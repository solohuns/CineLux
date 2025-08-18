using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace Cinema_2025
{
    public partial class Update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                StatusLabel.Text = "";
            }
        }

        // ✅ Load movie info by MovieCode
        protected void LoadMovieBtn_Click(object sender, EventArgs e)
        {
            string movieCode = MovieCodetxt.Text.Trim();

            if (string.IsNullOrEmpty(movieCode))
            {
                StatusLabel.ForeColor = System.Drawing.Color.Red;
                StatusLabel.Text = "Please enter a movie code.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Movies WHERE MovieCode = @MovieCode";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MovieCode", movieCode);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    MovieIDUpdatetxt.Text = reader["MovieID"].ToString();
                    TitleUpdatetxt.Text = reader["Title"].ToString();
                    DesricptionUpdatetxt.Text = reader["Description"].ToString();
                    GenreUpdatetxt.Text = reader["Genre"].ToString();
                    ReleaseDateUpdatetxt.Text = Convert.ToDateTime(reader["ReleaseDate"]).ToString("yyyy-MM-dd");
                    DurationUpdatetxt.Text = reader["Duration"].ToString();
                    LanguageUpdatetxt.Text = reader["Language"].ToString();
                    CountryUpdatetxt.Text = reader["Country"].ToString();
                    RatingUpdatetxt.Text = reader["Rating"].ToString();
                    PosterImageURLupdatetxt.Text = reader["PosterImageURL"].ToString();
                    TrailerURLupdatetxt.Text = reader["TrailerURL"].ToString();
                    CastNamesUpdatetxt.Text = reader["CastNames"].ToString();
                    DirectorNameUpdatetxt.Text = reader["DirectorName"].ToString();
                    FormatUpdatetxt.Text = reader["Format"].ToString();
                    PriceUpdatetxt.Text = reader["Price"].ToString();

                    StatusLabel.ForeColor = System.Drawing.Color.Green;
                    StatusLabel.Text = "Movie loaded successfully.";
                }
                else
                {
                    StatusLabel.ForeColor = System.Drawing.Color.Red;
                    StatusLabel.Text = "Movie not found.";
                }
                conn.Close();
            }
        }

        // ✅ Update only the fields that have been modified
        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                List<string> setClauses = new List<string>();
                SqlCommand cmd = new SqlCommand();

                string movieCode = MovieCodetxt.Text;
                if (string.IsNullOrWhiteSpace(movieCode))
                {
                    StatusLabel.Text = "Please enter a Movie Code to update.";
                    StatusLabel.ForeColor = System.Drawing.Color.Red;
                    return;
                }
                cmd.Parameters.AddWithValue("@MovieCode", movieCode);

                // Add non-empty fields
                if (!string.IsNullOrWhiteSpace(TitleUpdatetxt.Text)) { setClauses.Add("Title = @Title"); cmd.Parameters.AddWithValue("@Title", TitleUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(DesricptionUpdatetxt.Text)) { setClauses.Add("Description = @Description"); cmd.Parameters.AddWithValue("@Description", DesricptionUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(GenreUpdatetxt.Text)) { setClauses.Add("Genre = @Genre"); cmd.Parameters.AddWithValue("@Genre", GenreUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(ReleaseDateUpdatetxt.Text)) { setClauses.Add("ReleaseDate = @ReleaseDate"); cmd.Parameters.AddWithValue("@ReleaseDate", ReleaseDateUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(DurationUpdatetxt.Text)) { setClauses.Add("Duration = @Duration"); cmd.Parameters.AddWithValue("@Duration", DurationUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(LanguageUpdatetxt.Text)) { setClauses.Add("Language = @Language"); cmd.Parameters.AddWithValue("@Language", LanguageUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(CountryUpdatetxt.Text)) { setClauses.Add("Country = @Country"); cmd.Parameters.AddWithValue("@Country", CountryUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(RatingUpdatetxt.Text)) { setClauses.Add("Rating = @Rating"); cmd.Parameters.AddWithValue("@Rating", RatingUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(PosterImageURLupdatetxt.Text)) { setClauses.Add("PosterImageURL = @PosterImageURL"); cmd.Parameters.AddWithValue("@PosterImageURL", PosterImageURLupdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(TrailerURLupdatetxt.Text)) { setClauses.Add("TrailerURL = @TrailerURL"); cmd.Parameters.AddWithValue("@TrailerURL", TrailerURLupdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(CastNamesUpdatetxt.Text)) { setClauses.Add("CastNames = @CastNames"); cmd.Parameters.AddWithValue("@CastNames", CastNamesUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(DirectorNameUpdatetxt.Text)) { setClauses.Add("DirectorName = @DirectorName"); cmd.Parameters.AddWithValue("@DirectorName", DirectorNameUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(FormatUpdatetxt.Text)) { setClauses.Add("Format = @Format"); cmd.Parameters.AddWithValue("@Format", FormatUpdatetxt.Text); }
                if (!string.IsNullOrWhiteSpace(PriceUpdatetxt.Text)) { setClauses.Add("Price = @Price"); cmd.Parameters.AddWithValue("@Price", PriceUpdatetxt.Text); }

                if (setClauses.Count == 0)
                {
                    StatusLabel.Text = "No fields filled in to update.";
                    StatusLabel.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string setClause = string.Join(", ", setClauses);
                string query = $"UPDATE Movies SET {setClause} WHERE MovieCode = @MovieCode";

                cmd.CommandText = query;
                cmd.Connection = conn;

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ClearForm();
                        StatusLabel.Text = "Movie updated successfully!";
                        StatusLabel.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        StatusLabel.Text = "No movie found with that code.";
                        StatusLabel.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    StatusLabel.Text = "Error: " + ex.Message;
                    StatusLabel.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private void ClearForm()
        {
            MovieCodetxt.Text = "";
            TitleUpdatetxt.Text = "";
            DesricptionUpdatetxt.Text = "";
            GenreUpdatetxt.Text = "";
            ReleaseDateUpdatetxt.Text = "";
            DurationUpdatetxt.Text = "";
            LanguageUpdatetxt.Text = "";
            CountryUpdatetxt.Text = "";
            RatingUpdatetxt.Text = "";
            PosterImageURLupdatetxt.Text = "";
            TrailerURLupdatetxt.Text = "";
            CastNamesUpdatetxt.Text = "";
            DirectorNameUpdatetxt.Text = "";
            FormatUpdatetxt.Text = "";
            PriceUpdatetxt.Text = "";
        }
    }
}

