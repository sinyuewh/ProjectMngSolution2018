<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="Tb_Project_delay.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_delay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" TableName="JAttachment" PrimaryKeys="guidID"
        IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="guidID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="parentGuid" runat="server"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            预计结束日期：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="endDate" runat="server" AllowNullValue="false"
                Caption="预计结束日期" onclick="$.calendar();" mydatatype="*10-10"  />
        </div>
        
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            延期说明：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="contenttext" TextMode="MultiLine" runat="server"
                Caption="延期说明" Height="160px" mydatatype="*6-100" AllowNullValue="false" />
        </div>
        
    </div>
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server">
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
        >
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
