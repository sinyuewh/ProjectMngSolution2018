<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master" 
AutoEventWireup="true" CodeBehind="CheckList1.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.CheckList1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 月度考核 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说说明：
           
           Tb_KH_Month_READ ：  浏览所有用户的月度考核数据
           Tb_KH_Month_ADD：    创建月度考核数据
           Tb_KH_Month_EDIT：   修改月度考核数据
        --%>
        <div class="text-c">
            <jasp:JTextBox ID="UserID" runat="server" Visible="false"></jasp:JTextBox>
            姓名：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入用户姓名" />
            &nbsp; 年份：<jasp:JTextBox ID="byear" runat="server" class="input-text" Style="width: 100px"
                placeholder="输入考核年份" />
            &nbsp; 月份：<jasp:JTextBox ID="bmonth" runat="server" class="input-text" Style="width: 100px"
                placeholder="输入考核月份" />
            
            &nbsp;&nbsp;    
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="Tb_KH_Month_ADD">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 汇总月度考核数据</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KH_MonthView"
            FieldsList="*" OrderBy="byear desc,bmonth desc" PageSize="-1">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" DataName="UserName"
                    SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="byear"  />
                <jasp:ParameterItem ParaType="Control" ParaName="bmonth"  />
                 <jasp:ParameterItem ParaType="Control" ParaName="UserID"  />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            年月
                        </th>
                        <th>
                            用户ID
                        </th>
                        <th>
                            姓名
                        </th>
                        <th>
                            满荷工作量
                        </th>
                        <th>
                            综合完成工作量
                        </th>
                        <th>
                            完成率（%）
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
                                    <%#Eval("byear") %>- <%#Eval("bmonth") %>
                                </td>
                                <td>
                                    <%#Eval("UserID") %>
                                </td>
                                <td>
                                    <%#Eval("UserName") %>
                                </td>
                                <td>
                                    <%#Eval("FullLoad") %>
                                </td>
                                <td>
                                    <%#Eval("WorkLoad") %>
                                </td>
                                <td>
                                    <%#Eval("Rate") %> %
                                </td>
                                
                                <td>
                                    <%#Eval("Remark") %>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("DataID") %>');" href='#'>
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
        });

        //1*--浏览或修改数据
        function ReadData(dataid) {
            var title = "月度考核数据";
            var url = "Tb_KH_Month_READ.aspx?DataID=" + dataid;
            layer_show(title, url, 650, 450);
        }

        //2*--新增数据
        function NewData() {
            var title = "汇总月度考核数据";
            var url = "Tb_KH_Month_ADD.aspx";
            layer_show(title, url, 500, 300);
        }

    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
