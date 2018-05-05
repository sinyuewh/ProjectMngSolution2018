using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using WebFrame.Comm;
using System.Data;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class JItem_SetItemValues : System.Web.UI.Page
    {
        JBill bill1 = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                JItemDetailBU bu1 = new JItemDetailBU();
                DataTable dt1 = bu1.GetItemDetailByItemName(Request.QueryString["Itemname"]);
                this.rep1.DataSource = dt1;
                ViewState["billdata"] = dt1;
                this.rep1.DataBind();
            }
            bill1 = new JBill(ViewState, this.rep1, new String[] { "Num", "ItemText", "ItemValue" });
        }

        protected override void OnInit(EventArgs e)
        {
            this.button1.ServerClick += new EventHandler(button1_ServerClick);
            this.button2.ServerClick += new EventHandler(button2_ServerClick);
            this.rep1.ItemCommand += new RepeaterCommandEventHandler(rep1_ItemCommand);
            base.OnInit(e);
        }

        //Submit data
        void button2_ServerClick(object sender, EventArgs e)
        {
            String itemName = Request.QueryString["Itemname"];
            if (String.IsNullOrEmpty(itemName) == false)
            {
                String errorInfo = bill1.CheckData();
                if (String.IsNullOrEmpty(errorInfo) == false)
                {
                    //JAjax.Alert(errorInfo);
                    UTools.Alert(errorInfo);
                }
                else
                {
                    JItemDetailBU bu2 = new JItemDetailBU();
                    DataTable data = bill1.GetData();
                    String errorinfo = bu2.SaveItemData(itemName, data);
                    if (String.IsNullOrEmpty(errorinfo) == false)
                    {
                        //JAjax.Alert(errorinfo);
                        UTools.Alert(errorinfo);
                    }
                    else
                    {
                        String js1 = "layer.alert('操作成功!',function(index){;";
                        js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                        js1 = js1 + " parent.$('#butSearch').click();";
                        js1 = js1 + " parent.layer.close(index);});";
                        JAjax.ExecuteJS(js1);
                    }
                }
            }
        }

        //New data
        void button1_ServerClick(object sender, EventArgs e)
        {
            DataTable dt1 = bill1.NewRow();
            this.rep1.DataSource = dt1;
            this.rep1.DataBind();
        }

        void rep1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            this.rep1.DataSource = bill1.DeleteRow(int.Parse(e.CommandArgument.ToString()));
            this.rep1.DataBind();
        }
    }
}
