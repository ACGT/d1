///////////////////////////////
function formatPrice(A){
    var B = String(A);
    if(B.indexOf('.') != -1){
    	B = Math.round(Number(B)*100)/100;
        B = String(B);
        var C =B.substring(B.indexOf('.')).length;
        if(C == 2)
        {
            B = B+'0';
        }
    }
    return B;
}
/* *
 * 修改购买数量：页面
 */
function addorminus(opr,car_id,rec_key){
	var cart = $('#cart_'+rec_key);
	var numInput = $('#num_input_' + rec_key);
	var forenum = Number(numInput.attr('objNum'));
	var new_val = Number(numInput.val());
	
	var num = 0;
	switch(opr){
		case 'add':
			num = parseInt(new_val) + 1;
			numInput.val(num);
			numInput.focus();
			numInput.blur();
			isblur = 1;
			break;
		case 'minus':
			if (new_val >1){
				num = parseInt(new_val) - 1;
				numInput.val(num);
				numInput.focus();
				numInput.blur();
				isblur = 1;
			}else{
				$('#del_'+rec_key).get(0).onclick();
			}
			break;
		case 'change':
			if (new_val >=1){
				num = parseInt(new_val);
				var change = Number(num - forenum);
				numInput.val(num);
				$('#num_input_' + rec_key).attr('objNum',num);
			}
			break;
	}
}

/* *
 * 修改购买数量：数据库
 */
function updatecart(car_id,rec_key){
	var obj =$('#num_input_' + rec_key);
	var forenum = obj.attr('objNum',forenum);
	var num = obj.val()||forenum;

	if(!isMath(num)){//数量有错误.
		obj.val(forenum);
	    return false;
	}else{
		num = parseInt(num);
		if(num=='' || num == '0' ||num <= 0){
			obj.val(forenum);
		    return false;
		}else{
			//数量没有改变
			if(forenum == num){
				obj.val(forenum);
		        return false;
		    }
		    obj.val(num);
		}
	}
	addorminus('change',car_id,rec_key);
	
	$.post("/ajax/flow/updateCart.jsp", {"car_id":car_id,"goods_number":num,"rec_key":rec_key,"m":new Date().getTime()},function(json){
		switch(json.error){
			case -1://参数错误
				window.location.reload();
				break;
			case -2://需要提示信息
				obj.val(forenum);
				addorminus('change',car_id,rec_key);
				if(json.message != ''){
					$.showAlert($(obj),json.message,204);
				}
				break;
			case -3://物品超过库存，或者物品下架啥的。
				obj.val(forenum);
				addorminus('change',car_id,rec_key);
				if(json.message != ''){
					$('#num_tip_'+rec_key).html(json.message);
	                $('#num_tip_'+rec_key).show();
				}else{
					$('#num_tip_'+rec_key).hide();
				}
				break;
			case -4://物品被清空的状态。
				CartEmptyResponse(json);
				break;
			case -5://物品没了
				$('#cart_'+rec_key).remove();
				$('#cart_goods_area > tr[attribute='+car_id+']').remove();
				break;
			default:
				obj.val(json.content.goods_number);
            	obj.attr('objNum',json.content.goods_number);
            	$('#subtotal_'+rec_key).html(formatPrice(json.content.subtotal));
            	$('#prefrePrice_'+rec_key).html(formatPrice(json.content.prefrePrice));
            	//更新子类信息
            	var cart_type = json.content.cart_type;
            	var child_goods = json.content.child_goods;
            	if(child_goods.length > 0){
            		for(i=0;i<child_goods.length;i++){
            			$('#num_span_'+child_goods[i].rec_key).html(child_goods[i].goods_number);
            			if(cart_type < -4 && cart_type > -1){
	            			$('#prefrePrice_'+child_goods[i].rec_key).html(child_goods[i].prefrePrice);
	            			$('#subtotal_'+child_goods[i].rec_key).html(child_goods[i].subtotal);
            			}
            		}
            	}
            	//自动删除的商品删除
				var delete_goods_key = json.content.delete_goods_key;
		        var delete_goods_key_num = json.content.delete_goods_key.length;
		        if(delete_goods_key_num > 0){
		        	for(i = 0; i < delete_goods_key_num; i++){
		        		$('#cart_'+ delete_goods_key[i]).remove();
		            }
		        }
            	//自动删除赠品的提示
            	if(json.content.tishi_delete_favor != ''){
                  $('#delete_favor').html(json.content.tishi_delete_favor);
                  $('#delete_favor').show();
                }else{
                	$('#delete_favor').hide();
                }
            	//优惠活动赠品区域
                if(json.content.favor_out_cart > 0){
                  $('#zengpin_area').show();
                }else{
                  $('#zengpin_area').hide();
                }
                $('#zengpin_area').html(json.content.zengpin_area);
                $('#total_area').html(json.content.total_area);
                
                $.showAlert($(obj),'您的商品总金额为￥<span style="color:#C30;font-weight:bold;">'+formatPrice(json.content.totalPrice)+'</span>元',204,'修改成功！');
                
                getCartInfo();//KK
		}
	},"json");
}

