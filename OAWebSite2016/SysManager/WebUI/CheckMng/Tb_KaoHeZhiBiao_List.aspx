<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_KaoHeZhiBiao_List.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" 
    Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_KaoHeZhiBiao_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "普通项目", "日常管理项目", "日常学习项目");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <%-- 
           相关权限点说说明：
           Tb_KaoHeZhiBiao_ADD：  添加考核标准
           Tb_KaoHeZhiBiao_READ ：浏览标准
           Tb_KaoHeZhiBiao_EDIT : 修改
           Tb_KaoHeZhiBiao_DEL :  删除
        --%>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 其他考核标准 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            考核编码：<jasp:JTextBox ID="KHID" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp;考核规范：<jasp:JTextBox ID="KhRemark" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp; 状态： <span class="select-box" style="width: 120px">
                <jasp:AppDropDownList ID="Status" runat="server" CssClass="select">
                    <asp:ListItem Text="正常" Value="1"></asp:ListItem>
                    <asp:ListItem Text="停用" Value="0"></asp:ListItem>
                    <asp:ListItem Text="--不限--" Value=""></asp:ListItem>
                </jasp:AppDropDownList>
            </span>&nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearch" name="">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="Tb_KaoHeZhiBiao_ADD">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 新增考核标准</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KaoHeZhiBiao"
            PageSize="-1" FieldsList="*" OrderBy="num">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="KHID" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="KhRemark" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Status" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            序号
                        </th>
                        <th>
                            考核编码
                        </th>
                        <th>
                            考核规范
                        </th>
                        <th>
                            分值
                        </th>
                        <th>
                            发布时间
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
                                    <%#Eval("num")%>
                                </td>
                                <td>
                                    <%#Eval("KHID") %>
                                </td>
                                <td class="text-l">
                                    <%#Eval("KHRemark") %>
                                </td>
                                <td>
                                    <%#Eval("KHScore") %>
                                </td>
                                <td>
                                    <%#Eval("CreateTime","{0:yyyy-MM-dd}") %>
                                </td>
                                <td>
                                    <%#Eval("Remark")%>
                                </td>
                                <td class="operate">
                                    <a onclick="javascript:return ReadData('<%#Eval("KHID") %>');" href='#'>
                                        <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />明细</a>
                                        
                                    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="Tb_KaoHeOther_ADD">
                                        &nbsp;&nbsp;
                                        <a onclick="javascript:return NewKaoHeOtherData('<%#Eval("KHID") %>');" href='#'>
                                            <img src="/images/Add.jpg" width="16" height="16" border="0" alt="" />新增考核流水
                                        </a>
                                    </jasp:SecurityPanel>
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

        //1*--浏览或修改数据
        function ReadData(dataid) {
            var title = "【其他考核指标】信息";
            var url = "Tb_KaoHeZhiBiao_Detail.aspx?KHID=" + dataid;
            layer_show(title, url, 650, 550);
        }

        //2*--New Data
        function NewData() {
            var title = "新增【其他考核指标】信息";
            var url = "Tb_KaoHeZhiBiao_ADD.aspx";
            layer_show(title, url, 650, 550);
        }

        //New 考核流水
        function NewKaoHeOtherData(dataid) {
            var title = "新增【其他考核流水】";
            var url = "Tb_KaoHeOther_ADD.aspx?KHID=" + dataid;
            layer_show(title, url, 650, 400);
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityID="Tb_KaoHeZhiBiao_READ" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
