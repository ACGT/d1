$(function() {

	var sWidth = $("#focus").width();
	var len = Math.ceil($("#focus ul li").length/4); 
	
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

	
	$("#focus ul").css("width",sWidth * (len));
	
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
		var nowLeft = -index*612; //根据index值计算ul元素的left值
		
		$("#focus ul").stop(true,false).animate({"left":nowLeft},500); //通过animate()调整ul元素滚动到计算出的position
		
		
	}
});
   	
function chooseobb(obj){
    var skuid = $("#obb");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
			$(this).find("a").find("div").removeClass("div2");
			$(this).find("a").find("div").addClass("div1");
    	});
		$(obj).find("div").removeClass("div1");
		$(obj).find("div").addClass("div2");
		if($('#zimg').length>0){
			$('#zimg').removeClass("zdiv1");
			$('#zimg').addClass("zdiv2");
		}
		
		
		$("#showorder").val($(obj).attr("code"));//订单号
		$("#showgdsid").val($(obj).attr("attr"));//商品编码
		$("#hodtlid").val($(obj).attr("keys"));//订单详情id
		//alert($(obj).attr("attr"));
		checkchoose();
    }
}

function checkchoose(){
	 // var odrid=$.trim($("#showorder").val());
	 // var gdsid=$.trim($("#showgdsid").val());
	 // var odtlid=$.trim($("#hodtlid").val());
	 //  $('#uploadify').uploadifySettings('scriptData',{'odtlid':odtlid,'odrid':odrid,'gdsid':gdsid});  
	  $("#fileQueue").show();
	$("#btnupload").hide();
}

function choosemain()
{
    var skuid = $("#obb");
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
			$(this).find("a").find("div").removeClass("div2");
			$(this).find("a").find("div").addClass("div1");
    	});
		    $('#zimg').removeClass("zdiv2");
		    $('#zimg').addClass("zdiv1");
			$("#showorder").val($("#chooseimg").attr("code"));//订单号
			$("#showgdsid").val($("#chooseimg").attr("attr"));//商品编码
			$("#hodtlid").val($("#chooseimg").attr("keys"));//订单详情id
	
			checkchoose();
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
$(document).ready(function(){
	 var odrid=$.trim($("#showorder").val());
	  var gdsid=$.trim($("#showgdsid").val());
	  if(odrid.length==0 || gdsid.length==0){
		  $("#fileQueue").hide();
		 $("#btnupload").show();
	  }else{
		  $("#fileQueue").show();
			$("#btnupload").hide();
	  }
	 
	 $("#uploadify").uploadify({
         'uploader'       : '/res/js/uploadify/uploadify.swf?v=' + (new Date()).getTime(),
         'script'         : '/servlet/Upload?va=' + (new Date()).getTime(),//后台处理的请求
     	 'method' :'GET',
         'cancelImg'      : '/res/js/uploadify/cancel.png',
         'folder'         : '/uploads/sd',//您想将文件保存到的路径
         'queueID'        : 'fileQueue',//与下面的id对应
         'queueSizeLimit'  :1, 
        // 'simUploadLimit' ：5, // 允许同时上传的个数 默认值：1 。
         'fileDesc'    : 'jpg文件或jpeg文件或png文件或gif文件',
         'fileExt' : '*.jpg;*.jpeg;*.png;*.gif', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc                
         'auto'           : true,//是否立即上传
         'multi'          : false,//是否可以上传多个文件
         'sizeLimit': 5120000,//允许文件上传大小( 单位：KB)
         'buttonImg':'http://images.d1.com.cn/images2012/sd/an_03.jpg',
         'hideButton':true, 
         'buttonText'     : 'BROWSE'

     });
	 
	if($.trim($("#tcontent").val()).length==0){
		$("#tcontent").val("告诉大家您对宝贝的评价吧，说说您对使用/穿着的情况~真的优格，乐于分享！");
	}else{
		$("#tcontent").attr("color","black");
	}
	 var imgurl=$.trim($("#himgurl").val());
	  if(imgurl.length>0){
		  $("#testimgs").attr("src",imgurl);
		  var imgwidth = $("#hw").val();
			var imgheight =  $("#hh").val();//原图片高
			var w=imgwidth;
			var h=imgheight;
			 if(imgwidth>400){
				w=400;
				h=(imgheight * 400) / imgwidth;
			}
			 $("#divshowmsg").show();
			 $("#testimgs").attr("width",w);
			 $("#testimgs").attr("height",h);
			 $("#aimg").attr("href",imgurl);
	  }else{
		  $("#divshowmsg").hide();
	  }
});

