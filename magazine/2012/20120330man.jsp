<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>面面俱到 成功男人的魅力所在</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012MAR 第四期--面面俱到 成功男人的魅力所在</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
            <!-- ImageReady Slices (男杂志.psd) -->
<table id="__01" width="769" height="3508" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01715907" target="_blank"><img src="http://images.d1.com.cn/magazine/man//nanzazhi_011.jpg" alt="" width="769" height="163" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01715907" target="_blank"><img src="http://images.d1.com.cn/magazine/man//nanzazhi_021.jpg" alt="" width="769" height="189" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01715907" target="_blank"><img src="http://images.d1.com.cn/magazine/man//nanzazhi_031.jpg" alt="" width="769" height="162" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01715907" target="_blank"><img src="http://images.d1.com.cn/magazine/man//nanzazhi_041.jpg" alt="" width="769" height="124" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01715907" target="_blank"><img src="http://images.d1.com.cn/magazine/man//nanzazhi_051.jpg" alt="" width="769" height="154" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//nanzazhi_061.jpg" alt="" width="769" height="787" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//nanzazhi_071.jpg" alt="" width="769" height="684" border="0" usemap="#Map2"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//nanzazhi_081.jpg" alt="" width="769" height="671" border="0" usemap="#Map3"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man//nanzazhi_091.jpg" alt="" width="769" height="574" border="0" usemap="#Map4"></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
 
<map name="Map">
<area shape="poly" coords="339,248,416,279,524,283,555,175,557,72,524,38,443,22,394,41,351,65" href="http://www.d1.com.cn/product/01720624" target="_blank">
<area shape="poly" coords="592,159,655,211,734,187,759,117,756,70,756,44,720,23,641,24,590,38" href="http://www.d1.com.cn/product/01516147" target="_blank">
<area shape="poly" coords="31,438,96,442,206,425,279,378,277,289,273,237,245,201,191,189,121,176,69,193,37,205" href="http://www.d1.com.cn/product/01720194" target="_blank">
<area shape="poly" coords="27,578,99,583,177,564,225,509,230,476,212,450,163,449,81,458,46,459,15,466" href="http://www.d1.com.cn/product/01719251" target="_blank">
<area shape="poly" coords="183,582,217,603,289,605,386,609,477,599,503,545,468,518,432,499,379,482,330,482,286,483,241,498" href="http://www.d1.com.cn/product/01720203" target="_blank">
<area shape="poly" coords="276,432,312,458,421,478,478,471,498,437,498,399,489,360,462,317,444,296,388,288,348,288,326,288" href="http://www.d1.com.cn/product/01715931" target="_blank">
<area shape="poly" coords="524,495,579,499,623,494,647,474,649,423,639,364,628,331,608,309,568,300,539,303,514,306,505,315" href="http://www.d1.com.cn/product/01720192" target="_blank">
<area shape="poly" coords="659,488" href="#"><area shape="poly" coords="659,495,742,481,756,446,755,372,755,287,735,272,688,283,644,296" href="http://www.d1.com.cn/product/01720191" target="_blank">
</map>
<map name="Map2">
<area shape="poly" coords="22,557,141,543,201,466,220,400,199,362,156,293,135,274,97,274,37,276,8,280" href="http://www.d1.com.cn/product/01720196" target="_blank">
<area shape="poly" coords="140,251,198,327,227,327,272,317,299,299,309,248,304,191,274,157,246,145,223,145,179,166" href="http://www.d1.com.cn/product/01720198" target="_blank">
<area shape="poly" coords="70,124,104,162,155,169,231,121,232,82,207,45,189,33,142,24,114,26" href="#">
<area shape="poly" coords="324,304,388,304,432,278,436,130,438,63,418,37,390,31,359,35,332,39,303,44,291,44" href="http://www.d1.com.cn/product/01718863" target="_blank">
<area shape="poly" coords="203,546,307,551,397,551,426,511,421,443,406,372,377,344,340,325,319,306,292,320,249,344,226,355" href="http://www.d1.com.cn/product/01720199" target="_blank">
<area shape="poly" coords="428,582,517,604,578,599,618,565,625,490,583,475,511,459,462,467" href="http://www.d1.com.cn/product/01720272" target="_blank">
<area shape="poly" coords="628,648,711,654,745,621,758,520,756,460,755,427,724,397,655,389,635,399" href="http://www.d1.com.cn/product/01720200" target="_blank">
<area shape="poly" coords="405,338,431,419,457,435,530,446,570,439,589,408,585,346,578,293,582,256,582,235,551,220,507,222,454,234" href="http://www.d1.com.cn/product/01720188" target="_blank">
<area shape="poly" coords="595,219,607,314,623,360,651,362,714,367,740,356,754,323,760,267,761,202,732,185,669,185" href="#">
</map>
<map name="Map3">
<area shape="poly" coords="634,362,708,373,744,352,758,291,762,197,737,143,703,136,634,150,606,151,598,166" href="http://www.d1.com.cn/product/01710446" target="_blank">
<area shape="poly" coords="410,350,502,384,580,362,610,344,613,306,592,198,578,151,558,138,528,135,485,135,466,147,450,175" href="http://www.d1.com.cn/product/01718724" target="_blank">
<area shape="poly" coords="296,174,334,243,401,245,419,219,453,146,477,121,496,75,460,39,416,35,361,42,321,50" href="http://www.d1.com.cn/product/01720338" target="_blank">
<area shape="poly" coords="136,262,176,295,233,365,268,376,310,357,339,332,341,276,335,262,311,231,281,183,261,170,224,170,168,170,135,189" href="http://www.d1.com.cn/product/01718198" target="_blank">
<area shape="poly" coords="6,515,63,558,147,563,211,536,244,485,242,409,229,374,181,325,136,276,98,276,66,299,30,301" href="http://www.d1.com.cn/product/01718699" target="_blank">
<area shape="poly" coords="260,561,331,569,381,565,428,518,453,470,459,422,456,394,409,371,344,371,314,371,275,392" href="http://www.d1.com.cn/product/01718078" target="_blank">
<area shape="poly" coords="476,480,549,518,599,519,630,500,619,465,611,429,610,409,582,402,543,393,504,399,477,400" href="http://www.d1.com.cn/product/01718907" target="_blank">
<area shape="poly" coords="381,577,378,620,434,644,490,669,538,648,561,614,575,568,552,541,514,519,476,500,452,501" href="http://www.d1.com.cn/product/01720775" target="_blank">
</map>
<map name="Map4">
<area shape="poly" coords="19,407,141,422,190,397,188,304,191,226,187,179,188,134,176,72,160,42,99,40,60,40,27,44,17,44" href="http://www.d1.com.cn/product/01720584" target="_blank">
<area shape="poly" coords="227,282,287,295,296,232,326,191,332,126,317,56,315,30,291,27,247,32,213,32" href="http://www.d1.com.cn/product/01720586" target="_blank">
<area shape="poly" coords="313,324,348,377,458,361,467,329,477,224,464,130,458,71,454,40,422,41,384,47,349,47" href="http://www.d1.com.cn/product/01720585" target="_blank">
<area shape="poly" coords="462,421,480,476,510,480,566,476,596,474,604,411,605,332,597,254,599,214,589,202,544,195,508,207,493,212" href="http://www.d1.com.cn/product/01720587" target="_blank">
<area shape="poly" coords="637,408,640,464,671,486,723,486,741,386,742,283,744,221,741,198,714,198,669,199,616,205" href="http://www.d1.com.cn/product/01715926" target="_blank">
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