function clearCart(obj){
	isblur = 1;
	$.showConfirm(obj,'<font color="#CA0809">确定要清空购物车列表吗？</a>',210,function(){
		$.post("/ajax/flow/removeAllCart.jsp",{"m":new Date().getTime()},function(json){
			if(json.success){
				CartEmptyResponse(json);
				$.showClose();
			}
		},"json");
	});
}

function removeCart(rec_key,isGift){
	$.post("/ajax/flow/removeCart.jsp",{"rec_key":rec_key,"m":new Date().getTime()},function(json){
		if(json.error==-1){
			window.location.reload();
		}else if(json.error == 2){
			CartEmptyResponse(json);
		}else{
			//删除子节点
			//自动删除的商品隐藏
			var child_goods = json.content.child_goods;
	        if(child_goods.length > 0){
	        	for(i = 0; i < child_goods.length; i++){
	        		$('#cart_'+ child_goods[i]).remove();
	            }
	        }
			//自动删除赠品的提示
            if(json.content.tishi_delete_favor != ''){
               $('#delete_favor').html(json.content.tishi_delete_favor);
               $('#delete_favor').show();
            }
            //优惠活动赠品区域
            if(json.content.favor_out_cart > 0){
              $('#zengpin_area').show();
            }else{
              $('#zengpin_area').hide();
            }
            $('#zengpin_area').html(json.content.zengpin_area);
            //删除的商品价格不为0，重新加载相关区域
            if(json.content.recalculate == 1){
            	$('#total_area').html(json.content.total_area);
            }
            $('#cart_'+rec_key).remove();
            
            //自动删除的商品删除
			var delete_goods_key = json.content.delete_goods_key;
	        var delete_goods_key_num = json.content.delete_goods_key.length;
	        if(delete_goods_key_num > 0){
	        	for(i = 0; i < delete_goods_key_num; i++){
	        		$('#cart_'+ delete_goods_key[i]).remove();
	            }
	        }
        	//自动删除赠品的提示
        	if(json.content.tishi_delete_favor != ''){
              $('#delete_favor').html(json.content.tishi_delete_favor);
              $('#delete_favor').show();
            }else{
            	$('#delete_favor').hide();
            }
        	
        	getCartInfo();//KK
		}
        $.showClose();
	},"json");
}

//购物车为空，页面的变化
function CartEmptyResponse(json){
	//主商品区域
	if(json.cart_goods_area != ''){
		$('#cart_goods_area').html("<p class='notCart'>"+json.cart_goods_area+"</p>");
	}else{
		$('#cart_goods_area').empty();
	}
	
	$('#zengpin_area').hide();//赠品物品区域
	$('#check_btn_area').hide();//结算按钮
	$('#total_area').empty().hide();//总金额
	
	//自动删除赠品的提示
	if(json.hasContent==1){
		if(json.content.tishi_delete_favor != ''){
	      $('#delete_favor').html(json.content.tishi_delete_favor);
	      $('#delete_favor').show();
	    }else{
	    	$('#delete_favor').hide();
	    }
	}
}
//点击删除链接
function clickRemove(obj,type,rec_key,is_child){
	var _this = $(obj);
    isblur = 1;
    if(type == '0'){
    	$.showConfirm(_this,'<font color="#CA0809">您确定要删除该赠品吗？</font>',200,function(){
    		removeCart(rec_key,1);
    	});
    }else{
    	//需要判断要不要涉及到删除赠品的需求上。
    	if(is_child == "1"){//主商品包含子类或者购物车中包含有赠品
    		$.post("/ajax/flow/checkDropGoods.jsp",{"rec_key":rec_key,"m":new Date().getTime()},function(json){
    			//参数错误
    			if(json.error == -1){
    				window.location.reload();
    				return;
    			}
    			//导致关联的子类被删除
    			if(json.error == 1){
    				$.showConfirm(_this,json.content,300,function(){
    					removeCart(rec_key,0);
    				});
    			}else{//子类活赠品不被删除
    				$.showConfirm(_this,'<font color="#CA0809">您确定要删除该商品吗？</font>',200,function(){
    					removeCart(rec_key,0);
    				});
    			}
    		},"json");
    	}else{
    		$.showConfirm(_this,'<font color="#CA0809">您确定要删除该商品吗？</font>',200,function(){
    			removeCart(rec_key,0);
    		});
    	}
    }
}

