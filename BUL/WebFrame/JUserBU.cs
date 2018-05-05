using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

using WebFrame;
using WebFrame.Data;
using WebFrame.Util;
using KORWeb.DDL;
using KORWeb.DAL;
using System.Configuration;
using System.Web;

namespace KORWeb.BUL
{
    /// 说明：业务类
    /// 编码：jsj
    /// 时间：2013-8-2 16:20:21
    public partial class JUserBU 
    {
        public String ErrorInfo { get; set; }

        #region 实例方法

        /// <summary>
        /// 新增一条数据
        /// </summary>
        /// <param name="data1">Dictionary数据</param>
        public void NewData(Dictionary<String, object> data1)
        {
            JUserDA da = new JUserDA();
            da.NewData(data1);
        }

        /// <summary>
        /// 根据条件，修改一个实体数据
        /// </summary>
        /// <param name="condition">修改数据的条件</param>
        /// <param name="data1">新的数据</param>
        public void EditData(List<SearchField> condition, Dictionary<String, object> data1)
        {
            JUserDA da = new JUserDA();
            da.EditData(condition, data1);
        }

        //得到列表数据
        public DataTable GetListData(List<SearchField> condition,
            int PageSize, int CurPage, String orderBy, params String[] Fields)
        {
            JUserDA da = new JUserDA();
            return da.GetListData(condition, PageSize, CurPage, orderBy, Fields);
        }

        /// <summary>
        /// 得到满足条件的第一行数据
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="Fields">数据字段</param>
        /// <returns>满足条件的行</returns>
        public DataRow GetFirstDataRow(List<SearchField> condition, params String[] Fields)
        {
            JUserDA da = new JUserDA();
            return da.GetFirstDataRow(condition, Fields);
        }

        /// <summary>
        /// 判断是否有符合条件的数据
        /// </summary>
        ///<param name="condition">查询条件</param>
        /// <returns></returns>
        public bool HasData(List<SearchField> condition)
        {
            JUserDA da = new JUserDA();
            return da.HasData(condition);
        }

        /// <summary>
        /// 重置用户的登陆密码
        /// </summary>
        /// <param name="UserID"></param>
        public bool ResetPassWord(String UserID)
        {
            bool succ = false;
            try
            {
                JUserDA da1 = new JUserDA();
                if (String.IsNullOrEmpty(UserID) == false)
                {
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("UserID", UserID));
                    Dictionary<String, object> data1 = new Dictionary<string, object>();
                    data1["[password]"] = "123456";
                    da1.EditData(condition, data1);
                    succ = true;
                }
            }catch(Exception err){;}
            return succ;
        }

        /// <summary>
        /// 功能说明：更新密码
        /// </summary>
        /// <param name="oldpass">旧密码</param>
        /// <param name="newPass">新密码</param>
        /// <returns></returns>
        public String ChangeOldPassWord(String oldpass, String newPass)
        {
            String error = String.Empty;
            if (String.IsNullOrEmpty(oldpass) == false
               && String.IsNullOrEmpty(newPass) == false)
            {
                JUserDA da1 = new JUserDA();
                List<SearchField> condition = new List<SearchField>();
                String UserID = FrameLib.UserID;
                condition.Add(new SearchField("UserID", UserID));
                DataRow dr1 = da1.GetFirstDataRow(condition, "*");
                if (dr1 != null)
                {
                    String pass0 = dr1["password"].ToString().Trim();
                    String pass1 = oldpass;
                    String pass2 = JString.MD5(pass1);
                    if (pass1 == pass0 || pass2 == pass0)
                    {
                        String pass3 = JString.MD5(newPass);
                        Dictionary<string, object> data1 = new Dictionary<string, object>();
                        data1["[password]"] = pass3;
                        da1.EditData(condition, data1);
                    }
                    else
                    {
                        error = "提示：老密码输入不正确，请重新输入！";
                    }
                }
            }
            return error;
        }

