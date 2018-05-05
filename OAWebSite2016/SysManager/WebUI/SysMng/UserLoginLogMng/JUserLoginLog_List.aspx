<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="JUserLoginLog_List.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JUserLoginLog_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 登录日志 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说说明：
           JUserLoginLog_READ ：浏览
           JUserLoginLog_EDIT : 修改
        --%>
        <div class="text-c">
            登录用户：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入登录用户姓名" />&nbsp; 登录时间：<jasp:JTextBox ID="Time0" runat="server" onclick="$.calendar();"
                    class="input-text" Style="width: 150px" placeholder="输入登录开始时间" />
            ～
            <jasp:JTextBox ID="Time1" runat="server" onclick="$.calendar();" class="input-text"
                Style="width: 150px" placeholder="输入登录结束时间" />
            &nbsp;备注：<jasp:JTextBox ID="Remark" runat="server" class="input-text" Style="width: 200px"
                placeholder="输入备注" />
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
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserLoginLog" PageSize="-1"
            FieldsList="*" OrderBy="id desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Remark" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="CreateTime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="CreateTime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            登录时间
                        </th>
                        <th>
                            用户ID
                        </th>
                        <th>
                            用户姓名
                        </th>
                        <th>
                            备注
                        </th>
                       
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <%#Eval("CreateTime") %>
                                </td>
                                <td>
                                    <%#Eval("UserID") %>
                                </td>
                                <td>
                                    <%#Eval("UserName") %>
                                </td>
                                <td>
                                    <%#Eval("Remark") %>
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
                    //  { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
		            //   {"orderable": false, "aTargets": [4]}// 制定列不参与排序
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

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" RoleID="xtgl" >
    </jasp:SecurityPanel>
</asp:Content>
