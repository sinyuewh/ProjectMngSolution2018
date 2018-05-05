<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetMyQuanXian.aspx.cs" 
MasterPageFile="~/SysManager/include/H-uiThird2.Master"
Inherits="OAWebSite2016.SysManager.WebUI.SysMng.SetMyQuanXian" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="javascript" type ="text/javascript">
        //设置权限
        function setQx(qxindex) 
        {
            var title = "设置读数据用户";
            var keyid="";
            var olduser1 = $('#<%=this.qx1.ClientID%>').val();
            var olduser2 = $('#<%=this.qx2.ClientID%>').val();
            var olduser3 = $('#<%=this.qx3.ClientID%>').val();
            var olduser4 = $('#<%=this.qx4.ClientID%>').val();
            var dataid = "";
            if (qxindex == 1) {
                dataid = olduser1;
                keyid ='<%=this.qx1.ClientID%>';
            }
            else if (qxindex == 2) {
                dataid = olduser2;
                keyid ='<%=this.qx2.ClientID%>';
            }
            else if (qxindex == 3) {
                dataid = olduser3;
                keyid ='<%=this.qx3.ClientID%>';
            }
            else {
                dataid = olduser4;
                keyid ='<%=this.qx4.ClientID%>';
            }
            var url = "SetUserQx.aspx?oldUsers=" + dataid + "&keyid=" + keyid;            
            layer_show(title, url, 450, 550);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 设置个人权限 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            工作备忘读权限：</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="qx1"  ToolTip="可以读你的工作备忘" TextMode="MultiLine" Height="60px"
                runat="server" class="input-text" ></jasp:JTextBox>
        </div>
        <div class="col-4">
            <jasp:JButton ID="but1" runat="server" Text="选择" class="btn btn-success radius" OnClientClick="javascript:setQx(1);return false;"></jasp:JButton>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            工作日志读权限：</label>
        <div class="formControls col-5">
           <jasp:JTextBox ID="qx2"  ToolTip="可以读你的工作日志" TextMode="MultiLine" Height="60px"
                runat="server" class="input-text" ></jasp:JTextBox>
        </div>
        <div class="col-4">
            <jasp:JButton ID="but2" runat="server" Text="选择" class="btn btn-success radius" OnClientClick="javascript:setQx(2);return false;"></jasp:JButton>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            工作计划读权限:</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="qx3"  ToolTip="可以读你的工作计划" TextMode="MultiLine" Height="60px"
                runat="server" class="input-text" ></jasp:JTextBox>
        </div>
        <div class="col-4">
            <jasp:JButton ID="but3" runat="server" Text="选择" class="btn btn-success radius" OnClientClick="javascript:setQx(3);return false;"></jasp:JButton>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            考核数据读权限:</label>
        <div class="formControls col-5">
            <jasp:JTextBox ID="qx4"  ToolTip="可以读你的考核数据" TextMode="MultiLine" Height="60px"
                runat="server" class="input-text" ></jasp:JTextBox>
        </div>
        <div class="col-4">
            <jasp:JButton ID="but4" runat="server" Text="选择" class="btn btn-success radius" OnClientClick="javascript:setQx(4);return false;"></jasp:JButton>
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
