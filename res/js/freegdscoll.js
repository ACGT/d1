
 
var m=-1; //第i+1个tab开始
var i=-1;
var y=-1;
var j=-1; //第i+1个tab开始
var k=-1; //第i+1个tab开始
var l=-1; //第i+1个tab开始
var x=-1; //第i+1个tab开始
var a=-1;
var b=-1;
var c=-1;




var offset = 2000; //轮换时间
var offset1 = 2000; //轮换时间
var offset2 = 2000; //轮换时间
var offset3 = 2000; //轮换时间
var offset4 = 3000; //轮换时间

var offsetxpqx = 3000; //轮换时间

var timer = null;
var timer1 = null;
var timer2 = null;
var timer3 = null;
var timer4 = null;

var timerxpqx = null;

function autoroll(){
 n = $('.cbox1 li').length-1;
 slide(n);
    //timer = window.setTimeout(autoroll, offset);
 }
function autoroll2(){
	 n = $('.cbox2 li').length-1;
	 slide2(n);
}
function autoroll3(){
	 n = $('.cbox3 li').length-1;
	 slide3(n);
}
function autoroll4(){
	 n = $('.cbox4 li').length-1;
	 slide4(n);
}


function autoroll5(){
	 n = $('.cbox5 li').length-1;	 
	 slide5(n);
}


function autoroll6(){
	 n = $('.cbox6 li').length-1;
	 slide6(n);
}
function autoroll7(){
	 n = $('.cbox7 li').length-1;
	 slide7(n);
}
function autoroll8(){
	 n = $('.cbox8 li').length-1;
	slide8(n);
}
function autoroll9(){
	 n = $('.cbox9 li').length-1;
	 slide9(n);
}

function slide(i){
 $('.cbox1 li').eq(i).addClass('current').siblings().removeClass('current');
 $('.imgbox1 li').eq(i).css('display','block').siblings('li').css('display','none');
 
 }
function slide2(i){
	 $('.cbox2 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox2 li').eq(i).css('display','block').siblings('li').css('display','none');
}
function slide3(i){
	 $('.cbox3 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox3 li').eq(i).css('display','block').siblings('li').css('display','none');
}
function slide4(i){
	 $('.cbox4 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox4 li').eq(i).css('display','block').siblings('li').css('display','none');
}

function slide5(i){
	 $('.cbox5 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox5 li').eq(i).css('display','block').siblings('li').css('display','none');
}


function slide6(i){
	 $('.cbox6 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox6 li').eq(i).css('display','block').siblings('li').css('display','none');
}
function slide7(i){
	 $('.cbox7 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox7 li').eq(i).css('display','block').siblings('li').css('display','none');
}
function slide8(i){
	 $('.cbox8 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox8 li').eq(i).css('display','block').siblings('li').css('display','none');
}
function slide9(i){
	 $('.cbox9 li').eq(i).addClass('current').siblings().removeClass('current');
	 $('.imgbox9 li').eq(i).css('display','block').siblings('li').css('display','none');
}

function hookThumb(){    
 $('.cbox1 li').click(
	  function () {
	    //if (timer) {
	   // clearTimeout(timer);
	    i = $(this).prevAll().length;
	    slide(i); 
	    //        }
	//  },
	 // function () {
	      
	            //timer = window.setTimeout(autoroll, offset);  
	           // this.blur();            
	          //  return false;
	  }
 ); 
 $('.imgbox1 li').hover(
		  function () {
		   
		    i = $(this).prevAll().length;
		             slide(i); 
		  }
		); 
}
function hookThumb2(){    
	 $('.cbox2 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide2(i); 
	 }
		 ); 
		 $('.imgbox2 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide2(i); 
				  }
		); 
}
function hookThumb3(){    
	 $('.cbox3 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide3(i); 
	 }
		 ); 
		 $('.imgbox3 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				          slide3(i); 
				  }
		); 
}
function hookThumb4(){    
	 $('.cbox4 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide4(i); 
	 }
		 ); 
		 $('.imgbox4 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide4(i); 
				  }
		); 
}
function hookThumb5(){    
	 $('.cbox5 li').click(
			  function () {			   
			    i = $(this).prevAll().length;			   
			    slide5(i); 
	 }
		 ); 
		 $('.imgbox5 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide5(i); 
				  }
		); 
}
function hookThumb6(){    
	 $('.cbox6 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide6(i); 
	 }
		 ); 
		 $('.imgbox6 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide6(i); 
				  }
		); 
}
function hookThumb7(){    
	 $('.cbox7 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide7(i); 
	 }
		 ); 
		 $('.imgbox7 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide7(i); 
				  }
		); 
}
function hookThumb8(){    
	 $('.cbox8 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide8(i); 
	 }
		 ); 
		 $('.imgbox8 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide8(i); 
				  }
		); 
}
function hookThumb9(){    
	 $('.cbox9 li').click(
			  function () {			   
			    i = $(this).prevAll().length;
			    slide9(i); 
	 }
		 ); 
		 $('.imgbox9 li').hover(
				  function () {
					  i = $(this).prevAll().length;
				             slide9(i); 
				  }
		); 
}

