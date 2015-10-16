// JavaScript Document
function display_hide(id){
	var obj = $('#'+id);
	if(obj.is(":hidden")){
		obj.show();
	}else{
		obj.hide();  
	}
}

//最佳组合JS
function selectInit(mPrice, pPrice, value,flag) {
    var memberP = $("#memberP"+flag);
    var cheap = $("#cheap" + flag);
    var pktP = $("#pktP" + flag);
    if (value == false) {
    	memberP.html(formatNum(Number(memberP.html()) - Number(mPrice),2));
    	pktP.html(formatNum(Number(pktP.html()) - Number(pPrice),2));
    }
    else {
    	memberP.html(formatNum(Number(memberP.html()) + Number(mPrice),2));
    	pktP.html(formatNum(Number(pktP.html()) + Number(pPrice),2));
    }
    cheap.html(formatNum(Number(memberP.html()) - Number(pktP.html()),2));
    if (parseInt(pktP.html()) == 1) {
    	pktP.css("color","#0375D4");
    } else {
    	pktP.css("color","#A60042");
    }
    pktP.css("fontWeight","bold");
}
function check_pkt(flag,id,obj) {
    var pktsel = $("#content_list input[type='checkbox'][name='pktsel"+flag+"']:checked");
    if(pktsel.length < 1){
    	alert("组合购买至少勾选一个组合的商品！");
        return;
    }
    var arr = new Array();
    pktsel.each(function(i){
		arr[i] = $(this).val();
	});
    
    $(obj).attr('attr',id+","+arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/listPackageInCart.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}

//最佳组合切换
function $bb(id) { return document.getElementById(id) };
function switch_tags(tags, contents, cls, index, method, type , time) {
    this.time = time;
    this.method = method;
    this.tags = tags;
    this.contents = contents;
    this.cls = cls;
    this.c_index = index;
    this.type = type;
    tags.eq(index).attr("className",cls);
    contents.eq(index).show();
    this.bind_switch();
};

switch_tags.prototype.bind_switch = function() {
    var nb = this;
    var set_int;
    this.tags.each(function(i){
    	this.index=i;
    	if(nb.method=="mouseover"){
    		$(this).mouseover(function(){
    			var o = this;
    			set_int = setTimeout(function(){sw(o.index)},nb.time);
    		}).mouseout(function(){
    			clearTimeout(set_int);
    		});
    	}else if(nb.method=="click"){
    		$(this).click(function(){sw(this.index)});
    	}
    });
    //延时切换		
    function sw(m) {
        var obj = nb.tags.eq(m);
        nb.tags.eq(nb.c_index).attr('className','');
        nb.contents.eq(nb.c_index).hide();
        obj.attr('className',nb.cls);
        nb.contents.eq(obj.get(0).index).show();
        nb.c_index = obj.get(0).index;
       // alert(m+"wwwwwwwwww"+nb.type);
        if(nb.type == 2){
        	if(m == 3){//评论
        		$('#sdLink').hide();
        		$('#commLink').hide();
        		$('#ssd').hide();
        		$('#scomment').show();
        	}else if(m == 2){//晒单
        		$('#sdLink').hide();
        		$('#ssd').show();
        		$('#commLink').hide();
        		$('#scomment').hide();
        	}
        	
        	else{
        		$('#sdLink').show();
        		$('#commLink').show();
        		$('#ssd').show();
        		$('#scomment').show();
        	}
        }
       
    };
};

var t2 = $("#goodsinfotab > a");
var c2 = $("#content_list_info > span");
new switch_tags(t2, c2, "newa", 0, "click",2);

//增加或删除购买数量
function addorminus(opr, flag,hyprice)
{

    if (flag == 1) {
        $.alert('该商品只能买一件！！！');
        return;
    }
    var numInput = document.getElementById("num_input");

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
            $('#countgdsmst1').html(num);
            $('#countgdsmst2').html(num);
            $('#countgdsmst3').html(num * hyprice);
            $('#pricecount').html('￥'+(num * hyprice));
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
                $('#countgdsmst1').html(num);
                $('#countgdsmst2').html(num);
                $('#countgdsmst3').html(num * hyprice);
                $('#pricecount').html('￥'+(num * hyprice));
                numInput.focus();
                numInput.blur();
                isblur = 1;
            }
            break;

    }
   
    
}


