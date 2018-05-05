

/** year : /yyyy/ */
var _y4 = "([0-9]{4})";
/** year : /yy/ */
var _y2 = "([0-9]{2})";
/** index year */
var _yi = -1;
/** month : /MM/ */
var _M2 = "(0[1-9]|1[0-2])";
/** month : /M/ */
var _M1 = "([1-9]|1[0-2])";
/** index month */
var _Mi = -1;
/** day : /dd/ */
var _d2 = "(0[1-9]|[1-2][0-9]|30|31)";
/** day : /d/ */
var _d1 = "([1-9]|[1-2][0-9]|30|31)";
/** index day */
var _di = -1;
/** hour : /HH/ */
var _H2 = "([0-1][0-9]|20|21|22|23)";
/** hour : /H/ */
var _H1 = "([0-9]|1[0-9]|20|21|22|23)";
/** index hour */
var _Hi = -1;
/** minute : /mm/ */
var _m2 = "([0-5][0-9])";
/** minute : /m/ */
var _m1 = "([0-9]|[1-5][0-9])";
/** index minute */
var _mi = -1;
/** second : /ss/ */
var _s2 = "([0-5][0-9])";
/** second : /s/ */
var _s1 = "([0-9]|[1-5][0-9])";
/** index month */
var _si = -1;
var regexp;
function getFormatDate(dateString, formatString) {
    if (validateDate(dateString, formatString)) {
        var now = new Date();
        var vals = regexp.exec(dateString);
        var index = validateIndex(formatString);
        var year = index[0] >= 0 ? vals[index[0] + 1] : now.getFullYear();
        var month = index[1] >= 0 ? (vals[index[1] + 1] - 1) : now.getMonth();
        var day = index[2] >= 0 ? vals[index[2] + 1] : now.getDate();
        var hour = index[3] >= 0 ? vals[index[3] + 1] : "";
        var minute = index[4] >= 0 ? vals[index[4] + 1] : "";
        var second = index[5] >= 0 ? vals[index[5] + 1] : "";
        var validate;
        if (hour == "") {
            validate = new Date(year, month, day);
        } else {
            validate = new Date(year, month, day, hour, minute, second);
        }
        if (validate.getDate() == day) {
            return validate;
        }
    }
    alert("日期或时间格式错误！请选用24小时制日期和时间");
}
function validateDate(dateString, formatString) {
    var dateString = trim(dateString);
    if (dateString == "") {
        return;
    }
    var reg = formatString;
    reg = reg.replace(/yyyy/, _y4);
    reg = reg.replace(/yy/, _y2);
    reg = reg.replace(/MM/, _M2);
    reg = reg.replace(/M/, _M1);
    reg = reg.replace(/dd/, _d2);
    reg = reg.replace(/d/, _d1);
    reg = reg.replace(/HH/, _H2);
    reg = reg.replace(/H/, _H1);
    reg = reg.replace(/mm/, _m2);
    reg = reg.replace(/m/, _m1);
    reg = reg.replace(/ss/, _s2);
    reg = reg.replace(/s/, _s1);
    reg = new RegExp("^" + reg + "$");
    regexp = reg;
    return reg.test(dateString);
}
function validateIndex(formatString) {
    var ia = new Array();
    var i = 0;
    _yi = formatString.search(/yyyy/);
    if (_yi < 0) {
        _yi = formatString.search(/yy/);
    }
    if (_yi >= 0) {
        ia[i] = _yi;
        i++;
    }
    _Mi = formatString.search(/MM/);
    if (_Mi < 0) {
        _Mi = formatString.search(/M/);
    }
    if (_Mi >= 0) {
        ia[i] = _Mi;
        i++;
    }
    _di = formatString.search(/dd/);
    if (_di < 0) {
        _di = formatString.search(/d/);
    }
    if (_di >= 0) {
        ia[i] = _di;
        i++;
    }
    _Hi = formatString.search(/HH/);
    if (_Hi < 0) {
        _Hi = formatString.search(/H/);
    }
    if (_Hi >= 0) {
        ia[i] = _Hi;
        i++;
    }
    _mi = formatString.search(/mm/);
    if (_mi < 0) {
        _mi = formatString.search(/m/);
    }
    if (_mi >= 0) {
        ia[i] = _mi;
        i++;
    }
    _si = formatString.search(/ss/);
    if (_si < 0) {
        _si = formatString.search(/s/);
    }
    if (_si >= 0) {
        ia[i] = _si;
        i++;
    }
    var ia2 = new Array(_yi, _Mi, _di, _Hi, _mi, _si);
    for (i = 0; i < ia.length - 1; i++) {
        for (j = 0; j < ia.length - 1 - i; j++) {
            if (ia[j] > ia[j + 1]) {
                temp = ia[j];
                ia[j] = ia[j + 1];
                ia[j + 1] = temp;
            }
        }
    }
    for (i = 0; i < ia.length; i++) {
        for (j = 0; j < ia2.length; j++) {
            if (ia[i] == ia2[j]) {
                ia2[j] = i;
            }
        }
    }
    return ia2;
}

function trim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

function checkTime(tab) {
    if (tab < 10) {
        tab = "0" + tab;
    }
    return tab;
}

//两个日期相差的天数
function DateDiff(sDate1, sDate2) {
    var aDate, oDate1, oDate2, iDays;
    aDate = sDate1.split('-');
    oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
    //转换为04-19-2007格式 
    aDate = sDate2.split('-');
    oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
    iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 / 24); //把相差的毫秒数转换为天数 
    return iDays;
}

//比较两个日期
function CompareDate(d1, d2) {
    return ((new Date(d1.replace(/-/g, "\/"))) > (new Date(d2.replace(/-/g, "\/"))));
}