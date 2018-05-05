<%-- Author:admin--%>
<%-- DateTime:2016/5/31 14:28:09--%>

<%@ Page Title="用户列表" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="JUserLoginLog_List.aspx.cs" Inherits="KORWeb.WebSite.admin47142725.JUserLoginLog_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 人员管理 <span class="c-gray en">&gt;</span> 登录日志 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            用户名：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入用户名" />&nbsp;
            用户ID：<jasp:JTextBox ID="UserID" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入用户ID" />&nbsp;
                  登录时间：<jasp:JTextBox ID="beginDate" runat="server" class="input-text" Style="width: 150px"
                placeholder="开始时间" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />&nbsp; 至：<jasp:JTextBox
                    ID="endDate" runat="server" class="input-text" Style="width: 150px" placeholder="结束时间"
                    onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec3" runat="server" AuthorityID="$$0" Visible="false">
                    <a href="javascript:;" onclick="javascript:return DeleteData('');" class="btn btn-danger radius">
                        <i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
                </jasp:SecurityPanel>
                <jasp:SecurityPanel ID="sec1" runat="server" IsAlwaysReload="true" AuthorityID="$$1" Visible="false">
                    <a href="javascript:;" onclick="javascript:return EditData('');" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加JUserLoginLog</a>
                </jasp:SecurityPanel>
            </span><span class="r"  style="display:none">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="V_JUserLoginLog" PageSize="-1"
            FieldsList="top(300) *">
            <ParaItems>
                 <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UseObj8" DataName ="Province"   ParaName="xx" />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UseObj9" DataName ="City"  ParaName="xx"  />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UseObj10" DataName ="District"  ParaName="xx" />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="DepartID" DataName ="DepartID"   ParaName="xx" />
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="UserID" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="beginDate" DataName ="CreateTime" SearchOperator="BiggerAndEqual" />
                <jasp:ParameterItem ParaType="Control" ParaName="endDate" DataName ="CreateTime" SearchOperator="SmallerAndEqual" />
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
                            用户ID
                        </th>
                        <th>
                            用户名称
                        </th>
                        <th>
                            登录时间
                        </th>
                        <th>
                            登录IP
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <input type="checkbox" value='<%#Eval("ID") %>' name="selectdoc">
                                </td>
                                <td>
                                    <%#Eval("UserID")%>
                                </td>
                                <td>
                                    <%#Eval("UserName")%>
                                </td>
                                  <td>
                                    <%#Eval("CreateTime", "{0:yyyy-MM-dd HH:mm:ss}")%>
                                </td>
                                 <td>
                                    <%#Eval("Remark")%>
                                </td>
                           <%--     <td class="operate">
                                    <a style="display:none" onclick="javascript:return EditData('<%#Eval("ID") %>');" href='#'>明细</a>
                                    <jasp:SecurityPanel ID="sec30" runat="server" IsAlwaysReload="true" AuthorityID="$$3">
                                        <a onclick="javascript:return DeleteData('<%#Eval("ID") %>');" href='#'>
                                            删除</a>
                                    </jasp:SecurityPanel>
                                </td>--%>
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
                {"bVisible": false, "aTargets": [0]}, //控制列的隐藏显示
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
        });

        //1*---删除数据(单条或多条）
        function DeleteData(dataid) {
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
                layer.alert('没有选中任何要删除的数据!');
            }
            else {
                layer.confirm('确认要删除选中的数据吗？', function(index) {
                    var succ = KORWeb.WebSite.admin47142725.JUserLoginLog_List.DeleteData(seldata).value;
                    if (succ) {
                        layer.msg("删除成功！", { icon: 1, time: 1000 });
                        $('#butSearch').click();
                    }
                    else {
                        layer.msg("删除失败，请重试！", { icon: 1, time: 1000 });
                    }
                });
            }
        }

        //2*--新增或编辑数据
        function EditData(dataid) {
            var title = "";
            var url = "";
            if (dataid == "") {
                title = "新增JUserLoginLog";
                url = "JUserLoginLog_Detail.aspx";
            }
            else {
                title = "编辑JUserLoginLog";
                url = "JUserLoginLog_Detail.aspx?ID="+dataid;
            }

            layer_show(title, url, 800, 600);
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
    </jasp:SecurityPanel>
</asp:Content>