//限时秒杀
function retime(t, o_text) {

    this.time = t;
    this.timeSec = parseInt(this.time / 1000);
    this.tt = 1;
    this.startTime = parseInt(new Date() / 1000);
    this.offsetTime = this.startTime;
    this.text = o_text;
};

retime.prototype.starTime = function(o) {


    var oid = o.text.id; //由于对象o始终是存在的，所以即使o.text这个真实的标签不存在了，o.text.id这个值也是可以获取的，从对象o中。
    if (oid != '') {
        if (document.getElementById(oid) == null) {//当这个标签不存在的时候，应该终止循环
            return;
        }
    }

    if (this.tt > 0) {
        var endTime = parseInt(new Date() / 1000);
        var b = Math.abs(endTime - this.offsetTime);
        if (b > 60) {
            this.startTime += (endTime - this.offsetTime);
        }
        this.offsetTime = parseInt(new Date() / 1000);
        var c = Math.floor(this.timeSec - (endTime - this.startTime));

        if (c > 0) { this.tt = c } else { this.tt = 0; }
        var senconds = Math.floor(this.tt % 60);
        var minutes = Math.floor((this.tt / 60) % 60);
        var hours = Math.floor((this.tt / 3600) % 24);
        var day = Math.floor(this.tt / 86400);
        day < 10 ? day = "0" + day : day = day;
        hours < 10 ? hours = "0" + hours : hours = hours;
        senconds < 10 ? senconds = "0" + senconds : senconds = senconds;
        minutes < 10 ? minutes = "0" + minutes : minutes = minutes;

        o.setText(o, [day, hours, minutes, senconds]);
        setTimeout(function() { o.starTime(o) }, 1000);
    }

    else {
        o.setTextEnd(o);
    }
};

retime.prototype.setText = function(o, t) {

    var nid = o.text.id;
    if(t[0]<7){
    o.text.innerHTML = '<em>' + t[0] + '</em>天<em>' + t[1] + '</em>小时<em>' + t[2] + '</em>分<em>' + t[3] + '</em>秒';
    }
    else
    	{
    	  o.text.innerHTML ='';
    	}
};

retime.prototype.setTextEnd = function(o) {
    o.text.innerHTML = "活动已开始";
};

retime.prototype.sTime = function(o) {
    if (o.text == null) {
        alert("me");
        return;
    }
    setTimeout(function() { o.starTime(o) }, 1000);
};

function xsms_gdsmst(id) {
	$('#'+id+' .countdown').each(function(){
		var b = $(this).attr('time');
		if(b){
			var ttime = new retime(b, this);
            ttime.sTime(ttime);
		}
	});
};


//调用AJAx
// 显示商品页的一些数据

//选择第二规格(尺寸、表盘颜色等)
function chooseskuname1(obj){
    var skuid = $("#skuname");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("current");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("current");
    	$('#sizecount').html($(obj).attr("title"));
    }
}

  //遍历规格
function BLGG2(){
	var skuid = $("#skuname");
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
	var counts=$('#countgdsmst1').html();
	var sku2=BLGG2();
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
				$('#frgwc').show();
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
};

function addFavorite(id){
	$.post("/ajax/product/favoriteAdd.jsp",{"id":id,"m":new Date().getTime()},function(json){
		$.alert(json.message);
	},"json");
}

function keynum(obj,price){
	obj.value=obj.value.replace(/[^\d]/g,'');
	$('#countgdsmst1').html(obj.value);
	$('#countgdsmst2').html(obj.value);
	if(obj.value == ""){
		$('#pricecount').html('￥0');
	}else{
		$('#pricecount').html('￥'+(parseInt(obj.value)*parseInt(price)));
		obj.value=parseInt(obj.value);
	}
}

function emailTZ(id){
	$.load('到货通知',450,'/ajax/dialog/product/oosdtl.jsp?id='+id);
}

function pro_comment(id,pg){
	$('#commentContent').html("<div align='center'><img src='http://images.d1.com.cn/images2012/New/Loading.gif' /></div>");
	$.post("/ajax/product/commentList.jsp",{"id":id,"pg":pg,"m":new Date().getTime()},function(data){
		$('#commentContent').html(data);
	});
}


