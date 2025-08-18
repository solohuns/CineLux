using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Cinema_2025
{
    public partial class Delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No initialization needed on first load
        }

        protected void DeleteBtn_Click(object sender, EventArgs e)
        {
            MessageLabel.Text = ""; // clear previous message

            if (int.TryParse(TextBox1.Text.Trim(), out int movieCode))
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string deleteQuery = "DELETE FROM Movies WHERE MovieCode = @MovieCode";
                    SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                    cmd.Parameters.AddWithValue("@MovieCode", movieCode);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rows > 0)
                    {
                        MessageLabel.ForeColor = System.Drawing.Color.Green;
                        MessageLabel.Text = "Movie successfully deleted.";
                        GridView1.DataBind();
                    }
                    else
                    {
                        MessageLabel.ForeColor = System.Drawing.Color.Red;
                        MessageLabel.Text = "Movie not found or already deleted.";
                    }
                }
            }
            else
            {
                MessageLabel.ForeColor = System.Drawing.Color.Red;
                MessageLabel.Text = "Please enter a valid numeric movie code.";
            }

            TextBox1.Text = "";  // clear textbox after attempt
        }
    }
}
