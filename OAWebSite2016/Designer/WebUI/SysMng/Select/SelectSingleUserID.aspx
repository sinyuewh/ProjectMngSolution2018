<%@ Page Language="C#" AutoEventWireup="true"
 MasterPageFile="~/Designer/include/Third.Master"
 Inherits="WebFrame.SysMng.SelectSingleUserIDBU" %>

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
        <asp:HiddenField ID="windowtype" runat="server" Value="" /><!--调用页面的方式-->
        <asp:HiddenField ID="parentID" runat="server" Value="" />
        <!--接收的控件ID-->
        <asp:HiddenField ID="oldValue" runat="server" Value="" />
        <!--接收的控件原有的值-->
        <div style="text-align: left; margin-left: 10px; overflow-y: scroll; height: 450px">
            <asp:TreeView ID="tree1" runat="server" ShowLines="True">
                <ParentNodeStyle Font-Bold="False" />
                <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
                    VerticalPadding="0px" BackColor="Gray" />
                <NodeStyle Font-Names="Verdana" Font-Size="11pt" ForeColor="Black" HorizontalPadding="5px"
                    NodeSpacing="0px" VerticalPadding="0px" />
            </asp:TreeView>
        </div>
        <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="0">
        </jasp:SecurityPanel>
    </div>
</asp:Content>