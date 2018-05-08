using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Xml.Linq;
using System.Configuration;

namespace KORWeb.BUL
{
    public class MenuXMLBU
    {
        /// <summary>
        /// 得到所有的子模块
        /// </summary>
        /// <returns></returns>
        public DataTable GetChildModel()
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("Caption");
            dt1.Columns.Add("ClassName");
            dt1.Columns.Add("Url");
            dt1.Columns.Add("MenuID");

            String xmlName = ConfigurationManager.AppSettings["FrameMenuPath"];
            if (String.IsNullOrEmpty(xmlName) == false)
            {
                XElement root = XElement.Load(HttpContext.Current.Server.MapPath(xmlName));
                var menuList =
                    from ele in root.Elements("ChildModel")
                    select ele;

                foreach (var item in menuList)
                {
                    if (item.Attribute("Caption") != null
                        && String.IsNullOrEmpty(item.Attribute("Caption").Value) == false)
                    {
                        bool isCanRead = true;
                        

                        if (item.Attribute("visible") != null
                            && String.IsNullOrEmpty(item.Attribute("visible").Value) == false)
                        {
                            String visible = item.Attribute("visible").Value;
                            isCanRead = bool.Parse(visible);
                        }

                        if (isCanRead)
                        {
                            if (item.Attribute("AuthorityID") != null
                                && String.IsNullOrEmpty(item.Attribute("AuthorityID").Value) == false)
                            {
                                String AuthorityID = item.Attribute("AuthorityID").Value;
                                isCanRead = WebFrame.Comm.JAuthorityBU.HasSecurity(AuthorityID);
                                
                            }
                        }

                        if (isCanRead)
                        {
                            if (item.Attribute("RoleID") != null
                                && String.IsNullOrEmpty(item.Attribute("RoleID").Value) == false)
                            {
                                String RoleID = item.Attribute("RoleID").Value;
                                isCanRead = WebFrame.Comm.JSecurity.HasRoles(RoleID);

                            }
                        }

                        if (isCanRead)
                        {
                            DataRow dr1 = dt1.NewRow();
                            dr1["Caption"] = item.Attribute("Caption").Value;
                            dr1["MenuID"] = item.Attribute("MenuID").Value;
                            

                            if(item.Attribute("ClassName")!=null
                                && String.IsNullOrEmpty(item.Attribute("ClassName").Value)==false)
                            {
                                dr1["ClassName"]=item.Attribute("ClassName").Value;
                            }
                            else
                            {
                                dr1["ClassName"]="nav-info";
                            }
                            dt1.Rows.Add(dr1);
                        }
                    }
                }
            }

            return dt1;
        }


        /// <summary>
        /// 根据子模块得到子菜单
        /// </summary>
        /// <param name="CaptionName"></param>
        /// <returns></returns>
        public DataTable GetChildMenu(String CaptionName)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("Caption");
            dt1.Columns.Add("ClassName");
            dt1.Columns.Add("Url");