//填充图片
function AddImg(obj){
   var id=$(obj).attr("code");
   var flag=$(obj).attr("attr");
   var objs=$('.imgbox'+flag+' li .qba' );
   var cflag=$("#caflag").val();
   var mm=0;
   if(objs.length>0){
	   $(objs).each(function(i){
		   
		   if($(this).attr('attr').substr(0,8)==id){
			   //alert($(this).attr('attr').substr(0,8));
			   if(cflag!=1){
			      $('.cbox'+flag).find('li:last').remove();
			   }
			   mm=1;
			   alert("该商品已经添加过了，继续添加其他商品吧！");	
			  
		   }
		  
	   });	  
   }

   if(mm==0){
   var csflag=$("#caflag").val();
   $.ajax({
	   type: "post",
        dataType: "json",
        url: "/gdscoll/GetImg.jsp",
        cache: false,
        data:{'id':id,'flag':flag},
        error: function(XmlHttpRequest){
           alert(XmlHttpRequest.status);
        },
        success: function(json){	
        	if(json.succ){
	        	$("#box"+flag).css("background","none");
	        	var len=$(".imgbox"+flag+' li').length;
	        	
	        	if(len>=3&&csflag!=1){
	        		$.alert("对不起，该类别的商品只能添加三个！");
	        		return;
	            }
	        	
	        	
	        	if(csflag==1){
	        		//切换图片
	        		$(".imgbox"+flag).find('li').each(function(){
	        	   		if($(this).css('display')=='block'){
	        	   			$(this).remove();
	        	   		}
	        	   		
	        	   	});
	        		var mes=$(".imgbox"+flag).html();
		        	$(".imgbox"+flag).html('');
		        	$(".imgbox"+flag).append(mes+json.message);
	        	}
	        	else
	        	{
	        		//添加图片
		        	$("#add"+flag).css('display','none');
		            $("#wz"+flag).css('display','none');
		            $("#cs"+flag).css('display','none');
		        	$(".imgbox"+flag).css('display','block');
		        	if($(".cbox"+flag+' li').length==$(".imgbox"+flag+' li').length){
		        		var mses=$(".cbox"+flag).html();
			         	$(".cbox"+flag).html('<li>●</li>'+mses);      	
			        }
		        	
		        	var mes=$(".imgbox"+flag).html();
		        	$(".imgbox"+flag).html('');
		        	$(".imgbox"+flag).append(mes+json.message);
	        	} 
	        	if(flag==1){
	        		 autoroll();
		        	 hookThumb();
	        	}
	        	else if(flag==2){
	        		autoroll2();
		        	hookThumb2();
	        	}
	        	else if(flag==3){
	        		autoroll3();
		        	hookThumb3();
	        	}
	        	else if(flag==4){
	        		autoroll4();
		        	hookThumb4();
	        	}
	        	else if(flag==5){
	        		autoroll5();
		        	hookThumb5();
	        	}
	        	else if(flag==6){
	        		autoroll6();
		        	hookThumb6();
	        	}
	        	else if(flag==7){
	        		autoroll7();
		        	hookThumb7();
	        	}
	        	else if(flag==8){
	        		autoroll8();
		        	hookThumb8();
	        	}
	        	else{
	        		autoroll9();
		        	hookThumb9();
	        	}
	        	$("#count").html($(".dpimglist").find('span .qba').length);
	        	var money=0;
	        	var tmoney=0;
	        	var zk=1;
	        	if($(".dpimglist").find('span .qba').length>1){
	        		zk=0.95;
	        	}
	        	$(".dpimglist").find('span .qba').each(function(){
	        		money+=parseInt($(this).attr('m')*zk);
	        		tmoney+=parseInt($(this).attr('m'));
	        	});
	        	$("#money").html(money+".0");
	        	$("#totalmoney").html(tmoney+".0");
	        	$("#cheap").html((tmoney-money)+".0");
        	}
        },beforeSend: function(){	
        	$("#box"+flag).css("background","none");
        	//$("#box"+flag).html('加载中,请稍等...');
        },complete: function(json){
        	if(csflag==0){
        		$("#caflag").val('1');
        	}
        }
   });
   }
   else{
	   $("#add"+flag).css('display','none');
       $("#wz"+flag).css('display','none');
       $("#cs"+flag).css('display','none');
       $(".imgbox"+flag).css('display','block');
       if(flag==1){
  		 autoroll();
      	 hookThumb();
  	}
  	else if(flag==2){
  		autoroll2();
      	hookThumb2();
  	}
  	else if(flag==3){
  		autoroll3();
      	hookThumb3();
  	}
  	else if(flag==4){
  		autoroll4();
      	hookThumb4();
  	}
  	else if(flag==5){
  		autoroll5();
      	hookThumb5();
  	}
  	else if(flag==6){
  		autoroll6();
      	hookThumb6();
  	}
  	else if(flag==7){
  		autoroll7();
      	hookThumb7();
  	}
  	else if(flag==8){
  		autoroll8();
      	hookThumb8();
  	}
  	else{
  		autoroll9();
      	hookThumb9();
  	}
   }
}

