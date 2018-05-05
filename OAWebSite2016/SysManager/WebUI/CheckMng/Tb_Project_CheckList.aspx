<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_Project_CheckList.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_Project_CheckList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 项目贡献度 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <%-- 
           相关权限点说明：     
           Tb_Project_READ               浏览
           JTb_Project_ADD               添加
           Tb_Project_EDIT               修改
           Tb_Project_DEL                删除
           
           Tb_Project_SURE               项目立项
           Tb_Project_DELAY              项目延期
           Tb_Project_COMPLETE           项目完成
           Tb_Project_CANCEL             项目取消
           
           
           Tb_Project_PERSON             项目组成员管理
           Tb_Project_ATTACH             项目附件管理
           
        --%>
        <div class="text-c">
            项目编号：<jasp:JTextBox ID="prjNum" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp; 项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp;立项日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <%-- <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="Tb_Project_ADD">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加新项目</a>
                </jasp:SecurityPanel>--%>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project" PageSize="-1"
            OrderBy="begDate desc" FieldsList="Tb_Project.*, datediff( 'd',enddate,finishdate) as yq">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjNum" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="begDate>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="begDate<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Status =2" SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            项目编号
                        </th>
                        <th>
                            项目名称
                        </th>
                        
                        <th>
                            立项日期
                        </th>
                        <th>
                            计划完成
                        </th>
                        <th>
                            实际完成
                        </th>
                        <th>
                            逾期
                        </th>
                        <th>
                            核算金额
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
                                    <%#Eval("prjNum") %>
                                </td>
                                <td>
                                    <%#Eval("prjName") %>
                                </td>
                                
                                <td>
                                    <%#Eval("begDate","{0:yyyy-MM-dd}") %>
                                </td>
                                <td>
                                    <%#Eval("endDate","{0:yyyy-MM-dd}") %>
                                </td>
                                <td>
                                    <%#Eval("FinishDate", "{0:yyyy-MM-dd}")%>
                                </td>
                                <td>
                                    <%# int.Parse(Eval("yq").ToString()) < 0 ? "0" : Eval("yq")%>
                                </td>
                                <td >
                                     <%#Eval("HSMoney")%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("GuidID") %>');" href='#'>
                                        【查看贡献度】</a>
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
                "aaSorting": [[3, "desc"]], //默认第几个排序
                "bStateSave": true, //状态保存
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
            var title = "项目贡献度";
            var url = "Tb_Project_DetailGXD.aspx?ProjectGuid=" + dataid;
            //layer_show(title, url, 800, 450);

            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }

        
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" AuthorityID="ProjectGXD_READ">
    </jasp:SecurityPanel>
</asp:Content>
