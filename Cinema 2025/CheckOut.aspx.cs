using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Cinema_2025
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!int.TryParse(Request.QueryString["id"], out int movieId) ||
                    string.IsNullOrEmpty(Request.QueryString["time"]) ||
                    string.IsNullOrEmpty(Request.QueryString["seats"]))
                {
                    ErrorLabel.Text = "Invalid booking details.";
                    ConfirmBookingButton.Enabled = false;
                    return;
                }

                TimeLabel.Text = Server.HtmlEncode(Request.QueryString["time"]);
                SeatsLabel.Text = Server.HtmlEncode(Request.QueryString["seats"]);

                string movieTitle = GetMovieTitleById(movieId);
                if (string.IsNullOrEmpty(movieTitle))
                {
                    ErrorLabel.Text = "Movie not found.";
                    ConfirmBookingButton.Enabled = false;
                    return;
                }

                MovieTitleLabel.Text = Server.HtmlEncode(movieTitle);
                ViewState["MovieID"] = movieId; // store movieId for confirmation step
            }
        }

        // Retrieve movie title from database
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
                        title = result.ToString();
                }
            }
            return title;
        }

        // Button click to confirm booking
        protected void ConfirmBookingButton_Click(object sender, EventArgs e)
        {
            // Validate user input
            if (string.IsNullOrWhiteSpace(NameTextBox.Text) ||
                string.IsNullOrWhiteSpace(EmailTextBox.Text) ||
                string.IsNullOrWhiteSpace(PhoneTextBox.Text))
            {
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                ErrorLabel.Text = "Please fill in all your details.";
                return;
            }

            string name = Server.HtmlEncode(NameTextBox.Text.Trim());
            string email = Server.HtmlEncode(EmailTextBox.Text.Trim());
            string phone = Server.HtmlEncode(PhoneTextBox.Text.Trim());
            string movie = MovieTitleLabel.Text;
            string time = TimeLabel.Text;
            string seats = SeatsLabel.Text;
            int movieId = ViewState["MovieID"] != null ? (int)ViewState["MovieID"] : 0;

            // Send ticket email
            bool emailSent = SendTicketEmail(email, movie, time, seats, name);

            // Redirect only if email sent successfully
            if (emailSent)
            {
                string redirectUrl = $"Confirmation.aspx?id={movieId}&time={Server.UrlEncode(time)}&seats={Server.UrlEncode(seats)}&name={Server.UrlEncode(name)}";
                Response.Redirect(redirectUrl);
            }
        }

        // Method to send ticket email
        private bool SendTicketEmail(string toEmail, string movie, string time, string seats, string name)
        {
            try
            {
                string fromEmail = "mfengwanaliyema@gmail.com";      // Your Gmail
                string fromPassword = "psps xxae llrn qkvf";      // Use Gmail App Password
                string subject = "Your CineLux Ticket Confirmation";

                string body = $@"
                    <div style='font-family: Arial, sans-serif; color: #333;'>
                        <h2 style='color: red;'>Booking Confirmed!</h2>
                        <p><strong>Movie:</strong> {movie}</p>
                        <p><strong>Time:</strong> {time}</p>
                        <p><strong>Seats:</strong> {seats}</p>
                        <p><strong>Name:</strong> {name}</p>
                        <p style='margin-top:20px;'>Thank you for booking with <strong>CineLux Cinema</strong>!</p>
                    </div>
                ";

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(fromEmail, "mfengwanaliyema@gmail.com");
                    mail.To.Add(toEmail);
                    mail.Subject = subject;
                    mail.Body = body;
                    mail.IsBodyHtml = true;

                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.Credentials = new NetworkCredential(fromEmail, fromPassword);
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }

                ErrorLabel.ForeColor = System.Drawing.Color.Green;
                ErrorLabel.Text = "Booking confirmed! Ticket email sent successfully.";
                return true;
            }
            catch (Exception ex)
            {
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                ErrorLabel.Text = "Booking confirmed, but email sending failed: " + ex.Message;
                return false;
            }
        }
    }
}




