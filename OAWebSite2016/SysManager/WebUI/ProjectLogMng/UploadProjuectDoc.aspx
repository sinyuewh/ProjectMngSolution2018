<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    CodeBehind="UploadProjuectDoc.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectLogMng.UploadProjuectDoc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" TableName="JAttachment" PrimaryKeys="guidID"
        IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="guidID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
        <jasp:JTextBox ID="UploadTime" runat="server" TextDefaultValue="Now"></jasp:JTextBox>
        <jasp:JTextBox ID="UploadPerson" runat="server" TextDefaultValue="UserName"></jasp:JTextBox>
        <jasp:JTextBox ID="ProjectDoc" runat="server" TextDefaultValue="String1"></jasp:JTextBox>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            项目名称：</label>
        <div class="formControls col-6">
            <span class="select-box" width="80%">
                <jasp:JDropDownList ID="parentGuid" runat="server" CssClass="select">
                    
                </jasp:JDropDownList>
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            文档类别：</label>
        <div class="formControls col-6">
            <span class="select-box" width="80%">
                <jasp:AppDropDownList ID="ProjectDocKind" runat="server" CssClass="select" KeyItem="ProjectDocKind">
                </jasp:AppDropDownList> 
                
            </span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            文档说明：</label>
        <div class="formControls col-6">
            <jasp:JTextBox ID="Describle" runat="server" class="input-text"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-6">
            <jasp:JTextBox ID="Remark" runat="server"  class="input-text"></jasp:JTextBox>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            文件上传：</label>
        <div class="formControls col-6">
            <jasp:JFileUpload ID="file1" runat="server" class="input-text" AllowNullValue="false"
                 />
        </div>
    </div>
    
    
    <!--控制修改的权限-->
    <div class="row cl">
        <div class="col-10 col-offset-2">
            <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
            &nbsp;&nbsp;
            <button onclick="layer_close();" class="btn btn-default radius" type="button">
                &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
        </div>
    </div>

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
