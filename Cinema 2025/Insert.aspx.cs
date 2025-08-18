using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace Cinema_2025
{
    public partial class Insert : System.Web.UI.Page
    {
        private const int MaxFileSize = 500 * 1024 * 1024; // 500 MB

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNextMovieCode();
            }
        }

        // Load next MovieCode to display (MovieID is auto-generated)
        private void LoadNextMovieCode()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT ISNULL(MAX(MovieCode), 999) + 1 AS NextCode FROM Movies", conn);
                object result = cmd.ExecuteScalar();
                NextMovieCodeTextBox.Text = result.ToString();
            }
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string posterImageUrl = "";
            string trailerUrl = "";

            // Poster Upload
            if (PosterUpload.HasFile)
            {
                if (PosterUpload.PostedFile.ContentLength > MaxFileSize)
                {
                    MessageLabel.Text = "Poster file too large. Maximum size: 500 MB.";
                    MessageLabel.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string ext = Path.GetExtension(PosterUpload.FileName).ToLower();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png")
                {
                    MessageLabel.Text = "Invalid poster format. Only JPG/PNG allowed.";
                    MessageLabel.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string folderPath = Server.MapPath("~/Images/ImagesCineLux/");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                string fileName = Guid.NewGuid() + ext;
                PosterUpload.SaveAs(Path.Combine(folderPath, fileName));
                posterImageUrl = "/Images/ImagesCineLux/" + fileName;
            }

            // Trailer Upload
            if (TrailerUpload.HasFile)
            {
                if (TrailerUpload.PostedFile.ContentLength > MaxFileSize)
                {
                    MessageLabel.Text = "Trailer file too large. Maximum size: 500 MB.";
                    MessageLabel.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string ext = Path.GetExtension(TrailerUpload.FileName).ToLower();
                if (ext != ".mp4")
                {
                    MessageLabel.Text = "Invalid trailer format. Only MP4 allowed.";
                    MessageLabel.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string folderPath = Server.MapPath("~/Videos/TrailersCineLux/");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                string fileName = Guid.NewGuid() + ext;
                TrailerUpload.SaveAs(Path.Combine(folderPath, fileName));
                trailerUrl = "/Videos/TrailersCineLux/" + fileName;
            }

            // Insert into database and get auto-generated MovieID
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Movies 
                                (Title, Description, Genre, ReleaseDate, Duration, Language, Country, Rating, 
                                 PosterImageURL, TrailerURL, CastNames, DirectorName, Format, Price, MovieCode)
                                OUTPUT INSERTED.MovieID
                                VALUES 
                                (@Title, @Description, @Genre, @ReleaseDate, @Duration, @Language, @Country, @Rating, 
                                 @PosterImageURL, @TrailerURL, @CastNames, @DirectorName, @Format, @Price, @MovieCode)";

                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@Title", TitleTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", DescriptionTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Genre", GenreTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@ReleaseDate", string.IsNullOrEmpty(ReleaseDateTextBox.Text) ? DBNull.Value : (object)ReleaseDateTextBox.Text);
                cmd.Parameters.AddWithValue("@Duration", string.IsNullOrEmpty(DurationTextBox.Text) ? DBNull.Value : (object)DurationTextBox.Text);
                cmd.Parameters.AddWithValue("@Language", LanguageTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", CountryTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Rating", RatingTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@PosterImageURL", posterImageUrl);
                cmd.Parameters.AddWithValue("@TrailerURL", trailerUrl);
                cmd.Parameters.AddWithValue("@CastNames", CastNamesTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@DirectorName", DirectorNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Format", FormatTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", string.IsNullOrEmpty(PriceTextBox.Text) ? DBNull.Value : (object)PriceTextBox.Text);
                cmd.Parameters.AddWithValue("@MovieCode", NextMovieCodeTextBox.Text);

                conn.Open();
                int newMovieID = (int)cmd.ExecuteScalar(); // get auto-generated MovieID

                // Display new MovieID and MovieCode
                NextMovieIDTextBox.Text = newMovieID.ToString();
                LoadNextMovieCode(); // prepare next MovieCode for next insert
            }

            MessageLabel.ForeColor = System.Drawing.Color.Green;
            MessageLabel.Text = "Movie inserted successfully!";

            ClearForm();
        }

        private void ClearForm()
        {
            TitleTextBox.Text = "";
            DescriptionTextBox.Text = "";
            GenreTextBox.Text = "";
            ReleaseDateTextBox.Text = "";
            DurationTextBox.Text = "";
            LanguageTextBox.Text = "";
            CountryTextBox.Text = "";
            RatingTextBox.Text = "";
            DirectorNameTextBox.Text = "";
            CastNamesTextBox.Text = "";
            FormatTextBox.Text = "";
            PriceTextBox.Text = "";
            PosterUpload.Dispose();
            TrailerUpload.Dispose();
        }
    }
}