            if (String.IsNullOrEmpty(CaptionName) == false)
            {
                String xmlName = ConfigurationManager.AppSettings["FrameMenuPath"];
                if (String.IsNullOrEmpty(xmlName) == false)
                {
                    XElement root = XElement.Load(HttpContext.Current.Server.MapPath(xmlName));
                    var menuList =
                        from ele in root.Elements("ChildModel")
                        from ele2 in ele.Elements("ChildMenu")
                        where ele.Attribute("Caption").Value == CaptionName
                        select ele2;

                    foreach (var item in menuList)
                    {
                        bool isCanRead = true;

                        if (item.Attribute("visible") != null
                            && String.IsNullOrEmpty(item.Attribute("visible").Value) == false)
                        {
                            String visible = item.Attribute("visible").Value;
                            isCanRead = bool.Parse(visible);
                        }

                        if (isCanRead)
                        {
                            if (item.Attribute("AuthorityID") != null
                                && String.IsNullOrEmpty(item.Attribute("AuthorityID").Value) == false)
                            {
                                String AuthorityID = item.Attribute("AuthorityID").Value;
                                isCanRead = WebFrame.Comm.JAuthorityBU.HasSecurity(AuthorityID);
                            }
                        }

                        if (isCanRead)
                        {
                            if (item.Attribute("RoleID") != null
                                && String.IsNullOrEmpty(item.Attribute("RoleID").Value) == false)
                            {
                                String RoleID = item.Attribute("RoleID").Value;
                                isCanRead = WebFrame.Comm.JSecurity.HasRoles(RoleID);

                            }
                        }

                        if (isCanRead)
                        {
                            DataRow dr1 = dt1.NewRow();
                            dr1["Caption"] = item.Attribute("Caption").Value;

                            if (item.Attribute("url") != null
                                && String.IsNullOrEmpty(item.Attribute("url").Value) == false)
                            {
                                dr1["url"] = item.Attribute("url").Value;
                            }
                            dt1.Rows.Add(dr1);
                        }
                    }
                }
            }
            return dt1;
        }


        /// <summary>
        /// 根据子模块得到子菜单
        /// </summary>
        /// <param name="CaptionName"></param>
        /// <returns></returns>
        public DataTable GetChildMenuByMenuID(String MenuID)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("Caption");
            dt1.Columns.Add("ClassName");
            dt1.Columns.Add("Url");
            dt1.Columns.Add("Value");

            if (String.IsNullOrEmpty(MenuID) == false)
            {
                String xmlName = ConfigurationManager.AppSettings["FrameMenuPath"];
                if (String.IsNullOrEmpty(xmlName) == false)
                {
                    XElement root = XElement.Load(HttpContext.Current.Server.MapPath(xmlName));
                    var menuList =
                        from ele in root.Elements("ChildModel")
                        from ele2 in ele.Elements("ChildMenu")
                        where ele.Attribute("MenuID").Value == MenuID
                        select ele2;

                    foreach (var item in menuList)
                    {
                        bool isCanRead = true;

                        //判断visible属性
                        if (item.Attribute("visible") != null
                            && String.IsNullOrEmpty(item.Attribute("visible").Value) == false)
                        {
                            String visible = item.Attribute("visible").Value;
                            isCanRead = bool.Parse(visible);
                        }

                        //判断AuthorityID权限属性
                        if (isCanRead)
                        {
                            if (item.Attribute("AuthorityID") != null
                                && String.IsNullOrEmpty(item.Attribute("AuthorityID").Value) == false)
                            {
                                String AuthorityID = item.Attribute("AuthorityID").Value;
                                isCanRead = WebFrame.Comm.JAuthorityBU.HasSecurity(AuthorityID);
                            }
                        }

                        if (isCanRead)
                        {
                            if (item.Attribute("RoleID") != null
                                && String.IsNullOrEmpty(item.Attribute("RoleID").Value) == false)
                            {
                                String RoleID = item.Attribute("RoleID").Value;
                                isCanRead = WebFrame.Comm.JSecurity.HasRoles(RoleID);

                            }
                        }

                        if (isCanRead)
                        {
                            DataRow dr1 = dt1.NewRow();
                            dr1["Caption"] = item.Attribute("Caption").Value;
                            dr1["Value"] = dr1["Caption"];

                            if (item.Attribute("url") != null
                                && String.IsNullOrEmpty(item.Attribute("url").Value) == false)
                            {
                                dr1["url"] = item.Attribute("url").Value;
                            }

                            if (item.Attribute("Value") != null
                                && String.IsNullOrEmpty(item.Attribute("Value").Value) == false)
                            {
                                dr1["Value"] = item.Attribute("Value").Value;
                            }

                            dt1.Rows.Add(dr1);
                        }
                    }
                }
            }
            return dt1;
        }
    }
}
