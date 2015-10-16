function levelClick(level,obj)
{
	var newlevel=(parseInt(level)+1);
	$("#level"+level+" ul li").css("border","solid 1px #fff");
	$("#level"+level+" ul li").removeClass('hover1');					
	$(obj).addClass('hover1');	
	$(obj).css("border","solid 1px #72bdff");			
	$('#lbl'+level+'').html('&nbsp;>&nbsp;'+$(obj).attr('attr1')+'&nbsp;');
	$('#lbl'+level+'_1').html('&nbsp;>&nbsp;'+$(obj).attr('attr1')+'&nbsp;');
	$('#hcode').val($(obj).attr('attr'));
	Bindgg($(obj).attr('attr'));
	Bindpp($(obj).attr('attr'));
	if(level<4)
	{
	   GetOtherRack(newlevel,$(obj).attr('attr'));
	}
	
	}
function GetOtherRack(level,rack)
{
	for(var i=Number(level)+1;i<=4;i++){
		$('#level'+i).css('display','none');
		$('#level'+i+'_1').css('display','none');
	}
	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getOtherRack.jsp",
        cache: false,
        data:{
        	code:rack,levels:level
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取分类出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){        	
        	$('#level'+level+'_1').css('display','block');
        	$('#level'+level).css('display','block');
        	$('#level'+level).html(strRet);
        	
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });
	
}

function IsEndCode(code){
	 $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/GetCode.jsp',
			cache: false,
			data: {c:code},
			error: function(XmlHttpRequest){
				alert("获取分类出错！");
			
			},success: function(json){			
				
			},beforeSend: function(){
			},complete: function(){
			}
		});
	
}

function AddDetail()
{
   if($('#lbl3').html()==''&&$('#lbl2').html()==''&&$('#lbl1').html()=='')	
   {
	   alert('请先选择分类！');
	   return;
   }
   else
   {
	  //判断是否是最后一级分类
	   var code=$('#hcode').val();	   
	   if($('#level4').css('display')=='block'&&$('#level4').html().trim().indexOf('没有分类！')<0&&code.trim().length==9){
		   alert('不是最后一级分类');return;
	   }
	   if($('#level4').css('display')=='none'&&code.trim().length==6&&$('#level3').html().trim().indexOf('没有分类！')<0)
	   {
		   alert('不是最后一级分类！');return;
	   }	
	   if(code.trim().length==3){
		   alert(code+'不是最后一级分类！');return;
	   }	
	  
	   $('#spfl').css('display','none');
	   $('#spdetail').css('display','block');
	   $.ajax({
	        type: "get",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
	        url: "/admin/SHManage/ProductLR.jsp?act=form_search&gdsmst_rackcode="+code,
	        cache: false,
	        error: function(XmlHttpRequest, textStatus, errorThrown){
		    	alert("获取属性出错，请稍后重试或者联系客服处理！");
	        },success: function(json){
	        	$(json).insertAfter($("#no_provide"));
	        }
	    });
   }
	   
}


function CXChooese()
{
   $('#spfl').css('display','block');
   $('#spdetail').css('display','none');
}

function Bindgg(obj)
{

	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getAttribute.jsp",
        cache: false,
        data:{
        	code:obj
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取属性出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){ 
        	$('#allgg').html(strRet);
        
        	//getSkuName(obj);        	
        		
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });

}

function addSku()
{
	/*if($('#skuname option:selected').text()=="无"){
		alert('不能添加SKU！');
		return;
	}*/
	if($('#skuname option:selected').text()=="规格"){
		if($('#xzsku').val()==''){
			alert('请输入SKU名称！');
			return;
		}
	}
	//if($('#xzsku').val()!='')
	//{
	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getSku.jsp",
        cache: false,
        data:{
        	sku:$('#xzsku').val(),type:'1'
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取属性出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){ 
        	$('#skutable tr:last').after(strRet);
        	$('#xzsku').val('');
        	if($('#skuname option:selected').text()=="无"){//SKU无时，点击一次之后，隐藏‘添加库存’按钮
        		$("#xz_kc").hide();
	    		return;
        	}
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });
	//}
	//else
	//	{
	//	alert('请输入SKU名称！');
	//	}
}

function deleteSku(obj)
{
	$(obj).parent().parent().remove();
}

function getSkuName(obj)
{
	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getSku.jsp",
        cache: false,
        data:{
        	code:obj,type:'2'
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取属性出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){        	
        	$('#skuname').html(strRet);
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });
}

function GetZK()
{
	var d1=$('#gdsmst_d1j').val();
	var scj=$('#gdsmst_scj').val();
	if(d1!=""&&scj!=""&&!isNaN(d1)&&!isNaN(scj))
	{
		if(Number(d1)>Number(scj)){ alert('D1价不得大于市场价！');return;}
		$('#gdsmst_zk').val(Number(d1/scj*10).toFixed(2)+'折');	
	}
	else
	{
		$('#gdsmst_zk').val('');
	}
   
}

function DisplayImage()
{
   $('#imagelist').css('display','block');
   $('#spdetail').css('display','none');
}

