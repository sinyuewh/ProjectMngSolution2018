<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Designer/include/Third.Master"
     Inherits="WebFrame.SysMng.SelectMulRoleBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <base target="_self" />
    <style type="text/css">
        body
        {
            overflow: hidden;
        }
    </style>

    <script language="javascript" type="text/javascript">
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; padding-top: 5px;">
        <asp:Button ID="but1" runat="server" Text="确定返回" />
        <asp:HiddenField ID="windowtype" runat="server" Value="" />
        <!--调用页面的方式-->
        <asp:HiddenField ID="parentID" runat="server" Value="" />
        <!--接收的控件ID-->
        <asp:HiddenField ID="oldValue" runat="server" Value="" />
        <!--接收的控件原有的值-->
        <hr size="1" style="width: 98%" />
        <div style="text-align: left; margin-left: 10px; overflow-y: scroll; height: 450px">
            <asp:TreeView ID="tree1" runat="server" ShowLines="True" ShowCheckBoxes="All">
            </asp:TreeView>
        </div>
        <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage">
        </jasp:SecurityPanel>
    </div>
</asp:Content>
