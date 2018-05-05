/**************************************************   
名称: 图片轮播类 
示例:   
页面中已经存在名为imgPlayer(或者别的ID也行)的节点.   
PImgPlayer.addItem( "test", "http://www.test.com", "http://www.test.com/images/wy.jpg");   
PImgPlayer.addItem( "test2", "http://www.test.com", "http://www.test.com/images/wy.jpg");   
PImgPlayer.addItem( "test3", "http://www.test.com", "http://www.test.com/images/wy.jpg");   
PImgPlayer.init( "imgPlayer", 200, 230 );   
备注:   
适用于一个页面只有一个图片轮播的地方.   
***************************************************/
var PImgPlayer = {
    _timer: null,
    _items: [],
    _container: null,
    _index: 0,
    _imgs: [],
    intervalTime: 8000,        //轮播间隔时间   
    init: function(objID, w, h, time) {
        this.intervalTime = time || this.intervalTime;
        this._container = document.getElementById(objID);
        this._container.style.display = "block";
        this._container.style.width = w + "px";
        this._container.style.height = h + "px";
        this._container.style.position = "relative";
        this._container.style.overflow = "hidden";
        //this._container.style.border = "1px solid #000";   
        var linkStyle = "display: block; TEXT-DECORATION: none;";
        if (document.all) {
            linkStyle += "FILTER:";
            linkStyle += "progid:DXImageTransform.Microsoft.Barn(duration=0.5, motion='out', orientation='vertical') ";
            linkStyle += "progid:DXImageTransform.Microsoft.Barn ( duration=0.5,motion='out',orientation='horizontal') ";
            linkStyle += "progid:DXImageTransform.Microsoft.Blinds ( duration=0.5,bands=10,Direction='down' )";
            linkStyle += "progid:DXImageTransform.Microsoft.CheckerBoard()";
            linkStyle += "progid:DXImageTransform.Microsoft.Fade(duration=0.5,overlap=0)";
            linkStyle += "progid:DXImageTransform.Microsoft.GradientWipe ( duration=1,gradientSize=1.0,motion='reverse' )";
            linkStyle += "progid:DXImageTransform.Microsoft.Inset ()";
            linkStyle += "progid:DXImageTransform.Microsoft.Iris ( duration=1,irisStyle=PLUS,motion=out )";
            linkStyle += "progid:DXImageTransform.Microsoft.Iris ( duration=1,irisStyle=PLUS,motion=in )";
            linkStyle += "progid:DXImageTransform.Microsoft.Iris ( duration=1,irisStyle=DIAMOND,motion=in )";
            linkStyle += "progid:DXImageTransform.Microsoft.Iris ( duration=1,irisStyle=SQUARE,motion=in )";
            linkStyle += "progid:DXImageTransform.Microsoft.Iris ( duration=0.5,irisStyle=STAR,motion=in )";
            linkStyle += "progid:DXImageTransform.Microsoft.RadialWipe ( duration=0.5,wipeStyle=CLOCK )";
            linkStyle += "progid:DXImageTransform.Microsoft.RadialWipe ( duration=0.5,wipeStyle=WEDGE )";
            linkStyle += "progid:DXImageTransform.Microsoft.RandomBars ( duration=0.5,orientation=horizontal )";
            linkStyle += "progid:DXImageTransform.Microsoft.RandomBars ( duration=0.5,orientation=vertical )";
            linkStyle += "progid:DXImageTransform.Microsoft.RandomDissolve ()";
            linkStyle += "progid:DXImageTransform.Microsoft.Spiral ( duration=0.5,gridSizeX=16,gridSizeY=16 )";
            linkStyle += "progid:DXImageTransform.Microsoft.Stretch ( duration=0.5,stretchStyle=PUSH )";
            linkStyle += "progid:DXImageTransform.Microsoft.Strips ( duration=0.5,motion=rightdown )";
            linkStyle += "progid:DXImageTransform.Microsoft.Wheel ( duration=0.5,spokes=8 )";
            linkStyle += "progid:DXImageTransform.Microsoft.Zigzag ( duration=0.5,gridSizeX=4,gridSizeY=40 ); width: 100%; height: 100%";
        }
        //   

        //   
        var html = "<div style=\"" + linkStyle + "\"></div>";
        this._container.innerHTML = html;
        var link = this._container.getElementsByTagName("div")[0];
        link.style.width = w + "px";
        link.style.height = h + "px";
        link.style.background = 'url(' + this._items[0].img + ') no-repeat center top';
        //   
        this._timer = setInterval("PImgPlayer.play()", this.intervalTime);
    },
    addItem: function(_title, _link, _imgURL) {
        this._items.push({ title: _title, link: _link, img: _imgURL });
        var img = new Image();
        img.src = _imgURL;
        this._imgs.push(img);
    },
    play: function(index) {
        if (index != null) {
            this._index = index;
            clearInterval(this._timer);
            this._timer = setInterval("PImgPlayer.play()", this.intervalTime);
        } else {
            this._index = this._index < this._items.length - 1 ? this._index + 1 : 0;
        }
        var link = this._container.getElementsByTagName("div")[0];
        if (link.filters) {
            var ren = Math.floor(Math.random() * (link.filters.length));
            link.filters[ren].Apply();
            link.filters[ren].play();
        }
        // link.title = this._items[this._index].title;   
        link.style.background = 'url(' + this._items[this._index].img + ') no-repeat center top';

        //// title
        //var title = this._container.getElementsByTagName("h1")[0];     

        //               

    }
} 