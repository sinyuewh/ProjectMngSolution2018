<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Project_DetailGXD.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_Project_Detail" %>

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
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 项目贡献度</nav>
    <div class="pd-20">
        <!--查询区设置-->
        <!--操作区设置-->
        <div class="text-c" style="display: none">
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20" style="margin-top: -10px">
            <span class="l">
                <jasp:SecurityPanel ID="Security0" runat="server" AuthorityID="ProjectGXD_ADD">
                    <a href="javascript:;" onclick="javascript:return CreateProjectGXDData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 统计项目贡献度</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KH_Project_Person"
            PageSize="-1" FieldsList="*" OrderBy="DataID">
            <ParaItems>
                <jasp:ParameterItem ParaName="ProjectGuid" ParaType="RequestQueryString" DataName="ParentID" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            用户姓名
                        </th>
                        <th>
                            累计工作量
                        </th>
                        <th>
                            加权系数
                        </th>
                        <th>
                            等价工作量
                        </th>
                        <th>
                            贡献比(%)
                        </th>
                        <th>
                            贡献度
                        </th>
                        <th>
                            备注
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
                                    <%#Eval("username") %>
                                </td>
                                <td>
                                    <%#Eval("WorkLoad")%>
                                </td>
                                <td>
                                    <%#Eval("WorkRate")%>
                                </td>
                                <td>
                                    <%#Eval("factWorkLoad")%>
                                </td>
                                <td>
                                    <%#Eval("GxRate")%>%
                                </td>
                                <td>
                                    <%#Eval("GxMoney")%>
                                </td>
                                <td>
                                    <%#Eval("remark")%>
                                </td>
                                <td class="operate">
                                    <jasp:SecurityPanel ID="Security0" runat="server" IsAlwaysReload="true" AuthorityID="ProjectGXD_EDIT">
                                        <a title="调整数据" onclick="javascript:return ReadData('<%#Eval("DataID") %>');" href='#'>
                                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />调整</a>
                                    </jasp:SecurityPanel>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                <tfoot>
                    <tr class="text-c">
                        <th>
                            合计
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                    </tr>
                </tfoot>
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
		          {"orderable": false, "aTargets": [7]}// 制定列不参与排序
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


            //计算合计数//统计1、2、4列
            var table1 = $('.table-sort').DataTable();
            var arr1 = new Array(1,3,5);
            for (var i = 0; i < arr1.length; i++) {
                var sum1 = table1.column(arr1[i]).data().reduce(function(a, b) {

                    if (isNaN(a)) a = $(a).html();
                    if (isNaN(b)) b = $(b).html();
                    return parseInt(a) + parseInt(b);
                });

                $('.table-sort tfoot th').eq(arr1[i]).html(sum1 + "");
            }

            //动态改变表格中其他列的内容
            /*
            var len1 = table1.data().length;
            for (var i = 0; i < len1; i++) {
            var v3 = table1.cell(i, 3).data();
            v3 = parseFloat(v3);
            v3 = v3 *100/ sum1;
            v3 = v3.toFixed(2)+"%";
            table1.cell(i, 4).data(v3).draw();
            }*/

        });

        //read data
        function ReadData(dataid) {
            var title = "调整工作量加权系数";
            var url = "Tb_Project_GXD_Detail.aspx?DataID=" + dataid;
            layer_show(title, url, 600, 350);
        }


        //create new data
        function CreateProjectGXDData() {

            layer.confirm('确认要执行【统计项目贡献度】的操作吗？', function(index) {
                var ProjectGuid = '<%=Request.QueryString["ProjectGuid"] %>';
                //alert(ProjectGuid);
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: ProjectGuid,
                        Action: 'CREATE_ProjectGXDData'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("【统计项目贡献度】操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("【统计项目贡献度】操作失败！");
                        }
                    }
                });

                layer.close(index);

            });

        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="ProjectGXD_READ">
    </jasp:SecurityPanel>
</asp:Content>
