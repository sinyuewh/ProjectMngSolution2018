<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="Tb_KH_Month_READ.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_KH_Month_READ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KH_Month" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="DataID" DataType="NumericType" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
        ControlList="DataID,byear,bmonth,UserName,FullLoad,WorkLoad1,WorkLoad2,WorkLoad3,Remark,UserID"
        NoSaveControlList="DataID" TableName="Tb_KH_Month" PrimaryKeys="DataID" IsAppendData="true" />
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="DataID" runat="server" DataType="Integer"  />
         <jasp:JTextBox ID="UserID" runat="server"   />
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            考核年月：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="byear" runat="server"
                Caption="排序" DataType="Integer" ReadOnly="true" Width="135px" />&nbsp;年&nbsp;
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="bmonth" runat="server"
                Caption="排序" DataType="Integer" ReadOnly="true" Width="135px" />&nbsp;月&nbsp;
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            用户姓名：</label>
        <div class="formControls col-6">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="UserName" runat="server"
                Width="315px" ReadOnly="true" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            考核工作量</label>
        <div class="formControls col-6">
            <jasp:JTextBox class="input-text" ID="FullLoad" runat="server" Width="315px" Caption="考核工作量"
                mydatatype="n" AllowNullValue="false" nullmsg="请输入考核工作量！" />
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            完成工作量</label>
        <div class="formControls col-8">
            Team:
            <jasp:JTextBox class="input-text" ID="WorkLoad1" runat="server" ReadOnly="true" Width="60px" />
            &nbsp;Code:
            <jasp:JTextBox class="input-text" ID="WorkLoad2" runat="server" ReadOnly="true" Width="60px" />
            &nbsp;Test:
            <jasp:JTextBox class="input-text" ID="WorkLoad3" runat="server" ReadOnly="true" Width="60px" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-6">
            <jasp:JTextBox class="input-text"  ID="Remark" runat="server"
                Width="315px" TextMode="MultiLine" Height="80px" />
        </div>
        <div class="col-4">
        </div>
    </div>
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="Tb_KH_Month_EDIT">
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
    
    <jasp:JTextBox ID="CanReadData" runat="server" Text="0" Visible="false"></jasp:JTextBox>
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage"
     ConditionControlID="CanReadData" >
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
