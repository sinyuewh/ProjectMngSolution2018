//////////////////////////////////显示隐藏Tip层////////////////////////////////////
function ShowTip(ShowText, ShowTip, requestUrl) {
    var _key;
    $(ShowText).keyup(function (e) {
        if (e == null)/////////IE
        {
            _key = event.keyCode;
        }
        else//FireFox
        {
            _key = e.which;
        }
        if ((_key != 39 && _key != 40 && _key != 37 && _key != 38 && _key != 13 && _key != 17)) {
            $(ShowTip).show("");
            $(ShowTip).html("<img src='ajax-loader.gif'>&nbsp;正在获取提示...");
            $(ShowTip).css("width", $(ShowText).outerWidth())
			                           .css("top", $(ShowText).offset().top + $(ShowText).outerHeight() + "px") //使用 outerheight ，否则会与 文本框 有重叠部分
                                       .css("left", $(ShowText).offset().left + "px")
                                       .css("overflow", "auto")
                                       .css("position", "absolute")
                                       .css("border", "1px solid black");
            $.get(requestUrl, { KeyWord: $(ShowText).val() }, function (data) {
                //data为JSON数据
                var list = eval(data);
                if (list != "") {
                    $(ShowTip).html("");
                    var IdarrA = list;
                    var DIVStr = "";
                    var FormatStr = "";
                    var sum = IdarrA.length - 1;
                    for (P = 0; P < IdarrA.length; P++) {
                        FormatStr = IdarrA[P].replace($(ShowText).val(), "<b><font color='red'>" + $(ShowText).val() + "</font></b>")
                        DIVStr += "<div id='" + P + "' hideFocus style='cursor:pointer;line-height:20px;' onmousemove='FocusOP(" + P + "," + sum + ");' onmouseout='UFocusOP(" + P + ");' onclick='ClickInner(\"" + IdarrA[P] + "\",\"" + ShowText + "\",\"" + ShowTip + "\");'>" + FormatStr + "</div>";
                    }
                    $(ShowTip).html(DIVStr);
                    var i = 0; maxid = IdarrA.length;
                    document.onkeydown = function (e) {
                        var _key;
                        if (e == null)/////////IE
                        {
                            _key = event.keyCode;
                        }
                        else//FireFox
                        {
                            _key = e.which;
                        }
                        if ((_key == 39 || _key == 40))/////////////向下
                        {
                            if (i > maxid - 1) { i = 0; } else { i = i + 1; }
                            if (i > maxid - 1) { UFocusOP(maxid - 1); FocusOP('0', maxid); i = 0; }
                            else { UFocusOP(i - 1); FocusOP(i, maxid); }
                        }
                        else if (_key == 37 || _key == 38)/////////////向上
                        {
                            if (i < 0) { i = 0; } else { i = i - 1; }
                            if (i < 0) { UFocusOP(i + 1); FocusOP(maxid - 1, maxid); i = maxid - 1; }
                            else { UFocusOP(i + 1); FocusOP(i, maxid); }
                        }
                        if (_key == 13 && $(ShowText)[0].style.display != "none") {
                            $(ShowText).val(document.getElementById(i).textContent);
                            $(ShowTip).hide();
                        }
                    }
                }
                else {
                    $(ShowTip).hide();
                }
            });
        }
    });
}

function HideTTip() {
    $("#ShowTip").hide();
}
//////////////////////////////////显示隐藏Tip层////////////////////////////////////

//////////////////////////////////焦点获取和返值////////////////////////////////////
function FocusOP(OPP, VNum)//获取焦点
{
    for (M = 0; M < VNum; M++) {
        document.getElementById(M).focus = false;
        document.getElementById(M).style.background = "#FFFFFF";
    }
    document.getElementById(OPP).focus = true;
    document.getElementById(OPP).style.background = "#FFFFCC";
}
function UFocusOP(OPP) {
    document.getElementById(OPP).focus = false;
    document.getElementById(OPP).style.background = "#FFFFFF";
}
function ClickInner(OPP, ShowText, ShowTip) {
    $(ShowText).val(OPP);
    $(ShowTip)[0].style.display = "none";
}
//////////////////////////////////焦点获取和返值////////////////////////////////////