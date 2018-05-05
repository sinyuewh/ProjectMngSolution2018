<%@ Page Language="C#" AutoEventWireup="true"
MasterPageFile="~/Designer/include/Second.Master"
Inherits="WebFrame.SysMng.JUserLoginLog_ListBU" %>

<%@ Register Src="~/Designer/Controls/MyPageChange.ascx" TagName="MyPageChange"
    TagPrefix="uc1" %>
<%@ Register Assembly="WebFrame" Namespace="WebFrame.ExpControl" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/jquery.autocomplete.js" type="text/javascript"></script>

    <script src="/JS/Tip.js" type="text/javascript"></script>

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        //新增或编辑数据
        function EditData(dataID) {
            var url1 = "JUserLoginLog_Detail.aspx";
            var title = "新增用户登录日志";
            if (dataID != "") {
                url1 = url1 + "?ID=" + dataID;
                title = "用户登录日志明细";
            }
            AlertMsg(url1, title, 600, 350, true, 75);
            return false;
        }

        $(document).ready(function () {
           
            //设置用户姓名的智能选择
            $('#<%=UserName.ClientID %>').autocomplete({
                serviceUrl: '/Handler/AutoComplete.ashx',
                minChars: 1,
                maxHeight: 400,
                params: { "AutoKind": "GetUserNameLog" }
            });
           
           
            
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    系统管理 ＞＞登录日志
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    &nbsp;
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <div style="margin: 10 0 5 5">
        &nbsp;登录用户：<jasp:JTextBox ID="UserName" runat="server" Width="150" />&nbsp; 登录时间：<jasp:JTextBox
            ID="Time0" runat="server" Width="120" onclick="$.calendar();" />
        ～
        <jasp:JTextBox ID="Time1" runat="server" Width="120" onclick="$.calendar();" />
        &nbsp;备注：<jasp:JTextBox ID="Remark" runat="server" Width="150" />
        &nbsp;<jasp:JButton ID="butSearch" runat="server" Text="查 询" />
        <div style="display: none">
            <jasp:JButton ID="butSearch1" runat="server" Text="查 询" CssClass="submitButton" /></div>
    </div>

    <!--SQL SERVER的时间比较写法-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" PageSize="13"
        FieldsList="*" OrderBy="id desc">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Remark" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="CreateTime" SearchOperator="BiggerAndEqual" />
            <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="CreateTime<='{0} 23:59:59'" SearchOperator="UserDefine" />
            <jasp:ParameterItem ParaType="FrameLibPara" ParaName="xx"  FrameLibParaName="AuthorityGroup" DataName="AuthorityGroup" />
        </ParaItems>
    </jasp:JDataSource>
    
     <!--Oracle的时间比较写法-->
   <%-- <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" PageSize="13"
        FieldsList="*" OrderBy="id desc">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Remark" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="CreateTime>=to_date('{0}','yyyy-mm-dd')" SearchOperator="UserDefine" />
            <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="CreateTime<=to_date('{0} 23:59:59','yyyy-mm-dd hh24:mi:ss')" SearchOperator="UserDefine" />
        </ParaItems>
    </jasp:JDataSource>--%>
    
   <!--Access的时间比较写法-->
  <%-- <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" PageSize="13"
        FieldsList="*" OrderBy="id desc">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Remark" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="CreateTime>=cdate('{0}')" SearchOperator="UserDefine" />
            <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="CreateTime<=cdate('{0} 23:59:59')" SearchOperator="UserDefine" />
        </ParaItems>
    </jasp:JDataSource>--%>
    
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
                        登录时间
                    </td>
                    <td class="Caption">
                        用户ID
                    </td>
                    <td class="Caption">
                        用户姓名
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
                        <%# (data1.CurPage-1)*data1.PageSize+Container.ItemIndex+1 %>
                    </td>
                    <td class="Data">
                        <%#Eval("CreateTime") %>
                    </td>
                    <td class="Data">
                        <%#Eval("UserID") %>
                    </td>
                    <td class="Data">
                        <%#Eval("UserName") %>
                    </td>
                    <td class="Data">
                        <%#Eval("Remark") %>
                    </td>
                    <td class="Data">
                        <a onclick="javascript:return EditData('<%#Eval("ID") %>');" href='#'>
                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                        &nbsp;
                        <jasp:JLinkButton ID="LinkButton1" CommandArgument='<%#Eval("ID") %>' CommandName="delete"
                            AuthorityID="A1" runat="server" OnClientClick="return confirm('确定删除该条数据吗？')"
                            Text='<img  alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除'></jasp:JLinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    <!--用户自定义翻页控件-->
    <uc1:MyPageChange ID="MyPageChange1" runat="server" />
    <!--页面权限控制-->
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
    </jasp:SecurityPanel>
</asp:Content>