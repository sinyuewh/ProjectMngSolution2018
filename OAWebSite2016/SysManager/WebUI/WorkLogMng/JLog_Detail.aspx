<%@ Page Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master" AutoEventWireup="true"
    CodeBehind="JLog_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkLogMng.JLog_Detail"
    Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 
    <span class="c-gray en">&gt;</span> 工作备忘 <span class="c-gray en">&gt;</span>备忘日志 <script language="javascript" type="text/javascript"></script>
    <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            操作日期：<jasp:JTextBox ID="Time0" runat="server" onclick="$.calendar();" class="input-text"
                Style="width: 100px" />
            ～
            <jasp:JTextBox ID="Time1" runat="server" onclick="$.calendar();" class="input-text"
                Style="width: 100px" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加日志</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JLog" PageSize="-1"
            FieldsList="*" OrderBy="uploadTime desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="RequestQueryString" ParaName="LogID" DataName="ParentGuid" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="uploadTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="uploadTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th width="150">
                            记录时间
                        </th>
                        <th width="100">
                            记录用户
                        </th>
                        <th width="600">
                            日志内容
                        </th>
                        <th width="100">
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <%#Eval("uploadTime", "{0:yyyy.MM.dd mm:ss}")%>
                                </td>
                                <td>
                                    <%#Eval("uploadPerson")%>
                                </td>
                                <td>
                                    <%#Eval("content")%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("guidID") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                        
                                    <jasp:SecurityPanel ID="sec1" runat="server" IsAlwaysReload="true">
                                        &nbsp;&nbsp; <a onclick="javascript:DeleteGuidID('<%#Eval("guidID") %>');" href='#'>
                                            <img src="/images/Frame/del.gif" width="16" height="16" border="0" alt="" />删除</a>
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
                "aaSorting": [[0, "desc"]], //默认第几个排序
                "bStateSave": true, //状态保存
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

        //*--新增数据
        function NewData() {
            var title = "添加日志";
            var ParentGuid = '<%=Request.QueryString["LogID"]%>';
            var url = "JLogData_Detail_ADD.aspx?ParentGuid=" + ParentGuid;
            layer_show(title, url, 650, 450);
        }

        //*--记录明细
        function ReadData(dataid) {
            var title = "日志明细";
            var url = "JLog_Data_Detail.aspx?guidID=" + dataid;
            layer_show(title, url, 650, 400);
        }

        //2*--删除数据
        function DeleteGuidID(dataid) {
            layer.confirm("警告：确定要删除日志吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_JLog'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("【删除日志】操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("【删除日志】操作失败！");
                        }
                    }
                    //,dataType: "json"
                });
            });
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
