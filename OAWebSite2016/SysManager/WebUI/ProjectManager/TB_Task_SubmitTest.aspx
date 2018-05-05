<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="TB_Task_SubmitTest.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectManager.TB_Task_SubmitTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: none">
        <jasp:JTextBox ID="guidID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="parentGuid" runat="server"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            测试用户：</label>
        <div class="formControls col-10">
        
            <jasp:JDataSource ID="dataUserName" runat="server" JType="Table" SqlID="Tb_Project_Person inner join JUser on Tb_Project_Person.PersonID=JUser.UserID"
                OrderBy="Tb_Project_Person.num" FieldsList="JUser.UserID,JUser.UserName">
                <ParaItems>
                    <jasp:ParameterItem ParaName="xx" ParaType="String" DataName="status=1" SearchOperator="UserDefine" />
                    <jasp:ParameterItem  ParaName="parentGuid" ParaType="Control"  DataName ="ProjectGuidID" />
                </ParaItems>
            </jasp:JDataSource>
            
            <%--<%=this.data1.CommandText  %>--%>
            <span class="select-box" style="width: 80%">
                <jasp:JDropDownList ID="TestMan" runat="server" DataSourceID="dataUserName" DataTextField="UserName"
                    DataValueField="UserID" CssClass="select" Caption="测试用户">
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            测试地址：</label>
        <div class="formControls col-10">
            <jasp:JTextBox ID="TestUrl" runat="server" Caption="测试地址" class="input-text" Width="80%"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            补充说明：</label>
        <div class="formControls col-10">
            <jasp:JTextBox ID="Remark" runat="server" Caption="补充说明" class="input-text" TextMode="MultiLine"
                Height="120px" Width="80%"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            附件：</label>
        <div class="formControls col-10">
            <jasp:JFileUpload ID="file1" runat="server" class="input-text" AllowNullValue="false"
                Width="80%" />
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
