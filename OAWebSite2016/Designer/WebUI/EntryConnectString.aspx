<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Designer/include/Second.Master"
    ValidateRequest="false" %>
<%@ Import Namespace="WebFrame.Util" %>
<script runat="server">
    protected override void OnInit(EventArgs e)
    {
        this.butSubmit.Click += new EventHandler(butSubmit_Click);
        base.OnInit(e);
    }

    //提交
    void butSubmit_Click(object sender, EventArgs e)
    {
        this.connStr2.Text = WebFrame.Data.JConnect.GetConnectEntryString(this.connStr1.Text);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
        //新增或编辑数据
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    开发平台 ＞＞连接字符串加密
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="update1" runat="server">
        <ContentTemplate>
            <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
                style="width: 70%">
                <tr>
                    <td class="Caption2" style="vertical-align: top; padding-top: 5px; width: 20%">
                        原连接字符串：
                    </td>
                    <td class="Data2" style="padding-bottom: 5px; padding-top: 5px; vertical-align: top">
                        <jasp:JTextBox ID="connStr1" runat="server" TextMode="MultiLine" Width="550" Height="150"></jasp:JTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Caption2" style="vertical-align: top; padding-top: 5px; width: 20%">
                        加密后的字符串：
                    </td>
                    <td class="Data2" style="padding-bottom: 5px; padding-top: 5px; vertical-align: top">
                        <jasp:JTextBox ID="connStr2" runat="server" TextMode="MultiLine" Width="550" Height="150"></jasp:JTextBox>
                    </td>
                </tr>
            </table>
            <div class="ButtonArea">
                <asp:Button ID="butSubmit" runat="server" Text="提 交" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    &nbsp;
</asp:Content>
