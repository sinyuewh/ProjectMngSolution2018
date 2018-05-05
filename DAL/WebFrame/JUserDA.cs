using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using WebFrame;
using WebFrame.Data;
using WebFrame.Util;
using KORWeb.DDL;

namespace KORWeb.DAL
{
    /// 说明：数据操作类
    /// 编码：jsj
    /// 时间：2013-8-2 14:54:49
    public partial  class JUserDA
    {
        #region 通用的数据DAL
        private const String TableName = "JUser";
        private JConnect daConnect = null;
        
        /// <summary>
        /// 无参数构造函数
        /// </summary>
        public JUserDA()
        {
            this.daConnect = JConnect.GetConnect();
        }
        
        /// <summary>
        /// 带参数构造函数
        /// </summary>
        /// <param name="conn">DA使用的数据库连接</param>
        public JUserDA(JConnect conn)
        {
            this.daConnect = conn;
        }

        /// <summary>
        /// 新增一个实体数据
        /// </summary>
        /// <param name="data1">实体数据</param>
        public void NewData(JUserDD data1)
        {
             JTable tab1 = new JTable(daConnect,TableName);
             tab1.InsertData(data1);
             tab1.Close();
        }
        
        /// <summary>
        /// 新增一条数据
        /// </summary>
        /// <param name="data1">Dictionary数据</param>
        public void NewData(Dictionary<String, object> data1)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.InsertData(data1);
            tab1.Close();
        }
        
         /// <summary>
        /// 新增一条数据
        /// </summary>
        /// <param name="data1"></param>
        public void NewData(DataRow  data1)
        {
            Dictionary<string, object> data2 = FrameLib.GetDictionaryByDataRow(data1);
            NewData(data2);
        }

