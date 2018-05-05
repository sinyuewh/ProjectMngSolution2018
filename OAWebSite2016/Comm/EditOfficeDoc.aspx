<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditOfficeDoc.aspx.cs"
    Inherits="OAWebSite.Comm.EditOfficeDoc" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="x-ua-compatible" content="IE=EmulateIE7" />
    <style type="text/css">
        body
        {
            margin: 0 0 0 0;
            overflow: hidden;
            height: 100%;
        }
        html, form
        {
            height: 100%;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function myLoad() {
            var url = document.getElementById("wordUrl").value;
            var type1 = document.getElementById("wordExt").value;
            document.getElementById("WebOffice1").OptionFlag = 0x0400;
            flag = document.getElementById("WebOffice1").LoadOriginalFile(url, type1);
            if (flag == 0) {
                alert("启动Office失败，请检查 Microsoft Office 是否正确安装后重试！");
            }
            else {

                //if (document.getElementById("isAdmin").value == "") {
                //HiddenMenuAndBar();
                //document.getElementById("WebOffice1").SetToolBarButton2("Menu Bar", 1, 1);
                //document.getElementById("WebOffice1").SetSecurity(0x01);
                //document.getElementById("WebOffice1").SetSecurity(0x02);
                //document.getElementById("WebOffice1").SetSecurity(0x04);
                //document.getElementById("WebOffice1").SetSecurity(0x08);
                //HiddenMenuAndBar();
                //}
                //document.getElementById("WebOffice1").ShowToolBar = 0;

                document.getElementById("WebOffice1").SetTrackRevisions(1);
                document.getElementById("WebOffice1").SetCurrUserName(document.getElementById("currentUserName").value);
            }
        }

        //屏蔽Word的菜单和按钮
        function HiddenMenuAndBar() {
            //屏蔽标准工具栏的前几个按钮
            document.getElementById("WebOffice1").SetToolBarButton2("Standard", 3, 1);
            document.getElementById("WebOffice1").SetKeyCtrl(595, -1, 0);
        }

        //恢复菜单和Bar
        function RestoreMenuAndBar() {
            //恢复被屏蔽的菜单项和快捷键
            document.getElementById("WebOffice1").SetToolBarButton2("Standard", 1, 3);
            document.getElementById("WebOffice1").SetToolBarButton2("Standard", 2, 3);
            document.getElementById("WebOffice1").SetToolBarButton2("Standard", 3, 3);
            document.getElementById("WebOffice1").SetToolBarButton2("Standard", 6, 3);

            //恢复文件菜单项
            document.getElementById("WebOffice1").SetToolBarButton2("Menu Bar", 1, 4);
            //恢复 保存快捷键(Ctrl+S) 
            document.getElementById("WebOffice1").SetKeyCtrl(595, 0, 0);
            //恢复 打印快捷键(Ctrl+P) 
            document.getElementById("WebOffice1").SetKeyCtrl(592, 0, 0);

            //恢复文件保存
            document.getElementById("WebOffice1").SetSecurity(0x02 + 0x8000);
        }

        //关闭窗口
        function myUnload() {
            RestoreMenuAndBar();
            document.getElementById("WebOffice1").CloseDoc(0);
            document.getElementById("WebOffice1").close();
        }

        function SaveDoc() {
            if (confirm("提示：确定要保存Office文档吗?")) {
                document.getElementById("WebOffice1").HttpInit();
                document.getElementById("WebOffice1").HttpAddPostString("fileName", document.getElementById("filename").value);
                document.getElementById("WebOffice1").HttpAddPostString("DocType", "doc");
                document.getElementById("WebOffice1").HttpAddPostCurrFile("DocContent", "");
                var vtRet;
                vtRet = document.getElementById("WebOffice1").HttpPost(document.getElementById("saveDoc").value);
                alert(vtRet);
            }
            return false;
        }

        //显示或隐藏修改留痕迹
        //1为显示痕迹 0为隐藏痕迹
        function ShowTrach(showflag) {
            document.getElementById("WebOffice1").ShowRevisions(showflag);
            if (showflag == 1) {
                document.getElementById("WebOffice1").SetTrackRevisions(1);
                document.getElementById("WebOffice1").SetCurrUserName(document.getElementById("currentUserName").value);
            }
            return false;
        }
        
    </script>

</head>
<body onload="javascript:myLoad();" onunload="javascript:myUnload();">
    <form id="form1" runat="server">
    <div id="div1" style="text-align: center; height: 100%; margin-top: 2px">
        <table width="100%" align="center" bgcolor="#c5c5c5" cellpadding="1" cellspacing="1"
            height="100%" border="0">
            <tr bgcolor="#f0f8ff">
                <td align="left">
                    &nbsp;
                    <input class="btn" type="button" id="but2" value="保存到服务器>>" title="保存文件到服务器" onclick="javaScript:return SaveDoc();"
                        runat="server" name="but2" />
                    &nbsp;
                    <input class="btn" type="button" id="but3" value="显示修改痕迹" title="显示文档的修改痕迹，仅适合Doc文档" onclick="javaScript:return ShowTrach(1);"
                        runat="server" name="but3" />
                    &nbsp;
                    <input class="btn" type="button" id="but4" value="隐藏修改痕迹" title="不显示文档的修改痕迹，仅适合Doc文档" onclick="javaScript:return ShowTrach(0);"
                        runat="server" name="but4" />
                </td>
            </tr>
            <tr bgcolor="#f0f8ff" height="96%">
                <td align="center">

                    <script src="loadweboffice.js" type="text/javascript"></script>

                </td>
            </tr>
        </table>
        <input id="wordUrl" type="hidden" name="wordUrl" runat="server" />
        <input id="wordExt" type="hidden" name="wordExt" runat="server" />
        <input id="saveDoc" type="hidden" name="saveDoc" runat="server" />
        <input id="filename" type="hidden" name="filename" runat="server" />
        <input id="isAdmin" type="hidden" name="isAdmin" runat="server" />
        <input id="currentUserName" type="hidden" name="currentUserName" runat="server" />
    </div>
    </form>
</body>
</html>
