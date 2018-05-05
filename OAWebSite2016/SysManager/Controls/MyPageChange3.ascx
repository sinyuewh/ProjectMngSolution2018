<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebFrame.Designer.MyPageChange" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<webdiyer:aspnetpager id="AspNetPager1" runat="server" pagesize="15" enableurlrewriting="false"
       alwaysshow="True" firstpagetext="|< " lastpagetext=">|" 
        nextpagetext=" >>" numericbuttoncount="5"
        prevpagetext="<<" showinputbox="Always" showpageindexbox="Always" 
        custominfohtml=""
        custominfosectionwidth="" horizontalalign="Center" 
    custominfotextalign="Center" showpageindex="True" submitbuttontext="" textafterinputbox="页"
        textbeforeinputbox="跳转到" submitbuttonstyle="display:none"
        font-underline="False" PageIndexBoxStyle="display:none" 
    ShowMoreButtons="False" PagingButtonStyle="" BorderStyle="None" 
    BorderWidth="0px" LayoutType="Table" >
</webdiyer:aspnetpager>