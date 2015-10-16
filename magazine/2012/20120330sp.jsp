<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>海洋之星华丽归来</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012MAR 第三期--海洋之星华丽归来</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
             <!-- ImageReady Slices (2012TaiTan.psd) -->
  <table id="__01" width="769" height="2288" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_01.jpg" width="769" height="284" alt=""></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01517012" target="_blank"><img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_02.jpg" alt="" width="769" height="338" border="0"></a></td>
	  </tr>
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_03.jpg" width="769" height="260" alt=""></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01517012" target="_blank"><img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_04.jpg" alt="" width="769" height="285" border="0"></a></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01517013" target="_blank"><img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_05.jpg" alt="" width="769" height="161" border="0"></a></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01517012" target="_blank"><img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_06.jpg" alt="" width="769" height="274" border="0"></a></td>
	  </tr>
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_07.jpg" width="769" height="251" alt=""></td>
	  </tr>
    <tr>
      <td>
        <a href="http://www.d1.com.cn/product/01517013" target="_blank"><img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_08.jpg" alt="" width="769" height="209" border="0"></a></td>
	  </tr>
    <tr>
      <td>
        <img src="http://images.d1.com.cn/magazine/shipin//2012TaiTan_09.jpg" width="769" height="226" alt=""></td>
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