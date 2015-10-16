function check_gdscoll(obj,flag) {
	var pktsel = $(".a"+flag);
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

function check_gdscoll1(obj,flag) {
	var pktsel = $(".a"+flag);
    if(pktsel.length < 1){
    	alert("没有任何组合商品！");
        return;
    }
   
    var arr = new Array();
    pktsel.each(function(i){
		arr[i] = $(this).val();
	});
    //判断其他配件
    var pktsel1 = $("input[type='checkbox'][name='chk_"+flag+"']:checked");
    if(pktsel1.length >0){    	
    	 pktsel1.each(function(j){
    			arr[pktsel.length+j] = $(this).val();
    		});
    }  
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}

//最佳组合JS
function selectInitdp(mPrice,value,flag) {
	var zk=0.95;
    var memberP = $("#memberP"+flag);
    var cheap = $("#cheap" + flag);
    var pktP = $("#pktP" + flag);
    var mm=$("#memberP"+flag);
    var amount=$("#amount"+flag);
    //var pPrice=parseInt(mPrice*0.95);
    if (value == false) {    	
    	memberP.html(formatNum(Number(memberP.html()) - Number(mPrice),2));
    	pktP.html(Number(pktP.html())-parseInt(mPrice*zk));
    	amount.html(Number(amount.html())-1);
    }
    else {
    	memberP.html(formatNum(Number(memberP.html()) + Number(mPrice),2));
    	pktP.html(Number(pktP.html())+parseInt(mPrice*zk));
    	amount.html(Number(amount.html())+1);
    }
    cheap.html(formatNum(Number(memberP.html()) - Number(pktP.html()),2));
 
}

function selectInitdp1211(mPrice,value,flag,id) {
	var zk=0.95;
    var memberP = $("#memberP"+flag);
    var cheap = $("#cheap" + flag);
    var pktP = $("#pktP" + flag);
    var mm=$("#memberP"+flag);
    var amount=$("#amount"+flag);
    var s=$('#span'+id+flag);
    //var pPrice=parseInt(mPrice*0.95);
    if (value == false) {    	
    	memberP.html(formatNum(Number(memberP.html()) - Number(mPrice),2));
    	pktP.html(Number(pktP.html())-parseInt(mPrice*zk));
    	amount.html(Number(amount.html())-1);
    	s.css('display','block');
    }
    else {
    	memberP.html(formatNum(Number(memberP.html()) + Number(mPrice),2));
    	pktP.html(Number(pktP.html())+parseInt(mPrice*zk));
    	amount.html(Number(amount.html())+1);
    	s.css('display','none');
    }
    cheap.html(formatNum(Number(memberP.html()) - Number(pktP.html()),2));
 
}

function gdscollover(flag)
{
	   
	   if($('#other_'+flag)!=null)
		   {
		       $('#other_'+flag).css('display','block');
		   }
	   
}
function gdscollout(flag)
{
	   if($('#other_'+flag)!=null)
	   {
	   $('#other_'+flag).css('display','none');
	   }
	   
}
$(function() {
	var sWidth = $("#focus1").width();
	
	var len = parseInt($("#focus ul li").length/5); 
	if($("#focus ul li").length%5>0)
	{
	    len=len+1;
	}	
	var index = 0;
	var picTimer;
	
	//上一页按钮
	$("#focus .pre2012").click(function() {
		index -= 1;
		if(index == -1) {index = len - 1;}
		showPics(index);
	});

	//下一页按钮
	$("#focus .next2012").click(function() {
		index += 1;
		if(index == len) {index = 0;}
		showPics(index);
	});

	
	$("#focus div ul").css("width",sWidth * (len)+100);
	
	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
	$("#focus").hover(function() {
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
		
		$("#focus ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		
	}
});
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
function gdscollover1(obj,flag,overcolor)
{
	   $(obj).css('background','#'+overcolor);
	   if($('#gwx_'+flag)!=null)
		   {
		       $('#gwx_'+flag).css('display','block');
		   }
	   if($('#fav_'+flag)!=null)
	   {
	        $('#fav_'+flag).css('display','block');
	   }
	   if($('#sq_')+flag!=null)
		   {
		       $('#sq_'+flag).css('display','block');
		   }
}
function gdscollout1(obj,flag)
{
	   $(obj).css('background','');
	   if($('#gwx_'+flag)!=null)
	   {
	   $('#gwx_'+flag).css('display','none');
	   }
	   if($('#fav_'+flag)!=null)
	   {
	   $('#fav_'+flag).css('display','none');
	   }
	   if($('#sq_')+flag!=null)
	   {
	       $('#sq_'+flag).css('display','none');
	   }
}
function ccdzb(flag)
{
	 var obj=$("#ccdzb_img"+flag);
	 if(obj!=null)
		 {
		    obj.css("display","block");
		 }
	 
	}
function ccdzb1(flag)
{
	 var obj=$("#ccdzb_img"+flag);
	 if(obj!=null)
		 {
		    obj.css("display","none");
		 }
	 
	}
function choosedp(mPrice,value,flag) {
    var memberP = $("#memberPs"+flag);
    var cheap = $("#cheaps" + flag);
    var pktP = $("#pktPs" + flag);
    var mm=$("#memberPs"+flag);
    var amount=$("#amounts"+flag);
    //alert(memberP.val());
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
function add_gdscoll1(obj,flag)
{
    var arr = new Array();
    var pktsel1 = $("input[type='checkbox'][name='chks_"+flag+"']:checked");
    if(pktsel1.length<2)
    	{
    	   alert("请至少选择两个商品！");
    	   return;
    	}
    if(pktsel1.length >0){    	
    	 pktsel1.each(function(j){
    			arr[j] = $(this).val();
    		});
    }  
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}
function g_productscoll(obj,obj1){
	var sWidth = $(obj1).width();
	
	var len = parseInt($(obj+" ul li").length/4); 
	if($(obj+" ul li").length%4>0)
	{
	    len=len+1;
	}	
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

	
	$(obj+" div ul").css("width",sWidth * (len)+100);
	
	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
	//$("#focus").hover(function() {
		//clearInterval(picTimer);
	//},function() {
		//picTimer = setInterval(function() {
			//showPics(index);
			//index++;
			//if(index == len) {index = 0;}
		//},4000); 
	//}).trigger("mouseleave");
	
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换
	  
	      var nowLeft = -index*sWidth; //根据index值计算ul元素的left值 
		
		$(obj+" ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		
	}
}
function check_gdscoll20120710(obj,flag)
{
	
    var arr = new Array();
   
    //判断其他配件
    var pktsel1 = $("input[type='checkbox'][name='chk_"+flag+"']:checked");
    if(pktsel1.length >0){    	
    	 pktsel1.each(function(j){
    			arr[j] = $(this).val();
    		});
    }  
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});

}

function scoll0718t(flag,obj1)
{
	var obj=$('#scolllist'+flag);
    var sWidth = $('#scolllist'+flag).height();
	var hidden=$('#hidden'+flag);
	var len = parseInt($('#scolllist'+flag+' ul li').length/4); 
	if($('#scolllist'+flag+" ul li").length%4>0)
	{
	    len=len+1;
	}	
	var index =parseInt(hidden.attr("attr"));
	index -= 1;
	if(index <= -1) {index = len - 1;}
	showPics(index);
	hidden.attr("attr",index);
	$('#scolllist'+flag+" div ul").css("width",sWidth * (len)+100);
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换	  
	    var nowLeft = -index*sWidth; //根据index值计算ul元素的left值 
	    $('#scolllist'+flag+" ul").stop(true,false).animate({"top":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
   }
}

function scoll0718b(flag,obj1)
{
	var obj=$('#scolllist'+flag);
    var sWidth = $('#scolllist'+flag).height();
	var hidden=$('#hidden'+flag);
	var len = parseInt($('#scolllist'+flag+' ul li').length/4); 
	if($('#scolllist'+flag+" ul li").length%4>0)
	{
	    len=len+1;
	}	
	var index =parseInt(hidden.attr("attr"));
	index += 1;
	if(index >= len) {index = 0;}
	showPics(index);
	hidden.attr("attr",index);
	
		$('#scolllist'+flag+" div ul").css("width",sWidth * (len)+100);
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换	  
	    var nowLeft = -index*sWidth; //根据index值计算ul元素的left值 
	    $('#scolllist'+flag+" ul").stop(true,false).animate({"top":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		
	}
}


function scoll1119zt(flag,obj1)
{
	var obj=$('#scolllist'+flag);
    var sWidth = $('#scolllist'+flag).height();
	var hidden=$('#hidden'+flag);
	var len = parseInt($('#scolllist'+flag+' ul li').length/3); 
	if($('#scolllist'+flag+" ul li").length%3>0)
	{
	    len=len+1;
	}	
	var index =parseInt(hidden.attr("attr"));
	index += 1;
	if(index >= len) {index = 0;}
	showPics(index);
	hidden.attr("attr",index);
	
		$('#scolllist'+flag+" div ul").css("width",sWidth * (len)+100);
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换	  
	    var nowLeft = -index*sWidth; //根据index值计算ul元素的left值 
	    $('#scolllist'+flag+" ul").stop(true,false).animate({"top":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		
	}
}
