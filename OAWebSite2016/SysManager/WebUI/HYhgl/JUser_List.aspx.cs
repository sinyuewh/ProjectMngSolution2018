using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;
using WebFrame.Data;
using WebFrame;

namespace KORWeb.WebSite.admin29241310
{
    public partial class JUser_List : System.Web.UI.Page 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(KORWeb.WebSite.admin29241310.JUser_List));
            string ai = FrameLib.AuthorityID;
            if (ai != "A1")
            {
                UserID.Text = FrameLib.UserID;
            }
        }


        //调用后台的方法
        [AjaxPro.AjaxMethod]
        public bool DeleteData(String seldata)
        {
            bool succ = false;
            //JUserBU bu1 = new JUserBU();
            //succ=bu1.DeleteData(seldata);
            succ= WebFrame.Data.DbCommBU.DeleteData("JUser", "UserID", seldata);
            return succ;
        }     
    }
}