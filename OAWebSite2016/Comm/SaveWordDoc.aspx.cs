using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace KORWeb.WebSite.Comm
{
    public partial class SaveWordDoc1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            // 在此处放置用户代码以初始化页面
            if (!Page.IsPostBack)
            {
                if (Request.Files.Count > 0)
                {
                    HttpPostedFile file1 = Request.Files[0];
                    String fileName = Server.MapPath(Server.UrlDecode( Request["fileName"]));
                    file1.SaveAs(fileName);	
                    Response.Write("保存文件成功！");
                }
                else
                {
                    Response.Write("保存文件失败！");
                }
                Response.End();
            }
        }
    }
}