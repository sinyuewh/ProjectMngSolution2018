using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.PubLib
{
    public partial class GetEasyUITreeData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            KORWeb.BUL.UTools.ClearCache();
            if (!Page.IsPostBack)
            {
                String result = String.Empty;
                String dataKind = Request["dataKind"];
                String olduser1 = Request["oldUsers"];

                if (dataKind == "0")        //选择角色选择用户的Tree的Json数据
                {
                    if (String.IsNullOrEmpty(olduser1))
                    {
                        result = this.GetRoleUserJsonData();
                    }
                    else
                    {
                        result = this.GetRoleUserJsonData(olduser1);
                    }
                }
                else if (dataKind == "1")   //得到角色选择权限Tree的Json数据
                {
                    result = this.GetRoleAuthorityJsonData();
                }
                else if (dataKind == "99")   //得到通用的选择用户数据
                {
                    List<String> list1 = new List<string>();
                    if (String.IsNullOrEmpty(olduser1) == false)
                    {
                        String[] arr1 = olduser1.Split(',');
                        foreach (String m in arr1)
                        {
                            if (list1.Contains(m) == false)
                            {
                                list1.Add(m);
                            }
                        }
                    }
                    result = this.GetCommonUserJsonData(list1);
                    result = result.Replace("ID", "id");
                }


                //输出数据
                Response.AddHeader("Content-type", "text/json; charset=utf-8");  
                //Response.Charset = "UTF-8";
                Response.Write(result);
                Response.End();
            }
        }


        #region 私有方法
        /// <summary>
        /// 得到通用的用户选择
        /// </summary>
        /// <returns></returns>
        private String GetCommonUserJsonData(List<String> oldUser)
        {
            String result = (new KORWeb.BUL.JUserBU()).GetSelectUserEasyUiJsonData(oldUser);
            return result;
        }

        //得到角色用户选择Json数据
        private String GetRoleUserJsonData()
        {
            String RoleID = Request["RoleID"];
            List<String> oldUser = new List<string>();
            if (String.IsNullOrEmpty(RoleID) == false)
            {
                WebFrame.Comm.JRoleUsersBU bu2 = new WebFrame.Comm.JRoleUsersBU();
                String user1 = String.Empty;
                String user2 = String.Empty;
                String user3 = String.Empty;
                bu2.GetRoleUserID(RoleID, ref user1, ref user2, ref user3);
                if (String.IsNullOrEmpty(user1) == false)
                {
                    String[] arr1 = user1.Split(',');
                    foreach (String m in arr1)
                    {
                        oldUser.Add(m);
                    }
                }
            }
            String result = (new KORWeb.BUL.JUserBU()).GetSelectUserEasyUiJsonData(oldUser);
            return result;
        }


        //得到角色用户选择Json数据
        private String GetRoleUserJsonData(String oldUserValue)
        {
            List<String> oldUser = new List<string>();
            if (String.IsNullOrEmpty(oldUserValue) == false)
            {
                String[] arr1 = oldUserValue.Split(',');
                foreach (String m in arr1)
                {
                    oldUser.Add(m);
                }
            }

            String result = (new KORWeb.BUL.JUserBU()).GetSelectUserEasyUiJsonData(oldUser);
            return result;
        }


        //得到角色权限数据Json数据
        private String GetRoleAuthorityJsonData()
        {
            String RoleID = Request["RoleID"];
            String result = (new KORWeb.BUL.JAuthorityBU()).GetRoleAuthorityEasyUiJsonData(RoleID);
            return result;
        }
        #endregion
    }
}
