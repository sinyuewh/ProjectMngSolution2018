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
using WebFrame;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkReminderList2 : System.Web.UI.Page
    {
        protected override void OnLoad(EventArgs e)
        {
            this.datatype.SelectedIndexChanged += new EventHandler(datatype_SelectedIndexChanged);
            this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            base.OnLoad(e);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (this.datatype.SelectedValue == "0") //表示本人数据
            {
                e.Item.FindControl("sec3").Visible = true;
            }
            else                                   //表示他人数据
            {
                e.Item.FindControl("sec3").Visible = false;
            }
        }

        void datatype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.datatype.SelectedValue == "0")  //表示本人数据
            {
                this.AuthorID.Text = FrameLib.UserID;
                this.OtherMan.Text = "";
                this.sec1.Visible = true;
            }
            else                                                                             //表示他人数据
            {
                this.OtherMan.Text = FrameLib.UserID;
                if (WebFrame.Comm.JSecurity.HasSecurity("Tb_WorkReminder_READ") == false)
                {
                    JUserBU bu1 = new JUserBU();
                    this.AuthorID.Text = bu1.GetShouquanUserList(FrameLib.UserID, 1);             //表示他人的数据
                }
                else
                {
                    this.AuthorID.Text = "";
                }

                this.sec1.Visible = false;
            }

            this.Repeater1.DataBind();
        }



        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
