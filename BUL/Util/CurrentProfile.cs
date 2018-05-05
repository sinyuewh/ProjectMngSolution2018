using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using WebFrame.Util;
using System.IO;
using System.Windows.Forms;

namespace KORWeb.BUL
{
    
    /// <summary>
    /// 设置屏幕的尺寸
    /// </summary>
    public class CurrentProfile
    {
        /// <summary>
        /// 当前的屏幕的宽度
        /// </summary>
        public static int ScreenWidth
        {
            get
            {
                String value1 = JCookie.GetCookieValue("ScreenWidth");
                if (String.IsNullOrEmpty(value1))
                {
                    value1 = Screen.PrimaryScreen.Bounds.Width + "";
                    JCookie.SetCookieValue("ScreenWidth", value1 + "", 30 * 24);
                }
                return int.Parse(value1);
            }
        }

        /// <summary>
        /// 当前屏幕的高度
        /// </summary>
        public static int ScreenHeight
        {
            get
            {
                String value1 = JCookie.GetCookieValue("ScreenHeight");
                if (String.IsNullOrEmpty(value1))
                {
                    value1 = Screen.PrimaryScreen.Bounds.Height + "";
                    JCookie.SetCookieValue("ScreenHeight", value1 + "", 30 * 24);
                }
                return int.Parse(value1);
            }
        }

        /// <summary>
        /// 合适的最大宽度
        /// </summary>
        public static int AvailMaxWidth
        {
            get
            {
                return ScreenWidth - NavigateWidth - 60;
            }
        }


        /// <summary>
        /// 合适的最大高度
        /// </summary>
        public static int AvailMaxHeight
        {
            get
            {
                return ScreenHeight - 350;
            }
        }

        /// <summary>
        /// 左边导航条的宽度
        /// </summary>
        public static int NavigateWidth
        {
            get
            {
                return 200;
            }
        }
    }

}
