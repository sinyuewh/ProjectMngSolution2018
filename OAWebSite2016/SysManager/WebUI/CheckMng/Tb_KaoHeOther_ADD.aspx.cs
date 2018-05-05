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
using WebFrame.Data;
using System.Collections.Generic;
using KORWeb.DAL;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tb_KaoHeOther_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //Submit data
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            String user1 = this.UserID.Text;
            String username1 = String.Empty;
            if (String.IsNullOrEmpty(user1) == false)
            {
                username1 = KORWeb.BUL.JUserBU.GetUserNamByIDS(user1);
            }

            if (String.IsNullOrEmpty(username1) == false)
            {
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                dic1["UserID"] = this.UserID.Text;
                dic1["KHID"] = this.KHID.Text;
                dic1["KhRemark"] = this.KhRemark.Text;
                dic1["KHCount"] = this.KHCount.Text;
                dic1["KhScore"] = this.KhScore.Text;
                dic1["createtime"] = this.createtime.Text;
                dic1["AddUser"] = WebFrame.FrameLib.UserID;
                dic1["remark"] = this.remark.Text;

                Tb_KaoHeOtherBU bu2 = new Tb_KaoHeOtherBU();
                bu2.NewData(dic1);

                String js1 = "layer.alert('操作成功!',function(index){;";
                js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                //js1 = js1 + " parent.$('#butSearch').click();";
                js1 = js1 + " parent.layer.close(index);});";
                JAjax.ExecuteJS(js1);
            }
            else
            {
                UTools.Alert("错误：请选择一个合适的用户名！");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String khid1 = Request.QueryString["KHID"];
                if (String.IsNullOrEmpty(khid1) == false)
                {
                    Tb_KaoHeZhiBiaoBU bu1 = new Tb_KaoHeZhiBiaoBU();
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("KHID", khid1));

                    Dictionary<String,object> dic1= bu1.GetFirstDictionary(condition, "KhRemark,KhScore");
                    this.KhRemark.Text = dic1["KhRemark"].ToString();
                    this.KhScore.Text = dic1["KhScore"].ToString();
                }
            }
        }
    }
}
