<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JieDanAction.aspx.cs" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.JieDanAction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            接单用户：</label>
        <div class="formControls col-7">
            <span class="select-box" >
                <jasp:JDropDownList ID="ExecuteManID" runat="server" CssClass="select">
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            计划完成：</label>
        <div class="formControls col-7">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="PlanDate" runat="server"
                Caption="计划完成"  onclick="$.calendar();" />
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
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage">
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
