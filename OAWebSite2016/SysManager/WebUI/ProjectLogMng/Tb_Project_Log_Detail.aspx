<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
CodeBehind="Tb_Project_Log_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectLogMng.Tb_Project_Log_Detail" %>

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
        <jasp:JTextBox ID="GuidID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="AddUserID" runat="server"></jasp:JTextBox>
    </div>
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="GuidID,Stitle,Content,PlanTime,FinishTime,Remark,AddUserID"
        NoSaveControlList="" TableName="Tb_Project_Log" PrimaryKeys="GuidID" IsAppendData="true" />
    <!--数据Form-->
    
    <div class="row cl">
        <label class="form-label col-3">
            标题：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Stitle" runat="server"
                Caption="标题" ToolTip="提交后，将不能修改" />
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            正文：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Content" runat="server"
                Caption="正文" Height="280px" TextMode="MultiLine"  />
        </div>
    </div>
    
     <div class="row cl">
        <label class="form-label col-3">
            计划完成：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text"  ID="PlanTime" runat="server" DataType="DateTime"
                Caption="计划完成" onclick="$.calendar();" ToolTip="提交后，将不能修改"  />
        </div>
        
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            实际完成：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text"  ID="FinishTime" runat="server" DataType="DateTime"
                Caption="实际完成"  onclick="$.calendar();" ToolTip="提交后，将不能修改" />
        </div>
    </div>
        
        
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" ID="Remark" runat="server"  Caption="备注"  />
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
