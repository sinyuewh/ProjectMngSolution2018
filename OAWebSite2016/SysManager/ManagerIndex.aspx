<%@ Page Language="C#" AutoEventWireup="true" Inherits="OAWebSite2016.SysManager.ManagerIndex" %>

<!doctype html>
<html>
<head runat="server">
    <meta charset="utf-8">
    <link rel="stylesheet" href="/NewFrame/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/NewFrame/css/jquery.dialog.css" />
    <link rel="stylesheet" href="/NewFrame/css/index.css" />
    <title></title>

    <script src="/JS/jquery-1.8.2.min.js" type="text/javascript"></script>

    <style type="text/css">
        .sidebar .nav > li .subnav li a:hover
        {
            text-decoration: underline;
        }
    </style>

    <script type="text/javascript">
        function switchSysBar() {
            var locate = location.href.replace('ManagerIndex.aspx', '');
            var ssrc = document.all("img1").src.replace(locate, '');
            if (ssrc.indexOf("/NewFrame/images/toleft.png") > -1) {
                document.all("img1").src = "/NewFrame/images/toright.png";
                document.all("frmTitle").style.display = "none"
            }
            else {
                document.all("img1").src = "/NewFrame/images/toleft.png";
                document.all("frmTitle").style.display = ""
            }
        }

        //显示多标签的菜单
        function GoUrl(subtitle, weburl) {
            $(window.parent.document).contents().find("#iframe")[0].contentWindow.addTab(subtitle, weburl);
        }

        $(function() {
            $(".sidebar .nav > li .subnav li a").click(
           function() {
               $(".sidebar .nav > li .subnav li").each(function() {
                   $(this).find(">a").css("color", "black");
               });
               $(this).css("color", "#FF6100");
               //             $(".sidebar .nav > li .subnav li").eq($(this).index()).css("color","red");
               //.siblings().removeCss("color","black");
           }
           )
        })

        //Go MainPage
        function GoHomePage() {
            //$("#iframe").attr("src", "Index.aspx");
            var title = "主页";
            var url = "Welcome.aspx";

            GoUrl(title, url);
        }

        document.title = '<%=ConfigurationManager.AppSettings["WebTitle"] %>';
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="container">
        <div id="hd">
            <div class="hd-wrap ue-clear">
                <div class="top-light">
                </div>
                <h1 class="logo">
                </h1>
                <div class="login-info ue-clear">
                    <div class="welcome ue-clear">
                        <span>欢迎您,</span><a href="/Designer/AdminIndex.aspx" target="_blank" class="user-name"><%=WebFrame.FrameLib.UserName  %></a></div>
                   <%-- <div class="login-msg ue-clear">
                        <a href="javascript:;" class="msg-txt">消息</a> <a href="javascript:;" class="msg-num">
                            10</a>
                    </div>--%>
                </div>
                <div class="toolbar ue-clear">
                    <a href="javascript:GoHomePage();" class="home-btn">首页</a> <a href="javascript:;"
                        class="quit-btn exit"></a>
                </div>
            </div>
        </div>
        <div id="bd">
            <div class="wrap ue-clear">
                <div class="sidebar" id="frmTitle" name="fmTitle">
                    <h2 class="sidebar-header">
                        <p>
                            功能导航</p>
                    </h2>
                    <ul class="nav">
                        <asp:Repeater ID="rep1" runat="server">
                            <ItemTemplate>
                                <asp:Label ID="MenuID" runat="server" Visible="false" Text='<%#Eval("MenuID")%>'></asp:Label>
                                <li class="<%#Eval("ClassName").ToString()=="" ? "nav-info" : Eval("ClassName").ToString() %>">
                                    <div class="nav-header">
                                        <a href="javascript:;" class="ue-clear"><span>
                                            <%#Eval("Caption")%></span><i class="icon"></i></a></div>
                                    <ul class="subnav">
                                        <asp:Repeater ID="rep2" runat="server">
                                            <ItemTemplate>
                                                <li><a href="#" onclick="javascript:GoUrl('<%#Eval("value")%>','<%#Eval("Url")%>');">
                                                    <%#Eval("Caption")%></a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                    <input type="text" value='<%=WebFrame.FrameLib.UserID %>' id="userid1" name="userid1"  style="display:none" />
                </div>
                <div class="content">
                    <div class="toleft" onclick="switchSysBar()">
                        <span class="navPoint" id="switchPoint" title="关闭/打开左栏">
                            <img src="/NewFrame/images/toleft.png" width="6" height="46" name="img1" id="img1" /></span></div>
                    <iframe src="HomePage.aspx" id="iframe" name="iframe" width="100%" height="100%"
                        frameborder="0"></iframe>
                </div>
            </div>
        </div>
        <div id="ft" class="ue-clear">
            <div class="ft-left">
                <span>
                    <%=ConfigurationManager.AppSettings["WebTitle"] %></span>
                <%--<em>Elevator&nbsp;life-cycle&nbsp;information&nbsp;platform</em>--%>
            </div>
            <div class="ft-right">
                <%--<span>Automation</span>--%>
                <em>
                    <%=ConfigurationManager.AppSettings["Version"] %>&nbsp;<%=DateTime.Now.Year %></em>
            </div>
        </div>
    </div>
    <div class="exitDialog">
        <div class="dialog-content">
            <div class="ui-dialog-icon">
            </div>
            <div class="ui-dialog-text">
                <p class="dialog-content">
                    你确定要退出系统？</p>
                <p class="tips">
                    如果是请点击“确定”，否则点“取消”</p>
                <div class="buttons">
                    <input type="button" class="button long2 ok" value="确定" />
                    <input type="button" class="button long2 normal" value="取消" />
                </div>
            </div>
        </div>
    </div>

    <script language="javascript" type="text/javascript">
        function myrefresh() {
            var timestamp = (new Date()).valueOf();
            $.ajax({
                type: 'GET',
                url: "AutoLogin.aspx?time1=" + timestamp,
                data: {
                    'userid': $("#userid1").val()
                },
                success: function(data) {
                    if (data == "no") {
                        alert("not login");
                    }
                },
                dataType: "text"
            });
        }
        //setTimeout('myrefresh()', 1000); //指定1分钟刷新1次
        var t1 = window.setInterval(myrefresh, 60000); 
    </script>

    </form>
</body>

<script type="text/javascript" src="/NewFrame/js/jquery.js"></script>

<script type="text/javascript" src="/NewFrame/js/common.js"></script>

<script type="text/javascript" src="/NewFrame/js/core.js"></script>

<script type="text/javascript" src="/NewFrame/js/jquery.dialog.js"></script>

<script type="text/javascript" src="/NewFrame/js/index.js"></script>

</html>
