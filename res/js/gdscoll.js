function display_hide(id){
	var obj = $('#'+id);
	if(obj.is(":hidden")){
		obj.show();
	}else{
		obj.hide();  
	}
}
//增加或删除购买数量
function addorminus(opr, flag,hyprice,flag)
{

    if (flag == 1) {
        $.alert('该商品只能买一件！！！');
        return;
    }
    var numInput = document.getElementById("num_input_"+flag);

//    var forenum = Number(numInput.attr('objNum'));
//    var new_val = Number(numInput.val());

    var new_val = Number(numInput.value);
    var forenum = Number(numInput.getAttribute('objNum'));

    var num = 0, subtotal = 0;
    switch (opr) {
        case 'add':
            num = parseInt(new_val) + 1;
            //numInput.val(num);
            numInput.value = num;
            $('#count_'+flag).val(num);
            $('#countgdsmst1_'+flag).html(num);
            $('#countgdsmst2_'+flag).html(num);
            $('#countgdsmst3_'+flag).html(num * hyprice);
            $('#pricecount_'+flag).html('￥'+(num * hyprice));
            //numInput.setAttribute('value', num);
            numInput.focus();
            numInput.blur();
            isblur = 1;
            break;
        case 'minus':
            if (new_val > 1) {
                num = parseInt(new_val) - 1;
                //numInput.val(num);
                numInput.value = num;
                $('#count_'+flag).val(num);
                $('#countgdsmst1_'+flag).html(num);
                $('#countgdsmst2_'+flag).html(num);
                $('#countgdsmst3_'+flag).html(num * hyprice);
                $('#pricecount'+flag).html('￥'+(num * hyprice));
                numInput.focus();
                numInput.blur();
                isblur = 1;
            }
            break;

    }
   
    
}

function addFavorite(id){
	$.post("/ajax/product/favoriteAdd.jsp",{"id":id,"m":new Date().getTime()},function(json){
		$.alert(json.message);
	},"json");
}
function ccdzb(flag)
{
  var top=$('#skuname_'+flag).offset().top+$('#skuname_'+flag+' p').height()-5;
  var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
  $("#ccdzb_img_"+flag).css("margin-left",-300);
  //$("#ccdzb_img_"+flag).css("right",right);
  $("#ccdzb_img_"+flag).css("display","block");

}
function ccdzb1(flag)
{
	$("#ccdzb_img_"+flag).css("display","none");
}

//选择第二规格(尺寸、表盘颜色等)
function chooseskuname1(obj,flag){
    var skuid = $("#skuname_"+flag);
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("current");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("current");
    	$('#sizecount_'+flag).html($(obj).attr("title"));
    }
}

  //遍历规格
function BLGG2(flag){
	var skuid = $("#skuname_"+flag);
    if (skuid.length==0){
    	return '';
    }
    var skuItem = skuid.find("a");
    var s = '';
    if(skuItem.length>0){
    	skuItem.each(function(){
    		if($(this).hasClass('current')){
    			s = $(this).attr("attr");
    			return false;
    		}
    	});
    }
    return s;
}
  
