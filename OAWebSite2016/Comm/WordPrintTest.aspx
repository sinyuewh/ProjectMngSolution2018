<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WordPrintTest.aspx.cs"
    Inherits="OAWebSite.Comm.WordPrintTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            else 
            {
                document.getElementById("WebOffice1").ShowToolBar = 0;

                //设置Word书签的值
                SetDocBookmarkValues("WebOffice1", "BookMark1,BookMark2,BookMark3")

                //设置Word表格中的值
                SetDocTableCellsValues("WebOffice1", "tabinfo", 1, 2, 2, 1);  
            }
        }


        //关闭窗口
        function myUnload() {
            document.getElementById("WebOffice1").CloseDoc(0);
            document.getElementById("WebOffice1").close();
        }

        //==============================================================================

        //函数1：设置文档的书签值
        //docObject--Word文档OCX控件Name
        //bookmarknames -- Word文档中定义的书签名字列表，书签之间用逗号分隔
        //要求书签的名字和页面中对应的隐藏域相同
        function SetDocBookmarkValues(docOcxName, bookmarknames) {
            var v1 = bookmarknames;
            var vArr1 = v1.split(",");
            for (var i = 0; i < vArr1.length; i++) {
                var value1 = document.getElementById(vArr1[i]).value;
                document.getElementById(docOcxName).SetFieldValue(vArr1[i], value1, "");
            }
        }

        //函数2：填充文档中表格的值
        //docOcxName--Word文档控件Name
        //tabFieldName--页面中用来保存表格数据的隐藏域
        //tabIndex--Word文档中要填充表格的索引，从1开始 （如只有1个表格，则为1）
        //locationRowIndex--Word文档中要填充表格的定位行索引 (一般为2）
        //begRowIndex--Word文档中,表格开始填充的行  （一般为2）
        //begColIndex--word文档中，表格开始填充的列 （一般为1）
        function SetDocTableCellsValues(docOcxName, tabFieldName, tabIndex,
                locationRowIndex, begRowIndex, begColIndex) {
            // 设置表格信息
            try {
                var doc1 = new Object(document.getElementById(docOcxName).GetDocumentObject());
                if (doc1 != null) {

                    var v1 = document.getElementById(tabFieldName).value;
               
                    if (v1.length > 0) {
                        var arrV1 = v1.split("￥￥");
                        var tab1 = doc1.Tables(tabIndex);
                        var row1 = tab1.Rows(locationRowIndex);
                        
                        for (var i = 0; i < arrV1.length; i++) {
                            tab1.Rows.Add(row1);   //循环插入表格行
                        }

                        //删除定位行
                        tab1.Rows(locationRowIndex).Delete();

                        //对表格数据行进行赋值
                        for (var i = 0; i < arrV1.length; i++) {
                            var arrV2 = arrV1[i].split("$$");

                            for (var j = 0; j < arrV2.length; j++) {
                                tab1.Cell(i + begRowIndex, j + begColIndex).Range.Text = arrV2[j];
                            }
                        }
                    }
                }
            }
            catch (e) {
                alert(e.message);
            }
        }
    </script>

</head>
<body onload="javascript:myLoad();" onunload="javascript:myUnload();">
    <form id="form1" runat="server">
    <div id="div1" style="text-align: center; height: 100%; margin-top: 2px">

        <script src="LoadWebOffice.js" type="text/javascript"></script>
        
        <!--要显示的Word模版-->
        <input id="wordFile" type="hidden" name="wordFile" runat="server" value ="/Comm/DocTemp.doc" />
        
        <input id="wordUrl" type="hidden" name="wordUrl" runat="server" />
        <input id="wordExt" type="hidden" name="wordExt" runat="server" />

        <!--定义与书签对应的隐藏域 BookMark1 BookMark2 BookMark3-->
        <input id="BookMark1" type="hidden" name="BookMark1" runat="server" value ="Hello,WuHan" />
        <input id="BookMark2" type="hidden" name="BookMark2" runat="server" value ="Hello,HuBei" />
        <input id="BookMark3" type="hidden" name="BookMark3" runat="server" value ="Hello,China" />
        
        <!--设置表格的数据-->
        <input id="tabinfo" type="hidden" name="tabinfo1" runat="server" 
        value ="1$$2$$3$$4$$5￥￥11$$22$$33$$44$$55￥￥111$$222$$332$$442$$552" />
    </div>
    </form>
</body>
</html>
