<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="JStrInfo_List.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JStrInfo_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 系统配置 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说明：     
           JStrInfo_READ               浏览
           JJStrInfo_ADD               添加 （仅对admin有用，不写入权限）
           JStrInfo_EDIT               修改
           JStrInfo_DEL                删除 （仅对admin有用，不写入权限）
        --%>
        <div class="text-c">
            配置Key：<jasp:JTextBox ID="strID" runat="server" class="input-text" Style="width: 150px"
                placeholder="配置Key" />
            &nbsp; 配置Value：<jasp:JTextBox ID="strText1" runat="server" class="input-text" Style="width: 150px"
                placeholder="配置Value" />
            &nbsp; 备注：<jasp:JTextBox ID="Remark" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入备注" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="JStrInfo_ADD">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加系统配置</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JStrInfo" PageSize="-1"
            OrderBy="num">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="strID" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="strText1" SearchOperator="Contains" />
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
                            配置Key
                        </th>
                        <th>
                            配置Value
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
                                    <%#Eval("num") %>
                                </td>
                                <td>
                                    <%#Eval("strID") %>
                                </td>
                                <td>
                                    <%# WebFrame.Util.JString.GetMaxLenth(Eval("strText1").ToString(),100) %>
                                </td>
                                <td>
                                    <%#Eval("Remark") %>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("strID") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="JStrInfo_DEL" IsAlwaysReload="true">
                                        &nbsp;<a onclick="javascript:return DelData('<%#Eval("strID") %>');" href='#' style='display: <%#Eval("Kind").ToString()=="1" ? "none":"" %>'><img
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

        //1*--浏览或修改数据
        function ReadData(dataid) {
            var title = "配置信息";
            var url = "JStrInfo_Detail.aspx?strID=" + dataid;
            //layer_show(title, url, 800, 550);

            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }

        //2*--新增数据
        function NewData() {
            var title = "添加新配置";
            var url = "JStrInfo_Detail_ADD.aspx";
            //layer_show(title, url, 800, 450);

            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }

        //3*--删除配置数据
        function DelData(dataid) {
            layer.confirm("提示：确定要删除系统配置数据吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_JStrInfo'
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

        
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="JStrInfo_READ">
    </jasp:SecurityPanel>
</asp:Content>
