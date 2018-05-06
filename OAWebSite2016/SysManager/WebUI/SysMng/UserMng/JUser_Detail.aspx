<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JUser_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JUser_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        
    </div>
    
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUser" FieldsList="*"
        IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="UserID" />
        </ParaItems>
    </jasp:JDataSource>
    
        
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,UserID,UserName,Status,Gw,DepartID"
       TableName="JUser" PrimaryKeys="UserID" IsAppendData="true" />    
        
        
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            排序：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Num" runat="server"
                Caption="排序" DataType="Integer" TextDefaultValue="String1" mydatatype="n" />
        </div>
        
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            用户ID：</label>
        <div class="formControls col-8">
            <jasp:JTextBox ID="UserID" Caption="用户ID" class="input-text" AllowNullValue="false"
                IsUnique="true" UniqueTable="JUser" runat="server" mydatatype="*2-20"></jasp:JTextBox>
        </div>
        
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            姓名：</label>
        <div class="formControls col-8">
            <jasp:JTextBox ID="UserName" Caption="用户名称" AllowNullValue="false" runat="server"
                class="input-text" mydatatype="*2-20"></jasp:JTextBox>
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            所在部门：</label>
        <div class="formControls col-8">    
            <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="JOrg" OrderBy="num,orgid" FieldsList="orgid,orgname" >
                <ParaItems>
                    <jasp:ParameterItem ParaType="Control" ParaName="OrgID" SearchOperator="NotEqual" />
                    <jasp:ParameterItem ParaType="String"  ParaName="xx" DataName="Status=1"  SearchOperator="UserDefine" />
                </ParaItems>
            </jasp:JDataSource>         
            <span class="select-box">
                <jasp:JDropDownList ID="DepartID" class="select" runat="server" Caption="所在部门"
                 DataSourceID="data2" DataTextField="orgName" DataValueField="orgid">
                </jasp:JDropDownList>
            </span>
        </div>
        
    </div>
    
       
    <div class="row cl">
        <label class="form-label col-3">
            状态：</label>
        <div class="formControls col-8">
            <span class="select-box">
                <jasp:JDropDownList ID="Status" class="select" runat="server" Caption="状态">
                    <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                    <asp:ListItem Text="停用" Value="0"></asp:ListItem>
                </jasp:JDropDownList>
            </span>
            
        </div>
    </div>
    
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" RoleID="xtgl">
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
    
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage" RoleID="xtgl">
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
