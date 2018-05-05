$(".nav").on("click","li",function(){
//         $(".sidebar .nav > li").each(function () {
//                $(this).removeClass("hasChild");
//            });
	$(this).siblings().removeClass("current");
	$(this).siblings().removeClass("hasChild");
	$(this).siblings().find(".subnav").fadeOut(50);
	if(!$(this).hasClass("hasChild"))
	{
	  $(this).toggleClass("hasChild");
	  $(this).find(".subnav").slideDown(600);
	}else
	{
	$(this).find(".subnav").fadeOut(500);
	$(this).removeClass("hasChild");
	}
//	var hasChild = !!$(this).find(".subnav").size();
//	if(hasChild){
//		$(this).toggleClass("hasChild");
//	}
	$(this).addClass("current");
});


$(window).resize(function(e) {
    $("#bd").height($(window).height() - $("#hd").height() - $("#ft").height()-6);
	$(".wrap").height($("#bd").height()-6);
	$(".nav").css("minHeight", $(".sidebar").height() - $(".sidebar-header").height()-1);
	$("#iframe").height($(window).height() - $("#hd").height() - $("#ft").height()-12);
}).resize();

$(".nav>li").css({"borderColor":"#dbe9f1"});
$(".nav>.current").prev().css({"borderColor":"#7ac47f"});
$(".nav").on("click","li",function(e){
	var aurl = $(this).find("a").attr("date-src");
	$("#iframe").attr("src",aurl);
	$(".nav>li").css({"borderColor":"#dbe9f1"});
	$(".nav>.current").prev().css({"borderColor":"#7ac47f"});
	return false;
});

$('.exitDialog').Dialog({
	title:'提示信息',
	autoOpen: false,
	width:400,
	height:200
	
});

$('.exit').click(function(){
	$('.exitDialog').Dialog('open');
});



$('.exitDialog input[type=button]').click(function(e) {
    $('.exitDialog').Dialog('close');
	
	if($(this).hasClass('ok')){
		window.location.href = "/Login/SignOut.aspx"	;
	}
});



 function say(url) {
          $(".nav  li ul li").each(function () {
              var aurl=$(this).find("a").attr("date-src");
               $(this).find("a").css("color", "black");
              if(aurl==url.pathname)
              {
                 $(this).find("a").css("color", "#FF6100");
              	 $(this).parent().parent().siblings().removeClass("current");
	             $(this).parent().parent().siblings().removeClass("hasChild");
	             $(this).parent().parent().siblings().find(".subnav").fadeOut(50);
	              if(!$(this).parent().parent().hasClass("hasChild"))
	                {
	                  $(this).parent().parent().toggleClass("hasChild");
	                  $(this).parent().parent().find(".subnav").slideDown(600);
	                }
//	                else
//	                {
//	                   $(this).parent().parent().find(".subnav").fadeOut(500);
//	                   $(this).parent().parent().removeClass("hasChild");
//	                }
	                $(this).parent().parent().addClass("current");
              }
            });
         } 