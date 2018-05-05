<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="JOrg_List.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JOrg_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 组织机构 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        </td>
        <!--查询区设置-->
        <%-- 
           相关权限点说说明：
           JOrg_ADD：添加部门
           JOrg_EDIT : 修改
        --%>
        <div class="text-c">
            部门名称：<jasp:JTextBox ID="OrgName" runat="server" class="input-text" Style="width: 200px"
                placeholder="输入部门名称" />
            &nbsp; 状态： <span class="select-box" style="width:150px">
                <jasp:JDropDownList ID="Status" runat="server" CssClass="select">
                    <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                    <asp:ListItem Text="停用" Value="0"></asp:ListItem>
                    <asp:ListItem Text="不限" Value=""></asp:ListItem>
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server" RoleID="xtgl">
                    <a href="javascript:;" onclick="javascript:return NewDepart();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加部门</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JOrg" PageSize="-1"
            FieldsList="*" OrderBy="num">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="OrgName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Status" DataType="NumericType" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            部门编码
                        </th>
                        <th>
                            部门名称
                        </th>
                        <th>
                            上级部门
                        </th>
                        <th>
                            状态
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
                                    <%#Eval("OrgName")%>
                                </td>
                                <td>
                                    <%# KORWeb.BUL.JOrgBU.GetOrgNameByID(Eval("Parent").ToString())%>
                                </td>
                                <td>
                                    <%#Eval("Status").ToString()=="1" ? "正常":"停用"%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("OrgID") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
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
            var title = "组织机构";
            var url = "JOrg_Detail.aspx?OrgID=" + dataid;
            layer_show(title, url, 650, 400);
        }

        //2*--新增数据
        function NewDepart() {
            var title = "添加新组织机构";
            var url = "JOrg_Detail_ADD.aspx";
            layer_show(title, url, 650, 400);
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" RoleID="xtgl">
    </jasp:SecurityPanel>
</asp:Content>
