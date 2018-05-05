using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace OAWebSite2016.Comm
{
    public partial class OpenAttachment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String filepath1 = Request.QueryString["filepath"];
                String fileName = Request.QueryString["fileName"];

                string phyfile = Server.MapPath(filepath1);
                FileStream fileStream = File.OpenRead(phyfile);
                long fileSize = fileStream.Length;
                Context.Response.ContentType = "application/octet-stream";

                if (String.IsNullOrEmpty(fileName))
                {
                    fileName = Path.GetFileName(filepath1);
                }

                Context.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8) + "\"");
                Context.Response.AddHeader("Content-Length", fileSize.ToString());
                byte[] fileBuffer = new byte[fileSize];
                fileStream.Read(fileBuffer, 0, (int)fileSize);
                fileStream.Close();
                Response.BinaryWrite(fileBuffer);
                Response.End();
            }
        }
    }
}
