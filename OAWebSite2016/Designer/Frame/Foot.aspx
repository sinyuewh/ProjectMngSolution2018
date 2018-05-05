<%@ Page Language="C#" AutoEventWireup="true" %>

<script runat="server">
  
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        body
        {
            margin: 0 0 0 0;
            background-color: White;
            background-image: url(/images/Frame/footBg.gif);
            background-repeat: repeat-x;
            overflow-x: hidden;
            overflow-y: hidden;
        }
        img
        {
            border: 0;
        }
        .menu
        {
            height: 29px;
            float: left;
        }
        .menu ul
        {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .menu ul li
        {
            background-image: url(/images/Frame/menu1.gif);
            width: 82px;
            height: 29px;
            float: left;
            margin-right: 5px;
            text-align: center;
            line-height: 29px;
            cursor: pointer;
        }
        .menu ul li span
        {
            font-size: 13px;
            font-weight: bolder;
            color: #FFFFFF;
        }
        a
        {
            color: #000;
            text-decoration: none;
            blr: expression(this.onFocus=this.blur());
        }
    </style>

    <script src="/Js/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script src="/Js/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>

    <script src="/js/PubLib.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

       
    </script>

</head>
<body>
    <div style="background-image: url(/images/Frame/footBg.gif); height: 28px">
        <table id="__01" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <%-- <td height="30px" align="left" valign="middle">
                    <div style="text-align: right; line-height: 30px; float: left; margin-left: 10px;">
                        <a id="zd1" title="隐藏导航" href="JavaScript:OpenOrCloseMenu();" style="color: #FFFFFF;
                            font-size: 12px">
                            <img src="/images/Frame/ico/del.png" style="vertical-align: middle" />隐藏导航</a>&nbsp;&nbsp;&nbsp;
                        <a title="将页面加到首页的快捷方式" href="JavaScript:AddFavor();" style="color: #FFFFFF; font-size: 12px">
                            <img src="/images/Frame/ico/add1.png" style="vertical-align: middle" />加入快捷</a>&nbsp;&nbsp;&nbsp;
                    </div>
                </td>--%>
                <td style="height: 29px" align="center">
                    <span style="color: White; font-family: 黑体;">
                        <%=DateTime.Now.ToString("yyyy年MM月dd日 dddd") %></span>&nbsp;&nbsp; <span style="color: White;
                            font-family: 黑体;" id="time1">
                            <%=DateTime.Now.ToString("hh:mm:ss") %></span>
                </td>
            </tr>
        </table>
    </div>

    <script language="javascript" type="text/javascript">
        //设置时间显示的定时器
        var timeoutId = setInterval(function() {
            var dateObj = new Date();
            var h1 = dateObj.getHours();
            if (h1 < 10) h1 = "0" + h1;
            var s1 = dateObj.getMinutes();
            if (s1 < 10) s1 = "0" + s1;
            var m1 = dateObj.getSeconds();
            if (m1 < 10) m1 = "0" + m1;
            document.getElementById("time1").innerHTML = h1 + ":" + s1 + ":" + m1;
        }, 500);
    </script>
    <iframe height="0" width="0" src="/Login/RefreshSessionState.aspx" frameborder="0" />
</body>
</html>
