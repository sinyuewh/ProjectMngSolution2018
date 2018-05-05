<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TodayWorkList1.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.TodayWorkList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 工作管理 <span class="c-gray en">&gt;</span> 今日工作 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c" style="display: none">
            日志作者：<jasp:JTextBox ID="AddUserName" runat="server" class="input-text" Style="width: 120px"
                placeholder="" />
            &nbsp;&nbsp; 日志日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp; 日志内容：<jasp:JTextBox ID="LogContent" runat="server" class="input-text"
                Style="width: 300px" placeholder="" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <button id="but1" runat="server" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe644;</i> 提交今日工作</button>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_PlanDetailViewForWeek"
            PageSize="-1" OrderBy="PlanNum">
            <ParaItems>
                <jasp:ParameterItem ParaName="xx" ParaType="FrameLibPara" FrameLibParaName="UserID"
                    DataName="ExecuteManID" />
                <jasp:ParameterItem ParaName="xx" DataName="WorkCheck=false" SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <%--<%=this.data1.CommandText  %>--%>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            类别
                        </th>
                        <th>
                            计划编号
                        </th>
                        <th class="text-l">
                            计划内容
                        </th>
                        <th>
                            计划开始
                        </th>
                        <th>
                            计划结束
                        </th>
                        <th>
                            工作量预估
                        </th>
                        <th>
                            交付物
                        </th>
                        <th>
                            已完成内容
                        </th>
                        <th>
                            今日工作
                        </th>
                        <th>
                            工作量
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <%#Eval("PlanKind")%>
                                    <asp:Label ID="parentGuid" runat="server" Text ='<%#Eval("parentGuid")%>' Visible="false" ></asp:Label>
                                    <asp:Label ID="PlanID" runat="server" Text ='<%#Eval("PlanID")%>' Visible="false" ></asp:Label>
                                    <asp:Label ID="PlanNum" runat="server" Text ='<%#Eval("PlanNum")%>' Visible="false" ></asp:Label>
                                </td>
                                <td>
                                    <%#Eval("PlanNum")%>
                                </td>
                                <td class="text-l">
                                    <%#Eval("PlanTitle")%>
                                </td>
                                <td>
                                    <%#Eval("begTime", "{0:yyy-MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("endTime", "{0:yyy-MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("Workload")%>
                                </td>
                                <td>
                                    <%#Eval("PayMemo")%>
                                </td>
                                <td>
                                    <%#KORWeb.BUL.Tb_WorkLogBU.GetWorkLogContent(Eval("PlanNum").ToString(), false)%>
                                </td>
                                <td>
                                    <jasp:JTextBox class="input-text" TextMode="MultiLine" Height="100px" ID="LogContent"
                                        Text='<%#KORWeb.BUL.Tb_WorkLogBU.GetWorkLogContent(Eval("PlanNum").ToString(), true) %>'
                                        runat="server" Caption="今日工作" />
                                </td>
                                <td>
                                    <jasp:JTextBox class="input-text" ID="WorkLoad" AllowNullValue="false" 
                                         Text='<%#KORWeb.BUL.Tb_WorkLogBU.GetWorkLogLoad(Eval("PlanNum").ToString(), true) %>' 
                                         DataType="Numeric"
                                        Width="60px" Style="text-align: center" runat="server" Caption="工作量" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>

    <script type="text/javascript">
        $(function() {
            $('.table-sort').dataTable({
                "aaSorting": [[0, "desc"]], //默认第几个排序
                "bStateSave": false, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
		          {"orderable": false, "aTargets": [3]}// 制定列不参与排序
		        ]
            });
            $('.table-sort tbody').on('click', 'tr', function() {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            //Load Table
            $(".mt-20").css("display", "");
        });
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
