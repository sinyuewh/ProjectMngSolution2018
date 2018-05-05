<%@ Page Language="C#" AutoEventWireup="true" Title="系统用户" MasterPageFile="~/Designer/include/Second.Master"
    Inherits="WebFrame.SysMng.JUser_ListBU" %>

<%@ Register Src="~/Designer/Controls/MyPageChange.ascx" TagName="MyPageChange"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />

    <script src="/JS/jquery.autocomplete.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        //新增或编辑数据
        function EditData(dataID) {
            var url1 = "JUser_Detail.aspx";
            var title = "新增用户";
            if (dataID != "") {
                url1 = url1 + "?UserID=" + dataID;
                title = "用户明细";
            }
            AlertMsg(url1, title, 550, 300, true, 75);
            return false;
        }

        var url1 = "";
        $(document).ready(function() {

            //设置部门的选择值
            $('#<%=OrgID.ClientID %>').click(function() {
                url1 = "Select/SelectMulOrgID.aspx?parentID=" + this.id + "&oldValue=" + $(this).val();
                AlertMsg(url1, "选择一个或多个部门ID", 400, 550, true, 75, 200);
            });

            //设置用户姓名的智能选择
            $('#<%=UserName.ClientID %>').autocomplete({
                serviceUrl: '/Handler/AutoComplete.ashx',
                minChars: 1,
                maxHeight: 400,
                params: { "AutoKind": "GetUserName" }
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    系统管理 ＞＞用户列表
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    <jasp:JHyperLink ID="hyper1" runat="server" NavigateUrl="#" AuthorityID="A1" onclick="javascript:return EditData('');"
        Text='<img src="/images/Frame/22.gif" width="14" height="14" border="0" alt="" />&nbsp;新增'></jasp:JHyperLink>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <div style="margin: 10 0 5 5">
        &nbsp; 姓名：<jasp:JTextBox ID="UserName" runat="server" Width="120" />&nbsp; 所在部门ID：<jasp:JTextBox
            ID="OrgID" runat="server" Width="200" ToolTip="多个部门ID用逗号分隔" />&nbsp; 状态：<jasp:AppDropDownList
                ID="Status" runat="server">
                <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                <asp:ListItem Text="不限（包括停用）" Value=""></asp:ListItem>
            </jasp:AppDropDownList>
        &nbsp;
        <jasp:JButton ID="butSearch" runat="server" Text="查 询" />
        <div style="display: none">
            <jasp:JButton ID="butSearch1" runat="server" Text="查 询" CssClass="submitButton" /></div>
    </div>
    <!--数据源控件使用多表查询(Access 写法）-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUser Left JOIN (JOrgUsers Left Join Jorg on JOrgUsers.orgID = JOrg.orgID) ON JUser.UserID = JOrgUsers.UserID"
        PageSize="13" FieldsList="JUser.*,Jorg.orgID,jorg.orgName" OrderBy="JUser.num">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="UserName" DataName="Juser.UserName"
                SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="OrgID" DataName="Jorg.orgID" SearchOperator="Collection" />
            <jasp:ParameterItem ParaType="Control" ParaName="Status" DataName="JUser.Status"
                DataType="NumericType" />
            <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="JUser.UserID<>'admin'"
                SearchOperator="UserDefine" />
            <jasp:ParameterItem ParaType="FrameLibPara" ParaName="xx"  FrameLibParaName="AuthorityGroup" DataName="JUser.AuthorityGroup" />
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
                        用户ID
                    </td>
                    <td class="Caption">
                        姓名
                    </td>
                    <td class="Caption">
                        所在部门
                    </td>
                    <td class="Caption">
                        权限
                    </td>
                    <td class="Caption">
                        最近登陆
                    </td>
                    <td class="Caption">
                        登陆次数
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
                        <%#Eval("UserID") %>
                    </td>
                    <td class="Data">
                        <%#Eval("UserName") %>
                    </td>
                    <td class="Data">
                        <%#Eval("OrgName") %>
                    </td>
                    <td class="Data">
                        <%# Eval("AuthorityID").ToString()=="A1" ? "管理者": ( Eval("AuthorityID").ToString()=="A2" ? "操作者":"读者") %>
                    </td>
                    <td class="Data">
                        <%#Eval("LastLogin") %>
                    </td>
                    <td class="Data">
                        <%#Eval("LoginCount") %>
                    </td>
                    <td class="Data">
                        <a onclick="javascript:return EditData('<%#Eval("UserID") %>');" href='#'>
                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                        &nbsp;
                        <jasp:JLinkButton ID="LinkButton2" IsAlwaysReload="true" AuthorityID="A1" CommandArgument=' <%#Eval("UserID") %>'
                            CommandName="resetpassword" runat="server" OnClientClick="return confirm('确定需要重置密码吗？')"
                            Text='<img  alt="" src="/images/Frame/ico/person.png" width="16" height="16" border="0" />重置密码'>
                        </jasp:JLinkButton>
                        &nbsp;
                        <jasp:JLinkButton ID="LinkButton1" IsAlwaysReload="true" AuthorityID="A1" CommandArgument='<%#Eval("UserID") %>'
                            CommandName="delete" runat="server" OnClientClick="return confirm('确定删除该条数据吗？')"
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
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="$$0" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
