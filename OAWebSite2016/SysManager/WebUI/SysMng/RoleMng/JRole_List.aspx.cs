using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class JRole_List : System.Web.UI.Page
    {
        /// <summary>
        /// 得到角色的用户
        /// </summary>
        /// <param name="roleid"></param>
        /// <returns></returns>
        public String GetRoleUsers(String roleid)
        {
            String str1 = String.Empty;
            String str2 = String.Empty;
            String str3 = String.Empty;

            (new WebFrame.Comm.JRoleUsersBU()).GetRoleUserID(roleid, ref str1, ref str2, ref str3);
            int count1 = WebFrame.Comm.JRoleBU.GetRoleUserCount(roleid);
            if (count1 < 2)
            {
                if (count1 == 1)
                {
                    return KORWeb.BUL.JUserBU.GetUserNamByIDS(str1);
                }
                else
                {
                    return "未设置";
                }
            }
            else
            {
                String sname1 = KORWeb.BUL.JUserBU.GetUserNamByIDS(str1);
                return WebFrame.Util.JString.GetMaxLenth(sname1, 20) + "等" + count1 + "人";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}
