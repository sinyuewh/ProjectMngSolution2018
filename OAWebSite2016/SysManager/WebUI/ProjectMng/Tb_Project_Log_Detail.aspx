<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
CodeBehind="Tb_Project_Log_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_Log_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="Tb_Project_Log" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="GuidID" />
        </ParaItems>
    </jasp:JDataSource>
    
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" TableName="Tb_Project_Log" PrimaryKeys="GuidID" DataSourceID="data2"
         ControlList="GuidID,Stitle,Content,parentGuid"
        IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="GuidID" runat="server" ></jasp:JTextBox>
         <jasp:JTextBox ID="parentGuid" runat="server"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            标题：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Stitle" runat="server"
                Caption="标题"  />
        </div>
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            正文：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" TextMode="MultiLine"  Height="250px"
               AllowNullValue="false" ID="Content" runat="server"
                Caption="正文"  />
        </div>
        
    </div>
    
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server">
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