function deleteTP(str)
{
	$('#spzt'+str).html('');
	$('#himgurl'+str).val('');
}
function deleteTP1(str)
{
	var id=$('#del_zj'+(Number(str)-1)).val();
	var gdsid=$('#gdsid').val();
	if(id==''){
		alert('细节图不存在！');
		return;
	}
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/ShopM/Deleteimg.jsp',
		cache: false,
		data: {id:id,type:str,gdsid:gdsid},
		error: function(XmlHttpRequest){
			alert("删除图片出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){	
				$('#spzt'+str).html('');
				$('#himgurl'+str).val('');
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

function SCTPInit()
{
	var gdsid=$('#hgdsid').val();
	 /* 上传图片初始化*/	
	 $("#uploadify").uploadify({
	   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
	   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|1',
	   'method' :'GET',
	   'cancelImg'      : '/res/js/uploadify/cancel.png',
	   'folder'         : '/opt/shopimg/gdsimg',

	   'queueID'        : 'fileQueue',//与下面的id对应
	   'queueSizeLimit'  :1, 
	   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
	   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',                 
	   'auto'           : true,
	   'multi'          : false,
	   'sizeLimit': 5120000,
	   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
	   'hideButton':true, 
	   'buttonText'     : 'BROWSE',
	    'onComplete': function (event, queueID, fileObj, response, data) {//返回函数		
	    	if(response.indexOf(';')>0){
	    		   var str_arr1=response.split(';');
	    		   var imgurl1="http://www.d1.com.cn"+str_arr1[0]+"?"+Math.round(Math.random()*100000);
					$('#spzt').html('');
					$('#spzt').append("<img src='"+imgurl1+"' width=\"60\" height=\"60\"/>");	
					$('#cutimg').html('');
					$('#cutimg').append("<img src='"+imgurl1+"' width=\"75\" height=\"75\" style=\"margin-left:-7.5px;\"  />");
					$('#himgurl_1').val(str_arr1[0]);
					
	    	   }
	    		
	     
	    }

	});
	 //第二个
	 $("#uploadify1").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|2',
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',

		   'queueID'        : 'fileQueue1',
		   'queueSizeLimit'  :1, 
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',               
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
	       'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	
	    	   if(response.indexOf(';')>0){
	    		   var str_arr2=response.split(';');
	    		   if(str_arr2.length==3){
	    		    //获取宽和高判断
	    			   var w_arr=str_arr2[1];
	    			   var h_arr=str_arr2[2];
	    			   if(w_arr!=240&&h_arr!=300){
	    				   alert('上传图片尺寸错误，请上传240*300的图！');
	    			   }
	    			   else{
	    				    var mainimg2=$('#himgurl_1').val();
							var imgurl2="http://www.d1.com.cn"+str_arr2[0]+"?"+Math.round(Math.random()*100000);
							$('#spzt1').html('');
							$('#spzt1').append("<img src='"+imgurl2+"' width=\"60\" height=\"75\"/>");
							$('#himgurl1').val(str_arr2[0]);
							$('#himgurl_1').val(mainimg2);
	    			   }
	    		   }
	    	   }
	       }
		});
	 //细节图
	 $("#uploadify2").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|3',
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue2',
		   'queueSizeLimit'  :1, 	
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',            
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
	       'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	
	    		if(response.indexOf(';')>0){
	    			var mainimg3=$('#himgurl_1').val();
		    		   var str_arr3=response.split(';');
		    		   var imgurl3="http://www.d1.com.cn"+str_arr3[0]+"?"+Math.round(Math.random()*100000);
						$('#spzt2').html('');
						$('#spzt2').append("<img src='"+imgurl3+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
						$('#himgurl2').val(str_arr3[0]);
						$('#himgurl_1').val(mainimg3);
		    			 
		    	   }
				
				//SCXJT();				
	       }
		});
	//细节图2
	 $("#uploadify3").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|4',
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue3',
		   'queueSizeLimit'  :1, 	
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',            
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
	       'onComplete': function (event, queueID, fileObj, response, data) {//返回函数		    	  
				
				if(response.indexOf(';')>0){
					   var mainimg4=$('#himgurl_1').val();
					   var str_arr4=response.split(';');
		    		   var imgurl4="http://www.d1.com.cn"+str_arr4[0]+"?"+Math.round(Math.random()*100000);
						$('#spzt3').html('');
						$('#spzt3').append("<img src='"+imgurl4+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
						$('#himgurl3').val(str_arr4[0]);
						$('#himgurl_1').val(mainimg4);
		    		   
		    			 
		    	   }				
	       }
		});
	//细节图3
	 $("#uploadify4").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|5',
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue4',
		   'queueSizeLimit'  :1, 	
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',            
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
	       'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	
				if(response.indexOf(';')>0){
					var mainimg5=$('#himgurl_1').val();
		    		 var str_arr5=response.split(';');
		    		   var imgurl5="http://www.d1.com.cn"+str_arr5[0]+"?"+Math.round(Math.random()*100000);
						$('#spzt4').html('');
						$('#spzt4').append("<img src='"+imgurl5+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
						$('#himgurl4').val(str_arr5[0]);
						 $('#himgurl_1').val(mainimg5);
		    			 
		    	   }						
	       }
		});
	//细节图4
	 $("#uploadify5").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|6',
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue5',
		   'queueSizeLimit'  :1, 	
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.jpg;*.jpeg;*.png;*.gif',            
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
	       'onComplete': function (event, queueID, fileObj, response, data) {//返回函数		    	  
	    	   if(response.indexOf(';')>0){
	    		   var mainimg6=$('#himgurl_1').val();					
	    		   var str_arr6=response.split(';');
	    		   var imgurl6="http://www.d1.com.cn"+str_arr6[0]+"?"+Math.round(Math.random()*100000);
					$('#spzt5').html('');
					$('#spzt5').append("<img src='"+imgurl6+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
					$('#himgurl5').val(str_arr6[0]);
					 $('#himgurl_1').val(mainimg6);
	    			 
	    	   }	
	       }
		});	 
	      $("#uploadify6").uploadify({
		   'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
		   'script'         : '/servlet/Upload1?gdsid='+gdsid+'|7',
		   'method' :'GET',
		   'cancelImg'      : '/res/js/uploadify/cancel.png',
		   'folder'         : '/opt/shopimg/gdsimg',
		   'queueID'        : 'fileQueue6',
		   'queueSizeLimit'  :1, 
		   'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
		   'fileExt' : '*.png',                
		   'auto'           : true,
		   'multi'          : false,
		   'sizeLimit': 5120000,
		   'buttonImg':'/admin/SHManage/images/bdsc.jpg',
		   'hideButton':true, 
		   'buttonText'     : 'BROWSE',
		   'onComplete': function (event, queueID, fileObj, response, data) {//返回函数	  
			   if(response.indexOf(';')>0){
				   var mainimg7=$('#himgurl_1').val();
	    		   var str_arr7=response.split(';');
	    		   var imgurl7="http://www.d1.com.cn"+str_arr7[0]+"?"+Math.round(Math.random()*100000);
					$('#spzt6').html('');
					$('#spzt6').append("<img src='"+imgurl7+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
					$('#himgurl6').val(str_arr7[0]);
					 $('#himgurl_1').val(mainimg7);
	    	   }					   
	       }

		});
	 	
}
function SCXJT()
{	
	  var imgurl1=$.trim($("#himgurl2").val());
	  var w_1=$.trim($("#hw2").val());
	  var h_1=$.trim($("#hh2").val());	
	  var gdsid1=$.trim($("#hgdsid").val()); 
	  if(imgurl1!=''){
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl1,w:w_1,h:h_1},
			error: function(XmlHttpRequest){
				alert("上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){	
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
}
function Updatevalidflag(type)
{
    var gdsid1=$('#hgdsid').val();
    if(gdsid1==''){
    	alert('商品编号不存在！');
    	return;
    }
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/ShopM/updateflag.jsp',
		cache: false,
		data: {gdsid:gdsid1,t:type},
		error: function(XmlHttpRequest){
			alert("修改上架状态，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){	
				alert('上传图片成功，并且已修改商品的上架状态！');
				//location.reload();
			}else{
				alert(json.message);
				return;
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function SCTP(flag)
{
	var imgurl_1=$.trim($("#himgurl_1").val());
	var imgurl1_1=$.trim($("#himgurl1").val());
	var imgurl6_1=$.trim($("#himgurl6").val());
	var imgurl2_1=$.trim($("#himgurl2").val());
	var imgurl3_1=$.trim($("#himgurl3").val());
	var imgurl4_1=$.trim($("#himgurl4").val());
	var imgurl5_1=$.trim($("#himgurl5").val());
	if(imgurl_1==''){
		alert('主图必须上传！');
		return;
	}
	else{
	//大图
	  var w_1=$.trim($("#hw").val());
	  var h_1=$.trim($("#hh").val());	
	  var gdsid1=$.trim($("#hgdsid").val()); 
	  if(imgurl_1!=''){
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl_1,w:w_1,h:h_1},
			error: function(XmlHttpRequest){
				alert("主图上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){	
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	  //竖形图
	  var imgurl1_1=$.trim($("#himgurl1").val());
	  if(imgurl1_1!=''){
	  var w1_1=$.trim($("#hw1").val());
	  var h1_1=$.trim($("#hh1").val());	 
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddImg1.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl1_1,w:w1_1,h:h1_1},
			error: function(XmlHttpRequest){
				alert("竖形图上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	  //平铺图
	  if(imgurl6_1!=''){
	  var w6_1=$.trim($("#hw6").val());
	  var h6_1=$.trim($("#hh6").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddImg2.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl6_1,w:w6_1,h:h6_1},
			error: function(XmlHttpRequest){
				alert("平铺图上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图1
	  if(imgurl2_1!=''){
	  var w2_1=$.trim($("#hw2").val());
	  var h2_1=$.trim($("#hh2").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl2_1,w:w2_1,h:h2_1,order:'1'},
			error: function(XmlHttpRequest){
				alert("细节图1上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图4
	  if(imgurl5_1!=''){
	  var w5_1=$.trim($("#hw5").val());
	  var h5_1=$.trim($("#hh5").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl5_1,w:w5_1,h:h5_1,order:'4'},
			error: function(XmlHttpRequest){
				alert("细节图4上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图2
	  if(imgurl3_1!=''){
	  var w3_1=$.trim($("#hw3").val());
	  var h3_1=$.trim($("#hh3").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl3_1,w:w3_1,h:h3_1,order:'2'},
			error: function(XmlHttpRequest){
				alert("细节图2上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图3
	  if(imgurl4_1!=''){
	  var w4_1=$.trim($("#hw4").val());
	  var h4_1=$.trim($("#hh4").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl4_1,w:w4_1,h:h4_1,order:'3'},
			error: function(XmlHttpRequest){
				alert("细节图3上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	  Updatevalidflag(flag);
	}
}

function AddSku1()
{
	var gdsid1=$('#hgdsid').val();
	var hstrgdsid=$('#hstrgdsid').val();
	if(gdsid1==''&&hstrgdsid=='')
		{
		alert('商品不存在，不能添加Sku！');
		}
	$('#skutable tr:not(#bt)').each(function(){
		var first='';
		var two='';
		var three='';
		var four='';		
		$(this).find('td').each(function(i){
			if(i==0){
			  first=$(this).text();
			}
			if(i==1){
				two=$(this).find("input:text").val();
			}
			if(i==2){
				three=$(this).find("option:selected").val();
			}
			if(i==3){
				four=$(this).find("input:text").val();
			}
			
		})
		if(first.length>25){
			alert('Sku字符超长，请不要超过25个字！');
			return;
		}
		if(isNaN(parseInt(two))||two=='')
		{
			alert('请填写数字！');
			return;
		}
		if(isNaN(parseInt(four))&&four!='')
		{
			alert('请填写数字！');
			return;
		}
		 $.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/ShopM/AddSku.jsp',
		cache: false,
		data: {gdsid:gdsid1,hstrgdsid:hstrgdsid,sku1:first,stock:two,vstock:four,flag:three},
		error: function(XmlHttpRequest,textStatus,erroeThrown){			
			alert("录入Sku出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){}
			else
				{
			alert(json.message);
				}
		},beforeSend: function(){
		},complete: function(){
		}
	});

	});
}

//判断时间格式是否正确
function FormatDate(str)
{
	if(str.length!=10){
		return false;
	}
		
    var year=str.substr(0,4);
    var hx1=str.substr(4,1);
    var month=str.substr(5,2);
    var hx2=str.substr(7,1);
    var day=str.substr(8,2);
    if((!isNaN(parseInt(year))&&(parseInt(year.charAt(0))==1||parseInt(year.charAt(0))==2))
        &&(!isNaN(parseInt(month))&&parseInt(month.charAt(0))<=1)
        &&(!isNaN(parseInt(day))&&parseInt(day)<=31)&&hx1=='-'&&hx2=='-') 
    {
        return true;
    }   
    else
    {
       return false;
    }

}


function AddGdsmst()
{
   var shopcode1=$('#gdsmst_sjbm').val();
   var gdsbarcode=$('#gdsmst_barcode').val();
   if(shopcode1==''){
	   alert('请填写商家编码！');
	   return;
   }
   var name1=$('#gdsmst_title').val();
   if(name1==''){
	   alert('请填写商家名称！');
	   return;
   }
   var enam1=$('#gdsmst_subtitle').val();
   var vode1=$('#hcode').val();
   if(vode1==''){
	   alert('请选择类目！');
	   return;
   }
  
  var bname1=$('#gdsmst_pp option:selected').text();
  var bcode1='';
  /* if(bname1==''){
	   alert('请填写品牌名称！');
	   return;
   }
   else{
	   bcode1=$('#gdsmst_pp option:selected').val();  
   }*/
   bcode1=$('#gdsmst_pp option:selected').val();  
   var scj1=$('#gdsmst_scj').val();
   if(scj1==''){
	   alert('请填写市场价！');
	   return;
   }
   var m1=$('#gdsmst_d1j').val();
   if(m1==''){
	   alert('请填写D1价！');
	   return;
   }
  if(Number(m1)>Number(scj1)){ alert('D1价不得大于市场价！');return;}
  
  var provider=$('#gdsmst_provider').val();
  var othercost=$('#gdsmst_othercost').val();
  
  var inp=$('#gdsmst_inp').val();
  var cxj1=$('#gdsmst_cxj').val();
  /*if(cxj1==''){
	   alert('请填写促销价');
	   return;
   }
   var cxj1=$('#gdsmst_cxj').val();
   if(cxj1==''){
	   alert('请填写促销价');
	   return;
   }*/
   var zk1=$('#gdsmst_zk').val();
   var cd1=$('#gdsmst_station').val();
   var begin1=$('#gdsmst_begin').val();
   var end1=$('#gdsmst_end').val();
   if(cxj1!=''){
	   if(Number(cxj1)>=Number(m1)){ alert('促销价不得大于等于D1价');
	                return;}
	  /* if(begin1==''){
		   alert('促销开始时间不能为空');
		   return;
	   }
	   if(end1==''){
		   alert('促销结束时间不能为空');
		   return;
	   }*/
   }
  /* if(begin1!=''&&!FormatDate(begin1)){
	   alert('促销开始时间格式不正确，正确的为：2013-01-01');
	   return;
   }
   if(end1!=''&&!FormatDate(end1)){
	   alert('促销结束时间格式不正确，正确的为：2013-01-01');
	   return;
   }*/
   var des1=$('#gdsmst_cpjj').val();
   var ddes1=$('#elm1').val();
   if(ddes1==''){
	   alert('请填写商品描述！');
	   return;
   }
   var skuname1='';   
   skuname1=$('#skuname option:selected').text();
	   
   //获取属性
   var a11='';
   var a21='';
   var a31='';
   var a41='';
   var a51='';
   var a61='';
   var a71='';
   var a81='';
   var a91='';
   var a101='';
   var a111='';
   var a121='';
   var hidgg=$("#hidgg").val();

   if($('#req_div1').length>0&&$('#req_div1').html()!=''){
	   $("input[name='req_stdvalue1']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a11 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg1').length>0&&a11==""&&hidgg==0){
	   alert('属性1不能为空');
	   return;
   }
	   
   if($('#req_div2').length>0&&$('#req_div2').html()!=''){
	   $("input[name='req_stdvalue2']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a21 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg2').length>0&&a21==""&&hidgg==0){
	   alert('属性2不能为空');
	   return;
   }
   if($('#req_div3').length>0&&$('#req_div3').html()!=''){
	   $("input[name='req_stdvalue3']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a31 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg3').length>0&&a31==""&&hidgg==0){
	   alert('属性3不能为空');
	   return;
   }
   if($('#req_div4').length>0&&$('#req_div4').html()!=''){
	   $("input[name='req_stdvalue4']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a41 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg4').length>0&&a41==""&&hidgg==0){
	   alert('属性4不能为空');
	   return;
   }
   if($('#req_div5').length>0&&$('#req_div5').html()!=''){
	   $("input[name='req_stdvalue5']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a51 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg5').length>0&&a51==""&&hidgg==0){
	   alert('属性5不能为空');
	   return;
   }
   if($('#req_div6').length>0&&$('#req_div6').html()!=''){
	   $("input[name='req_stdvalue6']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a61 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg6').length>0&&a61==""&&hidgg==0){
	   alert('属性6不能为空');
	   return;
   }
   if($('#req_div7').length>0&&$('#req_div7').html()!=''){
	   $("input[name='req_stdvalue7']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a71 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg7').length>0&&a71==""&&hidgg==0){
	   alert('属性7不能为空');
	   return;
   }
   if($('#req_div8').length>0&&$('#req_div8').html()!=''){	
	   if($('#req_stdchar8').length>0&&$('#req_stdchar8').val()!=''){
	   $("input[name='req_stdvalue8']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a81 += $(this).val()+","		  
		   }
	   });
	   }else{
	    a81 += $('#req_stdvalue8').val();	
	   }
   } 
   if($('#fgg8').length>0&&a81==""&&hidgg==0){
	   alert('属性8不能为空');
	   return;
   }
   
   if($('#req_div9').length>0&&$('#req_div9').html()!=''){
	   $("input[name='req_stdvalue9']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a91 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg9').length>0&&a91==""&&hidgg==0){
	   alert('属性9不能为空');
	   return;
   }
   
   if($('#req_div10').length>0&&$('#req_div10').html()!=''){
	   $("input[name='req_stdvalue10']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a101 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg10').length>0&&a101==""&&hidgg==0){
	   alert('属性10不能为空');
	   return;
   }
   
   if($('#req_div11').length>0&&$('#req_div11').html()!=''){
	   $("input[name='req_stdvalue11']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a111 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg11').length>0&&a111==""&&hidgg==0){
	   alert('属性11不能为空');
	   return;
   }
   
   if($('#req_div12').length>0&&$('#req_div12').html()!=''){
	   $("input[name='req_stdvalue12']:checkbox").each(function(){
		   if($(this).attr("checked")){
               a121 += $(this).val()+","		  
		   }
	   });
   }
   if($('#fgg12').length>0&&a121==""&&hidgg==0){
	   alert('属性12不能为空');
	   return;
   }
   var specialflag="0";
   $("input[name='req_specialflag']:checkbox").each(function(){
	   if($(this).attr("checked")){
		   specialflag = $(this).val()	  
	   }
   });
   
   //判断sku
   var skuflag=0;
   $('#skutable tr:not(#bt)').each(function(){
		var first='';
		var two='';
		var three='';
		var four='';		
		$(this).find('td').each(function(i){
			if(i==0){
			  first=$(this).text();
			}
			if(i==1){
				two=$(this).find("input:text").val();
			}
			if(i==2){
				three=$(this).find("option:selected").val();
			}
			if(i==3){
				four=$(this).find("input:text").val();
			}
			
		})
		if(isNaN(parseInt(two))||two=='')
		{
			skuflag=skuflag+1;
		}		

	});
   if(skuflag>0){
	   alert('SKU的库存项必须填写！');
	   return;
	   
   }
   var shoprck='';
   $("input[name='shoprck']:checkbox").each(function(){
	   if($(this).attr("checked")){
		   shoprck += $(this).val()+","		  
	   }
   });
   var kc1 = $("#kc1").val();
   if(typeof kc1 == 'undefined'){//库存框为undefined，默认值0
	   kc1 = 0;
   }
   var gdsgrep=$("#gdsgrep").val();
   var provide=$('#provide').val();//主要供应商
	   if(typeof provide=='undefined'){
		   provide=""; 
	   }
	   var gdsmst_provideStr=$('#gdsmst_provideStr').val();//其他供应商
	   if(typeof gdsmst_provideStr=='undefined'){
		   gdsmst_provideStr=""; 
	   }
 //alert('sc:'+shopcode1+',name:'+name1+',enam:'+enam1+',code:'+vode1+',bname:'+bname1+',scj:'+scj1+',m:'+m1+'cxj:'+cxj1+',zk:'+zk1+',cd:'+cd1+',begin:'+begin1+',end:'+end1+',des:'+des1+',ddes:'+ddes1
		// +',a1:'+a11+',a2:'+a21+',a3:'+a31+',a4:'+a41+',a5:'+a51+',a6:'+a61+',a7:'+a71+',a8:'+a81+',skuname:'+skuname1+',bcode:'+bcode1);
 /*
   this.location.href="/ajax/ShopM/AddGdsinfo.jsp?sc="+shopcode1+"&name="+name1+"&ename="+enam1+"&code="+vode1
 +"&bname="+bname1+"&scj="+scj1+"&m="+m1+"&cxj="+cxj1+"&zk="+zk1+"&cd="+cd1
 +"&begin="+begin1+"&end="+end1+"&des="+des1+"&ddes="+ddes1+"&a1="+a11+"&a2="+a21+"&a3="+a31+"&a4="+a41+"&a5="+a51
 +"&a6="+a61+"&a7="+a71+"&a8="+a81+"&skuname="+skuname1+"&bcode="+bcode1;
  return;
  */
   $.ajax({
		type: "post",
		dataType: "json",
		url: '/ajax/ShopM/AddGdsinfo.jsp',
		cache: false,
		data: {sc:shopcode1,name:name1,ename:enam1,kc1:kc1,
			   code:vode1,bname:bname1,scj:scj1,
			   m:m1,cxj:cxj1,zk:zk1,cd:cd1,provide:provide,gdsmst_provideStr:gdsmst_provideStr,
			   begin:begin1,end:end1,des:des1,
			   ddes:ddes1,a1:a11,a2:a21,a3:a31,
			   a4:a41,a5:a51,a6:a61,a7:a71,
			   a8:a81,a9:a91,a10:a101,a11:a111,a12:a121,
			   skuname:skuname1,bcode:bcode1,shoprck:shoprck,inp:inp,gdsgrep:gdsgrep,
			   provider:provider,othercost:othercost,specialflag:specialflag,
			   gdsbarcode:gdsbarcode},
		error: function(XmlHttpRequest,textStatus,erroeThrown){			
			alert("录入商品出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
				$('#spdetail').css('display','none');
				$('#imagelist').css('display','block');
				//绑定Gdsid
				$('#hgdsid').val(json.gdsid);
				$('#hstrgdsid').val(json.strgdsid);
				$('#gdsstd').html(json.gdsstd);
				if(skuname1 != '无'){//当前台选择无的时候，不进行sku录入
					//录入sku
					AddSku1();
				}
				SCTPInit();
				//预览按钮
				$('#ylsp').attr("href","http://www.d1.com.cn/product/"+json.gdsid);
				$('#ylsp').attr("target","_blank");
				//跳到头部
				$(window).scrollTop(0);
				alert('商品录入成功！');
			}else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});

 
}

function Bindpp(obj)
{	
	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getPP.jsp",
        cache: false,
        data:{
        	code:obj
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取品牌出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){  
        	$('#gdsmst_pp').html(strRet);
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });
	
}

$(document).ready(function(){	
	$('#level1 ul li').each(function(){
		
		$(this).click(function(){	
			$("#level1 ul li").css("border","solid 1px #fff");
			$("#level1 ul li").removeClass('hover1');					
			$(this).addClass('hover1');	
			$(this).css("border","solid 1px #72bdff");			
			$('#lbl1').html('&nbsp;>&nbsp;'+$(this).attr('attr1')+'&nbsp;');
			$('#lbl1_1').html('&nbsp;>&nbsp;'+$(this).attr('attr1')+'&nbsp;');
			$('#lbl2_1').html('');
			$('#lbl3_1').html('');
			$('#lbl2').html('');
			$('#lbl3').html('');
			$("#level2").html('');
			$("#level3").html('');
			$("#level2").css('display','none');
			$("#level3").css('display','none');
			$("#level2_1").css('display','none');
			$("#level3_1").css('display','none');
			
			Bindgg($(this).attr('attr'));

			GetOtherRack('2',$(this).attr('attr'));
			$('#hcode').val($(this).attr('attr'));
			Bindpp($(this).attr('attr'));
       });
	});
	
});

/////////////////////////////商品维护页面////////////////////////////////////
function GetOtherRack1(level,rack)
{
	for(var i=Number(level)+1;i<=4;i++){
		$('#level'+i).css('display','none');
	}
	if(rack!='0'){
	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getOtherRack_M.jsp",
        cache: false,
        data:{
        	code:rack,levels:level
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取分类出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){
        	$('#level'+level).html('<option value="0">--请选择--</option>'+strRet);
        	$('#level'+level).css('display','block');
        	if($("#hidgg").val()==0){
        	Bindgg(rack);
        	}
        	//绑定品牌
        	Bindpp(rack);
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });
	}
	else{
		$('#level'+level).css('display','none');
		if(level==2){
			$('#level3').css('display','none');
		}
		if(level==3){
			$('#level4').css('display','none');
		}
	}
}
function SelectAll(obj)
{
   var select=$(obj).attr("checked");	
   $("input[name='sgoods']").attr("checked",select);
}

function Search_M()
{
	//品牌
	var pp=$('#gdsmst_pp option:selected').val();
	//名称
	var name=$('#name').val();
	var gid=$('#gdsid').val();//商品编号
	var flag='';
	if($('#gdsmst_validflag option:selected').val()!='-2'){
		flag=$('#gdsmst_validflag option:selected').val();
	}
	//商家编码
	var scode=$('#shopcode').val();
	//店内分类
	var scode1='';
	if($('#g_level1').css('display')!='none'&&$('#g_level1 option:selected').val()!='0'){
		scode1=$('#g_level1 option:selected').val();
	}

    //整理时间
	var begin=$('#begin').val();
	var end=$('#end').val();
	
	if(begin!=''&&end!=''){
		var date1 = new Date(Date.parse(begin.replace("-", "/"))); 
        var date2 = new Date(Date.parse(end.replace("-", "/"))); 
        if(date1>date2){
        	alert('开始时间不得大于结束时间！');
        	return;
        }
	}
	//整理分类
	var rcode='';
	if($('#level3').css('display')=='block'&&$('#level3 option:selected').val()!='0'){
		rcode=$('#level3 option:selected').val();
	}
	else if($('#level4').css('display')=='block'&&$('#level4 option:selected').val()!='0')
	{
		rcode=$('#level4 option:selected').val();
	}
	else{
		if($('#level2').css('display')=='block'&&$('#level2 option:selected').val()!='0'){
			rcode=$('#level2 option:selected').val();
		}
		else{
			if($('#level1').css('display')!='none'&&$('#level1 option:selected').val()!='0'){
				rcode=$('#level1 option:selected').val();
			}
			else{
				rcode='';
			}
		}
	}	
	
	//商家编码
	//alert('/admin/SHManage/ProductM.jsp?bcode='+pp+'&gname='+name+'&gid='+gid+'&flag='+flag+'&begin='+begin+'&end='+end+'&rcode='+rcode+'&scode='+scode1);
	location.href='/admin/SHManage/ProductM.jsp?act=s&bcode='+pp+'&gname='+name+'&gid='+gid+'&flag='+flag+'&begin='+begin+'&end='+end+'&rcode='+rcode+'&scode='+scode1+'&sjcode='+scode;
}

//绑定数据
function Bind_SM(pp,code,flag)
{
	//绑定品牌
	if(pp!='') $("#gdsmst_pp option[value='"+pp+"']").attr("selected", true); 
	//绑定商品状态
	if(flag!='') $("#gdsmst_validflag option[value='"+flag+"']").attr("selected", true); 
	//绑定分类
	if(code!=''){
		if(code.length==3){
			$("#level1 option[value='"+code+"']").attr("selected", true); 
		}
		if(code.length==6){
			$("#level1 option[value='"+code.substring(0,3)+"']").attr("selected", true);			
			$("#level2 option[value='"+code.substring(0,6)+"']").attr("selected", true);
			$("#level2").css('display','block');
		}
		if(code.length==9){
			$("#level1 option[value='"+code.substring(0,3)+"']").attr("selected", true);
			$("#level2 option[value='"+code.substring(0,6)+"']").attr("selected", true);			
			$("#level3 option[value='"+code.substring(0,9)+"']").attr("selected", true);
			$("#level2").css('display','block');
			$("#level3").css('display','block');
		}
		if(code.length==12){
			$("#level1 option[value='"+code.substring(0,3)+"']").attr("selected", true);
			$("#level2 option[value='"+code.substring(0,6)+"']").attr("selected", true);			
			$("#level3 option[value='"+code.substring(0,9)+"']").attr("selected", true);
			$("#level4 option[value='"+code.substring(0,12)+"']").attr("selected", true);
			$("#level2").css('display','block');
			$("#level3").css('display','block');
			$("#level4").css('display','block');
		}
	}
	//绑定店内分类
	
}

//获取SKU
function Bind_SKU(gdsid,obj)
{
	var src=$(obj).attr('src');
	if(src=='/admin/SHManage/images/add.jpg')
	{
		
		$.ajax({
	        type: "post",
	        dataType: "text",
	        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
	        url: "/ajax/ShopM/getSKU_M.jsp",
	        cache: false,
	        data:{
	        	gid:gdsid
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
		    	alert("获取SKU出错，请稍后重试或者联系客服处理！");
	        },success: function(strRet){
	        	  $(obj).attr('src','/admin/SHManage/images/jian.jpg');
	        	  //:eq(index)匹配一个给定索引值的元素
	        	  //$(strRet).insertAfter($('#gtable tr:eq('+$(obj).attr('attr')+')'));
	        	  $(strRet).insertAfter($('#tr_'+gdsid));
	        },beforeSend: function(){           
	        },complete: function(){
	        	
	        }
	    });
	
	}
	else{
		$(obj).attr('src','/admin/SHManage/images/add.jpg');
		$('.lsstr'+gdsid).remove();
		//$('#gtable tr:eq('+($(obj).attr('attr')+1)+')').remove();
	}
	
}

function Delete_Product(gid)
{
	if(gid!=''){
		$.ajax({
	        type: "post",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
	        url: "/ajax/ShopM/DeleteP.jsp",
	        cache: false,
	        data:{
	        	gdsid:gid
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
		    	alert("获取SKU出错，请稍后重试或者联系客服处理！");
	        },success: function(json){
	        	if(json.success){
	        		alert(json.message);
	        		location.reload();
	        	}
	        	else{
	        		alert(json.message);
	        	}
	        },beforeSend: function(){           
	        },complete: function(){
	        	
	        }
	    });
	
	}
}

//////////////////////////修改商品/////////////////////////////
function Bind_pM(pp,code,flag)
{
	//绑定品牌
	if(pp!='') $("#gdsmst_pp option[value='"+pp+"']").attr("selected", true); 
	//绑定商品状态
	if(flag!='') $("#gdsmst_validflag option[value='"+flag+"']").attr("selected", true); 	
	//绑定分类
	if(code!=''){
		if(code.length==3){
			$("#level1 option[value='"+code+"']").attr("selected", true); 
		}
		if(code.length==6){
			$("#level1 option[value='"+code.substring(0,3)+"']").attr("selected", true);			
			$("#level2 option[value='"+code.substring(0,6)+"']").attr("selected", true);
			$("#level2").css('display','block');
		}
		if(code.length==9){
			$("#level1 option[value='"+code.substring(0,3)+"']").attr("selected", true);
			$("#level2 option[value='"+code.substring(0,6)+"']").attr("selected", true);			
			$("#level3 option[value='"+code.substring(0,9)+"']").attr("selected", true);
			$("#level2").css('display','block');
			$("#level3").css('display','block');
		}
		if(code.length==12){
			$("#level1 option[value='"+code.substring(0,3)+"']").attr("selected", true);
			$("#level2 option[value='"+code.substring(0,6)+"']").attr("selected", true);			
			$("#level3 option[value='"+code.substring(0,9)+"']").attr("selected", true);
			$("#level4 option[value='"+code.substring(0,12)+"']").attr("selected", true);
			$("#level4").css('display','block');
			$("#level2").css('display','block');
			$("#level3").css('display','block');
		}
		$('hcode').val(code);
	}
	//获取折扣
	GetZK();
	//给属性赋值
	Bindgg1(code,$('#gdsid').val());
}


function Bindgg1(obj,gdsid1)
{

	$.ajax({
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        url: "/ajax/ShopM/getAttribute1.jsp",
        cache: false,
        data:{
        	code:obj,gdsid:gdsid1
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("获取属性出错，请稍后重试或者联系客服处理！");
        },success: function(strRet){ 
        	$('#allgg').html(strRet);
        		
        },beforeSend: function(){           
        },complete: function(){
        	
        }
    });

}

function KJUpdate(gid)
{
   var gdsid=gid;
   if(gid==''){
	   alert('商品编号不存在！');
	   return;
   }
   var s=$('#scj_'+gid).val();
   if(s==''){  
	   alert('请填写市场价！');
	   return;	   
   }  
   var m1=$('#mj_'+gid).val();
   if(m1==''){
	   alert('请填写D1价！');
	   return;
   }
   
   if(isNaN(s)){alert('市场价格式不正确！');return;}
   if(isNaN(m1)){alert('D1价格式不正确！');return;}
   if(Number(m1)>Number(s)){ alert('D1价不得大于市场价！');return;}
   var flag=$("#vflag_"+gdsid).val();
   if(flag=='-2'){
	   alert('请选择商品状态，上架或下架！');return;
   }
   var sku='';
   var eflag=0;
   if($('.lsstr'+gdsid).length>0){
	   $('.lsstr'+gdsid).each(function(){
		   if($(this).find('input').val()==''){ eflag++; alert('请填写库存！');return false;}
		   sku+=$(this).find('input').attr('attr')+'@';
		   sku+=$(this).find('input').val()+',';		   
	   });
	   if(eflag>0){ return;}
   }
   $.ajax({
       type: "post",
       dataType: "json",
       contentType: "application/x-www-form-urlencoded;charset=UTF-8",
       url: "/ajax/ShopM/KJUpdateP.jsp",
       cache: false,
       data:{
       	gdsid:gid,sale:s,m:m1,f:flag,sku:sku
	    },error: function(XmlHttpRequest, textStatus, errorThrown){
	    	alert("修改商品信息出错，请稍后重试或者联系客服处理！");
       },success: function(json){
       	if(json.success){
       		alert(json.message);
       		location.reload();
       	}
       	else{
       		alert(json.message);
       	}
       },beforeSend: function(){           
       },complete: function(){
       	
       }
   });
  
}

function Allupdate(){
	var gid=$('#gdsid').val();
	var shopcode1=$('#gdsmst_sjbm').val();
	var gdsbarcode=$('#gdsmst_barcode').val();
	   if(shopcode1==''){
		   alert('请填写商家编码！');
		   return;
	   }
	   var name1=$('#gdsmst_title').val();
	   if(name1==''){
		   alert('请填写商家名称！');
		   return;
	   }
	   var enam1=$('#gdsmst_subtitle').val();	  
	 //整理分类
		var rcode='';
		if($('#level4').css('display')=='block'&&$('#level4 option:selected').val()!='0'){
			rcode=$('#level4 option:selected').val();
		}
		else if($('#level3').css('display')=='block'&&$('#level3 option:selected').val()!='0'){
			rcode=$('#level3 option:selected').val();
		}
		else{
			if($('#level2').css('display')=='block'&&$('#level2 option:selected').val()!='0'
				&&($('#level3').css('display')=='none')||$('#level3 option:last').val()=='0'){
				rcode=$('#level2 option:selected').val();
			}			
		}	
	   if(rcode==''){
		   alert('请选择最终类目！');
		   return;
	   }	   
	  var bname1=$('#gdsmst_pp option:selected').text();
	  var bcode1='';	  
	   bcode1=$('#gdsmst_pp option:selected').val();  
	   var scj1=$('#gdsmst_scj').val();
	   if(scj1==''){
		   alert('请填写市场价！');
		   return;
	   }
	   var m1=$('#gdsmst_d1j').val();
	   if(m1==''){
		   alert('请填写D1价！');
		   return;
	   }
	   var provider=$('#gdsmst_provider').val();
	   var othercost=$('#gdsmst_othercost').val();
	   
	   //var inp=$('#gdsmst_inp').val();
	  if(Number(m1)>Number(scj1)){ alert('D1价不得大于市场价！');return;}
	  var cxj1=$('#gdsmst_cxj').val();	  
	   var zk1=$('#gdsmst_zk').val();
	   var cd1=$('#gdsmst_station').val();
	   var begin1=$('#gdsmst_begin').val();
	   var end1=$('#gdsmst_end').val();
	   var cxj1=$('#gdsmst_cxj').val();	   
	    var zk1=$('#gdsmst_zk').val();
	    var cd1=$('#gdsmst_station').val();
	    var begin1=$('#gdsmst_begin').val();
	    var end1=$('#gdsmst_end').val();
	    if(cxj1!=''){
	 	   if(Number(cxj1)>=Number(m1)){ alert('促销价不得大于等于D1价');
	 	                return;}
	 	   /*if(begin1==''){
	 		   alert('促销开始时间不能为空');
	 		   return;
	 	   }
	 	   if(end1==''){
	 		   alert('促销结束时间不能为空');
	 		   return;
	 	   }*/
	    }	    
	   /*if(begin1!=''&&!FormatDate(begin1)){
		   alert('促销开始时间格式不正确，正确的为：2013-01-01');
		   return;
	   }
	   if(end1!=''&&!FormatDate(end1)){
		   alert('促销结束时间格式不正确，正确的为：2013-01-01');
		   return;
	   }*/
	   var des1=$('#gdsmst_cpjj').val();
	   var ddes1=$('#elm1').val();
	   if(ddes1==''){
		   alert('请填写商品描述！');
		   return;
	   }
	   var skuname1='';   
	   skuname1=$('#skuname option:selected').text();
	   var flag=$('#gdsmst_validflag option:selected').val();
	   if(flag=='-2'){
		   alert('请选择商品状态！');
		   return;
	   }
	   //获取属性
	   var a11='';
	   var a21='';
	   var a31='';
	   var a41='';
	   var a51='';
	   var a61='';
	   var a71='';
	   var a81='';
	   var a91='';
	   var a101='';
	   var a111='';
	   var a121='';
	  var hidgg= $("#hidgg").val();

	   if($('#req_div1').length>0&&$('#req_div1').html()!=''){
		   $("input[name='req_stdvalue1']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a11 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg1').length>0&&a11==""&&hidgg==0){
		   alert('属性1不能为空');
		   return;
	   }
		   
	   if($('#req_div2').length>0&&$('#req_div2').html()!=''){
		   $("input[name='req_stdvalue2']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a21 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg2').length>0&&a21==""&&hidgg==0){
		   alert('属性2不能为空');
		   return;
	   }
	   if($('#req_div3').length>0&&$('#req_div3').html()!=''){
		   $("input[name='req_stdvalue3']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a31 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg3').length>0&&a31==""&&hidgg==0){
		   alert('属性3不能为空');
		   return;
	   }
	   if($('#req_div4').length>0&&$('#req_div4').html()!=''){
		   $("input[name='req_stdvalue4']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a41 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg4').length>0&&a41==""&&hidgg==0){
		   alert('属性4不能为空');
		   return;
	   }
	   if($('#req_div5').length>0&&$('#req_div5').html()!=''){
		   $("input[name='req_stdvalue5']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a51 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg5').length>0&&a51==""&&hidgg==0){
		   alert('属性5不能为空');
		   return;
	   }
	   if($('#req_div6').length>0&&$('#req_div6').html()!=''){
		   $("input[name='req_stdvalue6']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a61 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg6').length>0&&a61==""&&hidgg==0){
		   alert('属性6不能为空');
		   return;
	   }
	   if($('#req_div7').length>0&&$('#req_div7').html()!=''){
		   $("input[name='req_stdvalue7']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a71 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg7').length>0&&a71==""&&hidgg==0){
		   alert('属性7不能为空');
		   return;
	   }
	   if($('#req_div8').length>0&&$('#req_div8').html()!=''){	
		   if($('#req_stdchar8').length>0&&$('#req_stdchar8').val()!=''){
		   $("input[name='req_stdvalue8']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a81 += $(this).val()+","		  
			   }
		   });
		   }else{
		    a81 += $('#req_stdvalue8').val();	
		   }
	   } 
	   if($('#fgg8').length>0&&a81==""&&hidgg==0){
		   alert('属性8不能为空');
		   return;
	   }
	   if($('#req_div9').length>0&&$('#req_div9').html()!=''){
		   $("input[name='req_stdvalue9']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a91 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg9').length>0&&a91==""&&hidgg==0){
		   alert('属性9不能为空');
		   return;
	   }
	   
	   if($('#req_div10').length>0&&$('#req_div10').html()!=''){
		   $("input[name='req_stdvalue10']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a101 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg10').length>0&&a101==""&&hidgg==0){
		   alert('属性10不能为空');
		   return;
	   }
	   
	   if($('#req_div11').length>0&&$('#req_div11').html()!=''){
		   $("input[name='req_stdvalue11']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a111 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg11').length>0&&a111==""&&hidgg==0){
		   alert('属性11不能为空');
		   return;
	   }
	   
	   if($('#req_div12').length>0&&$('#req_div12').html()!=''){
		   $("input[name='req_stdvalue12']:checkbox").each(function(){
			   if($(this).attr("checked")){
	               a121 += $(this).val()+","		  
			   }
		   });
	   }
	   if($('#fgg12').length>0&&a121==""&&hidgg==0){
		   alert('属性12不能为空');
		   return;
	   }
       
	   var shoprck='';
	   $("input[name='shoprck']:checkbox").each(function(){
		   if($(this).attr("checked")){
			   shoprck += $(this).val()+","		  
		   }
	   });
	   var specialflag="0";
	   $("input[name='req_specialflag']:checkbox").each(function(){
		   if($(this).attr("checked")){
			   specialflag = $(this).val()	  
		   }
	   });
	   
	   
	   //判断sku
	   var skuflag=0;
	   var sku='';
	   $('#skutable tr:not(#bt)').each(function(){
			var first='';
			var two='';
			var three='';
			var four='';		
			$(this).find('td').each(function(i){
				if(i==0){
				  first=$(this).attr('attr')+'@'+$(this).text();
				}
				if(i==1){
					two=$(this).find("input:text").val();
				}
				if(i==2){
					three=$(this).find("option:selected").val();
				}
				if(i==3){
					four=$(this).find("input:text").val();
				}
				
			})
			if(isNaN(parseInt(two))||two=='')
			{
				skuflag=skuflag+1;
			}		
			if(four=='') four='0';
            sku+=first+'@'+two+'@'+three+'@'+four+',';
		});
	   if(skuflag>0){
		   alert('SKU的库存项必须填写！');
		   return;
	   }
	   var kc1 = $("#kc1").val();
	   if(typeof kc1 == 'undefined'){//库存框为undefined，默认值0
		   kc1 = 0;
	   }
	   //主要供应商和其他供应商只在测试账户和D1账户中出现
	   var provide=$('#provide').val();//主要供应商
	   if(typeof provide=='undefined'){
		   provide=""; 
	   }
	   
	   var gdsmst_provideStr=$('#gdsmst_provideStr').val();//其他供应商
	   if(typeof gdsmst_provideStr=='undefined'){
		   gdsmst_provideStr=""; 
	   }
	   $.ajax({
			type: "post",
			dataType: "json",
			url: '/ajax/ShopM/UpdateProduct.jsp',
			cache: false,
			data: {gdsid:gid,sc:shopcode1,name:name1,ename:enam1,kc1:kc1,
				   code:rcode,bname:bname1,scj:scj1,
				   m:m1,cxj:cxj1,zk:zk1,cd:cd1,provide:provide,gdsmst_provideStr:gdsmst_provideStr,
				   begin:begin1,end:end1,des:des1,
				   ddes:ddes1,a1:a11,a2:a21,a3:a31,
				   a4:a41,a5:a51,a6:a61,a7:a71,
				   a8:a81,a9:a91,a10:a101,a11:a111,a12:a121,
				   skuname:skuname1,bcode:bcode1,sku:sku,f:flag,shoprck:shoprck,provider:provider,
				   othercost:othercost,specialflag:specialflag,
				   gdsbarcode:gdsbarcode},
			error: function(XmlHttpRequest,textStatus,erroeThrown){			
				alert("录入商品出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){
					SCTP_update(gid);
					alert('商品修改成功！');
					//location.reload();
				}else{
					alert(json.message);
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});

}






function SCTP_update(gid)
{
	var imgurl_1=$.trim($("#himgurl_1").val());
	var imgurl1_1=$.trim($("#himgurl1").val());
	var imgurl6_1=$.trim($("#himgurl6").val());
	var imgurl2_1=$.trim($("#himgurl2").val());
	var imgurl3_1=$.trim($("#himgurl3").val());
	var imgurl4_1=$.trim($("#himgurl4").val());
	var imgurl5_1=$.trim($("#himgurl5").val());	
	//大图
	  var w_1=$.trim($("#hw").val());
	  var h_1=$.trim($("#hh").val());	
	  var gdsid1=gid; 
	  if(imgurl_1!=''){
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl_1,w:w_1,h:h_1},
			error: function(XmlHttpRequest){
				alert("上传图片出错1，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){	
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	  
	  
	  
	  //竖形图
	  var imgurl1_1=$.trim($("#himgurl1").val());
	  if(imgurl1_1!=''){
	  var w1_1=$.trim($("#hw1").val());
	  var h1_1=$.trim($("#hh1").val());	  
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddImg1.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl1_1,w:w1_1,h:h1_1},
			error: function(XmlHttpRequest){
				alert("竖形图上传图片出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	  //平铺图
	  if(imgurl6_1!=''){
	  var w6_1=$.trim($("#hw6").val());
	  var h6_1=$.trim($("#hh6").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddImg2.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl6_1,w:w6_1,h:h6_1},
			error: function(XmlHttpRequest){
				alert("上传图片出错2，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图1
	  if(imgurl2_1!=''){
	  var w2_1=$.trim($("#hw2").val());
	  var h2_1=$.trim($("#hh2").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl2_1,w:w2_1,h:h2_1,order:'1'},
			error: function(XmlHttpRequest){
				alert("上传图片出错3，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图4
	  if(imgurl5_1!=''){
	  var w5_1=$.trim($("#hw5").val());
	  var h5_1=$.trim($("#hh5").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl5_1,w:w5_1,h:h5_1,order:'4'},
			error: function(XmlHttpRequest){
				alert("上传图片出错4，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图2
	  if(imgurl3_1!=''){
	  var w3_1=$.trim($("#hw3").val());
	  var h3_1=$.trim($("#hh3").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl3_1,w:w3_1,h:h3_1,order:'2'},
			error: function(XmlHttpRequest){
				alert("上传图片出错5，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
	//细节图3
	  if(imgurl4_1!=''){
	  var w4_1=$.trim($("#hw4").val());
	  var h4_1=$.trim($("#hh4").val());
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/ShopM/AddXJImg.jsp',
			cache: false,
			data: {gdsid:gdsid1,imgurl:imgurl4_1,w:w4_1,h:h4_1,order:'3'},
			error: function(XmlHttpRequest){
				alert("上传图片出错6，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.success){					
				}else{
					alert(json.message);
					return;
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
}