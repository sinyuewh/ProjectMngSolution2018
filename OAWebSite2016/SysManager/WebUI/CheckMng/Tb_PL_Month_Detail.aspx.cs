﻿using System;
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
using WebFrame.Util;
using System.Collections.Generic;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tb_PL_Month_Detail : System.Web.UI.Page
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
                    double TotalScore = double.Parse(this.data1.Eval("TotalScore"));
                    double FactWork = double.Parse(this.data1.Eval("FactWork"));
                    double w1 = Math.Round(FactWork / double.Parse(this.TotalWork.Text), 2);
                    dic1["WorkRate"] = w1;
                    Tb_PL_MonthBU bu1 = new Tb_PL_MonthBU();
                    dic1["CheckResult"] = bu1.GetKhResult(TotalScore, w1);

                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("CheckDataID", this.CheckDataID.Text, WebFrame.SearchFieldType.NumericType));
                    dic1.Remove("CheckDataID");
                    bu1.EditData(condition, dic1);
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
