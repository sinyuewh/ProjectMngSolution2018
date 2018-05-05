using System;
using System.Net;
using System.IO;
using System.Text;

namespace OAWebSite2016.SysManager.WebUI.PubLib
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //KORWeb.BUL.Tb_KH_MonthBU bu1 = new KORWeb.BUL.Tb_KH_MonthBU();
            //bu1.CreateMonthKHData(2016, 8, 22);
            //System.Net.HttpWebRequest request1 = new System.Net.HttpWebRequest();
            if (!Page.IsPostBack)
            {
                String a = GetUrl("http://192.168.10.36:8888/GetPos.aspx");
                Response.Write(a);
            }
        }


        public static string GetUrl(string url)
        {
            System.GC.Collect();
            string result = "";

            HttpWebRequest request = null;
            HttpWebResponse response = null;

            //请求url以获取数据
            try
            {
                //设置最大连接数
                ServicePointManager.DefaultConnectionLimit = 200;
                //设置https验证方式
                
                /***************************************************************
                * 下面设置HttpWebRequest的相关属性
                * ************************************************************/
                request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";

                //设置代理
                //WebProxy proxy = new WebProxy();
                //proxy.Address = new Uri(WxPayConfig.PROXY_URL);
                //request.Proxy = proxy;

                //获取服务器返回
                response = (HttpWebResponse)request.GetResponse();

                //获取HTTP返回数据
                StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                result = sr.ReadToEnd().Trim();
                sr.Close();
            }
            catch (System.Threading.ThreadAbortException e)
            {
               System.Threading.Thread.ResetAbort();
            }
            
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                //关闭连接和流
                if (response != null)
                {
                    response.Close();
                }
                if (request != null)
                {
                    request.Abort();
                }
            }
            return result;
        }
    }
}
