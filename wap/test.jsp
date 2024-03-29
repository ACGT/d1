<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>D1优尚网触屏版</title>
<meta name="author" content="m.d1.cn">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="/res/wap/css/base.css"
	charset="utf-8" />
<link rel="stylesheet" type="text/css"
	href="/res/wap/css/result.css?1.31" charset="utf-8" />
<script type="text/javascript" src="/res/wap/js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/res/wap/js/com.js"></script>
<style>
.chooses {
	height: .40rem;
	font-size: .14rem;
	width: 100%;
	margin-top: .10rem;
}

.choose_con {
	font-size: .14rem;
	width: 95%;
	margin-top: .08rem;
	margin: 0 auto;
}

.chooses .ch_row {
	border-bottom: 1px solid #dedede;
	height: 40px;
}

.choose_con .chc_row {
	border-bottom: 1px solid #dedede;
	overflow-y: scroll;
	overflow-x: hidden;
	max-height: 160px;
	border-left: 1px solid #dedede;
	display: none;
}

.chooses ul li, .choose_con ul li {
	float: left;
	display: inline-block;
	width: 33.33%;
	min-width: 88px;
	height: 40px;
	line-height: 40px;
	text-align: center;
	border-top: 1px solid #dedede;
	border-right: 1px solid #dedede;
	border-left: none;
	margin: 0;
	padding: 0 1px;
	box-sizing: border-box;
	font-size: 14px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.chooses ul li:first-child, .choose_con ul li:first-child {
	border-left: none
}

.chooses ul li.on, .choose_con ul li.on {
	color: red;
	background: #dedede;
}

.clear {
	clear: both;
}
</style>
</head>
<body>
	<header class="p_header">
		<a name="top"></a>
		<div class="h_txt">
			<div class="pageback">
				<a href="javascript:window.history.back(-1);">返回</a>
			</div>
			<div class="search">
				<input type="submit" class="sbut" text="搜索" name="sbut" id="sbut" />
				<input name="keyword" id="keyword" autocomplete="off"
					role="combobox" aria-haspopup="true" type="text" class="keys" />
			</div>
			<div class="home">
				<a href="/wap/index.html"></a>
			</div>
			<div class="myuser">
				<a href="/wap/user/index.html"></a>
			</div>
			<div class="carth">
				<a href="/wap/flow.html"></a>
			</div>
		</div>
	</header>
	<div class="main">
		<div class="chooses">
			<ul class="ch_row">
				<li id="vrck" attr="rck">分类</li>
				<li id="vbrand" attr="brand">品牌</li>
				<li id="vprice" attr="price">价格</li>
			</ul>
		</div>
		<div class="choose_con">
			<ul class="chc_row" id="chrck">

			</ul>
			<ul class="chc_row" id="chbrand">

			</ul>
			<ul class="chc_row" id="chprice">

			</ul>
		</div>

		<div class="m_plist">
			<div class="mp_sort">
				<div class="mps_con">
					<div class="mpsc_txt">
						<a href="javascript:void(0)" attr="0" class="cur">综合</a> <a
							href="javascript:void(0)" attr="3">销量</a> <a
							href="javascript:void(0)" attr="2">价格</a> <a
							href="javascript:void(0)" attr="4">上架时间</a>
					</div>
				</div>
			</div>
			<div class="mp_list">
				<ul>

				</ul>
				<div class="m_page">
					<div class="mp_cell s">首页</div>
					<div class="mp_cell l">上一页</div>
					<div class="mp_cell m">
						<span class="vselect">10/15&nbsp;<i></i></span> <select
							class="go_select" onchange="gourl(this.value);">
						</select>
					</div>
					<div class="mp_cell r">下一页</div>
					<div class="mp_cell e">尾页</div>
				</div>
			</div>
		</div>
	</div>
	<div class="rr_smenu" style="display: none;">
		<div class="rrs_content">
			<div class="rrsc_top">
				<span class="rrsc_tok">确定</span><span class="rrsc_tclear">清空条件</span>
			</div>
			<div class="rrsc_box rrsc_min" id="rrsc_rck">
				<div class="box_top">
					<span>分类</span> <i class="icon_r"> </i>
					<div class="rck_choose ok_c" attr=""></div>
				</div>
				<div class="box_content">
					<ul class="bc_row">

					</ul>
				</div>
			</div>
			<div class="rrsc_box rrsc_min" id="rrsc_brand">
				<div class="box_top">
					<span>品牌</span> <i class="icon_r"> </i>
					<div class="rck_choose ok_c" attr=""></div>
				</div>
				<div class="box_content">
					<ul class="bc_row">
					</ul>
				</div>
			</div>
			<div class="rrsc_box rrsc_min" id="rrsc_price">
				<div class="box_top">
					<span>价格</span> <i class="icon_r"> </i>
					<div class="rck_choose ok_c" attr=""></div>
				</div>
				<div class="box_content">
					<ul class="bc_row">
					</ul>
				</div>
			</div>

		</div>
	</div>
	<div id="footer" class="footer">
		<script language="javascript">
					getwapFoot();
				   </script>
	</div>
	<script language="javascript">
             $(".chooses .ch_row>li").click(function(){
					
					cvalue=$(this).attr("attr");
					$(".choose_con ul").hide();
					if($(this).parent().find(".on").attr("attr")==cvalue){
					$(this).parent().find(".on").removeClass("on");
					}else{
					if(cvalue=="rck"){
					$("#chrck").show();
					}else if(cvalue=="brand"){
					$("#chbrand").show();
					}else if(cvalue=="price"){
					$("#chprice").show();
					}	
					$(this).parent().find(".on").removeClass("on");
					$(this).addClass("on");
					}
					
				});
	
function loaddata(rackcode1,order1,pageno1,pprice1,brand1){
	
  var url=document.URL;
  var para="";
  var pageno=1;
  var rackcode="014";
  var pprice="";
  var brand="";
  var order=0;
  if(rackcode1!=""){
	  rackcode=rackcode1
	  if(order1!=""){
		  order=order1;
	  }
	  if(pageno1!=""){
		  pageno=pageno1;
	  }
	  if(pprice1!=""){
		  pprice=pprice1;
	  }
	  if(brand1!=""){
		  brand=brand1;
	  }
  }else{
   if(url.lastIndexOf("?")>0)
   {
        para=url.substring(url.lastIndexOf("?")+1,url.length);
		var arr=para.split("&");
		para="";
		for(var i=0;i<arr.length;i++)
		{
		   if(arr[i].split("=")[0]=="pageno"){
			   pageno=arr[i].split("=")[1];
		   }else if(arr[i].split("=")[0]=="rackcode"){
			   rackcode=arr[i].split("=")[1];
		   }else if(arr[i].split("=")[0]=="order"){
			   order=arr[i].split("=")[1];
		   }else if(arr[i].split("=")[0]=="pprice"){
			   pprice=arr[i].split("=")[1];
		   }else if(arr[i].split("=")[0]=="brand"){
			   brand=arr[i].split("=")[1];
		   }
		}
   }
}

 
	var psize=12;
	  $.ajax({
		type: 'get', 
        url: '/ajax/wap/t.jsp',
        data:{pageno:pageno,productsort:rackcode,order:order,psize:psize,pprice:pprice,brand:brand},
		dataType:'json',
		success: function(data){
				/*处理数据*/
				if(data.pstatus=="1"){
				showlist(data,psize,pageno,rackcode,order,pprice,brand);
				}
        }
	});
	}

	function gourl(parr){
		c=parr.split(",");
		var gourl="test.jsp?rackcode="+c[0];
		if(c[1].length>0)gourl+="&pprice="+c[1];
		if(c[2].length>0)gourl+="&brand="+c[2];
		if(c[3].length>0&&c[3]!=0)gourl+="&order="+c[3];
		if(c[4].length>0&&c[4]!=1)gourl+="&pageno="+c[4];
		window.location.href=gourl;
	}
	function showlist(p,psize,pageno,rackcode,order,pprice,brand){
		if(p.rackname!=''){
			$("#vrck").html(p.rackname);
			}
             if(p.brandname!=''){
			$("#vbrand").html(p.brandname);
			}
            if(pprice!=''){
			$("#vprice").html(pprice);
			}	
		var rcklists=eval(p.rcklist);
		var catehtml="";
		var rrsrckhtml='<li data="">返回上级分类</li>';
		var arrlen=rcklists.length
		if(arrlen>0){
		   for(var k=0;k<arrlen;k++){
			   rrsrckhtml+='<li  data="'+rcklists[k].rckcode+'">'+rcklists[k].rckname+'</li>';
		   }
		}

		if(rrsrckhtml.length>0){
			if((arrlen+1)%3>0){
			for(var l=1;l<=3-(arrlen+1)%3;l++){
				rrsrckhtml+='<li></li>';
			}
			}
			rrsrckhtml+='<div class="clear"></div>';
		$("#chrck").html(rrsrckhtml);
		}else{
			$("#chrck").hide();
		}
		
		var brandlists=eval(p.brandlist);
		catehtml='<li data="">全部品牌</li>';
		arrlen=brandlists.length
		if(arrlen>0){
		   for(var k=0;k<arrlen;k++){
			   catehtml+='<li  data="'+brandlists[k].brandcode+'">'+brandlists[k].brandname+'</li>';
		   }
		}
		if(catehtml.length>0){
			if((arrlen+1)%3>0){
				for(var l=1;l<=3-(arrlen+1)%3;l++){
					catehtml+='<li></li>';
				}
				}
			catehtml+='<div class="clear"></div>';
		$("#chbrand").html(catehtml);
		}else{
			$("#chbrand").hide();
		}

		
		var pricelists=eval(p.pricelist);
		 catehtml='<li data="">全部价格</li>';
		 arrlen=pricelists.length
		if(arrlen>0){
		   for(var k=0;k<arrlen;k++){
			   catehtml+='<li  data="'+pricelists[k].pricep+'">'+pricelists[k].pricep+'</li>';
		   }
		}
		if(catehtml.length>0){
			if((arrlen+1)%3>0){
				for(var l=1;l<=3-(arrlen+1)%3;l++){
					catehtml+='<li></li>';
				}
				}
			catehtml+='<div class="clear"></div>';
		$("#chprice").html(catehtml);
		}else{
			$("#chprice").hide();
		}
		
		if(rackcode.substring(0,3)=="014"){
			 if(p.brandname==''){
			  $("#chbrand").show();
			 }
			}else{
				if(rcklists.length>0){
				$("#chrck").show();
				}else{
					if(pprice==''){
				    $("#chprice").show();
					}
				}
			}
 
		var pagenum=parseInt(p.page_total/psize);
		if(p.page_total%psize>0) {
			pagenum=pagenum+1;
	     }
		$(".vselect").html(pageno+'/'+pagenum+'&nbsp;<i></i>');
		 var pgnext=parseInt(pageno)+1;
		 var pgup=parseInt(pageno)-1;
		$(".m_page .mp_cell.s").html('<a attr="'+rackcode+','+pprice+','+brand+','+order+',1" href="javascript:void(0)">首页</a>');
		if(parseInt(pgup)>=1){
		$(".m_page .mp_cell.l").html('<a attr="'+rackcode+','+pprice+','+brand+','+order+','+ pgup+'" href="javascript:void(0)">上一页</a>');
		}else{
			$(".m_page .mp_cell.l").hide();
		}
		 if(parseInt(pgnext)<=parseInt(pagenum)){
		$(".m_page .mp_cell.r").html('<a attr="'+rackcode+','+pprice+','+brand+','+order+','+pgnext+'" href="javascript:void(0)">下一页</a>');
		 }else{
				$(".m_page .mp_cell.r").hide();
			}
		$(".m_page .mp_cell.e").html('<a attr="'+rackcode+','+pprice+','+brand+','+order+','+pagenum+'" href="javascript:void(0)">尾页</a>');
		
		pageselect="";
		for(var i=1;i<=pagenum;i++){
			if(i==pageno){
			pageselect+='<option value="'+rackcode+','+pprice+','+brand+','+order+','+i+'" selected>第'+i+'页</option>';
			}else{
			pageselect+='<option value="'+rackcode+','+pprice+','+brand+','+order+','+i+'">第'+i+'页</option>';	
			}
		}
		$(".go_select").html(pageselect);
		

	var products=eval(p.products);
	$(".mp_list ul").html('');
	if(products.length>0){
		var pli="";
	   for(var i=0;i<products.length;i++){
		  var gprice=products[i].p_mprice;
		  if(products[i].p_issgflag||products[i].p_ismiaoshao){
			  gprice=products[i].p_msprice;
		  }
		  var zk=(gprice*10.0/products[i].p_saleprice).toFixed(1);
		pli='<li>';
		pli+='<div class="iteml"><a href="product.html?id='+products[i].p_gdsid+'"><img src="'+products[i].p_img+'" border="0"></a></div>';
		pli+='	  <div class="itemr">';
		pli+='	      <span class="title"><a href="product.html?id='+products[i].p_gdsid+'">'+products[i].p_gdsname+'</a></span>';
		pli+='		  <div class="ptxt">';
		pli+='		     <span class="pm">￥'+gprice+'</span>';
		pli+='			 <span class="phot">'+ zk+'折</span>';
		pli+='		  </div>';
		pli+='		 <div class="ptxt">';
		pli+='			 <span class="ps">￥<s>'+products[i].p_saleprice+'</s></span>';
		//pli+='			 <span class="pc">'+products[i].p_comnum+'人评价</span>';
		pli+='		  </div>';
		pli+='	  </div>';
		pli+='  </li>';
	   $(".mp_list ul").append(pli);
	   }

	  
	}

	$(".m_page .mp_cell>a").click(function(){
		var paras=$(this).attr('attr');
		gourl(paras)
		
	});
	   /*orderContent
   case 6://热销商品升
case 5 ://上架时间升
case 4 ://上架时间降
	case 3://热销商品
	case 2://价格，升序
	case 1://价格，倒序*/
$(".mpsc_txt>a").click(function(){
			$(".mpsc_txt>a").removeClass("cur");
			$(this).addClass("cur");
			var corder=$(this).attr('attr');
			if(this.attr=='1'){
				this.attr='2'
			}else if(this.attr=='2'){
				this.attr='1'
			}
			//gourl(rackcode+','+corder+','+pageno);
			
			loaddata(rackcode,corder,pageno,pprice,brand);
	});
$(".chc_row>li").click(function(){
$(this).parent().find(".on").removeClass("on");
$(this).addClass("on");
$(this).parent().hide();
vid=$(this).parent().attr("id");
if(vid=="chrck"){
	vrackcode=$(this).attr("data");
	if(vrackcode==""){
	 if(rackcode.length>3){
		vrackcode=rackcode.substring(0,rackcode.length-3);
	}else{
		vrackcode=rackcode;
	}
	}
	rackcode=vrackcode;
	$("#vrck").html($(this).html());
}
if(vid=="chbrand"){
	brand=$(this).attr("data");
	$("#vbrand").html($(this).html());
}
if(vid=="chprice"){
	pprice=$(this).attr("data");
	$("#vprice").html($(this).html());
}
gourl(''+rackcode+','+pprice+','+brand+',0,1');
});
		

	}
	loaddata('','','','','');
	$("#sbut").click(function(){
		var headsearchkey =$("#keyword").val();
		 window.location.href="/wap/search.html?headsearchkey="+headsearchkey;
	});
	</script>
	<div style="display: none;">
		<script language="javascript">
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F46dd49a8ff1d96b258ddf6588110099c' type='text/javascript'%3E%3C/script%3E"));

	</script>
	</div>
</body>
</html>