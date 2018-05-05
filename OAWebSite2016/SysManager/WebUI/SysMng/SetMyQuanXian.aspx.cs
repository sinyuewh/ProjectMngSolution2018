using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using KORWeb.BUL;
using System.Collections.Generic;
using WebFrame.Data;
using WebFrame;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class SetMyQuanXian : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据处理
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            Dictionary<String, object> dic1 = new Dictionary<string, object>();
            dic1["qx1"] = this.qx1.Text;
            dic1["qx2"] = this.qx2.Text;
            dic1["qx3"] = this.qx3.Text;
            dic1["qx4"] = this.qx4.Text;

            JUserBU bu1 = new JUserBU();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("UserID", FrameLib.UserID));
            bu1.EditData(condition, dic1);

            UTools.Alert("提示：更新数据操作成功！");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                JUserBU bu1 = new JUserBU();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserID", FrameLib.UserID));
                DataRow dr1 = bu1.GetFirstDataRow(condition, "qx1,qx2,qx3,qx4");
                if (dr1 != null)
                {
                    this.qx1.Text = dr1[0].ToString();
                    this.qx2.Text = dr1[1].ToString();
                    this.qx3.Text = dr1[2].ToString();
                    this.qx4.Text = dr1[3].ToString();
                }
            }
        }
    }
}
