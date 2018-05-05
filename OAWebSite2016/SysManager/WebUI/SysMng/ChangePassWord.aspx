<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird2.Master"
    AutoEventWireup="true" CodeBehind="ChangePassWord.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.ChangePassWord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 修改密码 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            旧密码：</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="oldPass" TextMode="Password" Caption="旧密码" AllowNullValue="false"
                runat="server" class="input-text" mydatatype="*3-20" nullmsg="请输入旧密码！"></jasp:JTextBox>
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            新密码:：</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="pass1" TextMode="Password" Caption="新密码" AllowNullValue="false"
                runat="server" class="input-text" mydatatype="*3-20" nullmsg="请输入新密码！"></jasp:JTextBox>
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            再次输入:</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="pass2" TextMode="Password" Caption="再次输入" AllowNullValue="false"
                EqualControl="pass1" runat="server" mydatatype="*" class="input-text Validform_error"
                errormsg="您两次输入的新密码不一致！" nullmsg="请再输入一次新密码！" recheck="ctl00$ContentPlaceHolder1$pass1"></jasp:JTextBox>
        </div>
        <div class="col-4">
        </div>
    </div>
    <!--控制修改的权限-->
    <asp:ScriptManager ID="script" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="update1" runat="server">
        <ContentTemplate>
            <div class="row cl">
                <div class="col-9 col-offset-3">
                    <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                        value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        $(function() {
            $("#aspnetForm").Validform({
                tiptype: 2,
                callback: function(form) {

                }
            });
        });
    </script>

</asp:Content>
