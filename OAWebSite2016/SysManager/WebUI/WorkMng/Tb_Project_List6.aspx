<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" CodeBehind="Tb_Project_List6.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkMng.Tb_Project_List6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 工作管理 <span class="c-gray en">&gt;</span> 我工作的项目 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            项目编号：<jasp:JTextBox ID="prjNum" runat="server" class="input-text" Style="width: 100px"
                placeholder="" />
            &nbsp;&nbsp; 项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 120px"
                placeholder="" />
            &nbsp;&nbsp;立项日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 100px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 100px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp; 项目状态： <span class="select-box" style="width: 120px">
                <jasp:JDropDownList ID="Status" runat="server" CssClass="select">
                    <asp:ListItem Text ="实施中" Value="1"></asp:ListItem>
                    <asp:ListItem Text ="已完成" Value="2"></asp:ListItem>
                    <asp:ListItem Text ="--不限--" Value=""></asp:ListItem>
                </jasp:JDropDownList></span>
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
            OrderBy="begDate desc" FieldsList="Tb_Project.*, datediff( 'd',enddate,Now()) as yq">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjNum" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="begDate>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="begDate<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UserID" ParaName="xx"
                    DataName=" exists (select 1 from Tb_Project_Person where ProjectGuidID=Tb_Project.Guidid and PersonID='{0}') "
                    SearchOperator="UserDefine" />
                    
                 <jasp:ParameterItem ParaType="Control" ParaName="Status" DataType="NumericType" />
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
                            计划完成日期
                        </th>
                        <th>
                            逾期(天)
                        </th>
                        <th>
                            类别
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
                                    <%# int.Parse(Eval("yq").ToString()) < 0 ? "0" : Eval("yq")%>
                                </td>
                                <td>

                                    <script language="javascript">document.write(arrKind[<%#Eval("prjKind")%>])</script>

                                </td>
                                <td>
                                    <%#Eval("contenttext")%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("PrjNum") %>');" href='#'>
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
                "aaSorting": [[2, "desc"]], //默认第几个排序
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
            var title = "项目信息";
            var url = "Tb_Project_Detail.aspx?prjNum=" + dataid;
            //layer_show(title, url, 800, 600);

            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }

      
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
