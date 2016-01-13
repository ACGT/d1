(function($) {
	$.inCart = function(obj,options,arrays){
		var o = $.extend({}, $.inCart.defaults, options);
		$.inCart.doShopcatAction(o,obj,$(obj).attr("attr"),0,arrays);
	};
	
	$.inCart.doShopcatAction = function(o,obj,id,type,arrays){
		var options = {"id":id,"type":type};
		if(typeof arrays !="undefined") options = $.extend({},options, arrays);
		$.ajax({
			type: "post",
			dataType: "json",
			url: o.ajaxUrl,
		    cache: false,
		    data:options,
		    error: function(XmlHttpRequest){
		    	alert("错误请联系管理员");
		    },success: function(json){
		    	$.inCart.shopcarAddItemCallBack(obj,o,json,options["skuId"]);
		    }
		});
	};
	$.inCart.shopcarAddItemCallBack = function(obj,o,json,skuId){
		switch(json.code){
			case 0://success
				$("#cartmsg .txt i").html(json.message)
			    $("#cartmsg").show();
				break;
			case 3://sku
				$.inCart.sku(obj,o,json);
				break;
			
			default:
				$("#cartmsg .txt i").html(json.message)
			    $("#cartmsg").show();
		}
	};
	
	$.inCart.sku = function(obj,o,json){
		try{
			
			var arr = json.message.split(':');
			var skuname = arr[0];
			var sku = arr[1].split('#');
			var template = '<div class="txt"><div class="skulist" id="skulist">';
		            
				
			o['title']='加入购物车';
			//$.inCart.init(obj,o,template);
			//init
			var $inCart = $('#choose_sku');
			var options_sku = $('#skulist');//,buy_num = $inCart.find('input[type=text][tag=buyNum]'),add_confirm = $inCart.find('.add_confirm');
			
			
			for(var i=0;i<sku.length;i++){
				var id = sku[i].split('_')[0];
				var name = sku[i].split('_')[1];
				template += '<a href="javascript:void(0);" attr_id="'+id+'" attr_name="'+name+'">'+name+'</a>';
	
			}
			
			template+='</div><div class="skuerr"></div>\
	          <div class="but"><a href="javascript:void(0);" class="add_confirm">加入购物车</a>\</div>\
	        </div></div>';
			
          $inCart.html(template);
			
			$inCart.show();
			$("#skulist>a").click(function(){
				 $(this).parent().find("a").removeClass("cur");
				 $(this).attr("class","cur");	
				$(".skuerr").hide();
			});
			
			$('.add_confirm').click(function(){
				
				var lis = $('#skulist .cur');
				
				if(lis.length==0){
					$(".skuerr").html("请选择SKU");
					}else{
						$(".skuerr").show();
					var count ="1";
					$.inCart.doShopcatAction(o,obj,$(obj).attr("attr"),1,{"skuId":lis.attr('attr_id'),"count":count});
					$inCart.hide();
					
				}
			});
			
		}catch(e){
			if (typeof e === 'object'){
				alert(e.message);
			}else{
				alert(e);
			}
		}
	};
	$.inCart.loading = function(obj,o){
		var template = '<div class="loading"><img src="http://images.d1.com.cn/images2012/New/result/icon_loading_large.gif" /><strong>请稍候...</strong></div>';
		o['title']='';
		$.inCart.init(obj,o,template);
		$.inCart.show(o,obj);
	};
	$.inCart.init = function(obj, o , content) {
		var $inCart = $('#inCartDiv');
		if($inCart.length == 0){
			$inCart = $('<div id="inCartDiv" class="module_box_normal"></div>');
			$inCart.html('<div class="box_title"><h4 id="inCartDiv_title"></h4><a href="###" class="bt_close" id="inCartDiv_closer"></a></div><div id="inCartContent"></div>');
			$(document.body).append($inCart);
			$('#inCartDiv_closer').click(function(){
				$.inCart.close();
			});
		}
		$('#inCartDiv_title').html(o.title);
		$('#inCartContent').addClass(o.contentClass).html(content);
	};
	$.inCart.show = function(o,obj){
		var $inCart = $('#inCartDiv');
		if($inCart.length>0){
			$inCart.show();

			var clientWidth = $getWindowClientWidth();
			var clientHeight = $getWindowClientHeight();
			if(o.align=='center'){
				var height = $inCart.outerHeight();
				var l = (clientWidth - o.width)/2;
				var t = $getWindowScrollTop()+(clientHeight - height)/2
				$inCart.css({width:o.width,left:l,top:t});
			}else{
				clientHeight += $getWindowScrollTop();
				var offset=$(obj).offset();
				var l = offset.left-20;
				var t = offset.top-20;
				if(l > clientWidth-o.width-50) l = clientWidth-o.width-50;
				var height = $inCart.outerHeight();
				if(t > clientHeight-height-20) t = clientHeight-height-20;
				$inCart.css({width:o.width,left:l,top:t});
			}
		}
	};
	$.inCart.close = function(){
		var $inCart = $('#inCartDiv');
		if($inCart.length>0){
			$inCart.hide();
		}
	};
	
})(jQuery);