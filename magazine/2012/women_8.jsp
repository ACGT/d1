<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>早春针织衫搭配推荐</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012FEB 第八期--早春针织衫搭配推荐</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
             <!-- ImageReady Slices (FEB.psd) -->
  <table id="__01" width="769" height="5890" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="9">
        <img src="http://images.d1.com.cn/magazine/women/FEB_01_1.jpg" alt="" width="769" height="710" border="0" usemap="#Map"></td>
	  </tr>
    <tr>
      <td colspan="9">
        <img src="http://images.d1.com.cn/magazine/women/FEB_02.jpg" alt="" width="769" height="584" border="0" usemap="#Map2"></td>
	  </tr>
    <tr>
      <td colspan="9">
        <img src="http://images.d1.com.cn/magazine/women/FEB_03.jpg" alt="" width="769" height="666" border="0" usemap="#Map3"></td>
	  </tr>
    <tr>
      <td colspan="4">
        <img src="http://images.d1.com.cn/magazine/women/FEB_04.jpg" width="275" height="256" alt=""></td>
	    <td colspan="3">
		    <a href="http://www.d1.com.cn/product/01719514" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_05.jpg" alt="" width="231" height="256" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01719932" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_06.jpg" alt="" width="263" height="256" border="0"></a></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01719467" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_07.jpg" alt="" width="258" height="289" border="0"></a></td>
	    <td colspan="6">
		    <a href="http://www.d1.com.cn/product/01719450" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_08.jpg" alt="" width="248" height="289" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01717315" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_09.jpg" alt="" width="263" height="289" border="0"></a></td>
	  </tr>
    <tr>
      <td colspan="5">
        <img src="http://images.d1.com.cn/magazine/women/FEB_10.jpg" width="431" height="172" alt=""></td>
	    <td colspan="4" rowspan="2">
		    <a href="http://www.d1.com.cn/product/01718756" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_11.jpg" alt="" width="338" height="572" border="0"></a></td>
	  </tr>
    <tr>
      <td colspan="5">
        <img src="http://images.d1.com.cn/magazine/women/FEB_12.jpg" alt="" width="431" height="400" border="0" usemap="#Map4"></td>
	  </tr>
    <tr>
      <td colspan="9">
        <img src="http://images.d1.com.cn/magazine/women/FEB_13.jpg" alt="" width="769" height="369" border="0" usemap="#Map5"></td>
	  </tr>
    <tr>
      <td colspan="3">
        <img src="http://images.d1.com.cn/magazine/women/FEB_14.jpg" width="264" height="269" alt=""></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01719187" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_15.jpg" alt="" width="242" height="269" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01715795" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_16.jpg" alt="" width="263" height="269" border="0"></a></td>
	  </tr>
    <tr>
      <td colspan="3">
        <a href="http://www.d1.com.cn/product/01715190" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_17.jpg" alt="" width="264" height="285" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01715793" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_18.jpg" alt="" width="242" height="285" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01719456" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_19.jpg" alt="" width="263" height="285" border="0"></a></td>
	  </tr>
    <tr>
      <td colspan="3">
        <a href="http://www.d1.com.cn/product/01717667" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_20.jpg" alt="" width="264" height="325" border="0"></a></td>
	    <td colspan="4">
		    <a href="http://www.d1.com.cn/product/01716700" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_21.jpg" alt="" width="242" height="325" border="0"></a></td>
	    <td colspan="2">
		    <a href="http://www.d1.com.cn/product/01717310" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_22.jpg" alt="" width="263" height="325" border="0"></a></td>
	  </tr>
    <tr>
      <td colspan="6">
        <img src="http://images.d1.com.cn/magazine/women/FEB_23.jpg" width="469" height="167" alt=""></td>
	    <td colspan="3" rowspan="2">
		    <img src="http://images.d1.com.cn/magazine/women/FEB_24.jpg" alt="" width="300" height="528" border="0" usemap="#Map7"></td>
    </tr>
    <tr>
      <td colspan="6">
        <img src="http://images.d1.com.cn/magazine/women/FEB_25.jpg" alt="" width="469" height="361" border="0" usemap="#Map6"></td>
    </tr>
    <tr>
      <td colspan="9">
        <img src="http://images.d1.com.cn/magazine/women/FEB_26.jpg" alt="" width="769" height="412" border="0" usemap="#Map8"></td>
    </tr>
    <tr>
      <td colspan="3">
        <img src="http://images.d1.com.cn/magazine/women/FEB_27.jpg" width="264" height="298" alt=""></td>
	    <td colspan="5">
		    <a href="http://www.d1.com.cn/product/01718762" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_28.jpg" alt="" width="246" height="298" border="0"></a></td>
	    <td>
		    <a href="http://www.d1.com.cn/product/01718241" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_29.jpg" alt="" width="259" height="298" border="0"></a></td>
    </tr>
    <tr>
      <td colspan="2">
        <a href="http://www.d1.com.cn/product/01718185" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_30.jpg" alt="" width="263" height="326" border="0"></a></td>
	    <td colspan="6">
		    <a href="http://www.d1.com.cn/product/01718227" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_31.jpg" alt="" width="247" height="326" border="0"></a></td>
	    <td>
		    <a href="http://www.d1.com.cn/product/01719464" target="_blank"><img src="http://images.d1.com.cn/magazine/women/FEB_32.jpg" alt="" width="259" height="326" border="0"></a></td>
    </tr>
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="258" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="5" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="11" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="156" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="38" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="37" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="4" height="1" alt=""></td>
	    <td>
		    <img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="259" height="1" alt=""></td>
	  </tr>
  </table>
  <!-- End ImageReady Slices -->
