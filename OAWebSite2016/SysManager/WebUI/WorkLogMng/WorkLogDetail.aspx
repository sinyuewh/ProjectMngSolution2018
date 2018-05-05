<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="WorkLogDetail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.WorkLogDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="LogID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="AddUserID" runat="server"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            日志日期：</label>
        <div class="formControls col-9">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="begDate" runat="server"
                ReadOnly="true" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            日志作者：</label>
        <div class="formControls col-9">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="AddUserName" runat="server"
                ReadOnly="true" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            日志内容：</label>
        <div class="formControls col-9">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="LogContent" runat="server"
                Caption="日志内容" mydatatype="*10-300" TextMode="MultiLine" Height="350px" />
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
