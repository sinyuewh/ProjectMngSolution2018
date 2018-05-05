<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="TB_Task_List1.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkMng.TB_Task_List1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
        var arrStatus = new Array("", "开发", "测试", "审核");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 工作管理 <span class="c-gray en">&gt;</span> 实施中的工单 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp;下单日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
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
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Task inner join Tb_Project on Tb_Task.ProjectGuidID=Tb_Project.Guidid"
            PageSize="-1" FieldsList="TaskId,Tb_Task.Guidid,Tb_Task.AddTime,prjName,TaskTitle,Tb_Task.begDate,Tb_Task.endDate,Tb_Task.WorkLoad,Tb_Task.Relafile,RelaTrueName,ExecuteMan,Tb_Task.AddUser,TestMan,Tb_Task.Status,TestUrl"
            OrderBy="Tb_Task.AddTime desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="Tb_Task.AddTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="Tb_Task.AddTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="(Tb_Task.Status ='1' and ExecuteMan is not null)"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UserID" ParaName="xx"
                    DataName="Tb_Task.ExecuteMan='{0}' or Tb_Task.TestMan='{0}' or tb_task.AddUser='{0}' " 
                     SearchOperator="UserDefine"  />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            工单ID
                        </th>
                       <%-- <th>
                            状态
                        </th>--%>
                        <th>
                            下单时间
                        </th>
                        <th>
                            下单用户
                        </th>
                        <th>
                            项目名称
                        </th>
                        <th>
                            工单标题
                        </th>
                        <th>
                            计划开始
                        </th>
                        <th>
                            计划完成
                        </th>
                        <th>
                            预估
                        </th>
                        <th>
                            接单
                        </th>
                        <th>
                            测试
                        </th>
                        <th>
                            Bug
                        </th>
                        <th>
                            附件
                        </th>
                        <th>
                            日志
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
                                <td>
                                    <%#Eval("TaskId")%>
                                </td>
                                <%--<td>
                                    <script language="javascript">document.write(arrStatus[<%#Eval("Status")%>])</script>
                                </td>--%>
                                <td>
                                    <span title='<%#Eval("AddTime") %>'><%#Eval("AddTime","{0:MM-dd}") %></span>
                                </td>
                                <td>
                                    <%#KORWeb.BUL.JUserBU.GetUserNamByIDS(Eval("AddUser").ToString())%>
                                </td>
                                <td>
                                    <%#Eval("PrjName") %>
                                </td>
                                <td>
                                    <%#Eval("TaskTitle") %>
                                </td>
                                <td>
                                    <%#Eval("begDate","{0:MM-dd}") %>
                                </td>
                                <td>
                                    <%#Eval("endDate","{0:MM-dd}") %>
                                </td>
                                <td>
                                    <%#Eval("Workload")%>
                                </td>
                                <td>
                                    <%#KORWeb.BUL.JUserBU.GetUserNamByIDS(Eval("ExecuteMan").ToString())%>
                                </td>
                                
                                <td class="operate">
                                    <a title="点击进入测试页" href='<%#Eval("TestUrl")%>' target="_blank">
                                        <%#KORWeb.BUL.JUserBU.GetUserNamByIDS(Eval("TestMan").ToString())%></a>
                                </td>
                                
                                 <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("Guidid") %>',1);" href='#'>
                                        <%# KORWeb.BUL.Tb_Task_BugBU.GetBugCount(Eval("GuidID").ToString())%>
                                    </a>
                                </td>
                                
                                <td class="operate">
                                    <a href='<%#Eval("RelaFile")%>' target="_blank">
                                        <%#Eval("RelaTrueName").ToString() == String.Empty ? "" : Eval("RelaTrueName").ToString() %>
                                    </a>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("Guidid") %>',2);" href='#'>
                                        <%# KORWeb.BUL.Tb_Task_LogBU.GetLogCount(Eval("GuidID").ToString())%>
                                    </a>
                                </td>
                               
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("Guidid") %>',0);" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                    <span id="span1" style='display:<%#Eval("ExecuteMan").ToString()==WebFrame.FrameLib.UserID ? "":"none" %>'>&nbsp;<a onclick="javascript:return SumbitTestData('<%#Eval("Guidid") %>');" href='#'><img
                                        alt="" src="/images/gou2.gif" width="16" height="16" border="0" />提交</a></span>
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
		          {"orderable": false, "aTargets": [12]}// 制定列不参与排序
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


        //1*--浏览或修改数据
        function ReadData(dataid,index1) {
            var title = "派工单信息";
            var url = "TB_Task_Detail.aspx?flag="+index1+"&GuidID=" + dataid;
            //layer_show(title, url, 800, 600);

            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }

               
        //提交工单
        function SumbitTestData(dataid) {
            var title = "提交派工单";
            var url = "../ProjectManager/TB_Task_SubmitTest.aspx?GuidID=" + dataid;
            layer_show(title, url, 800, 450);
        }
        
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
