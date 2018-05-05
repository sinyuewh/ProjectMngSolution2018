<%-- Author:admin--%>
<%-- DateTime:2016/5/31 14:28:15--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JUserLoginLog_Detail.aspx.cs"
	Inherits="KORWeb.WebSite.admin183016269.JUserLoginLog_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <!--定义数据源-->
    <div style ="display:none">
        
    </div>
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="ID" />
        </ParaItems>
    </jasp:JDataSource>
    
    
    <!--定义数据豆-->
      <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
	    ControlList="ID,AuthorityGroup,CreateTime,UserID,UserName,Remark" NoSaveControlList =""
        TableName="JUserLoginLog" PrimaryKeys="ID"  IsAppendData="true" />
        
        
    <!--数据Form-->
    <div class="row cl"><label class="form-label col-3">ID：</label><div class="formControls col-5"><jasp:JTextBox class="input-text" ID="ID" runat="server" Caption="ID" AllowNullValue="false"  IsUnique ="true" UniqueTable ="JUserLoginLog" /></div><div class="col-4"></div></div>
	    
	    <div class="row cl"><label class="form-label col-3">AuthorityGroup：</label><div class="formControls col-5"><jasp:JTextBox class="input-text" ID="AuthorityGroup" runat="server" Caption="AuthorityGroup"     /></div><div class="col-4"></div></div>
	    
	    <div class="row cl"><label class="form-label col-3">CreateTime：</label><div class="formControls col-5"><jasp:JTextBox class="input-text" ID="CreateTime" runat="server" Caption="CreateTime"  DataType="DateTime"   /></div><div class="col-4"></div></div>
	    
	    <div class="row cl"><label class="form-label col-3">UserID：</label><div class="formControls col-5"><jasp:JTextBox class="input-text" ID="UserID" runat="server" Caption="UserID"     /></div><div class="col-4"></div></div>
	    
	    <div class="row cl"><label class="form-label col-3">UserName：</label><div class="formControls col-5"><jasp:JTextBox class="input-text" ID="UserName" runat="server" Caption="UserName"     /></div><div class="col-4"></div></div>
	    
	    <div class="row cl"><label class="form-label col-3">Remark：</label><div class="formControls col-5"><jasp:JTextBox class="input-text" ID="Remark" runat="server" Caption="Remark"     /></div><div class="col-4"></div></div>
     
    <div class="row cl">
        <div class="col-9 col-offset-3">
            <jasp:SecurityPanel ID="sec2" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$1|$$2">
				<input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
					value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
            </jasp:SecurityPanel>
                
             &nbsp;&nbsp;
            <button onclick="layer_close();" class="btn btn-default radius" type="button">
                &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
        </div>
    </div>

	<jasp:SecurityPanel ID="sec1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
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


