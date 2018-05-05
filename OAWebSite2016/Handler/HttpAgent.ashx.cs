using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Text;
using System.Net;

namespace OAWebSite.Handler
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class HttpAgent : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Cache.SetNoStore();
            context.Response.Clear();

            context.Response.ContentType = "text/plain";
            String url = System.Configuration.ConfigurationManager.AppSettings["LiftInfoURL"];
            if (String.IsNullOrEmpty(url))
            {
                url = "http://61.183.239.46:1080/?token=afec4cfab315da1dcda7ee364999&regNumbers=";
            }
            else
            {
                url = url + "&regNumbers=";
            }
            url = url + context.Request["registercode"];

            String str1 = this.GetHttpData(url);

            if (String.IsNullOrEmpty(str1) == false)
            {
                //str1 = "callback(" + str1 + ")";
            }
            context.Response.Write(str1);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        public string GetHttpData(string Url)
        {
            string sRslt = null;
            StreamReader oStreamRd = null;
            try
            {
                WebRequest oWebRqst = WebRequest.Create(Url);
                WebResponse oWebRps = oWebRqst.GetResponse();

                oStreamRd = new StreamReader(oWebRps.GetResponseStream(), Encoding.GetEncoding("utf-8"));
                sRslt = oStreamRd.ReadToEnd();
                oStreamRd.Close();
            }
            finally
            {
                if (oStreamRd != null)
                {
                    oStreamRd.Dispose();
                }
            }
             
            return sRslt;
        }
    }
}
