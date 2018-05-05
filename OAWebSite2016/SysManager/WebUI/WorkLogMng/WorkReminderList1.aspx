<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkReminderList1.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.WorkReminderList1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 时间管理 <span class="c-gray en">&gt;</span> 工作备忘 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            备忘日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp; 备忘内容：<jasp:JTextBox ID="LogContent" runat="server" class="input-text"
                Style="width: 300px" placeholder="" />&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 登记备忘</a> &nbsp;&nbsp; <a href="javascript:;"
                            onclick="javascript:return HasDoneData();" class="btn btn-primary radius"><i class="Hui-iconfont">
                                &#xe6a7;</i> 标为已处理</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <div style="display: none">
            <jasp:JTextBox ID="AuthorID" runat="server" TextDefaultValue="UserID"></jasp:JTextBox>
        </div>
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_WorkReminder"
            PageSize="-1" FieldsList="*" OrderBy="begDate">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="LogContent" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="begDate>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="begDate<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                   
                <jasp:ParameterItem ParaType="Control" ParaName="AuthorID" DataName="AddUserID" />
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
                        
                        <th style="width: 150px">
                            备忘日期
                        </th>
                        <th style="width: 910px">
                            备忘内容
                        </th>
                       
                        <th style="width: 150px">
                            重要程度
                        </th>
                        <th style="width: 150px">
                            是否处理
                        </th>
                        <th style="width: 150px">
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <input type="checkbox" value='<%#Eval("logID") %>' name="selectdoc">
                                </td>
                                
                                <td>
                                    <%#Eval("begDate", "{0:MM-dd dddd}")%>
                                </td>
                                <td class="text-l">
                                    <%#Eval("LogContent") %>
                                </td>
                               
                                <td>
                                    <%#Eval("JB") %>
                                </td>
                                
                                 <td>
                                    <%#(bool)Eval("IsDone")==true ? "√":"×" %>
                                </td>
                                
                                <td class="operate" style="width: 150px">
                                    <a onclick="javascript:return ReadData('<%#Eval("LogID") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                        
                                    <jasp:SecurityPanel ID="sec3" runat ="server">
                                    &nbsp;<a onclick="javascript:return DelData('<%#Eval("LogID") %>');" href='#'><img
                                        alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除</a>
                                    </jasp:SecurityPanel>
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
                "aaSorting": [[1, "asc"]], //默认第几个排序
                "bStateSave": false, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
		        //  {"orderable": false, "aTargets": [0, 5]}// 制定列不参与排序
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


        //1*--浏览或修改工作备忘
        function ReadData(dataid) {
            var title = "工作备忘";
            var url = "WorkReminderDetail.aspx?LogID=" + dataid;
            layer_show(title, url, 800, 550);
        }

        //2*--新增数据
        function NewData() {
            var title = "工作备忘";
            var url = "WorkReminderDetail.aspx";
            layer_show(title, url, 800, 550);
        }


        //3*--删除配置数据
        function DelData(dataid) {
            layer.confirm("提示：确定要删除【工作备忘】数据吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_WorkReminder'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("删除数据操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("删除数据操作失败！");
                        }
                    }
                });
            });
        }
        
        
        
        //将选中的数据标为【已处理】
        function HasDoneData() {
            var seldata = "";
            var first = true;
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

            if (seldata == "") {
                layer.alert('没有选中任何要批处理的数据!');
            }
            else {
                layer.confirm('确认要将选中的数据标记为【已处理】吗？', function(index) {
                    $.ajax({
                        type: 'POST',
                        url: "Handler/DoAction.aspx",
                        data: {
                            KeyID: seldata,
                            Action: 'HasDone_WorkReminder'
                        },
                        success: function(data) {
                            if ("ok" == data) {
                                layer.alert("【标为已处理】操作成功！", function() {
                                    $('#butSearch').click();  //重新加载页面
                                });
                            } else {
                                layer.alert("【标为已处理】操作失败！");
                            }
                        }
                    });
                });
            }
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
