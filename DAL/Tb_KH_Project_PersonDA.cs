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
    /// ˵����Tb_KH_Project_Person
    /// ���룺�����û�
    /// ʱ�䣺2016/9/4 22:32:12
    public partial  class Tb_KH_Project_PersonDA
    {
        #region ͨ�õ�����DAL
        private String tableName = "Tb_KH_Project_Person";
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }
        
        
        private JConnect daConnect = null;
        
        //ִ�н��������
        private int executeResultCount = -1;
        public int ExecuteResultCount
        {
            get { return this.executeResultCount; }
            private set { this.executeResultCount = value; }
         }
        
        /// <summary>
        /// �޲������캯��
        /// </summary>
        public Tb_KH_Project_PersonDA()
        {
            this.daConnect = JConnect.GetConnect();
        }
        
        /// <summary>
        /// ���������캯��
        /// </summary>
        /// <param name="conn">DAʹ�õ����ݿ�����</param>
        public Tb_KH_Project_PersonDA(JConnect conn)
        {
            this.daConnect = conn;
        }

        /// <summary>
        /// ����һ��ʵ������
        /// </summary>
        /// <param name="data1">ʵ������</param>
        public void NewData(Tb_KH_Project_PersonDD data1)
        {
             JTable tab1 = new JTable(daConnect,TableName);
             tab1.InsertData(data1);
             this.executeResultCount = tab1.ExecuteResultCount;
             tab1.Close();
        }
        
        /// <summary>
        /// ����һ������
        /// </summary>
        /// <param name="data1">Dictionary����</param>
        public void NewData(Dictionary<String, object> data1)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.InsertData(data1);
            this.executeResultCount = tab1.ExecuteResultCount;
            tab1.Close();
        }
        
         /// <summary>
        /// ����һ������
        /// </summary>
        /// <param name="data1"></param>
        public void NewData(DataRow  data1)
        {
            Dictionary<string, object> data2 = FrameLib.GetDictionaryByDataRow(data1);
            NewData(data2);
        }

        /// <summary>
        /// ��������ɾ������
        /// </summary>
        /// <param name="condition">ɾ����������</param>
        public void DeleteData(List<SearchField> condition)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.DeleteData(condition);
            this.executeResultCount = tab1.ExecuteResultCount;
            tab1.Close();
        }

        /// <summary>
        /// �����������޸�һ��ʵ������
        /// </summary>
        /// <param name="condition">�޸����ݵ�����</param>
        /// <param name="data1">�µ�����</param>
        public void EditData(List<SearchField> condition,Tb_KH_Project_PersonDD data1)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.EditData(data1,condition);
            this.executeResultCount = tab1.ExecuteResultCount;
            tab1.Close();
        }
        
        /// <summary>
        /// �����������޸�һ������
        /// </summary>
        /// <param name="condition">�޸����ݵ�����</param>
        /// <param name="data1">�µ�����</param>
        public void EditData(List<SearchField> condition, Dictionary<String,object> data1)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            tab1.EditData(data1, condition);
            this.executeResultCount = tab1.ExecuteResultCount;
            tab1.Close();
        }

        /// <summary>
        /// ���������õ��б�����
        /// </summary>
        /// <param name="condition">��ѯ����</param>
        /// <param name="PageSize">ҳ��С</param>
        /// <param name="CurPage">��ǰҳ</param>
        /// <param name="Fields">�����ֶ�</param>
        /// <param name="orderBy">�������ʽ</param>
        /// <param name="TotalRow">����������</param>
        /// <param name="Fields">Ҫ��ʾ���ֶ�</param>
        /// <returns>�б�����</returns>
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
            this.executeResultCount = tab1.ExecuteResultCount;
            TotalRow = tab1.GetTotalRow();          //�õ��ܵ�������
            tab1.Close();
            return dt1;
        }
        
        //�õ��б�����
        public DataTable GetListData(List<SearchField> condition,
            int PageSize, int CurPage, String orderBy, params String[] Fields)
        {
            int totalRow = 0;
            return this.GetListData(condition, PageSize, CurPage, orderBy, out totalRow, Fields);
        }


        /// <summary>
        /// ���������õ�����ĵ�һ��ʵ��
        /// </summary>
        /// <param name="condition">��ѯ����</param>
        /// <param name="Fields">�����ֶ�</param>
        /// <returns>ʵ������</returns>
        public Tb_KH_Project_PersonDD GetFirstDataEntity(List<SearchField> condition,params String[] Fields)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            Tb_KH_Project_PersonDD data1=tab1.GetFirstDataEntity<Tb_KH_Project_PersonDD>(condition, Fields);
            tab1.Close();
            return data1;
        }    
        
        /// <summary>
        /// �õ����������ĵ�һ������
        /// </summary>
        /// <param name="condition">��ѯ����</param>
        /// <param name="Fields">�����ֶ�</param>
        /// <returns>������������</returns>
        public DataRow  GetFirstDataRow(List<SearchField> condition, params String[] Fields)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            DataRow data1 = tab1.GetFirstDataRow(condition, Fields);
            tab1.Close();
            return data1;
        }    
        
        
        /// <summary>
        /// �õ����������ĵ�һ������(����ֵΪDictionary)
        /// </summary>
        /// <param name="condition">��ѯ����</param>
        /// <param name="Fields">�����ֶ�</param>
        /// <returns>Dictionary�ֵ�</returns>
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
        /// �ж��Ƿ��з�������������
        /// </summary>
        ///<param name="condition">��ѯ����</param>
        /// <returns></returns>
        public bool HasData(List<SearchField> condition)
        {
            JTable tab1 = new JTable(daConnect,TableName);
            bool result = tab1.HasData(condition);
            tab1.Close();
            return result;
        }
               
        /// <summary>
        /// ���ܣ�ִ����ͨ��SQL���
        /// </summary>
        public void ExcuteSql(String sql)
        {
            JCommand command = new JCommand(daConnect);
            command.CommandText = sql;
            command.ExecuteNoQuery();
            command.Close();
        } 
        #endregion 
        
        #region �û���չ���ݲ�������
        /// <summary>
        /// ������Ȩϵ�������¼�����Ŀ�Ĺ��׶�����
        /// </summary>
        /// <param name="DataID"></param>
        /// <returns></returns>
        public bool RecalProjectGXDData(String DataID)
        {
            bool succ = false;

            JConnect.GetConnect().BeginTrans();
            try
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("DataID", DataID,SearchFieldType.NumericType ));
                Tb_KH_Project_PersonDA da1 = new Tb_KH_Project_PersonDA();
                Dictionary<String, object> dic1 = da1.GetFirstDictionary(condition, "*");
                if (dic1 != null && dic1.Count > 0)
                {
                    String ParentID = dic1["ParentID"].ToString();

                    //�õ���Ŀ���ܽ��
                    double hsmoney = 0;
                    Tb_ProjectDA da0 = new Tb_ProjectDA();
                    condition.Clear();
                    condition.Add( new SearchField("GuidID",ParentID));
                    dic1 = da0.GetFirstDictionary(condition, "HSMoney");
                    if (dic1 != null && dic1.Count > 0)
                    {
                        double.TryParse(dic1["HSMoney"].ToString(), out hsmoney);
                    }

                    //�õ���Ŀ�ܵ���Ч������
                    double sumwk = 0;
                    condition.Clear();
                    condition.Add(new SearchField("ParentID", ParentID));
                    DataTable dt = da1.GetListData(condition, -1, -1, "DataID", "*");
                    foreach (DataRow dr1 in dt.Rows)
                    {
                        if (String.IsNullOrEmpty(dr1["factWorkLoad"].ToString()) == false)
                        {
                            sumwk = sumwk + double.Parse(dr1["factWorkLoad"].ToString());
                        }
                    }
                    if (sumwk == 0) sumwk = 1;

                    //�����ĸ�������
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dic1.Clear();
                        DataRow dr1 = dt.Rows[i];
                        double t1 = Math.Round(double.Parse(dr1["factWorkLoad"].ToString()) * 100 / sumwk, 2);
                        dic1["GxRate"] = t1;
                        dic1["GxMoney"] = t1 * hsmoney / 100;
                        condition.Clear();
                        condition.Add(new SearchField("DataID", dr1["DataID"].ToString(), SearchFieldType.NumericType));
                        da1.EditData(condition, dic1);
                    }
                }

                JConnect.GetConnect().CommitTrans();
                succ = true;
            }
            catch (Exception err)
            {
                JConnect.GetConnect().RollBackTrans();
                JTool.WriteErrorLog(err.ToString());
            }

            return succ;
        }
        #endregion
    }
}