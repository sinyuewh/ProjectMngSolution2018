<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Designer/include/Third.Master"
    Inherits="WebFrame.Designer.JItem_DetailBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $(".Data2 :input[type='text']").css({ 'width': '250px' });
            $(".Data2 textarea").css({ 'width': '250px' });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JItem" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="Itemname" />
        </ParaItems>
    </jasp:JDataSource>
    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,Itemname,Kind,Remark,MinValue,MaxValue,InterValue,Author"
        TableName="JItem" PrimaryKeys="Itemname" IsAppendData="true" />
    
   
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr>
            <td class="Caption2">
                序号：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Num" runat="server" Caption="序号" Width="250px" AllowNullValue="false"
                    DataType="Integer"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                条目名称：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Itemname" runat="server" Caption="条目名称" Width="250px" AllowNullValue="false"
                    IsUnique="true" UniqueTable="JItem"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                条目类型：
            </td>
            <td class="Data2">
                <jasp:AppRadioButtonList ID="Kind" Caption="条目类型" AllowNullValue="false" runat="server"
                    RepeatColumns="3" RepeatLayout="Flow" align="left">
                    <asp:ListItem Text="用户" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="系统" Value="1"></asp:ListItem>
                </jasp:AppRadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                最小值：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="MinValue" runat="server" Caption="最小值" Width="250px" DataType="Integer"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                最大值：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="MaxValue" runat="server" Caption="最大值" Width="250px" DataType="Integer"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                值间隔：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="InterValue" runat="server" Caption="值间隔" Width="250px" DataType="Integer"></jasp:JTextBox>
            </td>
        </tr>
        
        <tr>
            <td class="Caption2">
                作者：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Author" runat="server" Width="250px"></jasp:JTextBox>
            </td>
        </tr>
        
        <tr>
            <td class="Caption2">
                备注：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Remark" runat="server" Caption="备注" Width="250px" TextMode="MultiLine"
                    Height="60"></jasp:JTextBox>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnSubmit" runat="server" Text="提 交" />
                &nbsp;
                <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:art.dialog.close();" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
