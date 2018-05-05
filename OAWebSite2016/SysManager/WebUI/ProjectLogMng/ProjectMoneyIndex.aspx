<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectMoneyIndex.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.ProjectLogMng.ProjectMoneyIndex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "实施中", "已完成", "已取消");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目管理 <span class="c-gray en">&gt;</span> 项目支出 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 250px"
                placeholder="" autocomplete="on" list="datalist2" />
            &nbsp;&nbsp;立项日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp; 项目状态： <span class="select-box" style="width: 120px">
                <jasp:JDropDownList ID="Status" runat="server" CssClass="select" AutoPostBack="true">
                    <%-- <asp:ListItem Text="不限制" Value=""></asp:ListItem>--%>
                    <asp:ListItem Text="实施中" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="已完成" Value="2"></asp:ListItem>
                    <asp:ListItem Text="已取消" Value="3"></asp:ListItem>
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearchProject" name=""
                runat="server">
                <i class="Hui-iconfont">&#xe665;</i> 查询项目</button>
            <jasp:JDataSource ID="data0" runat="server" JType="Table" SqlID="Tb_Project" PageSize="-1"
                FieldsList="*" OrderBy="PrjName">
                <ParaItems>
                    <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                    <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="begDate>=cdate('{0}')"
                        SearchOperator="UserDefine" />
                    <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="begDate<=cdate('{0} 23:59:59')"
                        SearchOperator="UserDefine" />
                    <jasp:ParameterItem ParaName="xx" ParaType="String" DataName="Status<>0" SearchOperator="UserDefine" />
                    <jasp:ParameterItem ParaType="Control" ParaName="Status" DataType="NumericType" />
                    <jasp:ParameterItem ParaName="xx" ParaType="FrameLibPara" FrameLibParaName="UserID"
                        DataName="exists(select 1 from Tb_Project_Person where parentGuid=tb_Project.Guidid and UserID='{0}')"
                        SearchOperator="UserDefine" />
                </ParaItems>
            </jasp:JDataSource>
            <datalist id="datalist2">
                <asp:Repeater ID="rep_list2" runat="server" DataSourceID="data0" EnableViewState="false">
                    <ItemTemplate>
                        <option value="<%#Eval("prjName")%>"><%#Eval("prjName")%></option>
                    </ItemTemplate>
                </asp:Repeater>
             </datalist>
        </div>
        <!--数据表格-->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg">
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
                            项目经理
                        </th>
                        <th>
                            立项日期
                        </th>
                        <th>
                            项目状态
                        </th>
                        <th>
                            计划完成
                        </th>
                        <th>
                            完成日期
                        </th>
                        <th>
                            选择项目
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr class="text-c">
                                <td>
                                    <%#Eval("prjNum") %>
                                </td>
                                <td>
                                    <%#Eval("prjName") %>
                                </td>
                                <td>
                                    <%#Eval("clientName")%>
                                </td>
                                <td>
                                    <%# KORWeb.BUL.Tb_ProjectBU.GetProjectPersonName(Eval("GuidID").ToString(),"0") %>
                                </td>
                                <td>
                                    <%#Eval("begDate","{0:yyyy-MM-dd}") %>
                                </td>
                                <td>

                                    <script>document.write(arrKind[<%#Eval("Status")%>])</script>

                                </td>
                                <td>
                                    <%#Eval("endDate","{0:yyyy-MM-dd}") %>
                                </td>
                                <td>
                                    <%#Eval("FinishDate", "{0:yyyy-MM-dd}")%>
                                </td>
                                <td class="operate">
                                    <asp:LinkButton ID="link1" runat="server" CommandArgument='<%#Eval("prjNum") %>'
                                        Text='【选择项目】'></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <div id="selinfo" runat="server" visible="false">
                <div style="display: none">
                    <jasp:JTextBox ID="parentGuid" runat="server" Text="-1"></jasp:JTextBox>
                    <button type="submit" class="btn btn-success radius" id="butSearch2" name="" runat="server">
                    </button>
                </div>
                <jasp:JDataSource ID="logdata1" runat="server" JType="Table" SqlID="Tb_Project_Money"
                    OrderBy="AddTime">
                    <ParaItems>
                        <jasp:ParameterItem ParaType="Control" ParaName="parentGuid" />
                    </ParaItems>
                </jasp:JDataSource>
                <div class="cl pd-5 bg-1 bk-gray mt-20">
                    <span class="l">
                        <%if (this.IsProjectManager)
                          { %>
                        <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                            <i class="Hui-iconfont">&#xe600;</i> 添加项目支出</a>
                        <% } %>
                    </span><span class="r">项目【<asp:Label ID="selproject" runat="server" BackColor="Yellow"></asp:Label>】共有：<strong><%=this.logdata1.TotalRow%></strong>
                        条数据</span>
                </div>
                <table class="table table-border table-bordered table-hover table-bg table-sort"
                    id="tab_1">
                    <thead>
                        <tr class="text-c">
                            <th>
                                序号
                            </th>
                            <th>
                                操作时间
                            </th>
                            <th>
                                操作用户
                            </th>
                            <th>
                                经手人
                            </th>
                            <th>
                                支出金额
                            </th>
                            <th>
                                支出时间
                            </th>
                            <th>
                                支出说明
                            </th>
                            <%if (this.IsProjectManager)
                              { %>
                            <th>
                                操作
                            </th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rep2" runat="server" EnableViewState="false" DataSourceID="logdata1">
                            <ItemTemplate>
                                <tr class="text-c">
                                    <td>
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <td>
                                        <%#Eval("AddTime","{0:MM-dd hh:mm:ss}")%>
                                    </td>
                                    <td>
                                        <%#Eval("AddUserName")%>
                                    </td>
                                    <td>
                                        <%#Eval("UserName") %>
                                    </td>
                                    <td>
                                        <%#Eval("ProjectMoney","{0:C}")%>
                                    </td>
                                    <td>
                                        <%#Eval("MoneyTime", "{0:MM-dd hh:mm:ss}")%>
                                    </td>
                                    <td>
                                        <%#Eval("Remark") %>
                                    </td>
                                    <%if (this.IsProjectManager)
                                      { %>
                                    <td class="operate">
                                        <a onclick="javascript:return DelData('<%#Eval("DataID") %>');"
                                            href='#'>
                                            <img alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除</a>
                                    </td>
                                    <% } %>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function() {
            $('.table-sort').dataTable({
                "aaSorting": [[0, "asc"]], //默认第几个排序
                "bStateSave": true, //状态保存
                "aoColumnDefs": [
                //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
                //     {"orderable": false, "aTargets": [5]}// 制定列不参与排序
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


        function NewData() {
            var title = "添加项目支出";
            var url = 'Tb_Project_Money_ADD.aspx?prjNum=' + $('#<%=this.parentGuid.ClientID %>').val();
            layer_show(title, url, 600, 450);
        }


        //4*--删除项目
        function DelData(dataid) {
            layer.confirm("提示：确定要删除选中的数据吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_Tb_Project_Money'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("删除数据操作成功！", function() {
                            $('#<%=this.butSearchProject.ClientID %>').click();  //重新加载页面
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
