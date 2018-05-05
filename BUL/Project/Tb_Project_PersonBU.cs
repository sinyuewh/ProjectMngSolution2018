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
    /// 说明：Tb_Project_Person
    /// 编码：超级用户
    /// 时间：2016/8/8 14:46:57
    public partial  class Tb_Project_PersonBU
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
                Tb_Project_PersonDA da1 = new Tb_Project_PersonDA();
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
        /// 删除特定的数据
        /// </summary>
        /// <param name="guiidid"></param>
        /// <returns></returns>
        public bool DelProjectPerson(String guiidid)
        {
            bool succ = false;
            try
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("GuidID", guiidid));
                this.DeleteData(condition);
                succ = true;
            }
            catch (Exception err)
            {
                WebFrame.Util.JTool.WriteErrorLog(err.ToString());
            }
            return succ;
        }


        /// <summary>
        /// 得到成员的编号
        /// </summary>
        /// <param name="projectGuid"></param>
        /// <returns></returns>
        public int GetPersonNum(String projectGuid)
        {
            int num1 = 0;
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("parentGuid", projectGuid));
            Dictionary<String,object> dic1= this.GetFirstDictionary(condition, "max(num) as num1");
            if (dic1 != null && dic1.Count > 0 )
            {
                int.TryParse(dic1["num1"].ToString(),out num1);
                if (num1 > 0)
                {
                    num1++;
                }
            }
            if (num1 == 0) num1 = 1;
            return num1;
        }

        /// <summary>
        /// 得到项目组的成员信息
        /// </summary>
        /// <param name="projectGuid"></param>
        /// <returns></returns>
        public String GetPersonInfo(String projectGuid)
        {
            String result = "未设置";
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("parentGuid", projectGuid));
            DataTable dt1 = this.GetListData(condition, -1, -1, "num", "*");
            if (dt1 != null && dt1.Rows.Count > 0)
            {
                result = "{0}等{1}人";
                int count1 = dt1.Rows.Count;
                String prjName = "未安排项目经理";

                //项目角色为1表示是项目经理
                condition.Add(new SearchField("PrjRole", "1"));
                Dictionary<String, object> dic1 = this.GetFirstDictionary(condition, "UserName");
                if (dic1 != null && dic1.Count > 0)
                {
                    prjName = dic1["UserName"].ToString();
                }
                result = String.Format(result, prjName, count1);
            }
            return result;
        }
        #endregion

        #region 静态方法
        #endregion

        #region 私有方法
        #endregion
    }
}
