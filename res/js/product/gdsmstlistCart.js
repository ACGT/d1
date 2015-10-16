////javascript utf-8
function $isBrowser(str){
	str=str.toLowerCase();
	var b=navigator.userAgent.toLowerCase();
	var arrB=[];
	arrB['firefox']=b.indexOf("firefox")!=-1;
	arrB['opera']=b.indexOf("opera")!=-1;
	arrB['safari']=b.indexOf("safari")!=-1;
	arrB['chrome']=b.indexOf("chrome")!=-1;
	arrB['gecko']=!arrB['opera']&&!arrB['safari']&&b.indexOf("gecko")>-1;
	arrB['ie']=!arrB['opera']&&b.indexOf("msie")!=-1;
	arrB['ie6']=!arrB['opera']&&b.indexOf("msie 6")!=-1;
	arrB['ie7']=!arrB['opera']&&b.indexOf("msie 7")!=-1;
	arrB['ie8']=!arrB['opera']&&b.indexOf("msie 8")!=-1;
	arrB['ie9']=!arrB['opera']&&b.indexOf("msie 9")!=-1;
	return arrB[str];
};
function $getWindowScrollLeft(){if (window.scrollWidth) {return window.scrollLeft;} else if (document.documentElement.scrollWidth) {return document.documentElement.scrollLeft;} else if (document.body.scrollWidth) {return document.body.scrollLeft} else {return 0;}}
function $getWindowScrollTop(){if (window.scrollWidth) {return window.scrollTop;} else if (document.documentElement.scrollTop) { return document.documentElement.scrollTop;} else if (document.body.scrollTop) { return document.body.scrollTop;} else { return 0;}}
function $getWindowClientWidth(){return window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth|| 0;}
function $getWindowClientHeight(){return window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight|| 0;}
(function($) {
	$.inCart1 = function(obj,options,arrays){
		var o = $.extend({}, $.inCart1.defaults, options);
		$.inCart1.doShopcatAction(o,obj,$(obj).attr("attr"),0,arrays);
	};
	$.inCart1.defaults = {
		method : 'post',
		width : 400, //total width of inCart.  auto-adjusts based on showArrow value
		title : '', //window title
		contentClass : 'box_content', //content css class
		succButton : true, // is show success button
		ajaxUrl:'/ajax/flow/listInCart.jsp',
		goodsType : 0,//normal goods or points goods
		align:'normal',
		showSuccWindow:true,//is show success window
		onComplete : function(obj,o,json){$.inCart1.success(obj,o,json);} //when sucess then complete
	};
	$.inCart1.doShopcatAction = function(o,obj,id,type,arrays){
		var options = {"id":id,"type":type};
		if(typeof arrays !="undefined") options = $.extend({},options, arrays);
		$.ajax({
			type: o.method,
			dataType: "json",
			url: o.ajaxUrl,
		    cache: false,
		    data:options,
		    error: function(XmlHttpRequest){
		    	alert("加入购物车出错，请重新再试或者联系客服处理！");
		    },success: function(json){
		    	$.inCart1.shopcarAddItemCallBack(obj,o,json,options["skuId"]);
		    },beforeSend: function(){
		    	$.inCart1.loading(obj,o);
		    },complete: function(){
	          
		    }
		});
	};
	$.inCart1.shopcarAddItemCallBack = function(obj,o,json,skuId){
		switch(json.code){
			case 0://success
				if(o.showSuccWindow) $.inCart1.success(obj,o,json);
				o.onComplete(obj,o,json);
				break;
			case 1://informat
				$.inCart1.tips(obj,o,json);
				break;
			case 2://again
				$.inCart1.again(obj,o,json,skuId);
				break;
			case 3://sku
				$.inCart1.sku(obj,o,json);
				break;
			case 4://other sku
				$.inCart1.moreSku(obj,o,json);
				break;
			default:
				$.inCart1.tips(obj,o,{'message':'你要进行什么操作？'});
		}
	};
	$.inCart1.moreSku = function(obj,o,json){
		try{
			var skuList = json.list;
			var otherList = json.otherList;
			
			var template = '\
			<div class="tc_sel_attr">\
				<div class="tc_sel_attr_wrap" id="tc_sel_attr_wrap"></div>\
				<p class="pri_old">总价：<del id="foprice" defaultval="'+json.oldPrice+'">'+json.oldPrice+'</del> 元</p>\
				<p class="pri_new">套餐价：<ins id="fbprice" defaultval="'+json.price+'">'+json.price+'</ins> 元</p>\
				<p class="tc_sel_attr_btn">\
					<button id="bindBuy" type="button">完成选择，购买</button>\
					<button id="bindCancel" type="button">取消</button>\
				</p>\
			<div>';
			o['title']=(typeof json.title != 'undefined'?json.title:'');
			$.inCart1.init(obj,o,template);
			
			//init
			var $inCart = $('#inCartDiv'),$sel_wrap = $('#tc_sel_attr_wrap');
			$.each(json.list,function(i,n){
				i = n.id;
				var goods = $('<div class="tc_stock"></div>');
				goods.html('<p class="tc_stock_item"><a href="'+n.url+'" title="'+n.title+'" target="_blank"><img src="'+n.pic+'" /></a><span class="title" title="'+n.title+'">'+n.title+'</span></p>\
					<div class="tc_stock_buyinfo">\
						<dl class="stock">\
							<dt>'+n.skuname+'：</dt>\
							<dd><ul id="bind_sku'+i+'" tag="'+n.skuname+'"></ul></dd>\
						</dl>\
						<dl class="amount" id="bind_buynum'+i+'">\
							<dt>购买数量：</dt>\
							<dd><span>1</span> 件</dd>\
						</dl>\
						<dl class="choice">\
							<dt>提示：</dt>\
							<dd id="bind_choice'+i+'">请您选择 “'+n.skuname+'”</dd></dl>\
						<dl id="cc'+n.id+'"></dl></div>');
				$sel_wrap.append(goods);
				var ul = $('#bind_sku'+i);
				var sku = n.skulist.split('#');
				for(var j=0;j<sku.length;j++){
					var id = sku[j].split('_')[0];
					var name = sku[j].split('_')[1];
					ul.append('<li selected="0" attr_id="'+id+'" attr_name="'+name+'" v="'+n.skuname+':'+name+'"><a href="javascript:void(0);" hidefocus="true"><span>'+name+'</span></a></li>');
				}
				if(n.ccdes!=null)
				{
				   $('#cc'+n.id).append("<dd><font id=\"ccdzb\" style=\" color:#020399; cursor:hand;\" onmouseover=\"tcdes(\'"+n.id+"\')\" onmouseout=\"hidedes(\'"+n.id+"\')\">(尺寸对照表)</font><div id=\"des"+n.id+"\" style=\"position:absolute; right:0px; display:none;  z-index:2222222; background:#fff;\" onmouseover=\"tcdes(\'"+n.id+"\')\" onmouseout=\"hidedes(\'"+n.id+"\')\">"+n.ccdes+"</div></dd>");
			
				}
				var lis = ul.find("li");
				lis.each(function(){
					var _this = $(this);
					_this.click(function(){
						lis.each(function(){
							if(_this.attr('attr_id') == $(this).attr('attr_id')) return true;
							$(this).attr('selected',0).removeClass('select').find("a").removeClass("current");
						});
						if(_this.attr('selected')==1){
							_this.attr('selected',0).removeClass('select').find("a").removeClass("current");
						}else{
							_this.attr('selected',1).addClass('select').find("a").addClass('current');
						}
						var selectedLi = ul.find(' > li[selected=1]');
						if(selectedLi.length == 0){
							$('#bind_choice'+i).html('请选择"'+ul.attr('tag')+'"');
						}else{
							$('#bind_choice'+i).html('已选择<em>"'+selectedLi.attr('attr_name')+'"</em>');
						}
					});
				});
				//如果只有1个sku则默认选中
				if(lis.length == 1) lis.eq(0).click();
			});
			$sel_wrap.append('<div class="tc_other_item" id="tc_other" style="display:none;"><h5>其余商品<span>数量均为1件</span></h5><ul class="tc_glist" id="tc_glist"></ul></div>');
			var tc_other = $('#tc_other'),tc_glist = $('#tc_glist');
			$.each(json.otherList,function(i,n){
				if(tc_other.is(":hidden")) tc_other.show();
				tc_glist.append('<li><a href="'+n.url+'" title="'+n.title+'" target="_blank"><img src="'+n.pic+'"></a><p class="g_tit">'+n.title+'</p></li>');
			});
			//初始化event
			$('#bindCancel').click(function(){
				$.inCart1.close();
			});
			$('#bindBuy').click(function(){
				var skuId = "";
				var isCheck = true;
				$.each($(obj).attr("attr").split(','),function(i,n){
					var ul = $('#bind_sku'+n+i);
					if(ul.length>0){
						var selectedLi = ul.find(' > li[selected=1]');
						if(selectedLi.length == 0){
							alert('请选择"'+ul.attr('tag')+'"');
							isCheck = false;
							return false;
						}
						skuId+=','+selectedLi.attr('attr_id');
					}else{
						skuId+=',#';
					}
				});
				if(!isCheck) return;
				if(skuId.length>0) skuId = skuId.substring(1);
				//submit
				$.inCart1.doShopcatAction(o,obj,$(obj).attr("attr"),1,{"skuId":skuId,"code":$(obj).attr('code')});
			});
			$.inCart1.show(o,obj);
		}catch(e){
			if (typeof e === 'object'){
				alert(e.message);
			}else{
				alert(e);
			}
		}
	};
	$.inCart1.sku = function(obj,o,json){
		try{
			var arr = json.message.split(':');
			var skuname = arr[0];
			var sku = arr[1].split('#');
			var template = '\
			<div class="cart_property_wrapper">\
				<div class="block_options" tag="select_area">\
					<div class="txt_tips">提示：</div>\
					<div class="txt_display">请选择<span class="color_orange">“'+skuname+'”</span></div>\
				</div>\
				<p tag="warning" class="msg-para-warn" style="display:none;">\
					<span class="msg0-icon-warn"></span>\
					<span tag="info"></span>\
				</p>\
				<div class="block_options">\
					<div tag="item_name" v="'+skuname+'" class="block_property">'+skuname+'：</div>\
					<div class="option_list">\
						<ul id="options_sku"></ul>\
					</div>\
				</div>\
				<div class="block_options"'+(o.goodsType==1?' style="display:none;"':'')+'>\
					<div class="block_property">购买数量：</div>\
					<div class="option_list"><input tag="buyNum" value="1" name="" type="text"> 件</div>\
				</div>\
				<button class="add_confirm">加入购物车</button>\
			</div>';
			o['title']='添加到购物车';
			$.inCart1.init(obj,o,template);
			//init
			var $inCart = $('#inCartDiv');
			var select_area = $inCart.find('div[tag=select_area]'),warn_info = $inCart.find('p[tag=warning]'),options_sku = $('#options_sku'),buy_num = $inCart.find('input[type=text][tag=buyNum]'),add_confirm = $inCart.find('.add_confirm');
			var options_html = '';
			for(var i=0;i<sku.length;i++){
				var id = sku[i].split('_')[0];
				var name = sku[i].split('_')[1];
				options_html += '<li selected="0" attr_id="'+id+'" attr_name="'+name+'" v="'+skuname+':'+name+'">'+name+'</li>';
			}
			options_sku.html(options_html);
			
			var lis = options_sku.find("li");
			lis.each(function(i){
				var _this = $(this);
				_this.click(function(){
					warn_info.hide();
					select_area.show();
					lis.each(function(j){
						if(_this.attr('attr_id') == $(this).attr('attr_id')) return true;
						$(this).attr('selected',0).removeClass('property_box_hover property_box_selected');
					});
					if(_this.attr('selected')==1){
						_this.attr('selected',0).removeClass('property_box_hover property_box_selected');
					}else{
						_this.attr('selected',1).removeClass('property_box_hover').addClass('property_box_selected');
					}
					$.inCart1.refreshState();
					buy_num.keyup();
				}).mouseover(function(){
					if(parseInt(_this.attr('selected'))==0){
						_this.removeClass('property_box_selected').addClass('property_box_hover');
					}
				}).mouseout(function(){
					if(parseInt(_this.attr('selected'))==0){
						_this.removeClass('property_box_hover property_box_selected');
					}
				});
			});
			//如果只有1个sku则默认选中
			if(lis.length == 1) lis.eq(0).click();
			buy_num.keypress(function(e){
				var e=e||window.event,kc=$isBrowser("ie")?e.keyCode:e.charCode;
				if(kc!==0&&/\D/.test(String.fromCharCode(kc))){return false;}
			}).keyup(function(){
				var maxV=100;
				if(parseInt(this.value)>maxV){this.value=maxV;}
			}).blur(function(){
				var v=this.value;
				if(parseInt(v)<1||/^\s*$/.test(v)){this.value=1;}
				this.value=parseInt(this.value,10);
			});
			add_confirm.click(function(){
				var lis = $('#options_sku > li[selected=1]');
				if(lis.length==0){
					select_area.hide();
					warn_info.show().find('span[tag=info]').html('请选择“'+$inCart.find('div[tag=item_name]').attr('v')+'”');
				}else{
					var count = buy_num.val();
					if(!isMath(count)) count = "1";
					else if(parseInt(count) <= 0 || parseInt(count) > 100) count="1";
					$.inCart1.doShopcatAction(o,obj,$(obj).attr("attr"),1,{"skuId":lis.attr('attr_id'),"count":count});
				}
			});
			$.inCart1.show(o,obj);
		}catch(e){
			if (typeof e === 'object'){
				alert(e.message);
			}else{
				alert(e);
			}
		}
	};
	$.inCart1.refreshState = function(){
		var $inCart = $('#inCartDiv');
		var lis = $('#options_sku > li[selected=1]');
		if(lis.length==0){
			$inCart.find('div[tag=select_area] > .txt_display').html('请选择<span class="color_orange">“'+$inCart.find('div[tag=item_name]').attr('v')+'”</span>');
		}else{
			$inCart.find('div[tag=select_area] > .txt_display').html('已选择<span class="color_orange">“'+$inCart.find('div[tag=item_name]').attr('v')+'”</span>');
		}
	};
	$.inCart1.success = function(obj,o,json){
		var template = '<div class="box_hint_normal">\
			<span class="icon msg2-icon-right"></span>\
			<div class="hint_content">\
				<p class="hint_title"><strong>已成功添加到购物车！</strong></p>\
				<p>购物车里已有 '+json.totalCount+' 件商品。总价 '+json.totalAmount+'元。</p>\
				<div class="hint_op"'+(o['succButton']?'':' style="display:none;"')+'><a href="/flow.jsp" target="_blank" id="shopcar_b_watch" title="立即结算"><img src="http://images.d1.com.cn/images2012/New/product/chakan.gif" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="###" id="shopcar_b_goon" title="继续购物"><img src="/res/images/product/jixu.gif" /></a></div>\
			</div>\
		</div>';
		o['title']='提示';
		$.inCart1.init(obj,o,template);
		$('#shopcar_b_watch').click(function(){
			$.inCart1.close();
		});
		$('#shopcar_b_goon').click(function(){
			$.inCart1.close();
		});
		$.inCart1.show(o,obj);
	};
	$.inCart1.loading = function(obj,o){
		var template = '<div class="loading"><img src="http://images.d1.com.cn/images2012/New/result/icon_loading_large.gif" /><strong>请稍候...</strong></div>';
		o['title']='';
		$.inCart1.init(obj,o,template);
		$.inCart1.show(o,obj);
	};
	$.inCart1.again = function(obj,o,json,skuId){
		var template = '<div class="box_hint_normal">\
			<span class="icon msg2-icon-right"></span>\
			<div class="hint_content">\
				<p class="hint_title"><strong>您已经添加过该商品，确定要增加购买数量吗？</strong></p>\
				<div class="hint_op"><button class="btn_normal" id="shopcar_b_cover">确 认</button> <button class="btn_normal" id="shopcar_b_cancel">不要添加</button></div>\
				<div class="hint_other"><p style="text-align:right; display:none;"><a href="###">不再显示该提示</a></p></div>\
			</div>\
		</div>';
		o['title']='提示';
		$.inCart1.init(obj,o,template);
		$('#shopcar_b_cover').click(function(){
			$.inCart1.doShopcatAction(o,obj,$(obj).attr("attr"),1,{"skuId":skuId});
		});
		$('#shopcar_b_cancel').click(function(){
			$.inCart1.close();
		});
		$.inCart1.show(o,obj);
	};
	$.inCart1.tips = function(obj,o,json){
		var template = '<div class="box_hint_normal">\
			<span class="icon msg2-icon-right"></span>\
			<div class="hint_content">\
				<p class="hint_title"><strong>'+json.message+'</strong></p>\
				<div class="hint_op"> <button class="btn_normal" id="shopcar_b_cancel">取 消</button></div><div class="hint_other"></div>\
			</div>\
		</div>';
		o['title']='提示';
		$.inCart1.init(obj,o,template);
		$('#shopcar_b_cancel').click(function(){
			$.inCart1.close();
		});
		$.inCart1.show(o,obj);
	};
	$.inCart1.init = function(obj, o , content) {
		var $inCart = $('#inCartDiv');
		if($inCart.length == 0){
			$inCart = $('<div id="inCartDiv" class="module_box_normal"></div>');
			$inCart.html('<div class="box_title"><h4 id="inCartDiv_title"></h4><a href="###" class="bt_close" id="inCartDiv_closer"></a></div><div id="inCartContent"></div>');
			$(document.body).append($inCart);
			$('#inCartDiv_closer').click(function(){
				$.inCart1.close();
			});
		}
		$('#inCartDiv_title').html(o.title);
		$('#inCartContent').addClass(o.contentClass).html(content);
	};
	$.inCart1.show = function(o,obj){
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
	$.inCart1.close = function(){
		var $inCart = $('#inCartDiv');
		if($inCart.length>0){
			$inCart.hide();
		}
	};
})(jQuery);
function tcdes(id)
{
   var obj=$("#des"+id);
   if(obj!=null)
	   {
	     obj.css("margin-top",-$('#tc_sel_attr_wrap').scrollTop()-5+"px");
	    
	     obj.css("display","block");
	   }
}

function hidedes(id)
{
   var obj=$("#des"+id);
   if(obj!=null)
	   {
	     obj.css("display","none");
	   }
}