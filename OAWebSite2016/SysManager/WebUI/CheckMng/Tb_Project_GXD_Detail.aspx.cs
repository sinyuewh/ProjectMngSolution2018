using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Data;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tb_Project_GXD_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据的代码
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            String error = String.Empty;

            Control con1 = bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {

                int succ = 0;
                try
                {
                    Dictionary<String, object> dic1 = bean1.GetControlValues();
                    //调整其他的值
                    dic1["factWorkLoad"] = double.Parse(this.WorkRate.Text) * double.Parse(this.WorkLoad.Text);
                    Tb_KH_Project_PersonBU bu1 = new Tb_KH_Project_PersonBU();

                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("DataID", this.DataID.Text, WebFrame.SearchFieldType.NumericType));
                    dic1.Remove("DataID");
                    bu1.EditData(condition, dic1,this.DataID.Text);

                    
                    succ = 1;
                }
                catch (Exception err)
                { ;}

                if (succ == 1)   //submit succ
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                    js1 = js1 + " parent.$('#butSearch').click();";
                    js1 = js1 + " parent.layer.close(index);});";
                    JAjax.ExecuteJS(js1);
                }
                else
                {
                    UTools.Alert("操作失败，请重试!");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.bean1.SetControlValues();       //填充数据
            }
            base.OnPreRenderComplete(e);
        }
    }
}
