<%@ Page Language="C#" AutoEventWireup="true" 
MasterPageFile="~/SysManager/include/H-uiThird.Master"
CodeBehind="Tb_KaoHeZhiBiao_ADD.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_KaoHeZhiBiao_ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KaoHeZhiBiao" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="KHID" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <div style="display:none">
        <jasp:JTextBox ID="createtime" runat="server"  TextDefaultValue="Now"  />
        <jasp:JTextBox ID="Status" runat="server"  TextDefaultValue="String1"  />
    </div>
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
         ControlList="num,KHID,KhRemark,KhScore,remark,createtime,Status"
        NoSaveControlList="" TableName="Tb_KaoHeZhiBiao" PrimaryKeys="KHID" IsAppendData="true" />
    <!--数据Form-->
    <div class="row cl">
        <label class="form-label col-3">
            排序：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="num" runat="server"
                Caption="排序" DataType="Integer" TextDefaultValue="String1" mydatatype="n" />
        </div>
       
    </div>
    <div class="row cl">
        <label class="form-label col-3">
            考核编码：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="KHID" runat="server"
                Caption="考核编码" IsUnique="true" UniqueTable="Tb_KaoHeZhiBiao" 
                mydatatype="*1-20" />
        </div>
       
    </div>
    
    
    <div class="row cl">
        <label class="form-label col-3">
            考核规范：</label>
        <div class="formControls col-8">
            <jasp:JTextBox ID="KhRemark" runat="server" TextMode="MultiLine" 
             Height="120px" Caption="考核规范" class="input-text"></jasp:JTextBox>
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            分值：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="KhScore" runat="server"
                Caption="分值" DataType="Integer" TextDefaultValue="String1" mydatatype="n" />
        </div>
        
    </div>
    
    <div class="row cl">
        <label class="form-label col-3">
            备注：</label>
        <div class="formControls col-8">
            <jasp:JTextBox class="input-text"  ID="remark" runat="server"  Caption="备注" />
        </div>
       
    </div>
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="Tb_KaoHeZhiBiao_ADD">
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
        AuthorityID="Tb_KaoHeZhiBiao_ADD">
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


