using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web.UI.WebControls;

namespace Cinema_2025
{
    public partial class Details : System.Web.UI.Page
    {
        public int CurrentMovieId
        {
            get { return ViewState["CurrentMovieId"] != null ? (int)ViewState["CurrentMovieId"] : 0; }
            set { ViewState["CurrentMovieId"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["id"], out int movieId))
                {
                    LoadMovieDetailsById(movieId);
                }

                // Populate booking times
                TimeDropdown.Items.Add(new ListItem("10:00 AM"));
                TimeDropdown.Items.Add(new ListItem("1:00 PM"));
                TimeDropdown.Items.Add(new ListItem("4:00 PM"));
                TimeDropdown.Items.Add(new ListItem("7:00 PM"));
                TimeDropdown.Items.Add(new ListItem("10:00 PM"));

                // Populate seats
                for (int i = 1; i <= 10; i++)
                {
                    SeatCheckboxList.Items.Add(new ListItem("A" + i));
                }
            }
        }

        private void LoadMovieDetailsById(int movieId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Movies WHERE MovieID = @MovieID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@MovieID", movieId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    CurrentMovieId = movieId;
                    LoadDataIntoControls(reader);
                }
                reader.Close();
            }
        }

        private void LoadDataIntoControls(SqlDataReader reader)
        {
            TitleLabel.Text = reader["Title"].ToString();
            GenreLabel.Text = reader["Genre"].ToString();
            ReleaseDateLabel.Text = Convert.ToDateTime(reader["ReleaseDate"]).ToString("yyyy-MM-dd");
            LanguageLabel.Text = reader["Language"].ToString();
            CountryLabel.Text = reader["Country"].ToString();
            RatingLabel.Text = reader["Rating"].ToString();
            DurationLabel.Text = reader["Duration"].ToString();
            FormatLabel.Text = reader["Format"].ToString();
            PriceLabel.Text = reader["Price"].ToString();
            DirectorLabel.Text = reader["DirectorName"].ToString();
            CastLabel.Text = reader["CastNames"].ToString();
            DescriptionLabel.Text = reader["Description"].ToString();

            if (!reader.IsDBNull(reader.GetOrdinal("PosterImageURL")))
                PosterImage.ImageUrl = reader["PosterImageURL"].ToString();

            // Trailer popup
            if (!reader.IsDBNull(reader.GetOrdinal("TrailerUrl")))
            {
                string trailerUrl = reader["TrailerUrl"].ToString();
                if (trailerUrl.EndsWith(".mp4", StringComparison.OrdinalIgnoreCase))
                {
                    TrailerLiteralModal.Text = $"<video width='100%' height='450' controls><source src='{ResolveUrl(trailerUrl)}' type='video/mp4'>Your browser does not support the video tag.</video>";
                }
                else
                {
                    if (trailerUrl.Contains("autoplay=1")) trailerUrl = trailerUrl.Replace("autoplay=1", "");
                    TrailerLiteralModal.Text = $"<iframe width='100%' height='450' src='{trailerUrl}' frameborder='0' allowfullscreen></iframe>";
                }
            }
            else
            {
                TrailerLiteralModal.Text = "";
            }
        }

        protected void BookNowButton_Click(object sender, EventArgs e)
        {
            string selectedTime = TimeDropdown.SelectedValue;
            var selectedSeats = SeatCheckboxList.Items.Cast<ListItem>()
                                .Where(i => i.Selected)
                                .Select(i => i.Value)
                                .ToList();

            if (string.IsNullOrEmpty(selectedTime) || !selectedSeats.Any())
            {
                BookingStatusLabel.ForeColor = System.Drawing.Color.Red;
                BookingStatusLabel.Text = "Please select a time and at least one seat.";
                return;
            }

            string seatParam = string.Join(",", selectedSeats);
            string url = $"Checkout.aspx?id={CurrentMovieId}&time={Server.UrlEncode(selectedTime)}&seats={Server.UrlEncode(seatParam)}";
            Response.Redirect(url);
        }
    }
}