        /// <summary>
        /// 功能说明：更新密码
        /// </summary>
        /// <param name="oldpass">旧密码</param>
        /// <param name="newPass">新密码</param>
        /// <returns></returns>
        public String ChangeOldPassWord(String UserID,
            String oldpass, String newPass)
        {
            String error = String.Empty;
            if (String.IsNullOrEmpty(oldpass) == false
               && String.IsNullOrEmpty(newPass) == false)
            {
                JUserDA da1 = new JUserDA();
                List<SearchField> condition = new List<SearchField>();

                condition.Add(new SearchField("UserID", UserID));
                DataRow dr1 = da1.GetFirstDataRow(condition, "*");
                if (dr1 != null)
                {
                    String pass0 = dr1["password"].ToString().Trim();
                    String pass1 = oldpass;
                    String pass2 = JString.MD5(pass1);
                    if (pass1 == pass0 || pass2 == pass0)
                    {
                        String pass3 = JString.MD5(newPass);
                        Dictionary<string, object> data1 = new Dictionary<string, object>();
                        data1["password"] = pass3;
                        da1.EditData(condition, data1);
                    }
                    else
                    {
                        error = "提示：老密码输入不正确，请重新输入！";
                    }
                }
            }
            return error;
        }

        /// <summary>
        /// 删除用户数据，同时删除其相关数据
        /// 提示：此功能，可能会根据不同的项目重写
        /// </summary>
        /// <param name="AreaCode"></param>
        public bool DeleteData(String UserID)
        {
            bool succ = false;
            if (String.IsNullOrEmpty(UserID) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserID", UserID,SearchOperator.Collection));

                JConnect conn1 = JConnect.GetConnect();
                conn1.BeginTrans();
                try
                {
                    //JRoleUsersDA da1 = new JRoleUsersDA(conn1);
                    //da1.DeleteData(condition);

                    //JOrgUsersDA da2 = new JOrgUsersDA(conn1);
                    //da2.DeleteData(condition);

                    JUserDA da3 = new JUserDA();
                    da3.DeleteData(condition);

                    //删除其他的相关业务表
                    conn1.CommitTrans();
                    succ = true;

                }
                catch (Exception err)
                {
                    JTool.WriteErrorLog(err.Message);
                    conn1.RollBackTrans();
                }
            }
            return succ;
        }

        /// <summary>
        /// 根据用户的姓名得到姓名列表
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public DataTable GetUserName(String UserName,int pageSize)
        {
            DataTable dt1 = null;
            if (String.IsNullOrEmpty(UserName) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserName", UserName, SearchOperator.Contains));
                JUserDA da1 = new JUserDA();
                dt1=da1.GetListData(condition, pageSize, 1, "UserName", "UserName");
            }
            return dt1;
        }

        public String GetAuGroup(String userid)
        {
            if (String.IsNullOrEmpty(userid) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserID", userid));
                JUserDA da1 = new JUserDA();
                DataRow drresult = da1.GetFirstDataRow(condition, "AuthorityGroup");// GetListData(condition, -1, 1, "AuthorityGroup");

                if (drresult != null)
                {
                    if (!String.IsNullOrEmpty(drresult["AuthorityGroup"].ToString()))
                    {
                        return drresult["AuthorityGroup"].ToString();
                    }
                }
            }

            return "";
        }

