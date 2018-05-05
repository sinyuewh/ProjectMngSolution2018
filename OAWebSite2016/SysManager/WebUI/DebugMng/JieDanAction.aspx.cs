using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Data;
using System.Data;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.DebugMng
{
    public partial class JieDanAction : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            String taskid = Request.QueryString["TaskID"];
            if (String.IsNullOrEmpty(taskid) == false
                && WebFrame.Util.JValidator.IsDateTime(this.PlanDate.Text))
            {
                String doman = this.ExecuteManID.SelectedValue;
                string doman1 = this.ExecuteManID.SelectedItem.Text;
                Tb_TaskBU bu1 = new Tb_TaskBU();
                bool succ1 = bu1.JieDanTask(taskid, doman, doman1, this.PlanDate.Text);

                if (succ1)   //submit succ
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
                UTools.Alert("操作失败，可能的原因是数据类型错误!");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.PlanDate.Text = DateTime.Now.AddDays(5).ToString("yyyy-MM-dd");
                this.SetPerson();
                
            }
        }


        /// <summary>
        /// 设置接单人
        /// </summary>
        private void SetPerson()
        {
            String projectNum = Request.QueryString["parentGuid"];
            Tb_ProjectBU bu1 = new Tb_ProjectBU();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("prjNum", projectNum));
            Dictionary<String, object> dic1 = bu1.GetFirstDictionary(condition, "GuidID");
            if (dic1 != null && dic1.Count > 0)
            {
                String Guidid1 = dic1["GuidID"].ToString();
                Tb_Project_PersonBU bu2 = new Tb_Project_PersonBU();
                condition.Clear();
                condition.Add(new SearchField("parentGuid", Guidid1));
                DataTable dt = bu2.GetListData(condition, -1, -1, "prjRole", "*");
                if (dt != null && dt.Rows.Count > 0)
                {
                    bool isManager = false;
                    if (WebFrame.FrameLib.UserID == "admin")
                    {
                        isManager = true;
                    }
                    else
                    {
                        DataRow[] drs=dt.Select("UserID='" + WebFrame.FrameLib.UserID + "'");
                        if (drs != null && drs.Length > 0)
                        {
                            DataRow dr1 = drs[0];
                            String roles1 = dr1["PrjRole"].ToString();
                            if (roles1 == "0" || roles1 == "3")
                            {
                                isManager = true;
                            }
                        }
                    }

                    if (isManager)
                    {
                        foreach (DataRow dr1 in dt.Rows)
                        {
                            if (dr1["PrjRole"].ToString() != "3")
                            {
                                this.ExecuteManID.Items.Add(new ListItem(dr1["UserName"].ToString(),dr1["UserID"].ToString()));
                            }
                        }
                    }
                    else
                    {
                        this.ExecuteManID.Items.Add(new ListItem(WebFrame.FrameLib.UserName,WebFrame.FrameLib.UserID));
                    }
                }
            }
        }
    }
}