//放入购物车操作
function ShowAJax(param1){
	var counts=$('#count_'+param1).val();
	
	var sku2=BLGG2(param1);
	if(typeof sku2 == 'undefined'){
		sku2 = "";
	}
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/flow/InCart.jsp',
		cache: false,
		data: {gdsid:param1,count:counts,skuId:sku2},
		error: function(XmlHttpRequest){
			alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
				$('#frgwc_'+param1).show();
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
};



function ggdscoll(oc,gc,vc,id)
{
	if(id.length<=0)
		{
		return;
		}

	var oc1=oc;
	var gc1=gc;
	var vc1=vc;
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getGdscoll.jsp',
		cache: false,
		data: {id:id,param1:oc1,param2:gc1,param3:vc1},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			//if(json.succ){
				$('#2012test').html(json.message);
			//}else{
				$('#2012test').html(json.message);
			//}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}

function ggdscoll2(oc,gc,vc,id,brand)
{
	if(id.length<=0)
		{
		return;
		}

	var oc1=oc;
	var gc1=gc;
	var vc1=vc;
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getGdscoll2.jsp',
		cache: false,
		data: {id:id,param1:oc1,param2:gc1,param3:vc1,brand:brand},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			//if(json.succ){
				$('#2012test').html(json.message);
			//}else{
				$('#2012test').html(json.message);
			//}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}

function ggdscoll_product(oc,gc,vc,id)
{
	if(id.length<=0)
		{
		return;
		}

	var oc1=oc;
	var gc1=gc;
	var vc1=vc;
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getPGdsscoll.jsp',
		cache: false,
		data: {id:id,param1:oc1,param2:gc1,param3:vc1},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			//if(json.succ){
				$('#divdp').html(json.message);
			//}else{
				$('#divdp').html(json.message);
			//}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}

function check_gdscoll1(obj) {
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

//最佳组合JS
function selectInitdp(mPrice,value) {
	var zk=0.95;
    var memberP = $("#memberP");
    var cheap = $("#cheap");
    var pktP = $("#pktP");
    var mm=$("#memberP");
    //var pPrice=parseInt(mPrice*0.95);
     var amount=$("#amount");
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
function pgdscollover(obj,flag,overcolor)
{
	   $(obj).css('background','#'+overcolor);
	   if($('#pgwx_'+flag)!=null)
		   {
		       $('#pgwx_'+flag).css('display','block');
		   }
	   if($('#pfav_'+flag)!=null)
	   {
	        $('#pfav_'+flag).css('display','block');
	   }
	   if($('#psq_')+flag!=null)
		   {
		       $('#psq_'+flag).css('display','block');
		   }
}
function pgdscollout(obj,flag)
{
	   $(obj).css('background','');
	   if($('#pgwx_'+flag)!=null)
	   {
	   $('#pgwx_'+flag).css('display','none');
	   }
	   if($('#pfav_'+flag)!=null)
	   {
	   $('#pfav_'+flag).css('display','none');
	   }
	   if($('#psq_')+flag!=null)
	   {
	       $('#psq_'+flag).css('display','none');
	   }
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

//尺码对照
function getsize(gdsid){
	//alert(gdsid.length);
	if(gdsid.length==0 || gdsid.length!=8){
		return ;
	}
	if(isNaN(gdsid)){
		return ;
	}
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getSize.jsp',
		cache: false,
		data: {gdsid:gdsid},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			if(json.succ){
			//alert(json.message);
				$('#gdssize').html(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}
//身高体重对照
function getHweight(gdsid){
	//alert(gdsid.length);
	if(gdsid.length==0 || gdsid.length!=8){
		return ;
	}
	if(isNaN(gdsid)){
		return ;
	}
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getHWeightInfo.jsp',
		cache: false,
		data: {gdsid:gdsid},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			if(json.succ){
				$('#gdsHweight').html(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}
//身高体重对照mtype模特A=小栗舍，S=诗若漫，F=FM   如果模特不一样，就是A1,A2
function getHweight2(gdsid,mtype){
	//alert(gdsid.length);
	if(gdsid.length==0 || gdsid.length!=8 || mtype==""){
		return ;
	}
	if(isNaN(gdsid)){
		return ;
	}
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getHWeightInfo2.jsp',
		cache: false,
		data: {gdsid:gdsid,mtype:mtype},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			if(json.succ){
				$('#gdsHweight').html(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}
//最佳组合JS
function selectInitdp1209(mPrice,value,flag) {
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

function selectInitdp12091(mPrice,value,flag,id) {
	var zk=0.95;
    var memberP = $("#memberP"+flag);
    var cheap = $("#cheap" + flag);
    var pktP = $("#pktP" + flag);
    var mm=$("#memberP"+flag);
    var amount=$("#amount"+flag);
    var s=$("#span"+id+flag);
    //var pPrice=parseInt(mPrice*0.95);
    if (value == false) {    	
    	memberP.html(formatNum(Number(memberP.html()) - Number(mPrice),2));
    	pktP.html(Number(pktP.html())-parseInt(mPrice*zk));
    	amount.html(Number(amount.html())-1);
    	s.css("display",'block');
    }
    else {
    	memberP.html(formatNum(Number(memberP.html()) + Number(mPrice),2));
    	pktP.html(Number(pktP.html())+parseInt(mPrice*zk));
    	amount.html(Number(amount.html())+1);
    	s.css("display",'none');
    }
    cheap.html(formatNum(Number(memberP.html()) - Number(pktP.html()),2));
 
}


function check_gdscoll201209(obj,flag)
{
	
    var arr = new Array();
   
    //判断其他配件
    var pktsel1 = $("input[type='checkbox'][name='chk_"+flag+"']:checked");
    if(pktsel1.length >0){ 
    	if(pktsel1.length <2){
    		$.alert('请至少选择两个商品！');
    		return;
    	}
    	 pktsel1.each(function(j){
    			arr[j] = $(this).val();
    		});
    }  
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});

}

function g_productscoll(obj,obj1){
	var sWidth = $(obj1).width();
	
	var len = parseInt($(obj+" ul li").length/3); 
	if($(obj+" ul li").length%3>0)
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



function ggdscoll1(oc,gc,vc,id)
{
	if(id.length<=0)
		{
		return;
		}

	var oc1=oc;
	var gc1=gc;
	var vc1=vc;
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/product/getGdscoll121023.jsp',
		cache: false,
		data: {id:id,param1:oc1,param2:gc1,param3:vc1},
		error: function(XmlHttpRequest){
			
		},success: function(json){
			//if(json.succ){
				$('#20121023test').html(json.message);
			//}else{
				$('#20121023test').html(json.message);
			//}
		},beforeSend: function(){
		},complete: function(){
		}
	   
	}); 
}



