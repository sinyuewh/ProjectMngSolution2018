<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
     AutoEventWireup="true" CodeBehind="Tb_Project_Attachment_ADD.aspx.cs"
     Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_Attachment_ADD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" TableName="JAttachment" PrimaryKeys="guidID"
         ControlList="Stitle,Content"
        IsAppendData="true" />
    <!--数据Form-->
    <div style="display:none">
        <jasp:JTextBox ID="guidID" runat="server" TextDefaultValue="Guid" ></jasp:JTextBox>
        <jasp:JTextBox ID="parentGuid" runat="server" TextDefaultValue="RequestQueryString"></jasp:JTextBox>
    </div>
    
    
    <div class="row cl" id="sel1" runat="server">
        <label class="form-label col-3">
            选择项目：</label>
        <div class="formControls col-8">
            <span class="select-box">
                <jasp:AppDropDownList ID="selecProject" runat="server"  CssClass="select"
                   BlankValue="--请选择--" AllowNullValue="false"  Caption="选择项目" >
                </jasp:AppDropDownList>
            </span>
        </div>
       
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            文档类别：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Kind" runat="server"
                Caption="文档类别"  />
        </div>
       
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            文档描述：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" TextMode="MultiLine"  Height="200px"
               AllowNullValue="false" ID="Describle" runat="server"
                Caption="文档描述"  />
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            相关附件：</label>
        <div class="formControls col-8">
            <jasp:JFileUpload ID="file1" runat="server" class="input-text" />
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
