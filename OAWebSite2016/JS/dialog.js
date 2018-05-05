/// <reference path="/ArtDialog/jquery.artdialog.js?skin=blue" />
/// <reference path="/ArtDialog/plugins/iframeTools.js" />
//确定/取消对话框
var lock_opacity = 0.7;

// 通用显示Iframe方法
function ViewInLayer(obj) {
    var dialog_id = obj.dialog_id ? obj.dialog_id : "dialog1";
    var width = obj.width ? obj.width : 800;
    var height = obj.height ? obj.height : 480;
    var title = obj.title ? obj.title : "窗口";
    var url = obj.url ? obj.url : "";
    var okEvent = (obj.okEvent && typeof (obj.okEvent) == "function") ? function(ob) { obj.okEvent(ob); } : null;
    var cancel = obj.cancel == false ? null : true;
    var cancelVal, OK;
    if (cancel) {
        cancelVal = obj.cancelVal ? obj.cancelVal : "返回";
        OK = obj.hideOK == true ? false : fnOK;
    }
    var lock = obj.lock ? obj.lock : false;
    var close = (obj.close && typeof (obj.close) == "function") ? obj.close : null;
    var content = obj.content ? obj.content : "";
    try {
        art.dialog.open(url, {
            title: title,
            width: width,
            height: height,
            lock: lock,
            opacity: lock_opacity,
            ok: OK,
            cancel: cancel,
            cancelVal: cancelVal,
            close: close,
            content: content
        });
    } catch (e) {
        throw e;
    }

    //弹出框确认
    function fnOK() {
        var iframe = this.iframe.contentWindow;
        if (!iframe.document.body) {
            alert('正在加载...')
            return false;
        };
        if (iframe.SaveData != null) {
            var data = iframe.SaveData();
            if (okEvent != null && data != null) {
                okEvent(data);
                return true;
            }
        }
        return false;
    }
}

// 通用显示内容的弹出框
function ViewContentInLayer(obj) {
    var dialog_id = obj.dialog_id ? obj.dialog_id : "dialog1";
    var width = obj.width ? obj.width : 800;
    var height = obj.height ? obj.height : 480;
    var title = obj.title ? obj.title : "窗口";
    var lock = obj.lock ? obj.lock : false;
    var close = (obj.close && typeof (obj.close) == "function") ? obj.close : null;
    var content = obj.content ? obj.content : "";
    var padding = obj.padding ? obj.padding : '20px 25px';

    try {
        art.dialog({
            title: title,
            width: width,
            height: height,
            lock: lock,
            opacity: lock_opacity,
            close: close,
            content: content,
            padding: padding
        });
    }
    catch (e) {
        throw e;
    }
}

//Alert提示框
function AlertWin(msg, op) {
    op = op ? op : {};
    op.dialog_id = 'alert_dialog';
    op.title = "提示";
    op.width = op.width ? op.width : 200;
    op.height = op.height ? op.height : 100;
    op.content = msg;

    ViewContentInLayer(op);
}

artDialog.notice = function(options) {
    var opt = options || {},
        api, aConfig, hide, wrap, top,
        duration = 800;

    var config = {
        id: 'Notice',
        left: '100%',
        top: '100%',
        fixed: true,
        drag: false,
        resize: false,
        follow: null,
        lock: false,
        init: function(here) {
            api = this;
            aConfig = api.config;
            wrap = api.DOM.wrap;
            top = parseInt(wrap[0].style.top);
            hide = top + wrap[0].offsetHeight;

            wrap.css('top', hide + 'px')
                .animate({ top: top + 'px' }, duration, function() {
                    opt.init && opt.init.call(api, here);
                });
        },
        close: function(here) {
            wrap.animate({ top: hide + 'px' }, duration, function() {
                opt.close && opt.close.call(this, here);
                aConfig.close = $.noop;
                api.close();
            });

            return false;
        }
    };

    for (var i in opt) {
        if (config[i] === undefined) config[i] = opt[i];
    };

    return artDialog(config);
};

//Alarm提示框
function AlarmWin(title,msg,w) {
    art.dialog.notice({
        title: title,
        padding: "5px 0px 5px 5px",
        width: w, // 必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致artDialog收缩
        content:msg 
    });
}

//Alarm提示框(带表情图)
function AlarmWin(title, msg, w,ico) {
    art.dialog.notice({
        title: title,
        padding: "5px 0px 5px 5px",
        width: w, // 必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致artDialog收缩
        content: msg,
        icon:ico
    });
}

function AlertMsg(url, title, w, h, mask) {
    var op = {};
    op.dialog_id = title+'dialog1';
    op.title = title;
    //var url1 = location.href.substring(0, location.href.lastIndexOf("/") + 1) + url;
    //alert(url1);
    //op.url = url1;  
      
    op.url = url;
    op.width = w ? w : 600;
    op.height = h ? h : 400;
    op.cancel = false;
    op.cancelVal = "关闭";
    op.lock = mask;
    
    ViewInLayer(op);
}

//关闭窗体
function CloseMsg() {
    art.dialog.close();
}
