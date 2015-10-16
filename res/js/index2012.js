function startmarquee(lh,speed,delay,index){ 

var t; 
var p=false; 
var o=document.getElementById("scrollnews"); 
 
o.innerHTML+=o.innerHTML; 
o.onmouseover=function(){p=true} 

o.onmouseout=function(){p=false} 

o.scrollTop = 0; 

function start(){ 
t=setInterval(scrolling,speed); //每隔一段时间，setInterval便会执行一次 

if(!p){ o.scrollTop += 1;} 

} 
function scrolling(){ 
if(o.scrollTop%lh!=0){ 

o.scrollTop += 1; 
if(o.scrollTop>=o.scrollHeight/2) o.scrollTop = 0; 


}else{ 
clearInterval(t); 

setTimeout(start,delay); 

} 
} 
setTimeout(start,delay); //第一次启动滚动；setTimeout会在一定的时间后执行函数start()，且只执行一次 
} 
//传递参数 
 
//带停顿效果 
//startmarquee(25,40,0,1); 



function AutoScroll(obj){
        $(obj).animate({
                marginTop:"-19px"
        },1000,function(){
                $(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
        });
}


function ShowCenter1(imglist, alist) {
    var images = imglist.split(",");
    var urls = alist.split("|");

//    var images = ['../../images/images/scrollimgtest.jpg', '../../images/images/scrollimgtest.jpg', '../../images/images/scrollimgtest.jpg', '../../images/images/scrollimgtest.jpg', '../../images/images/scrollimgtest.jpg'];
//    var urls = ['#', '#', '#', '#', '#'];
    var widths = 703; var heights = 336; var times = 2000;
    for (i = 0; i < images.length; i++) { eval('img' + i + '=new Image ();img' + i + '.src="' + images[i] + '";'); }
    document.write('<div class="container" id="CenterImg1"  style="width:' + widths + 'px;height:' + heights + 'px; margin:0px auto;">');
    document.write('<table id="ImgTable1" border="0" cellpadding="0" cellspacing="0"><tr>');
    for (i = 0; i < images.length; i++) { document.write('<td><a href="' + urls[i] + '" target="_blank"><img src="' + images[i] + '" width=' + widths + ' height=' + heights + ' /></a></td>'); }
    document.write('</tr></table><ul class="num" id="idNum1"></ul></div>');
    var st = new SlideTrans1("CenterImg1", "ImgTable1", i, times, { Vertical: false });
    var forEach = function(array, callback, thisObject) {
        if (array.forEach) { array.forEach(callback, thisObject); }
        else { for (var i = 0, len = array.length; i < len; i++) { callback.call(thisObject, array[i], i, array); } }
    }
    var nums = [];
    for (var i = 0, n = st._count - 1; i <= n; ) { (nums[i] = $w("idNum1").appendChild(document.createElement("li"))).innerHTML = ++i; }
    forEach(nums, function(o, i) {
        o.onmouseover = function() { o.className = "on"; st.Auto = false; st.Run(i); }
        o.onmouseout = function() { o.className = ""; st.Auto = true; st.Run(); }
    })
    st.onStart = function() { forEach(nums, function(o, i) { o.className = st.Index == i ? "on" : ""; }) }
    st.Run();

}
var $w = function(id) { return "string" == typeof id ? document.getElementById(id) : id; };
var Extend = function(destination, source) { for (var property in source) { destination[property] = source[property]; } return destination; }
var CurrentStyle = function(element) { return element.currentStyle || document.defaultView.getComputedStyle(element, null); }
var Bind = function(object, fun) { var args = Array.prototype.slice.call(arguments).slice(2); return function() { return fun.apply(object, args.concat(Array.prototype.slice.call(arguments))); } }

var Tween = {
    Quart: {
        easeOut: function(t, b, c, d) {
            return -c * ((t = t / d - 1) * t * t * t - 1) + b;
        }
    },
    Back: {
        easeOut: function(t, b, c, d, s) {
            if (s == undefined) s = 1.70158;
            return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
        }
    },
    Bounce: {
        easeOut: function(t, b, c, d) {
            if ((t /= d) < (1 / 2.75)) {
                return c * (7.5625 * t * t) + b;
            } else if (t < (2 / 2.75)) {
                return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
            } else if (t < (2.5 / 2.75)) {
                return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
            } else {
                return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;
            }
        }
    }
}


//容器对象,滑动对象,切换数量
var SlideTrans1 = function(container, slider, count, times, options) {

    this._slider = $w(slider);
    this._container = $w(container); //容器对象
    this._timer = null; //定时器
    this._count = Math.abs(count); //切换数量
    this._target = 0; //目标值
    this._t = this._b = this._c = 0; //tween参数
    this.Index = 0; //当前索引

    this.SetOptions(options);

    this.Auto = !!this.options.Auto;
    this.Duration = Math.abs(this.options.Duration);
    this.Time = Math.abs(this.options.Time);
    if (times) this.Pause = times;
    else this.Pause = Math.abs(this.options.Pause);

    this.Tween = this.options.Tween;
    this.onStart = this.options.onStart;
    this.onFinish = this.options.onFinish;

    var bVertical = !!this.options.Vertical;
    this._css = bVertical ? "top" : "left"; //方向

    //样式设置
    var p = CurrentStyle(this._container).position;
    p == "relative" || p == "absolute" || (this._container.style.position = "relative");
    this._container.style.overflow = "hidden";
    this._slider.style.position = "absolute";

    this.Change = this.options.Change ? this.options.Change :
	this._slider[bVertical ? "offsetHeight" : "offsetWidth"] / this._count;
};
SlideTrans1.prototype = {
    //设置默认属性
    SetOptions: function(options) {
        this.options = {//默认值
            Vertical: true, //是否垂直方向（方向不能改）
            Auto: true, //是否自动
            Change: 0, //改变量
            Duration: 100, //滑动持续时间
            Time: 10, //滑动延时
            Pause: 4000, //停顿时间(Auto为true时有效)
            onStart: function() { }, //开始转换时执行
            onFinish: function() { }, //完成转换时执行
            Tween: Tween.Quart.easeOut//tween算子
        };
        Extend(this.options, options || {});
    },
    //开始切换
    Run: function(index) {
        //修正index
    	
        index == undefined && (index = this.Index);
        index < 0 && (index = this._count - 1) || index >= this._count && (index = 0);
        //设置参数
        
        this._target = -Math.abs(703) * (this.Index = index);
       
        this._t = 0;
        this._b = parseInt(CurrentStyle(this._slider)[this.options.Vertical ? "top" : "left"]);
        this._c = this._target - this._b;

        this.onStart();
        this.Move();
    },
    //移动
    Move: function() {
        clearTimeout(this._timer);
        //未到达目标继续移动否则进行下一次滑动
        if (this._c && this._t < this.Duration) {
            this.MoveTo(Math.round(this.Tween(this._t++, this._b, this._c, this.Duration)));
            this._timer = setTimeout(Bind(this, this.Move), this.Time);
        } else {
            this.MoveTo(this._target);
            this.Auto && (this._timer = setTimeout(Bind(this, this.Next), this.Pause));
        }
    },
    //移动到
    MoveTo: function(i) {
        this._slider.style[this._css] = i + "px";
    },
    //下一个
    Next: function() {
    	
        this.Run(++this.Index);
    },
    //上一个
    Previous: function() {
        this.Run(--this.Index);
    },
    //停止
    Stop: function() {
        clearTimeout(this._timer); this.MoveTo(this._target);
    }
}


function tagscroll(obj)
{
	var sWidth = $(obj).width();
	var len = $(obj+" ul li").length; 
	
	var index = 0;
	var picTimer;
	
	//上一页按钮
	$(obj+" .pre2012").click(function() {
		index -= 1;
		if(index == -1) {index = len - 1;}
		showPics(index);
	});

	//下一页按钮
	$(obj+" .next2012").click(function() {
		index += 1;
		if(index == len) {index = 0;}
		showPics(index);
	});

	
	$(obj+" ul").css("width",sWidth * (len));
	
	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
	$(obj).hover(function() {
		clearInterval(picTimer);
	},function() {
		picTimer = setInterval(function() {
			showPics(index);
			index++;
			if(index == len) {index = 0;}
		},4000); 
	}).trigger("mouseleave");
	
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换
		var nowLeft = -index*sWidth; //根据index值计算ul元素的left值
		//alert(obj+" ul");

		$(obj+" ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		
	}
}

function tagscroll1(obj)
{
	var sWidth = $(obj).width()-24;
	var len = $(obj+" ul li").length; 
	
	if(len%5>0)
		{
		len=Math.round(len/5)+1;
		}
	else
		{
		len=Math.round(len/5);
		}
	
	var index = 0;
	var picTimer;
	
	//上一页按钮
	$(obj+" .pre2012").click(function() {
		index -= 1;
		//if(index == -1) {index = len - 1;}
		if(index==-1){ index=len-1;}
		showPics(index);
	});

	//下一页按钮
	$(obj+" .next2012").click(function() {
		index += 1;
		if(index == len) {index = 0;}
		
		showPics(index);
	});

	
	$(obj+" ul").css("width",sWidth * (len));
	
	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
	$(obj).hover(function() {
		clearInterval(picTimer);
	},function() {
		picTimer = setInterval(function() {
			showPics(index);
			index++;
			if(index == len) {index = 0;}
		},4000); 
	}).trigger("mouseleave");
	
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换
		var nowLeft = -index*sWidth; //根据index值计算ul元素的left值
		//alert(obj+" ul");

		$(obj+" ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		
	}
}

function overcate(obj,flag)
{
	
	 if($("#catdiv_"+flag).css('display')=='none')
	   {
	   $("#catdiv_"+flag).css("display","block");
	   
	   }
	 $(obj).addClass("sdiv2012"+flag);
	 $("#simg"+flag).attr("src", "http://images.d1.com.cn/images2012/index2012/logo/logob_0"+flag+".jpg"); 
    }
function outcate(obj,flag)
{
	 if($("#catdiv_"+flag).css('display')=='block')
	   {
	      $("#catdiv_"+flag).css("display","none");
	   }
	
		 $(obj).removeClass("sdiv2012"+flag).addClass("sdiv2012_"+flag);
		 $("#simg"+flag).attr("src", "http://images.d1.com.cn/images2012/index2012/logo/logo_0"+flag+".jpg"); 
		   
	}

function getTag2012(){
	var tag=$('#tagtest');

    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/html/getTag.jsp",
        cache: false,
        data:{},
        error: function(XmlHttpRequest){
           alert(XmlHttpRequest.status);
        },
        success: function(json){
        	tag.removeClass('tagtest');
        	tag.html(json.message);
        },beforeSend: function(){
           
            tag.addClass('tagtest');
            tag.attr('value', '加载中,请稍等...');
        },complete: function(json){
        	
        	 //tag.removeClass('tagtest');
        	 //tag.html(json.message);
        }
    });
}

