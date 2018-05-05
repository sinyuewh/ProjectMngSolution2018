<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="TB_Task_Detail.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.ProjectManager.TB_Task_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/kindeditor-4.1.2/kindeditor-min.js" type="text/javascript"></script>

    <script src="/kindeditor-4.1.2/lang/zh_CN.js" type="text/javascript"></script>

    <script src="/JS/lhgcalendar.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="/H-ui.admin/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>

    <script language="javascript" type="text/javascript">

        KindEditor.ready(function(K) {
            K.create('#<%=content.ClientID %>',
            {
                themeType: 'simple',
                resizeType: 1,
                allowPreviewEmoticons: false,
                cssPath: '/kindeditor-4.1.2/plugins/code/prettify.css',
                uploadJson: '/Handler/upload_json.ashx',
                fileManagerJson: '/Handler/file_manager_json.ashx',
                allowImageUpload: true,                                       //是否允许本地上传文件
                afterCreate: function() { this.sync(); },
                afterBlur: function() { this.sync(); },
                items: [
					'source', 'fullscreen', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', '|', 'emoticons', 'image', 'link']
            });
        });

        var arrKind = new Array("项目经理", "测试", "开发", "其他");
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="tab-system" class="HuiTab">
        <asp:ScriptManager ID="script1" runat="server">
        </asp:ScriptManager>
        <div class="tabBar cl">
            <span>基本信息</span><span>派工单BUG</span> <span>派工单日志</span>
        </div>
        <!--1）项目基本信息-->
        <div class="tabCon">
            <!--定义数据源-->
            <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_Task" IsNoConditionNoData="true">
                <ParaItems>
                    <jasp:ParameterItem ParaType="RequestQueryString" ParaName="GuidID" />
                </ParaItems>
            </jasp:JDataSource>
            <!--定义数据豆-->
            <jasp:JDataBean ID="bean1" DataSourceID="data1" runat="server" ControlList="ProjectGuidID,GuidID,TaskTitle,TaskKind,content,contentText,begDate,endDate,ExecuteMan,Remark,Workload,LastWorkload,Status,TestUrl,TestMan"
                TableName="Tb_Task" PrimaryKeys="GuidID" IsAppendData="true" />
            <div style="display: none">
                <jasp:JTextBox ID="contentText" runat="server"></jasp:JTextBox>
                <jasp:JTextBox ID="GuidID" runat="server" TextDefaultValue="Guid"></jasp:JTextBox>
                <jasp:JTextBox ID="Status" runat="server" TextDefaultValue="String0"></jasp:JTextBox>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    工单项目：</label>
                <div class="formControls col-10">
                    <jasp:JDataSource ID="dataProject" runat="server" JType="Table" SqlID="Tb_Project"
                        PageSize="-1" OrderBy="begDate desc" FieldsList="prjName,GuidID">
                        <ParaItems>
                            <jasp:ParameterItem ParaType="String" ParaName="xx" DataName="Status =1 or Status=2"
                                SearchOperator="UserDefine" />
                            <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UserID" ParaName="xx"
                                DataName=" exists (select 1 from Tb_Project_Person where ProjectGuidID=Tb_Project.Guidid and PrjRole='0' and PersonID='{0}') "
                                SearchOperator="UserDefine" />
                        </ParaItems>
                    </jasp:JDataSource>
                    <%--<%=this.data1.CommandText  %>--%>
                    <span class="select-box" style="width: 80%">
                        <jasp:JDropDownList ID="ProjectGuidID" runat="server" DataSourceID="dataProject"
                            DataTextField="prjName" DataValueField="GuidID" CssClass="select" Caption="工单项目">
                        </jasp:JDropDownList>
                    </span>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    工单标题：</label>
                <div class="formControls col-10">
                    <jasp:JTextBox class="input-text" AllowNullValue="false" ID="TaskTitle" runat="server"
                        Caption="工单标题" mydatatype="*4-200" Width="80%" ToolTip="工单的标题字数在4-200以内" />
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    工单类型：</label>
                <div class="formControls col-10">
                    <span class="select-box" style="width: 80%">
                        <jasp:JDropDownList ID="TaskKind" runat="server" CssClass="select" Caption="工单类型">
                            <asp:ListItem Text="开发工单" Value=""></asp:ListItem>
                            <asp:ListItem Text="非开发工单" Value="1"></asp:ListItem>
                        </jasp:JDropDownList>
                    </span>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    工单内容：</label>
                <div class="formControls col-10">
                    <jasp:JTextBox ID="content" runat="server" TextMode="MultiLine" Height="250" Width="80%"
                        Caption="工单内容"></jasp:JTextBox>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    计划时间：</label>
                <div class="formControls col-3">
                    <jasp:JTextBox class="input-text" ID="begDate" runat="server" Caption="计划开始" DataType="DateTime"
                        onclick="$.calendar();" AllowNullValue="false" Width="25%" />&nbsp;至&nbsp;
                    <jasp:JTextBox class="input-text" ID="endDate" runat="server" Caption="计划结束时间" DataType="DateTime"
                        onclick="$.calendar();" AllowNullValue="false" Width="25%" />
                </div>
                <label class="form-label col-2">
                    工作量（小时）：</label>
                <div class="formControls col-3">
                    预估：<jasp:JTextBox ID="Workload" runat="server" Caption="工作量预估" DataType="Numeric"
                        TextDefaultValue="String8" class="input-text" Width="25%"></jasp:JTextBox>
                    实际：<jasp:JTextBox ID="LastWorkload" runat="server" Caption="时间工作量" class="input-text"
                        Width="25%" ReadOnly="true"></jasp:JTextBox>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    接单人：</label>
                <div class="formControls col-3">
                    <jasp:JDataSource ID="dataUserName" runat="server" JType="Table" SqlID="Tb_Project_Person inner join JUser on Tb_Project_Person.PersonID=JUser.UserID"
                        OrderBy="Tb_Project_Person.num" FieldsList="JUser.UserID,JUser.UserName">
                        <ParaItems>
                            <jasp:ParameterItem ParaName="xx" ParaType="String" DataName="status=1" SearchOperator="UserDefine" />
                            <jasp:ParameterItem ParaName="ProjectGuidID" ParaType="RequestQueryString" />
                        </ParaItems>
                    </jasp:JDataSource>
                    <%--<%=this.data1.CommandText  %>--%>
                    <span class="select-box">
                        <jasp:JDropDownList ID="ExecuteMan" runat="server" DataSourceID="dataUserName" DataTextField="UserName"
                            DataValueField="UserID" CssClass="select" Caption="接单人">
                        </jasp:JDropDownList>
                    </span>
                </div>
                <label class="form-label col-2">
                    测试人：</label>
                <div class="formControls col-3">
                    <span class="select-box">
                        <jasp:JDropDownList ID="TestMan" runat="server" DataSourceID="dataUserName" DataTextField="UserName"
                            DataValueField="UserID" CssClass="select" Caption="测试人" Enabled="false">
                        </jasp:JDropDownList>
                    </span>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    测试地址：</label>
                <div class="formControls col-3">
                    <jasp:JTextBox ID="TestUrl" runat="server" Caption="测试地址" ReadOnly="true" class="input-text"
                        Visible="false"></jasp:JTextBox>
                    <a style="color: Blue" href='<%=this.TestUrl.Text %>' target="_blank">
                        <%=this.TestUrl.Text %></a>
                </div>
                <label class="form-label col-2">
                    附件：</label>
                <div class="formControls col-3">
                    <jasp:JFileUpload ID="file1" runat="server" Caption="附件" />
                    <span id="spanFile" runat="server"><span id="br1" runat="server">
                        <br />
                    </span><a href='<%=this.data1.Eval("RelaFile")%>' target="_blank" style="color: Blue">
                        <%=this.data1.Eval("RelaTrueName")%></a> </span>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-2">
                    补充说明：</label>
                <div class="formControls col-10">
                    <jasp:JTextBox class="input-text" ID="Remark" runat="server" Caption="补充说明" Width="80%" />
                </div>
            </div>
            <!--控制修改的权限-->
            <jasp:SecurityPanel ID="sec0" runat="server">
                <div class="row cl">
                    <div class="col-10 col-offset-2">
                        <input class="btn btn-primary radius" runat="server" id="btnSubmit" type="submit"
                            value="&nbsp;&nbsp;提交&nbsp;&nbsp;" />
                        &nbsp;&nbsp;
                        <button onclick="layer_close();" class="btn btn-default radius" type="button">
                            &nbsp;&nbsp;关闭&nbsp;&nbsp;</button>
                    </div>
                </div>
            </jasp:SecurityPanel>
        </div>
        <!--2）派工单BUG-->
        <div class="tabCon">
            <jasp:JDataSource ID="data3" runat="server" JType="Table" SqlID="Tb_Task_Bug" PageSize="-1"
                OrderBy="AddTime" IsNoConditionNoData="true">
                <ParaItems>
                    <jasp:ParameterItem ParaType="RequestQueryString" ParaName="GuidID" DataName="parentGuid" />
                </ParaItems>
            </jasp:JDataSource>
            <!--数据表格-->
            <div id="mt-202" style="margin-top: 10px; display: none">
                <table id="#bugtab" class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                        <tr class="text-c">
                            <th>
                                时间
                            </th>
                            <th>
                                用户
                            </th>
                            <th>
                                A类
                            </th>
                            <th>
                                B类
                            </th>
                            <th>
                                C类
                            </th>
                            <th>
                                备注
                            </th>
                            <th>
                                类型
                            </th>
                            <th>
                                附件
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="data3" EnableViewState="false">
                            <ItemTemplate>
                                <tr class="text-c">
                                    <td>
                                        <%#Eval("AddTime") %>
                                    </td>
                                    <td>
                                        <%#Eval("AddUserNet") %>
                                    </td>
                                    <td>
                                        <%#Eval("BugA") %>
                                    </td>
                                    <td>
                                        <%#Eval("BugB") %>
                                    </td>
                                    <td>
                                        <%#Eval("BugC") %>
                                    </td>
                                    <td>
                                        <%#Eval("Remark") %>
                                    </td>
                                    <td>
                                        <%#Eval("kind") %>
                                    </td>
                                    <td class="operate">
                                        <a href='<%#Eval("RelateFile")%>' target="_blank">
                                            <%#Eval("RelaTrueName")%>
                                        </a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <script language="javascript" type="text/javascript">
                $(function() {
                    $('#bugtab').dataTable({
                        "aaSorting": [[0, "asc"]], //默认第几个排序
                        "bStateSave": false //状态保存  
                    });
                    $('#bugtab tbody').on('click', 'tr', function() {
                        if ($(this).hasClass('selected')) {
                            $(this).removeClass('selected');
                        }
                        else {
                            table.$('tr.selected').removeClass('selected');
                            $(this).addClass('selected');
                        }
                    });

                    //Load Table
                    $("#mt-202").css("display", "");
                });
            </script>

        </div>
        <!--2）派工单日志-->
        <div class="tabCon">
            <!--数据源定义-->
            <jasp:JDataSource ID="data2" runat="server" JType="Table" SqlID="Tb_Task_Log" PageSize="-1"
                OrderBy="AddTime" IsNoConditionNoData="true">
                <ParaItems>
                    <jasp:ParameterItem ParaType="RequestQueryString" ParaName="GuidID" DataName="parentGuid" />
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
                                类型
                            </th>
                            <th>
                                备注
                            </th>
                            <th>
                                附件
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

                                        <script language="javascript">document.write(arrKind[<%#Eval("kind") %>]);</script>

                                    </td>
                                    <td>
                                        <%#Eval("Content") %>
                                    </td>
                                    <td class="operate">
                                        <a href='<%#Eval("RelateFile")%>' target="_blank">
                                            <%#Eval("RelaTrueName")%>
                                        </a>
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

            var index1 = '<%=Request["flag"]%>';
            if (index1.length == 0) {
                index1 = "0";
            }
            $.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", index1);
        });
    </script>

</asp:Content>
