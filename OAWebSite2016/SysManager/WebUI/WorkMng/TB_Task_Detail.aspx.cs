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

namespace OAWebSite2016.SysManager.WebUI.WorkMng
{
    public partial class TB_Task_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
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
            }
            base.OnPreRenderComplete(e);
        }
    }
}
