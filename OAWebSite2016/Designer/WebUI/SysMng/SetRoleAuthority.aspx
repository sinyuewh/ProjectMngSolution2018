<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/Designer/include/Third.Master"
Inherits="WebFrame.SysMng.SetRoleAuthorityBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <base target="_self" />
    <style type="text/css">
        body
        {
            overflow: hidden;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function OnTreeNodeChecked() {
            var ele = event.srcElement;
            if (ele.type == 'checkbox') {
                var childrenDivID = ele.id.replace('CheckBox', 'Nodes');
                var div = document.getElementById(childrenDivID);
                if (div != null) {
                    var checkBoxs = div.getElementsByTagName('INPUT');
                    for (var i = 0; i < checkBoxs.length; i++) {
                        if (checkBoxs[i].type == 'checkbox')
                            checkBoxs[i].checked = ele.checked;
                    }
                }
                OnTreeNodeChildChecked(ele);
            }
        }

        //子节点的操作
        function OnTreeNodeChildChecked(ele) {
            //递归处理
            if (ele == null) {
                ele = event.srcElement;
            }
            var succ = true;
            if (ele.parentElement != null) {
                var parentDiv = ele.parentElement;
                // alert(ele.parentElement);
                while (succ) {
                    if (parentDiv.id != "") {
                        break;
                    }
                    else {
                        parentDiv = parentDiv.parentElement;
                    }
                }
                var parentChkBox = document.getElementById(parentDiv.id.replace('Nodes', 'CheckBox'));
                if (parentChkBox != null) {
                    var ChildsChkAll = true;
                    var Boxs = parentDiv.getElementsByTagName('INPUT');
                    for (var i = 0; i < Boxs.length; i++) {

                        if (Boxs[i].type == 'checkbox' && Boxs[i].checked == false) {
                            ChildsChkAll = false;
                        }
                    }
                    parentChkBox.checked = ChildsChkAll;
                    OnTreeNodeChildChecked(parentChkBox);
                }
            }
        }

        function killerrors() {
            return true;
        }

        window.onerror = killerrors;
        // window.onload = CheckCloseWindow;
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <div style="text-align: center; padding-top: 5px;">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <jasp:JButton ID="but1" runat="server" Text="提 交" OnClientClick="javascript:return confirm('提示：确定提交数据吗？')" />
                <hr size="1" style="width: 98%" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div style="text-align: left; margin-left: 10px; overflow-y: scroll; height: 450px">
            <asp:TreeView ID="tree1" runat="server" ShowLines="True" ShowCheckBoxes="All">
            </asp:TreeView>
        </div>
        <jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage">
        </jasp:SecurityPanel>
    </div>
</asp:Content>
