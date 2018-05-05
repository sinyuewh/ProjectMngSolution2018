<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="SetLogReaders.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.SetLogReaders" %>

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
            url: '/SysManager/WebUI/PubLib/GetEasyUITreeData.aspx?dataKind=99&oldUsers=<%=Request["oldUsers"]%>',
                checkbox: true
            });
        }

        function getChecked() {
            var nodes = $('#tree').tree('getChecked');
            var s = '';
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].tag == "1") {    //去掉单位的数据
                    if (s != '') s += ',';
                    s += nodes[i].ID;
                }
            }

            //alert(s);
            var index = parent.layer.getFrameIndex(window.name);
            parent.$('#<%=Request.QueryString["parentid"] %>').val(s);
            parent.layer.close(index);
            
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--数据Form-->
    <div style="margin-top: -20px; margin-left: -10px; border: solid 1px gray; padding: 10px;
        height: 380px; overflow: auto">
        <ul id="tree" class="easyui-tree">
        </ul>
    </div>
    <br />
    <div style="margin-left: -10px">
        <%-- <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                value=" 提 交 "  />--%>
        <asp:HiddenField ID="seluserid" runat="server" />
        <jasp:JButton ID="but1" runat="server" Text=" 确 定 " CssClass="btn btn-primary radius"
            OnClientClick="javascript:return getChecked();">
        </jasp:JButton>
        &nbsp;&nbsp;
        <button onclick="layer_close();" class="btn btn-default radius" type="button">
            取 消
        </button>
    </div>
    <%--  <a href="#" class="easyui-linkbutton" onclick="getChecked()">提交</a>--%>
</asp:Content>
