<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Person_YearCheckList.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_Person_YearCheckList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <%-- 
           相关权限点说说明：
           Tb_PL_Month_READALL ：浏览所有数据
           Tb_PL_Month_ADD :  创建考核数据
           
           普通用户只能看自己相关的数据，
           Tb_PL_Month_READALL 可以查看所有的数据
        --%>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 年度贡献度 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div style="display: none">
            <jasp:JTextBox ID="UserID" runat="server" />
        </div>
        <div class="text-c">
            用户姓名：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp;年份：<jasp:JTextBox ID="khyear" runat="server" class="input-text" Style="width: 80px"
                placeholder="" />
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
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="TB_KH_YearView"
            PageSize="-1" FieldsList="*">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="khyear" DataType="NumericType" />
                <jasp:ParameterItem  ParaType="Control" ParaName="UserID" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            年度
                        </th>
                        <th>
                            用户姓名
                        </th>
                        <th>
                            累计工作量
                        </th>
                        <th>
                            累计贡献度
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
                                    <%#Eval("khyear")%>
                                </td>
                                <td>
                                    <%#Eval("username") %>
                                </td>
                                <td>
                                    <%#Eval("FactWorkLoad1")%>
                                </td>
                                <td>
                                    <%#Eval("GxMoney1")%>
                                </td>
                                <td class="operate">
                                    <a title="查看贡献度明细" onclick="javascript:return ReadData('<%#Eval("UserID") %>',<%#Eval("khyear")%>,'<%#Eval("username") %>');"
                                        href='#'>【查看明细】</a>
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
                "bStateSave": false, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
		          {"orderable": false, "aTargets": [4]}// 制定列不参与排序
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

        //read data
        function ReadData(userid,khyear,username) {
            var title = "查看【" + username + "】" + khyear + "年度贡献度明细";
            var url = "Tb_Person_YearCheckListAll.aspx?UserID=" + userid +"&KhYear="+khyear;
            //layer_show(title, url, 600, 350);

            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }
    </script>

    
</asp:Content>
