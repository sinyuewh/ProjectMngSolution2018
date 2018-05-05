<%@ Page Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master" AutoEventWireup="true"
    CodeBehind="JLog_Data_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.JLog_Data_Detail"
    Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="/H-ui.admin/lib/jquery/1.9.1/jquery.min.js"></script>

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JLog" FieldsList="*"
        IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="guidID" DataType="NumericType" />
        </ParaItems>
    </jasp:JDataSource>
    <div class="row cl">
        <label class="form-label col-3">
            日志内容：</label>
        <div class="formControls col-6">
            <jasp:JTextBox class="input-text" ID="content" runat="server" TextMode="MultiLine"
                Height="250px" Width="380px" />
        </div>
        <div class="col-3">
        </div>
    </div>
    <div class="row cl">
        <div class="col-9 col-offset-3">
            <jasp:SecurityPanel ID="sec1" runat="server">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </jasp:SecurityPanel>
        </div>
    </div>
</asp:Content>
