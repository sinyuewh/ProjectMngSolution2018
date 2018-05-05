<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassWord.aspx.cs" Inherits="OAWebSite2016.Plat_ZgDw.WebUI.HYhgl.ChangePassWord" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>修改密码</title>
<meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<script type="text/javascript" src="lib/PIE_IE678.js"></script>
<![endif]-->
    <link href="/H-ui.admin/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="/H-ui.admin/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="/H-ui.admin/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="/H-ui.admin/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="/H-ui.admin/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
    <!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->

    <script type="text/javascript" src="/H-ui.admin/lib/jquery/1.9.1/jquery.min.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/layer/1.9.3/layer.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/My97DatePicker/WdatePicker.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/icheck/jquery.icheck.min.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/Validform/5.3.2/Validform.min1.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/webuploader/0.1.5/webuploader.min.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/ueditor/1.4.3/ueditor.config.js"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/ueditor/1.4.3/ueditor.all.min.js"> </script>

    <script type="text/javascript" src="/H-ui.admin/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>

    <script type="text/javascript" src="/H-ui.admin/js/H-ui.js"></script>

    <script type="text/javascript" src="/H-ui.admin/js/H-ui.admin.js"></script>
</head>
<body>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 人员管理<span class="c-gray en">&gt;</span> 修改密码 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <form id="form1" class="form form-horizontal" runat="server">
        <!--导航区设置-->
        <asp:ScriptManager ID="script" runat="server">
        </asp:ScriptManager>
        <div class="row cl">
            <label class="form-label col-3">
                旧密码：</label>
            <div class="formControls col-3">
                <jasp:JTextBox class="input-text" TextMode="Password" AllowNullValue="false" ID="oldpass"
                    runat="server" Caption="原始密码" mydatatype="*3-20" nullmsg="请输入原始密码" />
            </div>
            <div class="col-4">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">
                新密码：</label>
            <div class="formControls col-3">
                <jasp:JTextBox class="input-text" TextMode="Password" AllowNullValue="false" ID="pass1"
                    runat="server" Caption="新密码" mydatatype="*3-20" nullmsg="请输入新密码" />
            </div>
            <div class="col-4">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">
                密码确认：</label>
            <div class="formControls col-3">
                <jasp:JTextBox class="input-text" TextMode="Password" AllowNullValue="false" ID="pass2"
                    runat="server" Caption="再次输入新密码" mydatatype="*3-20" nullmsg="请再次输入新密码" EqualControl="pass1" />
            </div>
            <div class="col-4">
            </div>
        </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <asp:UpdatePanel ID="update1" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="but1" class="btn btn-primary radius" runat="server" Text="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <script type="text/javascript">
        $(function() {
            $("#form1").Validform({
                tiptype: 2,
                btnSubmit:"#<%=this.but1.ClientID%>",
                callback: function(form) {
                    $('#<%=this.but1.ClientID%>').click();
                }
            });

        });
        </script>

        </form>
    </div>
</body>
</html>

