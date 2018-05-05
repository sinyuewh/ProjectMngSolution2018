<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master" AutoEventWireup="true" CodeBehind="JRole_SetAthority.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JRole_SetAthority" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/EasyUI/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/EasyUI/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/EasyUI/demo/demo.css">

    <script type="text/javascript" src="/EasyUI/jquery.min.js"></script>

    <script type="text/javascript" src="/EasyUI/jquery.easyui.min.js"></script>

    <script type="text/javascript">
        $(function() {
            InitTreeData();
        });
        function InitTreeData() {
            $('#tree').tree({
                url: '/SysManager/WebUI/PubLib/GetEasyUITreeData.aspx?dataKind=1&RoleID=<%=Request["RoleID"]%>',
                checkbox: true
            });
        }

        function getChecked() {
            var nodes = $('#tree').tree('getChecked');
            var s = '';
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].tag == "1") {    //去掉非权限功能点数据
                    if (s != '') s += ',';
                    s += nodes[i].ID;
                }
            }

            //alert(s);
            if (s.length == 0) 
            {
                layer.alert("错误：请至少选择一个权限功能点！");
                return false;
            }
            else
            {
                $('#<%=this.selectdata.ClientID %>').val(s);
                return true;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--数据Form-->
    <div style="margin-top: -20px; margin-left: -10px; border: solid 1px gray; padding: 10px;
        height: 380px; overflow:auto">
        <ul id="tree" class="easyui-tree">
        </ul>
    </div>
    <br />
    <div style="margin-left:-10px">
        <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="JRole_AUTHORITY ">
           <%-- <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                value=" 提 交 "  />--%>
            <asp:HiddenField ID="selectdata" runat="server" />
            <jasp:JButton ID="but1" runat ="server" Text =" 提 交 "
             CssClass="btn btn-primary radius" OnClientClick="javascript:return getChecked();"></jasp:JButton>
             
              &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button"> 取 消 </button>
        </jasp:SecurityPanel>
    </div>
    <%--  <a href="#" class="easyui-linkbutton" onclick="getChecked()">提交</a>--%>
</asp:Content>
