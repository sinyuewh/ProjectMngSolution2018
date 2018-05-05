<%@ Page Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master" AutoEventWireup="true" CodeBehind="JLogData_Detail_ADD.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.JLogData_Detail_ADD" Title="无标题页" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript" src="/H-ui.admin/lib/jquery/1.9.1/jquery.min.js"></script>
<script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row cl">
        <label class="form-label col-3">
            记录用户：</label>
        <div class="formControls col-6">
            <jasp:JTextBox ID="uploadPerson" runat="server" class="input-text" Style="width: 375px" ReadOnly="True" />
        </div>
        <div class="col-3">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            内容：</label>
        <div class="formControls col-6">
            <jasp:JTextBox class="input-text" ID="content" runat="server" TextMode="MultiLine"
                Height="350px" Width="380px" />
        </div>
        <div class="col-3">
        </div>
    </div>
    
    <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
</asp:Content>