function check_pkt1(flag,id,obj) {
    var pktsel = $("#content_list input[type='checkbox'][name='pktsel"+flag+"']:checked");
    //if(pktsel.length < 1){
    	//alert("组合购买至少勾选一个组合的商品！");
        //return;
   // }
    var arr = new Array();
    pktsel.each(function(i){
		arr[i] = $(this).val();
	});
    
    $(obj).attr('attr',id+","+arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCartnew.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
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


function gdscollover(obj,flag,overcolor)
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
function gdscollout(obj,flag)
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
function check_pkt2(flag,id,obj) {
	    var pktsel = $("#content_list input[type='checkbox'][name='pktsel"+flag+"']:checked");
	    //if(pktsel.length < 1){
	    	//alert("组合购买至少勾选一个组合的商品！");
	        //return;
	   // }
	    var arr = new Array();
	    pktsel.each(function(i){
			arr[i] = $(this).val();
		});
	    
	    $(obj).attr('attr',id+","+arr.toString());
	    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart2.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
	}

function selectInits(mPrice,value,flag) {
	    var memberP = $("#memberP"+flag);
	    var cheap = $("#cheap" + flag);
	    var pktP = $("#pktP" + flag);
	    var mm=$("#memberP"+flag);
	    //var pPrice=parseInt(mPrice*0.95);
	    if (value == false) {    	
	    	memberP.html(formatNum(Number(memberP.html()) - Number(mPrice),2));
	    	pktP.html(Number(pktP.html())-parseInt(mPrice*0.95));
	    }
	    else {
	    	memberP.html(formatNum(Number(memberP.html()) + Number(mPrice),2));
	    	pktP.html(Number(pktP.html())+parseInt((mPrice*0.95)));
	    }
	    cheap.html(formatNum(Number(memberP.html()) - Number(pktP.html()),2));
	 
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
function choosedptj(mPrice,value,flag) {
    var memberP = $("#memberPstj"+flag);
    var cheap = $("#cheapstj" + flag);
    var pktP = $("#pktPstj" + flag);
    var mm=$("#memberPstj"+flag);
    var amount=$("#amountstj"+flag);
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

function add_gdscolltj(obj,flag)
{
    var arr = new Array();
    var pktsel1 = $("input[type='checkbox'][name='chkstj_"+flag+"']:checked");
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

//选择第二规格(尺寸、表盘颜色等)
function choosesku20120717(obj){
    var skuid = $("#skuname");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("current");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("current");
    	$('#sizecount').html($(obj).attr("title"));
    }
  //换图片
    var flag=$(obj).attr("flag");
    if(flag==1)
    {
        $('#gwc0717').attr("src","http://images.d1.com.cn/images2012/index2012/ydgsp.jpg");	
    }
    else
    	{
    	$('#gwc0717').attr("src","http://images.d1.com.cn/images2012/New/frgwc.gif");	
    	}
}
function pro_showorder(id,pg){
	$('#SdContent').html("<div align='center'><img src='http://images.d1.com.cn/images2012/New/Loading.gif' /></div>");
	$.post("/ajax/product/sdlist.jsp",{"id":id,"pg":pg,"m":new Date().getTime()},function(data){
		$('#SdContent').html(data);
	});
}
function pro_comment2(id,pg){
	$('#commentContent').html("<div align='center'><img src='http://images.d1.com.cn/images2012/New/Loading.gif' /></div>");
	$.post("/ajax/product/commentList2.jsp",{"id":id,"pg":pg,"m":new Date().getTime()},function(data){
		$('#commentContent').html(data);
	});
}
function sdimg_over2(showid){
	 $("#floatdp"+showid).show(); 
}
function sdimg_over(showid)
{
	 var obj=$("#floatdp"+showid);
	 if(!isNaN){
		 $.alert("参数错误");return;
	 }else{
		 $(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
		 obj.show(); 
		 $.ajax({
				type: "get",
				dataType: "json",
				url: '/ajax/product/getsdimg.jsp',
				cache: false,
				data: {showid:showid},
				error: function(XmlHttpRequest){
				},success: function(json){
					if(json.succ){
						//alert(json.message);
						$(obj).html(json.message);
					}else{
						$.alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
	 }
	
}


function sdimg_out(showid)
{
	 $("#floatdp"+showid).hide();
	
}
// end function