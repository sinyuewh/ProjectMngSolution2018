using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using WebFrame;

namespace OAWebSite.WebUI.Common
{
    public partial class SeeWordFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack 
                && String.IsNullOrEmpty(Request.QueryString["doc"])==false)
            {

                String url1 = "http://" + FrameLib.ServerHost;
                if (FrameLib.ServerPort != "80")
                {
                    url1 = url1 + ":" + FrameLib.ServerPort;
                }

                String docFile = Server.UrlDecode(Request.QueryString["doc"]);
                this.wordUrl.Value = url1 +docFile;
                String ext = Path.GetExtension(docFile).Replace(".", "");
                this.wordExt.Value = ext;
                this.saveDoc.Value = url1 + "/Comm/saveWordDoc.aspx";
                this.filename.Value =Server.UrlEncode(docFile);
            }
        }
    }
}
