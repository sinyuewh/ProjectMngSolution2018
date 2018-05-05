using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KORWeb.DAL;
using System.Data;
using WebFrame.Data;
using WebFrame;

namespace KORWeb.BUL
{
    /// <summary>
    /// Tb_Debug业务处理类
    /// </summary>
    public class Tb_DebugBU
    {
        public String ErrorInfo { get; set; }

        /// <summary>
        /// 执行结果的数据
        /// </summary>
        private int executeResultCount = -1;
        public int ExecuteResultCount
        {
            get { return this.executeResultCount; }
            private set { this.executeResultCount = value; }
        }

        #region 通用数据操作方法
        /// <summary>
        /// 新增一条数据
        /// </summary>
        /// <param name="data1">Dictionary数据</param>
        public void NewData(Dictionary<String, object> data1)
        {
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                da1.NewData(data1);
                this.executeResultCount = da1.ExecuteResultCount;
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
                throw err;
            }
        }


        /// <summary>
        /// 根据条件删除数据
        /// </summary>
        /// <param name="condition">删除数据条件</param>
        public void DeleteData(List<SearchField> condition)
        {
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                da1.DeleteData(condition);
                this.executeResultCount = da1.ExecuteResultCount;
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
        }


        /// <summary>
        /// 根据条件，修改一个数据
        /// </summary>
        /// <param name="condition">修改数据的条件</param>
        /// <param name="data1">新的数据</param>
        public void EditData(List<SearchField> condition, Dictionary<String, object> data1)
        {
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                da1.EditData(condition, data1);
                this.executeResultCount = da1.ExecuteResultCount;
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
        }

        /// <summary>
        /// 根据条件得到列表数据
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="PageSize">页大小</param>
        /// <param name="CurPage">当前页</param>
        /// <param name="Fields">数据字段</param>
        /// <param name="orderBy">排序表达式</param>
        /// <param name="TotalRow">数据总行数</param>
        /// <param name="Fields">要显示的字段</param>
        /// <returns>列表数据</returns>
        public DataTable GetListData(List<SearchField> condition,
            int PageSize, int CurPage, String orderBy,
            out int TotalRow, params String[] Fields)
        {
            TotalRow = 0;
            DataTable dt1 = null;
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                dt1 = da1.GetListData(condition, PageSize, CurPage, orderBy, out TotalRow, Fields);
                this.executeResultCount = da1.ExecuteResultCount;
                return dt1;
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
            return dt1;
        }

        //得到列表数据
        public DataTable GetListData(List<SearchField> condition,
            int PageSize, int CurPage, String orderBy, params String[] Fields)
        {
            int totalRow = 0;
            return this.GetListData(condition, PageSize, CurPage, orderBy, out totalRow, Fields);
        }


        /// <summary>
        /// 得到满足条件的第一行数据(返回值为Dictionary)
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="Fields">数据字段</param>
        /// <returns>Dictionary字典</returns>
        public Dictionary<string, object> GetFirstDictionary(List<SearchField> condition, params String[] Fields)
        {
            Dictionary<string, object> data1 = null;
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                data1 = da1.GetFirstDictionary(condition, Fields);
                this.executeResultCount = da1.ExecuteResultCount;
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
            return data1;
        }


        /// <summary>
        /// 判断是否有符合条件的数据
        /// </summary>
        ///<param name="condition">查询条件</param>
        /// <returns></returns>
        public bool HasData(List<SearchField> condition)
        {
            bool result = false;
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                result = da1.HasData(condition);
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
            return result;
        }

        /// <summary>
        /// 功能：执行普通的SQL语句
        /// </summary>
        public void ExcuteSql(String sql)
        {
            try
            {
                Tb_DebugDA da1 = new Tb_DebugDA();
                da1.ExcuteSql(sql);
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
        }
        #endregion

        #region 实例方法
        
        #endregion

        #region 静态方法
        /// <summary>
        /// 得到项目的Debug信息
        /// </summary>
        /// <param name="projectGuidid"></param>
        /// <returns></returns>
        public static String GetDebugCount(object projectGuidid)
        {
            String str1 = String.Empty;
            int count0 = 0;   //未完成
            int count1 = 0;   //待审核
            int count2 = 0;   //已完成

            Tb_DebugDA da1 = new Tb_DebugDA();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("ProjectGuidID", projectGuidid.ToString()));
            DataTable dt1 = da1.GetListData(condition, -1, -1, "", "Status");
            foreach (DataRow dr1 in dt1.Rows)
            {
                int status = int.Parse(dr1[0].ToString());
                if (status == 0)
                {
                    count0++;
                }
                else if (status == 1)
                {
                    count1++;
                }
                else
                {
                    count2++;
                }
            }

            str1 = String.Format("{0}|{1}|{2}", count0, count1, count2);

            return str1;
        }


