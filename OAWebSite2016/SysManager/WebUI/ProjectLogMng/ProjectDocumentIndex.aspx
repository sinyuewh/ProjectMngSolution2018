<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectDocumentIndex.aspx.cs"
    MasterPageFile="~/SysManager/include/H-uiSecond.Master" Inherits="OAWebSite2016.SysManager.WebUI.ProjectLogMng.ProjectDocumentIndex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var arrKind = new Array("", "实施中", "已完成", "已取消");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目管理 <span class="c-gray en">&gt;</span> 项目文档 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 180px"
                placeholder="" />
            &nbsp;&nbsp; 文件名：<jasp:JTextBox ID="FileName" runat="server" class="input-text" Style="width: 180px"
                placeholder="" />
            &nbsp;&nbsp; 文件说明：<jasp:JTextBox ID="Describle" runat="server" class="input-text"
                Style="width: 180px" placeholder="" />
            &nbsp;&nbsp; 上传日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            <button type="submit" class="btn btn-success radius" id="butSearchProject" name=""
                runat="server">
                <i class="Hui-iconfont">&#xe665;</i> 查询</button>
            <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_ProjectDocView"
                PageSize="-1" FieldsList="*" OrderBy="UploadTime desc">
                <ParaItems>
                    <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                    <jasp:ParameterItem ParaType="Control" ParaName="FileName" SearchOperator="Contains" />
                    <jasp:ParameterItem ParaType="Control" ParaName="Describle" SearchOperator="Contains" />
                    <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="UploadTime>=cdate('{0}')"
                        SearchOperator="UserDefine" />
                    <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="UploadTime<=cdate('{0} 23:59:59')"
                        SearchOperator="UserDefine" />
                </ParaItems>
            </jasp:JDataSource>
        </div>
        <!--操作区设置-->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <% if (KORWeb.BUL.Tb_ProjectBU.IsProjectManager())
                   { %>
                <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i> 上传文档</a>
                <% } %>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据表格-->
        <div class="mt-20">
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
                            文档类别
                        </th>
                        <th>
                            文件名
                        </th>
                        <th>
                            上传时间
                        </th>
                        <th>
                            上传人
                        </th>
                        <th>
                            文件说明
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
                                    <%# WebFrame.Comm.JItemBU.GetItemTextByKey("ProjectDocKind", Eval("ProjectDocKind").ToString())%>
                                </td>
                                <td>
                                    <%#Eval("FileName")%>
                                </td>
                                <td>
                                    <%#Eval("UploadTime")%>
                                </td>
                                <td>
                                    <%#Eval("UploadPerson")%>
                                </td>
                                <td>
                                    <%#Eval("Describle")%>
                                </td>
                                <td>
                                    <%#Eval("Remark")%>
                                </td>
                                <td class="operate">
                                    <span id="span1" runat="server"><a onclick="javascript:return deleteFile('<%#Eval("guidID") %>');"
                                        href='#'>
                                        <img alt="" src="/images/Frame/del.gif" width="16" height="16" border="0" />删除</a><br />
                                    </span><a onclick="javascript:return openFile('<%#Eval("EncryptFileName") %>','<%#Eval("FileName") %>');"
                                        href='#'>
                                        <img alt="" src="/images/lx.png" width="16" height="16" border="0" />下载</a>
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
                //"aaSorting": [[0, "asc"]], //默认第几个排序
                "bStateSave": true, //状态保存
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


        function NewData() {
            var title = "上传项目文档";
            var url = "UploadProjuectDoc.aspx";
            layer_show(title, url, 600, 450);
        }


        //打开附件
        function openFile(f1, f2) {
            var url1 = "/Comm/OpenAttachment.aspx?filepath=" + f1 + "&fileName=" + f2;
            window.open(url1);
        }

        //删除附件数据
        function deleteFile(dataid) {
            layer.confirm("提示：确定要删除项目文档吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_Tb_Project_Log_ATTACHMENT'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("删除附件操作成功！", function() {
                                $('#<%=butSearchProject.ClientID %>').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("删除附件操作失败！");
                        }
                    }
                });
            });
        }
    </script>

</asp:Content>
