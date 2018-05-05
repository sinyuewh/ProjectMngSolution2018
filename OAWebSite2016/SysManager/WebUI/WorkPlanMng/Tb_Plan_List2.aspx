<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" %>

<script runat="server">
    KORWeb.BUL.Tb_Project_PersonBU person1 = new Tb_Project_PersonBU();
    protected override void OnInit(EventArgs e)
    {
        this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
        base.OnInit(e);
    }

    void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        System.Data.DataRowView dv = e.Item.DataItem as System.Data.DataRowView;
        System.Data.DataRow dr = dv.Row;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript">
        var Arr1 = new Array();
        Arr1[0] = "未立项";
        Arr1[1] = "实施中";
        Arr1[2] = "已完成";
        Arr1[3] = "已终止";
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 计划管理 <span class="c-gray en">&gt;</span> 月度计划 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            项目状态：<span class="select-box" style="width: 150px">
                <jasp:JDropDownList ID="Status" class="select" runat="server" AutoPostBack="true" >
                   
                    <asp:ListItem Text="实施中" Value="1"></asp:ListItem>
                    <asp:ListItem Text="已完成" Value="2"></asp:ListItem>
                    <asp:ListItem Text="已终止" Value="3"></asp:ListItem>
                    <asp:ListItem Text="立项中" Value="0"></asp:ListItem>
                     <asp:ListItem Text="--全部--" Value=""></asp:ListItem>
                   
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp; 项目编号：<jasp:JTextBox ID="prjNum" runat="server" class="input-text"
                Style="width: 150px" placeholder="" autocomplete="on" list="datalist1" />
            &nbsp;&nbsp; 项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 150px"
                placeholder="" autocomplete="on" list="datalist2" />
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
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加月度计划</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_PlanView"
            PageSize="-1" OrderBy="AddTime desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjNum" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Status" DataType="NumericType" />
                 <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="PlanKind=1"   SearchOperator="UserDefine"  />
                 <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="History=false"   SearchOperator="UserDefine"  />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="">
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
                            计划年份
                        </th>
                        <th>
                            计划月份
                        </th>
                        <th>
                            计划版本
                        </th>
                                                
                        <th>
                            登记人
                        </th>
                        <th>
                            登记时间
                        </th>
                        <th>
                            备注
                        </th>
                        <th>
                            相关附件
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
                                <td class="operate">
                                    <span class="projectGuidID" style="display: none"><%#Eval("parentGuid")%></span>
                                    <span class="projectPrjNum" style="display: none"><%#Eval("PrjNum")%></span>
                                    <span class="projectName" style="display: none"> <%#Eval("prjName")%></span>
                                     <a  href='#'><%#Eval("prjNum") %></a>
                                </td>
                                <td>
                                    <%#Eval("prjName") %>
                                </td>
                                <td>
                                    <%#Eval("clientName")%>
                                </td>
                                <td>
                                    <%#Eval("PlanYear")%>
                                    
                                </td>
                                
                                 <td>
                                     <%#Eval("PlanMonth")%>
                                </td>
                                
                                
                                <td class="operate">
                                   <a  href='#' title="查看历史版本"><%#Eval("Version")%></a>
                                </td>
                                
                                <td class="operate">
                                    <%#Eval("AddUserName")%>
                                </td> 
                               
                                <td>
                                    <%#Eval("AddTime", "{0:yyy-MM-dd}")%>
                                </td>
                                
                                <td>
                                    <%#Eval("Remark")%>
                                </td>
                                
                               <td class="operate">
                                    <a href='/Comm/ScanFile.aspx?filepath=<%#Eval("AttachFilePath")%>&filename=<%#Eval("AttachFile")%>'>
                                        <%#Eval("AttachFile")%></a>
                                </td>                                
                                
                                <td class="operate">
                                    <a  target="_blank" title="查看计划的详细情况"  href='Tb_Plan_Detail2.aspx?PlanID=<%#Eval("PlanID")%>'>【查看详细】</a>
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
                //  {"orderable": false, "aTargets": [9]}// 制定列不参与排序
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


        //1*--新增数据
        function NewData() {
            var title = "添加项目月度计划";
            var url = "Tb_Project_Detail_ADD2.aspx";
            layer_show(title, url, 800, 550);
        }
    </script>

</asp:Content>
