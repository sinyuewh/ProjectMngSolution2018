using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame.Data;
using System.Data;

namespace KORWeb.BUL
{
    public class CommBU
    {
        /// <summary>
        /// 得到下一个编号
        /// </summary>
        /// <returns></returns>
        public static int  GetNextNum(String TableName,String ColumnName)
        {
            int result = 1;
            JTable tab1=null;
            try
            {
                tab1  = new JTable(TableName);
                DataRow dr1=tab1.GetFirstDataRow(null, "max(" + ColumnName + ") as max1");
                if (dr1 != null && dr1[0].ToString() != String.Empty)
                {
                    int.TryParse(dr1[0].ToString(), out result);
                    result++;
                }
            }
            catch (Exception err)
            {
                result = 1;
            }
            finally
            {
                if (tab1 != null) tab1.Close();
            }

            return result;
        }
    }
}
