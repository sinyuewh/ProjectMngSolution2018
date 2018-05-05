<%-- Author:admin--%>
<%-- DateTime:2016/5/31 14:28:33--%>

<%@ Page Title="用户列表" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" 
    CodeBehind="JUser_List.aspx.cs" Inherits="KORWeb.WebSite.admin29241310.JUser_List"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 人员管理 <span class="c-gray en">&gt;</span> 用户管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            用户名：
            <jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 250px"
                placeholder="输入用户名称" />
                用户ID：<jasp:JTextBox ID="UserID" runat="server" class="input-text" Style="width: 250px"
                placeholder="输入用户ID" />
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec3" runat ="server" AuthorityID="A1">
					<a href="javascript:;" onclick="javascript:return DeleteData('');"
						class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
				</jasp:SecurityPanel>


                 <jasp:SecurityPanel ID="sec1" runat ="server" IsAlwaysReload="true" AuthorityID="A1">    
                 <a href="javascript:;"
                    onclick="javascript:return EditData('');" class="btn btn-primary radius"><i class="Hui-iconfont">
                        &#xe600;</i> 添加用户</a> 
                 </jasp:SecurityPanel>
                        
              </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong>
                            条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUser" PageSize="-1"
            FieldsList="top(300) *">
            <ParaItems>
                <%--<jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UseObj8" DataName ="Province"   ParaName="xx" />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UseObj9" DataName ="City"  ParaName="xx"  />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UseObj10" DataName ="District"  ParaName="xx" />--%>
                 <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="DepartID" DataName ="DepartID"   ParaName="xx" />
                 <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
                 <jasp:ParameterItem ParaType="Control" ParaName="UserID" SearchOperator="Contains" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display:none">
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
                            用户名
                        </th>
                         <th>
                            用户权限
                        </th>
                        
                         <th>
                            登录次数
                        </th>
                        <th>
                            最近登录
                        </th>
                        <th>
                            用户状态
                        </th>
                        <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityID="A1">
                            <th>
                                操作
                            </th>
                        </jasp:SecurityPanel>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <input type="checkbox" value='<%#Eval("UserID") %>' name="selectdoc">
                                </td>
                                <td>
                                    <%#Eval("UserID") %>
                                </td>
                                <td>
                                    <%#Eval("UserName") %>
                                </td>
                                 <td>
                                    <%#Eval("AuthorityID").ToString() == "A1" ? "管理者" : Eval("AuthorityID").ToString() == "A2"? "操作者" : "读者" %>
                                </td>
                             
                                <td>
                                    <%#Eval("LoginCount") %>
                                </td>
                                 <td>
                                    <%#Eval("LastLogin") %>
                                </td>
                                 <td>
                                    <%#Eval("status").ToString() == "0" ? "停用" : "正常"%>
                                </td>
                                <jasp:SecurityPanel ID="SecurityPanel1" runat="server" AuthorityID="A1">
                                    <td class ="operate">
                                        <a onclick="javascript:return EditData('<%#Eval("UserID") %>');" href='#'>修改</a>&nbsp;|&nbsp;
                                        <a onclick="javascript:return DeleteData('<%#Eval("UserID") %>');" href='#'>删除</a>
                                    </td>
                                </jasp:SecurityPanel>
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
               
                  <% if(WebFrame.FrameLib.AuthorityID=="A1"){ %>
		            {"orderable": false, "aTargets": [0, 7]}// 制定列不参与排序
		          <% } else { %>
		             {"bVisible": false, "aTargets": [ 0 ]}, //控制列的隐藏显示
		             {"orderable": false, "aTargets": [0]}// 制定列不参与排序
		          <% } %>
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
                    var succ = KORWeb.WebSite.admin29241310.JUser_List.DeleteData(seldata).value;
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
                title = "新增用户";
                url = "JUser_Detail.aspx";
            }
            else {
                title = "编辑查看用户";
                url = "JUser_Detail.aspx?UserID="+dataid;
            }

            layer_show(title, url, 500, 480);
        }
</script>

<jasp:SecurityPanel ID="sec0" runat ="server" AuthorityKind="DirectNoAccessPage" AuthorityID="$$0">
</jasp:SecurityPanel>
</asp:Content>