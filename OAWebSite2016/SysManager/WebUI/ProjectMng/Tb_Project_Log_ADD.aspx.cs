using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;
using WebFrame;
using System.IO;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Log_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            if (this.selecProject.SelectedValue != string.Empty)
            {
                this.parentGuid.Text = this.selecProject.SelectedValue;
            }
            else
            {
                UTools.Alert("错误：请选择一个合适的项目！");
            }
            this.SaveData();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Tb_ProjectBU bu1 = new Tb_ProjectBU();
                Dictionary<String, String> dic1 = bu1.GetUserManagerProject(WebFrame.FrameLib.UserID);
                foreach (KeyValuePair<String, String> item in dic1)
                {
                    this.selecProject.Items.Add(new ListItem(item.Value, item.Key));
                }
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
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
                    dic1["GuidID"] = this.guidID.Text;
                    dic1["parentGuid"] = this.parentGuid.Text;

                    dic1["AddUserID"] = FrameLib.UserID;
                    dic1["AddUserName"] = FrameLib.UserName;
                    dic1["Stitle"] = this.Stitle.Text;
                    dic1["Content"] = this.Content.Text;
                    dic1["AddTime"] = DateTime.Now;

                    //将附件上传
                    if (this.file1.HasFile)
                    {
                        String fname= UTools.SaveFileToServer(this.file1);
                        dic1["AttachFile"] = this.file1.FileName;
                        dic1["AttachFilePath"] = fname;
                    }

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
