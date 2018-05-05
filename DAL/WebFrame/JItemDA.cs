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
    public partial  class JItemDA
    {
        #region 通用的数据DAL
        private const String TableName = "JItem";
        private JConnect daConnect = null;
        
        /// <summary>
        /// 无参数构造函数
        /// </summary>
        public JItemDA()
        {
            this.daConnect = JConnect.GetConnect();
        }
        
        /// <summary>
        /// 带参数构造函数
        /// </summary>
        /// <param name="conn">DA使用的数据库连接</param>
        public JItemDA(JConnect conn)
        {
            this.daConnect = conn;
        }

        /// <summary>
        /// 新增一个实体数据
        /// </summary>
        /// <param name="data1">实体数据</param>
        public void NewData(JItemDD data1)
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
        public void EditData(List<SearchField> condition,JItemDD data1)
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
        public JItemDD GetFirstDataEntity(List<SearchField> condition,params String[] Fields)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            JItemDD data1=tab1.GetFirstDataEntity<JItemDD>(condition, Fields);
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
        #endregion 
        
        #region 用户扩展数据操作方法
        #endregion
    }
}
