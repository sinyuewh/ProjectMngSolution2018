using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using KORWeb.BUL;
using WebFrame.Data;
using WebFrame;
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.CheckMng.Handler
{
    public partial class DoAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            KORWeb.BUL.UTools.ClearCache();
            if (!Page.IsPostBack)
            {
                String Action = Request["Action"];
                String KeyID = Request["KeyID"];
                String Result = "failer";

                switch (Action)
                {
                    case "CREATE_Tb_PL_Month":
                        String workday = Request["WorkDay"];
                        Result = this.CreateMonthKaoHeData(KeyID,workday);
                        break;

                    //统计项目的贡献度
                    case "CREATE_ProjectGXDData":
                        Result = this.CreateProjectGXDData(KeyID);
                        break;

                    case "RECAL_Tb_PL_Month":    //重新计算月度考核数据
                        Result = this.ReCalKaoHeData(KeyID);
                        break;

                    case "DEL_Tb_KaoHeOther":    //删除其他的考核流水记录
                        Result = this.DeleteTb_KaoHeOther(KeyID);
                        break;
                    
                    default:
                        break;
                }

                WebFrame.Data.JConnect.CloseConnect();
                //将结果输出
                Response.Write(Result);
                Response.End();
            }
        }

        #region 私有方法
        //操作1--创建月度考核数据
        private String CreateMonthKaoHeData(String DataID,String workday)
        {
            String result = "failer";
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("Tb_PL_Month_ADD"))
            {
                Tb_PL_MonthBU bu2 = new Tb_PL_MonthBU();
                bool succ = bu2.CreateMonthKaoHeData(DataID,workday,String.Empty);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        //操作2--重新计算月度考核数据
        private String ReCalKaoHeData(String DataID)
        {
            String result = "failer";
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("Tb_PL_Month_ADD"))
            {
                Tb_PL_MonthBU bu2 = new Tb_PL_MonthBU();
                bool succ = bu2.ReCalUerIDMonthKaoHeData(DataID);
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        
        //操作4--删除其他的考核流水
        private String DeleteTb_KaoHeOther(String dataid)
        {
            String result = "failer";
            //判断是否有操作的权限
            if (WebFrame.Comm.JAuthorityBU.HasSecurity("Tb_KaoHeOther_DEL"))
            {
                Tb_KaoHeOtherBU bu1 = new Tb_KaoHeOtherBU();
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("num", dataid, SearchFieldType.NumericType));
                bu1.DeleteData(condition);
                bool succ = true;
                if (succ)
                {
                    result = "ok";
                }
            }
            return result;
        }

        #endregion
    }
}
