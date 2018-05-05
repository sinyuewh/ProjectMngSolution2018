<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Task_ImportExcel.aspx.cs"
MasterPageFile="~/SysManager/include/H-uiThird.Master" 
 Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Task_ImportExcel" %>

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
    </div>
    
        
    <div class="row cl">
        <label class="form-label col-3">
            工单Excel：</label>
        <div class="formControls col-7">
           <span class="select-box" >
                <jasp:JFileUpload ID="file1" runat="server" FileFilter="xls" 
                Caption ="工单Excel数据" class="input-text" AllowNullValue="false"  />
            </span>
        </div>
    </div>    
    <div class="row cl">
        <label class="form-label col-3">
            模块下载：</label>
        <div class="formControls col-7">
            <span class="operate">
            <a href="/Attachment/Data/Task.xls">[点击下载]</a>
            </span>
        </div>
    </div>   
    
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server">
        <div class="row cl">
            <div class="col-8 col-offset-3">
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
