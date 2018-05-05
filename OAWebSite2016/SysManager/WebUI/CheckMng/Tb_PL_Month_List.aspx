<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    CodeBehind="Tb_PL_Month_List.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_PL_Month_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <%-- 
           相关权限点说说明：
           Tb_PL_Month_READALL ：浏览所有数据
           Tb_PL_Month_ADD :  创建考核数据
           
           普通用户只能看自己相关的数据，
           Tb_PL_Month_READALL 可以查看所有的数据
        --%>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 月度考核 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div style="display: none">
            <jasp:JTextBox ID="UserID" runat="server" />
        </div>
        <div class="text-c">
            用户姓名：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp;年份：<jasp:JTextBox ID="byear" runat="server" class="input-text" Style="width: 80px"
                placeholder="" />
            &nbsp;&nbsp;月份：<jasp:JTextBox ID="bmonth" runat="server" class="input-text" Style="width: 80px"
                placeholder="" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="Security0" runat="server" AuthorityID="Tb_PL_Month_ADD">
                    <a href="javascript:;" onclick="javascript:return CreateNewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 创建月度考核数据</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_PL_Month" PageSize="-1"
            FieldsList="*" OrderBy="CheckDataID desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="UserID" SearchOperator="Collection"  />
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="byear" DataType="NumericType" />
                <jasp:ParameterItem ParaType="Control" ParaName="bmonth" DataType="NumericType" />
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
                            用户姓名
                        </th>
                        <th>
                            工作考核
                        </th>
                        <th>
                            加减分
                        </th>
                        <th>
                            综合得分
                        </th>
                        <th>
                            考核结果
                        </th>
                        <th>
                            有效工作量
                        </th>
                        <th>
                            全额工作量
                        </th>
                        <th>
                            工作量饱满率
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
                                    <%#Eval("byear")%>年<%#Eval("bmonth")%>月
                                </td>
                                <td>
                                    <%#Eval("username") %>
                                </td>
                                <td>
                                    <%#Eval("CheckScore")%>
                                </td>
                                <td>
                                    <%#Eval("AddScore")%>
                                </td>
                                <td>
                                    <%#Eval("TotalScore")%>
                                </td>
                                <td>
                                    <%#Eval("CheckResult")%>
                                </td>
                                <td>
                                    <%#Eval("FactWork")%>
                                </td>
                                <td>
                                    <%#Eval("TotalWork")%>
                                </td>
                                <td>
                                    <%#Eval("WorkRate")%>
                                </td>
                                <td>
                                    <%#Eval("Remark")%>
                                </td>
                                <td class="operate">
                                
                                    <jasp:SecurityPanel ID="Security0" runat="server" AuthorityID="Tb_PL_Month_EDIT" IsAlwaysReload="true" >
                                        <a title="调整全额工作量和备注" onclick="javascript:return ReadData('<%#Eval("CheckDataID") %>');" href='#'>
                                            <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />调整</a>
                                        &nbsp;&nbsp; <a title="重新计算月度考核成绩" onclick="javascript:return CalData('<%#Eval("CheckDataID") %>');"
                                            href='#'>
                                            <img src="/images/newsicon.gif" width="16" height="16" border="0" alt="" />重新计算</a>
                                    </jasp:SecurityPanel>
                                    
                                    &nbsp;&nbsp;<a  onclick="javascript:return PrintData('<%#Eval("CheckDataID") %>');"
                                        href='#'><img src="/images/Frame/gtk-ok.png" width="16" height="16" border="0" alt="" />打印考核表</a>
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

        //read data
        function ReadData(dataid) {
            var title = "调整月度考核数据";
            var url = "Tb_PL_Month_Detail.aspx?CheckDataID="+dataid ;
            layer_show(title, url, 600, 350);
        }

        //caldata data
        function CalData(dataid) {
            layer.confirm('确认要【重新计算】选中的用户月度考核绩效吗？', function(index) {
            $.ajax({
                type: 'POST',
                url: "Handler/DoAction.aspx",
                data: {
                    KeyID: dataid,
                    Action: 'RECAL_Tb_PL_Month'
                },
                success: function(data) {
                    if ("ok" == data) {
                        layer.alert("【重新计算】操作成功！", function() {
                            $('#butSearch').click();  //重新加载页面
                        });
                    } else {
                    layer.alert("【重新计算】操作失败！");
                    }
                }
            });
            });
        }

        //print data
        function PrintData(dataid) {
            var url = "Tb_PL_Month_Detail_Print.aspx?CheckDataID=" + dataid;
            window.open(url);
        }
        
        //create new data
        function CreateNewData() {
            var myDate = new Date();
            var y1 = myDate.getFullYear(); //获取完整的年份(4位,1970-????)
            var m1 = myDate.getMonth() + 1; //获取当前月份(0-11,0代表1月)
            var ym1 = y1 + "-" + m1 + "," + 22;

            layer.prompt({
                formType: 0,
                value: ym1,
                title: '请输入考核的年月和工作日天数'
            }, function(value, index, elem) {
                var v1 = ym1.split(",");
                
                //alert(v1[0]);
                // alert(v1[1]);

                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: v1[0],
                        WorkDay: v1[1],
                        Action: 'CREATE_Tb_PL_Month'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("【创建月度考核数据】操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("【创建月度考核数据】操作失败！");
                        }
                    }
                });

                layer.close(index);
            });
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
