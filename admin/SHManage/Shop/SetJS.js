function SCTPinit()
{
	var shopcode=$('#hshopcode').val();
	/* 上传图片初始化*/	
	 $("#uploadify").uploadify({
	   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
	   'script'         : '/servlet/Upload',
	   'method' :'GET',
	   'cancelImg'      : '/res/js/uploadify/cancel.png',
	   'folder'         : '/opt/shopimg/gdsimg',

	   'queueID'        : 'fileQueue',//与下面的id对应
	   'queueSizeLimit'  :1, 
	   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
	   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',                 
	   'auto'           : true,
	   'multi'          : false,
	   'sizeLimit': 512000,
	   'buttonImg':'http://images.d1.com.cn/zt2013/icon/choose.png',	   
	   'hideButton':true, 
	   'buttonText'     : 'BROWSE',
	    'onComplete': function (event, queueID, fileObj, response, data) {//返回函数		
	    	if(response.indexOf(';')>0){
	    		   var str_arr=response.split(';');
	    		   if(str_arr.length==3){
	    		    //获取宽和高判断
	    			 
	    			   var w_arr=str_arr[1];
	    			   var h_arr=str_arr[2];
	    			   if(w_arr==1920){
							var imgurl2="http://www.d1.com.cn"+str_arr[0]+"?"+Math.round(Math.random()*100000);
							$('#background_img').html('');
							$('#background_img').append("<a href='"+("http://www.d1.com.cn"+str_arr[0])+"' target='_blank'><img src='"+imgurl2+"' width=\"830\" height=\"94\"/></a>");
							$('#himgurl').val(str_arr[0]);
	    				   
	    			   }
	    			   else{
	    				   alert('上传图片尺寸错误，请上传宽度为1920的图片！');
	    			   }
	    		   }
	    	   }
	       }
	    

	});	
}
function SaveLogo()
{
   var logoimg=$('#sh_logo').val();
   var hshopcode = $('#hshopcode').val();
   if(logoimg=='' && hshopcode != '00000000' && hshopcode != '13100902'){
	   alert('请添加店铺招牌！');
	   return;
   }
   $.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/Shop/AddShopLOGO.jsp',
		cache: false,
		data: {img:logoimg},
		error: function(XmlHttpRequest){
			alert("上传店铺招牌出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){	
				$('#shop_id').val(json.val);
				alert(json.message);
			}
			else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function Savebackg_img(){//添加店招背景图
   var shopid=$('#shop_id').val();
   if(shopid == 'null'){
		shopid = -1;//添加
   }
   if(shopid==''){
	   alert('请先保存LOGO图！');
	   return;
   }
   var logoimg=$('#himgurl').val();
   //alert(logoimg+"===");
   $.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/Shop/AddBackgroundImg.jsp',
		cache: false,
		data: {sid:shopid,img:logoimg},
		error: function(XmlHttpRequest){
			alert("上传店铺首张广告图出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){	
				$('#shop_id').val(json.shop_id);
				alert(json.message);
			}else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function SaveLogo_1()
{   
   var shopid=$('#shop_id').val();
   if(shopid == 'null'){
	   shopid = -1;//添加
   }
   if(shopid==''){
	   alert('请先保存LOGO图！');
	   return;
   }
   var logoimg=$('#bgimg').val();
  /* if(logoimg==''){
	   alert('请添加店铺首张广告图！');
	   return;
   }*/
   $.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/Shop/AddShopLOGOImg.jsp',
		cache: false,
		data: {sid:shopid,img:logoimg},
		error: function(XmlHttpRequest){
			alert("上传店铺首张广告图出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){	
				$('#shop_id').val(json.shop_id);
				alert(json.message);
			}else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function SaveZtGoods()
{
   var shopid=$('#shop_id').val();
   if(shopid==''){
	   alert('请先保存LOGO图！');
	   return;
   }
   if(shopid == 'null'){
	   shopid = -1;//添加
   }
   var shopinfo_title = $("#shopinfo_title").val();
   if(shopinfo_title == ''){
 	   alert('请输入专题名称！');
 	   return;
   }
   var ztgoods=$.trim($('#ztgdsmst').val().replace("，", ","));
   var cc=$('#bgcolor').val();
   if(cc==''){
	   cc='ffffff';
   }else{
	   if(cc.length!=6){
		   alert('请输入6位的颜色值，不用添加’#‘号！');
		   return;
	   }
   }
   
   var cw_gdsid='';
   var zq_gdsid='';
   if(ztgoods!='' && ztgoods!=null){
	   var arr=ztgoods.split(',');
	   for (i=0;i<arr.length ;i++ )   
	   {   
	       if(arr[i].length!=8 && arr[i].length != 4){
	    	   cw_gdsid+=arr[i]+',';
	       }
	       else{
	    	   zq_gdsid+=arr[i]+',';
	       }
	   }
	   if(cw_gdsid.length>0){
		   alert('以下商品编号不正确，请重新填写，错误的有：'+cw_gdsid.substr(0,cw_gdsid.length-1));
		   return;
	   }
	   zq_gdsid=zq_gdsid.substr(0,zq_gdsid.length-1);
   }
   //var fp=$('#floatpos  option:selected').val();
   var fp='';
   var fc='';
   $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/Shop/AddZtGdsmst.jsp',
		cache: false,
		data: {sid:shopid,goods:zq_gdsid,color:cc,fpos:fp,fcon:fc,shopinfo_title:shopinfo_title},
		error: function(XmlHttpRequest){
			alert("添加主推商品出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){					
				$("#shop_id").val(json.shop_id);
				alert(json.message);
			}
			else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}   
function AddModeDetail(type)
{
  var shopid=$('#shop_id').val();//获取shop_info的id,以便保存到shopmodel中关联起来
  var modeid=$('#hmodeid'+type).val();
  var type1=$('#mode_type'+type+' option:selected').val();
  var cc='';
  var title=$('#mode_titile'+type).val();  
  var flag=$('#mode_flag'+type+' option:selected').val();
  var seq=$('#mode_seq'+type).val();
  var tpcc='';  
  if(type1=='1'){
	  cc=$('#mode_html'+type).val();  
  }else{
	  cc=$.trim($('#mode_gdsmst'+type).val());
	  tpcc=$('#mode_tpcc'+type).val();
	  if(title==''){
		 title='ffffff';
	  }else{
		  if(title.length!=6){
			  alert('颜色值必须是6位，前面不用加‘#’号！');
			  return;
		  }
	  }
	  var model_txt=$('#mode_txt'+type).val();
	  var model_txtcolor=$('#mode_txtcolor'+type).val();
	  var model_txtmore=$('#mode_txtmore'+type).val();
	  var shopmodel_balloon = $("input[name='shopmodel_balloon"+type+"']:checked").val();
	  var shopmodel_balname=$('#shopmodel_balname'+type).val();
	  var gdsnum=$('#mode_gdsnum'+type).val();
	  //alert(shopmodel_balloon);
	  if(typeof shopmodel_balloon == "undefined"){
		  shopmodel_balloon = '-1';
	  }
	  
	  if(model_txtcolor==''){
		  model_txtcolor='F65D57';
	  }else{
		  if(model_txtcolor.trim().length!=6){
			  alert('标题颜色值必须是6位，前面不用加‘#’号！');
			  return;
		  }
	  }
  }
  
  if(cc==''){
	  alert('请输入详细信息！');
	  return;
  }
  //判断是否选中'商品秒杀起止时间和特卖会起止时间一致'
  var tm_flag = $("input[name='tm_flag"+type+"']:checked").val();
  if(typeof tm_flag == 'undefined'){//未选中，不做处理。
	  tm_flag = '-1'; 
  	//alert("未选中");
  }else{//选中之后，特卖会效果的起止时间必须填写
  	var tm_begin = $("#tm_begin").val();
  	var tm_end = $("#tm_end").val();
  	if(tm_begin == ''){
  		alert("请输入特卖会的开始时间！");
  		return false;
  	}
  	if(tm_end == ''){
  		alert("请输入特卖会的结束时间！");
  		return false;
  	}
  }
  //设置排序，值为1为勾选
  var shopmodel_orderflag = $("input[name='tm_order"+type+"']:checked").val();
  if(typeof shopmodel_orderflag == 'undefined'){
	  shopmodel_orderflag = '0';
  }
  $.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/Shop/AddMode.jsp',
		cache: false,
		data: {mid:modeid,type:type1,type_num:type,c:cc,t:title,f:flag,s:seq,size:tpcc,shopid:shopid,model_txt:model_txt,model_txtcolor:model_txtcolor,model_txtmore:model_txtmore,shopmodel_balloon:shopmodel_balloon,shopmodel_balname:shopmodel_balname,tm_flag:tm_flag,shopmodel_orderflag:shopmodel_orderflag,gdsnum:gdsnum},
		error: function(XmlHttpRequest){
			alert("添加模块出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){					
				alert(json.message);
				if(modeid==''){
					$('#hmodeid'+type).val(json.val);
				}
			}
			else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function DeleteModeDetail(type)
{
   	var mid=$('#hmodeid'+type).val();
   	if(mid==''){
   		alert('该模块不存在于系统中，不能完成删除操作！');
   		return;
   	}
   	$.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/Shop/deleteMode.jsp',
		cache: false,
		data: {mid:mid},
		error: function(XmlHttpRequest){
			alert("删除模块出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){					
				alert(json.message);
				location.reload();
			}
			else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function AddModel()
{
	var index_flag = $("#index_flag").val();
	var shopinfo_title = $("#shopinfo_title").val();
   if(shopinfo_title == '' && index_flag != 0){//不为0,表示是专题页
	   alert("请先填写专题名称");
	   return false;
   }
   var dis=$('#display').val();
   if(parseInt(dis)==22){
	   alert('您最多只能添加二十二个模块！');
	   return;
   }
   $('#mode_'+(parseInt(dis)+1)).css('display','block');
   $('#display').val(parseInt(dis)+1);
}

function changes(obj,f)
{
   var sv=$(obj).find('option:selected').val();
   if(sv=='1'){
	   $('#mode_h'+f).css('display','block');
	   $('#mode_list'+f).css('display','none');
   }
   else{
	   $('#mode_h'+f).css('display','none');
	   $('#mode_list'+f).css('display','block');
   }
}
function DeleteLogoBgImg()
{
   var shopid=$('#shop_id').val();
	   if(shopid==''){
		   alert('请先保存LOGO图！');
		   return;
	   }   
   $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/Shop/DeleteShopLOGOImg.jsp',
		cache: false,
		data: {sid:shopid},
		error: function(XmlHttpRequest){
			alert("删除店铺招牌背景出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){	
				$('#bgimg').html('');
				$('#himgurl').val('');
				alert(json.message);
			}
			else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}   

function SaveZtGoods_1(){
    var shopid=$('#shop_id').val();
	   if(shopid==''){
		   alert('请先保存LOGO图！');
		   return;
	}   
    var fc=$('#floatcontent').val();
    /*
	if(fc=='')
	{
	    alert('您没有添加浮动广告信息内容，不能保存！');
		return;
	}*/
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/Shop/AddPos.jsp',
		cache: false,
		data: {sid:shopid,con:fc},
		error: function(XmlHttpRequest){
			alert("添加浮动广告信息出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){	
				alert(json.message);
			}
			else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function SaveShopMore(){
	var index_flag = $('#index_flag').val();
	var shopid=$('#shop_id').val();
	if(shopid == 'null'){
		shopid = -1;//添加
	}
	if(shopid==''){
		alert('请先保存LOGO图！');
		return;
	}
	var logoimg=$('#bgimg').val();
    var shopinfo_title = $("#shopinfo_title").val();
    if(shopinfo_title == '' && index_flag == 0){
 	   alert('请输入专题名称！');
 	   return;
    }
    var ztgoods=$.trim($('#ztgdsmst').val().replace("，", ","));
    var cc=$('#bgcolor').val();
    if(cc==''){
	   cc='ffffff';
    }else{
	   if(cc.length!=6){
		   alert('请输入6位的颜色值，不用添加’#‘号！');
		   return;
	   }
    }
   
    var cw_gdsid='';
    var zq_gdsid='';
    if(ztgoods!='' && ztgoods!=null){
	   var arr=ztgoods.split(',');
	   for (i=0;i<arr.length ;i++ )   
	   {   
	       if(arr[i].length!=8 && arr[i].length != 4){
	    	   cw_gdsid+=arr[i]+',';
	       }
	       else{
	    	   zq_gdsid+=arr[i]+',';
	       }
	   }
	   
	   if(cw_gdsid!="," && cw_gdsid!="," && cw_gdsid.length>0){
		   alert('以下商品编号不正确，请重新填写，错误的有：'+cw_gdsid.substr(0,cw_gdsid.length-1));
		   return;
	   }
	   zq_gdsid=zq_gdsid.substr(0,zq_gdsid.length-1);
    }
    var fc=$('#floatcontent').val();
    var tm_begin = $("#tm_begin").val();
    var tm_end = $("#tm_end").val();
    var wapimg = $("#hsgimg").val();
    
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/Shop/AddShopMore.jsp',
		cache: false,
		data: {sid:shopid,img:logoimg,goods:zq_gdsid,color:cc,shopinfo_title:shopinfo_title,con:fc,tm_begin:tm_begin,tm_end:tm_end,wapimg:wapimg},
		error: function(XmlHttpRequest){
			alert("编辑信息出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){	
				$('#shop_id').val(json.shop_id);
				alert(json.message);
			}else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
	
}


function OnLine()
{
	var shopid=$('#shop_id').val();
	   if(shopid==''){
		   alert('请先保存LOGO图！');
		   return;
	}  
	   $.ajax({
			type: "get",
			dataType: "json",
			url: '/admin/ajax/Shop/Line.jsp',
			cache: false,
			data: {sid:shopid,type:'1'},
			error: function(XmlHttpRequest){
				alert("上线出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.succ){	
					$("#shopinfo_lineflag").val(json.shopinfo_lineflag);
					alert(json.message);
				}
				else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
}
function OutLine(){
	var shopid=$('#shop_id').val();
	   if(shopid==''){
		   alert('请先保存LOGO图！');
		   return;
	}  
	   $.ajax({
			type: "get",
			dataType: "json",
			url: '/admin/ajax/Shop/Line.jsp',
			cache: false,
			data: {sid:shopid,type:'0'},
			error: function(XmlHttpRequest){
				alert("下线出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.succ){	
					$("#shopinfo_lineflag").val(json.shopinfo_lineflag);
					alert(json.message);
				}
				else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
}