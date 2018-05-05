<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="Tb_Project_Detail_ADD.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_Detail_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="prjNum" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <div style="display:none">
        <jasp:JTextBox ID="guidID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
        <jasp:JTextBox ID="Status" runat="server" TextDefaultValue="String0"></jasp:JTextBox>
        <jasp:JTextBox ID="FinishDate" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="DepartID" runat="server" TextDefaultValue="DepartID" ></jasp:JTextBox>
        <jasp:JTextBox ID="Author" runat="server" TextDefaultValue="UserID" ></jasp:JTextBox>
        <jasp:JTextBox ID="CreateTime" runat="server"  TextDefaultValue="Now" ></jasp:JTextBox>
    </div>
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="prjNum,prjName,clientName,begDate,endDate,Remark,guidID,Status,FinishDate,DepartID,Author,CreateTime"
        NoSaveControlList="" TableName="Tb_Project" PrimaryKeys="prjNum" IsAppendData="true" />
    <!--数据Form-->
    
    <div class="row cl">
        <label class="form-label col-3">
            项目编号：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="prjNum" runat="server"
                Caption="项目编号" IsUnique="true" UniqueTable="Tb_Project" mydatatype="*2-20" />
        </div>
        <div class="col-4">
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            项目名称：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="prjName" runat="server"
                Caption="项目名称" mydatatype="*2-50" />
        </div>
        <div class="col-4">
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            客户：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text"  ID="clientName" runat="server"
                Caption="客户" />
        </div>
        <div class="col-4">
        </div>
    </div>      
        
    <div class="row cl">
        <label class="form-label col-3">
            项目日期：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="begDate" runat="server" AllowNullValue="false"
                Caption="开始日期" onclick="$.calendar();" Width="143px" /> <b>至</b>
                <jasp:JTextBox class="input-text" ID="endDate" runat="server" AllowNullValue="false"
                Caption="预计结束日期" onclick="$.calendar();" Width="143px" />
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-5">
            <jasp:JTextBox class="input-text" ID="Remark" runat="server"  Caption="备注"  TextMode="MultiLine" Height ="150px" />
        </div>
        <div class="col-4">
        </div>
    </div>
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" RoleID="xmgl">
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
        RoleID="xmgl">
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
