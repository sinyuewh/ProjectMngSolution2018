var str = "";
document.writeln("<div id=\"_contents\" style=\"padding:6px; background: url(/images/ui-bg_gloss-wave_35_f6a828_500x100.png); font-size: 12px; border: 1px solid #777777; position:absolute; left:?px; top:?px; width:?px; height:?px; z-index:1; visibility:hidden\">");
str += "\u65f6<select id=\"_hour\">";
for (h = 8; h <= 9; h++) {
    str += "<option value=\"0" + h + "\">0" + h + "</option>";
}
for (h = 10; h <= 22; h++) {
    str += "<option value=\"" + h + "\">" + h + "</option>";
}
str += "</select> \u5206<select id=\"_minute\">";
for (m = 0; m <= 9; m = m + 5) {
    str += "<option value=\"0" + m + "\">0" + m + "</option>";
}
for (m = 10; m <= 59; m = m + 5) {
    str += "<option value=\"" + m + "\">" + m + "</option>";
}
str += "</select>";
str += "</select> <input name=\"queding\" type=\"button\" onclick=\"_select()\" value=\"\u786e\u5b9a\" style=\"font-size:12px\" /></div>";
document.writeln(str);
var _fieldname;
function _SetTime(tt) {
    _fieldname = tt;
    var ttop = tt.offsetTop;    //TT控件的定位点高
    var thei = tt.clientHeight;    //TT控件本身的高
    var tleft = tt.offsetLeft;    //TT控件的定位点宽
    while (tt = tt.offsetParent) {
        ttop += tt.offsetTop;
        tleft += tt.offsetLeft;
    }
    document.getElementById("_contents").style.top = ttop + thei + 4;
    document.getElementById("_contents").style.left = tleft;
    document.getElementById("_contents").style.visibility = "visible";
    try {
        var curTime = _fieldname.value;
        if (curTime == "") {
            var date = new Date();
            curTime = date.getHours() + ":" + date.getMinutes();
        }
        var v1 = curTime.split(":");
        if (parseInt(v1[0]) >= 0 && parseInt(v1[0]) <= 23) {
            document.getElementById("_hour").value = v1[0];
        }

        if (parseInt(v1[1]) >= 0 && parseInt(v1[1]) <= 59) {
            var min = parseInt(v1[1]);
            if (min > 55) {
                min = 55;
            }
            else {
                if (min % 5 != 0) {
                    min = min + (5 - (min % 5));
                }
                if (min <= 9) {
                    min = "0" + min;
                }
            }
            document.getElementById("_minute").value = min;
        }
    }
    catch (e) {
    }

}
function _select() {
    _fieldname.value = document.getElementById("_hour").value + ":" + document.getElementById("_minute").value;
    document.getElementById("_contents").style.visibility = "hidden";
}

//使用
//<input name="time" type="text"   onclick="_SetTime(this)"/>
