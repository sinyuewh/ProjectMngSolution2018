<%@ Page Title="" Language="C#" MasterPageFile="~/Designer/include/Third.Master"
    AutoEventWireup="true" Inherits="WebFrame.Designer.SelectTableBU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language ="javascript" type ="text/javascript">
        $(document).ready(function () {
            $(".Caption2 :checkbox").click(function () {
                if (this.checked) {
                    $(this).siblings("#info").text("全不选");
                    $(".Data2 :checkbox").attr({ 'checked': 'true' });
                }
                else {
                    $(this).siblings("#info").text("全选");
                    $(".Data2 :checkbox").attr({ 'checked': '' });
                }
            });

            //按钮的click事件-----------------------------------------------------------
            $(".ButtonArea :submit").first().click(function () {
                var selvalue = "";
                $(".Data2 :checkbox").each(function () {
                    if (this.checked) {
                        if (selvalue == "") {
                            selvalue = $(this).siblings("label").text();
                        }
                        else {
                            selvalue = selvalue + "," + $(this).siblings("label").text();
                        }
                    }
                });


                var win = art.dialog.open.origin;
                $('#<%=Request["parentID"]%>', win.document).val(selvalue);
                
                //$('#<%=Request["parentID"]%>', parent.document).val(selvalue);
                art.dialog.close();
                return false;
            });
            //---------------------------------------------------------------
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="script1" runat="server">
    </asp:ScriptManager>
    <br />
    <!--定义数据源-->
    
    <table class="DetailTable" border="0" align="center" cellpadding="1" cellspacing="1"
        style="width: 90%">
        <tr>
            <td class="Caption2" style ="width:20%">
                请选择表名：<br />
                <span id="info" style="font-weight:normal">全选</span>
                <asp:CheckBox ID="chk1" runat ="server"  />
            </td>
            <td class="Data2">
                <asp:CheckBoxList ID="chkTable" runat ="server" RepeatColumns="3" Width ="95%">
                </asp:CheckBoxList>
            </td>
        </tr>
    </table>
    <div class="ButtonArea">
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnSubmit" runat="server" Text="确 定" />
                &nbsp;
                <asp:Button ID="btnClose" runat="server" Text="关 闭" OnClientClick="javascript:art.dialog.close();" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
