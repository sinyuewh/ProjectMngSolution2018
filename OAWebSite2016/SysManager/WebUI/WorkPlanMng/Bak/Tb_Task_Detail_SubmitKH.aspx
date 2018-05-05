<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Task_Detail_SubmitKH.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiThird.Master" 
    Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Task_Detail_SubmitKH" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function CalWorkLoad() {
            var t2 = $('#<%=this.finishDate.ClientID%>').val();
            var t1 = $('#<%=this.begdate1.ClientID%>').val();
            
            if (t2 != "" && t1 != "") {
                var a1 = DateDiff(t2, t1)+1;
                $('#<%=this.LastWorkLoad.ClientID%>').val(a1 * 8 + "")
            }
        }

        //计算时间差
        function DateDiff(d1, d2) {
            var day = 24 * 60 * 60 * 1000;
            try {
                var dateArr = d1.split("-");
                var checkDate = new Date();
                checkDate.setFullYear(dateArr[0], dateArr[1] - 1, dateArr[2]);
                var checkTime = checkDate.getTime();

                var dateArr2 = d2.split("-");
                var checkDate2 = new Date();
                checkDate2.setFullYear(dateArr2[0], dateArr2[1] - 1, dateArr2[2]);
                var checkTime2 = checkDate2.getTime();

                var cha = (checkTime - checkTime2) / day;
                return cha;
            }
            catch (e) 
            {
                return 0;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <!--数据Form-->
    <div style="display: none">
        <jasp:JTextBox ID="GuidID" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="Status" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="AddUser" runat="server"></jasp:JTextBox>
        
        <jasp:JTextBox ID="begDate" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="endDate" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="Workload" runat="server"></jasp:JTextBox>
    </div>
    
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Task" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaName="GuidID" ParaType="RequestQueryString" />
        </ParaItems>
    </jasp:JDataSource>
    
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" 
        ControlList="GuidID,begdate1,finishDate,LastWorkLoad,contentText,Status,AddUser,begDate,endDate,Workload,content"
        NoSaveControlList="GuidID" TableName="Tb_Task" PrimaryKeys="GuidID" IsAppendData="true" />
        
        
    <div class="row cl">
        <label class="form-label col-2">
            计划执行：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" ID="begdate1" runat="server" Caption="计划执行开始" DataType="DateTime"
                onclick="$.calendar();" AllowNullValue="false" Width="28%" />&nbsp;至&nbsp;
            <jasp:JTextBox class="input-text" ID="finishDate" runat="server" Caption="计划执行结束" DataType="DateTime"
                onclick="$.calendar();" AllowNullValue="false" Width="28%" />
             实际工作量：<jasp:JTextBox class="input-text" AllowNullValue="false" ID="LastWorkLoad" runat="server"
              Width="140px" onfocus="javascript:CalWorkLoad();"  DataType="Numeric"  />
        </div>
    </div>
   
   <div class="row cl">
        <label class="form-label col-2">
            计划内容：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="content" runat="server"
                Caption="计划工作内容" mydatatype="*10-600" TextMode="MultiLine" Height="125px" ReadOnly="true"  />
        </div>
    </div>
    
    <div class="row cl">
        <label class="form-label col-2">
            完成内容：</label>
        <div class="formControls col-10">
            <jasp:JTextBox class="input-text" AllowNullValue="false" ID="contentText" runat="server"
                Caption="计划工作内容" mydatatype="*10-600" TextMode="MultiLine" Height="125px" />
        </div>
    </div>
    
    
    <!--控制修改的权限-->
    <jasp:SecurityPanel ID="sec0" runat="server" >
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
