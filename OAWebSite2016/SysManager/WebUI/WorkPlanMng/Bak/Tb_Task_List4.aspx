﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Task_List4.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Task_List4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 工单管理 <span class="c-gray en">&gt;</span> 未完成工单 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div style="display: none">
            
        </div>
        <div class="text-c">
            项目名称：<span class="select-box" style="width: auto">
                <jasp:JDropDownList ID="parentGuid" runat="server" CssClass="select" AutoPostBack="true">
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp;&nbsp;&nbsp;派单日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text"
                Style="width: 120px" placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp; <span class="select-box" style="width: auto">
                <jasp:JDropDownList ID="MyTask" runat="server" CssClass="select" AutoPostBack="true">
                    <asp:ListItem Text="我负责的工单" Value="0"></asp:ListItem>
                    <asp:ListItem Text="所有工单" Value="1"></asp:ListItem>
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l"></span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong>
                条</span>
        </div>
        <!--数据源定义-->
        <div style="display: none">
            <jasp:JTextBox ID="ExecuteManID" runat="server" TextDefaultValue="UserID"></jasp:JTextBox>
        </div>
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Task" PageSize="-1"
            OrderBy="TaskID desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="parentGuid" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="AddTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="AddTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Tb_Task.Status ='4'"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Tb_Task.BigKind ='0'"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="ExecuteManID" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <%--<th width="25">
                            <input type="checkbox" name="" value="">
                        </th>--%>
                        <th>
                            工单ID
                        </th>
                        <th>
                            分类
                        </th>
                        <th>
                            模块
                        </th>
                        <th style="width: 450px">
                            工单内容
                        </th>
                        <th>
                            重要<br />
                            程度
                        </th>
                        <th>
                            紧急<br />
                            程度
                        </th>
                        <th>
                            派单<br />
                            接单
                        </th>
                        <th>
                            派单时间<br />
                            接单时间
                        </th>
                        <th>
                            要求完成<br />
                            计划完成
                        </th>
                        <th>
                            提交审核<br />
                            完成审核
                        </th>
                        <th>
                            预估<br />
                            工时
                        </th>
                        <th>
                            跟踪
                        </th>
                        <th>
                            附件
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <%--<td>
                                    <input type="checkbox" value='<%#Eval("TaskId")%>' name="selectdoc">
                                </td>--%>
                                <td>
                                    <%#Eval("TaskId")%>
                                </td>
                                <td>
                                    <%#Eval("TaskKind")%>
                                </td>
                                <td title='<%#Eval("TaskTitle")%>'>
                                    <%# WebFrame.Util.JString.GetMaxLenth(Eval("TaskTitle").ToString(), 60)%>
                                </td>
                                <td class="text-l" title='<%#Eval("content")%>'>
                                    <%# WebFrame.Util.JString.GetMaxLenth(Eval("content").ToString(), 200)%>
                                </td>
                                <td>
                                    <%#Eval("ImportGrade")%>
                                </td>
                                <td>
                                    <%#Eval("TimeGrade")%>
                                </td>
                                <td>
                                    <%#Eval("ManagerName")%><br />
                                    <%#Eval("ExecuteManName")%>
                                </td>
                                <td>
                                    <%#Eval("AddTime", "{0:MM-dd}")%><br />
                                    <%#Eval("begDate", "{0:MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("PlanDate", "{0:MM-dd}")%><br />
                                    <%#Eval("endDate", "{0:MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("CheckDate", "{0:MM-dd}")%><br />
                                    <%#Eval("finishDate", "{0:MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("Workload")%>
                                </td>
                                <td class="operate">
                                    <a href="#" onclick="javascript:ReadLogData('<%#Eval("guidid") %>','<%#Eval("TaskId")%>')">
                                        <%# KORWeb.BUL.Tb_Task_LogBU.GetLogCount(Eval("GuidID").ToString())%></a>
                                </td>
                                <td class="operate">
                                    <%# KORWeb.BUL.Tb_TaskBU.GetAttachmengList(Eval("GuidID").ToString())%>
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
                // {"orderable": false, "aTargets": [0]}// 制定列不参与排序
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

            //计算合计数

        });


        //1*--浏览日志信息
        function ReadLogData(dataid, title) {
            var title = "工单【" + title + "】跟踪信息";
            var url = "TB_Task_Log.aspx?TaskID=" + dataid;
            layer_show(title, url, 950, 650);
        }

        //上传附件
        function UploadAttachmentFile(data1) {
            var title = "上传附件";
            var url = "UploadAttachment.aspx?parentGuid=" + data1;
            layer_show(title, url, 550, 200);
        }

        //打开附件
        function openFile(f1, f2) {
            var url1 = "/Comm/OpenAttachment.aspx?filepath=" + f1 + "&fileName=" + f2;
            window.open(url1);
        }
        
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
