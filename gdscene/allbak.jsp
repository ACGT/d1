<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-最新搭配</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  .middle{ width:980px; margin:0px auto; padding-top:10px;}
  .middle ul li{position:relative;}
  .banner{ width:980px; height:61px; margin:0px auto; display:block; background:url('http://images.d1.com.cn/images2012/index2012/nov/women.jpg') no-repeat;}
  .banner span{ display:block; width:300px; height:59px;float:left;}
  .banner1{ width:980px; height:61px; margin:0px auto; display:block; background:url('http://images.d1.com.cn/images2012/index2012/nov/men.jpg') no-repeat;}
  .banner1 span{ display:block; width:300px; height:59px; float:left;}
  #women,#men{ width:980px;}
  ul{ margin:0px; padding:0px; list-style:none;}
  #men li{float:left; margin-right:14px;}
  .pp{ padding-top:10px;}
  #women{position: relative;background:#fdefec; height:362px;width:980px;}
  #women li{ float:left; margin-right:5px;}
  .preNext { position:absolute; top:0px;  cursor:pointer;}
  .pre2012 {left:0px; }
  .next2012 {right:0px; }
  #womenlist ul{position:absolute;}
  .fmlist{height:1200px;overflow:hidden;}
  .fmlist ul{list-style:none; margin:0px; padding:0px;width:980px; overflow:hidden; }
  .fmlist li{ float:left; margin-left:-60px;+margin-left:-53px; height:400px;overflow:hidden;}
  .fmlist ul li p {margin-top: 11px;_margin-top: 2px;margin-left: 35px;width: 175px;}
  .fmlist ul li p span {display: block;width: 80px;text-align: left;float: left;}
  .fmlist ul li p span font{font-size:12px;}
</style>

</head>
<body>
<%
   String defaultw="";
   String defaultm="";
%>
<%@include file="/inc/head.jsp" %>
  <div class="middle">
     <div id="banner" class="banner">
         <span attr="women">
         
         </span>
         <span attr="men">
         
         </span>
     </div>
     <div id="women" style="display:block;">
        <div id="womenlist" style="position:relative;width: 912px; height:362px;overflow: hidden;margin-left:38px;">
            <%
                    ArrayList<Promotion> mlist=new ArrayList<Promotion>();
                    mlist=PromotionHelper.getBrandListByCode("3272", 8);
                    if(mlist!=null&&mlist.size()>0)
                    {
                    	out.print("<ul>");
                    	int count=0;
                    	for(Promotion p:mlist)
                    	{
                    		if(p!=null)
                    		{
                    		    count++;
                    		    if(count==1)
                    		    {
                    		    	defaultw=p.getSplmst_name();
                    		    }
                    		    %>
                    			<li>
                    		
                    			   <a href="<%= p.getSplmst_url() %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" onmouseover="getGdscoll('<%= p.getSplmst_name().trim() %>')"/></a>
                    			</li>
                    		<%
                    		   if(count>=8)
                    		   {
                    			   break;
                    		   }
                    		}
                    	}
                    	out.print("</ul>");
                    }
                %>
        </div>
        <div class="preNext pre2012">
							 <img id="tprev1" src="http://images.d1.com.cn/images2012/index2012/nov/left1.jpg" >
		</div>
		<div class="preNext next2012">
							 <img id="tprev1" src="http://images.d1.com.cn/images2012/index2012/nov/right1.jpg" width="35">
		</div>
     </div>  
 
    <div id="men" style="display:none;">
        <table>
          <tr>
             <td>
                <%
                    ArrayList<Promotion> mlist1=new ArrayList<Promotion>();
                    mlist1=PromotionHelper.getBrandListByCode("3273", 5);
                    if(mlist1!=null&&mlist1.size()>0)
                    {
                    	out.print("<ul>");
                    	int count=0;
                    	for(Promotion p:mlist1)
                    	{
                    		if(p!=null)
                    		{
                    		    count++;
                    		    if(count==1)
                    		    {
                    		    	defaultm=p.getSplmst_name();
                    		    }
                    		    if(count%3==0)
                    		    {%>
                    		    	<li style="margin-right:0px;">
                    		    <%}
                    		    else
                    		    {
                    		%>
                    			<li>
                    			<%} %>
                    			   <a href="<%= p.getSplmst_url() %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" onmouseover="getGdscoll('<%= p.getSplmst_name().trim() %>')"/></a>
                    			</li>
                    		<%
                    		   if(count>=3)
                    		   {
                    			   break;
                    		   }
                    		}
                    	}
                    	out.print("</ul>");
                    }
                %>
             </td>
          </tr>  
        </table>
        
        
    </div>
    
    <div id="jztm" class="pp"></div>
    <div id="qpka" class="pp"></div>
    <div id="yysn" class="pp"></div>
    <div id="zcol" class="pp"></div>
    <div id="jtdn" class="pp"></div>
    <div id="gjjd" class="pp"></div>
    <div id="hlxx" class="pp"></div>
    <div id="hwxx" class="pp"></div>
    <div id="bmjz"  class="pp"></div>
    <div id="xbhw"  class="pp"></div>
    <div id="jjxy"  class="pp"></div>
    
     
     <input type="hidden" id="wd" value="<%= defaultw %>"/>
     <input type="hidden" id="md" value="<%= defaultm %>"/>
  </div>
  
  
