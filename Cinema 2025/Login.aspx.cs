using System;
using System.Data.SqlClient;

namespace Cinema_2025
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string username = UsernameTextBox.Text.Trim();
            string password = PasswordTextBox.Text.Trim();

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT Username FROM EmployeeLogins WHERE Username = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // ✅ Store the username in Session
                    Session["FullName"] = reader["Username"].ToString();

                    // ✅ Redirect to Admin page
                    Response.Redirect("ViewAll.aspx");
                }
                else
                {
                    ErrorMessage.ForeColor = System.Drawing.Color.Red;
                    ErrorMessage.Text = "Invalid username or password.";
                }
            }
        }
    }
}

