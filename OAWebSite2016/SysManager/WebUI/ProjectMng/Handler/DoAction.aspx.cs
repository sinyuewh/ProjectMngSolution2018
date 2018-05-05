using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng.Handler
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
                    //删除选中的项目
                    case "DEL_Tb_Project":
                        Result = this.DeleteProject(KeyID);
                        break;

                    
                    //确定选中的项目
                    case "SURE_Tb_Project":
                        Result = this.SureProject(KeyID);
                        break;
                    

                    //将项目标记为完成
                    case "COMPLETE_Tb_Project":
                        Result = this.CompleteProject(KeyID,DateTime.Parse(Remark));
                        break;

                    //将项目标记为取消
                    case "CANCEL_Tb_Project":
                        Result = this.CancelProject(KeyID, Remark);
                        break;


                    //删除选中的项目附件
                    case "DEL_Tb_Project_ATTACHMENT":
                        Result = this.DelAttachment(KeyID);
                        break;

                    //删除选中的项目成员
                    case "DEL_Tb_Project_PERSON":
                        Result = this.DelProjectPerson(KeyID);
                        break;

                    //将项目重新返工
                    case "ReturnWork_Tb_Project":
                        Result = this.ReturnWorkProject(KeyID, Remark);
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
        //操作1--删除项目
        private String DeleteProject(String ProjectNum)
        {
            String result = "failer";
            KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
            bool succ = bu1.DeleteData(ProjectNum);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //操作2--项目立项确定
        private String SureProject(String ProjectNum)
        {
            String result = "failer";
            KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
            bool succ = bu1.SureProjectData(ProjectNum);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //将项目标为完成
        private String CompleteProject(String ProjectNum,DateTime completeTime)
        {
            String result = "failer";
            KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
            bool succ = bu1.CompleteProjectData(ProjectNum, completeTime);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //将项目标为取消
        private String CancelProject(String ProjectNum,String remark)
        {
            String result = "failer";
            //判断是否有标为完成的权限
            KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
            bool succ = bu1.CancelProjectData(ProjectNum, remark);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //将项目标为返工
        private String ReturnWorkProject(String ProjectNum, String remark)
        {
            String result = "failer";
            //判断是否有标为完成的权限
            KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
            bool succ = bu1.ReturnWorkProject(ProjectNum, remark);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }


        //操作3--删除项目附件
        private String DelAttachment(String AttachID)
        {
            String result = "failer";
            //判断是否有操作的权限（删除）
            KORWeb.BUL.JAttachmentBU bu1 = new KORWeb.BUL.JAttachmentBU();
            bool succ = bu1.DeleteData(AttachID);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }
        
        //操作4--删除项目组成员
        private String DelProjectPerson(String dataid)
        {
            String result = "failer";
            //判断是否有操作的权限（删除）
            KORWeb.BUL.Tb_Project_PersonBU bu1 = new KORWeb.BUL.Tb_Project_PersonBU();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("GuidID", dataid));
            bool succ = bu1.DelProjectPerson(dataid);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }
        #endregion
    }
}
