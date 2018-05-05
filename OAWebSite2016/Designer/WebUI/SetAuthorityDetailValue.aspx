<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Third.Master"
    AutoEventWireup="true" Inherits="WebFrame.Designer.SetAuthorityDetailValueBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ButtonArea" style="display: none">
        <jasp:JButton ID="butAdd" runat="server" Text="增 加" />
        &nbsp;
        <jasp:JButton ID="btnSubmit" runat="server" Text="提 交" />
        &nbsp;
        <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:parent.CloseMsg();return false;" />
    </div>
    <br />
    <!--定义数据源-->
    <table style="width: 90%" border="0" align="center">
        <tr>
            <td>
                <b>权限ID：</b><%=Request.QueryString["AuthorityID"]%>
            </td>
        </tr>
    </table>
    <table class="ListTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr>
            <td class="Caption">
                序号
            </td>
            <td class="Caption">
                权限点描述
            </td>
            <td class="Caption">
                权限点ID
            </td>
            <td class="Caption">
                权限点值
            </td>
        </tr>
        <asp:Repeater ID="rep1" runat="server">
            <ItemTemplate>
                <tr>
                    <td class="Data">
                        <jasp:JTextBox ID="Num" runat="server" Caption="序号" AllowNullValue="false" DataType="Integer"
                            Text='<%#Eval("num") %>' Width="40" Style="text-align: center"></jasp:JTextBox>
                    </td>
                    <td class="Data">
                        <jasp:JTextBox ID="Remark" runat="server" Caption="权限点描述" AllowNullValue="false"
                            Text='<%#Eval("Remark") %>'></jasp:JTextBox>
                    </td>
                    <td class="Data">
                        <jasp:JTextBox ID="AuthorityUnitID" runat="server" Caption="权限点ID" AllowNullValue="false"
                            Text='<%#Eval("AuthorityUnitID") %>' Width="250px"></jasp:JTextBox>
                    </td>
                    <td class="Data">
                        <jasp:JTextBox ID="AuthorityIDValue" runat="server" Caption="权限点ID" DataType="Integer"
                            AllowNullValue="false" ToolTip="是个0-100数字" Width="40" Style="text-align: center"
                            Text='<%#Eval("AuthorityIDValue") %>'></jasp:JTextBox>
                    </td>
                    
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <table border="0" align="center" style="width: 90%">
        <tr>
            <td>
                提示：0表示浏览，1表示新增，2表示修改，3表示删除，4-10表示其他的权限功能点。
            </td>
        </tr>
    </table>
    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
