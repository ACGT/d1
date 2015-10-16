//新增收货人
function AddMbrcst_wap(type){
	var i=0;
	var strName = $.trim($('#txtName').val());
    var strSex = $('input[type=radio][name=rdoSex]:checked').val();
    if(strSex==null){
    	strSex=0;
    	i=1;
    }
  
    var strProvinceID = $('#ddlProvince').val();
    var strCityID = $('#ddlCity').val();
    var strRAddress = $.trim($('#txtRAddress').val());
    var strRPhone = $.trim($('#txtRPhone').val());
    var strTelePhone = $.trim($('#txtTelePhone').val());
    var strREmail = $.trim($('#txtREmail').val());
    var strRZipcode = $.trim($('#txtRZipcode').val());
    var strMbrcstID = $.trim($('#hdnMbrcstID').val());
    var MbrcstAction = $.trim($('#MbrcstAction').val());
    var isAdd = (MbrcstAction=="new_save_consignee"?true:false);
   
    var blnOK = CheckMbrcst(strName, strProvinceID, strCityID, strRAddress, strRPhone, strTelePhone, strREmail, strRZipcode);
   
    if (blnOK){
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/ajax/user/address_add.jsp",
            cache: false,
            data:{
		        MbrcstID: strMbrcstID,
		        Name: strName,
		        Sex: strSex,
		        ProvinceID: strProvinceID,
		        CityID: strCityID,
		        RAddress: strRAddress,
		        RPhone: strRPhone,
		        TelePhone: strTelePhone,
		        REmail: strREmail,
		        RZipcode: strRZipcode,
		        Action: MbrcstAction
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
		    	var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.removeAttr('disabled');
                btnSaveMbrcst.removeClass('WaitSaveMbrcst');
                btnSaveMbrcst.addClass('SaveMbrcst');
                btnSaveMbrcst.attr('value', '');
                alert('添加收货人失败！');
                spanMbrcstMsg.html('添加收货人失败！');
                spanMbrcstMsg.show();
                setInterval(FadeOutMbrcstMsg, iInterVal);
            },success: function(strRet){
                var iRet;
                var iMbrcstID;
                eval(strRet);
                var spanMbrcstMsg = $('#spanMbrcstMsg');
               
                switch (iRet){
                    case -201:
                        alert('会员ID参数出错！');
                        spanMbrcstMsg.html('会员ID参数出错！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -202:
                        alert('姓名超过20个字符长度(一个汉字占两个字符)！');
                        spanMbrcstMsg.html('姓名超过20个字符长度(一个汉字占两个字符)！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -203:
                        alert('请选择省份！');
                        spanMbrcstMsg.html('请选择省份！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -204:
                        alert('请选择城市！');
                        spanMbrcstMsg.html('请选择城市！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -205:
                        alert('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.html('地址超200个字符(一个汉字占两个字符)！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -206:
                        alert('已存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.html('已存在相同姓名和地址的收货人！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case -207:
                        alert('添加收货人失败！');
                        spanMbrcstMsg.html('添加收货人失败！');
                        spanMbrcstMsg.show();
                        setInterval(FadeOutMbrcstMsg, iInterVal);
                        break;
                    case 1:
                    	 
                    	if(isAdd){
                            spanMbrcstMsg.hide();
                            if(typeof type == 'undefined'){
    	                        AppendMbrcstRow(iMbrcstID);
    	                        CancelMbrcst();
                            }else{
                            	if(i==1){
                            		$('#fist').css("display","none");
                            		$('#second').css("display","none");
                            		$('#third').css("display","none");
                            		$('#info').css("display","block");
                            		$('#info').html("地址簿保存成功！<br/>您可以返回<a href=\"/wap/user/address.jsp\">我的地址簿</a>或<a href=\"/mindex.jsp\">返回首页</a>");
                            			}
                            	else{window.location.href='/flowCheck.jsp';}
                            }
                    	}else{
                    		
                    		if(i==1){
                    			$('#hdnMbrcstID').val("0");
                    			$('#MbrcstAction').val("update_save_consignee");
                    			$('#fist').css("display","none");
                        		$('#second').css("display","none");
                        		$('#third').css("display","none");
                        		$('#info').css("display","block");
                    			$('#info').html("修改收货人信息成功！<br/>您可以返回<a href=\"/wap/user/address.jsp\">我的地址簿</a>或<a href=\"/mindex.jsp\">返回首页</a>");
                        			}
                             
                            
                    	}
                        break;
                }
            },beforeSend: function(){
                var btnSaveMbrcst = $('#btnSaveMbrcst');
                btnSaveMbrcst.attr('disabled', 'disabled');
                btnSaveMbrcst.attr('value', '  保存中,请稍等...');
            },complete: function(){
            	if(typeof(type) == 'undefined'){
	                var btnSaveMbrcst = $('#btnSaveMbrcst');
	                btnSaveMbrcst.removeAttr('disabled');
            	}
            }
        });
    }
}

//填充修改收货人信息表单
function FillUpdateMbrcst_wap(modMbrcst){
    var ddlProvince = $('#ddlProvince');
    if (ddlProvince.get(0).options.length <= 1){
        BindProvince(modMbrcst.ProvID);
    }
    $('#txtName').val(modMbrcst.Name);
    BindProvCity(modMbrcst.ProvID, modMbrcst.CityID);
    $('#ddlProvince').val(modMbrcst.ProvID);
    $('#ddlCity').val(modMbrcst.CityID);
    $('#txtRAddress').val(modMbrcst.RAddress);
    $('#txtRPhone').val(modMbrcst.RPhone);
    $('#txtTelePhone').val(modMbrcst.RTelephone);
    $('#txtREmail').val(modMbrcst.REmail);
    $('#txtRZipcode').val(modMbrcst.RZipCode);
}


//获得某一收货人信息
function GetUpdMbrcst_wap(addId){
    
    $.ajax({
        type: "post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/user/address_info.jsp",
        cache: false,
        data:{id: addId,m: new Date().getTime()},
        error: function(XmlHttpRequest, textStatus, errorThrown){
        	$('#btnSaveMbrcst').removeAttr('disabled');
            alert(XmlHttpRequest.status + '-->' + XmlHttpRequest.statusText);
        },
        success: function(json){
        	if(json.success){
        		FillUpdateMbrcst_wap(json);
        	    //显示表单
        	    $('#hdnMbrcstID').val(addId);
        	    $('#MbrcstAction').val("update_save_consignee");
        	}else{
        		var spanMbrcstMsg = $('#erroinfo');
        		alert(json.message);
                spanMbrcstMsg.html(json.message);
                spanMbrcstMsg.fadeIn(iSpeed);
                setInterval(FadeOutMbrcstMsg, iInterVal);
        	}
        },beforeSend: function(){
            $('#btnSaveMbrcst').attr('disabled', 'disabled');
        },complete: function(){
            $('#btnSaveMbrcst').removeAttr('disabled');
        }
    });
}

function addFavorite(id){
	$.post("/ajax/product/favoriteAdd.jsp",{"id":id,"m":new Date().getTime()},function(json){
		$.alert(json.message);
	},"json");
}


//搜索
function searchwap(obj) {
	var searchKey = $('#'+obj).val();
	
	if(searchKey == ""){
		alert("请输入您要搜索的商品名称");
		$('#'+obj).focus();
		return;
	}
    var url = "/wap/search.jsp?headsearchkey="+encodeURIComponent($('#'+obj).val());
    top.location.href=url;
}


//选择第二规格(尺寸、表盘颜色等)
function chooseskuname1(obj){
    var skuid = $("#sku");
    if (skuid==null) return;
    var skuid = skuid.find("a");
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass("current");
    		$(this).addClass("old");
    	});
    	$(obj).removeClass("old");
    	$(obj).addClass("current");
    	
    }
}


//遍历规格
function BLGG_wap(){
	var skuid = $("#sku");
    if (skuid==null){
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
function AddCart(param1){
	
	var counts=$('#amount').val();
	var sku2=BLGG_wap();
	if(typeof sku2 == 'undefined'){
		sku2 = "";
	}
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/wap/InCart_wap.jsp',
		cache: false,
		data: {gdsid:param1,count:counts,skuId:sku2},
		error: function(XmlHttpRequest){
			alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
				$.alert(json.message+"<a href=\"/wap/flow.jsp\">查看购物车</a>或<a href=\"/mindex.jsp\">继续购物</a>");
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
};

//商品限购
function Comparebuy(obj,rec_key)
{
	   var count=$(obj).val();
	   var buylimit=$(obj).attr("attr");
	   if(!isMath(count)){//数量有错误.
			$.alert('输入的数字不正确！');
		    return
	   }
	   if(count>buylimit&&buylimit!=0)
		   {
		   $.alert('对不起，该商品限购'+buylimit+"个，清重新输入购买数量!",'提示');
		   
		   }
	   else if(count<=0)
		   {
		   $.alert("输入格式错误，请输入大于0的数字！",'提示');
		   
		   }
	   else
		   {
	 
		   changeCart(obj,rec_key);
		   }
	  
}

//价钱格式化
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
//购物车数目更改
function changeCart(obj,rec_key)
{
	   var cart_id=$(obj).attr('carid');
	  var fornum=$(obj).val();
	  $.post("/ajax/flow/updateCart.jsp", {"car_id":cart_id,"goods_number":$(obj).val(),"rec_key":rec_key,"m":new Date().getTime()},function(json){
		switch(json.error){
			case -1://参数错误
			    alert(json.message);
				window.location.reload();
				break;
			case -2://需要提示信息
				$.alert(json.message,'提示');
			    $(obj).val(fornum);
				break;
			case -3://物品超过库存，或者物品下架啥的。
				$(obj).val(fornum);
				if(json.message != ''){
					$.alert("物品超出库存！");
				}else{
					}
				break;
			case -4://物品被清空的状态。
				//CartEmptyResponse(json);
				break;
			case -5://物品没了
				$('#cart_'+rec_key).remove();
				$('#cart1_'+rec_key).remove();
				$('#cart2_'+rec_key).remove();
				$('#cart3_'+rec_key).remove();
				break;
			default:
				$.alert("您的总商品金额为："+formatPrice(json.content.totalPrice)+"元");
				$(obj).val(json.content.goods_number);
         	$('#total').html(formatPrice(json.content.totalPrice)+"元");
             
            
		}
	},"json");
}


function removeCart(rec_key,isGift){
	$.post("/ajax/wap/removeCart.jsp",{"rec_key":rec_key,"m":new Date().getTime()},function(json){
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
	        		$('#cart1_'+ child_goods[i]).remove();
	        		$('#cart2_'+ child_goods[i]).remove();
	        		$('#cart3_'+ child_goods[i]).remove();
	            }
	        }
			//自动删除赠品的提示
            if(json.content.tishi_delete_favor != ''){
               $('#delete_favor').html(json.content.tishi_delete_favor);
               $('#delete_favor').show();
            }
            
            //删除的商品价格不为0，重新加载相关区域
            if(json.content.recalculate == 1){
            	$('#total').html(json.content.total_area);
            }
            $('#cart_'+rec_key).remove();
            $('#cart1_'+rec_key).remove();
            $('#cart2_'+rec_key).remove();
            $('#cart3_'+rec_key).remove();
            
            //自动删除的商品删除
			var delete_goods_key = json.content.delete_goods_key;
	        var delete_goods_key_num = json.content.delete_goods_key.length;
	        if(delete_goods_key_num > 0){
	        	for(i = 0; i < delete_goods_key_num; i++){
	        		$('#cart_'+ delete_goods_key[i]).remove();
	        		$('#cart1_'+ delete_goods_key[i]).remove();
	        		$('#cart2_'+ delete_goods_key[i]).remove();
	        		$('#cart3_'+ delete_goods_key[i]).remove();
	            }
	        }
        	//自动删除赠品的提示
        	if(json.content.tishi_delete_favor != ''){
              $('#delete_favor').html(json.content.tishi_delete_favor);
              $('#delete_favor').show();
            }else{
            	$('#delete_favor').hide();
            }
        	
		}
        $.close();
	},"json");
}

//购物车为空，页面的变化
function CartEmptyResponse(json){
	//主商品区域
	if(json.cart_goods_area != ''){
		$('#all').html("<tr><td>"+json.cart_goods_area+"</td></tr>");
	}else{
		$('#all').empty();
	}

}

//点击删除链接
function clickRemove(obj,type,rec_key,is_child){
	var _this = $(obj);
    isblur = 1;
    if(type == '0'){
    	$.confirm('<font color="#CA0809">您确定要删除该赠品吗？</font>','提示',function(){
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
    				$.confirm(json.content,'提示',function(){
    					removeCart(rec_key,0);
    				});
    			}else{//子类活赠品不被删除
    				$.confirm('<font color="#CA0809">您确定要删除该商品吗？</font>','提示',function(){
    					removeCart(rec_key,0);
    				});
    			}
    		},"json");
    	}else{
    		$.confirm('<font color="#CA0809">您确定要删除该商品吗？</font>','提示',function(){
    			removeCart(rec_key,0);
    		});
    	}
    }
}




