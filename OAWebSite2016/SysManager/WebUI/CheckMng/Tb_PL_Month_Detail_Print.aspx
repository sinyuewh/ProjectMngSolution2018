<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_PL_Month_Detail_Print.aspx.cs"
    Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_PL_Month_Detail_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>月度考核结果打印</title>
    <style type="text/css">
        .table
        {
            border-collapse: collapse;
            font-size: 13px;
            height: 24px;
            line-height: 24px;
            color: black;
            text-align: center;
        }
        .table tr th
        {
            background: #36F;
            color: #FFF;
            font-size: 13px;
            height: 24px;
            line-height: 24px;
        }
        .table tr th.th_border
        {
            border-right: solid 1px #FFF;
            border-left: solid 1px black;
        }
        .table tr td
        {
            border: solid 1px black;
            font-size: 14px;
        }
        td.Caption
        {
            font-size: 16px;
            font-weight: bold;
            text-align: right;
        }
        td.Caption_Center
        {
            font-size: 16px;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_PL_Month">
        <ParaItems>
            <jasp:ParameterItem ParaName="CheckDataID" ParaType="RequestQueryString" DataType="NumericType" />
        </ParaItems>
    </jasp:JDataSource>
    <div style="display:none">
        <jasp:JTextBox ID="byear" Text="" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="bmonth" Text="" runat="server"></jasp:JTextBox>
        <jasp:JTextBox ID="UserID" Text="" runat="server"></jasp:JTextBox>
    </div>
    <div style="text-align: center">
        <div>
            <h1>
                软件部月度绩效考核</h1>
        </div>
        <table width="96%" align="center" class="table">
            <tr>
                <td class="Caption" style="width: 18%">
                    姓名&nbsp;
                </td>
                <td style="width: 15%">
                    <%=this.data1.Eval("UserName") %>
                </td>
                <td class="Caption" style="width: 18%">
                    考核年月&nbsp;
                </td>
                <td style="width: 15%">
                    <%=this.data1.Eval("byear") %>
                    年
                    <%=this.data1.Eval("bmonth") %>
                    月
                </td>
                <td class="Caption" style="width: 18%">
                    考核结果&nbsp;
                </td>
                <td style="width: 16%">
                    <%=this.data1.Eval("CheckResult") %>
                </td>
            </tr>
            <tr>
                <td class="Caption">
                    工作考核&nbsp;
                </td>
                <td>
                    <%=this.data1.Eval("checkscore") %>
                    分
                </td>
                <td class="Caption">
                    加减分&nbsp;
                </td>
                <td>
                    <%=this.data1.Eval("addscore") %>
                    分
                </td>
                <td class="Caption">
                    综合得分&nbsp;
                </td>
                <td>
                    <%=this.data1.Eval("totalscore") %>
                    分
                </td>
            </tr>
            <tr>
                <td class="Caption">
                    有效工作量&nbsp;
                </td>
                <td>
                    <%=this.data1.Eval("factwork") %>
                    小时
                </td>
                <td class="Caption">
                    全额工作量&nbsp;
                </td>
                <td>
                    <%=this.data1.Eval("totalwork") %>
                    小时
                </td>
                <td class="Caption">
                    工作量饱满率&nbsp;
                </td>
                <td>
                    <%=double.Parse(this.data1.Eval("workrate"))*100  %>
                    %
                </td>
            </tr>
        </table>
        <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="tb_taskView" OrderBy="taskid"
            PageSize="-1">
            <ParaItems>
                <jasp:ParameterItem ParaName="xx" ParaType="String" DataName="Status ='3'" SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaName="byear" ParaType="Control" DataName="format(finishDate, 'yyyy')='{0}'"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaName="bmonth" ParaType="Control" DataName="format(finishDate, 'm')='{0}'"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaName="UserID" ParaType="Control" DataName="AddUser" />
            </ParaItems>
        </jasp:JDataSource>
        <table width="96%" align="center" class="table">
            <tr>
                <td class="Caption_Center" colspan="6" style="border-top: solid 0px black; height: 30px">
                    工作考核明细
                </td>
            </tr>
            <tr>
                <td class="Caption_Center">
                    项目名称
                </td>
                <td class="Caption_Center" style="width: 40%">
                    计划内容<br />
                    完成内容
                </td>
                <td class="Caption_Center">
                    计划开始<br />
                    实际开始
                </td>
                <td class="Caption_Center">
                    计划完成<br />
                    实际完成
                </td>
                <td class="Caption_Center">
                    考核人
                </td>
                <td class="Caption_Center">
                    核定工时<br />
                    得分
                </td>
            </tr>
            <asp:Repeater ID="rep1" runat="server" DataSourceID="data2" EnableViewState="false">
                <ItemTemplate>
                    <tr>
                        <td rowspan="2">
                            <%#Eval("prjName")%>
                        </td>
                        <td style="text-align: left">
                            <%#Eval("content")%>
                        </td>
                        <td>
                            <%#Eval("begdate","{0:yyyy-MM-dd}")%>
                        </td>
                        <td>
                            <%#Eval("enddate","{0:yyyy-MM-dd}")%>
                        </td>
                        <td rowspan="2">
                            <%# KORWeb.BUL.JUserBU.GetUserNamByIDS(Eval("Manager").ToString()) %>
                        </td>
                        <td>
                            <%#Eval("LastWorkLoad")%>
                            小时
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <%#Eval("contentText")%>
                        </td>
                        <td>
                            <%#Eval("begdate1","{0:yyyy-MM-dd}")%>
                        </td>
                        <td>
                            <%#Eval("finishdate","{0:yyyy-MM-dd}")%>
                        </td>
                        <td>
                            <span style="font-weight: bold">
                                <%#Eval("Score")%>
                                分 </span>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td >
                            工作考核得分加权合计
                        </td>
                        <td style="text-align: left">
                            
                        </td>
                        <td>
                            
                        </td>
                        <td>
                            
                        </td>
                        <td >
                            
                        </td>
                        <td>
                            <%=this.HJ1 %> 分
                        </td>
                    </tr>
                </FooterTemplate>
            </asp:Repeater>
        </table>
        <jasp:JDataSource ID="data3" runat="server" JType="Table" SqlID="Tb_KaoHeOther" OrderBy="num"
            PageSize="-1" FieldsList="*,khscore*khcount as khscore1">
            <ParaItems>
                <jasp:ParameterItem ParaName="byear" ParaType="Control" DataName="format(createtime, 'yyyy')={0}"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaName="bmonth" ParaType="Control" DataName="format(createtime, 'mm')={0}"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaName="UserID" ParaType="Control" />
            </ParaItems>
        </jasp:JDataSource>
        
        <table width="96%" align="center" class="table">
            <tr>
                <td class="Caption_Center" colspan="5" style="border-top: solid 0px black; height: 30px">
                    加减分明细
                </td>
            </tr>
            <tr>
                <td class="Caption_Center">
                    登记时间
                </td>
                <td class="Caption_Center">
                    考核编码
                </td>
                <td class="Caption_Center">
                    考核规范
                </td>
                <td class="Caption_Center">
                    加减分
                </td>
                <td class="Caption_Center">
                    考核备注
                </td>
            </tr>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data3" EnableViewState="false">
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#Eval("createtime")%>
                        </td>
                        <td>
                            <%#Eval("KHID")%>
                        </td>
                        <td>
                            <%#Eval("KHRemark")%>
                        </td>
                        <td>
                            <%#Eval("KHScore1")%> 分
                        </td>
                        <td>
                            <%#Eval("remark")%>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td>
                            加减分合计
                        </td>
                        <td>
                            
                        </td>
                        <td>
                            
                        </td>
                        <td>
                            <%=this.HJ2 %> 分
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                </FooterTemplate>
            </asp:Repeater>
        </table>
        
    </div>
    </form>
</body>
</html>
