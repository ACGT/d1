// JavaScript Document最好写到HTML页面!!!!!!!!!!!!!!!!!!!!!!!!
	banner("slider1",//函数名
		   "1",//ul的ID的后面的数字-----id="slider1"
		   "#pagenavi",//分页按钮的ID
		   "#next",//next按钮的ID
		   "#prev"//prev按钮的ID
		   );
	banner("t2","2","#pagenavi2","#next2","#prev2");
	banner("t3","3","#pagenavi3","#next3","#prev3");

function banner(
				sliderTs, //函数名
				sliders,   //ul的ID的后面的数字
				Pagenavi, //分页按钮的ID
				Next,     //next按钮的ID
				Prev      //prev按钮的ID
				) {
	$(Next).click(function(){sliderTs.next();});
	$(Prev).click(function(){sliderTs.prev();});

    var num = 0;
    num = $("#slider" + sliders).children("li").length;
    var html = "";
    html = "<a href='javascript:void(0);' {c}>{i}</a>";
    var lasthtml,
    thtml;
    lasthtml = "";
	
	var $imgH = $(".swipe img").height();
	$(".swipe li").height($imgH);
	
    for (var i = 0; i < num; i++) {
        thtml = "";
        if (i == 0) {
            thtml = html.replace("{c}", "class='active' ");

        } else {
            thtml = html.replace("{c}", "");
        }
        thtml = thtml.replace("{i}", i + 1);
        lasthtml += thtml;
    };
    $(Pagenavi).html(lasthtml);
    var active = 0,
    as = $(Pagenavi).find("a");
    for (var i = 0; i < as.length; i++) {
        (function() {
            var j = i;
            as[i].onclick = function() {
                sliderTs.slide(j);
                return false;
            }
        })();

    }
	var sliderTs=new TouchSlider("slider" + sliders,{
		duration:600, 
		direction:0, 
		interval:3000,//间隔时间
		fullsize:true,
		autoplay:true,
	});
	sliderTs.on('before',function(m,n){
        as[m].className='';
        as[n].className='active';
    });	
	setTimeout(function(){sliderTs.resize();},100);
};
