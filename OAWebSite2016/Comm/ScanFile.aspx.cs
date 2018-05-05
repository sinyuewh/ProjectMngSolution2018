using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using KORWeb.BUL;

namespace OAWebSite.WebUI.Common
{
    public partial class ScanFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //计算文件的物理路径
                String filepath1 = Request.QueryString["filepath"];

                String strRootFolder = HttpContext.Current.Request.PhysicalApplicationPath;
                strRootFolder = strRootFolder.Substring(0, strRootFolder.LastIndexOf(@"\"));
                String root1 = strRootFolder;

                //计算文件的绝对地址
                String webpath1 = filepath1.Replace(root1, "").Replace("\\", "/");

                String ext = Path.GetExtension(filepath1).ToLower();

                //其他文件，直接输出附件的信息供用户保存
                string phyfile = Server.MapPath(filepath1);
                if (File.Exists(phyfile))
                {
                    FileStream fileStream = File.OpenRead(phyfile);
                    long fileSize = fileStream.Length;
                    Context.Response.ContentType = "application/octet-stream";

                    string fileName = Request.QueryString["filename"];
                    Context.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8) + "\"");
                    Context.Response.AddHeader("Content-Length", fileSize.ToString());
                    byte[] fileBuffer = new byte[fileSize];
                    fileStream.Read(fileBuffer, 0, (int)fileSize);
                    fileStream.Close();
                    Response.BinaryWrite(fileBuffer);
                }
                else
                {
                    Response.Write("错误：文件不存在或已删除！");
                }
                Response.End();

                /*
                if (ext == ".pdf")
                {
                    Response.Redirect("SeePDFFile.aspx?pdf=" + Server.UrlEncode(webpath1), false);
                }
                else if (ext == ".doc" || ext == ".docx" || ext == ".xls"
                    || ext == ".xlsx" || ext == ".ppt" || ext == ".pptx")
                {
                    Response.Redirect("SeeWordFile.aspx?doc=" + Server.UrlEncode(webpath1), false);
                }
                else if (ext == ".txt")
                {
                    //普通文档，使用文本编辑器打开
                    Response.Redirect("SeeTextFile.aspx?doc=" + Server.UrlEncode(webpath1), false);
                }
                else
                {
                   
                }*/


            }
        }
    }
}
