using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KORWeb.DAL;
using WebFrame.Data;

namespace KORWeb.BUL
{
    /// <summary>
    /// 系统条目类
    /// </summary>
    public class JItemBU
    {
        /// <summary>
        /// 删除系统条目
        /// </summary>
        /// <param name="ItemName">条目名称</param>
        /// <returns></returns>
        public bool DeleteData(String ItemName)
        {
            bool succ = false;
            if (String.IsNullOrEmpty(ItemName) == false)
            {
                try
                {
                    JConnect.GetConnect().BeginTrans();
                    JItemDA da1 = new JItemDA();
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("ItemName",ItemName));
                    da1.DeleteData(condition);

                    JItemDetailDA da2=new JItemDetailDA();
                    da2.DeleteData(condition);
                    JConnect.GetConnect().CommitTrans();
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
