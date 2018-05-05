<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Third.Master"
    AutoEventWireup="true" Inherits="WebFrame.Designer.JAuthority_DetailBU" %>

<%@ Register Assembly="WebFrame" Namespace="WebFrame.ExpControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $(".Data2 input").css({ 'width': '450px' });
            $(".Data2 textarea").css({ 'width': '450px' });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JAuthority" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="AuthorityID" />
            <jasp:ParameterItem ParaType="AppSettings" ParaName="AuthorityGroup" DataName="JAuthority.AuthorityGroup" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
        ControlList="Num,AuthorityID,AuthorityName,Author,ModelID,RelPages,Remark,AuthUnitText,AuthUnitNum"
        TableName="JAuthority" PrimaryKeys="AuthorityID" IsAppendData="true" />
    <jasp:JTextBox ID="Author" runat="server" Visible="false"></jasp:JTextBox>
    <jasp:JDataSource ID="Data2" runat="server" JType="Table" SqlID="JModel" PageSize="-1"
        FieldsList="ModelID,ModelName" OrderBy="num" />
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr>
            <td class="Caption2">
                序号：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Num" Caption="序号" AllowNullValue="false" DataType="Integer" runat="server"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                所属模块：
            </td>
            <td class="Data2">
                <jasp:AppDropDownList ID="ModelID" runat="server" DataSourceID="Data2" DataTextField="ModelName"
                    DataValueField="ModelId" Caption="所属模块" AllowNullValue="false">
                </jasp:AppDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                权限ID：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="AuthorityID" Caption="权限ID" AllowNullValue="false" IsUnique="true"
                    UniqueTable="JAuthority" runat="server"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                权限名称：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="AuthorityName" Caption="权限名称" AllowNullValue="false" runat="server"></jasp:JTextBox>
            </td>
        </tr>

        <tr>
            <td class="Caption2">
                权限功能点文本：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="AuthUnitText" Caption="权限功能点文本" runat="server"></jasp:JTextBox>
            </td>
        </tr>

        <tr>
            <td class="Caption2">
                权限功能点数字：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="AuthUnitNum" Caption="权限功能点数字" runat="server"></jasp:JTextBox>
            </td>
        </tr>

        <tr>
            <td class="Caption2">
                相关aspx和ascx文件
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="RelPages" Caption="备注" runat="server" TextMode="MultiLine" Height="100"></jasp:JTextBox>
                <br />使用绝对路径，多个用回车换行分隔
            </td>
        </tr>

        <tr>
            <td class="Caption2">
                备注：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Remark" Caption="备注" runat="server" TextMode="MultiLine" Height="60"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea" style ="display:none">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnSubmit" runat="server" Text="提 交" />
                &nbsp;
                <asp:Button ID="Button1" runat="server" Text="权限替换" />
                &nbsp;
                <asp:Button ID="Button2" runat="server" Text="权限反替换" />
                &nbsp;
                <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:art.dialog.close();" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
