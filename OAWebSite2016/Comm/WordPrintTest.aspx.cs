using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame;
using System.IO;

namespace OAWebSite.Comm
{
    public partial class WordPrintTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //将Word文件的相对路径变成url绝对路径
                String url1 = "http://" + FrameLib.ServerHost;
                if (FrameLib.ServerPort != "80")
                {
                    url1 = url1 + ":" + FrameLib.ServerPort;
                }

                url1 = url1 + this.wordFile.Value;
                this.wordUrl.Value = url1;
                String ext = Path.GetExtension(Server.MapPath(this.wordFile.Value)).Replace(".", "");
                this.wordExt.Value = ext;
            }
        }
    }
}
