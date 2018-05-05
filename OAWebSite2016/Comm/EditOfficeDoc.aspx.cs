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
    public partial class EditOfficeDoc : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                String url1 = "http://" + FrameLib.ServerHost;
                if (FrameLib.ServerPort != "80")
                {
                    url1 = url1 + ":" + FrameLib.ServerPort;
                }
                String docFile =String.Empty;
                if (String.IsNullOrEmpty(Request.QueryString["doc"]) == false)
                {
                    docFile = Server.UrlDecode(Request.QueryString["doc"]);
                }
                else
                {
                    docFile = "/Comm/BlankDoc.doc";
                    //docFile = "/Comm/BlankExcel.xls";
                }

                this.wordUrl.Value = url1 + docFile;
                String ext = Path.GetExtension(docFile).Replace(".", "");
                this.wordExt.Value = ext;
                this.saveDoc.Value = url1 + "/Comm/saveWordDoc.aspx";
                this.filename.Value = Server.UrlEncode(docFile);

               
                //设置当前用户的姓名
                if (String.IsNullOrEmpty(FrameLib.UserName) == false)
                {
                    this.currentUserName.Value = FrameLib.UserName;
                }
                else
                {
                    this.currentUserName.Value = "未登录";
                }
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //设置显示和隐藏文档的修改痕迹
                if (this.wordExt.Value.ToLower() != "doc")
                {
                    this.but2.Visible = false;
                    this.but3.Visible = false;
                }
            }
            base.OnPreRenderComplete(e);
        }
    }
}
