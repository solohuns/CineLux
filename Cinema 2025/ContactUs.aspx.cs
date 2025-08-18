using System;
using System.Net.Mail;
using System.Net;

namespace Cinema_2025
{
    public partial class ContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void SendButton_Click(object sender, EventArgs e)
        {
            try
            {
                string name = NameTextBox.Text.Trim();
                string email = EmailTextBox.Text.Trim();
                string message = MessageTextBox.Text.Trim();

                MailMessage mail = new MailMessage();
                mail.To.Add("mfengwanaliyema@gmail.com"); // ✅ Correct email address
                mail.From = new MailAddress("mfengwanaliyema@gmail.com");
                mail.Subject = $"Message from {name}";
                mail.Body = $"Name: {name}\nEmail: {email}\n\nMessage:\n{message}";
                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587); // ✅ Correct SMTP server
                smtp.Credentials = new NetworkCredential("mfengwanaliyema@gmail.com", "mkoj xqdc cmak loca"); // ⚠️ Use app password if 2FA is on
                smtp.EnableSsl = true;

                smtp.Send(mail);

                StatusLabel.ForeColor = System.Drawing.Color.Green;
                StatusLabel.Text = "Your message has been sent successfully!";
            }
            catch (Exception ex)
            {
                StatusLabel.ForeColor = System.Drawing.Color.Red;
                StatusLabel.Text = "An error occurred. Please try again.";

                // Optionally log the actual error for debugging:
                // StatusLabel.Text += " " + ex.Message;
            }
        }
    }
}

    
