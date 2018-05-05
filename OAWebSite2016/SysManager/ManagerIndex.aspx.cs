using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Data;
using System.Data;

namespace OAWebSite2016.SysManager
{
    public partial class ManagerIndex : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.rep1.ItemDataBound += new RepeaterItemEventHandler(rep1_ItemDataBound);
            base.OnInit(e);
        }

        void rep1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lab1 = e.Item.FindControl("MenuID") as Label;
            Repeater rep2 = e.Item.FindControl("rep2") as Repeater;
            if (lab1.Text != null)
            {
                rep2.DataSource = (new MenuXMLBU()).GetChildMenuByMenuID(lab1.Text);
                rep2.DataBind();
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                MenuXMLBU bu1 = new MenuXMLBU();
                this.rep1.DataSource = bu1.GetChildModel();
                this.rep1.DataBind();
            }
        }
    }
}
