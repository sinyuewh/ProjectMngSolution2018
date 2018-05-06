using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;
using WebFrame;

namespace OAWebSite2016.Login
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        
        protected override void OnInit(EventArgs e)
        {
            this.but1.Click += new EventHandler(but1_Click);
            base.OnInit(e);
        }

        //submit login
        void but1_Click(object sender, EventArgs e)
        {           
            if (String.IsNullOrEmpty(this.username.Value) == false)
            {
                if (String.IsNullOrEmpty(Request.Form["password"]) == false)
                {
                    JUserBU bu1 = new JUserBU();
                    String userid=String.Empty;
                    String departnum = String.Empty;

                    int succ = bu1.Login(this.username.Value, Request.Form["password"], ref userid,ref departnum);
                    if (succ == 0)
                    {
                        JAjax.AlertAndFocusControl("错误：用户名不存在！", this.username.ClientID);
                    }
                    else if (succ == 1)
                    {
                        JAjax.AlertAndFocusControl("错误：登录密码不正确！", "password");
                    }
                    else if (succ == 2)
                    {
                        JAjax.AlertAndFocusControl("错误：用户名已停用，请联系管理员！", "password");
                    }
                    else
                    {
                        
                        //设置用户的登录
                        WebFrame.FrameLib.Login(userid);

                        JCookie.SetCookieValue("login_userid", this.username.Value);
                        JCookie.SetCookieValue("departnum", departnum);
                        if (this.remember.Checked)
                        {
                            JCookie.SetCookieValue("login_password", Request.Form["password"]);
                            JCookie.SetCookieValue("login_remember", "true");
                        }
                        else
                        {
                            JCookie.SetCookieValue("login_password", "");
                            JCookie.SetCookieValue("login_remember", "");
                        }

                        //设置登录后转向的URL
                        String toUrl = "/SysManager/ManagerIndex.aspx";
                                                

                        if(String.IsNullOrEmpty(toUrl)==false)
                        {
                            Response.Redirect(toUrl, true);
                        }
                    }

                }
                else
                {
                    JAjax.AlertAndFocusControl("错误：请输入登录的密码！", "password");
                }
            }
            else
            {
                JAjax.AlertAndFocusControl("错误：请输入登录的用户名！", this.username.ClientID);
            }
        }

        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Application.RemoveAll();

                this.username.Value = JCookie.GetCookieValue("login_userid");
                if (JCookie.GetCookieValue("login_remember") == "true")
                {
                    this.remember.Checked = true;
                }
            }
        }


        private static byte[] strToToHexByte(string hexString)
        {
            hexString = hexString.Replace(" ", "");
            if ((hexString.Length % 2) != 0)
                hexString += " ";
            byte[] returnBytes = new byte[hexString.Length / 2];
            for (int i = 0; i < returnBytes.Length; i++)
                returnBytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
            return returnBytes;
        }
    }
}
