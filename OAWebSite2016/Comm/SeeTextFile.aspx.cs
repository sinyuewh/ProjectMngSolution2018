using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame;
using WebFrame.Comm;
using WebFrame.Util;
using System.Text;

namespace KORWeb.WebSite.Comm
{
    public partial class SeeTextFile : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.but.Click += new EventHandler(but_Click);
            base.OnInit(e);
        }

        void but_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["doc"]) == false)
            {
                String docFile = Server.MapPath(Request.QueryString["doc"]);
                PubFun.SaveTxtFileInfo(docFile, this.txt1.Text, Encoding.UTF8);
                JAjax.Alert("提示：保存操作成功！");
            }
        }

        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack
               && String.IsNullOrEmpty(Request.QueryString["doc"]) == false)
            {
                String docFile =Server.MapPath(Request.QueryString["doc"]);
                this.txt1.Text=PubFun.GetTxtFileInfo(docFile,Encoding.GetEncoding("gb2312"));
            }
        }
    }
}