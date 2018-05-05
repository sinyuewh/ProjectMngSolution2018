<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_PL_Month_Detail.aspx.cs" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_PL_Month_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_PL_Month"
        IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="CheckDataID" DataType="NumericType"  />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <div style="display: none">
        <jasp:JTextBox ID="CheckDataID" runat="server" DataType="Integer"  />
    </div>
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="CheckDataID,TotalWork,Remark"
        NoSaveControlList="" TableName="Tb_PL_Month" PrimaryKeys="CheckDataID" />
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            全额工作量：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="TotalWork" runat="server"
                Caption="全额工作量" DataType="Integer"  mydatatype="n" />
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
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="Tb_PL_Month_EDIT">
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
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
        AuthorityID="Tb_PL_Month_EDIT">
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
