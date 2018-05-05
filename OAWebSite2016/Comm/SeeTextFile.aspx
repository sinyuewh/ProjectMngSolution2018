<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeeTextFile.aspx.cs" 
Inherits="KORWeb.WebSite.Comm.SeeTextFile" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="x-ua-compatible" content="IE=EmulateIE7" />
    <style type="text/css">
        body
        {
            margin: 0 0 0 0;
            overflow: hidden;
            height: 100%;
        }
        
        html, form
        {
            height: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <div id="div1" style="text-align: center; height: 100%; margin-top: 2px">
        <table width="100%" align="center" bgcolor="#c5c5c5" cellpadding="1" cellspacing="1"
            height="100%" border="0"  >
            <tr bgcolor="#f0f8ff"  style="display:none">
                <td align="left" >
                    <asp:UpdatePanel ID="update1" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="but" runat="server" Text="保 存" OnClientClick="javascript:return confirm('提示：确定要保存文件吗？');" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="#f0f8ff" height="96%">
                <td align="center">
                    <asp:TextBox ID="txt1" runat="server" Width="100%" Height="100%" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
