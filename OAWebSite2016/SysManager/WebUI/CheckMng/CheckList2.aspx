<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="CheckList2.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.CheckList2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 月度考核 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说说明：
           
           Tb_KH_Project_READ ：      浏览所有用户的项目考核数据
           Tb_KH_Project_ADD：        创建项目考核数据
           Tb_KH_Project_EDIT：         修改项目考核数据
        --%>
        <div class="text-c">
            项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 150px"
                placeholder="输入项目名称" />
            &nbsp; 完成日期：<jasp:JTextBox ID="Time0" runat="server" onclick="$.calendar();" class="input-text"
                Style="width: 120px" placeholder="" />
            ～
            <jasp:JTextBox ID="Time1" runat="server" onclick="$.calendar();" class="input-text"
                Style="width: 120px" placeholder="" />&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="Tb_KH_Project_ADD">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 生成项目考核数据</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KH_Project" FieldsList="*"
            OrderBy="byear desc,prjNum" PageSize="-1">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                
                 <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="FactEndDate>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="FactEndDate<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            年份
                        </th>
                        <th>
                            项目编号
                        </th>
                        <th>
                            项目名称
                        </th>
                        <th>
                            开始日期
                        </th>
                        <th>
                            计划完成
                        </th>
                        <th>
                            实际完成
                        </th>
                        <th>
                            延期率
                        </th>
                        <th>
                            总派工量
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
                                    <%#Eval("byear") %>
                                </td>
                                <td>
                                    <%#Eval("prjNum") %>
                                </td>
                                <td>
                                    <%#Eval("prjName") %>
                                </td>
                                <td>
                                    <%#Eval("BegDate") %>
                                </td>
                                <td>
                                    <%#Eval("PlanEndDate") %>
                                </td>
                                <td>
                                    <%#Eval("FactEndDate") %>
                                </td>
                                <td>
                                    <%#Eval("DelayRate") %>
                                </td>
                                <td>
                                    <%#Eval("TotalWorkLoad") %>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("GuidID") %>');" href='#'>
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
		          {"orderable": false, "aTargets": [8]}// 制定列不参与排序
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
            var title = "生成项目考核数据";
            var url = "Tb_KH_Project_ADD.aspx";
            layer_show(title, url, 650, 350);
        }

    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
