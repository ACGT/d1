<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>打造三月春女郎</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/magazine.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>

<body>
<div id="wrapper">
	<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
 
    <!-- 中间内容 -->
       <div class="center">
           <div class="left">
              <img src="http://images.d1.com.cn/Index/YouShang(2).jpg" style=" margin:0px;"></img>
              <div class="ys_list" style="margin-top:-3px;">
               <%
                  ArrayList<Promotion> list=new ArrayList<Promotion>();
                  list=PromotionHelper.getBrandListByCode("2776", 100);
                  StringBuilder sb=new StringBuilder();
                  StringBuilder sb1=new StringBuilder();
                  if(list!=null&&list.size()>0)
                  {
                	  sb.append("<dl>");
                	  sb1.append("<select class=\"nselect\" id=\"titleselect\">");
                	  sb1.append("<option value=''>---请选择---</option>");
                	  for(Promotion p:list)
                	  {
                		  if(p!=null)
                		  {
                			  String title="";
                			  if(p.getSplmst_name().length()>0)
                			  {
                				  title=Tools.clearHTML(p.getSplmst_name());
                			  }
                			  
                			  sb.append("<dt><a href=\""+StringUtils.encodeUrl(p.getSplmst_url())+"\" target=\"_blank\"><img src=\""+p.getSplmst_picstr()+"\" alt=\""+title+"\" width=\"180\" height=\"225\"></a></dt>");
                			  sb.append("<dd><a href=\""+StringUtils.encodeUrl(p.getSplmst_url())+"\" target=\"_blank\">"+title+"</a></dd>");
                			  String newtitle=title.substring(0,title.indexOf("期")+1);
                			  sb1.append("<option value=\""+StringUtils.encodeUrl(p.getSplmst_url())+"\">"+newtitle+"</option>");
                		  }
                	  }
                	  sb.append("</dl>");
                	  sb1.append("</select>");
                  }
                  out.print(sb);
              %>
              </div>
           
           </div>
           
           <div  class="right" >
		    <table style="width:769px;">
               <tr>
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012MAR 第一期--打造三月春女郎</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
               <!-- ImageReady Slices (2012MAR.psd) -->
  <table id="__01" width="770" height="3401" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_01.jpg" width="769" height="256" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="256" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_02.jpg" width="769" height="219" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="219" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_03.jpg" width="769" height="241" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="241" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_04.jpg" width="769" height="237" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="237" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_05.jpg" width="769" height="341" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="341" alt=""></td>
	  </tr>
    <tr>
      <td colspan="3">
        <a href="http://www.d1.com.cn/product/01413703" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_06.jpg" alt="" width="305" height="162" border="0"></a></td>
	    <td colspan="6">
		    <a href="http://www.d1.com.cn/product/01413223" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_07.jpg" alt="" width="330" height="162" border="0"></a></td>
	    <td>
		    <a href="http://www.d1.com.cn/product/01409782" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_08.jpg" alt="" width="134" height="162" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="162" alt=""></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01406325" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_09.jpg" alt="" width="280" height="217" border="0"></a></td>
	    <td colspan="7">
		    <a href="http://www.d1.com.cn/product/01413048" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_10.jpg" alt="" width="275" height="217" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01409782" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_11.jpg" alt="" width="214" height="217" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="217" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_12.jpg" width="769" height="233" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="233" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_13.jpg" width="769" height="216" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="216" alt=""></td>
	  </tr>
    <tr>
      <td colspan="5">
        <a href="http://www.d1.com.cn/product/01414295" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_14.jpg" alt="" width="374" height="190" border="0"></a></td>
	    <td colspan="5">
		    <a href="http://www.d1.com.cn/product/01414293" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_15.jpg" alt="" width="395" height="190" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="190" alt=""></td>
	  </tr>
    <tr>
      <td colspan="4">
        <a href="http://www.d1.com.cn/product/01410219" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_16.jpg" alt="" width="337" height="164" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01416496" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_17.jpg" alt="" width="179" height="164" border="0"></a></td>
	    <td colspan="4" rowspan="2">
		    <a href="http://www.d1.com.cn/product/01416638" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_18.jpg" alt="" width="253" height="218" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="164" alt=""></td>
	  </tr>
    <tr>
      <td colspan="6" rowspan="2">
        <a href="http://www.d1.com.cn/product/01416496" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_19_1.jpg" alt="" width="516" height="215" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="54" alt=""></td>
	  </tr>
    <tr>
      <td colspan="4">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_20.jpg" width="253" height="161" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="161" alt=""></td>
	  </tr>
    <tr>
      <td colspan="10">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_21.jpg" width="769" height="199" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="199" alt=""></td>
	  </tr>
    <tr>
      <td colspan="7">
        <img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_22.jpg" width="542" height="293" alt=""></td>
	    <td colspan="3" rowspan="2">
		    <a href="http://www.d1.com.cn/product/01718791" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_23.jpg" alt="" width="227" height="510" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="293" alt=""></td>
	  </tr>
    <tr>
      <td colspan="2">
        <a href="http://www.d1.com.cn/product/01408558" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_24.jpg" alt="" width="293" height="217" border="0"></a></td>
	    <td colspan="5">
		    <a href="http://www.d1.com.cn/product/01718791" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//2012MAR_25.jpg" alt="" width="249" height="217" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="217" alt=""></td>
	  </tr>
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="280" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="13" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="12" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="32" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="37" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="142" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="26" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="13" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="80" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="134" height="1" alt=""></td>
	    <td></td>
	  </tr>
  </table>
  <!-- End ImageReady Slices -->

               
               </div>
           </div>
       
       </div>
       
    
    <!-- 中间内容结束 -->
    <div class="clear"></div>
    <%@include file="/inc/foot.jsp" %>

	
</div>
</body>
</html>	
<script type="text/javascript">
$(document).ready(function() {   
	
		 $("#titleselect").change(function(){   
              location.href=$("#titleselect option:selected").val();
		 })   
	 });
</script>