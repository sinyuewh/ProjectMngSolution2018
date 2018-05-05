<%@ Page Language="C#" AutoEventWireup="true" Inherits="WebFrame.Designer.LeftMenuBU" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="/css/frame/style.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/css/frame/core.css" rel="stylesheet" type="text/css" media="screen" />
    <style type="text/css">
        .childSystem
        {
        }
        html, body, form
        {
            height: 100%;
        }
        body
        {
            margin: 0 0 0 0;
            text-align: left;
            padding: 0 0 0 0;
        }
    </style>

    <script src="/Js/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            ShowChildSystem(0);
        });

        //显示index1的子系统导航
        function ShowChildSystem(index1) {
            var h1 = document.body.offsetHeight;
            var parent1 = $('.childSystem')[index1];
            $('.childSystem').css('display', 'none');
            $(parent1).css('display', 'block');

            var h0 = parseInt($('.accordionHeader h2', parent1).css('height').replace('px', ''));
            var h2 = $('.accordionContent', parent1).length * h0;
            var h3 = parseInt($('.toggleCollapse div', parent1).css('height').replace('px', ''));
            h1 = h1 - h2 - h3 - 10;   //计算合适的高度

            //设置默认第一个模块显示
            $('.accordionContent', parent1).css('height', h1 + 'px');
            $('.accordionContent', parent1).hide();
            $('.accordionContent', parent1).first().show();

            $('.accordionHeader', parent1).click(function() {
                $('.accordionHeader h2', parent1).removeClass('collapsable');
                $('h2', this).addClass('collapsable');
                var pos1 = $(this).next('.accordionContent').index();
                var $cur = $(this).next('.accordionContent');

                $('.accordionContent', parent1).each(function(index1, item1) {
                    var pos2 = $(item1).index();
                    if (pos1 != pos2 && $(item1).css('display') == 'block') {
                        $(item1).css('display', 'none');
                        $cur.slideDown(1000);
                        //$cur.css('display', 'block');

                        /*
                        if (pos2 < pos1) {
                        $(item1).slideToggle('slow');
                        $cur.slideToggle('slow');
                        }
                        else {
                        $cur.slideToggle('slow');
                        $(item1).slideToggle('slow');
                        }*/
                    }
                });
            });

            /*  
            //设置选中链接的颜色等
            $('.accordionContent').click(function () {
            $("a", this).css("color", "red");
            });*/


            //设置最后一个和第一个的样式
            $('.accordionContent').each(function(index1, item1) {
                $('ul li', item1).last().addClass('last');  //设置最后一个的样式为Last
            });

            $('.accordionHeader h2', parent1).first().addClass('collapsable');

            //设置最后一个边框的宽度为0
            $('.accordionContent', parent1).last().css("border-bottom-width", "0px");
            // $('.accordionContent', parent1).last().css("border-bottom-width", "0px");
        }

        //显示多标签的菜单
        function showurl(subtitle, url) {
            top.frames["dmMain"].addTab(subtitle, url);
        }
    </script>

</head>
<body scroll="no" style="background-color: #f0f8ff">
    <form id="form1" runat="server">
    <div id="layout" style="height: 100%">
        <div id="leftside" style="height: 100%">
            <asp:Repeater ID="rep1" runat="server" EnableViewState="false">
                <ItemTemplate>
                    <div class="childSystem" style="height: 100%; display: none">
                        <div class="sidebar" style="height: 100%;">
                            <div style="float: left; background-image: url(/images/Frame/tab_03.gif); width: 12px;
                                height: 26px; margin-left: -3px">
                            </div>
                            <div class="toggleCollapse">
                                <h2>
                                    <%#Container.DataItem%></h2>
                                <div>
                                </div>
                            </div>
                            <div class="accordion dwz-accordion" fillspace="sidebar" style="height: 100%;">
                                <asp:Repeater ID="rep2" runat="server">
                                    <ItemTemplate>
                                        <div class="accordionHeader" title="点击展开导航菜单">
                                            <h2>
                                                <span>Folder</span><%#Eval("Caption1") %></h2>
                                        </div>
                                        <div class="accordionContent">
                                            <ul class="tree">
                                                <asp:Repeater ID="rep3" runat="server">
                                                    <ItemTemplate>
                                                        <li>
                                                            <div>
                                                                <div class="node">
                                                                </div>
                                                                <a href="javascript:void(0)" title='<%#Eval("value") %>' id='<%#Eval("url")%>' onclick="showurl('<%#Eval("value") %>','<%#Eval("url")%>')"
                                                                    target="_self" rel="w_tabs">
                                                                    <%#Eval("caption") %></a></div>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                            <%--<div style ="height:50px"></div>--%>
                                           
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    </form>
</body>
</html>
