using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using WebFrame;
using WebFrame.Data;
using WebFrame.Util;
using KORWeb.BUL;
using WebFrame.Comm;

namespace KORWeb.WebSite.Handler
{
    /// <summary>
    /// AutoComplete 的摘要说明
    /// </summary>
    public class AutoComplete : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";
            string returnValue = String.Empty;
            String AutoKind = context.Request.QueryString["AutoKind"];
            String keyWord=context.Request.Params["query"];
            DataTable dt1 = null;

            switch (AutoKind)
            {
                case "GetUserName":
                    returnValue = this.GetUserNameForAutoComplete(context);
                    break;

                case "GetUserNameLog":
                    returnValue = this.GetUserNameLogForAutoComplete(context);
                    break;

                              

                default:
                    break;
            }

            context.Response.Write(returnValue);
            JConnect.CloseConnect();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        /// <summary>
        /// 通过DataTable填充下拉框框的数据
        /// </summary>
        /// <param name="context">上下文</param>
        /// <param name="dt1">DataTable</param>
        /// <param name="ColName">列名称</param>
        /// <returns></returns>
        private string GetAutoCompleteByDataTable(
            HttpContext context,String keyWord,
            DataTable dt1,String ColName)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            sb.AppendFormat("query:'{0}'", keyWord);
            sb.Append(",");
            /*下面一行中的4个数据一般是通过查询关键子keyWord从数据库中获取,本次则模拟静态数据
             * 本次模拟的是输入关键字‘Li’产生的数据，但本次只是为了做范例，所以无论输入什么关键字，都将在浏览器中显示下面的4个数据
             * */
            String data = String.Empty;
            foreach (DataRow dr1 in dt1.Rows)
            {
                string v = String.Empty;
                if (String.IsNullOrEmpty(ColName))
                {
                    v = dr1[0].ToString();
                }
                else
                {
                    v=dr1[ColName].ToString();
                }

                if (!String.IsNullOrEmpty(v))
                {
                    data += String.Format(",'{0}'", v);
                }
            }
            if (data.StartsWith(","))
            {
                data = data.Substring(1);
            }
            if (String.IsNullOrEmpty(data))
            {
                sb.Append("suggestions:[]");
            }
            else
            {
                sb.AppendFormat("suggestions:[{0}]", data);
            }
            sb.Append("}");
            return sb.ToString();
        }

        /// <summary>
        /// 通过DataTale填充下拉框的数据
        /// </summary>
        /// <param name="context">上下文兑现</param>
        /// <param name="dt1"></param>
        /// <returns></returns>
        private string GetAutoCompleteByDataTable(
          HttpContext context,String KeyWord,
          DataTable dt1)
        {
            return this.GetAutoCompleteByDataTable(context,KeyWord, dt1, String.Empty);
        }


        //得到用户姓名的下拉框
        public string GetUserNameForAutoComplete(HttpContext context)
        {
            String keyWord = context.Request.Params["query"];//获取的属性必须是“query”，这是jquery插件规定的
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            sb.AppendFormat("query:'{0}'", keyWord);
            sb.Append(",");
            /*下面一行中的4个数据一般是通过查询关键子keyWord从数据库中获取,本次则模拟静态数据
             * 本次模拟的是输入关键字‘Li’产生的数据，但本次只是为了做范例，所以无论输入什么关键字，都将在浏览器中显示下面的4个数据
             * */
            String data = String.Empty;
            if (!String.IsNullOrEmpty(keyWord))
            {
                KORWeb.BUL.JUserBU bu1 = new KORWeb.BUL.JUserBU();
                DataTable dt1 = bu1.GetUserName(keyWord, 10);

                foreach (DataRow dr1 in dt1.Rows)
                {
                    string v = dr1[0].ToString();
                    if (!String.IsNullOrEmpty(v))
                    {
                        data += String.Format(",'{0}'", v);
                    }
                }
                if (data.StartsWith(","))
                {
                    data = data.Substring(1);
                }
            }
            if (String.IsNullOrEmpty(data))
            {
                sb.Append("suggestions:[]");
            }
            else
            {
                sb.AppendFormat("suggestions:[{0}]", data);
            }
            sb.Append("}");
            return sb.ToString();

        }


        //得到用户登录日志
        public string GetUserNameLogForAutoComplete(HttpContext context)
        {

            String keyWord = context.Request.Params["query"];//获取的属性必须是“query”，这是jquery插件规定的
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            sb.AppendFormat("query:'{0}'", keyWord);
            sb.Append(",");
            /*下面一行中的4个数据一般是通过查询关键子keyWord从数据库中获取,本次则模拟静态数据
             * 本次模拟的是输入关键字‘Li’产生的数据，但本次只是为了做范例，所以无论输入什么关键字，都将在浏览器中显示下面的4个数据
             * */
            String data = String.Empty;
            if (!String.IsNullOrEmpty(keyWord))
            {
                JUserLoginLogBU bu1 = new JUserLoginLogBU();
                DataTable dt1 = bu1.GetUserName(keyWord, 10);
                foreach (DataRow dr1 in dt1.Rows)
                {
                    string v = dr1[0].ToString();
                    if (!String.IsNullOrEmpty(v))
                    {
                        data += String.Format(",'{0}'", v);
                    }
                }
                if (data.StartsWith(","))
                {
                    data = data.Substring(1);
                }
            }
            if (String.IsNullOrEmpty(data))
            {
                sb.Append("suggestions:[]");
            }
            else
            {
                sb.AppendFormat("suggestions:[{0}]", data);
            }
            sb.Append("}");
            return sb.ToString();
        }

    }
}