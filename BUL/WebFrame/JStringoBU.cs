using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KORWeb.DAL;
using WebFrame.Data;

namespace KORWeb.BUL
{
    /// <summary>
    /// 系统配置
    /// </summary>
    public class JStrInfoBU
    {
        /// <summary>
        /// 删除系统条目
        /// </summary>
        /// <param name="ItemName">条目ID</param>
        /// <returns></returns>
        public bool DeleteData(String strID)
        {
            bool succ = false;
            if (String.IsNullOrEmpty(strID) == false)
            {
                try
                {
                    JStrInfoDA da1 = new JStrInfoDA();
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("StrID", strID));
                    da1.DeleteData(condition);
                    succ = true;

                }
                catch (Exception err)
                {
                    JConnect.GetConnect().RollBackTrans();
                }
            }
            return succ;
        }
    }
}
