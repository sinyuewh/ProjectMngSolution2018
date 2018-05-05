using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkLogDetail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据的处理
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            String logid = this.LogID.Text;
            String authorid = this.AddUserID.Text;
            String addUserName = this.AddUserName.Text;
            String logcontent = this.LogContent.Text;
            String begdate= DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
           
            if (String.IsNullOrEmpty(logcontent) == false)
            {
                Tb_WorkLogBU bu1 = new Tb_WorkLogBU();
                //int succ = bean1.SaveDataToDb();
                int succ = bu1.SaveWorkLog(logid,authorid,addUserName, logcontent, begdate);
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
                UTools.Alert("操作错误，请输入工作日志的内容!");
            }
        }


        /// <summary>
        /// 判断日志能否修改
        /// </summary>
        public bool IsCanEdit
        {
            get
            {
                if (ViewState["IsCanEdit"] == null)
                {
                    return false;
                }
                else
                {
                    return (bool)ViewState["IsCanEdit"];
                }
            }
            set
            {
                ViewState["IsCanEdit"]=value;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Tb_WorkLogBU bu1 = new Tb_WorkLogBU();
                Dictionary<String, object> dic1 = null;
                
                if (String.IsNullOrEmpty(Request.QueryString["LogID"]) == false)
                {
                    dic1 = bu1.GetWorkLogByLogID(Request.QueryString["LogID"]);
                }
                else
                {
                    //表示新增日志，需判断今天是否有日志，
                    //如果存在，则转原来的日志进行编辑
                    dic1 = bu1.GetTodayWorkLog(FrameLib.UserID);
                }

                //假如dic1有数据
                if (dic1 != null && dic1.Count > 0)
                {
                    this.LogID.Text = dic1["LogID"].ToString();
                    this.AddUserID.Text = dic1["AddUserID"].ToString();
                    this.begDate.Text = DateTime.Parse(dic1["begDate"].ToString()).ToString("yyyy-MM-dd dddd");
                    this.AddUserName.Text = dic1["AddUserName"].ToString();
                    this.LogContent.Text = dic1["LogContent"].ToString();
                }
                else
                {
                    this.LogID.Text = WebFrame.Util.JString.GetUnique32ID();
                    this.AddUserID.Text = FrameLib.UserID;
                    this.begDate.Text = DateTime.Now.ToString("yyyy-MM-dd dddd");
                    this.AddUserName.Text = FrameLib.UserName;
                }
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (this.AddUserID.Text == FrameLib.UserID
                    && DateTime.Now.ToString("yyyy-MM-dd dddd") == this.begDate.Text)
                {
                    this.IsCanEdit = true;
                }
                else
                {
                    this.IsCanEdit = false;
                }

                this.sec0.Visible = this.IsCanEdit;
            }
            base.OnPreRenderComplete(e);
        }
    }
}
