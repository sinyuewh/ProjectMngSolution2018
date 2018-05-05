<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Second.Master"
Inherits="WebFrame.Designer.JAuthority_List" %>

<%@ Register Src="~/Designer/Controls/MyPageChange.ascx" TagName="MyPageChange"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
        //新增或编辑数据
        function EditData(dataID) {
            var url1 = "JAuthority_Detail.aspx";
            var title = "新增系统权限";
            if (dataID != "") {
                url1 = url1 + "?AuthorityID=" + dataID;
                title = "系统权限明细";
            }
            AlertMsg(url1, title, 800, 430, true, 75);
            return false;
        }

        function SetAuthorityDetailData(dataID) {
            var url1 = "SetAuthorityDetailValue.aspx?AuthorityID=" + dataID;
            AlertMsg(url1, "浏览权限点明细", 800, 450, true, 75);
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    开发平台 ＞＞系统权限
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    &nbsp;
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <div style="margin: 10 0 5 5">
        <jasp:JDataSource ID="Data2" runat="server" JType="Table" SqlID="JModel" PageSize="-1"
            FieldsList="ModelID,ModelName" OrderBy="num">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="AuthorityGroup" />
            </ParaItems>
        </jasp:JDataSource>
        &nbsp;管理目录： <jasp:JManageDirDropDownList ID="AuthorityGroup" runat ="server" AutoPostBack="true"></jasp:JManageDirDropDownList>
        &nbsp;所属模块：<jasp:AppDropDownList ID="ModelID" runat="server" DataSourceID="Data2"
            BlankValue="--不限--" DataTextField="ModelName" DataValueField="ModelId">
        </jasp:AppDropDownList>
        &nbsp;作者：<jasp:JTextBox ID="Author" runat="server" Width="100" />
        &nbsp;权限名称：<jasp:JTextBox ID="AuthorityName" runat="server" Width="100" />
        <jasp:JButton ID="butSearch" runat="server" Text="查 询" />
        &nbsp;
        <jasp:JButton ID="butImportAuthority" runat="server" Width ="150px" OnClientClick="javascript:return confirm('提示：确定要根据 Authority.xml 文件导入权限数据吗？');"
            Text="从权限XML中导入权限" />
        &nbsp;
        <jasp:JButton ID="butReplacePageAuthority" runat="server" Width ="120px" OnClientClick="javascript:return confirm('提示：确定要设置页面中的权限吗？');"
            Text="设置页面中权限" />
            
            &nbsp;
        <jasp:JButton ID="butCancelPageAuthority" runat="server" Width ="120px" OnClientClick="javascript:return confirm('提示：确定要取消页面中的权限吗？');"
            Text="取消页面中权限" />
        <div style="display: none">
            <jasp:JButton ID="butSearch1" runat="server" Text="查 询" CssClass="submitButton" /></div>
    </div>
    <!--数据源控件使用多表查询-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JAuthority left outer join Jmodel on JAuthority.modelid=jmodel.modelid"
        PageSize="13" FieldsList="JAuthority.*,ModelName" OrderBy="JAuthority.num">
        <ParaItems>
            <jasp:ParameterItem ParaType="Control" ParaName="ModelID" DataName="JAuthority.modelid" />
            <jasp:ParameterItem ParaType="Control" ParaName="AuthorityName" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="Author" SearchOperator="Contains" />
            <jasp:ParameterItem ParaType="Control" ParaName="AuthorityGroup"  DataName="JAuthority.AuthorityGroup" />
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
                        所属模块
                    </td>
                    <td class="Caption">
                        权限ID
                    </td>
                    <td class="Caption">
                        权限名称
                    </td>
                    <td class="Caption">
                        作者
                    </td>
                    <td class="Caption">
                        权限功能点
                    </td>
                    <td class="Caption">
                        相关页面
                    </td>
                    <td class="Caption">
                        替换
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
                        <%#Eval("modelName") %>
                    </td>
                    <td class="Data">
                        <%#Eval("AuthorityID") %>
                    </td>
                    <td class="Data">
                        <%#Eval("AuthorityName") %>
                    </td>
                    <td class="Data">
                        <%#Eval("Author") %>
                    </td>
                    <td class="Data">
                        <jasp:JHyperLink ID="hyper1" runat="server" NavigateUrl="#" onclick='<%# String.Format("javascript:SetAuthorityDetailData(\"{0}\");return false;",Eval("AuthorityID")) %>'
                            ToolTip='设置权限功能点' CssClass="blue" Text='<%# String.Format("[{0}]",WebFrame.Comm.JAuthorityBU.GetAuthorityDetailCount(Eval("AuthorityID").ToString()) ) %>'></jasp:JHyperLink>
                    </td>
                    <td class="Data" style="text-align: left; padding-left: 15px">
                        <div style="line-height: 150%">
                            <%# WebFrame.Util.JString.GetSimpleShowFormat(Eval("RelPages").ToString()) %></div>
                    </td>
                    <td class="Data">
                        <asp:Label ID="labNeedReplace" runat="server"></asp:Label>
                    </td>
                    <td class="Data">
                        <a onclick="javascript:return EditData('<%#Eval("AuthorityID") %>');" href='#'>
                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                        &nbsp;
                        <jasp:JLinkButton ID="LinkButton1" CommandArgument='<%#Eval("AuthorityID") %>' CommandName="delete"
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
    <!--页面权限控制-->
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
