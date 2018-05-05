<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Third.Master"
Inherits="WebFrame.SysMng.AddUserFavorBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <base target="_self" />
   
    <script language="javascript" type ="text/javascript">
        function checkinfo() {
            if (document.getElementById("<%=this.urlText.ClientID %>").value == "") {
                alert("错误：请输入收藏的名称！");
                document.getElementById("<%=this.urlText.ClientID %>").focus();
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%; margin-top: 10px">
        <tr>
            <td class="Caption2" style ="width:20%">
                名称1:
            </td>
            <td class="Data2" style ="width:80%">
                <jasp:JTextBox ID="urlText" AllowNullValue="false" CssClass="text" runat="server"
                    Caption="名称" Width="250px"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2" style ="width:20%">
                地址2:
            </td>
            <td class="Data2" style ="width:80%">
                <jasp:JTextBox ID="urlValue" AllowNullValue="false" CssClass="text" runat="server"
                    Caption="地址" ReadOnly="true" Width="250px"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:Button ID="butSubmit" CssClass="btn" runat="server" Text="提 交" OnClientClick="javascript:return checkinfo();" />
        &nbsp;
        <asp:Button ID="Button1" CssClass="btn" runat="server" Text="关 闭" OnClientClick="javascript:window.close();return false;" />
    </div>
</asp:Content>