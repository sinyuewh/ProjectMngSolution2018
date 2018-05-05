<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JStrInfo_Detail.aspx.cs"
     ValidateRequest="false" 
    Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JStrInfo_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/kindeditor-4.1.2/kindeditor-min.js" type="text/javascript"></script>

    <script src="/kindeditor-4.1.2/lang/zh_CN.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        KindEditor.ready(function(K) {
            K.create('#<%=StrText.ClientID %>',
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
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JStrInfo" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="strID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,strID,StrText,StrText1,Remark"
        NoSaveControlList="" TableName="JStrInfo" PrimaryKeys="strID" IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="StrText1" runat="server"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            排序：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Num" runat="server"
                Caption="排序" DataType="Integer" TextDefaultValue="String1" mydatatype="n" Width="80%" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            配置Key：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="strID" runat="server"
                Caption="配置Key" IsUnique="true" UniqueTable="JStrInfo" mydatatype="*1-20" Width="80%" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            配置Value：</label>
        <div class="formControls col-10">
            <jasp:JTextBox ID="StrText" runat="server" TextMode="MultiLine" Height="250" Width="80%"
                Caption="配置Value"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-2">
            备注：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" ID="Remark" runat="server" Caption="备注" Width="80%" />
        </div>
    </div>
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="JStrInfo_EDIT">
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
        AuthorityID="JStrInfo_READ">
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
