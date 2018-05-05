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
using WebFrame;
using WebFrame.Util;
using WebFrame.Data;
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class JLog_Data_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据的代码
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            string guidID = Request.QueryString["guidID"];
            string content = this.content.Text;

            if (!String.IsNullOrEmpty(content))
            {
                JLogBU bul = new JLogBU();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("guidID", guidID,SearchFieldType.NumericType));

                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic["uploadTime"] = DateTime.Now;
                dic["content"] = content;
                bul.EditData(condition, dic);

                String js1 = "layer.alert('操作成功!',function(index){;";
                js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                js1 = js1 + " parent.$('#butSearch').click();";
                js1 = js1 + " parent.layer.close(index);});";
                JAjax.ExecuteJS(js1);
            }
            else
            {
                JAjax.Alert("请输入内容");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.data1.GetListData();
                this.content.Text = this.data1.Eval("content");

                String parentid1 = this.data1.Eval("parentGuid");
                this.BindQX(parentid1);     
            }
        }

       

        /// <summary>
        /// 设置数据的权限
        /// </summary>
        private void BindQX(String LogID)
        {
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
                        this.sec1.Visible = true;
                    }
                    else
                    {
                        this.sec1.Visible = false;
                    }
                }
            }
        }
    }
}
