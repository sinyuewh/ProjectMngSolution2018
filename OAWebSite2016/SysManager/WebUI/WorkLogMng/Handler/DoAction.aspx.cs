using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Data;
using WebFrame;
using KORWeb.BUL;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng.Handler
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
                String Remark = Request["Remark"];

                String Result = "failer";

                switch (Action)
                {
                    case "DEL_WorkLog":
                        Result = this.DeleteWorkLog(KeyID);
                        break;

                    case "DEL_WorkReminder":
                        Result = this.DeleteWorkReminder(KeyID);
                        break;
                    
                    //将选中的数据标记为【已处理】
                    case "HasDone_WorkReminder":
                        Result = this.HasDoneWorkReminder(KeyID, true);
                        break;

                    //将选中的数据标记为【未处理】
                    case "HasNoneDone_WorkReminder":
                        Result = this.HasDoneWorkReminder(KeyID, false);
                        break;

                    case "DEL_JLog":
                        Result = this.DeleteJLog(KeyID);
                        break;

                    case "COMPLETE_WEEK_PLAN":
                        Result = this.CheckWeekPlan(KeyID, Remark);
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
        //操作---确定周工作计划
        private String CheckWeekPlan(String DataID, String Remark)
        {
            String result = "failer";
            //判断是否有操作的权限
            KORWeb.BUL.Tb_PlanBU bu1 = new Tb_PlanBU();
            bool succ = bu1.CheckWeekPlanDetail(DataID,Remark);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }

        //操作1--删除日志
        private String DeleteWorkLog(String DataID)
        {
            String result = "failer";
            //判断是否有操作的权限
            KORWeb.BUL.Tb_WorkLogBU bu1 = new KORWeb.BUL.Tb_WorkLogBU();
            bool succ = bu1.DeleteData(DataID);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //操作2--删除备忘录
        private String DeleteWorkReminder(String DataID)
        {
            String result = "failer";
            //判断是否有操作的权限
            try
            {
                Tb_WorkReminderBU bu1 = new Tb_WorkReminderBU();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("LogID", DataID));
                condition.Add(new SearchField("AddUserID", FrameLib.UserID));
                bu1.DeleteData(condition);
                result = "ok";
            }
            catch (Exception err)
            {
                ;
            }
            return result;
        }

        //操作3--将选中的数据标记为已处理
        private String HasDoneWorkReminder(String DataID,
            bool doneFlag)
        {
            String result = "failer";
            //判断是否有操作的权限
            try
            {
                Tb_WorkReminderBU bu1 = new Tb_WorkReminderBU();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("LogID", DataID,SearchOperator.Collection));
                condition.Add(new SearchField("AddUserID", FrameLib.UserID));

                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                dic1["IsDone"] = doneFlag;
                bu1.EditData(condition, dic1);
                result = "ok";
            }
            catch (Exception err)
            {
                ;
            }
            return result;
        }

        //操作4--删除备忘工作日志
        private String DeleteJLog(String guidID)
        {
            if (!string.IsNullOrEmpty(guidID))
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("guidID", guidID, SearchFieldType.NumericType));
                JLogBU bul = new JLogBU();
                bul.DeleteData(condition);
                return "ok";
            }
            else
            {
                return "";
            }
        }
        #endregion
    }
}
