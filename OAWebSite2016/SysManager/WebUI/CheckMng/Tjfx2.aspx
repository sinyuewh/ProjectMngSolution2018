<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tjfx2.aspx.cs" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tjfx2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计分析 <span class="c-gray en">&gt;</span> 项目支出统计 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            项目名称：<span class="select-box" style="width: auto">
                <jasp:JDropDownList ID="parentGuid" runat="server" CssClass="select">
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp; 统计时间段：<jasp:JTextBox ID="Time0" runat="server" class="input-text"
                Style="width: 150px" placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 150px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="" runat="server">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            姓名
                        </th>
                        <th>
                            累计支出（元）
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                   <%#Eval("UserName") %>
                                </td>
                                <td>
                                    <%#Eval("projectMoney","{0:c}")%>
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
