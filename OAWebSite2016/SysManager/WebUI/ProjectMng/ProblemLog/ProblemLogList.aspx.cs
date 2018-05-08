using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng.ProblemLog
{
    public partial class ProblemLogList : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            base.OnInit(e);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            System.Data.DataRowView dv = e.Item.DataItem as System.Data.DataRowView;
            System.Data.DataRow dr = dv.Row;

            String UserID = WebFrame.FrameLib.UserID;
            String projectID = dr["parentGuid"].ToString();
            String FinishTime = dr["FinishTime"].ToString();

            //判断对项目是否有管理权限
            bool has = false;
            int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(projectID, UserID);
            if (t1 >= 3) has = true;

            //设置项目的操作
            Control con2 = e.Item.FindControl("span1") as Control;
            if (has)
            {
                System.Collections.Generic.Dictionary<String, String> dic1 = new System.Collections.Generic.Dictionary<string, string>();
                DropDownList con1 = e.Item.FindControl("doAction") as DropDownList;
                if (String.IsNullOrEmpty(FinishTime))
                {
                    dic1["1"] = "标记完成";
                }
                else 
                {
                    dic1["2"] = "取消完成";
                }
                

                if (dic1.Count > 0)
                {
                    foreach (System.Collections.Generic.KeyValuePair<String, String> m in dic1)
                    {
                        ListItem item1 = new ListItem(m.Value, m.Key);
                        con1.Items.Add(item1);
                    }
                    con1.Items.Insert(0, new ListItem("选择操作", ""));
                }
                else
                {
                    con2.Visible = false;
                }
            }
            else
            {
                con2.Visible = false;
            }

           
        
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.Time0.Text = DateTime.Today.AddDays(-30).ToString("yyyy-MM-dd");
                this.Time1.Text = DateTime.Today.ToString("yyyy-MM-dd");

                //------------------------------------------------------------------------------
                //系统管理员，公司领导 可查看所有的项目列表资料
                if (WebFrame.Comm.JSecurity.HasRoles("xtgl,gsld"))
                {
                    this.DepartNum.Text = "";
                    this.PersonID.Text = "";
                }
                else if (WebFrame.Comm.JSecurity.HasRoles("bmld"))  //部门领导可查询本部门的所有项目
                {
                    this.DepartNum.Text = WebFrame.Util.JCookie.GetCookieValue("departnum");
                    this.PersonID.Text = "";
                }
                else
                {
                    //查询项目关联的人员或项目的发起人
                    this.DepartNum.Text = "";
                    this.PersonID.Text = String.Format("ProjectAuthor='{0}' or  exists (select 1 from Tb_Project_Person where parentGuid=Tb_Project_LogView.parentGuid and UserID='{0}')", WebFrame.FrameLib.UserID);
                }
            }
        }
    }
}