        /// <summary>
        /// 提交Debug的结果
        /// </summary>
        /// <returns></returns>
        public bool SubmitDebugData(String debugGuid,String status,
            String content,String domanUserID,string domanName)
        {
            bool succ = false;
            List<SearchField> condition = new List<SearchField>();
            Dictionary<String, object> dic1 = new Dictionary<string, object>();
            condition.Add(new SearchField("GuidID", debugGuid));
            Tb_DebugDA da1 = new Tb_DebugDA();
            dic1 = da1.GetFirstDictionary(condition, "*");
            if (dic1 != null && dic1.Count > 0)
            {
                //更新日志的内容
                DataTable dt1 = null;
                String log1 = dic1["log"].ToString();
                if (String.IsNullOrEmpty(log1))
                {
                    dt1 = new DataTable();
                    dt1.Columns.Add("dotime");
                    dt1.Columns.Add("domanUserID");
                    dt1.Columns.Add("domanUserName");
                    dt1.Columns.Add("status");
                    dt1.Columns.Add("content");
                }
                else
                {
                    dt1 = KORWeb.BUL.UTools.JsonToDataTable(log1);
                    //.JsonToDataTable(log1);
                }
                DataRow dr1 = dt1.NewRow();
                dr1["dotime"] = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
                dr1["domanUserID"] = domanUserID;
                dr1["domanUserName"] = domanName;
                dr1["status"] = (status == "1" ? "完成" : "未完成");
                dr1["content"] = content;
                dt1.Rows.Add(dr1);
                log1 = KORWeb.BUL.UTools.DataTableToJson(dt1);
                
                //更新debug的内容
                dic1.Clear();
                dic1["Status"] = status;
                dic1["StatusTime"] = DateTime.Now.ToString();
                dic1["lastlog"] = content + "(" + domanName+"  "+DateTime.Now.ToString() + ")";
                                
                StringBuilder str1 = new StringBuilder();
                str1.Append(log1);
                dic1["log"] = str1;
                da1.EditData(condition, dic1);
                succ = true;
            }
            return succ;
        }


        /// <summary>
        /// 得到Bug的统计结果
        /// tjkind=0 按登记人 tjkind=1 按责任人
        /// </summary>
        /// <param name="tjkind"></param>
        /// <param name="time0"></param>
        /// <param name="time1"></param>
        /// <returns></returns>
        public DataTable GetTjResult(String tjkind, String time0, String time1,String status)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("doman");
            dt1.Columns.Add("A",typeof(int));
            dt1.Columns.Add("B",typeof(int));
            dt1.Columns.Add("C",typeof(int));
            dt1.Columns.Add("TC",typeof(double));


            List<SearchField> condition = new List<SearchField>();
            if (String.IsNullOrEmpty(status) == false)
            {
                condition.Add(new SearchField("Status", status));
            }

            if (String.IsNullOrEmpty(time0) == false)
            {
                condition.Add(new SearchField(String.Format("AddTime>=cdate('{0}')", time0), "", SearchOperator.UserDefine));
            }

            if (String.IsNullOrEmpty(time1) == false)
            {
                condition.Add(new SearchField(String.Format("AddTime<=cdate('{0} 23:59:59')", time1), "", SearchOperator.UserDefine));
            }