<div class="clear"></div>


   <!-- 底部 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 底部结束 -->
   
</body>
</html>
<script type="text/javascript" language="javascript">
$(document).ready(function() {
	getGdscoll($('#wd').val());
	g_productscoll("#women","#womenlist");
    $(".banner").find('span').each(function(i){
    	$(this).mouseover(function(){
    		var id=$(this).attr("attr");
    		$('#women').css('display','none');
    		$('#men').css('display','none');
    		if(id=='women')
    		{
    			   $('#banner').removeClass('banner1');
    			   $('#banner').addClass('banner');
    			   getGdscoll($('#wd').val());
    		}
    		else
    		{
    			   $('#banner').removeClass('banner');
 			       $('#banner').addClass('banner1');
 			      getGdscoll($('#md').val());
    		}
    		$('#'+id).css('display','block');
    	});
    	
    });
    });
    
   function getGdscoll(id)
   {
	   var obj=$('#'+id);
	   if(obj.length>0)
	   {		  
		    if(obj.html()=='')
		    {
		    	$(".pp").css('display','none');		    	
		    	$.post("/gdscene/getnewgdscoll.jsp",{"id":id},function(data){		    		
		    		$(obj).html(data);
		    	});		
		    	obj.css('display',"block");	
		    }
		    else
		    {
		    	
		    	$(".pp").css('display','none');
		        obj.css('display',"block");	
		    }
		}
   }

   function g_productscoll(obj,obj1){	  
   	var sWidth = $(obj1).width();
   	
   	var len = parseInt($(obj+" ul li").length/4); 
   	if($(obj+" ul li").length%4>0)
   	{
   	    len=len+1;
   	}	
   	var index = 0;
   	var picTimer;
   	
   	//上一页按钮
   	$(obj+" .pre2012").click(function() {
   		index -= 1;
   		if(index == -1) {index = len - 1;}
   		if(index==0)
   			{
   			getGdscoll('jztm');
   			}
   		else
   			{
   			getGdscoll('jtdn');
   			}
   		showPics(index);
   	});

   	//下一页按钮
   	$(obj+" .next2012").click(function() {
   		index += 1;
   		if(index == len) {index = 0;}
   		if(index==0)
			{
			getGdscoll('jztm');
			}
		else
			{
			getGdscoll('jtdn');
			}
   		showPics(index);
   	});
  
   	$(obj+" div ul").css("width",sWidth * (len)+100);
   	
   	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
   	$('.middle').hover(function() {
   		clearInterval(picTimer);
   	},function() {
   		picTimer = setInterval(function() {
   			showPics(index);
   			index++;
   			if(index == len) {index = 0;}
   			if(index==1)
			{
			getGdscoll('jztm');
			}
		else
			{
			getGdscoll('jtdn');
			}
   		},4000); 
   	}).trigger("mouseleave");
   	
   	//显示图片函数，根据接收的index值显示相应的内容
   	function showPics(index) { //普通切换
   	  
   	      var nowLeft = -index*sWidth; //根据index值计算ul元素的left值 
   		
   		$(obj+" ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
   		
   	}
   }
    
</script>

