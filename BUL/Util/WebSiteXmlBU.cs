using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Web;
using System.Data;
using System.Configuration;

namespace KORWeb.BUL
{
    /// <summary>
    /// 二级菜单的节点信息
    /// </summary>
    public class MenuNode
    {
        public String Btitle {get;private set;}
        public String Etitle{get;private set;}
        public String AdType{get;private set;}

        public DataTable MenuTable{get;private set;}

       
        /// <summary>
        /// 根据菜单的信息设置节点信息
        /// </summary>
        /// <param name="infoid"></param>
        public void SetMenuInfo()
        {
            String infoid = ConfigurationManager.AppSettings["WebMenu"];
            if (String.IsNullOrEmpty(infoid)) infoid = "01";
            XmlDocument xmldoc = null;
            if (HttpContext.Current.Application["WebXmlDocument"] == null)
            {
                String xmlFile = HttpContext.Current.Server.MapPath("~/App_Data/WebSite.xml");
                xmldoc = new XmlDocument();
                xmldoc.Load(xmlFile);

                HttpContext.Current.Application.Lock();
                HttpContext.Current.Application["WebXmlDocument"] = xmldoc;
                HttpContext.Current.Application.UnLock();
            }

            xmldoc = HttpContext.Current.Application["WebXmlDocument"] as XmlDocument;
            //1--读取节点的信息
            XmlNode node1 = xmldoc.SelectSingleNode(String.Format("//WebMenu[@id='{0}']", infoid));
            if (node1 != null)
            {
                this.Btitle = node1.Attributes["Btitle"].Value.Trim();
                this.Etitle = node1.Attributes["Etitle"].Value.Trim();
                this.AdType = node1.Attributes["AdType"].Value.Trim();
            }
            
            //2--读取节点2的信息
            this.MenuTable = new DataTable();
            this.MenuTable.Columns.Add("caption");
            this.MenuTable.Columns.Add("url");
            XmlNodeList list1 = xmldoc.SelectNodes(String.Format("//WebMenu[@id='{0}']/MenuItem", infoid));
            foreach (XmlNode node in list1)
            {
                DataRow dr1 = this.MenuTable.NewRow();
                dr1["caption"] = node.Attributes["caption"].Value.Trim();
                dr1["url"] = node.Attributes["url"].Value.Trim();
                this.MenuTable.Rows.Add(dr1);
            }
        }

        /// <summary>
        /// 得到菜单栏
        /// </summary>
        /// <returns></returns>
        public DataTable GetBigMenu()
        {
            DataTable dt1 = null;
            Dictionary<String, DataTable> SecondMenuList = new Dictionary<string, DataTable>();

            if (HttpContext.Current.Application["BigMenu"] == null)
            {
                dt1 = new DataTable();
                dt1.Columns.Add("Btitle");
                dt1.Columns.Add("Etitle");

                dt1.Columns.Add("URL");
                dt1.Columns.Add("id");
                dt1.PrimaryKey = new DataColumn[] { dt1.Columns["id"]};

                XmlDocument xmldoc = null;
                if (HttpContext.Current.Application["WebXmlDocument"] == null)
                {
                    String xmlFile = HttpContext.Current.Server.MapPath("~/App_Data/WebSite.xml");
                    xmldoc = new XmlDocument();
                    xmldoc.Load(xmlFile);

                    HttpContext.Current.Application.Lock();
                    HttpContext.Current.Application["WebXmlDocument"] = xmldoc;
                    HttpContext.Current.Application.UnLock();
                }


                xmldoc = HttpContext.Current.Application["WebXmlDocument"] as XmlDocument;
                XmlNodeList list1 = xmldoc.SelectNodes("//WebMenu");
                foreach (XmlNode node1 in list1)
                {
                    DataRow dr1 = dt1.NewRow();
                    dr1["Btitle"] = node1.Attributes["Btitle"].Value.Trim();
                    dr1["Etitle"] = node1.Attributes["Etitle"].Value.Trim();
                    dr1["URL"] = node1.Attributes["URL"].Value.Trim();
                    dr1["id"] = node1.Attributes["id"].Value.Trim();
                    dt1.Rows.Add(dr1);

                    //设置二级菜单
                    String id1 = node1.Attributes["id"].Value.Trim();
                    if (String.IsNullOrEmpty(id1) == false)
                    {
                        DataTable dt2 = new DataTable();
                        dt2.Columns.Add("Caption");
                        dt2.Columns.Add("URL");
                        dt2.Columns.Add("ChileMenu");  //增加三级子菜单
                        dt2.Columns.Add("ChileMenu2");  //增加三级页面子菜单


                        XmlNodeList list2 = xmldoc.SelectNodes(String.Format("//WebMenu[@id='{0}']/MenuItem", id1));
                        foreach (XmlNode node in list2)
                        {
                            DataRow dr2 = dt2.NewRow();
                            dr2["caption"] = node.Attributes["caption"].Value.Trim();
                            dr2["url"] = node.Attributes["url"].Value.Trim();
                            

                            //读取三级菜单
                            XmlNodeList list3 = xmldoc.SelectNodes(String.Format("//WebMenu[@id='{0}']/MenuItem[@id='{1}']/ChildMenuItem", id1, node.Attributes["id"].Value.Trim()));
                            if (list3.Count > 0)
                            {
                                StringBuilder str1 = new StringBuilder();
                                StringBuilder str2 = new StringBuilder();

                                str1.Append("<ul>");
                                foreach (XmlNode node3 in list3)
                                {
                                    str1.Append(String.Format("<li><a href='{0}'>{1}</a></li>", node3.Attributes["url"].Value.Trim(), node3.Attributes["caption"].Value.Trim()));
                                    str2.Append(String.Format("<li class='s'><a href='{0}'>{1}</a></li>", node3.Attributes["url"].Value.Trim(), node3.Attributes["caption"].Value.Trim()));
                                }
                                str1.Append("</ul>");
                                dr2["ChileMenu"] = str1.ToString();
                                dr2["ChileMenu2"] = str2.ToString();
                            }
                            dt2.Rows.Add(dr2);
                        }

                        SecondMenuList[id1] = dt2;
                    }
                }

                HttpContext.Current.Application.Lock();
                HttpContext.Current.Application["BigMenu"] = dt1;
                HttpContext.Current.Application["SecondMenuList"] = SecondMenuList;
                HttpContext.Current.Application.UnLock();
            }
            return HttpContext.Current.Application["BigMenu"] as DataTable ;
        }


        /// <summary>
        /// 得到二级菜单列表
        /// </summary>
        /// <returns></returns>
        public Dictionary<String, DataTable> GetSecondMenuList()
        {
            Dictionary<String, DataTable> SecondMenuList = null;
            if (HttpContext.Current.Application["SecondMenuList"] == null)
            {
                this.GetBigMenu();
            }

            SecondMenuList = HttpContext.Current.Application["SecondMenuList"] as Dictionary<String, DataTable>;
            return SecondMenuList;
        }

        /// <summary>
        /// 根据MenuID得到标题
        /// </summary>
        /// <param name="MenuID"></param>
        /// <returns></returns>
        public String GetMenuChineseCaptionByID(String MenuID)
        {
            String result = String.Empty;
            DataTable dt1 = this.GetBigMenu();
            DataRow dr1= dt1.Rows.Find(MenuID);
            if (dr1 != null)
            {
                result = dr1["BTitle"].ToString();
            }
            return result;
        }
    }
}
