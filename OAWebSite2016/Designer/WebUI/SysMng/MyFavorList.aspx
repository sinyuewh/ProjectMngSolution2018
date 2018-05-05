<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Designer/include/Second.Master"
    Inherits="WebFrame.SysMng.MyFavorListBU" %>

<%@ Register Src="~/Designer/Controls/MyPageChange.ascx" TagName="MyPageChange"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--此处放置页面的样式和JS-->
    <script language="javascript" type="text/javascript">
        function showUrl(urlText, urlValue) {
            top.frames['dmMain'].addTab(urlText, urlValue);
        }
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    <!--系统导航-->
    系统管理 ＞＞我的快捷列表
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    <!--图标区操作-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserUrl" PageSize="13"
        OrderBy="num">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="urlText" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UserID" ParaName="xx"
                DataName="UserID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--页面的内容-->
    <div style="margin: 5 0 5 5">
        快捷名称：<jasp:JTextBox ID="urlText" runat="server" Width="150" />
         &nbsp;<jasp:JButton ID="butSearch" runat="server" Text="查 询" />
        <div style="display: none">
            <jasp:JButton ID="butSearch1" runat="server" Text="查 询" CssClass="submitButton" /></div>
    </div>
    <table class="ListTable" cellspacing="1" cellpadding="0" onmouseover="changeto()"
        onmouseout="changeback()">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1">
            <HeaderTemplate>
                <tr>
                    <td width="5%" class="Caption">
                        <asp:CheckBox ID="checkAll" runat="server" CssClass="selAllDocument" ToolTip="全部选中或者全部不选中"
                            onclick="selectChildChecked('selDocument',this.checked);" />
                    </td>
                    <td width="10%" class="Caption">
                        序号
                    </td>
                    <td width="15%" class="Caption">
                        快捷名称
                    </td>
                    <td width="35%" class="Caption">
                        快捷链接地址
                    </td>
                    <td width="15%" class="Caption">
                        加入时间
                    </td>
                    <td class="Caption">
                        操作
                    </td>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="Data">
                        <asp:CheckBox ID="selDocument" runat="server" CssClass="selDocument" onclick="selectParentChecked('selAllDocument','selDocument');" />
                    </td>
                    <td class="Data">
                        <%#Eval("num") %>
                    </td>
                    <td class="Data">
                        <%#Eval("UrlText") %>
                    </td>
                    <td class="Data_Left">
                        <a class ="blue" href="javascript:void(0)" id='<%#Eval("UrlValue")%>' onclick="javascript:showUrl('<%#Eval("UrlText") %>','<%#Eval("UrlValue")%>');"
                            target="_self" rel="w_tabs">
                            <%#Eval("UrlValue") %></a>
                    </td>
                    <td class="Data">
                        <%#Eval("AddTime") %>
                    </td>
                    <td class="Data">
                        <asp:LinkButton ID="LinkButton1" CommandArgument='<%#Eval("infoID") %>' CommandName="delete"
                            runat="server" OnClientClick="return confirm('确定删除该数据吗？')">
                            <img  alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" /> 删除</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    <uc1:MyPageChange ID="MyPageChange1" runat="server" PageSize="15" />
</asp:Content>
