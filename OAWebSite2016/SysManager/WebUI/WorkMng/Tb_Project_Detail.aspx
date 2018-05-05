<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="Tb_Project_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.WorkMng1.Tb_Project_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Project" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="prjNum" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="prjNum,prjName,prjKind,begDate,endDate,contenttext,guidID,Status"
        NoSaveControlList="" TableName="Tb_Project" PrimaryKeys="prjNum" IsAppendData="true" />
    <div id="tab-system" class="HuiTab">
        <asp:ScriptManager ID="script1" runat="server">
        </asp:ScriptManager>
        <div class="tabBar cl">
            <span>基本信息</span> <span>项目组成员</span> <span>项目附件</span> <span>项目日志</span>
        </div>
        <!--1）项目基本信息-->
        <div class="tabCon">
            <div style="display: none">
                <jasp:JTextBox ID="guidID" runat="server"></jasp:JTextBox>
                Status：<jasp:JTextBox ID="Status" runat="server"></jasp:JTextBox>
                <jasp:JTextBox ID="IsCanEdit" runat="server" Text="1"></jasp:JTextBox>
            </div>
            <div class="row cl">
                <label class="form-label col-3">
                    项目编号：</label>
                <div class="formControls col-5">
                    <jasp:JTextBox class="input-text" AllowNullValue="false" ID="prjNum" runat="server"
                        Caption="项目编号" IsUnique="true" UniqueTable="Tb_Project" mydatatype="*2-20" />
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">
                    项目名称：</label>
                <div class="formControls col-5">
                    <jasp:JTextBox class="input-text" AllowNullValue="false" ID="prjName" runat="server"
                        Caption="项目名称" mydatatype="*2-50" />
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">
                    项目类型：</label>
                <div class="formControls col-5">
                    <span class="select-box">
                        <jasp:AppDropDownList ID="prjKind" runat="server" KeyItem="ProjectKind" CssClass="select">
                        </jasp:AppDropDownList>
                    </span>
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">
                    开始日期：</label>
                <div class="formControls col-5">
                    <jasp:JTextBox class="input-text" ID="begDate" runat="server" AllowNullValue="false"
                        Caption="开始日期" onclick="$.calendar();" />
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">
                    预计结束日期：</label>
                <div class="formControls col-5">
                    <jasp:JTextBox class="input-text" ID="endDate" runat="server" AllowNullValue="false"
                        Caption="预计结束日期" onclick="$.calendar();" />
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">
                    备注：</label>
                <div class="formControls col-5">
                    <jasp:JTextBox class="input-text" ID="contenttext" TextMode="MultiLine" runat="server"
                        Caption="备注" Height="160px" />
                </div>
                <div class="col-4">
                </div>
            </div>
            <!--控制修改的权限-->
        </div>
        <!--2）项目组成员-->
        <div class="tabCon">
            <!--数据源定义-->
            <jasp:JDataSource ID="dataPerson" runat="server" JType="Table" SqlID="Tb_Project_Person inner join JUser on Tb_Project_Person.PersonID=JUser.UserID"
                PageSize="-1" OrderBy="Tb_Project_Person.num" IsNoConditionNoData="true" FieldsList="Tb_Project_Person.*,UserName">
                <ParaItems>
                    <jasp:ParameterItem ParaType="Control" ParaName="guidID" DataName="ProjectGuidID" />
                </ParaItems>
            </jasp:JDataSource>
            <!--数据表格-->
            <div id="mt_Person" style="margin-top: 10px;">
                <table id="personTab" class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                        <tr class="text-c">
                            <th>
                                序号
                            </th>
                            <th>
                                姓名
                            </th>
                            <th>
                                岗位
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater3" runat="server" DataSourceID="dataPerson" EnableViewState="false">
                            <ItemTemplate>
                                <tr class="text-c">
                                    <td>
                                        <%#Eval("num") %>
                                    </td>
                                    <td>
                                        <%#Eval("UserName")%>
                                    </td>
                                    <td>
                                        <span class="select-box" style="width: 150px; display: none">
                                            <jasp:AppDropDownList ID="prj1" runat="server" KeyItem="ProjectGw" CssClass="select"
                                                SelectedValue='<%#Eval("PrjRole")%>'>
                                            </jasp:AppDropDownList>
                                        </span>
                                        <%# ((DropDownList)Container.FindControl("prj1")).SelectedItem.Text  %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <script language="javascript" type="text/javascript">
                $(function() {
                    PersonRefresh();
                });

                function PersonRefresh() {
                    $('#personTab').dataTable({
                        "aaSorting": [[0, "asc"]],  //默认第几个排序
                        "bStateSave": false         //状态保存      
                    });

                    $('#personTab tbody').on('click', 'tr', function() {
                        if ($(this).hasClass('selected')) {
                            $(this).removeClass('selected');
                        }
                        else {
                            table.$('tr.selected').removeClass('selected');
                            $(this).addClass('selected');
                        }
                    });
                }
            </script>

        </div>
        <!--3）项目附件-->
        <div class="tabCon">
            <asp:UpdatePanel ID="update1" runat="server">
                <ContentTemplate>
                    <div class="cl pd-5 bg-1 bk-gray mt-20">
                        <span class="l"><span style="display: none">
                            <jasp:JButton ID="butRefresh1" runat="server" Text="test1">
                            </jasp:JButton></span> </span>
                    </div>
                    <!--数据源定义-->
                    <jasp:JDataSource ID="data3" runat="server" JType="Table" SqlID="JAttachment" PageSize="-1"
                        OrderBy="UploadTime desc" IsNoConditionNoData="true">
                        <ParaItems>
                            <jasp:ParameterItem ParaType="Control" ParaName="guidID" DataName="parentGuid" />
                        </ParaItems>
                    </jasp:JDataSource>
                    <!--数据表格-->
                    <div id="mt-202" style="margin-top: 10px;">
                        <table id="attchTab" class="table table-border table-bordered table-hover table-bg table-sort">
                            <thead>
                                <tr class="text-c">
                                    <th>
                                        上传时间
                                    </th>
                                    <th>
                                        上传用户
                                    </th>
                                    <th>
                                        文件名
                                    </th>
                                    <th>
                                        文件说明
                                    </th>
                                    <th>
                                        操作
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="data3" EnableViewState="false">
                                    <ItemTemplate>
                                        <tr class="text-c">
                                            <td>
                                                <%#Eval("uploadtime") %>
                                            </td>
                                            <td>
                                                <%#Eval("UploadPerson")%>
                                            </td>
                                            <td>
                                                <%#Eval("FileName")%>
                                            </td>
                                            <td>
                                                <%#Eval("Describle")%>
                                            </td>
                                            <td class="operate">
                                                <a target="_blank" href='<%#Eval("EncryptFileName") %>'>
                                                    <img src="/images/Frame/edt.gif" width="16" height="16" border="0" alt="" />打开</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <script language="javascript" type="text/javascript">
                $(function() {
                    AttachmentRefresh();
                });

                function AttachmentRefresh() {
                    $('#attchTab').dataTable({
                        "aaSorting": [[0, "desc"]], //默认第几个排序
                        "bStateSave": false, //状态保存
                        "aoColumnDefs": [
                        //                { "bVisible": false, "aTargets": [0] }, //控制列的隐藏显示
		                {"orderable": false, "aTargets": [4]}// 制定列不参与排序
		        ]
                    });

                    $('#attchTab tbody').on('click', 'tr', function() {
                        if ($(this).hasClass('selected')) {
                            $(this).removeClass('selected');
                        }
                        else {
                            table.$('tr.selected').removeClass('selected');
                            $(this).addClass('selected');
                        }
                    });
                }
            </script>

        </div>
        <!--3）项目日志-->
        <div class="tabCon">
            <!--数据源定义-->
            <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="Tb_Project_Log"
                PageSize="-1" OrderBy="AddTime" IsNoConditionNoData="true">
                <ParaItems>
                    <jasp:ParameterItem ParaType="Control" ParaName="prjNum" DataName="parentGuid" />
                </ParaItems>
            </jasp:JDataSource>
            <!--数据表格-->
            <div id="mt-201" style="margin-top: 10px; display: none">
                <table id="logtab" class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                        <tr class="text-c">
                            <th>
                                时间
                            </th>
                            <th>
                                用户
                            </th>
                            <th>
                                事项
                            </th>
                            <th>
                                备注
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="data2" EnableViewState="false">
                            <ItemTemplate>
                                <tr class="text-c">
                                    <td>
                                        <%#Eval("AddTime") %>
                                    </td>
                                    <td>
                                        <%#Eval("AddUserNet") %>
                                    </td>
                                    <td>
                                        <%#Eval("Stitle") %>
                                    </td>
                                    <td>
                                        <%#Eval("Content") %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <script language="javascript" type="text/javascript">
                $(function() {
                    $('#logtab').dataTable({
                        "aaSorting": [[0, "asc"]], //默认第几个排序
                        "bStateSave": false //状态保存  
                    });
                    $('#logtab tbody').on('click', 'tr', function() {
                        if ($(this).hasClass('selected')) {
                            $(this).removeClass('selected');
                        }
                        else {
                            table.$('tr.selected').removeClass('selected');
                            $(this).addClass('selected');
                        }
                    });

                    //Load Table
                    $("#mt-201").css("display", "");
                });
            </script>

        </div>
    </div>

    <script type="text/javascript">
        $(function() {
            $("#aspnetForm").Validform({
                tiptype: 2,
                callback: function(form) {

                }
            });
        });        
    </script>

    <script type="text/javascript">
        $(function() {

            $.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
        });
    </script>

</asp:Content>
