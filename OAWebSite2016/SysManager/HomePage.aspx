<%@ Page Language="C#" AutoEventWireup="true" StylesheetTheme="" %>

<script runat="server">
   
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/EasyUI/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/EasyUI/themes/icon.css" rel="stylesheet" />
    <link href="/css/admin.css" rel="stylesheet" />

    <script src="/EasyUI/jquery.min.js" type="text/javascript"></script>

    <script src="/EasyUI/jquery.easyui.min.js" type="text/javascript"></script>

    <script src="/js/common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        //Get Current Tab Index
        function getTabCurrentIndex() {
            var alltabs = $('#tabs').tabs('tabs');
            var currentTab = $('#tabs').tabs('getSelected');
            var tabIndex = $('#tabs').tabs('getTabIndex', currentTab);
            return tabIndex;
        }

        //Go MainPage
        function GoHomePage() {
            $("#iframe1").attr("src", "WelCome.aspx");
        }
    </script>

</head>
<body class="easyui-layout" data-options="fit:true,scroll:'no'">
    <div data-options="region:'center'">
        <div id="tabs" class="easyui-tabs" data-options="tools:'#tab-tools',fit:true,border:false">
            <div title="主页" data-options="iconCls:'icon-house'" style="padding-top: -5px;">
                <iframe id="iframe1" scrolling="auto" frameborder="0" src='Welcome.aspx' style="width: 100%;
                    height: 100%;"></iframe>
            </div>
        </div>
        <%--     <div id="tab-tools">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'"
                onclick="addTab('百度','http://www.baidu.com')"></a><a href="javascript:void(0)" class="easyui-linkbutton"
                    data-options="plain:true,iconCls:'icon-remove'" onclick="removeTab()"></a>
        </div>--%>
    </div>
    <div id="mm" class="easyui-menu" style="width: 150px;">
        <div id="refresh" data-options="iconCls:'icon-arrow_refresh'">
            刷新</div>
        <div class="menu-sep">
        </div>
        <div id="close">
            关闭</div>
        <div id="closeall">
            全部关闭</div>
        <div id="closeother">
            除此之外全部关闭</div>
        <div class="menu-sep">
        </div>
        <div id="closeright">
            当前页右侧全部关闭</div>
        <div id="closeleft">
            当前页左侧全部关闭</div>
        <div class="menu-sep">
        </div>
        <div id="exit">
            退出</div>
    </div>
</body>
</html>
