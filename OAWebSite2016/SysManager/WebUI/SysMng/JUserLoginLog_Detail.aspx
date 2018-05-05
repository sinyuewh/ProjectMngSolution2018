<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JUserLoginLog_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JUserLoginLog_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="ID" />
        </ParaItems>
    </jasp:JDataSource>
    <div style="display: none">
        <jasp:JLabel ID="ID" runat="server"></jasp:JLabel>
    </div>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="ID,CreateTime,UserID,UserName,Remark"
        TableName="JUserLoginLog" PrimaryKeys="ID" IsAppendData="true" NoSaveControlList="ID" />
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            创建时间：</label>
        <div class="formControls col-5">
            <jasp:JLabel ID="CreateTime" runat="server"></jasp:JLabel>
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            登录用户ID：</label>
        <div class="formControls col-5">
            <jasp:JLabel ID="UserID" runat="server"></jasp:JLabel>
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            登录用户姓名：</label>
        <div class="formControls col-5">
            <jasp:JLabel ID="UserName" runat="server"></jasp:JLabel>
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="Remark" Caption="Remark" Width="300" TextMode="MultiLine" Height="100"
                runat="server" class="input-text"></jasp:JTextBox>
        </div>
        <div class="col-4">
        </div>
    </div>
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="JUserLoginLog_EDIT">
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
        AuthorityID="JUserLoginLog_READ">
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
