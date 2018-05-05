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
    /// 说明：Tb_PlanDetail
    /// 编码：王松
    /// 时间：2016/8/11 17:28:28
    public partial  class Tb_PlanDetailBU
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
                Tb_PlanDetailDA da1 = new Tb_PlanDetailDA();
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
        /// 根据计划文件Excel得到计划明细的数据
        /// </summary>
        /// <param name="f1"></param>
        /// <returns></returns>
        public List<Tb_PlanDetailDD> GetPlanDetailListByExcel(System.Web.UI.WebControls.FileUpload f1,ref String saveFileName)
        {
            List<Tb_PlanDetailDD> list1 = new List<Tb_PlanDetailDD>();
            try
            {
                if (f1.HasFile)
                {
                    System.Web.HttpServerUtility server = System.Web.HttpContext.Current.Server;
                    saveFileName = "/Attachment/Plan/" + WebFrame.Util.JString.GetUnique32ID()
                        + System.IO.Path.GetExtension(f1.FileName);
                    
                    String fname = server.MapPath(saveFileName);
                    UExcel u1 = new UExcel(XlsFormat.Xls2003);
                    f1.SaveAs(fname);
                    DataSet ds1 = u1.XlsToDataSet(fname);
                    DataTable dt1 = ds1.Tables[0];
                    /*
                     分类/编号/计划内容/计划开始时间/计划结束时间/工作量预估（人天）/关键节点/交付物/备注
                     */
                    for (int i = 2; i < dt1.Rows.Count; i++)
                    {
                        if (String.IsNullOrEmpty(dt1.Rows[i][1].ToString()) == false &&
                            String.IsNullOrEmpty(dt1.Rows[i][2].ToString()) == false)
                        {
                            Tb_PlanDetailDD dd1 = new Tb_PlanDetailDD();
                            dd1.PlanKind = dt1.Rows[i][0].ToString();
                            dd1.PlanNum = dt1.Rows[i][1].ToString();
                            dd1.PlanTitel = dt1.Rows[i][2].ToString();
                            dd1.BegTime = DateTime.Parse(dt1.Rows[i][3].ToString());
                            dd1.EndTime = DateTime.Parse(dt1.Rows[i][4].ToString());
                            dd1.Workload = double.Parse(dt1.Rows[i][5].ToString());
                            dd1.KeyPlan = false;
                            if (dt1.Rows[i][6].ToString() != String.Empty)
                            {
                                if (dt1.Rows[i][6].ToString() == "是" || dt1.Rows[i][6].ToString() == "1"
                                    || dt1.Rows[i][6].ToString().ToLower() == "yes" || dt1.Rows[i][6].ToString().ToLower() == "true")
                                {
                                    dd1.KeyPlan = true;
                                }
                            }
                            dd1.PayMemo = dt1.Rows[i][7].ToString();
                            dd1.Remark = dt1.Rows[i][8].ToString();

                            list1.Add(dd1);
                        }
                    }
                }
            }
            catch (Exception err)
            {
                list1.Clear();
            }
            return list1;
        }


        /// <summary>
        /// 根据计划文件Excel得到计划明细的数据
        /// </summary>
        /// <param name="f1"></param>
        /// <returns></returns>
        public List<Tb_PlanDetailDD> GetMonthPlanDetailListByExcel(System.Web.UI.WebControls.FileUpload f1, 
            ref String saveFileName)
        {
            List<Tb_PlanDetailDD> list1 = new List<Tb_PlanDetailDD>();
            try
            {
                if (f1.HasFile)
                {
                    System.Web.HttpServerUtility server = System.Web.HttpContext.Current.Server;
                    saveFileName = "/Attachment/Plan/" + WebFrame.Util.JString.GetUnique32ID()
                        + System.IO.Path.GetExtension(f1.FileName);

                    String fname = server.MapPath(saveFileName);
                    UExcel u1 = new UExcel(XlsFormat.Xls2003);
                    f1.SaveAs(fname);
                    DataSet ds1 = u1.XlsToDataSet(fname);
                    DataTable dt1 = ds1.Tables[0];
                    /*
                     分类/编号/计划内容/计划开始时间/计划结束时间/工作量预估（人天）/责任人/交付物/备注
                     */
                    for (int i = 2; i < dt1.Rows.Count; i++)
                    {
                        if (String.IsNullOrEmpty(dt1.Rows[i][1].ToString()) == false &&
                            String.IsNullOrEmpty(dt1.Rows[i][2].ToString()) == false)
                        {
                            Tb_PlanDetailDD dd1 = new Tb_PlanDetailDD();
                            dd1.PlanKind = dt1.Rows[i][0].ToString();
                            dd1.PlanNum = dt1.Rows[i][1].ToString();
                            dd1.PlanTitel = dt1.Rows[i][2].ToString();
                            dd1.BegTime = DateTime.Parse(dt1.Rows[i][3].ToString());
                            dd1.EndTime = DateTime.Parse(dt1.Rows[i][4].ToString());
                            dd1.Workload = double.Parse(dt1.Rows[i][5].ToString());

                            //设置责任人
                            String zren1 = dt1.Rows[i][6].ToString();
                            String zrenid = KORWeb.BUL.JUserBU.GetUserIDByUserName(zren1);
                            dd1.ExecuteManID = zrenid;
                            dd1.ExecuteManName = zren1;
                                
                            dd1.PayMemo = dt1.Rows[i][7].ToString();
                            dd1.Remark = dt1.Rows[i][8].ToString();

                            dd1.ParentNum = dd1.PlanNum.Substring(0, 3);  //取前3位

                            list1.Add(dd1);
                        }
                    }
                }
            }
            catch (Exception err)
            {
                list1.Clear();
            }
            return list1;
        }


        /// <summary>
        /// 得到周计划的项目明细
        /// </summary>
        /// <param name="f1"></param>
        /// <param name="saveFileName"></param>
        /// <returns></returns>
        public List<Tb_PlanDetailDD> GetWeekPlanDetailListByExcel(System.Web.UI.WebControls.FileUpload f1,
            ref String saveFileName)
        {
            List<Tb_PlanDetailDD> list1 = new List<Tb_PlanDetailDD>();
            try
            {
                if (f1.HasFile)
                {
                    System.Web.HttpServerUtility server = System.Web.HttpContext.Current.Server;
                    saveFileName = "/Attachment/Plan/" + WebFrame.Util.JString.GetUnique32ID()
                        + System.IO.Path.GetExtension(f1.FileName);

                    String fname = server.MapPath(saveFileName);
                    UExcel u1 = new UExcel(XlsFormat.Xls2003);
                    f1.SaveAs(fname);
                    DataSet ds1 = u1.XlsToDataSet(fname);
                    DataTable dt1 = ds1.Tables[0];
                    /*
                     分类/编号/计划内容/计划开始时间/计划结束时间/工作量预估（人天）/责任人/交付物/备注
                     */
                    for (int i = 2; i < dt1.Rows.Count; i++)
                    {
                        if (String.IsNullOrEmpty(dt1.Rows[i][1].ToString()) == false &&
                            String.IsNullOrEmpty(dt1.Rows[i][2].ToString()) == false)
                        {
                            Tb_PlanDetailDD dd1 = new Tb_PlanDetailDD();
                            dd1.PlanKind = dt1.Rows[i][0].ToString();
                            dd1.PlanNum = dt1.Rows[i][1].ToString();
                            dd1.PlanTitel = dt1.Rows[i][2].ToString();
                            dd1.BegTime = DateTime.Parse(dt1.Rows[i][3].ToString());
                            dd1.EndTime = DateTime.Parse(dt1.Rows[i][4].ToString());
                            dd1.Workload = double.Parse(dt1.Rows[i][5].ToString());

                            //设置责任人
                            String zren1 = dt1.Rows[i][6].ToString();
                            String zrenid = KORWeb.BUL.JUserBU.GetUserIDByUserName(zren1);
                            dd1.ExecuteManID = zrenid;
                            dd1.ExecuteManName = zren1;

                            dd1.PayMemo = dt1.Rows[i][7].ToString();
                            dd1.Remark = dt1.Rows[i][8].ToString();

                            dd1.ParentNum = dd1.PlanNum.Substring(0, 3);        //取前3位
                            dd1.MaonthPlanNum =dd1.PlanNum.Substring(0,5);      //取前5位

                            list1.Add(dd1);
                        }
                    }
                }
            }
            catch (Exception err)
            {
                list1.Clear();
            }
            return list1;
        }
        
        #endregion

        #region 静态方法
        
        #endregion

        #region 私有方法
        #endregion
    }
}
