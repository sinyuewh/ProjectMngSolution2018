﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Task_Log.aspx.cs" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Task_Log" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 工单跟踪信息  <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            操作日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="Button1" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l"></span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong>
                条</span>
            <div style="display: none">
                <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 查询</button>
            </div>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Task_Log" PageSize="-1"
            OrderBy="AddTime">
            <ParaItems>
                <jasp:ParameterItem ParaType="RequestQueryString" ParaName="TaskID" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="AddTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="AddTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            序号
                        </th>
                        <th>
                            类型
                        </th>
                        <th>
                            备注
                        </th>
                        <th>
                            操作用户
                        </th>
                        <th>
                            操作时间
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <%# (this.data1.CurPage-1)*this.data1.PageSize+Container.ItemIndex+1 %>
                                </td>
                                <td>
                                    <%#Eval("DoKind")%>
                                </td>
                                <td>
                                    <%#Eval("Content")%>
                                </td>
                                <td>
                                    <%#Eval("AddUserName")%>
                                </td>
                                <td>
                                    <%#Eval("AddTime")%>
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
                "aaSorting": [[0, "asc"]], //默认第几个排序
                "bStateSave": true, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
                //     {"orderable": false, "aTargets": [5]}// 制定列不参与排序
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
