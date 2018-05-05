// JavaScript Document
	function setTab1(name,cursel,n){
		for(i=1;i<=n;i++){
		    if(i==cursel)
		        continue;
			var menu=document.getElementById(name+i);
			menu.className="";
			var styleName="li"+i;
			menu.className=styleName;
		}
		var t = document.getElementById(name+cursel);
		t.className="li"+cursel+" current"+cursel;
	}

