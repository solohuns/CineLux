using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Cinema_2025
{
    public partial class Search : System.Web.UI.Page
    {
        // Use "using" for connection for better resource management (optional)
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGenres();

                // Retrieve search keyword from session or empty string if null
                string keyword = Session["SearchKeyword"] as string ?? "";

                // Perform initial search using the keyword from session
                PerformSearch(keyword);
            }
        }

        private void LoadGenres()
        {
            try
            {
                con.Open();

                string query = "SELECT DISTINCT Genre FROM Movies ORDER BY Genre";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GenreDropdown.Items.Clear();
                GenreDropdown.Items.Add(new ListItem("All Genres", "")); // Default option

                foreach (DataRow row in dt.Rows)
                {
                    string genre = row["Genre"].ToString();
                    GenreDropdown.Items.Add(new ListItem(genre, genre));
                }
            }
            catch (Exception ex)
            {
                ResultCountLabel.Text = "Error loading genres: " + ex.Message;
            }
            finally
            {
                con.Close();
            }
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            // When the genre dropdown changes, rerun search with stored keyword and selected genre
            string keyword = Session["SearchKeyword"] as string ?? "";
            PerformSearch(keyword);
        }

        private void PerformSearch(string keyword)
        {
            try
            {
                con.Open();

                string query = @"
                    SELECT [MovieID], [Title], [Description], [Genre], [PosterImageURL], 
                           [Rating], [Country], [Format], [Duration], [Language]
                    FROM [Movies]
                    WHERE (@keyword = '' 
                        OR Title LIKE '%' + @keyword + '%' 
                        OR Description LIKE '%' + @keyword + '%'
                        OR Genre LIKE '%' + @keyword + '%'
                        OR Language LIKE '%' + @keyword + '%'
                        OR Country LIKE '%' + @keyword + '%'
                        OR Format LIKE '%' + @keyword + '%'
                    )
                ";

                // Add genre filter if one is selected
                if (!string.IsNullOrEmpty(GenreDropdown.SelectedValue))
                {
                    query += " AND Genre = @genre";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@keyword", keyword);

                if (!string.IsNullOrEmpty(GenreDropdown.SelectedValue))
                {
                    cmd.Parameters.AddWithValue("@genre", GenreDropdown.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                DataList1.DataSource = dt;
                DataList1.DataBind();

                ResultCountLabel.Text = dt.Rows.Count > 0 ? $"{dt.Rows.Count} movie(s) found." : "";
                NoResultsLabel.Visible = dt.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                ResultCountLabel.Text = "Error: " + ex.Message;
            }
            finally
            {
                con.Close();
            }
        }
    }
}






