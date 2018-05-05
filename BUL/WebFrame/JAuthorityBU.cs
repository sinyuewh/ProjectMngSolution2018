using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KORWeb.DAL;
using System.Data;

namespace KORWeb.BUL
{
   /// <summary>
   /// 权限业务类
   /// </summary>
   public class JAuthorityBU
   {
       /// <summary>
       /// 得到角色权限EasyUiJson 数据
       /// </summary>
       /// <param name="OldAuthorityID"></param>
       /// <returns></returns>
       public String GetRoleAuthorityEasyUiJsonData(String RoleID)
       {
           String str1 = String.Empty;
           JAuthorityDetailDA da1 = new JAuthorityDetailDA();
           DataTable t1 = da1.GetRoleAuthorityEasyUiJsonData(RoleID);
           str1 = KORWeb.BUL.UTools.GetEasyUiTreeData(t1);
           return str1;
       }
   }
}
