<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="TB_Task_Detail_ADD.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectManager.TB_Task_Detail_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/kindeditor-4.1.2/kindeditor-min.js" type="text/javascript"></script>

    <script src="/kindeditor-4.1.2/lang/zh_CN.js" type="text/javascript"></script>

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        KindEditor.ready(function(K) {
            K.create('#<%=content.ClientID %>',
            {
                themeType: 'simple',
                resizeType: 1,
                allowPreviewEmoticons: false,
                cssPath: '/kindeditor-4.1.2/plugins/code/prettify.css',
                uploadJson: '/Handler/upload_json.ashx',
                fileManagerJson: '/Handler/file_manager_json.ashx',
                allowImageUpload: true,                                       //是否允许本地上传文件
                afterCreate: function() { this.sync(); },
                afterBlur: function() { this.sync(); },
                items: [
					'source', 'fullscreen', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', '|', 'emoticons', 'image', 'link']
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" ControlList="ProjectGuidID,GuidID,TaskTitle,TaskKind,content,contentText,begDate,endDate,ExecuteMan,Remark,Workload"
        TableName="Tb_Task" PrimaryKeys="GuidID" IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="contentText" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="GuidID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            工单项目：</label>
        <div class="formControls col-10">
            <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="Tb_Project" PageSize="-1"
                OrderBy="begDate desc" FieldsList="prjName,GuidID">
                <ParaItems>
                    <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="(Status =1 or Status=2)" SearchOperator="UserDefine" />
                    <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UserID" ParaName="xx"
                        DataName=" exists (select 1 from Tb_Project_Person where ProjectGuidID=Tb_Project.Guidid and PrjRole='0' and PersonID='{0}') "
                        SearchOperator="UserDefine" />
                </ParaItems>
            </jasp:JDataSource>
            <%--<%=this.data1.CommandText  %>--%>
            <span class="select-box" style="width: 80%">
                <jasp:JDropDownList ID="ProjectGuidID" runat="server" DataSourceID="data2" DataTextField="prjName"
                    DataValueField="GuidID" CssClass="select" Caption="工单项目">
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            工单标题：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="TaskTitle" runat="server"
                Caption="工单标题" mydatatype="*4-200" Width="80%" ToolTip="工单的标题字数在4-200以内" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            工单类型：</label>
        <div class="formControls col-10">
            <span class="select-box" style="width: 80%">
                <jasp:JDropDownList ID="TaskKind" runat="server" CssClass="select" Caption="工单类型">
                    <asp:ListItem Text="开发工单" Value=""></asp:ListItem>
                    <asp:ListItem Text="非开发工单" Value="1"></asp:ListItem>
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            工单内容：</label>
        <div class="formControls col-10">
            <jasp:JTextBox ID="content" runat="server" TextMode="MultiLine" Height="250" Width="80%"
                Caption="工单内容"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            计划时间：</label>
        <div class="formControls col-3">
            <jasp:JTextBox class="input-text" ID="begDate" runat="server" Caption="计划开始" DataType="DateTime"
                onclick="$.calendar();" AllowNullValue="false" Width="40%" />&nbsp;至&nbsp;
            <jasp:JTextBox class="input-text" ID="endDate" runat="server" Caption="计划结束时间" DataType="DateTime"
                onclick="$.calendar();" AllowNullValue="false" Width="40%" />
        </div>
        <label class="form-label col-2">
            工作量预估（小时）：</label>
        <div class="formControls col-3">
            <jasp:JTextBox ID="Workload" runat="server" Caption="工作量预估" DataType="Numeric" TextDefaultValue="String8"
                class="input-text"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            接单人：</label>
        <div class="formControls col-3">
            <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project_Person inner join JUser on Tb_Project_Person.PersonID=JUser.UserID"
                OrderBy="Tb_Project_Person.num" FieldsList="JUser.UserID,JUser.UserName">
                <ParaItems>
                    <jasp:ParameterItem ParaName="xx" ParaType="String" DataName="status=1" SearchOperator="UserDefine" />
                    <jasp:ParameterItem ParaName="ProjectGuidID" ParaType="RequestQueryString" />
                </ParaItems>
            </jasp:JDataSource>
            <%--<%=this.data1.CommandText  %>--%>
            <span class="select-box">
                <jasp:JDropDownList ID="ExecuteMan" runat="server" DataSourceID="data1" DataTextField="UserName"
                    DataValueField="UserID" CssClass="select" Caption="接单人">
                </jasp:JDropDownList>
            </span>
        </div>
        <label class="form-label col-2">
            附件：</label>
        <div class="formControls col-3">
            <jasp:JFileUpload ID="file1" runat="server" Caption="附件" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            补充说明：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" ID="Remark" runat="server" Caption="补充说明" Width="80%" />
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
                    &nbsp;&nbsp;关闭&nbsp;&nbsp;</button>
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
