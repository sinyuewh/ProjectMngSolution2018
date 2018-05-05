<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
CodeBehind="UploadAttachment.aspx.cs" 
Inherits="OAWebSite2016.SysManager.WebUI.ProjectLogMng.UploadAttachment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" 
        TableName="JAttachment" PrimaryKeys="guidID" IsAppendData="true" />
        
    <!--数据Form-->
    <div style="display:none">
        <jasp:JTextBox ID="guidID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
        <jasp:JTextBox ID="parentGuid" runat="server"  TextDefaultValue="RequestQueryString"></jasp:JTextBox>
    </div>
   
    <div class="row cl">
        <label class="form-label col-3">
            附件上传：</label>
        <div class="formControls col-6">
            <jasp:JFileUpload ID="file1" runat="server" class="input-text" AllowNullValue="false" Width="80%" />
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
