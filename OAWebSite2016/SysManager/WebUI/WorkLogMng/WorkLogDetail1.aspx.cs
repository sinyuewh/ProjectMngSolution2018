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
using WebFrame;
using System.Collections.Generic;
using KORWeb.BUL;
using WebFrame.Util;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkLogDetail1 : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据的处理
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            this.begDate.Text = this.selday1.SelectedValue;
            String authorid = this.AddUserID.Text;
            String addUserName = this.AddUserName.Text;
            String logcontent = this.LogContent.Text;
            String begdate = DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
            

            if (String.IsNullOrEmpty(logcontent) == false)
            {
                Tb_WorkLogBU bu1 = new Tb_WorkLogBU();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("AddUserID", authorid));
                String temp1 = String.Format("begDate>=cdate('{0}')", begdate);
                String temp2 = String.Format("begDate<=cdate('{0} 23:59:59')", begdate);

                condition.Add(new SearchField(temp1,"",SearchOperator.UserDefine));
                condition.Add(new SearchField(temp2, "", SearchOperator.UserDefine));

                if (bu1.HasData(condition) == false)
                {
                    //int succ = bean1.SaveDataToDb();
                    int succ = bu1.SaveWorkLog(JString.GetUnique32ID(), authorid, addUserName, logcontent, begdate);
                    if (succ == 1)   //submit succ
                    {
                        String js1 = "layer.alert('操作成功!',function(index){;";
                        js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                        js1 = js1 + " parent.$('#butSearch').click();";
                        js1 = js1 + " parent.layer.close(index);});";
                        JAjax.ExecuteJS(js1);
                    }
                    else
                    {
                        UTools.Alert("操作失败，请重试!");
                    }
                }
                else
                {
                    UTools.Alert("操作失败，失败原因，已存在相同日期的工作日志!");
                }
            }
            else
            {
                UTools.Alert("操作错误，请输入工作日志的内容!");
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               // this.LogReaderID.Attributes["ReadOnly"] = "true";

                //设置补登的日期
                DateTime t1 = DateTime.Today.AddDays(-1);
                for (var i = 0; i < 5; i++)
                {
                    ListItem item1 = new ListItem(t1.ToString("yyyy-MM-dd dddd"), t1.ToString("yyyy-MM-dd"));
                    this.selday1.Items.Add(item1);

                    t1 = t1.AddDays(-1);
                }
            }
        } 
    }
}
