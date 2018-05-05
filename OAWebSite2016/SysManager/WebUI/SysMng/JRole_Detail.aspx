<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JRole_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JRole_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JRole" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="RoleID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,RoleID,RoleName,Remark"
        NoSaveControlList="" TableName="JRole" PrimaryKeys="RoleID" IsAppendData="true" />
    
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            排序：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Num" runat="server"
                Caption="排序" DataType="Integer" TextDefaultValue="String1" mydatatype="n" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            角色ID：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="RoleID" runat="server"
                Caption="角色ID" IsUnique="true" UniqueTable="JRole" mydatatype="*1-20" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            角色名称：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" ID="RoleName" runat="server" AllowNullValue="false"
                Caption="角色名称" mydatatype="*1-20" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" ID="Remark" runat="server" 
                Caption="备注"  />
        </div>
        <div class="col-4">
        </div>
    </div>
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="JRole_EDIT">
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
        AuthorityID="JRole_READ">
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
