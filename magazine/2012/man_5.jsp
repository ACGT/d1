<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>美国南加州的时尚经典</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012JAN 第五期--美国南加州的时尚经典</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
<table width="769" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/01.jpg" width="769" height="890" border="0" usemap="#Map8" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/02.jpg" width="769" height="1032" border="0" usemap="#Map" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/03.jpg" width="769" height="1032" border="0" usemap="#Map2" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/04.jpg" width="769" height="1032" border="0" usemap="#Map3" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/05.jpg" width="769" height="1032" border="0" usemap="#Map4" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/06.jpg" width="769" height="1032" border="0" usemap="#Map5" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/07.jpg" width="769" height="1032" border="0" usemap="#Map6" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/magazine/man/08.jpg" width="769" height="1032" border="0" usemap="#Map7" /></td>
  </tr>
</table>
 
<map name="Map" id="Map">
  <area shape="rect" coords="69,159,261,628" href="http://www.d1.com.cn/product/01713233" target="_blank" />
  <area shape="rect" coords="262,41,536,596" href="http://www.d1.com.cn/product/01713232" target="_blank" />
  <area shape="rect" coords="536,164,725,592" href="http://www.d1.com.cn/product/01713234" target="_blank" />
</map>
 
<map name="Map2" id="Map2">
  <area shape="rect" coords="13,17,192,489" href="http://www.d1.com.cn/gdsinfo/01719777.asp" target="_blank" />
  <area shape="rect" coords="212,179,284,282" href="http://www.d1.com.cn/gdsinfo/01717867.asp" target="_blank" />
  <area shape="rect" coords="288,178,370,286" href="http://www.d1.com.cn/gdsinfo/01718862.asp" target="_blank" />
  <area shape="rect" coords="208,296,285,386" href="http://www.d1.com.cn/gdsinfo/01718852.asp" target="_blank" />
  <area shape="rect" coords="395,9,649,507" href="http://www.d1.com.cn/product/01719778" target="_blank" />
  <area shape="rect" coords="657,190,743,286" href="http://www.d1.com.cn/gdsinfo/01717867.asp" target="_blank" />
  <area shape="rect" coords="652,295,746,389" href="http://www.d1.com.cn/product/01715924" target="_blank" />
  <area shape="rect" coords="652,393,744,492" href="http://www.d1.com.cn/gdsinfo/01718852.asp" />
  <area shape="rect" coords="30,709,110,799" href="http://www.d1.com.cn/product/01715924" target="_blank" />
  <area shape="rect" coords="30,803,111,898" href="http://www.d1.com.cn/gdsinfo/01718851.asp" target="_blank" />
  <area shape="rect" coords="122,540,369,1030" href="http://www.d1.com.cn/gdsinfo/01719780.asp" target="_blank" />
  <area shape="rect" coords="409,761,495,856" href="http://www.d1.com.cn/gdsinfo/01717867.asp" target="_blank" />
  <area shape="rect" coords="496,760,575,858" href="http://www.d1.com.cn/gdsinfo/01718862.asp" target="_blank" />
  <area shape="rect" coords="409,861,493,962" href="http://www.d1.com.cn/gdsinfo/01718852.asp" target="_blank" />
  <area shape="rect" coords="580,530,754,1025" href="http://www.d1.com.cn/gdsinfo/01719779.asp" target="_blank" />
</map>
 
<map name="Map3" id="Map3">
  <area shape="rect" coords="32,35,240,616" href="http://www.d1.com.cn/gdsinfo/01719283.asp" target="_blank" />
  <area shape="rect" coords="243,37,543,589" href="http://www.d1.com.cn/gdsinfo/01719776.asp" target="_blank" />
  <area shape="rect" coords="548,38,750,590" href="http://www.d1.com.cn/gdsinfo/01719285.asp" target="_blank" />
</map>
 
