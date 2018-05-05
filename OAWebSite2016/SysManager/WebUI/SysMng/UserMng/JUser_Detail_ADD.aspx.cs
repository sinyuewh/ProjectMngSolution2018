﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class JUser_Detail_ADD : System.Web.UI.Page
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

            //设置父编码的值

            Control con1 = bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                Dictionary<String,object> dic1= bean1.GetControlValues();
                dic1["AuthorityGroup"] = WebFrame.FrameLib.AuthorityGroup;
                dic1["[PassWord]"] = "123456";
                dic1["LoginCount"] = 0;

                
                if (this.DepartLeader.SelectedValue == "True")
                {
                    dic1["DepartLeader"] = true;
                }
                else
                {
                    dic1["DepartLeader"] = false;
                }
                int succ = bean1.SaveDataToDb(dic1);
               

                //int succ2 = 0;
                //if (succ == 1)
                //{
                //    Dictionary<String, object> dic2 = bean2.GetControlValues();
                //    dic2["AuthorityGroup"] = WebFrame.FrameLib.AuthorityGroup;
                //    succ2 = bean2.SaveDataToDb(dic2);
                //}
                //else
                //{
                //    //throw bean1.MyException;
                //}

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

       
    }
}