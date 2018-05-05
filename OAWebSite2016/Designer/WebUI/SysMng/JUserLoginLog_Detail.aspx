<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Third.Master"
Inherits="WebFrame.SysMng.JUserLoginLog_DetailBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="ID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="ID,CreateTime,UserID,UserName,Remark"
        TableName="JUserLoginLog" PrimaryKeys="ID" IsAppendData="true" NoSaveControlList="ID" />
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr style="display:none">
            <td class="Caption2">
                数据ID：
            </td>
            <td class="Data2">
                <jasp:JLabel ID="ID" runat="server"></jasp:JLabel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                创建时间：
            </td>
            <td class="Data2">
                <jasp:JLabel ID="CreateTime" runat="server"></jasp:JLabel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                登录用户ID：
            </td>
            <td class="Data2">
                <jasp:JLabel ID="UserID" runat="server"></jasp:JLabel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                登录用户姓名：
            </td>
            <td class="Data2">
                <jasp:JLabel ID="UserName" runat="server"></jasp:JLabel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                备注：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Remark" Caption="Remark" Width="300" TextMode="MultiLine" Height="100"
                    runat="server"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <jasp:JButton ID="btnSubmit" runat="server" Text="提 交" AuthorityID="A1" />
                &nbsp;
                <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:art.dialog.close();" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <!--页面权限控制-->
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
    </jasp:SecurityPanel>
</asp:Content>