<map name="Map4" id="Map4">
  <area shape="rect" coords="83,81,319,499" href="http://www.d1.com.cn/product/01713447" target="_blank" />
  <area shape="rect" coords="432,164,739,661" href="http://www.d1.com.cn/product/01719626" target="_blank" />
  <area shape="rect" coords="48,689,157,970" href="http://www.d1.com.cn/product/01719287" target="_blank" />
  <area shape="rect" coords="161,652,295,991" href="http://www.d1.com.cn/product/01719289" target="_blank" />
  <area shape="rect" coords="298,680,410,995" href="http://www.d1.com.cn/product/01719288" target="_blank" />
  <area shape="rect" coords="455,865,530,974" href="http://www.d1.com.cn/product/01719287" target="_blank" />
  <area shape="rect" coords="530,869,603,977" href="http://www.d1.com.cn/product/01719289" target="_blank" />
  <area shape="rect" coords="603,873,680,981" href="http://www.d1.com.cn/product/01719288" target="_blank" />
</map>
 
<map name="Map5" id="Map5">
  <area shape="rect" coords="137,81,402,645" href="http://www.d1.com.cn/product/01718865" target="_blank" />
  <area shape="rect" coords="403,86,669,645" href="http://www.d1.com.cn/product/01718864" target="_blank" />
</map>
 
<map name="Map6" id="Map6">
  <area shape="rect" coords="97,13,346,440" href="http://www.d1.com.cn/product/01719291" target="_blank" />
  <area shape="rect" coords="476,7,757,447" href="http://www.d1.com.cn/product/01718861" target="_blank" />
  <area shape="rect" coords="37,485,240,1017" href="http://www.d1.com.cn/product/01718858" target="_blank" />
  <area shape="rect" coords="266,451,516,1014" href="http://www.d1.com.cn/product/01719296" target="_blank" />
  <area shape="rect" coords="527,470,754,1026" href="http://www.d1.com.cn/product/01719294" target="_blank" />
</map>
 
<map name="Map7" id="Map7">
  <area shape="poly" coords="174,154,240,145,268,160,283,193,294,291,199,304,148,299" href="http://www.d1.com.cn/product/01718255" target="_blank" />
  <area shape="poly" coords="272,104,345,96,370,106,374,118,385,163,396,245,296,253,269,149" href="http://www.d1.com.cn/product/01718257" target="_blank" />
  <area shape="poly" coords="376,46,460,47,492,65,494,123,465,135,443,199,392,193,376,118" href="http://www.d1.com.cn/product/01718259" target="_blank" />
  <area shape="poly" coords="440,282,446,201,469,140,498,127,545,130,560,171,579,277" href="http://www.d1.com.cn/product/01718258" target="_blank" />
  <area shape="poly" coords="553,122,579,63,620,51,652,55,673,83,686,203,569,217" href="http://www.d1.com.cn/product/01718256" target="_blank" />
  <area shape="rect" coords="38,322,176,473" href="http://www.d1.com.cn/product/01718249" target="_blank" />
  <area shape="rect" coords="180,367,318,538" href="http://www.d1.com.cn/product/01718253" target="_blank" />
  <area shape="rect" coords="35,490,179,648" href="http://www.d1.com.cn/product/01718250" target="_blank" />
  <area shape="rect" coords="33,652,188,798" href="http://www.d1.com.cn/product/01718254" target="_blank" />
  <area shape="rect" coords="82,803,221,962" href="http://www.d1.com.cn/product/01718251" target="_blank" />
  <area shape="rect" coords="224,696,468,999" href="http://www.d1.com.cn/product/01718262" target="_blank" />
  <area shape="rect" coords="368,375,541,668" href="http://www.d1.com.cn/product/01718257" target="_blank" />
  <area shape="rect" coords="543,374,731,667" href="http://www.d1.com.cn/product/01718255" target="_blank" />
</map>
 
<map name="Map8" id="Map8">
  <area shape="rect" coords="16,195,520,825" href="http://www.d1.com.cn/gdsinfo/01719779.asp" target="_blank" />
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