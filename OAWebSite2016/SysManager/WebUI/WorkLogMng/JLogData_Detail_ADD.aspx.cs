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
using WebFrame.Util;
using System.Collections.Generic;
using System.IO;
using KORWeb.BUL;
using WebFrame;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class JLogData_Detail_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            string ParentGuid = Request.QueryString["ParentGuid"];
            string content = this.content.Text;
            //获取当前登录用户
            string uploadPerson = WebFrame.FrameLib.UserID;

            if (!String.IsNullOrEmpty(content))
            {
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic["parentGuid"] = ParentGuid;
                dic["uploadPerson"] = uploadPerson;
                dic["content"] = content;

                JLogBU bul = new JLogBU();
                bul.NewData(dic);

                String js1 = "layer.alert('操作成功!',function(index){;";
                js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                js1 = js1 + " parent.$('#butSearch').click();";
                js1 = js1 + " parent.layer.close(index);});";
                JAjax.ExecuteJS(js1);

                Tb_WorkReminderBU bu2 = new Tb_WorkReminderBU();
                List<SearchField> condition = new List<SearchField>();

                //获取备忘录原始数据
                condition.Add(new SearchField("LogID", ParentGuid, SearchFieldType.StringType));
                Dictionary<string, object> dic1 = bu2.GetFirstDictionary(condition, "LogContent");

                string oldLogContent = "";
                if (dic1 != null && dic1.Count > 0)
                {
                    oldLogContent = dic1["LogContent"].ToString();
                }
                Dictionary<string, object> dic2 = new Dictionary<string, object>();
                ;
                dic2["LogContent"] = oldLogContent + "\n\n" + DateTime.Now.ToString("yyyy年MM月dd日") + "\n" + content;
                bu2.EditData(condition, dic2);

            }
            else
            {
                String js1 = "layer.alert('请输入完整信息!')";
                JAjax.ExecuteJS(js1);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.uploadPerson.Text = WebFrame.FrameLib.UserName;
            }
        }
    }
}
