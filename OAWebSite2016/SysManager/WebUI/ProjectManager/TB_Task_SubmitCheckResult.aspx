﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="TB_Task_SubmitCheckResult.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectManager.TB_Task_SubmitCheckResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: none">
        <jasp:JTextBox ID="guidID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="parentGuid" runat="server"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            工单审核结果：</label>
        <div class="formControls col-10">
            <span class="select-box" style="width: 80%">
                <jasp:JDropDownList ID="CheckResult" runat="server" CssClass="select" Caption="工单审核结果">
                    <asp:ListItem Text="通过" Value="1"></asp:ListItem>
                    <asp:ListItem Text="未通过" Value="0"></asp:ListItem>
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            工单最终工作量：</label>
        <div class="formControls col-10">
            <jasp:JTextBox ID="LastWorkload" runat="server" Caption="工单最终工作量" DataType="Numeric"
                 class="input-text" Width="80%"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            补充说明：</label>
        <div class="formControls col-10">
            <jasp:JTextBox ID="Remark" runat="server" Caption="补充说明" class="input-text" TextMode="MultiLine"
                Height="120px" Width="80%"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            附件：</label>
        <div class="formControls col-10">
            <jasp:JFileUpload ID="file1" runat="server" class="input-text" AllowNullValue="false"
                Width="80%" />
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
