using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;
using System.IO;
using System.Text;

namespace OAWebSite2016.SysManager.WebUI.ProjectManager
{
    public partial class TB_Task_Detail_ADD : System.Web.UI.Page
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
                
                int succ=0;
                int succ1=0;
                bool saveFile = false;
                String FileDir = "/Attachment/UseAttachment/";
                String truename1 = String.Empty;
                WebFrame.Data.JConnect.GetConnect().BeginTrans();
                try
                {
                    Dictionary<String, object> dic1 = bean1.GetControlValues();
                    dic1["Workload"] = double.Parse(this.Workload.Text);

                    dic1["content"] = (new StringBuilder()).Append(this.content.Text);
                    dic1["contentText"] = (new StringBuilder()).Append(WebFrame.Util.JString.NoHTML(this.content.Text));

                    if (this.file1.HasFile)
                    {
                        String ext1 = Path.GetExtension(this.file1.FileName);
                        truename1 = WebFrame.Util.JString.GetUnique32ID() + ext1;
                        this.file1.SaveAs(Server.MapPath(FileDir + truename1));
                        dic1["RelaFile"] = FileDir + truename1;
                        dic1["RelaTrueName"] = Path.GetFileName(this.file1.FileName);
                        saveFile = true;
                    }

                    if (String.IsNullOrEmpty(dic1["ExecuteMan"].ToString()))
                    {
                        dic1["Status"] = "0";
                    }
                    else
                    {
                        dic1["Status"] = "1";
                    }
                    dic1["Manager"] = WebFrame.FrameLib.UserID;
                    dic1["AddTime"] = DateTime.Now;
                    dic1["AddUser"] = WebFrame.FrameLib.UserID;

                    succ = bean1.SaveDataToDb(dic1);

                    //如操作成功，则插入派工单的日志
                    if (succ == 1)
                    {
                        succ1 = (new Tb_Task_LogBU()).NewLog(this.GuidID.Text,"创建派工单", "", "0", null);

                        if (dic1["Status"].ToString() == "1")
                        {
                            succ1 = (new Tb_Task_LogBU()).NewLog(this.GuidID.Text, "将工单分配给" + dic1["ExecuteMan"].ToString(), "", "0", null);
                        }
                    }

                    WebFrame.Data.JConnect.GetConnect().CommitTrans();
                }
                catch (Exception err)
                {
                    WebFrame.Data.JConnect.GetConnect().RollBackTrans();
                    succ = 0;
                    succ1 = 0;
                }

                //操作成功
                if (succ == 1 && succ1==1)   //submit succ
                {
                    String js1 = "layer.msg('操作成功!',{ icon: 1, time: 2000 },function(index){;";
                    //js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                    //js1 = js1 + " parent.$('#butSearch').click();";
                    //js1 = js1 + " parent.layer.close(index);";
                    js1 = js1 + String.Format(" location.href='TB_Task_Detail_ADD.aspx?ProjectGuidID={0}';", this.ProjectGuidID.SelectedValue);
                    js1 = js1 + " });";
                    JAjax.ExecuteJS(js1);
                }
                else
                {
                    if (saveFile && File.Exists(Server.MapPath(FileDir + truename1)))
                    {
                        File.Delete(Server.MapPath(FileDir + truename1));
                    }
                    UTools.Alert("操作失败，请重试!");
                }
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
            if (!Page.IsPostBack)
            {
                ListItem item1 = new ListItem("--未指定--", "");
                this.ExecuteMan.Items.Insert(0, item1);

                this.begDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                this.endDate.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");

                String p1 = Request.QueryString["ProjectGuidID"];
                if (String.IsNullOrEmpty(p1) == false)
                {
                    if (this.ProjectGuidID.Items.FindByValue(p1)!=null)
                    {
                        this.ProjectGuidID.SelectedValue = p1;
                        this.ProjectGuidID.Enabled = false;
                    }
                }
            }
            base.OnPreRenderComplete(e);
        }
    }
}
