using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Attachment_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交附件处理
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            if (this.selecProject.SelectedValue != string.Empty)
            {
                this.parentGuid.Text = this.selecProject.SelectedValue;            
            }

            //提交数据
            if (String.IsNullOrEmpty(this.parentGuid.Text) == false)
            {
                this.SaveData();
            }
            else
            {
                UTools.Alert("错误：请选择一个合适的项目！");
            }    
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (String.IsNullOrEmpty(Request.QueryString["parentGuid"]) == false)
                {
                    this.sel1.Visible = false;
                }
                else
                {
                    Tb_ProjectBU bu1 = new Tb_ProjectBU();
                    Dictionary<String, String> dic1 = bu1.GetUserManagerProject(WebFrame.FrameLib.UserID);
                    foreach (KeyValuePair<String, String> item in dic1)
                    {
                        this.selecProject.Items.Add(new ListItem(item.Value, item.Key));
                    }
                    this.sel1.Visible = true;
                }
            }
        }

        private void SaveData()
        {
            if (this.file1.HasFile)
            {
                bool succ = false;
                try
                {
                    Dictionary<String, object> dic1 = new Dictionary<string, object>();
                    dic1["guidID"] = this.guidID.Text;
                    dic1["parentGuid"] = this.parentGuid.Text;
                    dic1["FileName"] = Path.GetFileName(this.file1.FileName);
                    dic1["UploadTime"] = DateTime.Now;
                    dic1["UploadPerson"] = WebFrame.FrameLib.UserName;
                    dic1["Kind"] = this.Kind.Text;
                    dic1["Describle"] = this.Describle.Text;
                    dic1["del"] = 0;
                    dic1["FileDir"] = "/Attachment/UseAttachment/";

                    String ext1 = Path.GetExtension(this.file1.FileName);
                    String truename1 = WebFrame.Util.JString.GetUnique32ID() + ext1;
                    this.file1.SaveAs(Server.MapPath(dic1["FileDir"].ToString() + truename1));

                    dic1["EncryptFileName"] = dic1["FileDir"] + truename1;
                    this.bean1.SaveDataToDb(dic1);
                    succ = true;
                }
                catch (Exception err)
                {
                    WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                }


                if (succ)   //submit succ
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
                UTools.Alert("提示：请选择一个要上传的附件！");
            }
        }
    }
}
