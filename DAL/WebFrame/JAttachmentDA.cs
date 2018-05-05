using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame.Data;
using WebFrame;
using System.Data;
using KORWeb.DDL;
using System.IO;

namespace KORWeb.DAL
{
    public partial class JAttachmentDA
    {
        #region 通用的数据DAL
        private const String TableName = "JATTACHMENT";
        private JConnect daConnect = null;
        
        /// <summary>
        /// 无参数构造函数
        /// </summary>
        public JAttachmentDA()
        {
            this.daConnect = JConnect.GetConnect();
        }
        
        /// <summary>
        /// 带参数构造函数
        /// </summary>
        /// <param name="conn">DA使用的数据库连接</param>
        public JAttachmentDA(JConnect conn)
        {
            this.daConnect = conn;
        }

        /// <summary>
        /// 新增一个实体数据
        /// </summary>
        /// <param name="data1">实体数据</param>
        public void NewData(JAttachmentDD data1)
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
        public void EditData(List<SearchField> condition,JAttachmentDD data1)
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
        public JAttachmentDD GetFirstDataEntity(List<SearchField> condition,params String[] Fields)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            JAttachmentDD data1=tab1.GetFirstDataEntity<JAttachmentDD>(condition, Fields);
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
        public void DeleteDataAndFile(string parentGuid)
        {
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("parentGuid", parentGuid));

            DataTable dt =GetListData(condition, -1, -1, string.Empty, "FileDir,EncryptFileName");
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["FileDir"].ToString() != string.Empty)
                    {
                        File.Delete(System.Web.HttpContext.Current.Server.MapPath(dr["FileDir"].ToString()) + dr["EncryptFileName"].ToString());
                    }
                }
            }

            DeleteData(condition);
        }
        #endregion
    }
}
