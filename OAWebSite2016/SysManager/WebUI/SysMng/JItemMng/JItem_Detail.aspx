<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JItem_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JItem_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JItem" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="ItemName" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
         ControlList="Num,ItemName,Remark"
        NoSaveControlList="" TableName="JItem" PrimaryKeys="ItemName" IsAppendData="true" />
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            排序：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="Num" runat="server"
                Caption="排序" DataType="Integer" TextDefaultValue="String1" mydatatype="n" />
        </div>
       
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            条目名称：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="ItemName" runat="server"
                Caption="条目名称" IsUnique="true" UniqueTable="JItem" mydatatype="*1-20" />
        </div>
        
    </div>
   
    
    
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox ID="Remark" runat="server" Caption="备注" class="input-text" TextMode="MultiLine" Height ="80px"></jasp:JTextBox>
        </div>
        
    </div>
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" RoleID="xtgl">
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
    <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityKind="DirectNoAccessPage" RoleID="xtgl">
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
