<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="public.jsp"%>
<%@include file="/html/public.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【正品行货】配饰/配饰_配饰品牌_价格_图片-D1优尚网</title>
<meta name="Description" content="D1优尚网配饰,配饰频道，提供最新款配饰品牌、配饰价格、配饰图片以及配饰搭配图。想通过网上购物买到名牌配饰，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网,配饰" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/channel.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style>
.dh ul li {margin-left: 12px;margin-right: 12px;float: left;font-size: 18px;color: #333;font-family: '微软雅黑';}
.spjrtg{ margin-top:10px; list-style:none;}
.spjrtg li{ width:320px; border:solid 1px #ccc; float:left; margin-right:3px; margin-bottom:10px;}
.spjrtg span{ display:block; width:320px; margin:0px auto; font-size:15px; height:26px; line-height:28px; text-align:center;}
.spjrtg span em{ font-size:19px; color:#f1931f; font-style:normal; font-weight:bold; padding:2px;  padding-top:0px; padding-bottom:0px;}
.spjrtg a img{ border:none;}
</style>
<script language="javascript" type="text/javascript">
	//限时抢购
	var the_s=new Array();	
	function $getid(id)
	{
	    return document.getElementById(id);
	}
	function view_time(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
	        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = "剩余";
	        if(the_D!=0) html += '<em>'+the_D+"</em>天";
	        //if(the_D!=0 || the_H!=0) html += '<em>'+((the_D*24)+(the_H))+"</em>小时";
	        if(the_D!=0 || the_H!=0) html += '<em>'+((the_H))+"</em>小时";
	        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<em>'+the_M+"</em>分";
	        html += '<em>'+the_S+"</em>秒";
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }else{
	        $getid(objid).innerHTML = "已结束";
	    }
	}
	function addCart1(id,obj){
		$.post("/html/getCoscount.jsp",{"id":id},function(data){});	
		$.inCart(obj);
	}
	function addCart(obj){
		$.inCart(obj,{ajaxUrl:'/ajax/flow/listTuanInCartNew.jsp'});
	}
</script>
</head>

<body>
<div id="wrapper">
		<!--头部-->
		<%@include file="../../inc/head.jsp" %>
		<!-- 头部结束-->
		
		<!-- 中间内容 -->		
		<div class="center">
		<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/scrollimg.js")%>"></script>
		<div class="dh">
		   <table width="980" height="42">
		       <tr><td width="140" style="padding-left:15px;font-size:20px; font-family:'微软雅黑';  color:#fff;">
		       配饰专区
		       </td><td width="700">
		       <ul>
		       <%
		           ArrayList<Promotion> tlist=PromotionHelper.getBrandListByCode("3288",11);
		           if(tlist!=null&&tlist.size()>0)
		           {
		        	   for(Promotion p:tlist)
		        	   {
		        		   if(p!=null)
		        		   {%>
		        			   <li><a href="<%= p.getSplmst_url() %>" target="_blank"><%= p.getSplmst_name() %></a></li>
		        		   <%}
		        	   }
		           }
		       %>
		          
		       </ul>
		       </td><td><a href="http://www.d1.com.cn/result.jsp?productsort=015,021,022,031,032&order=3" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/nov/allyrf.jpg"/></a></td></tr>
		   </table>
		</div>
		<div class="clear"></div>
		  <div class="scrollimglist">
		 
                <script>ShowCenter(<%= ScrollImg("3294") %>,<%= ScrollText("3294") %>,980,400,3000)</script>     </div>
         
            <!--滚动图结束-->
		 
		 <div class="clear"></div>
		 <!-- 今日团购 -->
		  <div class="gdsmstlist">
		     <div class="gtitle">
		        <img src="http://images.d1.com.cn/images2013/sp/7.jpg" width="980" height="46" border="0" >
		     </div>
		     <div class="spjrtg">
               <ul class="spjrtg">
               <%
                   ArrayList<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode("8570");
                   if(pplist!=null&&pplist.size()>0)
                   {
                	   int i=0;
                	   for(PromotionProduct pp:pplist)
                	   {
                		   if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0)
                		   {
                			   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                			   Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
                			   long currentTime = System.currentTimeMillis();
                			   if(p!=null){
                				   float memberprice = Tools.floatValue(p.getGdsmst_memberprice());//会员价
                				   long discountendDate = Tools.dateValue(p.getGdsmst_discountenddate());//应该是秒杀结束的时间。
                				   float oldmemberprice = Tools.floatValue(p.getGdsmst_oldmemberprice());//旧的会员价
                			   if(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS && Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0)
                			   {
          			        	 long begindate=Tools.dateValue(pp.getSpgdsrcm_begindate());
          			        	 long nowtime1=System.currentTimeMillis();
          			        	if(discountendDate>=nowtime1)
          			        	{
                			      i++;
                			      String imgurl=pp.getSpgdsrcm_otherimg();
                			      if(Tools.isNull(imgurl)){
                			      imgurl=ProductHelper.getImageTo400(p);
                			      }
                			      if(i%4==0)
                			      {%>
                			    	<li style="margin-right:0px;">
                			      <%}
                			      else
                			      {%>
                			    	   <li>
                			      <%}
                			   %>
                				
                				   <span id="xstj_<%=i%>">剩余<em>00</em>天<em>00</em>时<em>00</em>分<em>00</em>秒
                				    <%
                				    String	nowtime= DateFormat.format( new Date());
     						        String endtime= DateFormat.format(discountendDate);
                				    
						           %>
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime%>");
                             var endDate= new Date("<%=endtime%>");
                             the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(<%=i%>,'xstj_<%=i%>')",1000);
                             </SCRIPT>
                				   </span>
                				  <!--  <span style="background:#f2f2f2; color:#333; font-size:13px; height:18px; line-height:20px; padding:0px;">已销售<%//= pp.getSpgdsrcm_tghit() %></span>--> 
                				  <span style=" height:312px; padding-top:10px;">
				                   <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank"><img src="<%= imgurl%>" width="302" height="302" /></a>
				                  </span>
				                  <span style="background:url('http://images.d1.com.cn/images2012/index2012/JULY/btn.jpg') no-repeat center; height:38px; text-align:center; line-height:38px; color:#fff; overflow:hidden;">
				                  <table style="width:100%; height:100%;" align="center">
				                     <tr><td width="80"></td>
				                     <td align="left">&nbsp;&nbsp;￥<font style="color:#fff; font-size:30px; padding-top:2px; font-weight:bold; font-family:'宋体'"><%= Tools.getFormatMoney(memberprice) %></font></td>
				                     <td><a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank" style="color:#fff; text-decoration:none;">抢购</a>
				                     <!-- <a href="javascript:void(0)" style="color:#fff; text-decoration:none;" attr="<%//=pp.getId() %>" onclick="addCart(this);">抢购</a>-->
				                     </td>
				                     <td width="80"></td>
				                     </tr>
				                  </table>
				                  </span>
				                  <span style=" height:30px; line-height:32px;"><a style=" color:#000; font-size:12px;" href="http://www.d1.com.cn/product/<%= p.getId()%>" target="_blank"><%= Tools.substring(Tools.clearHTML(pp.getSpgdsrcm_gdsname()),24) %></a></span>
                				 </li>
                				   
                			   <%}
                			   }
                		    }
                		   }
                	   }
                   }
               %>
            </ul>
            </div>
         
		 </div>
               <!-- 今日团购结束 -->
            <div class="clear"></div>
           <div class="gdsmstlist">
		     <div class="gtitle">
		         <img src="http://images.d1.com.cn/images2013/sp/6.jpg" width="980" height="46" border="0" />
		     </div>
		     <table width="980" border="0" cellspacing="0" cellpadding="0" style="background:#f1f1f1">
  <tr>
    <td width="175"><table width="100%" height="340" border="0" cellpadding="0" cellspacing="0">
    <%List<Promotion> list=PromotionHelper.getBrandListByCode("3387", -1);
	if(list!=null&&list.size()>0)
	{
		for(int i=0;i<list.size();i++)
		{ 
			Promotion p=list.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
		%>
      <tr>
        <td align="center"><a href="<%=url %>" target="_blank"><img src="<%=StringUtils.clearHTML(p.getSplmst_picstr())%>" border="0" /></a></td>
      </tr>
      <%}
		}%>
    </table></td>
    <td><table width="100%" height="340" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <%List<Promotion> list234=PromotionHelper.getBrandListByCode("3388", -1);
	if(list234!=null&&list234.size()>0)
	{
		for(int i=0;i<list234.size();i++)
		{ 
			Promotion p234=list234.get(i);
			String url=StringUtils.encodeUrl(p234.getSplmst_url()).replace("aspx", "jsp");
		%>
        <td><a href="<%=url %>" target="_blank"><img src="<%=StringUtils.clearHTML(p234.getSplmst_picstr())%>" border="0" /></a></td>
      <%}
		}%>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>	     
		 </div>		 
		  <div class="gdsmstlist">
		     <div class="gtitle"><img src="http://images.d1.com.cn/images2013/sp/1.jpg" width="980" height="46" border="0" usemap="#Mapsssp" />
<map name="Mapsssp" id="Mapsssp">
<area shape="rect" coords="886,4,978,41" href="http://www.d1.com.cn/result.jsp?productsort=015009"  target="_blank"/></div>
		     <%=getprec("8571")%>		     
		 </div>
		 
		 <div class="gdsmstlist">
		      <div class="gtitle"><img src="http://images.d1.com.cn/images2013/sp/2.jpg" width="980" height="46" border="0" usemap="#Mapssmp" />
<map name="Mapssmp" id="Mapssmp">
<area shape="rect" coords="886,4,978,41" href="http://www.d1.com.cn/result.jsp?productsort=015002"  target="_blank"/></div>
		     <%=getprec("8572")%>			     
		 </div>
		 
		  <div class="gdsmstlist">
			     <div class="gtitle"><img src="http://images.d1.com.cn/images2013/sp/3.jpg" width="980" height="46" border="0" usemap="#Mapsssy" />
<map name="Mapsssy" id="Mapsssy">
<area shape="rect" coords="886,4,978,41" href="http://www.d1.com.cn/result.jsp?productsort=020012"  target="_blank"/></div>
	
		      <%=getprec("8573")%>			     
		 </div>
		 
		  <div class="gdsmstlist">
		     <div class="gtitle"><img src="http://images.d1.com.cn/images2013/sp/4.jpg" width="980" height="46" border="0" usemap="#Mapsspj" />
<map name="Mapsspj" id="Mapsspj">
<area shape="rect" coords="886,4,978,41" href="http://www.d1.com.cn/result.jsp?productsort=023,033"  target="_blank"/></div>
	
		     <%=getprec("8574")%>			     
		 </div>
		 
		 <div class="gdsmstlist">
		     <div class="gtitle">
<img src="http://images.d1.com.cn/images2013/sp/5.jpg" width="980" height="46" border="0" usemap="#Mapssother" />
<map name="Mapssother" id="Mapssother">
<area shape="rect" coords="886,4,978,41" href="http://www.d1.com.cn/result.jsp?productsort=021,022"  target="_blank"/></div>
	
		     <%=getprec("8575")%>			     
		 </div>
		
			  </div>
		<!-- 中间内容结束 -->
		<div class="clear"></div>
		
        <!-- 尾部 -->
		<%@include file="../../inc/foot.jsp" %>
		<!-- 尾部结束 -->
</div>
</body>

</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script> 
<script type="text/javascript" language="javascript"> 
 $(document).ready(function() {
        //$(".gdmstlist_sub").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
    });
</script>