<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目列表 <span class="c-gray en">&gt;</span> 已完成项目 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            项目编号：<jasp:JTextBox ID="prjNum" runat="server" class="input-text" Style="width: 150px"
                placeholder="" autocomplete="on" list="datalist1" />
            &nbsp;&nbsp; 项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 200px"
                placeholder="" autocomplete="on" list="datalist2" />
            &nbsp;&nbsp;立项日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
                
            <datalist id="datalist1">
                <asp:Repeater ID="rep1" runat="server" DataSourceID="data1" EnableViewState="false">
                    <ItemTemplate>
                        <option value="<%#Eval("prjNum")%>"><%#Eval("prjNum")%></option>
                    </ItemTemplate>
                </asp:Repeater>
             </datalist>
             
             <datalist id="datalist2">
                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="data1" EnableViewState="false">
                    <ItemTemplate>
                        <option value="<%#Eval("prjName")%>"><%#Eval("prjName")%></option>
                    </ItemTemplate>
                </asp:Repeater>
             </datalist>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
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
                            客户
                        </th>
                        <th>
                            核算金额（万)
                        </th>
                        <th>
                            项目经理
                        </th>
                        <th>
                            立项日期
                        </th>
                        <th>
                            计划完成
                        </th>
                        <th>
                            完成日期
                        </th>
                        <th>
                            逾期(天)
                        </th>
                        <th>
                            备注
                        </th>
                        
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data1" EnableViewState="false">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td class="operate">
                                    <span class="projectGuidID" style="display: none"><%#Eval("GuidID")%></span>
                                    <span class="projectPrjNum" style="display: none"><%#Eval("PrjNum")%></span>
                                     <span class="projectName" style="display: none"><%#Eval("prjName")%></span>
                                     <a onclick="javascript:EditData(this);" title="点击进入项目明细" href='#'><%#Eval("prjNum") %></a>
                                </td>
                                <td>
                                    <%#Eval("prjName") %>
                                </td>
                                <td>
                                    <%#Eval("clientName")%>
                                </td>
                                <td>
                                    <%#Eval("prjMoney")%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:SeeProjectPerson(this);" title='<%# KORWeb.BUL.Tb_ProjectBU.GetProjectPersonName(Eval("GuidID").ToString(),"") %>'>
                                        <%# KORWeb.BUL.Tb_ProjectBU.GetProjectPersonName(Eval("GuidID").ToString(),"0") %></a>
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
                                <td>
                                    <%#Eval("Remark")%>
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
                "aaSorting": [[1, "desc"]], //默认第几个排序
                "bStateSave": true, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
                // {"orderable": false, "aTargets": [10]}// 制定列不参与排序
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


        //*--编辑或查看项目的明细
        function EditData(obj) {
            var v1 = $(obj).parent().parent().find('.projectPrjNum').html();
            var title = "项目信息";
            var url = "Tb_Project_Detail.aspx?prjNum=" + v1;
            layer_show(title, url, 800, 550);
        }

        //*---查看项目组成员信息
        function SeeProjectPerson(obj) {
            var v1 = $(obj).parent().parent().find('.projectGuidID').html();
            var v2 = $(obj).parent().parent().find('.projectName').html();

            var title = "【" + v2 + "】";
            var url = "Tb_Project_Person.aspx?parentGuid=" + v1;
            layer_show(title, url, 900, 650);
        }


        //*--查看项目日志
        function SeeProjectLog(obj) {
            var v1 = $(obj).parent().parent().find('.projectGuidID').html();
            var v2 = $(obj).parent().parent().find('.projectName').html();

            var title = "【" + v2 + "】";
            var url = "Tb_Project_Log.aspx?parentGuid=" + v1;
            layer_show(title, url, 900, 650);
        }
    </script>

</asp:Content>
