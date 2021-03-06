﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tb_KaoHeOtherList.aspx.cs" 
 MasterPageFile="~/SysManager/include/H-uiSecond.Master" 
Inherits="OAWebSite2016.SysManager.WebUI.CheckMng.Tb_KaoHeOtherList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <%-- 
           相关权限点说说明：
           Tb_KaoHeOther_READALL ：浏览所有数据
           Tb_KaoHeOther_DEL :  删除
           
           普通用户只能看自己相关的数据，
           Tb_KaoHeOther_READALL 可以查看所有的数据
        --%>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 考核管理 <span class="c-gray en">&gt;</span> 其他考核流水 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div style="display:none">
            <jasp:JTextBox ID="UserID" runat="server"  />
        </div>
        <div class="text-c">
            用户姓名：<jasp:JTextBox ID="UserName" runat="server" class="input-text" Style="width: 150px"
                placeholder="" />
            &nbsp;&nbsp;提交时间：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
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
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_KaoHeOtherView"
            PageSize="-1" FieldsList="*,KHScore*KHCount as khcj" OrderBy="num desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="UserID" SearchOperator="Collection"  />
                
                <jasp:ParameterItem ParaType="Control" ParaName="UserName" SearchOperator="Contains" />
                
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="createtime>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="createtime<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <!--数据表格-->
        <div class="mt-20" style="display: none">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th>
                            登记时间
                        </th>
                        <th>
                            用户姓名
                        </th>
                        <th>
                            考核编码
                        </th>
                        <th>
                            考核规范
                        </th>
                        
                        <th>
                            加减分
                        </th>
                        <th>
                            考核备注
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
                                    <%#Eval("createtime")%>
                                </td>
                                <td>
                                    <%#Eval("username") %>
                                </td>
                                <td>
                                    <%#Eval("KHID") %>
                                </td>
                                <td class="text-l">
                                    <%#Eval("KHRemark") %>
                                </td>
                                <td>
                                    <%#Eval("khcj")%>
                                </td>
                               
                                <td class="text-l">
                                    <%#Eval("Remark")%>
                                </td>
                                <td class="operate">                                       
                                    <jasp:SecurityPanel ID="sec1" runat="server" AuthorityID="Tb_KaoHeOther_DEL">
                                         &nbsp;<a onclick="javascript:return DelData('<%#Eval("num") %>');" href='#'><img
                                            alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除</a>
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


        //3*--删除项目
        function DelData(dataid) {
            layer.confirm("提示：确定要删除选中的数据吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_Tb_KaoHeOther'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("删除数据操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("删除数据操作失败！");
                        }
                    }
                });
            });
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage">
    </jasp:SecurityPanel>
</asp:Content>
