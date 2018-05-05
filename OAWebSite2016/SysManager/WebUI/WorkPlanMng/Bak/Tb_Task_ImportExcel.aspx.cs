using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng
{
    public partial class Tb_Task_ImportExcel : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            if (this.file1.CheckData())
            {
                KORWeb.BUL.Tb_TaskBU bu1 = new KORWeb.BUL.Tb_TaskBU();
                String f1 = Server.MapPath("/Attachment/Temp/taskdata.xls");
                this.file1.SaveAs(f1);
                bool succ = bu1.ExportDataFromXls(this.parentGuid.Text,f1);
                if (succ)
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";

                    js1 = js1 + " parent.$('#butSearch').click();";
                    js1 = js1 + " parent.layer.close(index);});";
                    JAjax.ExecuteJS(js1);
                }
                else
                {
                    WebFrame.Util.JAjax.Alert("错误：操作失败，请重试！");
                }
            }
            else
            {
                WebFrame.Util.JAjax.Alert("错误：请选择一个正确的工单Excel文件上传！");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