var bb = 0;
///////////////////////////////////////////////////////////////
$(document).ready(function(){
$(document).bind('click',function(){
//$.addEvent();
});
$('#checkout').live('click',function(){
$.post("/ajax/flow/checkAllCart_wap.jsp",{"m":new Date().getTime()},function(json){
	//alert(json.error);
if(json.error > 0){
	 if(json.error == 8){
		window.location.href = '/wap/login.jsp?url=/wap/flow.jsp';
		}else if(json.error == 9){
		window.location.href = '/wap/login.jsp?url=/wap/flowCheck.jsp';
		}
//购物车为空
		else if(json.error == 2){
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
$('#zengpin_area').html(json.content.zengpin_area);
$('#total_area').html(json.content.total_area);
}
location.href = '#cart_top';
}else if(json.error == 0){
window.location.href = '/wap/flowCheck.jsp';
}
},"json");
});
});


function vcode()
{
	var code=$('#code').val();
	var phone=$('#tele').val();
   	if(code=='')
   	{
   		$('#code_Notice').html('手机验证码不能为空！');
   		return;
   	}
   	else if(code.length>6)
   	{
   		$('#code_Notice').html('手机验证码位数不正确！');
   		return;
    }
   	else{
   	$.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/wap/validate_wap.jsp",
        cache: false,
        data:{phone: phone,param:'code',code:code},
        error: function(json){
           $('#code_Notice').html(json.message);
           return;
        },
        success: function(json){
            	if(!json.success){
            		$('#code_Notice').html(json.message);
            		return;
                }
            	else
            		{
            		$("#code_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
            		return;
            		}
        },beforeSend: function(){
        	$('#code_Notice').val('验证中...');
        },complete: function(){
        	$('#code_Notice').val('');
        }
    });
   	
	}
  
}

function vcode1()
{
	var code=$('#code').val();
	var phone=$('#tele').val();
   	if(code=='')
   	{
   		$('#code_Notice').html('手机验证码不能为空！');
   		return;
   	}
   	else if(code.length>6)
   	{
   		$('#code_Notice').html('手机验证码位数不正确！');
   		return;
    }
   	else{
   	$.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/wap/validate_wap.jsp",
        cache: false,
        data:{phone: phone,param:'code',code:code},
        error: function(json){
           $('#code_Notice').html(json.message);
           return ;
        },
        success: function(json){
            	if(!json.success){
            		$('#code_Notice').html(json.message);
            		return ;
                }
            	else
            		{
            		window.location.href="/wap/getpwd1.jsp?tele="+phone;
            		
            		}
        },beforeSend: function(){
        	$('#code_Notice').val('验证中...');
        },complete: function(){
        	$('#code_Notice').val('');
        	
        }
    });
   	
	}

}

