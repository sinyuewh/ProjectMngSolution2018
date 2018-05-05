<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/H-ui.admin/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="/H-ui.admin/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="/H-ui.admin/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pd-20" style="padding-top: 0px;">
        <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JUser">
            <ParaItems>
                <jasp:ParameterItem ParaType="FrameLibPara" FrameLibParaName="UserID" ParaName="xx"
                    DataName="UserID='{0}'" SearchOperator="UserDefine" />
            </ParaItems>
        </jasp:JDataSource>
        <p class="f-20 text-success">
            欢迎使用网站后台管理系统 <span class="f-14">v2.0</span></p>
        <p>
            登录次数：<%=this.data1.Eval("LoginCount") %>
        </p>
        <p>
            上次登录IP：<%=this.data1.Eval("LastLoginIP")%>
            上次登录时间：<%=this.data1.Eval("LastLogin")%>
        </p>
        <%--<table class="table table-border table-bordered table-bg">
            <thead>
                <tr>
                    <th colspan="7" scope="col">
                        信息统计
                    </th>
                </tr>
                <tr class="text-c">
                    <th>
                        统计
                    </th>
                    <th>
                        资讯库
                    </th>
                    <th>
                        图片库
                    </th>
                    <th>
                        产品库
                    </th>
                    <th>
                        用户
                    </th>
                    <th>
                        管理员
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr class="text-c">
                    <td>
                        总数
                    </td>
                    <td>
                        92
                    </td>
                    <td>
                        9
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        8
                    </td>
                    <td>
                        20
                    </td>
                </tr>
                <tr class="text-c">
                    <td>
                        今日
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                </tr>
                <tr class="text-c">
                    <td>
                        昨日
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                </tr>
                <tr class="text-c">
                    <td>
                        本周
                    </td>
                    <td>
                        2
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                </tr>
                <tr class="text-c">
                    <td>
                        本月
                    </td>
                    <td>
                        2
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                    <td>
                        0
                    </td>
                </tr>
            </tbody>
        </table>--%>
        <table class="table table-border table-bordered table-bg mt-20">
            <thead>
                <tr>
                    <th colspan="2" scope="col">
                        服务器信息
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th width="200">
                        服务器计算机名
                    </th>
                    <td>
                        <span id="lbServerName">
                            <%=Page.Server.MachineName %></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器IP地址
                    </td>
                    <td>
                        <%=Request.ServerVariables["Local_Addr"].ToString()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器域名
                    </td>
                    <td>
                        <%=Request.ServerVariables["SERVER_NAME"].ToString()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器端口
                    </td>
                    <td>
                        <%=Request.ServerVariables["Server_Port"].ToString()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器IIS版本
                    </td>
                    <td>
                        <%=Request.ServerVariables["SERVER_SOFTWARE"]%>
                    </td>
                </tr>
                <tr>
                    <td>
                        网站所在文件夹
                    </td>
                    <td>
                        <%=Server.MapPath("~/") %>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器操作系统
                    </td>
                    <td>
                        <%=Environment.OSVersion.ToString() %>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器脚本超时时间
                    </td>
                    <td>
                        <%=(Server.ScriptTimeout / 1000).ToString()%>秒
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器的语言种类
                    </td>
                    <td>
                        <%=System.Globalization.CultureInfo.InstalledUICulture.EnglishName%>
                    </td>
                </tr>
                <tr>
                    <td>
                        .NET Framework 版本
                    </td>
                    <td>
                        <%=string.Concat(new object[] { Environment.Version.Major, ".", Environment.Version.Minor, Environment.Version.Build, ".", Environment.Version.Revision }) %>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器当前时间
                    </td>
                    <td>
                        <%=DateTime.Now.ToString() %>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器IE版本
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        服务器上次启动到现在已运行
                    </td>
                    <td>
                        <%=((Environment.TickCount / 0x3e8) / 60).ToString()%>分钟
                    </td>
                </tr>
                <tr>
                    <td>
                        CPU 总数
                    </td>
                    <td>
                        <%=Environment.GetEnvironmentVariable("NUMBER_OF_PROCESSORS").ToString()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        CPU 类型
                    </td>
                    <td>
                        <%=Environment.GetEnvironmentVariable("PROCESSOR_IDENTIFIER").ToString()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        虚拟内存
                    </td>
                    <td>
                        <%=(Environment.WorkingSet / 1024).ToString() + "M"%>
                    </td>
                </tr>
                <tr>
                    <td>
                        当前程序占用内存
                    </td>
                    <td>
                        <%=((Double)GC.GetTotalMemory(false) / 1048576).ToString("N2") + "M"%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Asp.net所占内存
                    </td>
                    <td>
                        <%=((Double)System.Diagnostics.Process.GetCurrentProcess().WorkingSet64 / 1048576).ToString("N2") + "M"%>
                    </td>
                </tr>
                <tr>
                    <td>
                        当前Session数量
                    </td>
                    <td>
                        <%=Session.Contents.Count.ToString()%>
                    </td>
                </tr>
                <tr>
                    <td>
                        当前SessionID
                    </td>
                    <td>
                        <%=Session.Contents.SessionID %>
                    </td>
                </tr>
                <tr>
                    <td>
                        当前系统用户名
                    </td>
                    <td>
                        <%=Environment.UserName %>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
