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
    public partial class Tb_PL_Month_Detail_Print : System.Web.UI.Page
    {
        /// <summary>
        /// 工作考核加权合计
        /// </summary>
        public double HJ1
        {
            get
            {
                if (ViewState["HJ1"] == null)
                {
                    return 0;
                }
                else
                {
                    return (double)ViewState["HJ1"];
                }
            }
            private set
            {
                ViewState["HJ1"] = value;
            }
        }

        /// <summary>
        /// 加减分合计
        /// </summary>
        public double HJ2
        {
            get
            {
                if (ViewState["HJ2"] == null)
                {
                    return 0;
                }
                else
                {
                    return (double)ViewState["HJ2"];
                }
            }
            private set
            {
                ViewState["HJ2"] = value;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.data1.DataBind();
                this.byear.Text = this.data1.Eval("byear");
                this.bmonth.Text = this.data1.Eval("bmonth");
                this.UserID.Text = this.data1.Eval("userid");

                this.data2.DataBind();
                this.data3.DataBind();

                //统计工作绩效加权得分1
                double sum1 = 0;
                double sum2 = 0;
                foreach (DataRow dr1 in this.data2.GetListData().Rows)
                {
                    sum1=sum1+double.Parse(dr1["LastWorkLoad"].ToString())*double.Parse(dr1["score"].ToString());
                    sum2 = sum2 + double.Parse(dr1["LastWorkLoad"].ToString());
                }

                this.HJ1 = Math.Round(sum1 / sum2, 0);

                //统计其他加减分2
                sum1 = 0;
                foreach (DataRow dr1 in this.data3.GetListData().Rows)
                {
                    sum1 = sum1 + double.Parse(dr1["KhScore1"].ToString());
                    
                }
                this.HJ2 = sum1;

                //判断用户是否有读数据的权限
                bool isCanRead = false;
                if (WebFrame.Comm.JAuthorityBU.HasSecurity("Tb_PL_Month_READ") == false)
                {
                    JUserBU bu1 = new JUserBU();
                    String s1 = bu1.GetShouquanUserList(WebFrame.FrameLib.UserID, 4);
                    s1 = s1 + "," + WebFrame.FrameLib.UserID;
                    String[] a1 = s1.Split(',');
                    if (a1.Contains(this.UserID.Text))
                    {
                        isCanRead = true;
                    }
                }
                else
                {
                    isCanRead = true;
                }

                //表示数据不能读写
                if (isCanRead == false)
                {
                    Response.Redirect("/NoAccessPage.aspx", true);
                }
            }
        }
    }
}
