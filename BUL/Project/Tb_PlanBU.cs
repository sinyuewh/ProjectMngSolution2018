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
using System.IO;

namespace KORWeb.BUL
{
    /// 说明：Tb_Plan
    /// 编码：王松
    /// 时间：2016/8/11 17:28:28
    public partial  class Tb_PlanBU
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
                Tb_PlanDA da1 = new Tb_PlanDA();
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
        /// 确定周工作计划
        /// </summary>
        /// <param name="planid">周计划ID</param>
        /// <param name="Remark">备注</param>
        /// <returns></returns>
        public bool CheckWeekPlanDetail(String TaskId, String Remark)
        {
            bool succ = false;
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("TaskID", TaskId, SearchFieldType.NumericType));
            condition.Add(new SearchField("WorkCheck", "false", SearchFieldType.NumericType));
            Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
            if (da1.HasData(condition))
            {
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                dic1["WorkCheck"] = true;
                dic1["Remark"] = Remark;
                da1.EditData(condition, dic1);
                succ = true;
            }
            return succ;
        }
        /// <summary>
        /// 得到项目的默认周次
        /// </summary>
        /// <param name="projectGuid"></param>
        /// <returns></returns>
        public int GetProjectDefaultWeek(String projectGuid)
        {
            int result = 1;
            if (String.IsNullOrEmpty(projectGuid) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("parentGuid", projectGuid));
                condition.Add(new SearchField("PlanKind", "2", SearchFieldType.NumericType));
                Dictionary<String, object> dic1 = this.GetFirstDictionary(condition, "max(PlanWeek) as week1");
                if (dic1 != null && dic1.Count > 0)
                {
                    int.TryParse(dic1["week1"].ToString(), out result);
                    if (result == 0)
                    {
                        result = 1;
                    }
                    else
                    {
                        result++;
                    }
                }
            }
            return result;
        }

        /// <summary>
        /// 将数据导入到项目的总体计划
        /// </summary>
        /// <param name="projectGuid"></param>
        /// <param name="t1"></param>
        /// <param name="t2"></param>
        /// <param name="remark"></param>
        /// <param name="AttachFile"></param>
        /// <param name="AttachFilePath"></param>
        /// <param name="list1"></param>
        /// <returns></returns>
        public bool ImportExcelToZTPlan(String projectGuid, DateTime t1, DateTime t2, String remark,
            String AttachFile,String AttachFilePath,
            List<Tb_PlanDetailDD> list1)
        {
            bool succ = false;
            JConnect.GetConnect().BeginTrans();
            try
            {
                Tb_PlanDA da1 = new Tb_PlanDA();

                //提交数据的版本更新
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("parentGuid", projectGuid));
                condition.Add(new SearchField("PlanKind", "0", SearchFieldType.NumericType));
                condition.Add(new SearchField("History", "false", SearchFieldType.NumericType));
                Dictionary<String, object> dic1 = da1.GetFirstDictionary(condition, "*");
                int version = 1;
                if (dic1 != null && dic1.Count > 0)
                {
                    version = int.Parse(dic1["Version"].ToString());
                    version++;
                    dic1.Clear();
                    dic1["History"] = true;
                    da1.EditData(condition, dic1);
                }

                //提交新的版本数据
                String planid=WebFrame.Util.JString.GetUnique32ID();
                dic1.Clear();
                dic1["parentGuid"]=projectGuid;
                dic1["PlanID"] = planid;
                dic1["PlanKind"] = "0";
                dic1["Version"] = version;
                dic1["Remark"] = remark;
                dic1["AddTime"] = DateTime.Now;
                dic1["AddUserID"] = FrameLib.UserID;
                dic1["AddUserName"] = FrameLib.UserName;
                dic1["AttachFile"] = AttachFile;
                dic1["AttachFilePath"] = AttachFilePath;
                dic1["PlanStatus"] = 0;
                dic1["FinishTime"] = DBNull.Value;
                dic1["begTime"] = t1;
                dic1["endTime"] = t2;
                dic1["History"] = false;
                da1.NewData(dic1);

                //提交新的计划明细数据
                Tb_PlanDetailDA da2 = new Tb_PlanDetailDA();
                foreach (Tb_PlanDetailDD d1 in list1)
                {
                    dic1.Clear();
                    dic1["PlanKind"] = d1.PlanKind;
                    dic1["parentGuid"] = projectGuid;
                    dic1["planID"] = planid;
                    dic1["planNum"] = d1.PlanNum;
                    dic1["planTitle"] = d1.PlanTitel;
                    dic1["begTime"] = d1.BegTime;
                    dic1["endTime"] = d1.EndTime;
                    dic1["workload"] = d1.Workload;
                    dic1["keyplan"] = d1.KeyPlan;
                    dic1["remark"] = d1.Remark;
                    dic1["Taskkind"] = "0";
                    dic1["payMemo"] = d1.PayMemo;
                    da2.NewData(dic1);
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


        /// <summary>
        /// 将数据导入项目的月度计划
        /// </summary>
        /// <param name="projectGuid"></param>
        /// <param name="t1"></param>
        /// <param name="t2"></param>
        /// <param name="remark"></param>
        /// <param name="AttachFile"></param>
        /// <param name="AttachFilePath"></param>
        /// <param name="list1"></param>
        /// <returns></returns>
        public bool ImportExcelToMonthPlan(String projectGuid, int year1,int month1, String remark,
           String AttachFile, String AttachFilePath,
           List<Tb_PlanDetailDD> list1)
        {
            bool succ = false;

            JConnect.GetConnect().BeginTrans();
            try
            {
                Tb_PlanDA da1 = new Tb_PlanDA();

                //提交数据的版本更新
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("parentGuid", projectGuid));
                condition.Add(new SearchField("PlanKind", "1", SearchFieldType.NumericType));
                condition.Add(new SearchField("History", "false", SearchFieldType.NumericType));
                Dictionary<String, object> dic1 = da1.GetFirstDictionary(condition, "*");
                int version = 1;
                if (dic1 != null && dic1.Count > 0)
                {
                    version = int.Parse(dic1["Version"].ToString());
                    version++;
                    dic1.Clear();
                    dic1["History"] = true;
                    da1.EditData(condition, dic1);
                }

                //提交新的版本数据
                String planid = WebFrame.Util.JString.GetUnique32ID();
                dic1.Clear();
                dic1["parentGuid"] = projectGuid;
                dic1["PlanID"] = planid;
                dic1["PlanKind"] = "1";
                dic1["Version"] = version;
                dic1["Remark"] = remark;
                dic1["AddTime"] = DateTime.Now;
                dic1["AddUserID"] = FrameLib.UserID;
                dic1["AddUserName"] = FrameLib.UserName;
                dic1["AttachFile"] = AttachFile;
                dic1["AttachFilePath"] = AttachFilePath;
                dic1["PlanStatus"] = 0;
                dic1["FinishTime"] = DBNull.Value;
                dic1["PlanYear"] = year1;
                dic1["PlanMonth"] = month1;
                dic1["History"] = false;
                da1.NewData(dic1);

                //提交新的计划明细数据
                Tb_PlanDetailDA da2 = new Tb_PlanDetailDA();
                foreach (Tb_PlanDetailDD d1 in list1)
                {
                    dic1.Clear();
                    dic1["PlanKind"] = d1.PlanKind;
                    dic1["parentGuid"] = projectGuid;
                    dic1["planID"] = planid;
                    dic1["planNum"] = d1.PlanNum;
                    dic1["planTitle"] = d1.PlanTitel;
                    dic1["begTime"] = d1.BegTime;
                    dic1["endTime"] = d1.EndTime;
                    dic1["workload"] = d1.Workload;

                    dic1["ExecuteManID"] = d1.ExecuteManID;
                    dic1["ExecuteManName"] = d1.ExecuteManName;

                    dic1["ParentNum"] = d1.ParentNum;

                    dic1["remark"] = d1.Remark;
                    dic1["Taskkind"] = "0";
                    dic1["payMemo"] = d1.PayMemo;
                    da2.NewData(dic1);
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


        /// <summary>
        /// 将计划导入到周计划
        /// </summary>
        /// <param name="projectGuid"></param>
        /// <param name="week1"></param>
        /// <param name="t1"></param>
        /// <param name="t2"></param>
        /// <param name="remark"></param>
        /// <param name="AttachFile"></param>
        /// <param name="AttachFilePath"></param>
        /// <param name="list1"></param>
        /// <returns></returns>
        public bool ImportExcelToWeekPlan(String projectGuid, int week1, DateTime t1, DateTime t2, String remark,
          String AttachFile, String AttachFilePath,
          List<Tb_PlanDetailDD> list1)
        {
            bool succ = false;

            JConnect.GetConnect().BeginTrans();
            try
            {
                Tb_PlanDA da1 = new Tb_PlanDA();

                //提交数据的版本更新
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("parentGuid", projectGuid));
                condition.Add(new SearchField("PlanKind", "2", SearchFieldType.NumericType));
                condition.Add(new SearchField("History", "false", SearchFieldType.NumericType));
                Dictionary<String, object> dic1 = da1.GetFirstDictionary(condition, "*");
                int version = 1;
                if (dic1 != null && dic1.Count > 0)
                {
                    version = int.Parse(dic1["Version"].ToString());
                    version++;
                    dic1.Clear();
                    dic1["History"] = true;
                    da1.EditData(condition, dic1);
                }

                //提交新的版本数据
                String planid = WebFrame.Util.JString.GetUnique32ID();
                dic1.Clear();
                dic1["parentGuid"] = projectGuid;
                dic1["PlanID"] = planid;
                dic1["PlanKind"] = "2";
                dic1["Version"] = version;
                dic1["Remark"] = remark;
                dic1["AddTime"] = DateTime.Now;
                dic1["AddUserID"] = FrameLib.UserID;
                dic1["AddUserName"] = FrameLib.UserName;
                dic1["AttachFile"] = AttachFile;
                dic1["AttachFilePath"] = AttachFilePath;
                dic1["PlanStatus"] = 0;
                dic1["FinishTime"] = DBNull.Value;
                dic1["PlanWeek"] = week1;

                dic1["begTime"] = t1;
                dic1["endTime"] = t2;

                dic1["History"] = false;
                da1.NewData(dic1);

                //提交新的计划明细数据
                Tb_PlanDetailDA da2 = new Tb_PlanDetailDA();
                foreach (Tb_PlanDetailDD d1 in list1)
                {
                    dic1.Clear();
                    dic1["PlanKind"] = d1.PlanKind;
                    dic1["parentGuid"] = projectGuid;
                    dic1["planID"] = planid;
                    dic1["planNum"] = d1.PlanNum;
                    dic1["planTitle"] = d1.PlanTitel;
                    dic1["begTime"] = d1.BegTime;
                    dic1["endTime"] = d1.EndTime;
                    dic1["workload"] = d1.Workload;

                    dic1["ExecuteManID"] = d1.ExecuteManID;
                    dic1["ExecuteManName"] = d1.ExecuteManName;

                    //设置整体计划编号和月计划编号
                    dic1["ParentNum"] = d1.ParentNum;
                    dic1["MonthPlanNum"] = d1.MaonthPlanNum;

                    dic1["remark"] = d1.Remark;
                    dic1["Taskkind"] = "0";
                    dic1["payMemo"] = d1.PayMemo;
                    da2.NewData(dic1);
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


        #endregion

        #region 静态方法
        
        #endregion

        #region 私有方法
        #endregion
    }
}
