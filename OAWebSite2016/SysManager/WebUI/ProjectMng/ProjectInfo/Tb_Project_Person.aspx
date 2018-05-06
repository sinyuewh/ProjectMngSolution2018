<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Project_Person.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.ProjectMng.Tb_Project_Person" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb">项目组成员 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20" style="margin-top: -20px">
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <% if (this.IsAdmin.Text == "1")
                   { %>
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加新成员</a>
                <% } %>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
            <div style="display: none">
                <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 查询</button>
            </div>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project_Person"
            PageSize="-1" OrderBy="num">
            <ParaItems>
                <jasp:ParameterItem ParaType="RequestQueryString" ParaName="parentGuid" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div>
            <jasp:JTextBox ID="IsAdmin" runat="server" Text ="0" Visible="false"></jasp:JTextBox>
        </div>
        <div class="mt-20" >
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            序号
                        </th>
                        <th>
                            用户ID
                        </th>
                        <th>
                            用户姓名
                        </th>
                        <th>
                            角色
                        </th>
                       <%-- <th>
                            系数
                        </th>--%>
                        <% if (this.IsAdmin.Text == "1")
                           { %>
                            <th>
                                操作
                            </th>
                       <% } %>
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
                                    <%#Eval("UserName")%>
                                </td>
                                <td>
                                    <%# WebFrame.Comm.JItemBU.GetItemTextByKey("ProjectRole",Eval("PrjRole").ToString())%>
                                </td>
                                <%--<td>
                                    <%#Eval("Weight")%>
                                </td>--%>
                                <% if (this.IsAdmin.Text == "1")
                                   { %>
                                    <td class="operate">
                                        <a onclick="javascript:return  EditData('<%#Eval("GuidID") %>');" href='#'>
                                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />修改</a>
                                        &nbsp;<a onclick="javascript:return DelData('<%#Eval("GuidID") %>');" href='#'><img
                                            alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除</a>
                                    </td>
                                <% } %>
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
                //           {"orderable": false, "aTargets": [5]}// 制定列不参与排序
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


        //2*--新增数据
        function NewData() {
            var title = "添加新成员";
            var url = 'Tb_Project_Person_ADD.aspx?parentGuid=<%=Request.QueryString["parentGuid"] %>';
            layer_show(title, url, 500,300);
        }

        //3*--修改数据
        function EditData(data1) {
            var title = "编辑成员数据";
            var url = "Tb_Project_Person_Edit.aspx?GuidID=" + data1;
            layer_show(title, url, 500, 300);
        }

        //4*--删除数据
        function DelData(dataid) {
            layer.confirm("提示：确定要删除项目组成员吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "../Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_Tb_Project_PERSON'
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

</asp:Content>
