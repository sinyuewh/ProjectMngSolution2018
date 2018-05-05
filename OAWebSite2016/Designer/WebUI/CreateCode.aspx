<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Designer/include/Second.Master"
    Inherits="WebFrame.Designer.CreateCodeBU" %>

<script runat="server">
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
        //新增或编辑数据
        function selectTableList() {
            var url1 = "SelectTable.aspx?parentID=<%=this.TableNameList.ClientID %>";
            var title = "选择表名( 仅支持SQL SERVER和Oracle )";
            AlertMsg(url1, title, 850, 550, true, 75);
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    开发平台 ＞＞代码生成器
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
            <td class="Caption2">
                管理目录：
            </td>
            <td class="Data2">
                <jasp:JManageDirDropDownList ID="managedir" runat="server">
                </jasp:JManageDirDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                数据实体层根目录：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="DDLDir" runat="server" Width="550"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                数据操作层根目录：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="DALDir" runat="server" Width="550"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                业务操作层根目录：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="BULDir" runat="server" Width="550"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                UI界面层根目录：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="WEDDir" runat="server" Width="550"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2" style="vertical-align: top; padding-top: 5px">
                表名列表（多个用逗号分隔）：
            </td>
            <td class="Data2" style="padding-bottom: 5px; padding-top: 5px; vertical-align: top">
                <jasp:JTextBox ID="TableNameList" runat="server" TextMode="MultiLine" Width="550"
                    Height="150"></jasp:JTextBox>
                <div style="display: inline; vertical-align: top;">
                    &nbsp;<a onclick="javascript:selectTableList();" class="blue" href="#">[选择表名]</a></div>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                生成的代码类型：
            </td>
            <td class="Data2">
                <jasp:JDropDownList ID="codekind" runat="server">
                    <asp:ListItem Text="数据实体层代码" Value="0"></asp:ListItem>
                    <asp:ListItem Text="数据操作层代码" Value="1"></asp:ListItem>
                    <asp:ListItem Text="业务操作层代码" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Web界面层-List页面" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Web界面层-Detail页面(2列)" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Web界面层-Detail页面(4列)" Value="6"></asp:ListItem>
                </jasp:JDropDownList>
                &nbsp;
                <asp:CheckBox ID="singlePage" runat="server" Visible="false" /><%-- 单页面--%>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="butSetDir" runat="server" Text="设置" Visible="false" />&nbsp;&nbsp;
                <asp:Button ID="butSaveDir" runat="server" Text="保存路径" />&nbsp;&nbsp;
                <asp:Button ID="btnSubmit" runat="server" Text="创建代码" ForeColor="Red" OnClientClick="return confirm('提示：确定要提交吗？');" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    &nbsp;
</asp:Content>
