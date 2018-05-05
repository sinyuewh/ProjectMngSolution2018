<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadLiftData.aspx.cs" Inherits="OAWebSite.Comm.ReadLiftData" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="/JS/PubLib.js" type="text/javascript"></script>

    <script src="/Js/jquery.pack.js" type="text/javascript"></script>

    <script src="/JS/jquery.1.3.2.js" type="text/javascript" language="javascript"></script>

    <script src="/JS/popup_layer.js" type="text/javascript" language="javascript"></script>

    <script language="javascript" type="text/javascript">
    
        var clock1 = window.setInterval(tip, 100);
        var index1 = parseInt(Math.random() * (1000 + 1));

        function tip() {
            var htmlobj = $.ajax({ url: "http://61.183.239.46:7777/", async: false });
            var str1 = htmlobj.responseText;
            document.getElementById("txt1").value = str1;
            //document.getElementById("span1").innerHTML = str1;
            
            /*
            document.getElementById("txt1").value = document.getElementById("txt1").value
            + str1;

            index1 = index1 + 1;
            document.getElementById("span1").innerHTML = parseInt(document.getElementById("span1").innerHTML) + str1.length *
            */
        } 

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <jasp:JTextBox ID="txt1" runat="server" TextMode="MultiLine" Width="90%" Height="400px">
        </jasp:JTextBox>
        <%--电梯的运行数据如下：<br /><span id="span1"></span>--%>
    </div>
    </form>
</body>
</html>