</div>
 
<map name="Map"><area shape="rect" coords="75,163,358,434" href="http://www.d1.com.cn/product/01720154" target="_blank">
</map>
<map name="Map2">
  <area shape="rect" coords="366,23,551,493" href="http://www.d1.com.cn/product/01720155" target="_blank">
<area shape="rect" coords="563,25,737,501" href="http://www.d1.com.cn/product/01720154" target="_blank">
<area shape="rect" coords="65,302,222,575" href="http://www.d1.com.cn/product/01720154" target="_blank">
<area shape="rect" coords="236,296,362,573" href="http://www.d1.com.cn/product/01720155" target="_blank">
</map>
<map name="Map3"><area shape="rect" coords="21,11,229,378" href="http://www.d1.com.cn/product/01720153" target="_blank"><area shape="rect" coords="242,10,400,384" href="http://www.d1.com.cn/product/01720152" target="_blank">
<area shape="rect" coords="419,312,578,535" href="http://www.d1.com.cn/product/01720152" target="_blank">
<area shape="rect" coords="583,312,756,538" href="http://www.d1.com.cn/product/01720153" target="_blank">
</map>
<map name="Map4">
<area shape="rect" coords="42,105,234,333" href="http://www.d1.com.cn/product/01715138" target="_blank">
<area shape="rect" coords="243,106,419,335" href="http://www.d1.com.cn/product/01715137" target="_blank">
</map>
<map name="Map5"><area shape="rect" coords="12,43,205,267" href="http://www.d1.com.cn/product/01718042" target="_blank">
<area shape="rect" coords="207,158,408,357" href="http://www.d1.com.cn/product/01718045" target="_blank">
<area shape="rect" coords="416,147,592,340" href="http://www.d1.com.cn/product/01718044" target="_blank">
<area shape="rect" coords="595,21,760,242" href="http://www.d1.com.cn/product/01718043" target="_blank">
</map>
<map name="Map6"><area shape="rect" coords="37,95,234,296" href="http://www.d1.com.cn/product/01719849" target="_blank"><area shape="rect" coords="251,92,459,298" href="http://www.d1.com.cn/product/01719848" target="_blank">
</map>
<map name="Map7">
<area shape="poly" coords="12,102,47,44,94,36,148,40,188,63,201,103,200,125,165,145,158,160,140,169,128,190,109,220,95,249,87,262,56,269" href="http://www.d1.com.cn/product/01719199" target="_blank">
<area shape="poly" coords="105,250,146,186,174,161,221,143,249,153,273,166,297,208,284,292,262,373,174,384" href="http://www.d1.com.cn/product/01719198" target="_blank">
</map>
<map name="Map8"><area shape="rect" coords="87,106,270,338" href="http://www.d1.com.cn/product/01719499" target="_blank"><area shape="rect" coords="287,169,434,403" href="http://www.d1.com.cn/product/01719498" target="_blank"><area shape="rect" coords="466,105,642,330" href="http://www.d1.com.cn/product/01717878" target="_blank">
</map>

                  
               
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