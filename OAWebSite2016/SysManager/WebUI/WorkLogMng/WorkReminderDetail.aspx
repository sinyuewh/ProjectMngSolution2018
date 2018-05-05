<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkReminderDetail.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiThird.Master" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.WorkReminderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
     <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_WorkReminder" FieldsList="*"
        IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="LogID" />
        </ParaItems>
    </jasp:JDataSource>
    
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
        ControlList="LogID,AddUserID,begDate,JB,LogContent,AddTime,IsDone"
        TableName="Tb_WorkReminder" PrimaryKeys="LogID" IsAppendData="true" />  
    
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="LogID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
        <jasp:JTextBox ID="AddUserID" runat="server" TextDefaultValue="UserID"></jasp:JTextBox>
         <jasp:JTextBox ID="AddUserName" runat="server" TextDefaultValue="UserName"></jasp:JTextBox>
        <jasp:JTextBox ID="AddTime" runat="server" TextDefaultValue="Now" ></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            备忘日期：</label>
        <div class="formControls col-9">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="begDate" runat="server"
               onclick="$.calendar();"  DataType="DateTime"  />
        </div>
    </div>
     <div class="row cl">
        <label class="form-label col-2">
            重要程度：</label>
        <div class="formControls col-9">
            <span class="select-box">
                <jasp:JDropDownList ID="JB" runat="server" CssClass="select">
                    <asp:ListItem Text ="A" Value="A"></asp:ListItem>
                    <asp:ListItem Text ="B" Value="B"></asp:ListItem>
                    <asp:ListItem Text ="C" Value="C"></asp:ListItem>
                </jasp:JDropDownList>             
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            备忘内容：</label>
        <div class="formControls col-9">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="LogContent" runat="server"
                Caption="备忘内容" mydatatype="*10-500" TextMode="MultiLine" Height="250px" />
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            处理标志：</label>
        <div class="formControls col-9">
            <jasp:JCheckBox ID="IsDone" runat="server" />            
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
