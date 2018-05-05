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

namespace KORWeb.WebSite.admin47142725
{
    public partial class JUserLoginLog_List : System.Web.UI.Page 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(KORWeb.WebSite.admin47142725.JUserLoginLog_List));
            string ai = FrameLib.AuthorityID;
            if (ai != "A1") 
            {
                UserID.Text=FrameLib.UserID;
            }
        }


        //调用后台的方法
        [AjaxPro.AjaxMethod]
        public bool DeleteData(String seldata)
        {
            bool succ = false;
            //JUserLoginLogBU bu1 = new JUserLoginLogBU();
            //succ=bu1.DeleteData(seldata);
            succ= WebFrame.Data.DbCommBU.DeleteData("JUserLoginLog", "ID", seldata);
            return succ;
        }     
    }
}