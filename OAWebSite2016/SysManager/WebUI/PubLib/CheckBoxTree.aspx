<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckBoxTree.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.PubLib.CheckBoxTree" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>CheckBox Tree</title>
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
                url: 'GetEasyUITreeData.aspx?dataKind=0',
                checkbox: true
            });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ul id="tree" class="easyui-tree">
    </ul>
    </form>
</body>
</html>
