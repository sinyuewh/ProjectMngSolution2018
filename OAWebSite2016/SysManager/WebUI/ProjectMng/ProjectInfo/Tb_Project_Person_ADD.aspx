<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="Tb_Project_Person_ADD.aspx.cs" 
    Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_Person_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="javascript" src="/js/PubLib.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" TableName="Tb_Project_Person" PrimaryKeys="guidID"
         ControlList="num,PersonID,PrjRole,Weight"
        IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="guidID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="parentGuid" runat="server" TextDefaultValue="RequestQueryString"></jasp:JTextBox>
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            用户ID：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="UserID" runat="server"
                Caption="用户ID"  TextMode="MultiLine" Height="100px"
                 ToolTip="点击选择用户的ID"
                onclick="javascript:SelectUserIDS();" />
        </div>
        
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            岗位：</label>
        <div class="formControls col-8">
            <span class="select-box">
                <jasp:AppDropDownList ID="PrjRole" runat="server" KeyItem="ProjectRole" CssClass="select"
                   BlankValue="--请选择--" AllowNullValue="false"  Caption="岗位" >
                </jasp:AppDropDownList>
            </span>
        </div>
        
    </div>
    
        
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" >
        <div class="row cl">
            <div class="col-10 col-offset-2">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
        >
    </jasp:SecurityPanel>

    <script type="text/javascript">
        $(function() {
            $("#aspnetForm").Validform({
                tiptype: 2,
                callback: function(form) {

                }
            });
        });
        
        
        function SelectUserIDS() {
            var parentid = '<%=this.UserID.ClientID %>';
            var oldValue = $('#' + parentid).val();
            myOpenURL("SelectProjectPerson.aspx?parentid=" + parentid + "&oldUsers=" + oldValue, 600, 400);
        }
    </script>

</asp:Content>
