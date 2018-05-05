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

namespace KORWeb.WebSite.Handler
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    public class AutoCompleteSample : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";
            string returnValue = String.Empty;
            String AutoKind = context.Request.QueryString["AutoKind"];
            switch (AutoKind)
            {
                case "SuggestTest":
                    returnValue = this.GetSuggestForAutoComplete(context);
                    break;
                default:
                    break;
            }
            context.Response.Write(returnValue);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        /// <summary>
        /// 自动完成下拉列表数据Demo
        /// </summary>
        /// <param name="sname"></param>
        /// <returns></returns>
        private string GetSuggestForAutoComplete(HttpContext context)
        {
            /*
             * 返回数据格式必须是json数据，如下所示，本次重点不是json，不做json转换，使用土办法实现
               { 
                query:'Li', 
                suggestions:['Liberia','Libyan Arab Jamahiriya','Liechtenstein','Lithuania'], 
                data:['LR','LY','LI','LT']
               }
               或者
               {
                "query": "Li",
                "suggestions": ["Liberia", "Libyan Arab Jamahiriya", "Liechtenstein",'Lithuania']
                }
             * */
            String keyWord = context.Request.Params["query"];//获取的属性必须是“query”，这是jquery插件规定的
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            sb.AppendFormat("query:'{0}'", keyWord);
            sb.Append(",");
            /*下面一行中的4个数据一般是通过查询关键子keyWord从数据库中获取,本次则模拟静态数据
             * 本次模拟的是输入关键字‘Li’产生的数据，但本次只是为了做范例，所以无论输入什么关键字，都将在浏览器中显示下面的4个数据
             * */
            sb.Append("suggestions:['张三','李四','王五','赵六','陈七','朱八']");
            //sb.Append(",");
            /*下面一行数据是推荐关键字*/
            //sb.Append("data:['张','李','王','赵','陈','朱']");
            sb.Append("}");
            return sb.ToString();
        }
    }
}
