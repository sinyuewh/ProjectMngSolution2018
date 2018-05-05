<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Project_Money_ADD.aspx.cs" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
Inherits="OAWebSite2016.SysManager.WebUI.ProjectLogMng.Tb_Project_Money_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project_Log" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="GuidID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <div style="display: none">
          <jasp:JTextBox ID="parentGuid" runat="server" TextDefaultValue="RequestQueryString"></jasp:JTextBox>
          <jasp:JTextBox ID="AddUserID" runat="server" TextDefaultValue="UserID"></jasp:JTextBox>
          <jasp:JTextBox ID="AddUserName" runat="server" TextDefaultValue="UserName"></jasp:JTextBox>
          <jasp:JTextBox ID="AddTime" runat="server" TextDefaultValue="Now" DataType="DateTime"></jasp:JTextBox>
         <%-- <jasp:JTextBox ID="DataID" runat="server"  Text="0" DataType="Integer"  ></jasp:JTextBox>--%>
          
          <jasp:JTextBox ID="UserName" runat="server"></jasp:JTextBox>
    </div>
    
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
        ControlList="parentGuid,AddUserID,AddUserName,AddTime,UserName,UserID,ProjectMoney,MoneyTime,Remark"
         TableName="Tb_Project_Money" 
        PrimaryKeys="DataID" IsAppendData="true" />
    <!--数据Form-->
    
    <div class="row cl">
        <label class="form-label col-3">
            经手人：</label>
        <div class="formControls col-8">
            <span class="select-box">
                <jasp:JDropDownList ID="UserID" runat="server" CssClass="select" AllowNullValue="false" Caption ="经手人">                  
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            支出金额：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="ProjectMoney" runat="server"
                Caption="支出金额"  DataType="Numeric"  TextDefaultValue="String0"   />
        </div>
    </div>
    
     <div class="row cl">
        <label class="form-label col-3">
            支出时间：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="MoneyTime" runat="server"
                Caption="支出时间"  DataType="DateTime"   />
        </div>
    </div>  
    
    <div class="row cl">
        <label class="form-label col-3">
            支出说明：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text"  ID="Remark" runat="server"
                Caption="支出说明"  />
        </div>
    </div>
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server">
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button" runat="server" id="btnClose">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
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
