<!--
function document.oncontextmenu(){event.returnValue=false;}//ÆÁ±ÎÊó±êÓÒ¼ü
function window.onhelp(){return false} //ÆÁ±ÎF1°ïÖú
function document.onkeydown()
{
  if ((window.event.altKey)&&
      ((window.event.keyCode==37)||   //ÆÁ±Î Alt+ ·½Ïò¼ü ¡û
       (window.event.keyCode==39)))   //ÆÁ±Î Alt+ ·½Ïò¼ü ¡ú
  {
     window.close();
     event.returnValue=false;
  }
  if ((event.keyCode==116)||                 //ÆÁ±Î F5 Ë¢ÐÂ¼ü
      (event.keyCode==117)||                 //ÆÁ±Î F6 Ë¢ÐÂ¼ü
      (event.keyCode==114)||                 //ÆÁ±Î F3 Ë¢ÐÂ¼ü
      (event.ctrlKey && event.keyCode==82)){ //Ctrl + R
     event.keyCode=0;
     event.returnValue=false;
     }
  if (event.keyCode==122){event.keyCode=0;event.returnValue=false;}  //ÆÁ±ÎF11
  if (event.ctrlKey && event.keyCode==78) event.returnValue=false;   //ÆÁ±Î Ctrl+n
  //if (event.shiftKey && event.keyCode==121)event.returnValue=false;  //ÆÁ±Î shift+F10
  //if (window.event.srcElement.tagName == "A" && window.event.shiftKey)
  //   window.event.returnValue = false;             //ÆÁ±Î shift ¼ÓÊó±ê×ó¼üÐÂ¿ªÒ»ÍøÒ³
  if ((window.event.altKey)&&(window.event.keyCode==115))             //ÆÁ±ÎAlt+F4
  {
      window.showModelessDialog("about:blank","","dialogWidth:1px;dialogheight:1px");
      return false;
  }
}
-->
