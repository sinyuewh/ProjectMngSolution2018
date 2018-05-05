using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectLogMng
{
    public partial class ProjectDocumentIndex : System.Web.UI.Page
    {
        Tb_ProjectBU bu1 = new Tb_ProjectBU();

        protected override void OnInit(EventArgs e)
        {
            this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            base.OnInit(e);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataRowView dv1 = e.Item.DataItem as DataRowView;
            if (dv1 != null)
            {
                DataRow dr1 = dv1.Row;
                bool succ=bu1.IsCanEditProject(dr1["parentGuid"].ToString(), WebFrame.FrameLib.UserID);
                e.Item.FindControl("span1").Visible = succ;
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
