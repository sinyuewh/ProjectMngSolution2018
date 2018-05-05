<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Third.Master"
    AutoEventWireup="true" 
     ValidateRequest="false"
     Inherits="WebFrame.Designer.JStrInfo_DetailBU" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/kindeditor-4.1.2/kindeditor-min.js" type="text/javascript"></script>
    <script src="/kindeditor-4.1.2/lang/zh_CN.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $(".Data2 :input[type='text']").css({ 'width': '450px' });
            $(".Data2 textarea").css({ 'width': '450px' });
        });

        KindEditor.ready(function (K) {
            K.create('#<%=StrText.ClientID %>',
            {
                themeType: 'simple',
                resizeType: 1,
                allowPreviewEmoticons: false,
                cssPath: '/kindeditor-4.1.2/plugins/code/prettify.css',
                uploadJson: '/Handler/upload_json.ashx',
                fileManagerJson: '/Handler/file_manager_json.ashx',
                allowImageUpload: true,                                       //是否允许本地上传文件
                afterCreate: function () { this.sync(); },
                afterBlur: function () { this.sync(); },
                items: [
					'source', 'fullscreen', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', '|', 'emoticons', 'image', 'link']
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <!--定义数据源-->
    <jasp:JDataSource ID="data1" runat="server" JType="Table" SqlID="JStrInfo" IsNoConditionNoData="true">
        <ParaItems>
            <jasp:ParameterItem ParaType="RequestQueryString" ParaName="StrID" />
        </ParaItems>
    </jasp:JDataSource>

    <!--定义数据豆-->
    <jasp:JDataBean ID="bean1" runat="server" DataSourceID="data1" ControlList="Num,StrID,StrText,Kind,Remark,Author,StrText1"
        TableName="JStrInfo" PrimaryKeys="StrID" IsAppendData="true" />

     
     <jasp:JTextBox ID="StrText1" runat="server" Visible ="false"></jasp:JTextBox>
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 95%">
        <tr>
            <td class="Caption2">
                序号：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Num" runat="server" AllowNullValue="false" Caption="序号" DataType="Integer"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                字符串资源ID：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="StrID" runat="server" AllowNullValue="false" 
                   Caption="字符串资源ID" IsUnique="true" UniqueTable ="JStrInfo"></jasp:JTextBox>
            </td>
        </tr>
        
        <tr>
            <td class="Caption2">
                类型：
            </td>
            <td class="Data2">
                <jasp:AppRadioButtonList ID="Kind" Caption="类型" AllowNullValue="false" runat="server"
                    RepeatColumns="3" RepeatLayout="Flow" align="left">
                    <asp:ListItem Text="用户" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="系统" Value="1"></asp:ListItem>
                </jasp:AppRadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                字符串资源文本：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="StrText" runat="server" TextMode="MultiLine" Height="250" Width ="450px"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
               作者：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Author" runat="server"></jasp:JTextBox>
            </td>
        </tr>
        <tr>
            <td class="Caption2">
                备注：
            </td>
            <td class="Data2">
                <jasp:JTextBox ID="Remark" runat="server"></jasp:JTextBox>
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
