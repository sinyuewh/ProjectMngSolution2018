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
using System.Collections.Generic;
using System.IO;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectLogMng
{
    public partial class UploadProjuectDoc : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交附件处理
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(this.parentGuid.SelectedValue)==false)
            {
                if (this.file1.HasFile)
                {
                    bool succ = false;
                    try
                    {
                        Dictionary<String, object> dic1 = new Dictionary<string, object>();
                        dic1["guidID"] = this.guidID.Text;
                        dic1["parentGuid"] = this.parentGuid.SelectedValue;

                        dic1["FileName"] = Path.GetFileName(this.file1.FileName);
                        dic1["UploadTime"] = DateTime.Now;
                        dic1["UploadPerson"] = WebFrame.FrameLib.UserName;

                        dic1["Describle"] = this.Describle.Text;
                        dic1["Remark"] = this.Remark.Text;

                        dic1["del"] = 0;
                        dic1["FileDir"] = "/Attachment/UseAttachment/";
                        dic1["ProjectDoc"] = "1";
                        dic1["ProjectDocKind"] = this.ProjectDocKind.SelectedValue;


                        String ext1 = Path.GetExtension(this.file1.FileName);
                        String truename1 = WebFrame.Util.JString.GetUnique32ID() + ext1;
                        this.file1.SaveAs(Server.MapPath(dic1["FileDir"].ToString() + truename1));

                        dic1["EncryptFileName"] = dic1["FileDir"] + truename1;
                        int s1=this.bean1.SaveDataToDb(dic1);
                        if (s1 == 1)
                        {
                            succ = true;
                        }
                        else
                        {
                            throw this.bean1.MyException;
                        }
                    }
                    catch (Exception err)
                    {
                        WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                    }


                    if (succ)   //submit succ
                    {
                        String js1 = "layer.alert('操作成功!',function(index){;";
                        js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";

                        js1 = js1 + " parent.$('#ctl00_ContentPlaceHolder1_butSearchProject').click();";
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
            else
            {
                UTools.Alert("提示：请选择一个合适的项目！");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Tb_ProjectBU.SetProjectDropDownList(this.parentGuid);
                this.guidID.Text = WebFrame.Util.JString.GetUnique32ID();
            }
        }
    }
}
