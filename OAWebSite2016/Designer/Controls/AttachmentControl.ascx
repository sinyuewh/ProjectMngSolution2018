<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttachmentControl.ascx.cs"
    Inherits="OAWebSite.Controls.AttachmentControl" %>
<div id="div1" runat="server">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <jasp:JFileUpload ID="file" runat="server" Width="200" title="上传新的文件" />
            </td>
            <td align="right">
                文件描述：
            </td>
            <td align="left" style="width: 100px;">
                <asp:TextBox ID="txtFileDesc" runat="server" Width="100"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="but1" runat="server" Text="上传" />
            </td>
        </tr>
    </table>
    <br />
</div>
<asp:DataList ID="data1" runat="server" RepeatDirection="Horizontal" RepeatColumns="5">
    <ItemTemplate>
        <img src='/Images/Frame/file/file.jpg' width ="60px" 
            title='<%#Eval("Describle")%>' alt="" /><br />
        <a class="blue" href='<%#Eval("FileDir")%><%#Eval("EncryptFileName")%>' title='点击打开文件【<%#Eval("FileName")%>】'
            target="_blank">
            <%# WebFrame.Util.JString.GetMaxLenth(Eval("FileName").ToString(),10,"")%></a>
        <br />
        <asp:LinkButton ID="butDel" runat="server" CssClass="blue" Text="[删除]" OnClientClick="javascript:return confirm('警告：确定要删除文件吗？');"></asp:LinkButton>
        <asp:Label ID="lab1" runat="server" Text='<%#Eval("guidID")%>' Visible="false"></asp:Label>
    </ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
    <SeparatorTemplate>
        &nbsp;&nbsp; &nbsp;&nbsp;
    </SeparatorTemplate>
</asp:DataList>