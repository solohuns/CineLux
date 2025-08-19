using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cinema_2025
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var banners = new List<object> {
           new Banner { ImageUrl = "Images\\CineLuxBanners\\INCEPTION Banner.jpg" },
new Banner { ImageUrl = "Images\\CineLuxBanners\\CREED III.jpg" },
new Banner { ImageUrl = "Images\\CineLuxBanners\\NAPOLEON.jpg" },
new Banner { ImageUrl = "Images\\CineLuxBanners\\THE DARK KNIGHT BANNER.jpg" },
new Banner { ImageUrl = "Images\\CineLuxBanners\\THE FLASH BANNER.jpg" },
        };

                BannerRepeater.DataSource = banners;
                BannerRepeater.DataBind();
            }
        }


        public class Banner
        {
            public string ImageUrl { get; set; }
        }
    }
}