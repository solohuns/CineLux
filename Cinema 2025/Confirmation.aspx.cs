using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Cinema_2025
{
    public partial class Confirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!int.TryParse(Request.QueryString["id"], out int movieId))
                {
                    MovieLabel.Text = "Unknown movie";
                }
                else
                {
                    MovieLabel.Text = GetMovieTitleById(movieId);
                }

                TimeLabel.Text = Server.UrlDecode(Request.QueryString["time"] ?? "N/A");
                SeatsLabel.Text = Server.UrlDecode(Request.QueryString["seats"] ?? "N/A");
                NameLabel.Text = Server.UrlDecode(Request.QueryString["name"] ?? "Guest");
            }
        }

        private string GetMovieTitleById(int movieId)
        {
            string title = "";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (var con = new SqlConnection(connectionString))
            {
                string query = "SELECT Title FROM Movies WHERE MovieID = @MovieID";
                using (var cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MovieID", movieId);
                    con.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        title = result.ToString();
                    }
                }
            }
            return title;
        }
    }
}

