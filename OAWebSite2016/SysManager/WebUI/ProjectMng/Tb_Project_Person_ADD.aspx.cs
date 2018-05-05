using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Person_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            this.SaveData();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.parentGuid.Text = Request.QueryString["parentGuid"];
                this.guidID.Text = WebFrame.Util.JString.GetUnique32ID();

                this.PersonID.Items.Insert(0, new ListItem("--请选择--", ""));

                if (String.IsNullOrEmpty(this.num.Text))
                {
                    Tb_Project_PersonBU bu1 = new Tb_Project_PersonBU();
                    this.num.Text = bu1.GetPersonNum(this.parentGuid.Text)+"";
                }

                int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(Request.QueryString["parentGuid"], WebFrame.FrameLib.UserID);

                if (t1 >= 3)
                {
                    this.sec0.Visible = true;
                }
                else
                {
                    this.sec0.Visible = false;
                }
            }
            base.OnPreRenderComplete(e);
        }

        private void SaveData()
        {
            String error = String.Empty;
            bool succ = false;
            Control con1 = this.bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                try
                {
                    Dictionary<String, object> dic1 = new Dictionary<string, object>();
                    dic1["num"] = this.num.Text;
                    dic1["GuidID"] = this.guidID.Text;
                    dic1["parentGuid"] = this.parentGuid.Text;
                    dic1["PrjRole"] = this.PrjRole.SelectedValue;

                    dic1["UserID"] = this.PersonID.SelectedValue;
                    dic1["UserName"] = this.PersonID.SelectedItem.Text;

                    dic1["Weight"] = this.Weight.SelectedValue;

                    this.bean1.SaveDataToDb(dic1);
                    if (this.bean1.MyException != null)
                    {
                        throw this.bean1.MyException;
                    }
                    succ = true;
                }
                catch (Exception err)
                {
                    WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                    succ = false;
                }

                if (succ)   //submit succ
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                    js1 = js1 + " parent.$('#butSearch').click();";
                    //js1 = js1 + " parent.$('#ctl00$ContentPlaceHolder1$butPerson').click();";
                    js1 = js1 + " parent.layer.close(index);});";
                    JAjax.ExecuteJS(js1);
                }
                else
                {
                    UTools.Alert("操作失败，请重试!");
                }
            }
        }
    }
}
