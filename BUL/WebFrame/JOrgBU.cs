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
    /// 说明：JOrg
    /// 编码：金寿吉
    /// 时间：2014-12-27 13:52:09
    public partial  class JOrgBU
    {  
        public String ErrorInfo { get; set; }
        
                       
        #region 实例方法
        /// <summary>
        /// 得到满足条件的列表数据
        /// </summary>
        /// <param name="condition"></param>
        /// <returns></returns>
        public DataTable GetDepartTable(List<SearchField> condition,String fields)
        {
            JOrgDA da1 = new JOrgDA();
            DataTable dt1= da1.GetListData(condition, -1, -1, "num", fields);
            return dt1;
        }
        #endregion

        #region 静态方法
        /// <summary>
        /// 根据部门的ID得到部门的Name
        /// </summary>
        /// <param name="OrgID">部门ID</param>
        /// <returns>部门Name</returns>
        public static String GetOrgNameByID(String OrgID)
        {
            String result = String.Empty;
            if (String.IsNullOrEmpty(OrgID) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("OrgID", OrgID));
                JOrgDA da1 = new JOrgDA();
                DataRow dr1 = da1.GetFirstDataRow(condition, "OrgName");
                if (dr1 != null) result = dr1[0].ToString();
            }
            return result;
        }
        #endregion

        #region 私有方法
        #endregion
    }
}
