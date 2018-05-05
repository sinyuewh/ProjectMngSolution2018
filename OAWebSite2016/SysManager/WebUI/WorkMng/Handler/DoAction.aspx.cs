using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.WorkMng.Handler
{
    public partial class DoAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            KORWeb.BUL.UTools.ClearCache();
            if (!Page.IsPostBack)
            {
                String Action = Request["Action"];
                String KeyID = Request["KeyID"];
                String Result = "failer";

                switch (Action)
                {
                    case "RECEIVE_Tb_Task":
                        Result = this.ReceiveTask(KeyID);
                        break;

                    default:
                        break;
                }

                //将结果输出
                Response.Write(Result);
                Response.End();
            }
        }

        #region 私有方法
        //操作1--用户接单
        private String ReceiveTask(String guidid)
        {
            String result = "failer";
            //判断是否有操作的权限
            KORWeb.BUL.Tb_TaskBU bu2 = new KORWeb.BUL.Tb_TaskBU();
            bool succ = bu2.ReceiveTask(guidid);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }

        #endregion
    }
}
