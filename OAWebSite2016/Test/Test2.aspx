<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="OAWebSite2016.Test.Test2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <script language="javascript">
        Number.prototype.toFixed = function(s) {
            changenum = (parseInt(this * Math.pow(10, s) + 0.5) / Math.pow(10, s)).toString();
            index = changenum.indexOf(".");
            if (index < 0 && s > 0) {
                changenum = changenum + ".";
                for (i = 0; i < s; i++) {
                    changenum = changenum + "0";
                }

            } else {
                index = changenum.length - index;
                for (i = 0; i < (s - index) + 1; i++) {
                    changenum = changenum + "0";
                }

            }
            return changenum;
        } 
  
        try {
            var v1 = 1.1
            var v2 = 1.2
            var v = (v1 + v2) / 2;
            var v1 = v.toFixed(1);
            alert(v1);
            
        }
        catch (e) {
            alert(e.toString());
        }


       
    </script>
    </div>
    </form>
</body>
</html>
