<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>韩式甜妞吸晴早春搭</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012MAR 第二期--韩式甜妞吸晴早春搭</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
             <!-- ImageReady Slices (2012MAR.psd) -->
  <table id="__01" width="770" height="3204" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="12">
        <a href="http://www.d1.com.cn/product/01720426" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_01.jpg" alt="" width="439" height="555" border="0"></a></td>
	    <td colspan="7">
		    <img src="http://images.d1.com.cn/magazine/women/2012MAR2_02.jpg" width="330" height="555" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="555" alt=""></td>
	  </tr>
    <tr>
      <td colspan="19">
        <img src="http://images.d1.com.cn/magazine/women/2012MAR2_03.jpg" width="769" height="95" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="95" alt=""></td>
	  </tr>
    <tr>
      <td colspan="19">
        <img src="http://images.d1.com.cn/magazine/women/2012MAR2_04.jpg" width="769" height="136" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="136" alt=""></td>
	  </tr>
    <tr>
      <td rowspan="3">
        <a href="http://www.d1.com.cn/product/01720374" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_05.jpg" alt="" width="151" height="399" border="0"></a></td>
	    <td colspan="4" rowspan="2">
		    <a href="http://www.d1.com.cn/product/01720392" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_06.jpg" alt="" width="135" height="204" border="0"></a></td>
	    <td colspan="6" rowspan="3">
		    <a href="http://www.d1.com.cn/product/01720375" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_07.jpg" alt="" width="137" height="399" border="0"></a></td>
	    <td colspan="5" rowspan="3">
		    <a href="http://www.d1.com.cn/product/01720408" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_08.jpg" alt="" width="134" height="399" border="0"></a></td>
	    <td colspan="3">
		    <a href="http://www.d1.com.cn/product/01720313" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_09.jpg" alt="" width="212" height="194" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="194" alt=""></td>
	  </tr>
    <tr>
      <td colspan="3" rowspan="2">
        <a href="http://www.d1.com.cn/product/01720428" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_10.jpg" alt="" width="212" height="205" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="10" alt=""></td>
	  </tr>
    <tr>
      <td colspan="4">
        <img src="http://images.d1.com.cn/magazine/women/2012MAR2_11.jpg" width="135" height="195" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="195" alt=""></td>
	  </tr>
    <tr>
      <td colspan="19">
        <img src="http://images.d1.com.cn/magazine/women/2012MAR2_12.jpg" width="769" height="107" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="107" alt=""></td>
	  </tr>
    <tr>
      <td colspan="4">
        <a href="http://www.d1.com.cn/product/01720591" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_13.jpg" alt="" width="205" height="408" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01720592" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_14.jpg" alt="" width="141" height="408" border="0"></a></td>
	    <td colspan="5">
		    <a href="http://www.d1.com.cn/product/01720597" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_15.jpg" alt="" width="102" height="408" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01720590" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_16.jpg" alt="" width="135" height="408" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01720594" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_17.jpg" alt="" width="186" height="408" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="408" alt=""></td>
	  </tr>
    <tr>
      <td colspan="3">
        <a href="http://www.d1.com.cn/product/01720600" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_18.jpg" alt="" width="199" height="470" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01720598" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_19.jpg" alt="" width="140" height="470" border="0"></a></td>
	    <td colspan="7">
		    <a href="http://www.d1.com.cn/product/01720410" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_20.jpg" alt="" width="110" height="470" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01720295" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_21.jpg" alt="" width="139" height="470" border="0"></a></td>
	    <td>
		    <a href="http://www.d1.com.cn/product/01720596" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_22.jpg" alt="" width="181" height="470" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="470" alt=""></td>
	  </tr>
    <tr>
      <td colspan="15">
        <img src="http://images.d1.com.cn/magazine/women/2012MAR2_23.jpg" width="553" height="128" alt=""></td>
	    <td colspan="4" rowspan="2">
		    <a href="http://www.d1.com.cn/product/01717666" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_24.jpg" alt="" width="216" height="552" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="128" alt=""></td>
	  </tr>
    <tr>
      <td colspan="2">
        <a href="http://www.d1.com.cn/product/01720599" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_25.jpg" alt="" width="172" height="424" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01720440" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_26.jpg" alt="" width="141" height="424" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01720432" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_27.jpg" alt="" width="105" height="424" border="0"></a></td>
	    <td colspan="5">
		    <a href="http://www.d1.com.cn/product/01720431" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_28.jpg" alt="" width="135" height="424" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="424" alt=""></td>
	  </tr>
    <tr>
      <td colspan="19">
        <img src="http://images.d1.com.cn/magazine/women/2012MAR2_29.jpg" width="769" height="103" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="103" alt=""></td>
	  </tr>
    <tr>
      <td colspan="9">
        <a href="http://www.d1.com.cn/product/01516976" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_30.jpg" alt="" width="381" height="188" border="0"></a></td>
	    <td colspan="10">
		    <a href="http://www.d1.com.cn/product/01516843" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_31.jpg" alt="" width="388" height="188" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="188" alt=""></td>
	  </tr>
    <tr>
      <td colspan="19">
        <a href="http://www.d1.com.cn/product/01516971" target="_blank"><img src="http://images.d1.com.cn/magazine/women/2012MAR2_32.jpg" alt="" width="769" height="190" border="0"></a></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="190" alt=""></td>
	  </tr>
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="151" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="21" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="27" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="6" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="81" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="27" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="26" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="7" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="35" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="37" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="5" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="16" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="9" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="104" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="4" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="26" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="5" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="181" height="1" alt=""></td>
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