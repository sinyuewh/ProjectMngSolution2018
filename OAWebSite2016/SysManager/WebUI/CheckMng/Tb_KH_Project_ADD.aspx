<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    CodeBehind="Tb_KH_Project_ADD.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_KH_Project_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row cl">
        <label class="form-label col-3">
            年份：</label>
        <div class="formControls col-7">
            <span class="select-box">
                <jasp:AppDropDownList ID="byear" runat="server" CssClass="select"
                 AutoPostBack="true" >
                </jasp:AppDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            考核的项目：</label>
        <div class="formControls col-7">
            <span class="select-box">
                <jasp:AppDropDownList ID="ProjectGuidID" runat="server" CssClass="select">
                </jasp:AppDropDownList>
            </span>
        </div>
    </div>
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="Tb_KH_Project_ADD">
        <div class="row cl">
            <div class="col-8 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
        AuthorityID="Tb_KH_Project_ADD">
    </jasp:SecurityPanel>

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
