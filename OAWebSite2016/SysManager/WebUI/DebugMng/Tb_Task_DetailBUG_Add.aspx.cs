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
using WebFrame.Util;
using System.IO;
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng
{
    public partial class Tb_Task_DetailBUG_Add : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }
        //提交数据的代码
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            String error = String.Empty;

            Control con1 = bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                Dictionary<String, object> dic1 = bean1.GetControlValues();
                dic1["ManagerID"] = WebFrame.FrameLib.UserID;
                dic1["ManagerName"] = WebFrame.FrameLib.UserName;
                if (String.IsNullOrEmpty(dic1["PlanDate"].ToString()))
                {
                    dic1["PlanDate"] = DateTime.Parse(dic1["AddTime"].ToString()).AddDays(3).ToString("yyyy-MM-dd");
                }
                dic1["Status"] = "0";

                int succ = bean1.SaveDataToDb(dic1);

                //插入工单日志
                Tb_Task_LogBU bu2 = new Tb_Task_LogBU();
                bu2.NewLog(this.GuidID.Text, "创建工单","");

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
                    //throw bean1.MyException;
                    UTools.Alert("操作失败，请重试!");
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.AddTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }
    }
}
