<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Second.Master"
Inherits="WebFrame.SysMng.SetRoleUserBU" %>

<%@ Register Src="~/Designer/Controls/MyPageChange.ascx" TagName="MyPageChange"
    TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--此处放置页面的样式和JS-->

    <script src="/Js/PubLib.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            $('table#currentPalace').css({ 'display': 'none' })
        });

        //设置角色用户
        function setRoleUsers(vkind) {
            var url = "{urlaspx}?level=2&parentID={parentID}&oldValue={oldValue}&clickID={clickID}&roleid={roleID}";
            var urlaspx = "";
            var parentID = "";
            var oldValue = "";
            var clickID = "<%=this.butAction.ClientID%>";

            if (vkind == "0") {
                urlaspx = "Select/SelectMulUserID.aspx";
                parentID = "<%=this.u0.ClientID%>";
                oldValue = $('#' + parentID).val();
                $('#<%=this.doAction.ClientID%>').val("0");
            }
            else if (vkind == "1") {
                urlaspx = "Select/SelectMulOrgID.aspx";
                parentID = "<%=this.u1.ClientID%>";
                oldValue = $('#' + parentID).val();
                $('#<%=this.doAction.ClientID%>').val("1");
            }
            else if (vkind == "2") {
                urlaspx = "Select/SelectMulRole.aspx";
                parentID = "<%=this.u2.ClientID%>";
                oldValue = $('#' + parentID).val();
                $('#<%=this.doAction.ClientID%>').val("2");
            }
            else {
            }

            url = url.replace("{urlaspx}", urlaspx).replace("{parentID}", parentID).replace("{oldValue}", oldValue).replace("{clickID}", clickID);
            url = url.replace("{roleID}", '<%=Request.QueryString["roleid"]%>');
            AlertMsg(url, "设置角色用户", 600, 500, true, 50);
            //alert(1);
            //alert(url);
        }
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    <!--系统导航-->
    &nbsp;
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    <!--图标区操作-->
    &nbsp;
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <!--页面的内容-->
    <asp:HiddenField ID="u0" runat="server" />
    <asp:HiddenField ID="u1" runat="server" />
    <asp:HiddenField ID="u2" runat="server" />
    <asp:HiddenField ID="doAction" runat="server" />
    <div style="margin: 5 0 5 5">
        &nbsp;&nbsp;用户标识：<jasp:JTextBox ID="UserID" runat="server" Width="150" />&nbsp;
        用户名称：<jasp:JTextBox ID="UserName" runat="server" Width="150" />&nbsp;
        <jasp:JButton ID="butSearch" runat="server" Text="查 询" />&nbsp;&nbsp;&nbsp;
        <div style="display: none">
            <jasp:JButton ID="butSearch1" runat="server" Text="查 询" CssClass="submitButton" />
            <jasp:JButton ID="butAction" runat="server" Text="操 作" /></div>
        <jasp:JButton ID="butAdd0" runat="server" Text="添加用户" AuthorityID="$$4" OnClientClick="javascript:setRoleUsers(0);return false;" />
        &nbsp;
        <jasp:JButton ID="butAdd1" runat="server" Text="添加部门" AuthorityID="$$4" OnClientClick="javascript:setRoleUsers(1);return false;"
            ToolTip="把某部门作为该角色的用户，表示该部门的所有用户具有该角色的权限" />
        &nbsp;
        <jasp:JButton ID="butAdd2" runat="server" Text="添加子角色" AuthorityID="$$4" OnClientClick="javascript:setRoleUsers(2);return false;"
            ToolTip="把某角色作为该角色的用户，表示该子角色的所有用户具有该角色的权限（只限包含用户和部门的角色，不允许添加有子角色的角色，即不允许角色嵌套）" />
    </div>
    <!--数据源控件使用多表查询-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JRoleUsers" PageSize="13"
        OrderBy="num">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="UserID" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="roleid" />
        </ParaItems>
    </jasp:JDataSource>
    <table class="ListTable" cellspacing="1" cellpadding="0" onmouseover="changeto()"
        onmouseout="changeback()">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1">
            <HeaderTemplate>
                <tr>
                    <td class="Caption">
                        用户标识
                    </td>
                    <td class="Caption">
                        用户名称
                    </td>
                    <td class="Caption">
                        用户类型
                    </td>
                    <td class="Caption">
                        操作
                    </td>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="Data">
                        <%#Eval("UserID") %>
                    </td>
                    <td class="Data">
                        <%#Eval("UserName") %>
                    </td>
                    <td class="Data">
                        <%#Eval("Kind").ToString() == "0" ? "个人" :( Eval("Kind").ToString() == "1" ? "部门":"角色" ) %>
                    </td>
                    <td class="Data">
                        <jasp:JLinkButton ID="LinkButton1" AuthorityID="$$5" CommandArgument=' <%#Eval("ID") %>' CommandName="delete"
                            runat="server" OnClientClick="return confirm('确定删除该数据吗？')" Text='<img  alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除' />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    <uc1:MyPageChange ID="MyPageChange1" runat="server" PageSize="15" />
    <!--页面权限控制-->
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
    </jasp:SecurityPanel>
</asp:Content>