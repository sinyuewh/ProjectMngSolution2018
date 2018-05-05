<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Task_Detail_Add.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiThird.Master" 
    Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Task_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <!--数据Form-->
    <div style="display:none">
        <jasp:JTextBox ID="parentGuid" runat="server" TextDefaultValue="RequestQueryString"></jasp:JTextBox>
        <jasp:JTextBox ID="BigKind" runat="server" TextDefaultValue="String0"></jasp:JTextBox>
        <jasp:JTextBox ID="TaskId" runat="server" TextDefaultValue="String0"></jasp:JTextBox>
        <jasp:JTextBox ID="GuidID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
    </div>
    
    <jasp:JDataBean ID="bean1" runat="server" 
        ControlList="parentGuid,BigKind,TaskKind,TaskTitle,content,ImportGrade,TimeGrade,Workload,PlanDate,GuidID"
        NoSaveControlList="TaskId" TableName="Tb_Task" PrimaryKeys="TaskId" IsAppendData="true" />
    
    <div class="row cl">
        <label class="form-label col-2">
            分类：</label>
        <div class="formControls col-8">
           <span class="select-box" >
                <jasp:AppDropDownList ID="TaskKind" runat="server" Caption ="工单分类" CssClass="select"
                  KeyItem="TaskKind"></jasp:AppDropDownList>
            </span>
        </div>
    </div>    
    <div class="row cl">
        <label class="form-label col-2">
            模块：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="TaskTitle" runat="server"
                Caption="工单模块"  />
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            工单内容：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="content" runat="server"
                Caption="工单内容"  TextMode="MultiLine" Height="200px" />
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            重要程度：</label>
        <div class="formControls col-8">
            <span class="select-box" >
                <jasp:AppDropDownList ID="ImportGrade" runat="server" Caption ="重要程度" CssClass="select"
                  KeyItem="ImportGrade"></jasp:AppDropDownList>
            </span>
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            紧急程度：</label>
        <div class="formControls col-8">
            <span class="select-box" >
                <jasp:AppDropDownList ID="TimeGrade" runat="server" Caption ="紧急程度" CssClass="select"
                  KeyItem="TimeGrade"></jasp:AppDropDownList>
            </span>
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            要求完成：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="PlanDate" runat="server"
                Caption="要求完成" onclick="$.calendar();" DataType="DateTime" />
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            预估工时：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Workload" runat="server"
                Caption="预估工时"  DataType="Integer"  TextDefaultValue="String8" />
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
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage">
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
