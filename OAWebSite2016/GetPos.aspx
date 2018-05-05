<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected override void OnLoad(EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Response.Write("100,200,300");
            Response.End();
        }
        base.OnLoad(e);
    }
</script>

