<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Debug_List0.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.WorkPlanMng.Tb_Debug_List0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> BUG管理 <span class="c-gray en">&gt;</span> 待解决BUG <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            项目名称：<span class="select-box" style="width: auto">
                <jasp:JDropDownList ID="parentGuid" runat="server" CssClass="select" AutoPostBack="true">
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp;派单日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text"
                Style="width: 120px" placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <% if (this.IsManager)
                   { %>
                <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i>添加BUG</a> &nbsp;&nbsp; <a href="javascript:;"
                        onclick="javascript:return ImportExcelData();" class="btn btn-primary radius"><i
                            class="Hui-iconfont">&#xe645;</i>导入BUG</a> &nbsp;&nbsp;
                <% } %><a href="javascript:;" onclick="javascript:return JieDanAction('');" class="btn btn-primary radius"><i
                    class="Hui-iconfont">&#xe603;</i>成批接单或派单</a> </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong>
                        条</span>
        </div>
        <!--数据源定义-->
        <div style="display: none">
        </div>
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Task" PageSize="-1"
            OrderBy="TaskID desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="parentGuid" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="AddTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="AddTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Tb_Task.Status ='0'"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="BigKind ='1'" SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th width="25">
                            <input type="checkbox" name="" value="">
                        </th>
                        <th>
                            BUGID
                        </th>
                        <%-- <th>
                            分类
                        </th>--%>
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
                            重要程度
                        </th>
                        <th>
                            紧急程度
                        </th>
                        <th>
                            发现日期
                        </th>
                        <th>
                            要求完成
                        </th>
                        <th>
                            备注
                        </th>
                        <%--<th>
                            预估工时
                        </th>--%>
                        <th>
                            跟踪
                        </th>
                        <th>
                            附件
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
                                    <input type="checkbox" value='<%#Eval("GuidID")%>' name="selectdoc">
                                </td>
                                <td>
                                    <%#Eval("TaskId")%>
                                </td>
                                <%-- <td>
                                    <%#Eval("TaskKind")%>
                                </td>--%>
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
                                    <%#Eval("AddTime", "{0:MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("PlanDate", "{0:MM-dd}")%>
                                </td>
                                <td>
                                    <%#Eval("Remark")%>
                                </td>
                                <%-- <td>
                                    <%#Eval("Workload")%>
                                </td>--%>
                                <td class="operate">
                                    <a href="#" onclick="javascript:ReadLogData('<%#Eval("guidid") %>','<%#Eval("TaskId")%>')">
                                        <%# KORWeb.BUL.Tb_Task_LogBU.GetLogCount(Eval("GuidID").ToString())%></a>
                                </td>
                                <td class="operate">
                                    <%# KORWeb.BUL.Tb_TaskBU.GetAttachmengList(Eval("GuidID").ToString())%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return JieTaskData('<%#Eval("GuidID") %>');" href='#' title="接单">
                                        <img alt="" src="/images/gou2.gif" width="16" height="16" border="0" />接单</a><br />
                                    <% if (this.IsManager)
                                       { %>
                                    <a onclick="javascript:return DelData('<%#Eval("GuidID") %>');" href='#' title="取消BUG">
                                        <img alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />取消</a>
                                    <% } %>
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
                 {"orderable": false, "aTargets": [0]}// 制定列不参与排序
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

        //成批接单操作
        function JieDanAction(dataid) {
            //得到选中的值
            var seldata = "";
            var first = true;
            if (dataid == "") {
                $('input[name="selectdoc"]:checked').each(function() {
                    if (first) {
                        first = false;
                        seldata += $(this).val();
                    }
                    else {
                        seldata += ",";
                        seldata += $(this).val();
                    }
                });
            }
            else {
                seldata = dataid;
            }

            if (seldata == "") {
                layer.alert('没有选中任何要操作的数据!');
            }
            else {
                var title = "成批接单";
                var url = "JieDanAction.aspx?TaskID=" + seldata + "&parentGuid=" + $('#<%=parentGuid.ClientID %>').val();
                layer_show(title, url, 650, 350);
            }
        }
        
        
        
        function NewData() {
            var title = "添加BUG";
            var url = "Tb_Task_DetailBUG_Add.aspx?parentGuid=" + $('#<%=parentGuid.ClientID %>').val();
            layer_show(title, url, 900, 600);
        }

        //导入Excel文件
        function ImportExcelData() {
            var title = "利用Excel导入BUG";
            var url = "Tb_Task_ImportExcelBUG.aspx?parentGuid=" + $('#<%=parentGuid.ClientID %>').val();
            layer_show(title, url, 600, 350);
        }

        //1*--浏览日志信息
        function ReadLogData(dataid, title) {
            var title = "BUG【" + title + "】跟踪信息";
            var url = "../WorkPlanMng/TB_Task_Log.aspx?TaskID=" + dataid;
            layer_show(title, url, 950, 650);
        }

        //3*--用户取消BUG
        function DelData(dataid) {
            layer.confirm("提示：确定要【取消BUG】吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "../WorkPlanMng/Handler/DoAction.aspx",
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


        //3*--用户接单
        function JieTaskData(dataid) {
            var v1 = '<%=DateTime.Now.ToString("yyyy-MM-dd") %>';
            layer.confirm("提示：确定要【接单】吗？", function() {
                layer.prompt({ title: '请输入计划完成的日期', formType: 0, value: v1 }, function(text) {
                    $.ajax({
                        type: 'POST',
                        url: "Handler/DoAction.aspx",
                        data: {
                            KeyID: dataid,
                            Action: 'JieDan_Tb_Task',
                            endDate: text
                        },
                        success: function(data) {
                            if ("ok" == data) {
                                layer.alert("【接单】操作成功！", function() {
                                    $('#butSearch').click();  //重新加载页面
                                });
                            } else {
                                layer.alert("【接单】操作失败，可能的原因是你已有三个未完成的BUG工单！");
                            }
                        }
                    });
                });
            });
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
