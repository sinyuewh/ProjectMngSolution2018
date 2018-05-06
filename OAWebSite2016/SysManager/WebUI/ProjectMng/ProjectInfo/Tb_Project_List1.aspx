<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiSecond.Master"
    AutoEventWireup="true" %>

<script runat="server">
    KORWeb.BUL.Tb_Project_PersonBU person1 = new Tb_Project_PersonBU();
    protected override void OnInit(EventArgs e)
    {
        this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);      
        base.OnInit(e);
    }

    protected override void OnLoad(EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.Time0.Text = DateTime.Today.AddYears(-1).ToString("yyyy-MM-dd");
            this.Time1.Text = DateTime.Today.ToString("yyyy-MM-dd");

            //------------------------------------------------------------------------------
            //系统管理员，公司领导 可查看所有的项目列表资料
            if (WebFrame.Comm.JSecurity.HasRoles("xtgl,gsld"))
            {
                this.DepartNum.Text = "";
                this.PersonID.Text = "";
            }
            else if (WebFrame.Comm.JSecurity.HasRoles("bmld"))  //部门领导可查询本部门的所有项目
            {
               this.DepartNum.Text = WebFrame.Util.JCookie.GetCookieValue("departnum");
               this.PersonID.Text = "";
            }
            else
            {
                //查询项目关联的人员或项目的发起人
                this.DepartNum.Text = "";
                this.PersonID.Text = String.Format("Author='{0}' or exists (select 1 from Tb_Project_Person where parentGuid=Tb_ProjectView.GuidID and UserID='{0}')",WebFrame.FrameLib.UserID);
            }
            //------------------------------------------------------------------------------
            
        }
        base.OnLoad(e);
    }
    
    void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        System.Data.DataRowView dv = e.Item.DataItem as System.Data.DataRowView;
        System.Data.DataRow dr = dv.Row;

        String Author = dr["Author"].ToString();
        String Status = dr["Status"].ToString();
        String UserID = WebFrame.FrameLib.UserID;
        String projectID = dr["Guidid"].ToString();

        //判断对项目是否有管理权限
        bool has = false;
        int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(projectID, UserID);
        if (t1 >= 3) has = true;

        //设置项目的操作
        Control con2 = e.Item.FindControl("span1") as Control;
        if (has)
        {
            System.Collections.Generic.Dictionary<String, String> dic1 = new System.Collections.Generic.Dictionary<string, string>();
            DropDownList con1 = e.Item.FindControl("doAction") as DropDownList;
            if (Status == "0")
            {
                dic1["1"] = "项目立项";
                //dic1["3"] = "项目终止";
                dic1["6"] = "项目删除";
            }
            else if(Status =="1")
            {
                dic1["2"] = "项目完成";
                dic1["4"] = "项目延期";
                dic1["3"] = "项目终止";
            }
            else if (Status == "2" || Status =="3")
            {
                dic1["5"] = "项目返工";
            }

            if (dic1.Count > 0)
            {
                foreach (System.Collections.Generic.KeyValuePair<String, String> m in dic1)
                {
                    ListItem item1 = new ListItem(m.Value, m.Key);
                    con1.Items.Add(item1);
                }
                con1.Items.Insert(0, new ListItem("选择操作", ""));
            }
            else
            {
                con2.Visible = false;
            }
        }
        else
        {
           con2.Visible = false;
        }
        
        //设置项目组的成员信息
        String info1=person1.GetPersonInfo(projectID);
        (e.Item.FindControl("personinfo") as Label).Text = info1; 
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
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目列表 <span class="c-gray en">&gt;</span> 未确定项目 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <!--查询区设置-->
        <div class="text-c">
            <span style="display:none">
            <jasp:JTextBox ID="DepartNum" runat="server" />
            <jasp:JTextBox ID="PersonID" runat="server" /></span>
            
            立项日期：<jasp:JTextBox ID="Time0" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            ～<jasp:JTextBox ID="Time1" runat="server" class="input-text" Style="width: 120px"
                placeholder="" onclick="$.calendar();" />
            &nbsp;&nbsp;
            项目状态：<span class="select-box" style="width: 150px">
                <jasp:JDropDownList ID="Status" class="select" runat="server" >
                    <asp:ListItem Text="--全部--" Value=""></asp:ListItem>
                    <asp:ListItem Text="实施中" Value="1"></asp:ListItem>
                    <asp:ListItem Text="已完成" Value="2"></asp:ListItem>
                    <asp:ListItem Text="已终止" Value="3"></asp:ListItem>
                    <asp:ListItem Text="立项中" Value="0"></asp:ListItem>
                   
                </jasp:JDropDownList>
            </span>&nbsp;&nbsp; 项目名称：<jasp:JTextBox ID="prjName" runat="server" class="input-text" Style="width: 200px"
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
                <jasp:SecurityPanel ID="sec1" runat="server" RoleID="xmgl">
                    <a href="javascript:;" onclick="javascript:return NewData();" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加新项目</a>
                </jasp:SecurityPanel>
            </span><span class="r">共有数据：<strong><%=this.data1.TotalRow %></strong> 条</span>
        </div>
        <!--数据源定义-->
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="Tb_ProjectView"
            PageSize="-1" OrderBy="begDate desc">
            <ParaItems>
                <jasp:ParameterItem ParaType="Control" ParaName="prjName" SearchOperator="Contains" />
                <jasp:ParameterItem ParaType="Control" ParaName="Status" DataType="NumericType" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time0" DataName="begDate>=cdate('{0}')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="Time1" DataName="begDate<=cdate('{0} 23:59:59')"
                    SearchOperator="UserDefine" />
                <jasp:ParameterItem ParaType="Control" ParaName="DepartNum" SearchOperator="RightContains" />
                <jasp:ParameterItem ParaType="Control" ParaName="PersonID"  DataName="{0}" SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        
       <%-- <%=this.data1.CommandText  %>--%>
        <!--数据表格-->
        <div class="mt-20" style="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                         <th>
                            立项部门
                        </th>
                        <th>
                            项目编号
                        </th>
                        <th>
                            项目名称
                        </th>
                        <th>
                            客户名称
                        </th>
                        <th>
                            计划完成
                        </th>
                        <th>
                            实际完成
                        </th>
                        <th>
                            项目状态
                        </th>
                        
                         <th>
                            项目发起人
                        </th>                     
                        
                        <th>
                            项目团队
                        </th>  
                        
                        <th>
                            项目日志
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
                                    <%#Eval("departName")%>[<%#Eval("departNum")%>]
                                </td>
                                
                                <td class="operate">
                                    <span class="projectGuidID" style="display: none"><%#Eval("GuidID")%></span>
                                    <span class="projectPrjNum" style="display: none"><%#Eval("PrjNum")%></span>
                                    <span class="projectName" style="display: none"> <%#Eval("prjName")%></span>
                                     <a onclick="javascript:EditData(this);" title="点击进入项目明细" href='#'><%#Eval("prjNum") %></a>
                                </td>
                                <td>
                                    <%#Eval("prjName") %>
                                </td>
                                <td>
                                    <%#Eval("clientName")%>
                                </td>
                                <td>
                                    <%#Eval("begDate","{0:yyy-MM-dd}") %>
                                    <b>至</b>
                                    <%#Eval("endDate","{0:yyyy-MM-dd}") %>
                                </td>
                                
                                 <td>
                                    <%# Eval("Status").ToString()=="2" ? Eval("FinishDate", "{0:yyyy-MM-dd}"): "" %>
                                </td>
                                
                                
                                <td class="operate">
                                   <script>document.write(Arr1[<%#Eval("Status")%>])</script>
                                </td>
                                
                                <td>
                                    <%#Eval("AuthorName")%>
                                </td>     
                                
                                <td class="operate">
                                     <a title="点击查看项目团队" onclick="javascript:SeeProjectPerson(this);">
                                        <asp:Label ID="personinfo" runat="server"></asp:Label>
                                     </a>
                                </td>  
                                
                                <td>
                                    1
                                </td>                           
                                                                
                                <td class="operate">
                                    <span class="select-box" id ="span1" runat="server">
                                        <jasp:JDropDownList ID="doAction" class="select" runat="server" onchange="javascript:doProjectAction(this);">
                                            
                                        </jasp:JDropDownList>
                                    </span>
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
                //"lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
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
            var title = "添加新项目";
            var url = "Tb_Project_Detail_ADD.aspx";
            layer_show(title, url, 650, 550);
        }

        //2*--编辑或查看项目的明细
        function EditData(obj) {
            var v1 = $(obj).parent().parent().find('.projectPrjNum').html();
            var title = "项目信息";
            var url = "Tb_Project_Detail.aspx?prjNum=" + v1;
            layer_show(title, url, 650, 550);
        }

        //3---查看项目组成员信息
        function SeeProjectPerson(obj) {
            var v1 = $(obj).parent().parent().find('.projectGuidID').html();
            var v2 = $(obj).parent().parent().find('.projectName').html();

            var title = "【" + v2 + "】";
            var url = "Tb_Project_Person.aspx?parentGuid=" + v1;
            layer_show(title, url, 900, 650);
        }
       

        //5--项目的相关操作
        function doProjectAction(obj) {
            var v1 = $(obj).parent().parent().parent().find('.projectGuidID').html();
            var v2 = $(obj).parent().parent().parent().find('.projectName').html();
            var v3 = $(obj).val();
            if (v3 == "1") {
                //项目立项
                ProjectSureData(v1, v2);
            }
            else if (v3 == "2") {
                //项目完成
                ProjectCompleteData(v1,v2)
            }
            else if (v3 == "3") {
                //项目终止
                ProjectCancelData(v1, v2);
            }
            else if (v3 == "4") {
                //项目延期
                DelayProjectData(v1, v2);
            }
            else if (v3 == "5") {
                //项目返工
                ReturnWorkData(v1, v2);
            }
            else if (v3 == "6") {
            //项目删除
                DelData(v1, v2);
            }
        }


        //5.1---项目立项
        function ProjectSureData(dataid, prjName) {
            layer.confirm("提示：确定要对项目【" + prjName + "】立项吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "../Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'SURE_Tb_Project'
                    },
                    success: function(data) {
                        if ("ok" == data) {
                            layer.alert("项目立项操作成功！", function() {
                                $('#butSearch').click();  //重新加载页面
                            });
                        } else {
                            layer.alert("项目立项操作失败！");
                        }
                    }
                });
            });
        }

        //5.2*--删除项目
        function DelData(dataid, prjName) {
            layer.confirm("提示：确定要删除项目【" + prjName + "】的数据吗？", function() {
                $.ajax({
                    type: 'POST',
                    url: "../Handler/DoAction.aspx",
                    data: {
                        KeyID: dataid,
                        Action: 'DEL_Tb_Project'
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


        //5.3---项目完成
        function ProjectCompleteData(dataid, prjName) {
            var v1 = '<%=DateTime.Now.ToString("yyyy-MM-dd") %>';
            layer.confirm("提示：确定要将项目【" + prjName + "】标为完成吗？", function() {
                layer.prompt({ title: '请输入项目完成的日期', formType: 0, value: v1 }, function(text) {
                    $.ajax({
                        type: 'POST',
                        url: "../Handler/DoAction.aspx",
                        data: {
                            KeyID: dataid,
                            Action: 'COMPLETE_Tb_Project',
                            Remark: text
                        },
                        success: function(data) {
                            if ("ok" == data) {
                                layer.alert("【将项目标为完成】操作成功！", function() {
                                    $('#butSearch').click();  //重新加载页面
                                });
                            } else {
                                layer.alert("【将项目标为完成】操作失败！");
                            }
                        }
                    });
                });
            });
        }

        //5.4---项目终止
        function ProjectCancelData(dataid, prjName) {
            layer.confirm("提示：确定要将项目【" + prjName + "】标为取消吗？", function() {
                layer.prompt({ title: '请输入项目取消的说明', formType: 2 }, function(text) {
                    $.ajax({
                        type: 'POST',
                        url: "../Handler/DoAction.aspx",
                        data: {
                            KeyID: dataid,
                            Action: 'CANCEL_Tb_Project',
                            Remark: text
                        },
                        success: function(data) {
                            if ("ok" == data) {
                                layer.alert("【将项目标为取消】操作成功！", function() {
                                    $('#butSearch').click();  //重新加载页面
                                });
                            } else {
                                layer.alert("【将项目标为取消】操作失败！");
                            }
                        }
                    });
                });
            });
        }


        //5.5--登记项目延期信息
        function DelayProjectData(dataid, prjName) {
            var title = "登记项目【" + prjName + "】延期信息";
            var url = "Tb_Project_delay.aspx?parentGuid=" + dataid;
            layer_show(title, url, 550, 400);
        }


        //5.6---将项目标记为再次施工
        function ReturnWorkData(dataid, prjName) {
            layer.confirm("提示：确定要将项目【" + prjName + "】重新返工吗？", function() {
                layer.prompt({ title: '请输入项目返工的说明', formType: 2 }, function(text) {
                    $.ajax({
                        type: 'POST',
                        url: "../Handler/DoAction.aspx",
                        data: {
                            KeyID: dataid,
                            Action: 'ReturnWork_Tb_Project',
                            Remark: text
                        },
                        success: function(data) {
                            if ("ok" == data) {
                                layer.alert("【将项目返工】操作成功！", function() {
                                    $('#butSearch').click();  //重新加载页面
                                });
                            } else {
                                layer.alert("【将项目返工】操作失败！");
                            }
                        }
                    });
                });
            });
        }
    </script>

</asp:Content>
