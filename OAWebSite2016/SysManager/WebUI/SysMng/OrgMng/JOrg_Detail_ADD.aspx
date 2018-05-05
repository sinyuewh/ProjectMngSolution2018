<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JOrg_Detail_ADD.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JOrg_Detail_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JOrg" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="OrgID" />
        </ParaItems>
    </jasp:JDataSource>
    
    <div style="display:none">
        <jasp:JTextBox ID="AuthorityGroup"  runat="server" TextDefaultValue="AuthorityGroup"></jasp:JTextBox>
        <jasp:JTextBox class="input-text" AllowNullValue="false" ID="OrgID" runat="server"
                Caption="部门编码" IsUnique="true" UniqueTable="JOrg"  TextDefaultValue="Guid"  />
    </div>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,OrgID,OrgName,Parent,Status,AuthorityGroup"
        NoSaveControlList="" TableName="JOrg" PrimaryKeys="OrgID" IsAppendData="true" />
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            部门编码：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Num" runat="server"
                Caption="部门编码" />
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            部门名称：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="OrgName" runat="server" AllowNullValue="false"
                Caption="部门名称" mydatatype="*1-20" />
        </div>
        
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            上级部门：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="Parent" runat="server" Caption="上级部门" Visible="false" />
            <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="JOrg" OrderBy="num,orgid"
                FieldsList="orgid,orgname">
                <ParaItems>
                    <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Status=1" SearchOperator="UserDefine" />
                </ParaItems>
            </jasp:JDataSource>
            <span class="select-box" style="width:395px">
                <jasp:JDropDownList ID="Parent1" class="select" runat="server" Caption="上级部门" DataSourceID="data2"
                    DataTextField="orgName" DataValueField="orgid">
                </jasp:JDropDownList>
            </span>
        </div>
        
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            状态：</label>
        <div class="formControls col-8">
            <span class="select-box" style="width:395px">
                <jasp:JDropDownList ID="Status" class="select" runat="server" Caption="部门状态">
                    <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                    <asp:ListItem Text="停用" Value="0"></asp:ListItem>
                </jasp:JDropDownList>
            </span>
            
        </div>
    </div>
    <!--控制修改的权限-->
    <div class="row cl">
        <div class="col-9 col-offset-3">
            <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
            &nbsp;&nbsp;
            <button onclick="layer_close();" class="btn btn-default radius" type="button">
                &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
        </div>
    </div>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
         RoleID ="xtgl">
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
