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
    /// 说明：Tb_KH_Month
    /// 编码：金寿吉
    /// 时间：2016/8/27 11:04:49
    public partial  class Tb_KH_MonthBU
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
                Tb_KH_MonthDA da1 = new Tb_KH_MonthDA();
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
        /// 创建月度考核数据
        /// </summary>
        /// <param name="byear">考核年份</param>
        /// <param name="bmonth">考核月份</param>
        /// <param name="khDays">考核工作日</param>
        /// <returns></returns>
        public bool CreateMonthKHData(int byear, 
            int bmonth, 
            double khDays)
        {
            bool succ = false;

            //code、team和test的工作量系数
            double rate1 = double.Parse(WebFrame.Comm.JStrInfoBU.GetStrTextByID("codeRate"));
            double rate2 = double.Parse(WebFrame.Comm.JStrInfoBU.GetStrTextByID("teamRate"));
            double rate3 = double.Parse(WebFrame.Comm.JStrInfoBU.GetStrTextByID("testRate"));

            JConnect.GetConnect().BeginTrans();
            try
            {
                //1--得到考核人员清单
                List<SearchField> condition = new List<SearchField>();
                JUserDA da1 = new JUserDA();
                condition.Add(new SearchField("gw='0' or gw='1' or gw='2'", "", SearchOperator.UserDefine));
                DataTable dt1 = da1.GetListData(condition, -1, -1, "num", "UserID,UserName");

                //2--删除原有的考核数据
                Tb_KH_MonthDA da2 = new Tb_KH_MonthDA();
                condition.Clear();
                condition.Add(new SearchField("byear", byear+"", SearchFieldType.NumericType));
                condition.Add(new SearchField("bmonth", bmonth + "", SearchFieldType.NumericType));
                da2.DeleteData(condition);

                //3--根据考核人员名单形成新的月度考核数据
                DataTable khTable = new DataTable();
                khTable.Columns.Add("userid");
                khTable.Columns.Add("username");
                khTable.Columns.Add("workload1", typeof(double));
                khTable.Columns.Add("workload2", typeof(double));
                khTable.Columns.Add("workload3", typeof(double));
                khTable.PrimaryKey = new DataColumn[] { khTable.Columns["userid"]};
                foreach (DataRow dr1 in dt1.Rows)
                {
                    DataRow khrow = khTable.NewRow();
                    khrow["userid"] = dr1["userid"];
                    khrow["UserName"] = dr1["username"];
                    khrow["workload1"] = 0;     //code
                    khrow["workload2"] = 0;     //team
                    khrow["workload3"] = 0;     //test
                    khTable.Rows.Add(khrow);
                }

                //4--根据月度考核的任务，修改考核数据
                condition.Clear();
                condition.Add(new SearchField("Status", "4"));
                condition.Add(new SearchField("DatePart('yyyy', finishDate)="+byear,"",SearchOperator.UserDefine));
                condition.Add(new SearchField("DatePart('M', finishDate)=" + bmonth, "", SearchOperator.UserDefine));
                Tb_TaskDA da3 = new Tb_TaskDA();
                DataTable dt3 = da3.GetListData(condition, -1, -1, "FinishDate", "*");

                Tb_Task_BugDA da4 = new Tb_Task_BugDA();
                foreach (DataRow dr3 in dt3.Rows)
                {
                    int load1 = int.Parse(dr3["LastWorkLoad"].ToString());
                    String Manager = dr3["Manager"].ToString();
                    String ExecuteMan = dr3["ExecuteMan"].ToString();

                    //得到测试的情况A-3 B-2 C-1
                    Dictionary<String, double> debugDic = da4.GetTaskDebugRate(dr3["Guidid"].ToString());
                    if (debugDic.Count == 0)
                    {
                        debugDic[dr3["TestMan"].ToString()] = 1.0;
                    }

                    //根据不同的人员分配工作量
                    //code
                    DataRow datarow1 = khTable.Rows.Find(ExecuteMan);
                    if (datarow1 != null)
                    {
                        datarow1["workload1"] = double.Parse(datarow1["workload1"].ToString()) + load1;
                    }

                    //team
                    DataRow datarow2 = khTable.Rows.Find(Manager);
                    if (datarow2 != null)
                    {
                        datarow2["workload2"] = double.Parse(datarow2["workload2"].ToString()) + load1;
                    }

                    //test
                    foreach (string m in debugDic.Keys)
                    {
                        DataRow datarow3 = khTable.Rows.Find(m);
                        if (datarow3 != null)
                        {
                            datarow3["workload3"] = double.Parse(datarow3["workload3"].ToString()) + load1*debugDic[m];
                        }

                    }
                }

                //5--将数据写入到月度考核任务表
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                foreach (DataRow dr1 in khTable.Rows)
                {
                    dic1.Clear();
                    dic1["byear"] = byear;
                    dic1["bmonth"] = bmonth;
                    dic1["userid"] = dr1["userid"];
                    dic1["userName"] = dr1["username"];
                    dic1["Fullload"] = khDays * 8;
                    dic1["workload1"] = dr1["workload1"];
                    dic1["workload2"] = dr1["workload2"];
                    dic1["workload3"] = dr1["workload3"];
                    dic1["workload"] = rate1 * double.Parse(dr1["workload1"].ToString()) +
                                     rate2 * double.Parse(dr1["workload2"].ToString()) +
                                     rate3 * double.Parse(dr1["workload3"].ToString());
                    dic1["AddMoney"] = 0;

                    da2.NewData(dic1);
                }

                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
                WebFrame.Util.JTool.WriteErrorLog(err.ToString());
            }
            return succ;
        }
        #endregion

        #region 静态方法
        #endregion

        #region 私有方法
        #endregion
    }
}