        public String GetPwd(String userid)
        {
            if (String.IsNullOrEmpty(userid) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserID", userid));
                JUserDA da1 = new JUserDA();
                DataRow drresult = da1.GetFirstDataRow(condition, "PassWord");// GetListData(condition, -1, 1, "AuthorityGroup");

                if (drresult != null)
                {
                    if (!String.IsNullOrEmpty(drresult["PassWord"].ToString()))
                    {
                        return drresult["PassWord"].ToString();
                    }
                }
            }

            return "";
        }
        /// <summary>
        /// 保存用户数据的修改
        /// </summary>
        /// <returns></returns>
        public int SaveData(String oldUserID,String num, String UserID,
            String UserName,String Status,String AuthorityID,String OrgID)
        {
            int succ = 0;
            JConnect conn = JConnect.GetConnect();
            conn.BeginTrans();
            try
            {
                JUserDA da1 = new JUserDA(conn);
                JOrgUsersDA da2 = new JOrgUsersDA(conn);

                Dictionary<String, object> data1 = new Dictionary<string, object>();
                data1["num"] = num;
                data1["userid"] = UserID;
                data1["username"] = UserName;
                data1["status"] = Status;
                data1["AuthorityID"] = AuthorityID;
                data1["DepartID"] = FrameLib.DepartID;
                data1["AuthorityGroup"] = FrameLib.AuthorityGroup;
                
                if (String.IsNullOrEmpty(oldUserID) == false)
                {
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("UserID", UserID));
                    data1.Remove("userid");
                    da1.EditData(condition, data1);
                }
                else
                {
                    data1["[Password]"] = "123456";                           //设置默认的口令和密码
                    data1["LastLogin"] = DateTime.Now;           //设置默认的登陆时间
                    data1["LoginCount"] = 0;                                //设置默认的登陆测试
                    da1.NewData(data1);
                }

                //更新组织用户表
                List<SearchField> condition2 = new List<SearchField>();
                condition2.Add(new SearchField("UserID", UserID));
                if (string.IsNullOrEmpty(OrgID) == false)
                {
                    if (da2.HasData(condition2))
                    {
                        data1.Clear();
                        data1["orgid"] = OrgID;
                        da2.EditData(condition2, data1);
                    }
                    else
                    {
                        data1.Clear();
                        data1["orgid"] = OrgID;
                        data1["userid"] = UserID;
                        da2.NewData(data1);
                    }
                }
                else
                {
                    da2.DeleteData(condition2);
                }
                conn.CommitTrans();
                succ = 1;
            }
            catch (Exception err)
            {
                conn.RollBackTrans();
            }
            return succ;
        }

        /// <summary>
        /// 保存用户数据的修改
        /// </summary>
        /// <returns></returns>
        public int SaveData(String oldUserID, String num, String UserID,
            String UserName,String trueName,String telephone, String Status, String AuthorityID, String OrgID,String cardID)
        {
            int succ = 0;
            JConnect conn = JConnect.GetConnect();
            conn.BeginTrans();
            try
            {
                JUserDA da1 = new JUserDA(conn);
                JOrgUsersDA da2 = new JOrgUsersDA(conn);

                Dictionary<String, object> data1 = new Dictionary<string, object>();
                data1["num"] = num;
                data1["userid"] = UserID;
                data1["username"] = UserName;
                data1["TrueName"] = trueName;
                data1["status"] = Status;
                data1["AuthorityID"] = AuthorityID;
                data1["DepartID"] = FrameLib.DepartID;
                data1["AuthorityGroup"] = FrameLib.AuthorityGroup;
                if (!string.IsNullOrEmpty(cardID))
                {
                    data1["WbCardID"] = cardID;
                }
                if (!string.IsNullOrEmpty(telephone))
                {
                    data1["Telephone"] = telephone;
                }

                if (String.IsNullOrEmpty(oldUserID) == false)
                {
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("UserID", UserID));
                    data1.Remove("userid");
                    da1.EditData(condition, data1);
                }
                else
                {
                    data1["[Password]"] = "123456";                           //设置默认的口令和密码
                    data1["LastLogin"] = DateTime.Now;           //设置默认的登陆时间
                    data1["LoginCount"] = 0;                                //设置默认的登陆测试
                    da1.NewData(data1);
                }

                //更新组织用户表
                List<SearchField> condition2 = new List<SearchField>();
                condition2.Add(new SearchField("UserID", UserID));
                if (string.IsNullOrEmpty(OrgID) == false)
                {
                    if (da2.HasData(condition2))
                    {
                        data1.Clear();
                        data1["orgid"] = OrgID;
                        da2.EditData(condition2, data1);
                    }
                    else
                    {
                        data1.Clear();
                        data1["orgid"] = OrgID;
                        data1["userid"] = UserID;
                        da2.NewData(data1);
                    }
                }
                else
                {
                    da2.DeleteData(condition2);
                }
                conn.CommitTrans();
                succ = 1;
            }
            catch (Exception err)
            {
                conn.RollBackTrans();
            }
            return succ;
        }

        /// <summary>
        /// 根据用户的ID得到用户实体
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public JUserDD GetUserInfoByUserID(String UserID)
        {
            JUserDD data1 = null;
            if (String.IsNullOrEmpty(UserID) == false)
            {
                JUserDA da1 = new JUserDA();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserID", UserID));
                data1 = da1.GetFirstDataEntity(condition, "*");
            }
            return data1;
        }

        /// <summary>
        /// 得到选择用户的EasyUiJson数据
        /// </summary>
        /// <returns></returns>
        public String GetSelectUserEasyUiJsonData(List<String> OldUserID)
        {
            JUserDA da1 = new JUserDA();
            DataTable dt1 = da1.GetSelectUserEasyUiJsonData(OldUserID);
            String str1=UTools.GetEasyUiTreeData(dt1);
            return str1;
        }

        /// <summary>
        /// 得到用户的授权用户信息
        /// </summary>
        /// <param name="UserID">用户ID</param>
        /// <param name="sqkind">授权类型 1--工作备忘 2--工作日志 3--工作计划  4--考核数据
        /// </param>
        /// <returns></returns>
        public String GetShouquanUserList(String UserID,int sqkind)
        {
            StringBuilder str1 = new StringBuilder();
            bool first = true;

            JUserDA da1 = new JUserDA();
            List<SearchField> condition = new List<SearchField>();
            String s2 = String.Format("instr(qx{0}, '{1}') > 0",sqkind,UserID);
            condition.Add(new SearchField(s2, "", SearchOperator.UserDefine));
            DataTable dt1 = da1.GetListData(condition, -1, -1, "num", "UserID,qx" + sqkind+" as sq");
            foreach (DataRow dr1 in dt1.Rows)
            {
                String[] sq = dr1[1].ToString().Split(',');
                if (sq.Contains(UserID))
                {
                    if (first)
                    {
                        str1.Append(dr1[0].ToString());
                        first = false;
                    }
                    else
                    {
                        str1.Append(",").Append(dr1[0].ToString());
                    }
                }
            }

            String s1 = str1.ToString();
            if (String.IsNullOrEmpty(s1)) s1 = "-1";
            return s1;
        }
        #endregion

        #region 静态方法
        /// <summary>
        /// 根据用户的姓名得到用户的ID
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public static String GetUserIDByUserName(String UserName)
        {
            String userid = String.Empty;
            if (String.IsNullOrEmpty(UserName) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("UserName", UserName));
                Dictionary<String, object> dic1 = (new JUserDA()).GetFirstDictionary(condition, "UserID");
                if (dic1 != null && dic1.Count > 0)
                {
                    userid = dic1["UserID"].ToString();
                }
            }
            return userid;
        }
        #endregion

        #region 私有方法
        #endregion

        #region 用户登陆的方法 

        /// <summary>
        /// 平台用户的登陆方法
        /// </summary>
        /// <param name="userName">用户名</param>
        /// <param name="PassWord">登录密码</param>
        /// <param name="Userid">登录成功后，返回的用户ID</param>
        /// <returns>
        /// 0--表示用户名不存在
        /// 1--表示密码不正确
        /// 2--表示账号已停用
        /// 3--表示登陆成功
        /// </returns>
        public int Login(String userName, String PassWord,ref String Userid)
        {
            int succ = 0;
            Userid = userName;

            if (String.IsNullOrEmpty(userName) == false
                && String.IsNullOrEmpty(PassWord) == false)
            {
                JUserDA da1 = new JUserDA();
                List<SearchField> condition = new List<SearchField>();
                SearchField search1 = new SearchField("UserID", userName);
                SearchField search2 = new SearchField("UserName", userName);

                condition.Add(search1 | search2);
                DataRow data1 = da1.GetFirstDataRow(condition,"*");  

                if (data1!=null)
                {
                    String password1 = data1["Password"].ToString();
                    if (PassWord == password1 ||
                        JString.MD5(PassWord) == password1)
                    {
                        if (data1["status"].ToString() == "1")
                        {
                            //判断用户所在单位的情况
                            succ = 3;

                            //修改用户登录时间和登录次数
                            condition.Clear();
                            condition.Add(search1 | search2);
                            Dictionary<String, object> dic0 = new Dictionary<string, object>();
                            dic0["LastLogin"] = DateTime.Now;
                            if (data1["LoginCount"].ToString() != String.Empty)
                            {
                                dic0["LoginCount"] = "$$LoginCount+1";
                            }
                            else
                            {
                                dic0["LoginCount"] = 1;
                            }
                            da1.EditData(condition, dic0);

                            //设置用户的权限角色（可能需要修改)
                            FrameLib.AuthorityID = data1["AuthorityID"].ToString();         //用户的权限ID
                            FrameLib.UserName = data1["UserName"].ToString();               //用户的UserName
                            FrameLib.AuthorityGroup = data1["AuthorityGroup"].ToString();   //表示用户的类别
                            
                            //FrameLib.DepartID = data1["DepartID"].ToString();               //表示用户所属的部门ID
                            
                            Userid = data1["userid"].ToString();


                            //创建用户登录日志
                            JUserLoginLogDA da2 = new JUserLoginLogDA();
                            Dictionary<String, object> logdata = new Dictionary<string, object>();
                            logdata["ID"] = WebFrame.Util.JString.GetUnique32ID();
                            logdata["UserID"] = data1["UserID"].ToString();
                            logdata["UserName"] = data1["UserName"].ToString();
                            logdata["CreateTime"] = DateTime.Now;
                            logdata["AuthorityGroup"] = data1["AuthorityGroup"];
                            string ip = GetIPAddress();
                            logdata["Remark"] = ip;
                            da2.NewData(logdata);
                        }
                        else
                        {
                            succ = 2;
                        }
                    }
                    else
                    {
                        succ = 1;
                    }
                }
            }
            return succ;
        }

        /// <summary>
        /// 检查用户名是否正确，并返回正确的用户ID列表
        /// </summary>
        /// <param name="userNameList"></param>
        /// <returns></returns>
        public bool CheckUserList(String userNameList,ref String rightUser)
        {
            bool succ = true; ;
            StringBuilder str1 = new StringBuilder();
            bool first = true;
            if (String.IsNullOrEmpty(userNameList) == false)
            {
                userNameList = userNameList.Replace("，", ",");
                String[] arr1 = userNameList.Split(',');
                List<SearchField> condition = new List<SearchField>();
                JUserDA da1 = new JUserDA();
                Dictionary<string, object> dic1 = null;
                foreach (String m in arr1)
                {
                    condition.Clear();
                    condition.Add(new SearchField("( UserID='" + m + "' or UserName='" + m + "') ", "", SearchOperator.UserDefine));
                    dic1 = da1.GetFirstDictionary(condition, "UserID");
                    if (dic1 != null && dic1.Count > 0)
                    {
                        if (first)
                        {
                            str1.Append(dic1["UserID"].ToString());
                            first = false;
                        }
                        else
                        {
                            str1.Append(",").Append(dic1["UserID"].ToString());
                        }
                    }
                    else
                    {
                        succ=false;
                        break;
                    }
                }
            }
            if (succ)
            {
                rightUser = str1.ToString();
            }
            return succ;
        }

        /// <summary>
        /// 根据用户的ID得到用户的姓名
        /// </summary>
        /// <param name="userIDS"></param>
        public static String GetUserNamByIDS(String userIDS)
        {
            String result=String.Empty;
            if (String.IsNullOrEmpty(userIDS) == false)
            {
                JUserDA da1=new JUserDA();
                List<SearchField> condition=new List<SearchField>();
                condition.Add(new SearchField("UserID",userIDS,SearchOperator.Collection));
                DataTable dt1=da1.GetListData(condition,-1,-1,"num","UserName");
                bool first=true;
                StringBuilder str1=new StringBuilder();
                foreach(DataRow dr1 in dt1.Rows)
                {
                    if (first)
                    {
                        str1.Append(dr1[0].ToString());
                        first = false;
                    }
                    else
                    {
                        str1.Append(",").Append(dr1[0].ToString());
                    }
                }
                result = str1.ToString();
            }
            return result;
        }


        /// <summary>
        /// 获取登录ip
        /// </summary>
        /// <returns></returns>
        public static string GetIPAddress()
        {
            string userHostAddress = HttpContext.Current.Request.UserHostAddress;
            if (string.IsNullOrEmpty(userHostAddress))
            {
                userHostAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }
            return userHostAddress;

        }
        #endregion

    }
}
