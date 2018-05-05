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

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tjfx2 : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.butSearch.ServerClick += new EventHandler(butSearch_ServerClick);
            base.OnInit(e);
        }

        void butSearch_ServerClick(object sender, EventArgs e)
        {
            Tb_ProjectBU bu1 = new Tb_ProjectBU();
            DataTable dt1 = bu1.GetTj2Data(this.parentGuid.SelectedValue, this.Time0.Text, this.Time1.Text);
            this.Repeater1.DataSource = dt1;
            this.Repeater1.DataBind();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Tb_ProjectBU.SetProjectDropDownList(this.parentGuid, "prjNum");
                this.parentGuid.Items.Insert(0, new ListItem("---不限---", ""));

                this.Time0.Text = DateTime.Now.ToString("yyyy-MM-01");
                this.Time1.Text = DateTime.Now.ToString("yyyy-MM-dd");

                Tb_ProjectBU bu1 = new Tb_ProjectBU();

            }
        }
    }
}
