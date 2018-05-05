<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_KaoHeOther_ADD.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiThird.Master" 
    Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_KaoHeOther_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/EasyUI/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/EasyUI/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="/EasyUI/demo/demo.css" />

  <%--  <script type="text/javascript" src="/EasyUI/jquery.min.js"></script>--%>

    <script type="text/javascript" src="/EasyUI/jquery.easyui.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据豆-->
    <div style="display: none">
        <jasp:JTextBox ID="createtime" runat="server" TextDefaultValue="Now" />
        <jasp:JTextBox ID="KHID" runat="server" TextDefaultValue="RequestQueryString" />
        <jasp:JTextBox ID="KhRemark" runat="server" />
        <jasp:JTextBox ID="KhScore" runat="server" />
         <jasp:JTextBox class="input-text" AllowNullValue="false" ID="UserID" runat="server"
                Caption="用户ID"  />
    </div>
    <!--数据Form-->
    <div class="row cl" style="margin-top:-10px">
        <label class="form-label col-3">
            用户ID：</label>
        <div class="formControls col-8">
            <%--/EasyUI/demo/combotree/tree_data1.json--%>
            <%--/SysManager/WebUI/PubLib/GetEasyUITreeData.aspx?dataKind=99&oldUsers=--%>
            <input id="cc" class="easyui-combotree" data-options="url:'/SysManager/WebUI/PubLib/GetEasyUITreeData.aspx?dataKind=99&oldUsers=-1',method:'get',required:true"
                style="width: 360px; height:28px" runat="server" >
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            考核次数：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="KHCount" runat="server"
                Caption="考核次数" TextDefaultValue="String1" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="remark" runat="server" TextMode="MultiLine"
                Height="120px" Caption="备注" AllowNullValue="false" mydatatype="*5-200"  />
        </div>
    </div>
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="Tb_KaoHeOther_ADD">
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" onclick="javascript:setUserID();" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
        AuthorityID="Tb_KaoHeOther_ADD">
    </jasp:SecurityPanel>

    <script type="text/javascript">
        $(function() {
             $("#aspnetForm").Validform({
                tiptype: 2,
                callback: function(form) {
                    
                }
            });
        });

        function setUserID() {
            var val = $('#<%=this.cc.ClientID %>').combotree('getValue');
            $('#<%=this.UserID.ClientID %>').val(val);
        }
    </script>

</asp:Content>
