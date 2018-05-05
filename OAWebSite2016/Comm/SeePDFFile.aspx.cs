using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame;

namespace OAWebSite.WebUI.Common
{
    public partial class SeePDFFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String url1 = "http://" + FrameLib.ServerHost;
                if (FrameLib.ServerPort != "80")
                {
                    url1 = url1 + ":" + FrameLib.ServerPort;
                }

                this.pdffont.Value = "SC_TC_JP_KR.CAB";
                
                if (String.IsNullOrEmpty(Request.QueryString["pdf"]) == false)
                {
                    this.pdfdoc.Value =  url1+Server.UrlDecode(Request.QueryString["pdf"]);
                }
                else
                {
                    this.pdfdoc.Value = "";
                }
            }
        }
    }
}
