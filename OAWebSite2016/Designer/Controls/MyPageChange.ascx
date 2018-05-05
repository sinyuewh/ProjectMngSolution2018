<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebFrame.Designer.MyPageChange" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<webdiyer:aspnetpager id="AspNetPager1" runat="server" pagesize="15" enableurlrewriting="false"
        alwaysshow="True" firstpagetext="首页" lastpagetext="尾页" nextpagetext="下一页" numericbuttoncount="5"
        prevpagetext="上一页" showinputbox="Always" showpageindexbox="Always" width="100%"
        custominfohtml="&lt;div&gt;当前共有&lt;b&gt;%RecordCount%&lt;/b&gt;条记录,当前第&lt;b&gt;%CurrentPageIndex%&lt;/b&gt;页，共&lt;b&gt;%PageCount%&lt;/b&gt;页&lt;/div&gt;"
        custominfosectionwidth="40%" horizontalalign="Right" custominfotextalign="Left"
        showcustominfosection="Left" showpageindex="True" submitbuttontext="跳转" textafterinputbox="页"
        textbeforeinputbox="跳转到" submitbuttonstyle="border:0px; text-decoration:underline;background-image: url(/Images/tab_19.gif);"
        font-underline="False" PageIndexBoxStyle="height:12px;" >
</webdiyer:aspnetpager>