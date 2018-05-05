<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Second.Master"
    AutoEventWireup="true" Inherits="WebFrame.Designer.CommListBU" %>

<%@ Register Src="~/Designer/Controls/MyPageChange.ascx" TagName="MyPageChange"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
        //新增或编辑数据
        function EditData(dataID) {
            var url1 = "JSqlInfo_Detail.aspx";
            var title = "新增SQL字符串";
            if (dataID != "") {
                url1 = url1 + "?SqlID=" + dataID;
                title = "SQL字符串明细";
            }
            AlertMsg(url1, title, 600, 350, true, 75);
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    开发平台 ＞＞SQL字符串
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    <jasp:JHyperLink ID="hyper1" runat="server" NavigateUrl="#" onclick="javascript:return EditData('');"
        Text='<img src="/images/Frame/22.gif" width="14" height="14" border="0" alt="" />&nbsp;新增'></jasp:JHyperLink>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <div style="margin: 10 0 5 5">
        &nbsp;SqlID：<jasp:JTextBox ID="SqlID" runat="server" Width="150" />
        &nbsp;备注：<jasp:JTextBox ID="Remark" runat="server" Width="150" />
        <jasp:JButton ID="butSearch" runat="server" Text="查 询" />
        <div style="display: none">
            <jasp:JButton ID="butSearch1" runat="server" Text="查 询" CssClass="submitButton" /></div>
    </div>
    <!--数据源控件使用多表查询-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JSqlInfo" PageSize="13"
        OrderBy="num">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="SqlID" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Remark" SearchOperator="Contains" />
        </ParaItems>
    </jasp:JDataSource>
    <!--显示数据列表-->
    <table class="ListTable" cellspacing="1" cellpadding="0" onmouseover="changeto()"
        onmouseout="changeback()">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1">
            <HeaderTemplate>
                <tr>
                    <td width="5%" class="Caption">
                        <asp:CheckBox ID="checkAll" runat="server" CssClass="selAllDocument" ToolTip="全部选中或者全部不选中"
                            onclick="selectChildChecked('selDocument',this.checked);" />
                    </td>
                    <td class="Caption">
                        序号
                    </td>
                    <td class="Caption">
                        SqlID
                    </td>
                    <td class="Caption">
                        作者
                    </td>
                    <td class="Caption">
                        备注
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
                        <%#Eval("Num") %>
                    </td>
                    <td class="Data">
                        <%#Eval("SqlID") %>
                    </td>
                    <td class="Data">
                        <%#Eval("Author") %>
                    </td>
                    <td class="Data">
                        <%#Eval("Remark") %>
                    </td>
                    <td class="Data">
                        <a onclick="javascript:return EditData('<%#Eval("SqlID") %>');" href='#'>
                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                        &nbsp;
                        <jasp:JLinkButton ID="LinkButton1" CommandArgument='<%#Eval("SqlID") %>' CommandName="delete"
                            runat="server" OnClientClick="return confirm('确定删除该条数据吗？')" Text='<img  alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除'></jasp:JLinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    <!--用户自定义翻页控件-->
    <uc1:MyPageChange ID="MyPageChange1" runat="server" />
    <!--设置删除的表名和关键字段ID-->
    <jasp:JTextBox ID="TableName" runat="server" Text="JSqlInfo" Visible="false"></jasp:JTextBox>
    <jasp:JTextBox ID="PrimaryKeyID" runat="server" Text="SqlID" Visible="false"></jasp:JTextBox>
    <!--页面权限控制-->
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
