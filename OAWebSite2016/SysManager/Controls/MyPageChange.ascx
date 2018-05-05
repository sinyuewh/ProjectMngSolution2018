<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebFrame.Designer.MyPageChange" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<script runat ="server">
    protected override void OnInit(EventArgs e)
    {
        this.but1.Click += new EventHandler(but1_Click);
        base.OnInit(e);
    }

    void but1_Click(object sender, EventArgs e)
    {
        int t1 = int.Parse(Request.Form["mycurpage"])+1;
        this.CurrentPageIndex = t1;
        this.AspNetPager1.CurrentPageIndex = t1;
    }
</script>
<div class="pagination ue-clear">
</div>
<webdiyer:AspNetPager ID="AspNetPager1" runat="server" PageSize="15" EnableUrlRewriting="false"
    Visible="false" AlwaysShow="True" FirstPageText="首页" LastPageText="尾页" NextPageText="下一页"
    NumericButtonCount="5" PrevPageText="上一页" showinputbox="Always" ShowPageIndexBox="Always"
    Width="100%" CustomInfoHTML="<div class='pxofy'>&lt;div&gt;当前共有&lt;b&gt;%RecordCount%&lt;/b&gt;条记录,当前第&lt;b&gt;%CurrentPageIndex%&lt;/b&gt;页，共&lt;b&gt;%PageCount%&lt;/b&gt;页&lt;/div&gt;</div>"
    CustomInfoSectionWidth="60%" HorizontalAlign="Right" CustomInfoTextAlign="Left"
    ShowCustomInfoSection="Left" ShowPageIndex="True" SubmitButtonText="跳转" textafterinputbox="页"
    textbeforeinputbox="跳转到" Font-Underline="False" PageIndexBoxStyle="height:18px;">
</webdiyer:AspNetPager>
<div style="display: none">
    <input type="hidden" name="mycurpage" id="mycurpage" value="0" />
    <jasp:JButton ID="but1" runat ="server"></jasp:JButton>
</div>

<script type="text/javascript">
    $('.pagination').pagination(<%=this.RecordCount %>, {
        callback: function(page) {
            GoPage(page);
        },
        display_msg: true,
        setPageNo: true,
        items_per_page : <%=this.PageSize %>, 
		current_page : <%=(this.CurrentPageIndex-1) %>    
    });
    
    
    function GoPage(page1)
    {
        $("#mycurpage").val(page1+"");
        $('#<%=this.but1.ClientID %>').click();
    }
</script>