function check_gdscoll(obj) {
	var pktsel = $(".a");
    if(pktsel.length < 1){
    	alert("没有任何组合商品！");
        return;
    }
   
    var arr = new Array();
    pktsel.each(function(i){
		arr[i] = $(this).val();
	});
   
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}

function addflow(obj) {
	var pktsel = $(".a");
    if(pktsel.length < 1){
    	alert("没有任何组合商品！");
        return;
    }
   
    var arr = new Array();
    pktsel.each(function(i){
		arr[i] = $(this).val();
	});
    //判断其他配件
    var pktsel1 = $("input[type='checkbox'][name='chk']:checked");
    if(pktsel1.length >0){    	
    	 pktsel1.each(function(j){
    			arr[pktsel.length+j] = $(this).val();
    		});
    }     
   
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}


function selectInit(mPrice,value) {
    var memberP = $("#memberP");
    var cheap = $("#cheap");
    var pktP = $("#pktP");
    var mm=$("#memberP");
    var amount=$("#amount");
    //var pPrice=parseInt(mPrice*0.95);
    if (value == false) {    	
    	memberP.html(formatNum(Number(memberP.html()) - Number(mPrice),2));
    	pktP.html(Number(pktP.html())-parseInt(mPrice*0.95));
    	amount.html(Number(amount.html())-1);
    }
    else {
    	memberP.html(formatNum(Number(memberP.html()) + Number(mPrice),2));
    	pktP.html(Number(pktP.html())+parseInt(mPrice*0.95));
    	amount.html(Number(amount.html())+1);
    }
    cheap.html(formatNum(Number(memberP.html()) - Number(pktP.html()),2));
 
}
//搭配加到购物车

