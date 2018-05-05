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
using WebFrame;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng.Handler
{
    public partial class DoAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UTools.ClearCache();
            if (!Page.IsPostBack)
            {
                String Action = Request["Action"];
                String KeyID = Request["KeyID"];
                String Result = "failer";

                switch (Action)
                {
                    case "Cancel_Tb_Task":                           //取消工单
                        Result = this.CancelTask(KeyID);
                        break;


                   case "JieDan_Tb_Task":                          //接单
                        String endDate = Request["endDate"];
                        Result = this.JieDanTask(KeyID, endDate);
                        break;

                    case "TuiTask_Tb_Task":                         //退单
                        Result = this.TuiTaskTask(KeyID);
                        break;

                    case "SubmitCheck_Tb_Task":                    //提交审核
                        Result = this.SubmitTask(KeyID);
                        break;

                    case "Complete_Tb_Task":                        //完成或失败工单
                        int Flag = int.Parse(Request["Flag"]);
                        Result = this.CompleteTask(KeyID, Flag);
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

        //操作1--取消工单
        private String CancelTask(String TaskID)
        {
            String result = "failer";
            Tb_TaskBU bu1 = new Tb_TaskBU();
            bool succ = bu1.CancelTask(TaskID);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //操作2--接单
        private String JieDanTask(String TaskID, String endDate)
        {
            String result = "failer";
            Tb_TaskBU bu1 = new Tb_TaskBU();
            int noTask = bu1.GetNoCompleteTaskCount();
            if (noTask < 3)
            {
                bool succ = bu1.JieDanTask(TaskID, endDate);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        //操作3--退单
        private String TuiTaskTask(String TaskID)
        {
            String result = "failer";
            Tb_TaskBU bu1 = new Tb_TaskBU();
            bool succ = bu1.TuiTaskTask(TaskID);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }

        //操作1--提交工单审核
        private String SubmitTask(String TaskID)
        {
            String result = "failer";
            Tb_TaskBU bu1 = new Tb_TaskBU();
            bool succ = bu1.SubmitTask(TaskID);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }

        //操作--Complet or not Task
        private String CompleteTask(String TaskID, int Flag)
        {
            String result = "failer";
            Tb_TaskBU bu1 = new Tb_TaskBU();
            bool succ = bu1.CompleteTask(TaskID, Flag,"");
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //提交考核数据
        private String SubmitKaoHeData(String TaskID, int workload, int score)
        {
            String result = "failer";
            Tb_TaskBU bu1 = new Tb_TaskBU();
            bool succ = bu1.SubmitKaoHeData(TaskID, workload,score);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }

        #endregion
    }
}
