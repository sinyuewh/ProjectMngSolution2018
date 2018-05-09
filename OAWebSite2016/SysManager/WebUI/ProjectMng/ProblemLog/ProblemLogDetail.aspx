<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProblemLogDetail.aspx.cs" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.ProblemLog.ProblemLogEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据豆-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project_LogView" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="GuidID" />
        </ParaItems>
    </jasp:JDataSource>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            项目编号：</label>
        <div class="formControls col-8">
            <%=this.data1.Eval("prjNum") %>
        </div>
       
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            问题描述：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" TextMode="MultiLine"  Height="160px"
               AllowNullValue="false" ID="Content" runat="server"
                Caption="问题描述"  />
        </div>
        
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            严重程度：</label>
        <div class="formControls col-8">
            <span class="select-box">
                <jasp:AppDropDownList ID="Degree" class="select" runat="server" Caption="严重程度" KeyItem="ProbleGrade" >
                   
                </jasp:AppDropDownList>
            </span>
        </div>
       
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text"  ID="Remark" runat="server"  Caption="备注"  />
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
