using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using System.IO;
using KORWeb.BUL;
using System.Text;

namespace OAWebSite2016.SysManager.WebUI.ProjectManager
{
    public partial class TB_Task_Detail : System.Web.UI.Page
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
                int succ = 0;
                int succ1 = 0;
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

                        //如果以前有附件，则删除
                        String s1 = this.data1.Eval("RelaFile");
                        if (String.IsNullOrEmpty(s1) == false)
                        {
                            s1 = Server.MapPath(s1);
                            if (File.Exists(s1))
                            {
                                File.Delete(s1);
                            }
                        }
                    }

                    if (String.IsNullOrEmpty(dic1["ExecuteMan"].ToString()))
                    {
                        dic1["Status"] = "0";
                        succ1 = 1;
                    }
                    else
                    {
                        dic1["Status"] = "1";
                        //创建日志

                    }
                    //dic1["Manager"] = WebFrame.FrameLib.UserID;
                    //dic1["AddTime"] = DateTime.Now;
                    //dic1["AddUser"] = WebFrame.FrameLib.UserID;

                    succ = bean1.SaveDataToDb(dic1);

                    //如操作成功，则插入派工单的日志
                    if (succ == 1 && dic1["Status"].ToString()=="1")
                    {
                        succ1 = (new Tb_Task_LogBU()).NewLog(this.GuidID.Text, "将工单分配给" + dic1["ExecuteMan"].ToString(), "", "0", null);
                    }

                    WebFrame.Data.JConnect.GetConnect().CommitTrans();
                }
                catch (Exception err)
                {
                    WebFrame.Data.JConnect.GetConnect().RollBackTrans();
                    succ = 0;
                }

                //操作成功
                if (succ == 1 )   //submit succ
                {
                    String js1 = "layer.msg('操作成功!',{ icon: 1, time: 2000 },function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                    js1 = js1 + " parent.$('#butSearch').click();";
                    js1 = js1 + " parent.layer.close(index);";
                    //js1 = js1 + String.Format(" location.href='TB_Task_Detail_ADD.aspx?ProjectGuidID={0}';", this.ProjectGuidID.SelectedValue);
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

                ListItem item2 = new ListItem("--未指定--", "");
                this.TestMan.Items.Insert(0, item2);
                
                this.bean1.SetControlValues();       //填充数据

                if (this.begDate.Text != String.Empty)
                {
                    this.begDate.Text = DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
                }

                if (this.endDate.Text != String.Empty)
                {
                    this.endDate.Text = DateTime.Parse(this.endDate.Text).ToString("yyyy-MM-dd");
                }

                if (String.IsNullOrEmpty(this.data1.Eval("RelaTrueName")))
                {
                    this.spanFile.Visible = false;
                }
                else
                {
                    this.spanFile.Visible = true;
                }

                if (this.LastWorkload.Text == "0")
                {
                    this.LastWorkload.Text = "";
                }

                if (this.Status.Text == "0")
                {
                    this.sec0.Visible = true;
                    this.file1.Visible = true;
                }
                else
                {
                    this.sec0.Visible = false;
                    this.file1.Visible = false;
                    this.br1.Visible = false;
                }
            }
            base.OnPreRenderComplete(e);
        }
    }
}
