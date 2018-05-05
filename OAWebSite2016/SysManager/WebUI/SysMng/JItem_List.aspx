<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="JItem_List.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JItem_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 系统条目 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说说明：
           JItem_ADD：添加条目（仅对admin有用，不写入权限）
           JItem_READ ：浏览
           JItem_EDIT : 修改
           JItem_DEL :  删除（仅对admin有用，不写入权限）
           JItem_SET : 设置条目值
        --%>
        <div class="text-c">
            条目名称：<jasp:JTextBox ID="Itemname" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入条目名称" />
            &nbsp; 备注：<jasp:JTextBox ID="Remark" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入备注" />&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server" RoleID="xtgl">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加条目</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JItem" PageSize="-1"
            FieldsList="*" OrderBy="JItem.num">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="Itemname" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Remark" SearchOperator="Contains" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            排序
                        </th>
                        <th>
                            条目名称
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
                                    <%#Eval("num")%>
                                </td>
                                <td>
                                    <%#Eval("itemname")%>
                                </td>
                                <td>
                                    <%#Eval("remark")%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("Itemname") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                    <jasp:SecurityPanel ID="sec0" runat="server" RoleID="xtgl" IsAlwaysReload="true" >
                                        &nbsp; <a onclick="javascript:return DelData('<%#Eval("Itemname") %>');" href='#'>
                                            <img alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除</a>
                                    </jasp:SecurityPanel>
                                    <jasp:SecurityPanel ID="SecurityPanel1" runat="server">
                                        &nbsp; <a onclick="javascript:return SetItemValue('<%#Eval("Itemname") %>');" href='#'>
                                            <img src="/images/Frame/gtk-ok.png" width="16" height="16" border="0" alt="" />条目的值</a>
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
                "aaSorting": [[0, "asc"]], //默认第几个排序
                "bStateSave": false, //状态保存
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

        //1*--浏览或修改数据
        function ReadData(dataid) {
            var title = "系统条目";
            var url = "JItem_Detail.aspx?ItemName=" + dataid;
            layer_show(title, url, 650, 450);
        }

        //2*--新增数据
        function NewData() {
            var title = "添加新条目";
            var url = "JItem_Detail_ADD.aspx";
            layer_show(title, url, 650, 450);
        }

        //3*--删除条目
        function DelData(dataid) {
            layer.confirm("提示：确定要删除【系统条目】的数据吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_JItem'
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

        //4--设置条目的值
        function SetItemValue(dataid) {
            var title = "条目【"+dataid+"】的多个值";
            var url = "JItem_SetItemValues.aspx?ItemName=" + dataid;
            layer_show(title, url, 800, 500);
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
