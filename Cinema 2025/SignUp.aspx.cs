using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Cinema_2025
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            // Collect user input
            string name = NameTxt.Text.Trim();
            string surname = SurnameTxt.Text.Trim();
            string username = UsernameTxt.Text.Trim();
            string email = EmailTxt.Text.Trim();
            string password = PasswordTxt.Text.Trim();
            string confirmPassword = ConfirmPasswordTxt.Text.Trim();

            // Validation
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(surname) ||
                string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
            {
                ErrorLabel.Text = "⚠ All fields are required.";
                return;
            }

            if (password != confirmPassword)
            {
                ErrorLabel.Text = "⚠ Passwords do not match.";
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Check if username or email already exists
                    string checkQuery = "SELECT COUNT(*) FROM EmployeeLogins WHERE Username=@Username OR Email=@Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Username", username);
                        checkCmd.Parameters.AddWithValue("@Email", email);

                        int exists = (int)checkCmd.ExecuteScalar();
                        if (exists > 0)
                        {
                            ErrorLabel.Text = "⚠ Username or Email already exists.";
                            return;
                        }
                    }

                    // Insert new user with auto-generated UserCode
                    string insertQuery = @"
INSERT INTO EmployeeLogins
    (Username, Password, Email, Role, Name, Surname, UserCode)
OUTPUT INSERTED.UserID, INSERTED.UserCode
VALUES
    (@Username, @Password, @Email, @Role, @Name, @Surname,
     (SELECT ISNULL(MAX(UserCode), 999) + 1 FROM EmployeeLogins))";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password); // ⚠ TODO: hash later
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Role", "User");
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Surname", surname);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int newUserID = reader.GetInt32(0);
                                int newUserCode = reader.GetInt32(1);

                                ErrorLabel.ForeColor = System.Drawing.Color.LimeGreen;
                                ErrorLabel.Text = $"✅ Account created! UserID: {newUserID}, UserCode: {newUserCode}";
                            }
                        }
                    }

                    // Clear the input fields
                    NameTxt.Text = "";
                    SurnameTxt.Text = "";
                    UsernameTxt.Text = "";
                    EmailTxt.Text = "";
                    PasswordTxt.Text = "";
                    ConfirmPasswordTxt.Text = "";
                }
            }
            catch (Exception ex)
            {
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                ErrorLabel.Text = "❌ Error: " + ex.Message;
            }
        }

    }
}


