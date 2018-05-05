using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using KORWeb.BUL;
using System.Net;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections;
using System.Data;

namespace KORWeb.WebSite
{
    public class Global : System.Web.HttpApplication
    {
        //创建权限访问角色
        protected void Application_Start(object sender, EventArgs e)
        {
           
        }

        

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_EndRequest(object sender, EventArgs e)
        {
           
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        //错误异常日志跟踪
        protected void Application_Error(object sender, EventArgs e)
        {
            Exception err1 = Server.GetLastError();
            WebFrame.Util.JTool.WriteErrorLog(err1.ToString());

            WebFrame.Data.JConnect.CloseConnect();
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}