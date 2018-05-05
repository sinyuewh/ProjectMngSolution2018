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
    /// 说明：Tb_Task
    /// 编码：王松
    /// 时间：2016/8/11 17:28:28
    public partial  class Tb_TaskBU
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
                Tb_TaskDA da1 = new Tb_TaskDA();
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
        /// 从xlsFile中导入数据
        /// </summary>
        /// <param name="xlsFile"></param>
        /// <returns></returns>
        public bool ExportDataFromXls(String parentGuid,String xlsFile,String BigKind)
        {
            bool succ = false;
            try
            {
                JConnect.GetConnect().BeginTrans();
                if (String.IsNullOrEmpty(xlsFile) == false && File.Exists(xlsFile))
                {
                    WebFrame.Util.UExcel u1 = new WebFrame.Util.UExcel();
                    DataTable dt1 = u1.XlsToDataSet(xlsFile).Tables[0];

                    Dictionary<String, object> dic1 =new Dictionary<string,object>();
                   

                    Tb_TaskDA da0 = new Tb_TaskDA();
                    Tb_Task_LogBU bu2 = new Tb_Task_LogBU();
                    
                    foreach (DataRow dr1 in dt1.Rows)
                    {
                        dic1.Clear();
                        dic1["ManagerID"] = WebFrame.FrameLib.UserID;
                        dic1["ManagerName"] = WebFrame.FrameLib.UserName;
                        dic1["AddTime"] = DateTime.Now;
                        dic1["Status"] = "0";
                        dic1["parentGuid"] = parentGuid;
                        dic1["BigKind"] = BigKind;

                        if (BigKind == "0")     //工单
                        {
                            dic1["TaskKind"] = dr1[0].ToString();
                            dic1["TaskTitle"] = dr1[1].ToString();
                            dic1["content"] = dr1[2].ToString();
                            dic1["ImportGrade"] = dr1[3].ToString();
                            dic1["TimeGrade"] = dr1[4].ToString();
                            dic1["PlanDate"] = DateTime.Parse(dr1[5].ToString());
                            dic1["Workload"] = dr1[6].ToString();
                            dic1["GuidID"] = WebFrame.Util.JString.GetUnique32ID();  //得到32位的GuidID的数据

                            if (String.IsNullOrEmpty(dr1[0].ToString()) == false
                                && String.IsNullOrEmpty(dr1[1].ToString()) == false
                                && String.IsNullOrEmpty(dr1[2].ToString()) == false
                                && String.IsNullOrEmpty(dr1[3].ToString()) == false
                                && String.IsNullOrEmpty(dr1[4].ToString()) == false
                                && String.IsNullOrEmpty(dr1[5].ToString()) == false
                                && String.IsNullOrEmpty(dr1[6].ToString()) == false)
                            {
                                da0.NewData(dic1);
                                //插入工单
                                bu2.NewLog(dic1["GuidID"].ToString(), "创建工单", "");
                            }
                        }
                        else                 //BUG工单
                        {
                            dic1["TaskTitle"] = dr1[0].ToString();
                            dic1["SubTitle"] = dr1[1].ToString();

                            dic1["content"] = dr1[2].ToString();
                            dic1["BugKind"] = dr1[3].ToString();

                            dic1["ImportGrade"] = dr1[4].ToString();
                            dic1["TimeGrade"] = dr1[5].ToString();

                            dic1["AddTime"] = DateTime.Parse(dr1[6].ToString());
                            dic1["PlanDate"] = DateTime.Parse(dr1[7].ToString());


                            dic1["Remark"] = dr1[8].ToString();
                            dic1["GuidID"] = WebFrame.Util.JString.GetUnique32ID();  //得到32位的GuidID的数据

                            if (String.IsNullOrEmpty(dr1[0].ToString()) == false
                                && String.IsNullOrEmpty(dr1[2].ToString()) == false
                                && String.IsNullOrEmpty(dr1[3].ToString()) == false
                                && String.IsNullOrEmpty(dr1[4].ToString()) == false
                                && String.IsNullOrEmpty(dr1[6].ToString()) == false
                                && String.IsNullOrEmpty(dr1[7].ToString()) == false)
                            {
                                da0.NewData(dic1);
                                //插入BUG工单
                                bu2.NewLog(dic1["GuidID"].ToString(), "创建BUG工单", "");
                            }
                        }
                    }
                }
                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
                WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                if (String.IsNullOrEmpty(xlsFile) == false && File.Exists(xlsFile))
                {
                    File.Delete(xlsFile);
                }
            }
            return succ;
        }

        public bool ExportDataFromXls(String parentGuid, String xlsFile)
        {
            return this.ExportDataFromXls(parentGuid, xlsFile, "0");
        }

        //插入数据
        private void InsertData1(
                String prNum,
                String content1 ,
                String content2 ,
                String zeren1 ,
                String finish1,
                Tb_TaskDA da0)
        {
            //1--更加prjNum得到项目id
            String prjguid = String.Empty;
            Tb_ProjectDA da1 = new Tb_ProjectDA();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("prjNum", prNum));
            Dictionary<String, object> dic1 = da1.GetFirstDictionary(condition, "GuidID");
            if(dic1!=null && dic1.Count>0 && String.IsNullOrEmpty(dic1["GuidID"].ToString())==false)
            {
                prjguid = dic1["GuidID"].ToString();
            }

            //2--得到项目经理的id
            String prjManager = String.Empty;
            Tb_Project_PersonDA da3 = new Tb_Project_PersonDA();
            dic1.Clear();
            condition.Clear();
            condition.Add(new SearchField("ProjectGuidID", prjguid));
            condition.Add(new SearchField("PrjRole", "0"));
            dic1 = da3.GetFirstDictionary(condition, "PersonID");
            if (dic1 != null && dic1.Count > 0)
            {
                prjManager = dic1["PersonID"].ToString();
            }

            //3--根据责任人的姓名得到责任id
            String zr1 = String.Empty;
            JUserDA da2 = new JUserDA();
            dic1.Clear();
            condition.Clear();
            condition.Add(new SearchField("UserName", zeren1));
            dic1 = da2.GetFirstDictionary(condition, "UserID");
            if (dic1 != null && dic1.Count > 0)
            {
                zr1 = dic1["UserID"].ToString();
            }
            
            //插入数据
            String year1=DateTime.Now.ToString("yyyy");
            String month1=DateTime.Now.ToString("MM");
            if (String.IsNullOrEmpty(prjguid) == false
                && String.IsNullOrEmpty(content1)==false
                && String.IsNullOrEmpty(content2)==false
                && String.IsNullOrEmpty(prjManager)==false
                && String.IsNullOrEmpty(zr1)==false )
            {
                dic1.Clear();
                dic1["ProjectGuidID"] = prjguid;
                DateTime t1 = DateTime.Parse(year1 + "-"+month1 + "-01");
                dic1["begDate"] = t1;

                DateTime t2 = DateTime.Parse(year1 +"-"+finish1.Substring(0,2)+"-"+finish1.Substring(2));
                dic1["endDate"] = t2;

                dic1["Workload"] = ((t2 - t1).Days + 1) * 8;
                dic1["TaskTitle"] = "工作计划";
                dic1["content"] = content1 + "--" + content2;
                dic1["Manager"] = prjManager;
                dic1["Status"] = "1";
                dic1["GuidID"] = WebFrame.Util.JString.GetUnique32ID();
                dic1["AddTime"] = DateTime.Now;
                dic1["AddUser"] = zr1;

                da0.NewData(dic1);
            }

        }


        /// <summary>
        /// 删除派工单，同时删除其中包含的附件
        /// 上传派工单的日志和日志包含的附件
        /// </summary>
        /// <param name="guidid"></param>
        /// <returns></returns>
        public bool DeleteData(String guidid)
        {
            bool succ = false;
            JConnect.GetConnect().BeginTrans();
            try
            {
                //1--删除派工单
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("Guidid", guidid));
                Tb_TaskDA da1 = new Tb_TaskDA();
                DataRow dr1 = da1.GetFirstDataRow(condition, "*");
                if (dr1 != null)
                {
                    //删除相关附件
                    String filename1 = dr1["RelaFile"].ToString();
                    if (String.IsNullOrEmpty(filename1) == false)
                    {
                        filename1 = System.Web.HttpContext.Current.Server.MapPath(filename1);
                        if (File.Exists(filename1))
                        {
                            File.Delete(filename1);
                        }
                    }

                    //删除数据
                    da1.DeleteData(condition);
                }

                //2--删除派工单的日志
                condition.Clear();
                condition.Add(new SearchField("parentGuid", guidid));
                Tb_Task_LogDA da2 = new Tb_Task_LogDA();
                DataTable dt1 = da2.GetListData(condition, -1, -1, "", "*");
                foreach (DataRow dr0 in dt1.Rows)
                {
                    String filename1 = dr0["RelateFile"].ToString();
                    if (String.IsNullOrEmpty(filename1) == false)
                    {
                        filename1 = System.Web.HttpContext.Current.Server.MapPath(filename1);
                        if (File.Exists(filename1))
                        {
                            File.Delete(filename1);
                        }
                    }
                }
                da2.DeleteData(condition);

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

        /// <summary>
        /// 得到满足条件的第一条数据
        /// </summary>
        /// <param name="guidid"></param>
        /// <returns></returns>
        public DataRow GetFirstDataRow(String guidid,String fields)
        {
            Tb_TaskDA da1 = new Tb_TaskDA();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("GuidID", guidid));
            DataRow dr1 = da1.GetFirstDataRow(condition, fields);
            return dr1;
        }

        /// <summary>
        /// 用户接单
        /// </summary>
        /// <param name="guidid"></param>
        /// <returns></returns>
        public bool ReceiveTask(String guidid)
        {
            bool succ = false;
            JConnect.GetConnect().BeginTrans();
            try
            {
                //1--更改工单中的数据
                Dictionary<String, object> dic1 = new Dictionary<string,object>();
                dic1["ExecuteMan"] = FrameLib.UserID;
                dic1["Status"] = "1";
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("GuidID", guidid));
                Tb_TaskDA da1 = new Tb_TaskDA();
                da1.EditData(condition, dic1);
               

                //如操作成功，则插入派工单的日志
                //2--创建工单日志
                (new Tb_Task_LogBU()).NewLog(guidid, FrameLib.UserID+"承接工单", "", "0", null);

                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                JConnect.GetConnect().RollBackTrans();
                succ = false;
            }
            return succ;
        }

        /// <summary>
        /// 提交一个计划
        /// 根据taskid，得到项目的id，设置计划的审核者和状态
        /// </summary>
        /// <param name="GuidID">项目的GuidID</param>
        /// <param name="userid">提交的用户ID</param>
        /// <returns></returns>
        public bool SubmitTask(String GuidID)
        {
            bool succ = false;
            try
            {
                Tb_TaskDA da1 = new Tb_TaskDA();
                List<SearchField> condition = new List<SearchField>();
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                condition.Add(new SearchField("GuidID", GuidID));

                //1--提交工单审核
                dic1["Status"] = "2";
                dic1["CheckDate"] = DateTime.Now;
                da1.EditData(condition, dic1);

                //2--创建日志
                (new Tb_Task_LogBU()).NewLog(GuidID, "提交审核", "");

                succ = true;
            }
            catch (Exception err)
            {
                succ = false;
            }
            return succ;
        }


        /// <summary>
        /// 取消一个工单
        /// </summary>
        /// <param name="GuidID"></param>
        /// <returns></returns>
        public bool CancelTask(String GuidID)
        {
            bool succ = false;
            try
            {
                Tb_TaskDA da1 = new Tb_TaskDA();
                List<SearchField> condition = new List<SearchField>();
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                condition.Add(new SearchField("GuidID", GuidID));

                //1--取消工单
                dic1["Status"] = "9";
                da1.EditData(condition, dic1);
                
                //2--创建日志
                (new Tb_Task_LogBU()).NewLog(GuidID, "取消工单", "");

                succ = true;
            }
            catch (Exception err)
            {
                succ = false;
            }
            return succ;
        }


        /// <summary>
        /// 完成接单的操作
        /// </summary>
        /// <param name="TaskID"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public bool JieDanTask(String GuidIDS, String domanid,String domanName,
            String endDate)
        {
            bool succ = false;
            try
            {
                Tb_TaskDA da1 = new Tb_TaskDA();
                String[] arrs = GuidIDS.Split(',');
                List<SearchField> condition = new List<SearchField>();
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                foreach (String m in arrs)
                {

                    condition.Clear();
                    condition.Add(new SearchField("GuidID", m));

                    //1--接单
                    dic1.Clear();
                    dic1["Status"] = "1";
                    dic1["ExecuteManID"] = domanid;
                    dic1["ExecuteManName"] = domanName;
                    dic1["begDate"] = DateTime.Now;
                    dic1["endDate"] = DateTime.Parse(endDate);
                    da1.EditData(condition, dic1);

                    //2--创建日志
                    (new Tb_Task_LogBU()).NewLog(m, "接单", "计划完成时间：" + endDate);
                }

                succ = true;
            }
            catch (Exception err)
            {
                succ = false;
            }
            return succ;
        }

        public bool JieDanTask(String GuidIDS, 
            String endDate)
        {
            return this.JieDanTask(GuidIDS, WebFrame.FrameLib.UserID, 
                WebFrame.FrameLib.UserName, endDate);
        }

        /// <summary>
        /// 退单
        /// </summary>
        /// <param name="GuidID"></param>
        /// <returns></returns>
        public bool TuiTaskTask(String GuidID)
        {
            bool succ = false;
            try
            {
                Tb_TaskDA da1 = new Tb_TaskDA();
                List<SearchField> condition = new List<SearchField>();
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                condition.Add(new SearchField("GuidID", GuidID));

                //1--退单
                dic1["Status"] = "0";
                dic1["ExecuteManID"] = "";
                dic1["ExecuteManName"] = "";
                dic1["begDate"] = DBNull.Value;
                dic1["endDate"] = DBNull.Value;
                da1.EditData(condition, dic1);

                //2--创建日志
                (new Tb_Task_LogBU()).NewLog(GuidID, "退单","");

                succ = true;
            }
            catch (Exception err)
            {
                succ = false;
            }
            return succ;
        }


        /// <summary>
        /// Complete or not Complete Task
        /// </summary>
        /// <param name="TaskID"></param>
        /// <param name="Flag"></param>
        /// <returns></returns>
        public bool CompleteTask(String GuidID, int Flag,String Remark)
        {
            bool succ = false;
            try
            {
                Tb_TaskDA da1 = new Tb_TaskDA();
                List<SearchField> condition = new List<SearchField>();
                Dictionary<String, object> dic1 = new Dictionary<string, object>();
                condition.Add(new SearchField("GuidID", GuidID));

                String title = "工单完成";
                //1--退单
                if (Flag == 1)
                {
                    dic1["Status"] = "3";
                    dic1["finishDate"] = DateTime.Now;  //完成审核时间
                }
                else if (Flag == 2)                    //退回重改
                {
                    dic1["Status"] = "1";
                    title = "工单退回重改，退回说明："+Remark;
                }
                else
                {
                    dic1["Status"] = "4";
                    dic1["finishDate"] = DateTime.Now;  //完成审核时间
                    title = "工单失败";
                }
                da1.EditData(condition, dic1);

                //2--创建日志       
                (new Tb_Task_LogBU()).NewLog(GuidID, "审核工单", title);

                succ = true;
            }
            catch (Exception err)
            {
                succ = false;
            }
            return succ;
        }

        /// <summary>
        /// 得到当前用户未完成工单的数量
        /// </summary>
        /// <returns></returns>
        public int GetNoCompleteTaskCount(String BigKind)
        {
            int result = 0;
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("BigKind", BigKind));
            condition.Add(new SearchField("Status='1' or Status='2'", "", SearchOperator.UserDefine));
            condition.Add(new SearchField("ExecuteManID", FrameLib.UserID));
            Dictionary<String, object> dic1 = this.GetFirstDictionary(condition, "count(*) as count1");
            if (dic1 != null && dic1.Count > 0)
            {
                int.TryParse(dic1["count1"].ToString(), out result);
            }
            return result;
        }

        public int GetNoCompleteTaskCount()
        {
            return this.GetNoCompleteTaskCount("0");
        }


        /// <summary>
        /// 提交考核数据
        /// </summary>
        /// <param name="GuidID"></param>
        /// <param name="workload"></param>
        /// <param name="score"></param>
        /// <returns></returns>
        public bool SubmitKaoHeData(String GuidID, int workload, int score)
        {
            bool succ = false;
            try
            {
                Tb_TaskDA da1 = new Tb_TaskDA();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("GuidID", GuidID));
                Dictionary<String,object> dic1=new Dictionary<string,object>();

                dic1["Status"] = "3";
                dic1["CheckDate"] = DateTime.Now;
                dic1["Score"] = score;
                dic1["LastWorkLoad"] = workload;

                da1.EditData(condition, dic1);
                succ = true;

            }
            catch (Exception err)
            {
                succ = false;
            }
            return succ;
        }

        #endregion

        #region 静态方法
        /// <summary>
        /// 根据工单的ID,得到其附件列表
        /// </summary>
        /// <param name="Guidid"></param>
        /// <returns></returns>
        public static String GetAttachmengList(String Guidid)
        {
            //判断用户对数据能否进行维护
            bool IsCanEdit = false;
            List<SearchField> condition = new List<SearchField>();
            //得到工单的数据
            condition.Add(new SearchField("Guidid", Guidid));
            Dictionary<String, object> dic1 = (new Tb_TaskDA()).GetFirstDictionary(condition, "*");
            if (dic1 != null && dic1.Count>0)
            {
                String Status1 = dic1["Status"].ToString();
                String ExecuteManID = dic1["ExecuteManID"].ToString();
                String parentGuid = dic1["parentGuid"].ToString();

                //未派单，进行中，审核中 （已完成、未完成和已作废）
                if(Status1=="0"|| Status1=="1" || Status1=="2")
                {
                    if (ExecuteManID == WebFrame.FrameLib.UserID)
                    {
                        IsCanEdit = true;
                    }
                    else
                    {
                        IsCanEdit = (new Tb_ProjectBU()).IsCanEditProjectByProjectNum(parentGuid, WebFrame.FrameLib.UserID);
                    }
                }
            }
            
            //得到附件列表
            String result = String.Empty;         
            JAttachmentDA da1 = new JAttachmentDA();
            condition.Clear();
            condition.Add(new SearchField("parentGuid", Guidid));
            DataTable dt1 = da1.GetListData(condition, -1, -1, "UploadTime", "*");
            bool first = true;
            String temp1 = "<a title='上传时间{2},点击打开' href='#' onclick='javascript:openFile(\"{0}\",\"{1}\")'>{1}</a> ";
            if (IsCanEdit)
            {
                // temp1 = temp1 + "<a title='删除附件' onclick='javascript:deleteFile(\"{2}\")' href='#'><img src='/images/Frame/del.gif' width='16' height='16' border='0' /></a>";
            }


            foreach (DataRow dr1 in dt1.Rows)
            {
                if (first)
                {
                    result = String.Format(temp1, dr1["EncryptFileName"].ToString(), dr1["FileName"].ToString(), dr1["UploadTime"]);
                    first = false;
                }
                else
                {
                    result = result + "<br/>";
                    result = result + String.Format(temp1, dr1["EncryptFileName"].ToString(), dr1["FileName"].ToString(), dr1["UploadTime"]);
                }
            }

            if (IsCanEdit)
            {
                if (String.IsNullOrEmpty(result))
                {
                    result = String.Format("<a href='#' onclick='UploadAttachmentFile(\"{0}\")'>上传附件</a>", Guidid);
                }
                else
                {
                    result = result + "<br/>" + String.Format("<a href='#' onclick='UploadAttachmentFile(\"{0}\")'>上传附件</a>", Guidid);
                }
            }

            return result;
        }



        /// <summary>
        /// 得到最新的工单日志跟踪列表
        /// </summary>
        /// <param name="Guidid"></param>
        /// <returns></returns>
        public static String GetNewTrackInfo(String Guidid)
        {
            String result = String.Empty;

            return result;
        }
        #endregion

        #region 私有方法
        #endregion
    }
}
