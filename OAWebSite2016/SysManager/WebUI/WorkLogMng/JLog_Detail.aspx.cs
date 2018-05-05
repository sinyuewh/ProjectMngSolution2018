using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using KORWeb.BUL;
using WebFrame.Data;
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class JLog_Detail : System.Web.UI.Page
    {
        /// <summary>
        /// 判断是否为日志的作者
        /// </summary>
        public bool IsAuthor
        {
            get
            {
                if (ViewState["IsAuthor"] == null)
                {
                    return false;
                }
                else
                {
                    return (bool)ViewState["IsAuthor"];
                }
            }
            private set
            {
                ViewState["IsAuthor"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            this.BindQX();
            base.OnPreRenderComplete(e);
        }


        /// <summary>
        /// 设置数据的权限
        /// </summary>
        private void BindQX()
        {
            if (ViewState["IsAuthor"] == null)
            {
                this.IsAuthor = false;
                String LogID = Request.QueryString["LogID"];
                if (!String.IsNullOrEmpty(LogID))
                {
                    Tb_WorkReminderBU bu1 = new Tb_WorkReminderBU();
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("LogID", LogID));
                    Dictionary<String, object> dic1 = bu1.GetFirstDictionary(condition, "AuthorID");
                    if (dic1 != null && dic1.Count > 0)
                    {
                        String Authorid1 = dic1["AuthorID"].ToString();
                        if (Authorid1 == WebFrame.FrameLib.UserID)
                        {
                            this.IsAuthor  = true;
                        }
                    }
                }
            }

            if (this.IsAuthor == false)
            {
                this.sec1.Visible = false;

                foreach (RepeaterItem item1 in this.Repeater1.Items)
                {
                    item1.FindControl("sec1").Visible = false;
                }
            }
        }
    }
}
