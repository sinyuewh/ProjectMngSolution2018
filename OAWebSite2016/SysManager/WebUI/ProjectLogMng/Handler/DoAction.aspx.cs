using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.ProjectLogMng.Handler
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
                    //删除选中的项目附件
                    case "DEL_Tb_Project_Log_ATTACHMENT":                   //DEL_Tb_Project_Log_ATTACHMENT
                        Result = this.DelAttachment(KeyID);
                        break;


                    case "DEL_Tb_Project_Money":                            //删除财务数据
                        Result = this.DelProjectMoney(KeyID);
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


        private String DelProjectMoney(String DataID)
        {
            String result = "failer";
            //判断是否有操作的权限（删除）
            KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
            
            bool succ = bu1.DelteProjectMoneyData(DataID);
            if (succ)
            {
                result = "ok";
            }
            return result;
        }
        #endregion
    }
}
