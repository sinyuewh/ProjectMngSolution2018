<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Debug_List2.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Debug_List2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> BUG管理 <span class="c-gray en">&gt;</span> 待审核BUG <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div style="display: none">
            
        </div>
        <div class="text-c">
            项目名称：<span class="select-box" style="width: auto">
                <jasp:JDropDownList ID="parentGuid" runat="server" CssClass="select"  AutoPostBack="true">
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp;&nbsp;&nbsp;派单日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text"
                Style="width: 120px" placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
             &nbsp; <span class="select-box" style="width: auto">
                <jasp:JDropDownList ID="MyTask" runat="server" CssClass="select" AutoPostBack="true">
                    <asp:ListItem Text="我负责的BUG" Value="0"></asp:ListItem>
                    <asp:ListItem Text="所有BUG" Value="1"></asp:ListItem>
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
        <div style="display:none">
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
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Tb_Task.Status ='2'"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Tb_Task.BigKind ='1'"
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
                            BUGID
                        </th>
                       
                        <th>
                            模块
                        </th>
                        <th>
                            功能项
                        </th>
                        <th style="width: 400px">
                            BUG内容
                        </th>
                        <th>
                            类别
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
                            发现日期<br />
                            接单日期
                        </th>
                        <th>
                            要求完成<br />
                            计划完成
                        </th>
                        <th>
                            提交审核
                        </th>
                       
                        <th>
                            备注
                        </th>
                        
                        
                        <th>
                            跟踪
                        </th>
                        <th>
                            附件
                        </th>
                        <% if (this.IsManager)
                           { %>
                        <th>
                            操作
                        </th>
                        <% } %>
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
                                
                                <td title='<%#Eval("TaskTitle")%>'>
                                    <%# WebFrame.Util.JString.GetMaxLenth(Eval("TaskTitle").ToString(), 60)%>
                                </td>
                                
                                <td title='<%#Eval("SubTitle")%>'>
                                    <%# WebFrame.Util.JString.GetMaxLenth(Eval("SubTitle").ToString(), 60)%>
                                </td>
                                
                                <td class="text-l" title='<%#Eval("content")%>'>
                                    <%# WebFrame.Util.JString.GetMaxLenth(Eval("content").ToString(), 200)%>
                                </td>
                                
                                <td>
                                    <%#Eval("BugKind")%>
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
                                    <%#Eval("CheckDate", "{0:MM-dd}")%>
                                </td>
                                
                                <td>
                                    <%#Eval("remark")%>
                                </td>
                                
                                <td class="operate">
                                    <a href="#" onclick="javascript:ReadLogData('<%#Eval("guidid") %>','<%#Eval("TaskId")%>')">
                                        <%# KORWeb.BUL.Tb_Task_LogBU.GetLogCount(Eval("GuidID").ToString())%></a>
                                </td>
                                <td class="operate">
                                    <%# KORWeb.BUL.Tb_TaskBU.GetAttachmengList(Eval("GuidID").ToString())%>
                                </td>
                                <% if (this.IsManager)
                                   { %>
                                <td class="operate">
                                    <a onclick="javascript:return CompleteTask('<%#Eval("GuidID") %>');" href='#' title="将BUG标为完成BUG">
                                        <img alt="" src="/images/icon/office_001.png" width="16" height="16" border="0" />完成</a><br />
                                    <a onclick="javascript:return CompleteNoTask('<%#Eval("GuidID") %>');" href='#' title="将BUG标为退回重改">
                                        <img alt="" src="/images/icon/office_005.png" width="16" height="16" border="0" />退回</a><br />
                                    <a onclick="javascript:return DelData('<%#Eval("GuidID") %>');" title="取消BUG" href='#'>
                                        <img alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />取消</a>
                                </td>
                                <% } %>
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
            var title = "BUG【" + title + "】跟踪信息";
            var url = "../WorkPlanMng/TB_Task_Log.aspx?TaskID=" + dataid;
            layer_show(title, url, 950, 650);
        }

        //上传附件
        function UploadAttachmentFile(data1) {
            var title = "上传附件";
            var url = "../WorkPlanMng/UploadAttachment.aspx?parentGuid=" + data1;
            layer_show(title, url, 550, 200);
        }

        //打开附件
        function openFile(f1, f2) {
            var url1 = "/Comm/OpenAttachment.aspx?filepath=" + f1 + "&fileName=" + f2;
            window.open(url1);
        }


        //3*--用户取消BUG
        function DelData(dataid) {
            layer.confirm("提示：确定要【取消BUG】吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'Cancel_Tb_Task'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("【取消BUG】操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("【取消BUG】操作失败！");
                        }
                    }
                });
            });
        }


        //4*--将BUG标记为完成
        function CompleteTask(dataid) {
            layer.confirm("提示：确定要将BUG标记为【完成】吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'Complete_Tb_Task',
                        Flag: 1
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("将BUG标记为【完成】操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("将BUG标记为【完成】操作失败！");
                        }
                    }
                });
            });
        }


        //4*--将BUG标记为失败
        function CompleteNoTask(dataid) {
            layer.confirm("提示：确定要将BUG【退回重改】吗？", function() {
                layer.prompt({ title: '请输入退回重改的原因的说明', formType: 2 }, function(text) {                    
                    $.ajax({
                        type: 'POST',
                        url: "Handler/DoAction.aspx",
                        data: {
                            KeyID: dataid,
                            Action: 'Complete_Tb_Task',
                            Remark:text,
                            Flag: 2
                        },
                        success: function(data) {
                            if ("ok" == data) {
                                layer.alert("将BUG标记为【退回重改】操作成功！", function() {
                                    $('#butSearch').click();  //重新加载页面
                                });
                            } else {
                                layer.alert("将BUG标记为【失败】操作失败！");
                            }
                        }
                    });
                });
            });
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
