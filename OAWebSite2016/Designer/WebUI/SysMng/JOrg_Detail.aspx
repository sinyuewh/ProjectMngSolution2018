<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Designer/include/Third.Master"
     Inherits="WebFrame.SysMng.JOrg_DetailBU" %>

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
        <jasp:JTextBox ID="AuthorityGroup" runat="server"></jasp:JTextBox>
    </div>
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JOrg" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="OrgID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,OrgID,OrgName,Parent,Status,AuthorityGroup"
        TableName="JOrg" PrimaryKeys="OrgID" IsAppendData="true" />
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr>
            <td class="Caption2">
                序号：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Num" Caption="序号" DataType="Integer" runat="server" AllowNullValue="false"
                    Width="250px"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                组织机构名称：
            </td>
            <td class="Data2">
                <asp:UpdatePanel ID="update2" runat="server">
                    <ContentTemplate>
                        <jasp:JTextBox ID="OrgName" Caption="组织机构名称" AllowNullValue="false" runat="server"
                            AutoPostBack="true" Width="250px"></jasp:JTextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                组织机构ID：
            </td>
            <td class="Data2">
                <asp:UpdatePanel ID="UpdatePane3" runat="server">
                    <Triggers>
                        <asp:AsyncPostBackTrigger EventName="TextChanged" ControlID="OrgName" />
                    </Triggers>
                    <ContentTemplate>
                        <jasp:JTextBox ID="OrgID" Caption="组织机构ID" AllowNullValue="false" IsUnique="true"
                            UniqueTable="JOrg" runat="server" Width="250px"></jasp:JTextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                上级机构ID：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Parent" Caption="上级机构ID" runat="server" Width="250px"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                状态：
            </td>
            <td class="Data2">
                <jasp:AppRadioButtonList ID="Status" Caption="状态" AllowNullValue="false" runat="server"
                    RepeatColumns="3" RepeatLayout="Flow" align="left">
                    <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                    <asp:ListItem Text="停用" Value="0"></asp:ListItem>
                </jasp:AppRadioButtonList>
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
