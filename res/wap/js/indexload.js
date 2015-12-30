function loaddata(){  
		   $.ajax({
				type: "get",
				dataType: "json",
				url: '/ajax/wap/getzttm2015.jsp',
				//cache: false,
				error: function(XmlHttpRequest){
					$.alert("内容错误！");
				},success: function(json){
						if(json.status=="1"){
							showpm(json);
//							 $(".touchslider").touchSlider({
//								 container: this,
//								 fixWidth:true,
//								 flexible : true,
//								 duration: 350, // the speed of the sliding animation in milliseconds
//								 delay: 3000, // initial auto-scrolling delay for each loop
//								 margin: 5, // borders size. The margin is set in pixels.
//								 mouseTouch: true,
//								 autoplay: true, // whether to move from image to image automatically
//							 });
//							$("#sliderA").excoloSlider({
//				                mouseNav: false,
//				                interval: 5000, // = 5 seconds
//				                playReverse: true,
//				                width:640,
//				                height:250
//				            });
//							$(".es-caption").hide();
						}else{
							$(".tm").hide();
						}
				}
		   });
	}

function banner(
		sliderTs, //函数名
		sliders,   //ul的ID的后面的数字
		Pagenavi //分页按钮的ID
		) {
//$(Next).click(function(){sliderTs.next();});
//$(Prev).click(function(){sliderTs.prev();});

var num = 0;
num = $("#slider" + sliders).children("li").length;
var html = "";
html = "<a href='javascript:void(0);' {c}>{i}</a>";
var lasthtml,
thtml;
lasthtml = "";

//var $imgH = $(".swipe img").height();
//$(".swipe li").height($imgH);

for (var i = 0; i < num; i++) {
thtml = "";
if (i == 0) {
    thtml = html.replace("{c}", "class='active' ");

} else {
    thtml = html.replace("{c}", "");
}
thtml = thtml.replace("{i}", i + 1);
lasthtml += thtml;
};
$(Pagenavi).html(lasthtml);
var active = 0,
as = $(Pagenavi).find("a");
for (var i = 0; i < as.length; i++) {
(function() {
    var j = i;
    as[i].onclick = function() {
        sliderTs.slide(j);
        return false;
    }
})();

}
var sliderTs=new TouchSlider("slider" + sliders,{
duration:600, 
direction:0, 
interval:3000,//间隔时间
fullsize:true,
autoplay:true,
});
sliderTs.on('before',function(m,n){
as[m].className='';
as[n].className='active';
});	
setTimeout(function(){sliderTs.resize();},100);
}
    

    function showpm(json){
    	var lblists=eval(json.lblist);
    	console.log(lblists);
    	if(typeof lblists!="undefined"){
    	if(lblists.length>0){
    		var lblistsli="";
    		//添加轮播图片
    	   for(var i=0;i<lblists.length;i++){
    		   lblistsli+='<li><a href="'+lblists[i].pmurl+'" title=\"'+lblists[i].pmtitle+'\"><img src="'+lblists[i].pmpic+'" ></a></li>'; 
    		   //lblistsli+='<img src="'+lblists[i].pmpic+'" data-plugin-slide-caption="<a href=\''+lblists[i].pmurl+'\' target=\'_blank\' ></a>"  /> ';
    		   }
    		   //alert(lblistsli);
    	   //添加轮播的导航
    	   $("#slider1").html(lblistsli);
    	   banner("slider1",//函数名
    			   "1",//ul的ID的后面的数字-----id="slider1"
    			   "#pagenavi"//分页按钮的ID   			 
    			   );
//    	   var nav="<div>";
//    	   for(var i=0;i<lblists.length;i++){
//    		   if(i==0){
//    			   nav+='<a class="touchslider-nav-item touchslider-nav-item-current"> </a>';
//    		   }else{
//    			   nav+='<a class="touchslider-nav-item"> </a>';
//    		   }
//    	   }
//    	   nav+="</div>";
//    	   $(".touchslider-nav").html(nav);
    	   
    	}
    	}else{
    		//$("#sliderA").parent().hide();
    	}
    	var actpplists=eval(json.actpplist);
    	if(typeof actpplists!="undefined"){
    	if(actpplists.length>0){
    		var pli="";
    	   for(var i=0;i<actpplists.length;i++){
    		  // pli='<a href="'+actpplists[i].pmurl+'" title=\"'+actpplists[i].pmtitle+'\"><img src="'+actpplists[i].pmpic+'" ></a>'
    			//   $(".mp_list .adimg").append(pli);
    	   }
    	   //$("#mpadimg").show();
    	}
    	}
    	

    	var pmlists=eval(json.pmlist);
    	if(typeof pmlists!="undefined"){
    	if(pmlists.length>0){
    		var pli="";
    	   for(var i=0;i<pmlists.length;i++){
    		   pli+='<li>';
    		   pli+='<div class="tmitem">';
    		   pli+='	<div class="pic"><a href="'+pmlists[i].pmurl+'">';
    		   pli+='		<img src="'+pmlists[i].pmpic+'">';
    		   pli+='</a>';
    		   pli+='</div></div></li>';		

    	   }
    	   $(".tm ul").html(pli);
    	   $(".tm").show();
    	}
    	}
    	var products=eval(json.products);
    	if(typeof products!="undefined"){
    	if(products.length>0){
    		var pli="";
    		var licls="";
    		var len=products.length;
    	   for(var i=0;i<len;i++){
    		  var pprice=products[i].p_mprice;
    		  if(products[i].p_issgflag||products[i].p_ismiaoshao){
    			  pprice=products[i].p_msprice;
    		  }
    		  var zk=(pprice*10.0/products[i].p_saleprice).toFixed(1);
    		  licls="";
    		  piccls="";
    		  if(!products[i].p_issgflag){
    		   licls='class="soldout"';
    		   piccls='<div class="isend"></div>';
    		  }
    		  if(i!=0&&(i+1)%2==0){
    			  licls='class=" r"';
    			  if(!products[i].p_issgflag){
    	    		   licls='class="soldout r"';
    	    		   piccls='<div class="isend"></div>';
    	    		  }
    		  }
    		 pli+='<li '+licls+'>';
    		 pli+='<div class="sgitem">';
    		 pli+='	<div class="pic"><a href="product.html?id='+products[i].p_gdsid+'">';
    		 pli+='	<img src="http://images.d1.com.cn/wap/2014/load.png" _src="'+products[i].p_img+'" border="0" >';
    	     pli+=''+piccls+'	</a></div>';
    		 pli+='	<div class="txt">';
    		pli+='		<p class="title"><a href="product.html?id='+products[i].p_gdsid+'">'+products[i].p_gdsname+'</a></p>';
    		pli+='		<div class="price">';
    		pli+='			<span class="m">￥'+parseInt(pprice)+'</span>';
    		pli+='		<span class="s">￥'+parseInt(products[i].p_saleprice)+'</span>';
    		pli+='		<span class="zk">'+ zk+'折</span>';
    		pli+='		   <p class="buytxt">'+products[i].p_buynum+'已购买</p>'; 
    		pli+='	   <div class="but">';
    		pli+='	     <a href="product.html?id='+products[i].p_gdsid+'"><i></i></a>';
    		pli+='	   </div>';
    		pli+='   </div> </div></div></li>';

    	 
    	   }
    	   $("#cjsg").html(pli);
    	}
    	$("#cjsg").parent().show();
    	}
    	
    	var phonedxs=eval(json.phonedxs);
    	if(typeof phonedxs!="undefined"){
    	if(phonedxs.length>0){
    		var pli="";
    		var licls="";
    		var len=phonedxs.length;
    	   for(var i=0;i<len;i++){
    		  var pprice=phonedxs[i].dx_mprice;
    		  //var zk=(pprice*10.0/phonedxs[i].dx_saleprice).toFixed(1);
    		
    		pli+='<li>';
    		pli+='<div class="iteml"><a href="product.html?id='+phonedxs[i].dx_gdsid+'"><img src="'+phonedxs[i].dx_img+'" border="0"></a></div>';
    		pli+='	  <div class="itemr">';
    		pli+='	      <span class="title"><a href="product.html?id='+phonedxs[i].dx_gdsid+'">'+phonedxs[i].dx_gdsname+'</a></span>';
    		pli+='		 <div class="ptxt">';
    		pli+='			 <span class="pm">￥'+pprice+'</span>';
    		pli+='			 <span class="pdx">手机独享价</span>';
    		pli+='		  </div>';
    		pli+='		  <div class="ptxt">';
    		pli+='			 <span class="pc">￥<s>'+phonedxs[i].dx_saleprice+'</s></span>';
    		pli+='		  </div>';
    		pli+='	  </div>';
    		pli+='  </li>';

    		
    	 
    	   }
    	   $("#dxpp").html(pli);
    	}
    	$("#dxpp").parent().show();
    	}
    	
    	var sglists=eval(json.sglist);
    	if(typeof sglists!="undefined"){
    	$("#sgnew").html('');
    	if(sglists.length>0){
    		var pli="";
    	   for(var i=0;i<sglists.length;i++){
    		  var pprice=sglists[i].p_mprice;
    		  if(sglists[i].p_issgflag||sglists[i].p_ismiaoshao){
    			  pprice=sglists[i].p_msprice;
    		  }
    		  var zk=(pprice*10.0/sglists[i].p_saleprice).toFixed(1);
    		pli='<li>';
    		pli+='<div class="iteml"><a href="product.html?id='+sglists[i].p_gdsid+'"><img src="'+sglists[i].p_img+'" border="0"></a></div>';
    		pli+='	  <div class="itemr">';
    		pli+='	      <span class="title"><a href="product.html?id='+sglists[i].p_gdsid+'">'+sglists[i].p_gdsname+'</a></span>';
    		pli+='		 <div class="ptxt">';
    		pli+='			 <span class="ps">';
    		if(sglists[i].p_time>0){
 			   pli+='<script>';
 			   pli+='the_s['+i+']='+sglists[i].p_time+';';
				     
 			   pli+='setInterval("view_time('+i+',\'tjsg_'+i+'\',0)",1000);';
				   pli+='<\/script><span id="tjsg_'+i+'">';
				   pli+='    </span>';
				 }
    		pli+='</span>';
    		pli+='			 <span class="pc">'+sglists[i].p_buynum+'已购买</span>';
    		pli+='		  </div>';
    		pli+='		  <div class="ptxt">';
    		pli+='		     <span class="pm">￥'+pprice+'</span>';
    		pli+='			 <span class="pc">￥<s>'+sglists[i].p_saleprice+'</s></span>';
    		pli+='		  </div>';
    		pli+='	  </div>';
    		pli+='  </li>';
    	   $("#sgnew").append(pli);
    	   }
    	   $("#sgnew").parent().hide();
    	}
    	}
    	
    	var phonems=eval(json.phonems);
    	if(typeof phonems!="undefined"){
    	if(phonems.length>0){
    		var pli="";
    		pli='<div class="rcklist"> <ul>';
    	   for(var i=0;i<phonems.length;i++){
    		  var pprice=phonems[i].p_mprice;
    		  if(phonems[i].p_issgflag||phonems[i].p_ismiaoshao){
    			  pprice=phonems[i].p_msprice;
    		  }
    		  var zk=(pprice*10.0/phonems[i].p_saleprice).toFixed(1);
    		  pli+='<li>';

    		  pli+='<div class="listitem">';
    		  pli+='	<div class="pic"><a href="product.html?id='+phonems[i].p_gdsid+'">';
    		  pli+='	<img src="http://images.d1.com.cn/wap/2014/load.png" _src="'+phonems[i].p_img+'" border="0" >';
    		  pli+='</a></div>';

    		  pli+='	<div class="txt">';
 
    		  var msflag=0;
    		  if(phonems[i].msnslen>0){
    				pli+='		<p class="mdtitle">开始：'+phonems[i].mssdate+'</p>';
    				msflag=1;
    			}else if(phonems[i].p_ismiaoshao&&phonems[i].p_vstock>0){
    				msflag=2;
    				
    				 pli+='<script>';
    				   pli+='the_s['+i+']='+phonems[i].mseslen+';';  

    				   pli+='setInterval("view_time('+i+',\'tjjs_'+i+'\')",1000);';
    				   pli+='<\/script>';
    				   pli+='		<p class="mdtitle"><span id="tjjs_'+i+'"></span></p>';
    			 }else if(phonems[i].msnelen>0||phonems[i].p_vstock<=0){
    				 msflag=3;
    					pli+='		<p class="mdtitle">已结束：</p>';
    			 }

    		  pli+='		<p class="title"><a href="product.html?id='+phonems[i].p_gdsid+'">'+phonems[i].p_gdsname+'</a></p>';
    		  pli+='		<div class="price">';
    		  pli+='			<span class="m">￥'+parseInt(pprice)+'</span>';
    		  pli+='		<span class="s">￥'+parseInt(phonems[i].p_saleprice)+'</span>';
    		  pli+='		<span class="zk">'+ zk+'折</span>';
    		  pli+='   </div> </div></div></li>';
    	 
    	   }
    	   pli+='  </ul><div style=" clear:both;"></div></div>';
    	   $(".ms2015").append(pli);
    	   $(".ms2015").show();
    	}
    	
    	}
    	
    	var phonepnew=eval(json.phonepnew);
    	if(typeof phonepnew!="undefined"){
    	if(phonepnew.length>0){
    		var pli="";
    		pli='<div class="rcklist"> <ul>';
    	   for(var i=0;i<phonepnew.length;i++){
    		  var pprice=phonepnew[i].p_mprice;
    		  if(phonepnew[i].p_issgflag||phonepnew[i].p_ismiaoshao){
    			  pprice=phonepnew[i].p_msprice;
    		  }
    		  var zk=(pprice*10.0/phonepnew[i].p_saleprice).toFixed(1);
    		  pli+='<li>';

    		  pli+='<div class="listitem">';
    		  pli+='	<div class="pic"><a href="product.html?id='+phonepnew[i].p_gdsid+'">';
    		  pli+='	<img src="http://images.d1.com.cn/wap/2014/load.png" _src="'+phonepnew[i].p_img+'" border="0" >';
    		  pli+='</a></div>';
    		  pli+='	<div class="txt">';
    		  pli+='		<p class="title"><a href="product.html?id='+phonepnew[i].p_gdsid+'">'+phonepnew[i].p_gdsname+'</a></p>';
    		  pli+='		<div class="price">';
    		  pli+='			<span class="m">￥'+parseInt(pprice)+'</span>';
    		  pli+='		<span class="s">￥'+parseInt(phonepnew[i].p_saleprice)+'</span>';
    		  pli+='		<span class="zk">'+ zk+'折</span>';
    		  pli+='   </div> </div></div></li>';
    	 
    	   }
    	   pli+='  </ul><div style=" clear:both;"></div></div>';
    	   $(".pnew2015").append(pli);
    	   $(".pnew2015").show();
    	}
    	
    	}
    	var phonephot=eval(json.phonephot);
    	if(typeof phonephot!="undefined"){
    	if(phonephot.length>0){
    		var pli="";
    		pli='<div class="rcklist"> <ul>';
    	   for(var i=0;i<phonephot.length;i++){
    		  var pprice=phonephot[i].p_mprice;
    		  if(phonephot[i].p_issgflag||phonephot[i].p_ismiaoshao){
    			  pprice=phonephot[i].p_msprice;
    		  }
    		  var zk=(pprice*10.0/phonephot[i].p_saleprice).toFixed(1);
    		  pli+='<li>';

    		  pli+='<div class="listitem">';
    		  pli+='	<div class="pic"><a href="product.html?id='+phonephot[i].p_gdsid+'">';
    		  pli+='	<img src="http://images.d1.com.cn/wap/2014/load.png" _src="'+phonephot[i].p_img+'" border="0" >';
    		  pli+='</a></div>';
    		  pli+='	<div class="txt">';
    		  pli+='		<p class="title"><a href="product.html?id='+phonephot[i].p_gdsid+'">'+phonephot[i].p_gdsname+'</a></p>';
    		  pli+='		<div class="price">';
    		  pli+='			<span class="m">￥'+parseInt(pprice)+'</span>';
    		  pli+='		<span class="s">￥'+parseInt(phonephot[i].p_saleprice)+'</span>';
    		  pli+='		<span class="zk">'+ zk+'折</span>';
    		  pli+='   </div> </div></div></li>';

    	   }
    	   pli+='  </ul><div style=" clear:both;"></div></div>';
    	   $(".phot2015").append(pli);
    	   $(".phot2015").show();
    	}
    	
    	}
    }
    
    function loadrck(){
    		  $.ajax({
    			type: 'get', 
    	        url: '/ajax/wap/getindexrck.jsp',
    			dataType:'json',
    			success: function(data){
    					/*处理数据*/
    					if(data.pstatus=="1"){
    						showrck(data);
    					meitem.getInViewportList();
    					}
    	        }
    		});
    		}


    		function showrck(p){	
    			var pliststr=p.plist;	
    			var plistarr=eval(pliststr);
    			if(plistarr.length>0){
    				
    		   for(var j=0;j<plistarr.length;j++){
       			var phtml="";
     		   phtml='<div><span class="tmtit"><h2><a href="/wap/result.html?rackcode='+plistarr[j].rckcode+'">'+plistarr[j].rcktitle+'</a></h2></span>'
    		   if(plistarr[j].rckadurl!=""&&plistarr[j].rckad!=""){
    		   phtml+='	<div class="adimg"><a href="'+plistarr[j].rckadurl+'">';
    		   phtml+='	<img src="'+plistarr[j].rckad+'" border="0" >';
    		   phtml+='</a></div>';
    		   }
  		      var rckstr=plistarr[j].rcks;
      		var rcks=eval(rckstr);
      		var rckcount=rcks.length;
      		  
      		if(rckcount>0){
      		  phtml+='<div class="rckitem">';
      			 for(var i=0;i<rckcount;i++){
       			  phtml+='<a href="'+rcks[i].rckurl+'">'+rcks[i].rckname+'</a>';
      			 }
      			 phtml+='</div>';
      			 }
    		   
    		   var productstr=plistarr[j].products;
    		var products=eval(productstr);
    		var procount=products.length;
    		  
    		if(procount>0){
                phtml+='<div class="rcklist">';
    			phtml+='<ul>';
    		   for(var i=0;i<procount;i++){
    			   if(i==6)break;
    			  var pprice=products[i].p_mprice;
    			  if(products[i].p_issgflag||products[i].p_ismiaoshao){
    				  pprice=products[i].p_msprice;
    			  }
    			  var zk=(pprice*10.0/products[i].p_saleprice).toFixed(1);

    			
    			licls="";
    			  piccls="";

    			  if(i!=0&&(i+1)%2==0){
    				  licls='class=" r"';

    			  }
    			  
    			  phtml+='<li '+licls+'>';

    			  phtml+='<div class="listitem">';
    			  phtml+='	<div class="pic"><a href="product.html?id='+products[i].p_gdsid+'">';
    			  phtml+='	<img src="http://images.d1.com.cn/wap/2014/load.png" _src="'+products[i].p_img+'" border="0" >';
    			  phtml+=''+piccls+'	</a></div>';
    			  phtml+='	<div class="txt">';
    			  phtml+='		<p class="title"><a href="product.html?id='+products[i].p_gdsid+'">'+products[i].p_gdsname+'</a></p>';
    			  phtml+='		<div class="price">';
    			  phtml+='			<span class="m">￥'+parseInt(pprice)+'</span>';
    			  phtml+='		<span class="s">￥'+parseInt(products[i].p_saleprice)+'</span>';
    			  phtml+='		<span class="zk">'+ zk+'折</span>';
    			  phtml+='   </div> </div></div></li>';
    		   
    		   }
    		   phtml+='</ul><div style=" clear:both;"></div></div>';
    		 
    		}
    		 phtml+='</div>';
    		  $("#racks").append(phtml);
    	  }
    	 }
    	}
    		
    
    
	