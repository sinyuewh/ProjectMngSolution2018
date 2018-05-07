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
    /// 说明：Tb_Project_Log
    /// 编码：超级用户
    /// 时间：2016/8/8 22:58:03
    public partial  class Tb_Project_LogBU
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
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
        /// 得到当前项目的日志数量
        /// </summary>
        /// <param name="projectGuidid"></param>
        /// <returns></returns>
        public static int GetProjectLogCount(String projectGuidid)
        {
            int count1 = 0;
            return count1;
        }

        /// <summary>
        /// 得到相关的附件列表
        /// </summary>
        /// <param name="Guidid"></param>
        /// <returns></returns>
        public static String GetAttachmengList(String Guidid,String projectStatus)
        {
            //判断用户对数据能否进行维护
            bool IsCanManager = false;
            if (projectStatus == "1")
            {
                IsCanManager = IsCanEdit(Guidid);
            }

            String result = String.Empty;
            List<SearchField> condition = new List<SearchField>();
            JAttachmentDA da1 = new JAttachmentDA();
            condition.Clear();
            condition.Add(new SearchField("parentGuid", Guidid));
            DataTable dt1 = da1.GetListData(condition, -1, -1, "UploadTime", "*");
            bool first = true;
            String temp1 = "<a title='打开附件' href='#' onclick='javascript:openFile(\"{0}\",\"{1}\")'>{1}</a> ";
            if (IsCanManager)
            {
               // temp1 = temp1 + "<a title='删除附件' onclick='javascript:deleteFile(\"{2}\")' href='#'><img src='/images/Frame/del.gif' width='16' height='16' border='0' /></a>";
            }


            foreach (DataRow dr1 in dt1.Rows)
            {
                if (first)
                {
                    result = String.Format(temp1, dr1["EncryptFileName"].ToString(), dr1["FileName"].ToString(), dr1["Guidid"].ToString());
                    first = false;
                }
                else
                {
                    result = result + "<br/>";
                    result = result + String.Format(temp1, dr1["EncryptFileName"].ToString(), dr1["FileName"].ToString(), dr1["Guidid"].ToString());
                }
            }

            if (IsCanManager)
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
        /// 判断当前用户能否对数据进行维护
        /// </summary>
        /// <param name="Guidid"></param>
        /// <returns></returns>
        public static bool IsCanEdit(String Guidid)
        {
            bool result = false;
            if (FrameLib.UserID == "admin")
            {
                result = true;
            }
            else
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("guidID", Guidid));
                Tb_Project_LogDA da1 = new Tb_Project_LogDA();
                Dictionary<String,object> dic1= da1.GetFirstDictionary(condition, "*");
                if (dic1 != null && dic1.Count > 0)
                {
                    if (dic1["AddUserID"].ToString() != "admin")
                    {
                        String parentGuid = dic1["parentGuid"].ToString();   //项目编号
                        Tb_ProjectDA da2 = new Tb_ProjectDA();
                        condition.Clear();
                        condition.Add(new SearchField("prjNum", parentGuid));
                        dic1.Clear();
                        dic1 = da2.GetFirstDictionary(condition, "GuidID");
                        if (dic1 != null && dic1.Count > 0)
                        {
                            result =(new Tb_ProjectBU()).IsCanEditProject(dic1["GuidID"].ToString(),WebFrame.FrameLib.UserID);
                        }
                    }
                }
            }
            return result;
        }
        #endregion

        #region 私有方法
        #endregion
    }
}
