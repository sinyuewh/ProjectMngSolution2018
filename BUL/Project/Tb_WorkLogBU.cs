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

namespace KORWeb.BUL
{
    /// 说明：Tb_WorkLog
    /// 编码：苏纽兵
    /// 时间：2016/8/19 16:11:58
    public partial  class Tb_WorkLogBU
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                da1.NewData(data1);
                this.executeResultCount = da1.ExecuteResultCount;
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                result=da1.HasData(condition);
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
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                da1.ExcuteSql(sql);
            }
            catch (Exception err)
            {
                this.ErrorInfo = err.Message.Replace("\r", "").Replace("\t", "").Replace("\n", "");
            }
        }
        #endregion
        
        #region 实例方法
        /// <summary>
        /// 提交今日工作日志
        /// </summary>
        /// <param name="list1"></param>
        /// <returns></returns>
        public bool UpdateTodayLog(List<KORWeb.DDL.Tb_WorkLogDD> list1)
        {
            bool succ = false;
            JConnect.GetConnect().BeginTrans();
            try
            {
                List<SearchField> condition = new List<SearchField>();
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                foreach (Tb_WorkLogDD d1 in list1)
                {
                    condition.Clear();
                    condition.Add(new SearchField("AddUserID", d1.AddUserID));
                    condition.Add(new SearchField("parentGuid", d1.ParentGuid));
                    condition.Add(new SearchField("PlanID", d1.PlanID));
                    condition.Add(new SearchField("PlanNum", d1.PlanNum));
                    String t1 = "CDate('" + d1.BegDate.ToString("yyyy-MM-dd") + "')";
                    condition.Add(new SearchField("begDate", t1,SearchFieldType.NumericType));

                    dic1.Clear();

                    //修改数据
                    if (da1.HasData(condition))
                    {
                        dic1["LogContent"] = d1.LogContent;
                        dic1["WorkLoad"] = d1.WorkLoad;
                        da1.EditData(condition, dic1);
                    }
                    else
                    {
                        dic1["LogContent"] = d1.LogContent;
                        dic1["WorkLoad"] = d1.WorkLoad;
                        if (d1.LogContent.Length > 0 && d1.WorkLoad > 0)
                        {
                            dic1["LogContent"] = d1.LogContent;
                            dic1["WorkLoad"] = d1.WorkLoad;
                            dic1["parentGuid"] = d1.ParentGuid;
                            dic1["PlanID"] = d1.PlanID;
                            dic1["PlanNum"] = d1.PlanNum;
                            dic1["AddUserID"] = d1.AddUserID;
                            dic1["AddUserName"] = d1.AddUserName;
                            dic1["begDate"] = d1.BegDate;
                            dic1["Addtime"] = d1.AddTime;
                            dic1["LogID"] = WebFrame.Util.JString.GetUnique32ID();
                            da1.NewData(dic1);
                        }
                    }
                }
                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
                succ = false;
            }

            return succ;
        }
        /// <summary>
        /// 删除工作日志
        /// </summary>
        /// <param name="DataID"></param>
        /// <returns></returns>
        public bool DeleteData(String DataID)
        {
            bool succ = false;
            JConnect.GetConnect().BeginTrans();
            try
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("LogID", DataID));
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                da1.DeleteData(condition);

                condition.Clear();
                condition.Add(new SearchField("ParentID", DataID));
                Tb_WorkLogReadersDA da2 = new Tb_WorkLogReadersDA();
                da2.DeleteData(condition);

                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
            }
            return succ;
        }

        /// <summary>
        /// 保存工作日志
        /// </summary>
        /// 
        /// <param name="logid"></param>
        /// <param name="authorid"></param>
        /// <param name="authorName"></param>
        /// <param name="logcontent"></param>
        /// <param name="begdate"></param>
        /// 
        /// <returns></returns>
        public int  SaveWorkLog(
            String logid ,
            String authorid ,
            String authorName,
            String logcontent,
            String begdate)
        {
            int succ = 0;
            JConnect.GetConnect().BeginTrans();
            try
            {
                //1--插入或修改日志
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                JConnect.GetConnect().CommitTrans();
                dic1["logid"] = logid;
                dic1["AddUserID"] = authorid;
                dic1["AddUserName"] = authorName;
                dic1["begdate"] = DateTime.Parse(begdate);
                dic1["logcontent"] = logcontent;
                if (DateTime.Parse(begdate).ToString("yyyy-MM-dd") != DateTime.Now.ToString("yyyy-MM-dd"))
                {
                    dic1["IsBuDeng"] = true;
                }
                else
                {
                    dic1["IsBuDeng"] = false;
                }
                
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("logid", logid));
                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                if (da1.HasData(condition))
                {
                    da1.EditData(condition, dic1);
                }
                else
                {
                    da1.NewData(dic1);
                }

                
                JConnect.GetConnect().CommitTrans();
                succ = 1;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
            }
            return succ;
        }
        /// <summary>
        /// 得到今日工作日志
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public Dictionary<String,object> GetTodayWorkLog(String UserID)
        {
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("AddUserID", UserID));
            condition.Add(new SearchField("begDate=cdate('"+DateTime.Today.ToString("yyyy-MM-dd")+"')","",SearchOperator.UserDefine ));
            Tb_WorkLogDA da1 = new Tb_WorkLogDA();
            da1.TableName = "Tb_WorkLog";
            Dictionary<String, object> dic1 = da1.GetFirstDictionary(condition, "*");
            return dic1;
        }


        /// <summary>
        /// 通过LogID，得到日志的数据
        /// </summary>
        /// <param name="LogID">日志ID</param>
        /// <returns></returns>
        public Dictionary<String, object> GetWorkLogByLogID(String LogID)
        {
            Dictionary<String, object> dic1 = null;
            if (String.IsNullOrEmpty(LogID) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("LogID", LogID));

                Tb_WorkLogDA da1 = new Tb_WorkLogDA();
                da1.TableName = "Tb_WorkLog";

                dic1 = da1.GetFirstDictionary(condition, "*");
            }  
            return dic1;
        }


        /// <summary>
        /// 得到用户的最近工作日志
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public Dictionary<String, object> GetLastWorkLog(String UserID)
        {
            Dictionary<String, object> dic1 = null;
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("AddUserID", UserID));
            Tb_WorkLogDA da1 = new Tb_WorkLogDA();
            da1.TableName = "Tb_WorkLog";

            DataTable dt1 = da1.GetListData(condition, -1, -1, "begDate desc", "*");
            if (dt1.Rows.Count > 0)
            {
                DataRow dr1 = dt1.Rows[0];
                dic1 = new Dictionary<string, object>(StringComparer.CurrentCultureIgnoreCase);
                foreach (DataColumn col in dt1.Columns)
                {
                    dic1[col.ColumnName] = dr1[col.ColumnName];
                }
            }
            return dic1;
        }

        /// <summary>
        /// 得到最近的Log Readers
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public String GetLastLogReaders(String UserID)
        {
            String result = String.Empty;
            Dictionary<String, object> dic1 = this.GetLastWorkLog(UserID);
            if (dic1 != null && dic1.Count>0)
            {
                result = dic1["LogReaderID"].ToString();
            }
            return result;
        }
        #endregion



        #region 静态方法
        /// <summary>
        /// 根据计划编号得到今日的工作内容和其他的工作内容
        /// </summary>
        /// <param name="PlanNum"></param>
        /// <returns></returns>
        public static String GetWorkLogContent(String PlanNum,bool isToday)
        {
            String s1 = String.Empty;
            if (String.IsNullOrEmpty(PlanNum) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("PlanNum", PlanNum));
                condition.Add(new SearchField("AddUserID", WebFrame.FrameLib.UserID));
                if (isToday)
                {
                    condition.Add(new SearchField("begDate=cdate('"+DateTime.Now.ToString("yyyy-MM-dd")+"')","",SearchOperator.UserDefine));
                }
                else
                {
                    condition.Add(new SearchField("begDate<>cdate('" + DateTime.Now.ToString("yyyy-MM-dd") + "')", "", SearchOperator.UserDefine));
                }

                DataTable dt1 = (new Tb_WorkLogBU()).GetListData(condition, -1, -1, "begDate", "*");
                if (dt1 != null)
                {
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        if (s1 == String.Empty)
                        {
                            if (isToday)
                            {
                                s1 = s1 + "\r\n";
                            }
                            else
                            {
                                s1 = s1 + "<br/>";
                            }
                        }

                        if (isToday == false)
                        {
                            s1 = s1 + "(" + DateTime.Parse(dr1["begDate"].ToString()).ToString("MM-dd") + ")&nbsp;&nbsp;";
                        }

                        s1 = s1 + dr1["LogContent"].ToString();

                        if (isToday == false)
                        {
                            s1 = s1 + "【" + dr1["workload"].ToString() + "】";
                        }
                    }
                }

            }

            return s1;
        }

        /// <summary>
        /// 根据计划编号得到所有的工作内容
        /// </summary>
        /// <param name="PlanNum"></param>
        /// <returns></returns>
        public static String GetWorkLogContent(String PlanNum)
        {
            String s1 = String.Empty;
            if (String.IsNullOrEmpty(PlanNum) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("PlanNum", PlanNum));
                condition.Add(new SearchField("AddUserID", WebFrame.FrameLib.UserID));
                

                DataTable dt1 = (new Tb_WorkLogBU()).GetListData(condition, -1, -1, "begDate", "*");
                if (dt1 != null)
                {
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        if (s1 == String.Empty)
                        {
                            s1 = s1 + "<br/>";
                        }

                        s1 = s1 + "(" + DateTime.Parse(dr1["begDate"].ToString()).ToString("MM-dd") + ")&nbsp;&nbsp;";                        
                        s1 = s1 + dr1["LogContent"].ToString();
                        s1 = s1 + "【" + dr1["workload"].ToString() + "】";

                    }
                }

            }

            return s1;
        }


        /// <summary>
        /// 根据计划编号和日期得到工作量
        /// </summary>
        /// <param name="PlanNum"></param>
        /// <param name="isToday"></param>
        /// <returns></returns>
        public static double GetWorkLogLoad(String PlanNum, bool isToday)
        {
            double t1 = 0;

            String s1 = String.Empty;
            if (String.IsNullOrEmpty(PlanNum) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("PlanNum", PlanNum));
                condition.Add(new SearchField("AddUserID", WebFrame.FrameLib.UserID));
                if (isToday)
                {
                    condition.Add(new SearchField("begDate=cdate('" + DateTime.Now.ToString("yyyy-MM-dd") + "')", "", SearchOperator.UserDefine));
                }
                else
                {
                    condition.Add(new SearchField("begDate<>cdate('" + DateTime.Now.ToString("yyyy-MM-dd") + "')", "", SearchOperator.UserDefine));
                }

                DataTable dt1 = (new Tb_WorkLogBU()).GetListData(condition, -1, -1, "begDate", "*");
                if (dt1 != null)
                {
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        t1 = t1 + double.Parse(dr1["WorkLoad"].ToString());
                    }
                }

            }

            return t1;
        }


        /// <summary>
        /// 得到所有的今日工作
        /// </summary>
        /// <param name="PlanNum"></param>
        /// <returns></returns>
        public static double GetWorkLogLoad(String PlanNum)
        {
            double t1 = 0;

            String s1 = String.Empty;
            if (String.IsNullOrEmpty(PlanNum) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("PlanNum", PlanNum));
                condition.Add(new SearchField("AddUserID", WebFrame.FrameLib.UserID));
               
                DataTable dt1 = (new Tb_WorkLogBU()).GetListData(condition, -1, -1, "begDate", "*");
                if (dt1 != null)
                {
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        t1 = t1 + double.Parse(dr1["WorkLoad"].ToString());
                    }
                }
            }
            return t1;
        }
        #endregion

        #region 私有方法
        #endregion
    }
}
