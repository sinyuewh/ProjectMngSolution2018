<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Second.Master"
Inherits="WebFrame.SysMng.ChangePassWordBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    <!--系统导航-->
    系统管理 ＞＞修改密码
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <!--页面的内容-->
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 50%">
        <tr>
            <td class="Caption2">
                旧密码:
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="oldPass" TextMode="Password" Caption="旧密码" AllowNullValue="false"
                    runat="server" Width="250" ></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                新密码:
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="pass1" TextMode="Password" Caption="新密码" AllowNullValue="false"
                    runat="server" Width="250"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                再次输入:
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="pass2" TextMode="Password" Caption="再次输入" AllowNullValue="false"
                    EqualControl="pass1" runat="server" Width="250"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="butSubmit" runat="server" Text="提 交" CssClass="btn1" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    &nbsp;
</asp:Content>
