using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cinema_2025
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GlobalSearchBtn_Click(object sender, EventArgs e)
        {
            // Save search text to session
            Session["SearchKeyword"] = GlobalSearchtxt.Text.Trim();

            // Redirect to Search page
            Response.Redirect("Search.aspx");
        }
    }
}