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
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.ProjectLogMng
{
    public partial class Tb_Project_Money_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

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
                this.UserName.Text = this.UserID.SelectedItem.Text;


                Dictionary<String, object> dic1 = bean1.GetControlValues();
                //KORWeb.DAL.Tb_KH_ProjectDA da1 = new KORWeb.DAL.Tb_KH_ProjectDA();
                //da1.TableName = "Tb_Project_Money";
                //dic1.Remove("DataID");
                //da1.NewData(dic1);

                int succ = bean1.SaveDataToDb(dic1);
                //int succ = 1;
                if (succ == 1)   //submit succ
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";

                    js1 = js1 + " parent.$('#ctl00_ContentPlaceHolder1_butSearchProject').click();";
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
                this.MoneyTime.Text = DateTime.Now.ToString("yyyy-MM-dd");

                //设置项目的经手人
                Tb_ProjectBU bu1 = new Tb_ProjectBU();
                bu1.SetProjectManDropDownList(this.UserID, Request.QueryString["prjNum"], "");
                this.parentGuid.Text=Request.QueryString["prjNum"];
            }
        }
    }
}
