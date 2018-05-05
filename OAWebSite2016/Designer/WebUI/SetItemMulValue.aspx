<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Third.Master"
    AutoEventWireup="true" Inherits="WebFrame.Designer.SetItemMulValueBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ButtonArea">
        <jasp:JButton ID="butAdd" runat="server" Text="增 加" />
        &nbsp;
        <jasp:JButton ID="btnSubmit" runat="server" Text="提 交" />
        &nbsp;
        <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:art.dialog.close();" />
    </div>
    <br />
    <!--定义数据源-->
    <table style="width: 90%" border="0" align="center">
        <tr>
            <td>
                <b>条目名称：</b><%=Request.QueryString["Itemname"]%>
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
                    条目Text
                </td>
                <td class="Caption">
                    条目Value
                </td>
                <td class="Caption">
                    操作
                </td>
            </tr>
            <asp:Repeater ID="rep1" runat="server">
                <ItemTemplate>
                    <tr>
                        <td class="Data">
                            <jasp:JTextBox ID="Num" class="input-text" runat="server" Caption="序号" AllowNullValue="false"
                                DataType="Integer" Text='<%#Eval("num") %>'></jasp:JTextBox>
                        </td>
                        <td class="Data">
                            <jasp:JTextBox ID="ItemText" class="input-text" runat="server" Caption="条目Text" AllowNullValue="false"
                                Text='<%#Eval("itemtext") %>'></jasp:JTextBox>
                        </td>
                        <td class="Data">
                            <jasp:JTextBox ID="ItemValue" class="input-text" runat="server" Caption="条目Value"
                                AllowNullValue="false" Text='<%#Eval("itemvalue") %>'></jasp:JTextBox>
                        </td>
                        <td class="Data">
                            <jasp:JLinkButton ID="butDel" runat="server" Text="[删除]" CommandArgument='<%#Container.ItemIndex %>'
                                OnClientClick="javascript:return confirm('提示：确定要删除该条数据吗？');" CssClass="blue"></jasp:JLinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
</asp:Content>
