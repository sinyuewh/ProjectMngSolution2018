using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class JRole_Action : System.Web.UI.Page
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
                    case "DEL_JRole":                    
                        Result = this.DeleteRole(KeyID);
                        break;

                    case "DEL_JItem":
                        Result = this.DeleteItem(KeyID);
                        break;

                    case "DEL_JStrInfo":
                        Result = this.DeleteStrInfo(KeyID);
                        break;

                    case "RESETPASSWORD_JUser":
                        Result = this.ResetPassWord(KeyID);
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
        //操作1--删除角色
        private String DeleteRole(String RoleID)
        {
            String result = "failer";
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("JRole_DEL"))
            {
                WebFrame.Comm.JRoleBU bu2 = new WebFrame.Comm.JRoleBU();
                bool succ=bu2.DeleteData(RoleID);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        //操作2--删除系统条目
        private String DeleteItem(String ItemName)
        {
            String result = "failer";
            bool succ = false;
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("JItem_DEL"))
            {
                succ = (new KORWeb.BUL.JItemBU()).DeleteData(ItemName);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        //操作3--重置用户密码
        private String ResetPassWord(String userid)
        {
            String result = "failer";
            bool succ = false;
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("JUser_RESET"))
            {
                KORWeb.BUL.JUserBU bu1 = new KORWeb.BUL.JUserBU();
                succ = bu1.ResetPassWord(userid);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        private String DeleteStrInfo(String strID)
        {
            String result = "failer";
            bool succ = false;
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("JStrInfo_DEL"))
            {
                succ = (new KORWeb.BUL.JStrInfoBU()).DeleteData(strID);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }
        #endregion
    }
}