function checkorder(){
	 var odrid=$.trim($("#showorder").val());
	  var gdsid=$.trim($("#showgdsid").val());
	  var odtlid=$.trim($("#hodtlid").val());
	  if(odrid.length==0 || gdsid.length==0 || odtlid.length==0){
		  $.alert("请选择要晒单的商品！");
	  }
}
function startupload(){
	
	  var odrid=$.trim($("#showorder").val());
	  var gdsid=$.trim($("#showgdsid").val());
	  var odtlid=$.trim($("#hodtlid").val());
	  var content=$.trim($("#tcontent").val());	
	 var mbrid=$.trim($("#hmbrid").val());	
	 if(odrid.length==0 || gdsid.length==0 || odtlid.length==0){
		  $.alert("请选择要晒单的商品！");
	  }else if($("#sfname").length==0){
		  $.alert("请选择要晒单的图片！"); 
	  }
	  else if(content.length==0 || content=="告诉大家您对宝贝的评价吧，说说您对使用/穿着的情况~真的优格，乐于分享！"){
		  $.alert("请输入使用心得！");
		 
	  }else{
	   $('#uploadify').uploadifySettings('scriptData',{'odtlid':odtlid,'odrid':odrid,'gdsid':gdsid,'mbrid':mbrid,'content':content});  
	 jQuery('#uploadify').uploadifyUpload();
	  }
 }

  function checklen(){
	  var text1=$("#tcontent").val();
	  var clen=$.trim(text1).length;
	  var maxlen=200;
	  var lastlen=200;
	  if(clen>maxlen){
		  $.alert("超过字数限制，请您精简部分文字!");
          text1 = text1.substr(0, 500);
          lastlen = 0;
	  }else{
		  lastlen=maxlen-clen;
	  }
	  var show="(您还可以输入" + lastlen + "个字)"; 
	  $("#spanmsg").html(show);
  }
 
  function checkcontent(){
	  var text1=$("#tcontent").val();
	  if(text1.indexOf("告诉大家您对宝贝的评价吧")>=0){
		  $("#tcontent").val("");
	  }
  }
  
  function checkcontentblur(){
	  if($.trim($("#tcontent").val()).length==0){
		$("#tcontent").val("告诉大家您对宝贝的评价吧，说说您对使用/穿着的情况~真的优格，乐于分享！");
		return false;
	  }
  }
  
  //发表晒单
  function cmtshoworder(){
	  var odrid=$.trim($("#showorder").val());
	  var gdsid=$.trim($("#showgdsid").val());
	  var odtlid=$.trim($("#hodtlid").val());
	  var content=$.trim($("#tcontent").val());	
	  var imgurl=$.trim($("#himgurl").val());
	  var w=$.trim($("#hw").val());
	  var h=$.trim($("#hh").val());
	  if(odrid.length==0 || gdsid.length==0 || odtlid.length==0){
		  $.alert("请选择要晒单的商品！");
	  }else if(imgurl.length==0){
		  $.alert("请选择要晒单的图片！"); 
	  }
	  else if(content.length==0 || content=="告诉大家您对宝贝的评价吧，说说您对使用/穿着的情况~真的优格，乐于分享！"){
		  $.alert("请输入使用心得！");
	  }
	  else{
			$.ajax({
				type: "get",
				dataType: "json",
				url: '/ShowOrder/op.jsp',
				cache: false,
				data: {odtlid:odtlid,odrid:odrid,gdsid:gdsid,imgurl:imgurl,w:w,h:h,content:content},
				error: function(XmlHttpRequest){
					$.alert("晒单出错，请稍后重试或者联系客服处理！");
				},success: function(json){
					if(json.success){
						if(json.type==1){
							showmsg(''); 
						}else{
							$.alert(json.message);//晒单修改
						}
					}else{
						$.alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
	  }
  }
  function showmsg(c){$.close(); var odrid=$.trim($("#showorder").val());
  var gdsid=$.trim($("#showgdsid").val()); var odtlid=$.trim($("#hodtlid").val()); var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("晒单提醒",500,"/ShowOrder/sddialog.jsp"+s+"&gdsid="+gdsid+"&odrid="+odrid+"&odtlid="+odtlid);}

  


  