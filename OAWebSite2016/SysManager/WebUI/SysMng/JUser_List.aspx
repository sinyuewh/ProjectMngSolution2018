<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="JUser_List.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JUser_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 用户列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说说明：
           
           JUser_READ ：浏览
           JJUser_ADD：添加用户
           JUser_EDIT : 修改
           JUser_RESET : 重置密码
        --%>
        <div class="text-c">
            姓名：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入用户姓名" />
            &nbsp; 状态： <span class="select-box" style="width: 120px">
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
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加用户</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUserView"
            OrderBy="num" PageSize="-1">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" DataName="UserName"
                    SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Status" DataName="Status"
                    DataType="NumericType" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="UserID<>'admin'"
                    SearchOperator="UserDefine" />
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
                            用户ID
                        </th>
                        <th>
                            姓名
                        </th>
                        <th>
                            所在部门
                        </th>
                        <th>
                            部门负责人
                        </th>
                        <th>
                            最近登录
                        </th>
                        <th>
                            登录次数
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
                                    <%#Eval("num") %>
                                </td>
                                <td>
                                    <%#Eval("UserID") %>
                                </td>
                                
                                <td>
                                    <%#Eval("UserName") %>
                                </td>
                                
                                <td>
                                    <%#Eval("orgName") %>
                                </td>
                                
                                 <td>
                                    <%#Eval("DepartLeader") %>
                                </td>
                                
                                <td>
                                    <%#Eval("LastLogin") %>
                                </td>
                                <td>
                                    <%#Eval("LoginCount") %>
                                </td>
                                <td>
                                    <%#Eval("Status").ToString()=="1" ? "正常":"停用"%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("UserID") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                    <jasp:SecurityPanel ID="sec0" runat="server" RoleID="xtgl">
                                        &nbsp; <a onclick="javascript:return ResetPassWord('<%#Eval("UserID") %>');" href="#">
                                            <img alt="" src="/images/Frame/ico/person.png" width="16" height="16" border="0" />重置密码</a>
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
                "bStateSave": true, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
		          {"orderable": false, "aTargets": [6]}// 制定列不参与排序
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
            var title = "用户信息";
            var url = "JUser_Detail.aspx?UserID=" + dataid;
            layer_show(title, url, 650, 450);
        }

        //2*--新增数据
        function NewData() {
            var title = "添加新用户";
            var url = "JUser_Detail_ADD.aspx";
            layer_show(title, url, 650, 450);
        }

        //3*--重置用户密码
        function ResetPassWord(userid) {
            layer.confirm("提示：确定需要重置密码吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: userid,
                        Action: 'RESETPASSWORD_JUser'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("重置密码操作成功！");
                        } else {
                            layer.alert("重置密码操作失败！" + data);
                        }
                    }
                });
            });
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