            //统计数据
            String commdText = String.Empty;
            JCommand comm1 = new JCommand();
            if (tjkind == "0")
            {
                commdText = "select AddUser as domanID,testman as domanName,BugKind,count(*) as count1 from Tb_DebugView";
                if (condition.Count > 0)
                {
                    commdText = commdText + " where " + SearchField.GetSearchCondition(condition);
                }
                commdText  = commdText + " group by AddUser,testman,BugKind";
            }
            else
            {
                commdText = "select executeMan as domanID,zrr as domanName,BugKind,count(*) as count1 from Tb_DebugView";
                if (condition.Count > 0)
                {
                    commdText = commdText + " where " + SearchField.GetSearchCondition(condition);
                }
                commdText = commdText + " group by executeMan,zrr,BugKind";
            }
            comm1.CommandText = commdText;
            DataTable dt0=comm1.SearchData(-1).Tables[0];
            String doman1 = String.Empty;
            DataRow dr1 = null;
            foreach (DataRow dr0 in dt0.Rows)
            {
                if (doman1 != dr0["domanID"].ToString())
                {
                    if (dr1!=null)
                    {
                        dt1.Rows.Add(dr1);
                    }
                    dr1 = dt1.NewRow();
                    dr1["doman"] = dr0["domanName"];
                    dr1["A"] = 0;
                    dr1["B"] = 0;
                    dr1["C"] = 0;
                    dr1[dr0["BugKind"].ToString()] = int.Parse(dr0["count1"].ToString());
                }
                else
                {
                    dr1[dr0["BugKind"].ToString()] = int.Parse(dr0["count1"].ToString());
                }
            }
            if (dr1 != null)
            {
                dt1.Rows.Add(dr1);
            }
            
            return dt1;
        }


        /// <summary>
        /// CheckDebugData 
        /// </summary>
        /// <returns></returns>
        public bool CheckDebugData(String debugGuid, String status,
            String content, String domanUserID, string domanName, 
            String ExecuteMan)
        {
            bool succ = false;
            int fgrate = 0;

            List<SearchField> condition = new List<SearchField>();
            Dictionary<String, object> dic1 = new Dictionary<string, object>();
            condition.Add(new SearchField("GuidID", debugGuid));
            Tb_DebugDA da1 = new Tb_DebugDA();
            dic1 = da1.GetFirstDictionary(condition, "*");
            if (dic1 != null && dic1.Count > 0)
            {
                //更新日志的内容
                DataTable dt1 = null;
                String log1 = dic1["log"].ToString();
                fgrate = int.Parse(dic1["fgrate"].ToString());

                if (String.IsNullOrEmpty(log1))
                {
                    dt1 = new DataTable();
                    dt1.Columns.Add("dotime");
                    dt1.Columns.Add("domanUserID");
                    dt1.Columns.Add("domanUserName");
                    dt1.Columns.Add("status");
                    dt1.Columns.Add("content");
                }
                else
                {
                    dt1 = KORWeb.BUL.UTools.JsonToDataTable(log1);
                }
                DataRow dr1 = dt1.NewRow();
                dr1["dotime"] = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
                dr1["domanUserID"] = domanUserID;
                dr1["domanUserName"] = domanName;
                dr1["status"] = (status == "2" ? "已解决" : "未解决");
                dr1["content"] = content;
                dt1.Rows.Add(dr1);
                log1 = KORWeb.BUL.UTools.DataTableToJson(dt1);

                //更新debug的内容
                dic1.Clear();
                dic1["Status"] = status;
                dic1["StatusTime"] = DateTime.Now.ToString();
                if (status == "0")
                {
                    dic1["fgrate"] = fgrate + 1;  //增加返工次数
                }
                dic1["lastlog"] = content + "(" + domanName + "  " + DateTime.Now.ToString() + ")";


                if (String.IsNullOrEmpty(ExecuteMan) == false)
                {
                    JUserBU bu1 = new JUserBU();
                    List<SearchField> condition1 = new List<SearchField>();
                    condition1.Add(new SearchField("UserID", ExecuteMan));
                    if (bu1.HasData(condition1))
                    {
                        dic1["ExecuteMan"] = ExecuteMan;
                    }
                }

                StringBuilder str1 = new StringBuilder();
                str1.Append(log1);
                dic1["log"] = str1;
                da1.EditData(condition, dic1);
                succ = true;
            }
            return succ;
        }
        #endregion

        #region 私有方法
        #endregion
    }
}
