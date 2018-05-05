<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Second.Master"
    AutoEventWireup="true" Inherits="WebFrame.Designer.ExecuteSqlBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
     开发平台 ＞＞SQL语句执行器
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 80%">
        <tr>
            <td class="Caption2" style="vertical-align: top; padding-top: 5px">
                请输入要执行的SQL语句：<br /><br />
                <span id="info" style="font-weight:normal">（多条语句之间使用分号分隔）</span>
                
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="sqlText" runat="server" TextMode="MultiLine" Width="75%" Height="300"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnSubmit" runat="server" Text="执行SQL语句" OnClientClick="return confirm('提示：确定要提交吗？');" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    &nbsp;
</asp:Content>
