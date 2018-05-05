<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Designer/include/Third.Master"
    Inherits="WebFrame.SysMng.JUser_DetailBU" %>
<script runat ="server" >
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/Js/dialog.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            $(".Data2 :input[type='text']").css({ 'width': '300px' });
            $(".Data2 textarea").css({ 'width': '300px' });

            $('#<%=OrgID.ClientID %>').click(function() {
                var url1 = "Select/SelectSingleOrgID.aspx?level=2&parentID=" + this.id + "&oldValue=" + $(this).val();
                AlertMsg(url1, "选择一个部门ID", 400, 550, true, 75, 200);
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <div style ="display:none">
        <jasp:JTextBox ID="AuthorityGroup" runat ="server"></jasp:JTextBox>
    </div>
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUser left outer join JOrgUsers on Juser.userid=JOrgUsers.userid"
        FieldsList="JUser.*,JOrgUsers.OrgID" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="UserID" DataName="JUser.UserID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JTextBox ID="PassWord" runat="server" Visible="false"></jasp:JTextBox>
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,UserID,UserName,Status,OrgID,PassWord,AuthorityGroup,AuthorityID"
        TableName="JUser" PrimaryKeys="UserID" IsAppendData="true" />
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
         <tr>
            <td class="Caption2">
                所属部门：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="OrgID" Caption="所属部门" AllowNullValue="false" runat="server"></jasp:JTextBox>
            </td>
        </tr>
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
                姓名：
            </td>
            <td class="Data2">
                <asp:UpdatePanel ID="update2" runat="server">
                    <ContentTemplate>
                        <jasp:JTextBox ID="UserName" Caption="姓名" Width="300px" AutoPostBack="true" runat="server"
                            AllowNullValue="false"></jasp:JTextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                用户标识：
            </td>
            <td class="Data2">
                <asp:UpdatePanel ID="update3" runat="server">
                    <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="UserName" EventName ="TextChanged" />
                    </Triggers>
                    <ContentTemplate>
                        <jasp:JTextBox ID="UserID" Width ="300px"
                            Caption="用户标识" AllowNullValue="false" IsUnique="true"
                            UniqueTable="JUser" runat="server"></jasp:JTextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
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
       
        <tr>
            <td class="Caption2">
                权限标识：
            </td>
            <td class="Data2">
                <jasp:AppDropDownList ID ="AuthorityID" runat ="server">
                    <asp:ListItem Text ="管理者" Value ="A1"></asp:ListItem>
                    <asp:ListItem Text ="操作者" Value ="A2"></asp:ListItem>
                    <asp:ListItem Text ="读者" Value ="A3"></asp:ListItem>
                </jasp:AppDropDownList>
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
