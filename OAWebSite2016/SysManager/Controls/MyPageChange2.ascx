<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebFrame.Designer.MyPageChange" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<webdiyer:aspnetpager id="AspNetPager1" runat="server" pagesize="15" enableurlrewriting="false"
        alwaysshow="True" firstpagetext="首页" lastpagetext="尾页" 
    nextpagetext="下一页" numericbuttoncount="5"
        prevpagetext="上一页" showinputbox="Always" showpageindexbox="Always" 
        custominfohtml=""
        custominfosectionwidth="" horizontalalign="Center" custominfotextalign="Center"
        showcustominfosection="Left" showpageindex="True" submitbuttontext="" textafterinputbox="页"
        textbeforeinputbox="跳转到" submitbuttonstyle="display:none"
        font-underline="False" PageIndexBoxStyle="display:none" 
    ShowMoreButtons="False" PagingButtonStyle="" >
</webdiyer:aspnetpager>