<%@ Page Title="" Language="C#" MasterPageFile="~/SysManager/include/H-uiThird.Master"
    AutoEventWireup="true" CodeBehind="JItem_SetItemValues.aspx.cs" Inherits="OAWebSite2016.SysManager.WebUI.SysMng.JItem_SetItemValues" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--导航区设置-->
    <div class="pd-20">
        <asp:ScriptManager ID="script1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="update1" runat="server">
            <ContentTemplate>
                <div class="cl pd-5 bg-1 bk-gray mt-20" style="margin-top: -30px">
                    <span class="l">
                        <jasp:SecurityPanel ID="sec1" runat="server" RoleID="xtgl">
                            <button id="button1" runat="server" class="btn btn-primary radius">
                                <i class="Hui-iconfont">&#xe600;</i> 添加条目</button>
                            &nbsp;&nbsp;
                            <button id="button2" runat="server" class="btn btn-secondary radius">
                                <i class="Hui-iconfont">&#xe632;</i> 提 交</button>
                        </jasp:SecurityPanel>
                    </span><span class="r">共有数据：<strong><%=this.rep1.Items.Count %></strong> 条</span>
                </div>
                <!--数据表格-->
                <div class="mt-20" style="height: 330px; overflow: auto">
                    <table class="table table-border table-bordered table-hover table-bg table-sort">
                        <thead>
                            <tr class="text-c">
                                <th>
                                    排序
                                </th>
                                <th>
                                    条目Text
                                </th>
                                <th>
                                    条目Key
                                </th>
                                <th>
                                    操作
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rep1" runat="server">
                                <ItemTemplate>
                                    <tr class="text-c">
                                        <td>
                                            <jasp:JTextBox ID="Num" runat="server" Caption="排序" AllowNullValue="false" DataType="Integer"
                                                Text='<%#Eval("num") %>' class="input-text" Width="60px" Style="text-align: center"></jasp:JTextBox>
                                        </td>
                                        <td>
                                            <jasp:JTextBox ID="ItemText" runat="server" Caption="条目Text" AllowNullValue="false"
                                                Text='<%#Eval("itemtext") %>' class="input-text"></jasp:JTextBox>
                                        </td>
                                        <td>
                                            <jasp:JTextBox ID="ItemValue" runat="server" Caption="条目Value" AllowNullValue="false"
                                                Text='<%#Eval("itemvalue") %>' class="input-text"></jasp:JTextBox>
                                        </td>
                                        <td class="operate">
                                            <jasp:JLinkButton ID="butDel" RoleID="xtgl" IsAlwaysReload="true" runat="server"
                                                Text="[删除]" CommandArgument='<%#Container.ItemIndex %>' OnClientClick="javascript:DeleteData(this.id);return false;"
                                                CssClass="blue"></jasp:JLinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <script type="text/javascript">
        $(function() {
            $('.table-sort tbody').on('click', 'tr', function() {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
        });

        //删除数据
        function DeleteData(delid) {
            var index1 = layer.confirm("提示：确定要删除选中的数据吗？",
                function() { delid = delid.replace(/_/g, "$"); __doPostBack(delid, ''); layer.close(index1); }
            );
        }
    </script>

    <jasp:SecurityPanel ID="sec0" runat="server" AuthorityKind="DirectNoAccessPage" >
    </jasp:SecurityPanel>
</asp:Content>
