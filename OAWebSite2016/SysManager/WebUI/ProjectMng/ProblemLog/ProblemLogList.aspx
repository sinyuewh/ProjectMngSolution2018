<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProblemLogList.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.ProblemLog.ProblemLogList" %>

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
    <span style="display: none">
        <jasp:JTextBox ID="DepartNum" runat="server" />
        <jasp:JTextBox ID="PersonID" runat="server" />
        <jasp:JTextBox ID="Kind" runat="server" Text="1" />
    </span>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目管理 <span class="c-gray en">&gt;</span> 问题日志 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            操作时间：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp; 是否解决：<span class="select-box" style="width: 150px">
                <jasp:JDropDownList ID="Status" class="select" runat="server">
                    <asp:ListItem Text="--不限--" Value=""></asp:ListItem>
                    <asp:ListItem Text="未解决" Value="1"></asp:ListItem>
                    <asp:ListItem Text="已解决" Value="2"></asp:ListItem>
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp; 项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text"
                Style="width: 200px" placeholder="" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加问题日志</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project_LogView"
            PageSize="-1" OrderBy="AddTime desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Status" DataType="NumericType" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="AddTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="AddTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Kind" />
                <jasp:ParameterItem ParaType="Control" ParaName="DepartNum" SearchOperator="RightContains" />
                <jasp:ParameterItem ParaType="Control" ParaName="PersonID" DataName="{0}" SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <%-- <%=this.data1.CommandText  %>--%>
        <!--数据表格-->
        <div class="mt-20" style="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            项目编号
                        </th>
                        <th>
                            项目名称
                        </th>
                        <th style="width: 30%">
                            问题描述
                        </th>
                        <th>
                            严重程度
                        </th>
                        <th>
                            相关附件
                        </th>
                        <th>
                            登记人
                        </th>
                        <th>
                            登记时间
                        </th>
                        <th>
                            关联工单
                        </th>
                        <th>
                            完成时间
                        </th>
                        <th>
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td class="operate">
                                    <a href="#" onclick ="javascript:ReadData('<%#Eval("GuidID")%>');" title="点击查看问题日志的明细">
                                        <%#Eval("prjNum")%>
                                    </a>
                                </td>
                                <td>
                                    <%#Eval("prjName")%>
                                </td>
                                <td class="text-l">
                                    <%#Eval("Content")%>
                                </td>
                                <td>
                                    <%#Eval("Degree")%>
                                </td>
                                <td class="operate">
                                    <%#Eval("AttachFile") %>
                                </td>
                                <td>
                                    <%#Eval("AddUserName")%>
                                </td>
                                <td>
                                    <%#Eval("AddTime")%>
                                </td>
                                <td class="operate">
                                    <a href="">
                                        <%#Eval("Workorder").ToString() == "" ? "未派单" : Eval("Workorder").ToString()%></a>
                                </td>
                                <td>
                                    <%#Eval("FinishTime","{0:yyyy-MM-dd}") %>
                                </td>
                                <td class="operate">
                                    <span class="select-box" id="span1" runat="server">
                                        <jasp:JDropDownList ID="doAction" class="select" runat="server" onchange="javascript:doProjectAction(this);">
                                        </jasp:JDropDownList>
                                    </span>
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
                "aaSorting": [[1, "desc"]], //默认第几个排序
                "bStateSave": true, //状态保存
                //"lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
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


        //1*--新增数据
        function NewData() {
            var title = "添加问题日志";
            var url = "ProblemLogAdd.aspx";
            layer_show(title, url, 800, 520);
        }

        //2*--查看数据
        function ReadData(dataid) {
            var title = "问题日志的详细";
            var url = "ProblemLogDetail.aspx?GuidID=" + dataid;
            layer_show(title, url, 800, 520);
        }
    </script>

</asp:Content>