////////////////////////////////////window alter///////////////////////////
var isblur=0;
(function($){
	$.showAlert = function(obj,msg,w,title,fn){
		var f1;switch(true){case typeof(fn) == "string":f1 = new Function("e", fn);break;case fn instanceof Function:f1 = fn;break;default:f1 = function(){$.showClose();};break;}
		$('#locListDiv > .content').html(((typeof title !="undefined")?"<p>"+title+"</p>":"")+"<p>"+msg+"</p><p><a href='###' id='locClose'>关闭</a></p>");
		$('#locClose').click(function(){f1();});
		$('#locListDiv').show().css("width",w);
		var $obj = $(obj);
		var offset=$obj.offset();
		var x = (offset.left-(w-$obj.width())/2)+"px";
		var y = (offset.top-$('#locListDiv').outerHeight())+"px";
		$('#locListDiv').css({left:x,top:y});
	}
	
	$.showConfirm = function(obj,msg,w,fn,fc){
		var f1;switch(true){case typeof(fn) == "string":f1 = new Function("e", fn);break;case fn instanceof Function:f1 = fn;break;default:f1 = function(){$.showClose();};break;}
		var f2;switch(true){case typeof(fc) == "string":f2 = new Function("e", fc);break;case fc instanceof Function:f2 = fc;break;default:f2 = function(){$.showClose();};break;}
		$('#locListDiv > .content').html("<p>"+msg+"</p><p><a href='###' id='locConfirm'>确定</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='###' id='locCancle'>取消</a></p>");
		$('#locConfirm').click(function(){f1();});
		$('#locCancle').click(function(){f2();});
		$('#locListDiv').show().css("width",w);
		var $obj = $(obj);
		var offset=$obj.offset();
		var x = (offset.left-(w-$obj.width())/2)+"px";
		var y = (offset.top-$('#locListDiv').outerHeight())+"px";
		$('#locListDiv').css({left:x,top:y});
	}
	
	$.showClose = function(){
		$("#locListDiv").hide();
		isblur = 0;
	}
	
	$.addEvent = function(){
		if(isblur==1 || $("#locListDiv").is(':hidden')){
			isblur=0;
			return;
		}
		var e=event||window.event;
		var sender=e.srcElement||e.target;
		var isShow_locListDiv=true;
		while(sender){
			if(sender!=$("#locListDiv").get(0)&&sender){
				sender=sender.offsetParent;
				isShow_locListDiv=false;
				continue;
			}else if(sender){
				isShow_locListDiv=true;
				break;
			}
		}
		if(!isShow_locListDiv){
			$.showClose();
		}
	}
})(jQuery);

