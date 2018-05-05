using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame.Data;
using KORWeb.DAL;
using System.Data;
using System.Web;
using System.IO;

namespace KORWeb.BUL
{
    /// <summary>
    /// 附件处理业务类
    /// 编码：金寿吉
    /// </summary>
    public partial class JAttachmentBU
    {
        public String ErrorMessage { get; set; }

        /// <summary>
        /// 插入一条新的数据
        /// </summary>
        /// <param name="dic1"></param>
        public bool NewData(Dictionary<String, object> dic1)
        {
            bool succ = false;
            try
            {
                JAttachmentDA da1 = new JAttachmentDA();
                da1.NewData(dic1);
                succ = true;
            }
            catch (Exception err)
            {
                this.ErrorMessage = err.Message.Replace("\r", "").Replace("\t", "");
            }
            return succ;
        }

        /// <summary>
        /// 删除附件中的数据
        /// </summary>
        /// <param name="guidID"></param>
        /// <returns></returns>
        public bool DeleteData(String guidID)
        {
            bool succ = false;
            try
            {
                if (String.IsNullOrEmpty(guidID) == false)
                {
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("guidID", guidID));
                    JAttachmentDA da1 = new JAttachmentDA();
                    DataRow dr1 = da1.GetFirstDataRow(condition, "*");
                    if (dr1 != null)
                    {
                        String file1 = dr1["FileDir"].ToString() + dr1["EncryptFileName"].ToString();
                        //删除数据库
                        da1.DeleteData(condition);

                        //删除文件
                        file1 = HttpContext.Current.Server.MapPath(file1);
                        if (File.Exists(file1))
                        {
                            File.Delete(file1);
                        }

                        //删除文件2
                       file1 = dr1["EncryptFileName"].ToString();
                       file1 = HttpContext.Current.Server.MapPath(file1);
                       if (File.Exists(file1))
                       {
                           File.Delete(file1);
                       }
                    }
                }
                succ = true;
            }
            catch (Exception err)
            {
                throw err;
            }
            return succ;
        }

        #region static function
        /// <summary>
        /// 根据ParentGuid得到第一个附件的文件名
        /// </summary>
        /// <param name="ParentGuid"></param>
        /// <returns></returns>
        public static String GetFirstFileName(String ParentGuid)
        {
            String result = String.Empty;
            if (String.IsNullOrEmpty(ParentGuid) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("parentGuid", ParentGuid));
                JAttachmentDA da1 = new JAttachmentDA();
                DataRow dr1 = da1.GetFirstDataRow(condition, "EncryptFileName");
                if (dr1 != null)
                {
                    result = dr1[0].ToString();
                }
            }
            return result;
        }

        /// <summary>
        /// 得到相关的附件数量
        /// </summary>
        /// <param name="ParentGuid"></param>
        /// <returns></returns>
        public static int GetFileCount(String ParentGuid)
        {
            int result = 0;
            if (String.IsNullOrEmpty(ParentGuid) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("ParentGuid", ParentGuid));
                JAttachmentDA da1 = new JAttachmentDA();
                DataRow dr1=da1.GetFirstDataRow(condition,"count(*) as count0");
                if (dr1 != null)
                {
                    result = int.Parse(dr1[0].ToString());
                }
            }
            return result;
        }
        #endregion
    }
}
