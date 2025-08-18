using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cinema_2025
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["FullName"] != null)
                {
                    lblUserName.Text = "Welcome, " + Session["FullName"].ToString();
                }
                else
                {
                    // If not logged in, send back to Login page
                    Response.Redirect("Login.aspx");
                }
            }
        }
    }
}