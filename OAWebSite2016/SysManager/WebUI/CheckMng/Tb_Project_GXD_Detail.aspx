<%@ Page Language="C#" AutoEventWireup="true" 
CodeBehind="Tb_Project_GXD_Detail.aspx.cs" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_Project_GXD_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KH_Project_Person"
        IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="DataID" DataType="NumericType"  />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <div style="display:none ">
        <jasp:JTextBox ID="DataID" runat="server" DataType="Integer"  />
        <jasp:JTextBox ID="WorkLoad" runat="server"   />
        <jasp:JTextBox ID="factWorkLoad" runat="server"   />
    </div>
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1"
        ControlList="DataID,WorkLoad,factWorkLoad,Remark,WorkRate"
        NoSaveControlList="DataID" TableName="Tb_KH_Project_Person" PrimaryKeys="DataID" />
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            加权系数：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="WorkRate" runat="server"
                Caption="加权系数" DataType="Numeric"   />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text"  ID="Remark" runat="server"
                Caption="备注"  TextMode="MultiLine"  Height="80px" />
        </div>
    </div>
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="ProjectGXD_EDIT">
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                    value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                &nbsp;&nbsp;
                <button onclick="layer_close();" class="btn btn-default radius" type="button">
                    &nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </jasp:SecurityPanel>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="ProjectGXD_EDIT">
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
