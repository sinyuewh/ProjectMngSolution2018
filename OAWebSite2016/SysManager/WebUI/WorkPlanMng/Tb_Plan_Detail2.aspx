<%@ Page Title="项目月度计划" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" %>

<script runat="server">
    KORWeb.BUL.Tb_Project_PersonBU person1 = new Tb_Project_PersonBU();
    protected override void OnInit(EventArgs e)
    {
        this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
        base.OnInit(e);
    }

    void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        System.Data.DataRowView dv = e.Item.DataItem as System.Data.DataRowView;
        System.Data.DataRow dr = dv.Row;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript">
        var Arr1 = new Array();
        Arr1[0] = "未立项";
        Arr1[1] = "实施中";
        Arr1[2] = "已完成";
        Arr1[3] = "已终止";
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 月度计划详细  <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            责任人：<jasp:JTextBox ID="ExecuteManName" runat="server" class="input-text"
                Style="width: 150px" placeholder=""  />&nbsp;&nbsp; 计划编号：<jasp:JTextBox ID="PlanNum" runat="server" class="input-text"
                Style="width: 150px" placeholder=""  />
            &nbsp;&nbsp; 计划内容：<jasp:JTextBox ID="PlanTitle" runat="server" class="input-text" Style="width: 150px"
                placeholder=""  />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l"></span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong>
                条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_PlanDetailView" PageSize="-1"
             FieldsList="*,(SumValidWork/workload)*100 as fRate"
            OrderBy="PlanNum">
            <ParaItems>
                <jasp:ParameterItem ParaType="RequestQueryString" ParaName="PlanID" />
                <jasp:ParameterItem ParaType="Control" ParaName="PlanNum" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="PlanTitle" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="ExecuteManName" SearchOperator="Contains" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            类别
                        </th>
                        <th>
                            计划编号
                        </th>
                        <th class="text-l" style="width: 30%">
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
                            责任人
                        </th>
                        <th>
                            考核指标
                        </th>
                        <th>
                            备注
                        </th>
                        <th>
                            完成标志
                        </th>
                        <th>
                            完成时间
                        </th>
                        <th>
                            完成情况
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <%#Eval("PlanKind")%>
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
                                    <%#Eval("ExecuteManName")%>
                                </td>
                                <td>
                                    <%#Eval("PayMemo")%>
                                </td>
                                <td>
                                    <%#Eval("Remark")%>
                                </td>
                                <td>
                                    <%#Eval("FiniahStatus").ToString()=="0" ? "":"<span style='color:green;font-weight:bold'>√<span>"%>
                                </td>
                                <td>
                                    <%#Eval("finishDate", "{0:yyy-MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("fRate")%> %
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
                //"aaSorting": [[1, "desc"]], //默认第几个排序
            "lengthMenu": [[15, 30, 60, -1], [15, 30, 60, "All"]],
                "bStateSave": true, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
                //  {"orderable": false, "aTargets": [9]}// 制定列不参与排序
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

</asp:Content>
