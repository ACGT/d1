<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>初春型男流行看点</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012FEB 第十一期--初春型男流行看点</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
            <!-- ImageReady Slices (杂志 男.psd) -->
<table id="__01" width="769" height="3842" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man//ypszn_01.jpg" width="769" height="238" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man//ypszn_02-1.jpg" width="769" height="218" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man//ypszn_03.jpg" width="769" height="154" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man//ypszn_04.jpg" width="769" height="185" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man//ypszn_05.jpg" alt="" width="769" height="848" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01720201" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_06.jpg" alt="" width="256" height="424" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01718264" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_07.jpg" alt="" width="257" height="424" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01715924" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_08.jpg" alt="" width="256" height="424" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01713584" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_09.jpg" alt="" width="415" height="210" border="0"></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01720271" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_10.jpg" alt="" width="354" height="210" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man//ypszn_11.jpg" alt="" width="769" height="888" border="0" usemap="#Map2"></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01715171" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_12.jpg" alt="" width="293" height="432" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01715923" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_13.jpg" alt="" width="234" height="432" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01718863" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_14.jpg" alt="" width="242" height="432" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01713583" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_15.jpg" alt="" width="406" height="244" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01720272" target="_blank"><img src="http://images.d1.com.cn/magazine/man//ypszn_16.jpg" alt="" width="363" height="244" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="256" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="37" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="113" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="9" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="98" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//分隔符.gif" width="242" height="1" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
 
<map name="Map">
<area shape="poly" coords="336,262" href="#"><area shape="poly" coords="279,20,374,17,410,36,447,75,445,123,445,143,401,154,362,167,354,186,339,230,333,257,327,281,294,286,249,286,238,263,222,244" href="http://www.d1.com.cn/product/01718855" target="_blank">
<area shape="poly" coords="371,174" href="#"><area shape="poly" coords="404,165,486,166,529,182,531,201,544,239,542,307,539,355,530,373,507,388,462,387,401,390,345,398,337,390,336,361,349,296,350,260,351,236,364,207,370,185,381,173" href="http://www.d1.com.cn/product/01718854" target="_blank">
<area shape="rect" coords="319,409,506,447" href="http://www.d1.com.cn/product/01718855" target="_blank"><area shape="poly" coords="578,216,682,209,721,216,753,254,759,310,759,416,764,454,743,463,659,452,596,455,568,455,545,455" href="http://www.d1.com.cn/product/01718855" target="_blank">
<area shape="rect" coords="572,464,766,766" href="http://www.d1.com.cn/product/01718264" target="_blank"><area shape="rect" coords="295,482,558,779" href="http://www.d1.com.cn/product/01719632" target="_blank"><area shape="rect" coords="19,578,284,843" href="http://www.d1.com.cn/product/01717617" target="_blank"><area shape="rect" coords="16,306,284,560" href="http://www.d1.com.cn/product/01710446" target="_blank">
</map>
<map name="Map2">
<area shape="rect" coords="4,235,226,455" href="http://www.d1.com.cn/product/01720188" target="_blank">
<area shape="rect" coords="10,464,190,868" href="http://www.d1.com.cn/product/01720200" target="_blank"><area shape="poly" coords="205,180,238,233,243,272,258,287,276,293,306,291,325,273,360,261,366,251,417,253,460,259,515,248,516,199,486,148,442,73,382,50,327,33,300,37,263,41,225,50,202,58" href="http://www.d1.com.cn/product/01720187" target="_blank">
<area shape="poly" coords="261,533,308,557,400,552,471,545,510,530,531,429,576,398,612,371,636,365,638,351,629,337,589,332,553,327,511,315,461,284,422,268,401,260,378,264,355,269,328,299,291,322,263,328" href="http://www.d1.com.cn/product/01720336" target="_blank">
<area shape="poly" coords="543,540,589,606,625,644,648,688,681,711,734,714,749,688,751,653,757,601,756,540,755,484,754,453,741,420,674,389,638,388,613,406,580,428,560,444" href="http://www.d1.com.cn/product/01717869" target="_blank">
<area shape="poly" coords="397,622,419,692,431,773,442,837,490,865,588,882,641,843,660,780,644,726,627,672,617,650,579,622,551,592,524,567,493,562,444,574" href="http://www.d1.com.cn/product/01717868" target="_blank">
<area shape="poly" coords="225,601,323,591,358,598,400,661,408,715,415,795,427,843,443,876,357,882,304,867,252,867,213,868,199,866,200,778,208,663" href="http://www.d1.com.cn/product/01720186" target="_blank">
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