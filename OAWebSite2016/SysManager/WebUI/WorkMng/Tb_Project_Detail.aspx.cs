using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.WorkMng1
{
    public partial class Tb_Project_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            //this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            this.butRefresh1.Click += new EventHandler(butRefresh1_Click);
                       
            //this.Repeater2.ItemCommand += new RepeaterCommandEventHandler(Repeater2_ItemCommand);
            base.OnInit(e);
        }

             
        //附件列表刷新
        void butRefresh1_Click(object sender, EventArgs e)
        {
            //this.data3.DataBind();
            this.Repeater2.DataBind();
            String js1 = "AttachmentRefresh();";
            JAjax.ExecuteJS(js1);
        }

       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.bean1.SetControlValues();       //填充数据

                if (this.begDate.Text != String.Empty)
                {
                    this.begDate.Text = DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
                }

                if (this.endDate.Text != String.Empty)
                {
                    this.endDate.Text = DateTime.Parse(this.endDate.Text).ToString("yyyy-MM-dd");
                }

                this.Repeater1.DataBind();
                this.Repeater2.DataBind();
                this.Repeater3.DataBind();


                //状态为0，才可以需改数据
                if (this.Status.Text == "0")
                {
                    this.IsCanEdit.Text = "1";
                }
                else
                {
                    this.IsCanEdit.Text = "0";
                }
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            
            base.OnPreRenderComplete(e);
        }
    }
}
