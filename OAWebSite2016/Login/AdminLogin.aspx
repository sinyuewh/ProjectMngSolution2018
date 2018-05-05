<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="OAWebSite2016.Login.AdminLogin" %>

<!doctype html>
<html lang="en">
<html>
<head runat="server">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/NewFrame/css/base.css" />
    <link rel="stylesheet" href="/NewFrame/css/login.css" />
    <title></title>
</head>
<body onkeypress="javascript:checkenter();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="script" runat="server">
    </asp:ScriptManager>
    <div id="container">
        <div id="bd">
            <div class="login1">
                <div class="login-top">
                   <h1 class="logo">
                   </h1>
                </div>
                <div class="login-input">
                    <p class="user ue-clear">
                        <label>
                            用户名</label>
                        <input type="text" id="username" runat="server" />
                    </p>
                    <p class="password ue-clear">
                        <label>
                            密&nbsp;&nbsp;&nbsp;码</label>
                        <input type="password" id="password" name="password" value='<%=WebFrame.Util.JCookie.GetCookieValue("login_password") %>' />
                    </p>
                    <%-- <p class="yzm ue-clear">
                                <label>
                                    验证码</label>
                                <input type="text" runat="server" id="chkcode" />
                                <cite>
                                    <asp:LinkButton ID="butGetCode" runat="server" Text="X394D" ForeColor="White"></asp:LinkButton></cite>
                            </p>--%>
                </div>
                <asp:UpdatePanel ID="update1" runat="server">
                    <ContentTemplate>
                        <div class="login-btn ue-clear">
                            <asp:LinkButton ID="but1" runat="server" CssClass="btn" Text="登录"></asp:LinkButton>
                            <div class="remember ue-clear">
                                <input type="checkbox" id="remember" runat="server"  />
                                <em></em>
                                <label for="remember">
                                    记住密码</label>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div id="ft">
        CopyRight&nbsp;2016&nbsp;&nbsp;版权所有&nbsp;&nbsp;<%=ConfigurationManager.AppSettings["CorpName"]%></div>
    </form>
</body>

<script type="text/javascript" src="/NewFrame/js/jquery.js"></script>

<script type="text/javascript" src="/NewFrame/js/common.js"></script>

<script type="text/javascript">
    var height = $(window).height();
    $("#container").height(height);
    $("#bd").css("padding-top", height / 2 - $("#bd").height() / 2);

    $(window).resize(function() {
        var height = $(window).height();
        $("#bd").css("padding-top", $(window).height() / 2 - $("#bd").height() / 2);
        $("#container").height(height);

    });

    $('#remember').focus(function() {
        $(this).blur();
    });

    $('#remember').click(function(e) {
        checkRemember($(this));
    });

    function checkRemember($this) {
        if (! -[1, ]) {
            if ($this.prop("checked")) {
                $this.parent().addClass('checked');
            } else {
                $this.parent().removeClass('checked');
            }
        }
    }

    try {
        document.title = '<%=ConfigurationManager.AppSettings["WebTitle"] %>';
        if (window != top) {
            top.location.href = location.href;
        }
    }
    catch (e) { ; }


    //enter login
    function checkenter() {
        //alert(event.keyCode);
        if (event.keyCode == 13) {
            __doPostBack('but1', '');
        }
    }
</script>

</html>
</html>
