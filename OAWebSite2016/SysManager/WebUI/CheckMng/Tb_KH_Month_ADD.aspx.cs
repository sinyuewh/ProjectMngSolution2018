using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tb_KH_Month_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            KORWeb.BUL.Tb_KH_MonthBU bu1 = new KORWeb.BUL.Tb_KH_MonthBU();
            bool succ = bu1.CreateMonthKHData(int.Parse(this.byear.Text),int.Parse(this.bmonth.Text),
                                                int.Parse(this.khdays.Text));
            if (succ)   //submit succ
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


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.byear.Text = DateTime.Now.Year + "";
                this.bmonth.Text = DateTime.Now.Month + "";
                this.khdays.Text = this.getDays(int.Parse(this.byear.Text), int.Parse(this.bmonth.Text))+"";
            }
        }


        //得到工作日
        private int getDays(int byear,int bmonth)
        {
            int m = System.DateTime.DaysInMonth(byear, bmonth);
            int mm = 0;
            for (int i = 1; i <= m; i++)
            {
                System.DateTime date = Convert.ToDateTime(byear + "-" + bmonth + "-" + i);
                switch (date.DayOfWeek)
                {
                    case System.DayOfWeek.Monday:
                    case System.DayOfWeek.Thursday:
                    case System.DayOfWeek.Tuesday:
                    case System.DayOfWeek.Wednesday:
                    case System.DayOfWeek.Friday:
                        mm = mm + 1;
                        break;
                }
            }
            return mm;
        }
    }
}