var bb = 0;
///////////////////////////////////////////////////////////////
$(document).ready(function(){
	$(document).bind('click',function(){
		$.addEvent();
	});
	
	$('#checkout').live('click',function(){
		var objs=$('#havesku');
		if(objs.length>0){
			if(objs.val()>0){
				$.alert('对不起，您还有商品没选择规格，请先选择规格再继续结算！');
				return;
			}
		}
		/*var shopcode ='00000000';
		var req_shopcode = $('input[type=radio][name=shopcode]');
	    if (req_shopcode.length > 0){
	    	req_shopcode.each(function(){
	    		if(this.checked){
	    			shopcode = this.value;
	    			return false;
	    		}
	    	});
	    }*/
		//$.post("/ajax/flow/checkAllCart.jsp",{"m":new Date().getTime(),"shopcode":shopcode},function(json){
		$.post("/ajax/flow/checkAllCart.jsp",{"m":new Date().getTime()},function(json){
			if(json.error > 0){
				//购物车为空
				 if(json.error == 2){
					 CartEmptyResponse(json);
				 }else if(json.error == 1){//购物车商品或赠品有变化 
					//自动删除的商品删除
					var delete_goods_key = json.content.delete_goods_key;
			        var delete_goods_key_num = json.content.delete_goods_key.length;
			        if(delete_goods_key_num > 0){
			        	for(i = 0; i < delete_goods_key_num; i++){
			        		$('#cart_'+ delete_goods_key[i]).remove();
			            }
			        }
			        //自动删除赠品的提示
	            	if(json.content.tishi_delete_favor != ''){
	                	$('#delete_favor').html(json.content.tishi_delete_favor);
	                	$('#delete_favor').show();
	                }else{
	                	$('#delete_favor').hide();
	                }
			        //优惠活动赠品区域
			        if(json.content.favor_out_cart > 0){
			        	$('#zengpin_area').show();
			        }else{
			        	$('#zengpin_area').hide();
			        }
			       // if(shopcode=="00000000"){
			        $('#zengpin_area').html(json.content.zengpin_area);
			       // }
			        $('#total_area').html(json.content.total_area);
				 }
				 location.href = '#cart_top';
			}else if(json.error == 0){
				window.location.href = '/flowCheck.jsp';
			}else if(json.error == -1){
				$.confirm("您还没有选择赠品，是否立即结算？","提示","window.location.href = '/flowCheck.jsp'");
			}else if(json.error == -2){
				$.alert("您须购物满299元才能免费获得围巾");
			}else if(json.error == -3){
				var f=json.content;
				showmsg('',f,1);
			}else if(json.error == -4){
				var f=json.content;
				showmsg('',f,2);
			}else if(json.error == -5){
				var f=json.content;
				showmsg('',f,3);
			}else if(json.error == -6){
				$.alert('由于您不是第一次购物，不能享受第一次购物专属独享价！','提示',function(){
					$.ajax({
				        type: "post",
				        dataType: "text",
				        url: "/ajax/flow/updateCartPrice.jsp",
				        cache: false,
				        error: function(XmlHttpRequest){
				            alert("更新价格失败，请重新再试或者联系客服处理！");
				        },
				        success: function(json){
				        	if(json==1){
				        		window.location.href="/flow.jsp";
					        	}else{
				        			alert("更新价格失败，请重新再试或者联系客服处理！");
				        		}
				        	 },beforeSend: function(){
				        }
				    });	
					});
			}else if(json.error == -7){
				var f=json.content;
				showmsg('',f,4);
			}
			else if(json.error == -8){
				$.alert("您的购物车中没有兑换的Zippo，无法获取Zippo大礼盒！");
			}else if(json.error == -9){
				$.alert("兑换一个Zippo只能获取一个Zippo大礼盒！");
			}else if(json.error == -10){
				$.alert("您需要再购买一件商品即可0元领取");
			}else if(json.error == -11){
				$.alert("每个订单只能加5件打底裤赠品！");
			}else if(json.error == -12){
				$.alert("您必须购买其他任意商品才能获得此台历！");
			}else if(json.error == -13){
				$.alert("您须买化妆品满299元才能获得“The Face Shop 植物绿豆洗面奶”！");
			}
			
		},"json");
	});
});
function showmsg(c,lastmoney,type){
	$.close(); var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("结账提醒",450,"/html/zt2012/20121015zp/lastmoney.jsp?lastmoney="+lastmoney+"&type="+type);

	}

function test(c){$.close();var zpid=$("#zpid").val(); var lastmoney=$("#lastmoney").val();  var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("结账提醒",680,"/ajax/dialog/gb.jsp"+s+"&zpid="+zpid+"&lastmoney="+lastmoney);}

function fmmap(c,lastmoney,type){$.close();  var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("结账提醒",680,"/ajax/dialog/fmcap.jsp"+s+"&lastmoney="+lastmoney+"&type="+type);}