        /// <summary>
        /// 根据条件删除数据
        /// </summary>
        /// <param name="condition">删除数据条件</param>
        public void DeleteData(List<SearchField> condition)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.DeleteData(condition);
            tab1.Close();
        }

        /// <summary>
        /// 根据条件，修改一个实体数据
        /// </summary>
        /// <param name="condition">修改数据的条件</param>
        /// <param name="data1">新的数据</param>
        public void EditData(List<SearchField> condition,JUserDD data1)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.EditData(data1,condition);
            tab1.Close();
        }
        
        /// <summary>
        /// 根据条件，修改一个数据
        /// </summary>
        /// <param name="condition">修改数据的条件</param>
        /// <param name="data1">新的数据</param>
        public void EditData(List<SearchField> condition, Dictionary<String,object> data1)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.EditData(data1, condition);
            tab1.Close();
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
            int PageSize, int CurPage,String orderBy,
            out int TotalRow,params String[] Fields)
        {
            TotalRow = 0;
            DataTable dt1 = null;
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.PageSize = PageSize;
            if (String.IsNullOrEmpty(orderBy) == false)
            {
                tab1.OrderBy = orderBy;
            }
            dt1=tab1.SearchData(condition, CurPage, Fields).Tables[0];
            TotalRow = tab1.GetTotalRow();          //得到总的数据行
            tab1.Close();
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
        /// 根据条件得到满足的第一个实体
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="Fields">数据字段</param>
        /// <returns>实体数据</returns>
        public JUserDD GetFirstDataEntity(List<SearchField> condition,params String[] Fields)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            JUserDD data1=tab1.GetFirstDataEntity<JUserDD>(condition, Fields);
            tab1.Close();
            return data1;
        }    
        
        /// <summary>
        /// 得到满足条件的第一行数据
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="Fields">数据字段</param>
        /// <returns>满足条件的行</returns>
        public DataRow  GetFirstDataRow(List<SearchField> condition, params String[] Fields)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            DataRow data1 = tab1.GetFirstDataRow(condition, Fields);
            tab1.Close();
            return data1;
        }    
        
        
        /// <summary>
        /// 得到满足条件的第一行数据(返回值为Dictionary)
        /// </summary>
        /// <param name="condition">查询条件</param>
        /// <param name="Fields">数据字段</param>
        /// <returns>Dictionary字典</returns>
        public Dictionary<string, object> GetFirstDictionary(List<SearchField> condition, params String[] Fields)
        {
            DataRow dr = GetFirstDataRow(condition, Fields);
            Dictionary<string, object> data1 = new Dictionary<string, object>(StringComparer.CurrentCultureIgnoreCase);
            if (dr != null)
            {
                foreach (DataColumn col in dr.Table.Columns)
                {
                    data1.Add(col.ColumnName, dr[col.ColumnName]);
                }
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
            JTable tab1 = new JTable(daConnect,TableName);
            bool result = tab1.HasData(condition);
            tab1.Close();
            return result;
        }
               
        /// <summary>
        /// 功能：执行普通的SQL语句
        /// </summary>
        public void ExcuteSql(String sql)
        {
            JCommand command = new JCommand(daConnect);
            command.CommandText = sql;
            command.ExecuteNoQuery();
            command.Close();
        }


        /// <summary>
        /// 功能：执行查询SQL语句
        /// </summary>
        /// <returns>返回结果集</returns>
        public DataTable SearchSql(String sql)
        {
            JCommand command = new JCommand(daConnect);
            command.CommandText = sql;
            DataTable dt1 = command.SearchData(-1).Tables[0];
            command.Close();
            return dt1;
        }
        #endregion 
        
        #region 用户扩展数据操作方法
        /// <summary>
        /// 得到下一个用户的编号
        /// </summary>
        /// <returns></returns>
        public int GetNextNum()
        {
            int num1 = 1;
            JTable tab1 = new JTable(this.daConnect, TableName);
            DataRow dr1 = tab1.GetFirstDataRow(null, "max(num)");
            if (dr1 != null && dr1[0].ToString() != String.Empty)
            {
                num1 = int.Parse(dr1[0].ToString()) + 1;
            }
            return num1;
        }


        /// <summary>
        /// 得到选择用户的Json的数据DataTable
        /// </summary>
        /// <returns></returns>
        public DataTable GetSelectUserEasyUiJsonData(List<String> OldUserID)
        {
            /*
            String sql1 = @"SELECT   OrgID AS id, OrgName AS [text], parent AS parentid,0 as tag,null as state,null as checked
                            FROM      JOrg
                            WHERE   (status = 1) AND EXISTS
                                                (SELECT   1 AS Expr1
                                                 FROM      (JOrgUsers INNER JOIN
                                                                 JUser ON JOrgUsers.UserID = JUser.UserID)
                                                 WHERE   (JOrgUsers.OrgID = JOrg.OrgID) AND (JUser.status = 1))

                            UNION
                            SELECT   JUser_1.UserID AS id, JUser_1.UserName AS [text], JOrgUsers_1.OrgID AS parent,1 as tag,null as state,null as checked
                            FROM      (JUser JUser_1 INNER JOIN
                                            JOrgUsers JOrgUsers_1 ON JUser_1.UserID = JOrgUsers_1.UserID)
                            WHERE   (JUser_1.status = 1)"; */

           String sql1 = @"SELECT   OrgID AS id, OrgName AS [text], parent AS parentid,0 as tag,null as state,null as checked
                            FROM      JOrg
                            WHERE   (status = 1) 

                            UNION
                            SELECT   JUser_1.UserID AS id, JUser_1.UserName AS [text], DepartID AS parent,1 as tag,null as state,null as checked
                            FROM      JUser JUser_1
                            WHERE   (JUser_1.status = 1) and userid<>'admin' ";

            DataTable dt1= this.SearchSql(sql1);
            if (OldUserID.Count > 0)
            {
                foreach (DataRow dr1 in dt1.Rows)
                {
                    if (OldUserID.Contains(dr1["id"].ToString()))
                    {
                        dr1["checked"] = "true";
                    }
                }
            }
            return dt1;
        }
        #endregion
    }
}
