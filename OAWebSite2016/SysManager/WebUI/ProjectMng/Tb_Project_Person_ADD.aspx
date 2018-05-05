<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="Tb_Project_Person_ADD.aspx.cs" 
    Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_Person_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            排序：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="num" runat="server"
                Caption="排序" DataType="Integer" mydatatype="n" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            用户：</label>
        <div class="formControls col-5">
            <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUser" OrderBy="num" PageSize="-1"
                FieldsList="UserID,UserName">
                <ParaItems>
                    <jasp:ParameterItem ParaName="xx" ParaType="String" DataName="status=1 and userid<>'admin'" SearchOperator ="UserDefine"  />
                </ParaItems>
            </jasp:JDataSource>
            <%--<%=this.data1.CommandText  %>--%>
            <span class="select-box">
                <jasp:JDropDownList ID="PersonID" runat="server" DataSourceID="data1" DataTextField="UserName"
                    DataValueField="UserID" CssClass="select" AllowNullValue="false"  Caption="用户">
                </jasp:JDropDownList>
            </span>
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            岗位：</label>
        <div class="formControls col-5">
            <span class="select-box">
                <jasp:AppDropDownList ID="PrjRole" runat="server" KeyItem="ProjectRole" CssClass="select"
                   BlankValue="--请选择--" AllowNullValue="false"  Caption="岗位" >
                </jasp:AppDropDownList>
            </span>
        </div>
        <div class="col-4">
        </div>
    </div>
    
    <div class="row cl" style="display:none">
        <label class="form-label col-3">
            系数：</label>
        <div class="formControls col-5">
            <span class="select-box">
                <jasp:AppDropDownList ID="Weight" runat="server" KeyItem="ProjectRate" CssClass="select"
                    BlankValue="--请选择--"   Caption="系数" >
                </jasp:AppDropDownList>
            </span>
        </div>
        <div class="col-4">
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
    </script>

</asp:Content>