function AddGdscollInCart(obj){
	var productid=$(obj).attr("attr");
	if(productid==null)
		{
		   $.alert('加入购物车的商品不存在！');
		   return;
		}
	$.inCart(obj,{ajaxUrl:'/ajax/flow/productInCart.jsp',width:400,align:'center'});
}
function gdscollover()
{
	   
	   if($('#otherpj')!=null)
		   {
		       $('#otherpj').css('display','block');
		   }
	   
}
function gdscollout()
{
	   if($('#otherpj')!=null)
	   {
	   $('#otherpj').css('display','none');
	   }
	   
}
function getindexp(gdsid,w,flag,left,position,endtop)
{
	var obj=$("#div_"+flag);
	if(obj!=null)
	{       
		    $(obj).html("");
		    $(obj).css("left","");
		    $(obj).css("top","");
		    $(obj).css("bottom","");
		    $(obj).css("background-color","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:100px; margin-top:100px; \"/>");
			$.post("/html/getindexp.jsp",{"gdsid":gdsid,w:w,flag:flag},function(data){
			$(obj).html(data);
	
				if(flag==1||flag==2||flag==3||flag==4)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png";
						}
						else
						{
						   bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm.png";
						}
					}

					if(flag==8||flag==9||flag==10)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/sheromo1.png";
						}
						else
						{
						   bg="http://images.d1.com.cn/images2012/index2012/JULY/sheromo.png";
						}
						
					}
					if(flag==5||flag==6||flag==7)
					{
						if(w>784)
						{
							bg="http://images.d1.com.cn/images2012/index2012/JULY/aleeishe1.png";
						}
						else
						{
						    bg="http://images.d1.com.cn/images2012/index2012/JULY/aleeishe.png";
						}
						
					}
					for(var i=1;i<=10;i++)
					{
						var obj1=$("#div_"+i);
						if(obj1!=null&&i!=flag)
							{
							  obj1.css("display","none");
							}
					}
				
				$(obj).css("left",left);
				$(obj).css(position,endtop);
				$(obj).css("background","url('"+bg+"')");
				$(obj).css("display","block");
				//$(obj).removeClass("floatdp");
				//$(obj).addClass("floatdp1");
				//$(obj).css("top",$("#da"+count).offset().top+document.documentElement.scrollTop);
		
			});
	
    }
}


function mdmoverf(flag)
{
	var obj=$("#div_"+flag);
	obj.css("display","block");
}


 function mdmoutf(flag)
{
	 var obj=$("#div_"+flag);
		obj.css("display","none");
}
function mdmoverf1(gdsid,w,flag,left,position,endtop)
{
	var obj=$("#div_"+flag);
	if(obj!=null)
		{
		   getindexp(gdsid,w,flag,left,position,endtop);
		}
    
}