function getconfirm(){
	var msg='<table cellpadding="0" cellspacing="0" style="border:solid 1px #8F0100;">\
		<tr><td colspan="2" style="background:#8F0100; width:646px; height:30px; vertical-align:middle;" valign="middle">\
		<div style="margin-bottom:0px; float:left; margin-left:5px;"><span style="color:#FFFFFF; font-size:14px; font-weight:bold;">结账提醒</span></div>\
		<div style="float:right; margin-right:8px; margin-top:3px;"><a href=""><img src="http://images.d1.com.cn/images2012/1.png"  alt="关闭" border="0"/></a></div>\
		</td></tr>\
		<tr><td>\
		<div style="padding-left:20px; padding-top:20px; padding-bottom:20px;float:left "><img src="http://images.d1.com.cn/images2012/2.png"/></div>\
		</td>\
		<td valign="middle"><div style="padding-top:0px; padding-right:20px; float:right ;"><span style="font-size:15px;">很抱歉，您选择的以下赠品无法领取，请返回购物车修改或放弃赠品直接结账。</span></div></td>\
		</tr>\
		<tr><td colspan="2">\
		<div style=" padding-left:140px; float:left; padding-bottom:30px;"><a href=""><img src="http://images.d1.com.cn/images2012/3.png"  alt="返回购物车" border="0"/></a></div>\
		<div style="padding-right:140px; float:right;padding-bottom:30px;"><a href=""><img src="http://images.d1.com.cn/images2012/4.png"  alt="立即结算" border="0"/></a></div>\
		</td></tr>\
		<tr><td colspan="2">\
		<div style=" padding-left:30px; float:left; padding-bottom:10px;"><span style="font-weight:bold; font-size:16px;">无法领取赠品清单：</span><br/>\
		<table cellpadding="0" cellspacing="0" style="border:solid 1px #C68EA7; width:580px;">\
		<tr><td style="border-bottom:solid 1px #CCCCCC;">商品/商品号</td><td></td><td style="border-bottom:solid 1px #CCCCCC;">单价</td></tr>\
		</table>\
		</div>\
		</td></tr>\
		</table>';
	
	$(".form").html(msg);
	
	var yscroll =document.documentElement.scrollTop;
	$("#faqdiv").css("top","100px");
	$("#faqdiv").css("display","block");
	document.documentElement.scrollTop=0;
}

function addFavorite(id){
	$.post("/ajax/product/favoriteAdd.jsp",{"id":id},function(json){
		$.alert(json.message);
	},"json");
}

function delFavorite(id,obj){
	if(!window.confirm('您确认要删除吗？')) return;
	$.post("/ajax/product/favoriteDel.jsp",{"id":id},function(json){
		if(json.success){
			var tr = $(obj).parent().parent();
			var table = tr.parent();
			tr.remove();
			if(table.find("tr").length==0){
				$('#favorite').hide();
			}
		}else{
			$.alert(json.message);
		}
	},"json");
}

function getCartInfo(){
	$.post("/ajax/flow/getCartInfo.jsp",{"m":new Date().getTime()},function(json){
		if(json.error == 0){
			$('#cart_goods_area').html(json.content.cart_goods_area);
			$('#total_area').html(json.content.total_area).show();
			//优惠活动赠品区域
            if(json.content.favor_out_cart > 0){
              $('#zengpin_area').show();
            }else{
              $('#zengpin_area').hide();
            }
            $('#zengpin_area').html(json.content.zengpin_area);
		}else{
			CartEmptyResponse(json);
		}
	},"json");
}

function addCart(obj){
	$.inCart(obj,{succButton:false,onComplete:function(){
		getCartInfo();
		$('#check_btn_area').show();
	}});
}
function addGiftCart(obj){
	$.inCart(obj,{ajaxUrl:'/ajax/flow/listGiftInCart.jsp',succButton:false,goodsType:1,onComplete:function(){
		getCartInfo();
	}});
}

//在购物车里选择sku
function rechoosesku(gdsid,cartid,name)
{
	
 if(gdsid.length<=0||cartid.length<=0){
	   $.alert('商品编号不正确或者记录不存在！');
	   return;
   }	
   var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}
   $.load("请选择商品"+name,536,"/ajax/flow/updatecartbysku.jsp?id="+cartid);
}