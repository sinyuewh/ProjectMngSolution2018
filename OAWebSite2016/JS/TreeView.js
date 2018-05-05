//TreeView的操作
function OnTreeNodeChecked() {
    var ele = event.srcElement;
    if (ele.type == 'checkbox') {
        var childrenDivID = ele.id.replace('CheckBox', 'Nodes');
        var div = document.getElementById(childrenDivID);
        if (div != null) {
            var checkBoxs = div.getElementsByTagName('INPUT');
            for (var i = 0; i < checkBoxs.length; i++) {
                if (checkBoxs[i].type == 'checkbox')
                    checkBoxs[i].checked = ele.checked;
            }
        }
        OnTreeNodeChildChecked(ele);
    }
}

//子节点的操作
function OnTreeNodeChildChecked(ele) {
    //递归处理
    if (ele == null) {
        ele = event.srcElement;
    }
    var succ = true;
    if (ele.parentElement != null) {
        var parentDiv = ele.parentElement;
        // alert(ele.parentElement);
        while (succ) {
            if (parentDiv.id != "") {
                break;
            }
            else {
                parentDiv = parentDiv.parentElement;
            }
        }
        var parentChkBox = document.getElementById(parentDiv.id.replace('Nodes', 'CheckBox'));
        if (parentChkBox != null) {
            var ChildsChkAll = true;
            var Boxs = parentDiv.getElementsByTagName('INPUT');
            for (var i = 0; i < Boxs.length; i++) {

                if (Boxs[i].type == 'checkbox' && Boxs[i].checked == false) {
                    ChildsChkAll = false;
                }
            }
            parentChkBox.checked = ChildsChkAll;
            OnTreeNodeChildChecked(parentChkBox);
        }
    }
}


function killerrors() {
    return true;
}

window.onerror = killerrors;  