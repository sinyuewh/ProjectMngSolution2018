<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Designer/include/Third.Master"
    Inherits="WebFrame.SysMng.JRole_DetailBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $(".Data2 :input[type='text']").css({ 'width': '250px' });
            $(".Data2 textarea").css({ 'width': '250px' });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <!--定义数据源-->
    <div style="display: none">
         <jasp:JTextBox ID="AuthorityGroup" runat ="server"></jasp:JTextBox>
          <jasp:JTextBox ID="Kind" runat ="server"></jasp:JTextBox>
    </div>
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JRole" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="RoleID" />
           
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,RoleID,RoleName,Kind,Remark,AuthorityGroup"
        TableName="JRole" PrimaryKeys="RoleID" IsAppendData="true" />
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr>
            <td class="Caption2">
                序号：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Num" Caption="序号" Width="250px" AllowNullValue="false" DataType="Integer"
                    runat="server"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                角色名称：
            </td>
            <td class="Data2">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <jasp:JTextBox ID="RoleName" Caption="RoleName" Width="250px" AutoPostBack="true"
                            AllowNullValue="false" runat="server"></jasp:JTextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                角色ID：
            </td>
            <td class="Data2">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="RoleName" EventName="TextChanged" />
                    </Triggers>
                    <ContentTemplate>
                        <jasp:JTextBox ID="RoleID" Caption="角色ID" Width="250px" AllowNullValue="false" IsUnique="true"
                            UniqueTable="JRole" runat="server"></jasp:JTextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                备注：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Remark" Caption="Remark" Width="250px" runat="server" TextMode="MultiLine"
                    Height="60px"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnSubmit" runat="server" Text="提 交" />
                &nbsp;
                <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:art.dialog.close();" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <!--页面权限控制-->
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
