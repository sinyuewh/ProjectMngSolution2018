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
    /// 说明：Tb_PL_Month
    /// 编码：超级用户
    /// 时间：2016/10/27 16:48:44
    public partial  class Tb_PL_MonthBU
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
                Tb_PL_MonthDA da1 = new Tb_PL_MonthDA();
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
        /// <param name="YearAndMonth"></param>
        /// <returns></returns>
        public bool CreateMonthKaoHeData(String YearAndMonth,String totalDay,
            String UserID)
        {
            bool succ = false;
            JConnect.GetConnect().BeginTrans();
            try
            {
                double totalday1 = double.Parse(totalDay) * 8;   //表示总的工作量
               
                String[] arr1 = YearAndMonth.Split('-');
                int byear = int.Parse(arr1[0]);
                int bmonth = int.Parse(arr1[1]);

                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("byear", byear + "", SearchFieldType.NumericType));
                condition.Add(new SearchField("bmonth", bmonth + "", SearchFieldType.NumericType));
                if (String.IsNullOrEmpty(UserID) == false)
                {
                    condition.Add(new SearchField("UserID", UserID));
                }

                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                Dictionary<String, object> dic2 = new Dictionary<string, object>();

                //1--清除老数据
                Tb_PL_MonthDA da0 = new Tb_PL_MonthDA();
                da0.DeleteData(condition);
                                
                //2--创建软件开发人员的月度考核数据
                double s1 = 0;
                double w1 = 0;

                Tb_TaskDA da1 = new Tb_TaskDA();
                da1.TableName = "Tb_TaskKHView";
                condition.Clear();
                condition.Add(new SearchField("byear", byear + "", SearchFieldType.NumericType));
                condition.Add(new SearchField("bmonth", bmonth + "", SearchFieldType.NumericType));
                if (String.IsNullOrEmpty(UserID) == false)
                {
                    condition.Add(new SearchField("AddUser", UserID));
                }
                DataTable dt1 = da1.GetListData(condition, -1, -1, "AddUser", "*");
                if (dt1.Rows.Count > 0)
                {
                    String first1 = dt1.Rows[0]["AddUser"].ToString();
                    double workload = 0;
                    double score = 0;
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        if (dr1["AddUser"].ToString() == first1)
                        {
                            workload += double.Parse(dr1["lastWorkload"].ToString());
                            score += double.Parse(dr1["lastWorkload"].ToString()) *
                                   double.Parse(dr1["score"].ToString());
                        }
                        else
                        {
                            //插入新的数据
                            dic1.Clear();
                            dic1["byear"] = byear;
                            dic1["bmonth"] = bmonth;
                            dic1["UserID"] = first1;
                            dic1["UserName"] = KORWeb.BUL.JUserBU.GetUserNamByIDS(dic1["UserID"].ToString());

                            s1 = score / workload;
                            dic1["CheckScore"] =Math.Round(s1);
                            dic1["AddScore"] = 0;
                            dic1["TotalScore"] = dic1["CheckScore"];

                            dic1["TotalWork"] = totalday1;
                            dic1["FactWork"] = workload;
                            w1 = Math.Round(workload/totalday1,2);
                            dic1["WorkRate"] = w1;

                            dic1["CheckResult"] = this.GetKhResult(s1,w1);   
                            da0.NewData(dic1);


                            first1 = dr1["AddUser"].ToString();
                            workload = double.Parse(dr1["lastWorkload"].ToString());
                            score = double.Parse(dr1["lastWorkload"].ToString()) *
                                   double.Parse(dr1["score"].ToString());
                        }
                    }

                    //插入最后一条数据
                    dic1.Clear();
                    dic1["byear"] = byear;
                    dic1["bmonth"] = bmonth;
                    dic1["UserID"] = first1;
                    dic1["UserName"] = KORWeb.BUL.JUserBU.GetUserNamByIDS(dic1["UserID"].ToString());

                    s1 = score / workload;
                    dic1["CheckScore"] = Math.Round(s1);
                    dic1["AddScore"] = 0;
                    dic1["TotalScore"] = dic1["CheckScore"];

                    dic1["TotalWork"] = totalday1;
                    dic1["FactWork"] = workload;
                    w1 = Math.Round(workload / totalday1, 2);
                    dic1["WorkRate"] = w1;

                    dic1["CheckResult"] = this.GetKhResult(s1, w1);
                    da0.NewData(dic1);


                    //3--调整用户的其他加减分
                    Tb_KaoHeOtherDA da3 = new Tb_KaoHeOtherDA();
                    da3.TableName = "Tb_KaoHeOtherTJView";
                    condition.Clear();
                    condition.Add(new SearchField("byear", byear + "", SearchFieldType.NumericType));
                    condition.Add(new SearchField("bmonth", bmonth + "", SearchFieldType.NumericType));
                    if (String.IsNullOrEmpty(UserID) == false)
                    {
                        condition.Add(new SearchField("userid", UserID));
                    }
                    dt1 = da3.GetListData(condition, -1, -1, "userid", "*");

                    double addscore = 0;                            //加减分
                    double totalScore = 0;                          //总分
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        String userid1 = dr1["userid"].ToString();
                        addscore = double.Parse(dr1["addscore"].ToString());  //加减分
                        
                        condition.Clear();
                        condition.Add(new SearchField("byear",byear+"",SearchFieldType.NumericType));
                        condition.Add(new SearchField("bmonth",bmonth+"",SearchFieldType.NumericType));
                        condition.Add(new SearchField("userid",userid1));

                        dic1 = da0.GetFirstDictionary(condition, "*");
                        if (dic1 != null && dic1.Count > 0)
                        {
                            totalScore = double.Parse(dic1["TotalScore"].ToString());
                            totalScore = totalScore + addscore;  //调整总分
                            w1 = double.Parse(dic1["WorkRate"].ToString());

                            //调整数据
                            dic2.Clear();
                            dic2["AddScore"] = addscore;
                            dic2["TotalScore"] = totalScore;
                            dic2["CheckResult"] = this.GetKhResult(totalScore, w1);
                            da0.EditData(condition, dic2);  //更新数据
                        }
                    }
                }

               
                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
            }
            return succ;
        }

        public bool CreateMonthKaoHeData(String YearAndMonth,String totalDay)
        {
            return this.CreateMonthKaoHeData(YearAndMonth,totalDay,String.Empty);
        }


        /// <summary>
        /// 重新计算某天月度考核数据
        /// </summary>
        /// <param name="CheckDataID"></param>
        /// <returns></returns>
        public bool ReCalUerIDMonthKaoHeData(String CheckDataID)
        {
            bool succ = false;
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("CheckDataID", CheckDataID, SearchFieldType.NumericType));
            Dictionary<String, object> dic1 = this.GetFirstDictionary(condition, "*");
            if (dic1 != null && dic1.Count > 0)
            {
                String YearAndMonth = dic1["byear"].ToString() + "-" + dic1["bmonth"].ToString();
                String totalDay = double.Parse(dic1["TotalWork"].ToString()) / 8 + "";
                String userid = dic1["UserID"].ToString();

                succ = this.CreateMonthKaoHeData(YearAndMonth, totalDay, userid);
            }
            return succ;
        }

        /// <summary>
        /// 根据考核成绩得到考核等级
        /// </summary>
        /// <param name="s1"></param>
        /// <returns></returns>
        public String GetKhResult(double s1, double w1)
        {
            String khResult = "C";
            if (w1 >= 0.6)   //工作量定义60%，则直接设置考核级别为C
            {
                if (s1 > 100)
                {
                    khResult = "A+";
                }
                else if (s1 >= 90 && s1 <= 100)
                {
                    khResult = "A";
                }
                else if (s1 >= 70 && s1 <= 89)
                {
                    khResult = "B";
                }
                else
                {
                    khResult = "C";
                }
            }
            return khResult;
        }

        #endregion

        #region 静态方法
        #endregion

        #region 私有方法
        
        #endregion
    }
}
