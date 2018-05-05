<%@ Page Language="C#" AutoEventWireup="true"
MasterPageFile="~/SysManager/include/H-uiThird.Master"
 CodeBehind="Tb_Project_Detail_ADD2.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Project_Detail_ADD2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
    <div class="row cl" id="sel1" runat="server">
        <label class="form-label col-3">
            选择项目：</label>
        <div class="formControls col-8">
            <span class="select-box">
                <jasp:AppDropDownList ID="selecProject" runat="server"  CssClass="select"
                   BlankValue="--请选择--" AllowNullValue="false"  Caption="选择项目" >
                </jasp:AppDropDownList>
            </span>
        </div>
       
    </div>
    
   <div class="row cl">
        <label class="form-label col-3">
            计划年月：</label>
        <div class="formControls col-8">
            <span class="select-box" style="width:220px">
                <jasp:AppDropDownList ID="PlanYear" runat="server"  CssClass="select"
                    AllowNullValue="false"   >
                </jasp:AppDropDownList>
            </span> 年 &nbsp;&nbsp;
            <span class="select-box" style="width:220px">
                <jasp:AppDropDownList ID="PlanMonth" runat="server"  CssClass="select"
                    AllowNullValue="false"   >
                </jasp:AppDropDownList>
            </span> 月
        </div>
        
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" TextMode="MultiLine"  Height="200px"
               AllowNullValue="false" ID="Remark" runat="server"
                Caption="计划备注"  />
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            计划内容：</label>
        <div class="formControls col-8">
            <jasp:JFileUpload ID="file1" runat="server" class="input-text" />
        </div>
       
    </div>
    
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server">
        <div class="row cl">
            <div class="col-10 col-offset-2">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    
    <script type="text/javascript">
        $(function() {
            $("#aspnetForm").Validform({
                tiptype: 2,
                callback: function(form) {

                }
            });
        });
    </script>   
</asp:Content>