function PrePage(){
    var obj=$('#scolllist');
    var sWidth = $('#scolllist').height();
   	var hidden=$('#hidden');
   	var len = parseInt($('#scolllist ul li').length/6); 
   	if($('#scolllist ul li').length%6>0)
   	{
   	    len=len+1;
   	}	
   	var index =parseInt(hidden.attr("attr"));
    index -= 1;
	if(index <= -1) {index = len - 1;}
	showPics(index,sWidth);
	hidden.attr("attr",'');
	hidden.attr("attr",index);	
		
   
}
function NextPage(){
    var obj=$('#scolllist');
    var sWidth = $('#scolllist').height();
   	var hidden=$('#hidden');
   	var len = parseInt($('#scolllist ul li').length/6); 
   	if($('#scolllist ul li').length%6>0)
   	{
   	    len=len+1;
   	}	
   	var index =parseInt(hidden.attr("attr"));
		index += 1;
	   	if(index >= len) {index = 0;}
	   	showPics(index,sWidth);
	   	hidden.attr("attr",'');
	   	hidden.attr("attr",index);
	
}
function showPics(index,sWidth) { //普通切换	  
	  var nowLeft = -index*sWidth; //根据index值计算ul元素的left值 
	   	    $('#scolllist ul').stop(true,false).animate({"top":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
	   		
	   	}

//获取分类
function getRack(flag){
  var obj=$('#type'+flag);
  if(obj==null) return;
   $(".option").find('ul').each(function(i){
	  $(this).css("display","none");
	 
   });
   var c=$("#category").val();
   obj.css("display","block");
   $.ajax({
	   type: "post",
        dataType: "json",
        url: "/gdscoll/getRackcode.jsp",
        cache: false,
        data:{'category':c,'flag':flag,'box':flag},
        error: function(XmlHttpRequest){
           alert(XmlHttpRequest.status);
        },
        success: function(json){	
        	if(json.succ){	        	
	        	obj.html(json.message);
	        	if(obj.find('li')){
	        	  getProductBycolde(obj.find('li:first-child'));
	        	}
        	}
        },beforeSend: function(){	
        	obj.html('加载中,请稍等...');
        },complete: function(json){
        	
        }
   });


}


//点击删除功能
function deleteimg(obj)
{
	var flag=$(obj).attr('flag');
	var o=$("#box"+flag); 
    if($('.imgbox'+flag+' li').length<=1){
	   var r=$(obj).parent();
	   r.html('');
	   r.remove();
	   $('.cbox'+flag).html('');
	   var mes=$("#box"+flag).html();	   
	   o.html('');
	   o.append(mes);
	   //$('.dpimglist span img').css('border','none');	   
	   //$('#add'+flag).css('display','block');
	   //$('#add'+flag).css('border','solid 3px #aa2e44;');
	   addfun(flag);
	   $('#wz'+flag).css('display','block');
	   $("#cs"+flag).css('display','none');
   }
   else{
	   var r=$(obj).parent();
	   r.html('');
	   r.remove();
	   $('.cbox'+flag+' li:last').remove();
   }
   var len=$('.imgbox'+flag+' li').length;
   if(len>0){
	   $('.imgbox'+flag+' li').css('display','none');
	   $('.imgbox'+flag+' li:last').css('display','block');
	   $('.cbox'+flag+' li:last').addClass('current');
   }
   
   $("#count").html($(".dpimglist").find('span .qba').length);
	   var money=0;
	   var zk=1;
	   var tmoney=0;
	  
   	   if($(".dpimglist").find('span .qba').length>1){
   		  zk=0.95;
      	}
	   $(".dpimglist").find('span .qba').each(function(){
		   money+=parseInt($(this).attr('m')*zk);
		   tmoney+=parseInt($(this).attr('m'));
	   });
	   $("#money").html(money+".0");
   	$("#totalmoney").html(tmoney+".0");
   	$("#cheap").html((tmoney-money)+".0");
  
}

//搭配3.0的加入购物车
function AddInCart(obj) {
	var list = $(".dpimglist").find('span .qba');
    if(list.length < 1){
    	$.alert("没有添加任何商品！");
        return;
    }
    var arr = new Array();
    list.each(function(i){
		arr[i] = $(this).attr('attr');
	});
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart3.jsp',width:600,align:'center'});
}

//图片添加方法
function addfun(flag)
{
	var len=$(".imgbox"+flag+' li').length;
	
	if(len>=3){
		$.alert("对不起，该类别的商品只能添加三个！");
		return;
    }
	$(".dpimglist span").find('img').each(function(i){   
		if($(this)!=null){
   			$(this).css("border","none");
   			
		}
   	});
	for(i=1;i<=9;i++){
		$('#cs'+i).css('display','none');
	}
	if(len<=0){
		$("#cs"+flag).css('display','none');
	}
	else
		{
		$("#cs"+flag).css('display','block');
		}
	if($('#add'+flag)!=null){
	   $('#add'+flag).css("display","block");
	   $('#add'+flag).css("border","solid 3px #aa2e44");
	   $('#wz'+flag).css("display","block");
	   $('.imgbox'+flag).css("display","none");
	   if($(".cbox"+flag+' li').length>0){
		   var mses=$(".cbox"+flag).html();
	   	   $(".cbox"+flag).html('<li>●</li>'+mses);	
	   }
	   
	}
	$("#caflag").val('0');
	getRack(flag);
}

//图片添加方法
function addfun1(flag)
{
	$("#caflag").val('1');
	getRack(flag);
}

//取消
function cx(flag){
	
	
	if($('.imgbox'+flag).find('li').length>0){
		$('#add'+flag).css('display','none');
		$('#wz'+flag).css('display','none');	
		$('.cbox'+flag).find('li:first').remove();
		$('.imgbox'+flag).css('display','block');

	}
	else
	{
		$('#add'+flag).css('display','block');
		$('#wz'+flag).css('display','block');	
		$('.imgbox'+flag).css('display','none');

	}
	$('#cs'+flag).css('display','none');
	$("#caflag").val('1');
}


function getfgdscollp(objs,gdsid,flag)
{
	var obj=$("#div_float");
	var pp=$(objs).attr("pp");
	if(obj!=null)
	{       
		    var fbl=screen.width; 
		    $(obj).html("");
		    $(obj).css("background","");
		    $(obj).css("background-color","#fff");
		    if(flag%6==1||flag%6==3||flag%6==5){
		    	$(obj).css("left","");
		    	$(obj).css("width","174px");
		    	$(obj).css("padding-left","0px");
                $(obj).css("padding-right","24px");
				$(obj).css("right","190px");
				var top=(flag%6-1)*61;
				$(obj).css("top",top+"px");
				var bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png";
				$(obj).css("background","url('"+bg+"') no-repeat");
				$(obj).css("text-align","left");
			}
			if(flag%6==2||flag%6==4||flag%6==0){
				$(obj).css("right","");
				$('#ttt').css('width','0px');
				if(fbl>1024){
					$(obj).css("left","195px");
					$(obj).css("width","174px");
					$(obj).css("padding-right","0px");
					 $(obj).css("padding-left","24px");
					var bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm.png";
				}
				else{
                    var bg="http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png";
                    $(obj).css("width","174px");
                    $(obj).css("padding-left","0px");
                    $(obj).css("padding-right","24px");
                    $(obj).css("right","85px");
				}
				var top=0;
				if(flag%6==0){
					top=244;
				}
				else{
				   top=(flag%6-2)*61;
				}
				$(obj).css("top",top+"px");
				
				$(obj).css("background","url('"+bg+"') no-repeat");
				$(obj).css("text-align","left");
			}
		   
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:100px; margin-top:100px; \"/>");
			$.post("/gdscoll/getFloatProduct.jsp",{"gdsid":gdsid,flag:flag,pp:pp},function(data){
			$(obj).html(data);	        
			$(obj).css("display","block");		
			});
	
    }
}
function mdmout()
{
	 var obj=$("#div_float");
	 obj.css("display","none");
}
function mdmover(obj)
{
	var gdsid=$(obj).parent().attr('code');
	var flag=$(obj).attr("flag");
	var obj1=$("#div_float");
	if(obj1!=null)
		{
		getfgdscollp(obj,gdsid,flag);
		}
    
}
function mdmover1()
{
	 var obj=$("#div_float");
	 obj.css("display","block");
}

//搭配3.0的加入购物车
function AddInCart1(obj) {
	var list = $(".dpimglist").find('span .qba');
    if(list.length < 1){
    	$.alert("没有添加任何商品！");
        return;
    }
    var arr = new Array();
    list.each(function(i){
		arr[i] = $(this).attr('attr');
	});
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart3new.jsp',width:600,align:'center'});
}