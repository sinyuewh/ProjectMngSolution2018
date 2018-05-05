<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Second.Master"
Inherits="WebFrame.Designer.JAuthorityTreeBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--此处放置页面的样式和JS-->
    <script language ="javascript" type ="text/javascript">
        
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceForNavigatorTitle" runat="server">
    <!--系统导航-->
    开发平台 ＞＞权限结构树
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceForNavigatorButtonArea"
    runat="server">
    <!--图标区操作-->
    &nbsp;
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceForContent" runat="server">
    <!--页面的内容-->
    <div style="padding-left: 30px">
        <asp:TreeView ID="tree1" runat="server" ShowCheckBoxes="None" 
          ExpandDepth="1"
          ShowLines="true">
        </asp:TreeView>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceForPageChange" runat="server">
    &nbsp;<jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
    </jasp:SecurityPanel>
</asp:Content>
