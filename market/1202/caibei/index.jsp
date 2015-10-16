<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>绝版特惠</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>
<style>
.seltuth{width:980px;margin-bottom:10px;margin-top:10px;background:#FFFFFF;color:#555555;overflow:hidden;_zoom:1;}
.seltuth .tj{position:relative; width:200px;height:200px;z-index:1;margin:0 auto;}
.seltuth .tj a img{border:#cccccc 1px solid;width:200px;height:200px;}
.seltuth .tj .di{position:absolute;left:138px;top:143px;z-index:999;width:52px;height:32px;border:none; background-image:url(http://images.d1.com.cn/images2012/jbth/newth_2.gif); font-size:20px; color:#FFFFFF; padding-top:25px; padding-left:10px; font-weight:bold;}
.seltuth ul{width:200px;margin:0 auto;}
.seltuth dl{float:left;width:245px;text-align:center}
.seltuth dt{text-align:center;margin-top:2px;margin-bottom:10px}
.seltuth dd {height:94px; overflow:hidden;margin-left:5px;margin-right:5px;color:#555555;}/* 80 */
.seltuth dd { list-style:none}
.seltuth dd li { text-align:center;height: 25px;line-height: 25px}
.seltuth dd li.title{height:36px; height:34px\0; overflow:hidden;line-height: 18px;}
.seltuth dd a{text-decoration:none}
.seltuth dd a:link,.seltu dd a:visited{padding:1px;color:#555555;}
.seltuth dd span.me{font-size:12px; font-weight:bold; color:#f00;	letter-spacing:-1px;text-decoration:none;margin-right:10px;}
.seltuth dd span.sale{font-size: 12px; font-weight:bold;color : #666666; text-decoration:line-through}
</style>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
<!-- ImageReady Slices (5zhe副本.jpg) -->
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td>
		<table id="__01" width="980" height="397" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/caibei/caibei1202_01.jpg" width="980" height="97" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/caibei/caibei1202_02.jpg" width="980" height="99" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/caibei/caibei1202_03.jpg" width="980" height="102" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/caibei/caibei1202_04.jpg" width="980" height="99" alt=""></td>
	</tr>
</table>	
			</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/jbth/5zheth_04.jpg" width="980" height="48" alt="" usemap="#jbthMap"></td>
	</tr>
	<tr>
		<td>
<table width="980"  border="0" cellspacing="1" cellpadding="0"  class="t" >
    <tr><td>   <div class='seltuth'>
                     <% //7439到7445			

                     String id=request.getParameter("id");
                     if(id==null||Tools.isNull(id)){
                    	 id="1";
                     }
                             String code="7439";
         			switch (Tools.parseInt(id)){
          				case 1:
          					code="7439";
         					break;
         				case 2:
         					code="7440";
         					break;
         				case 3:
         					code="7441";
         					break;
         				case 4:
         					code="7442";
         					break;
         				case 5:
         					code="7443";
         					break;
         				case 6:
         					code="7444";
         					break;
         				case 7:
         					code="7445";
         					break;
         				default:
         					code="7439";
         					break;
         			}

                     int pageno1=1;
                     ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,200);
                     ArrayList gdsidlist=new ArrayList();
                     if(list!=null && list.size()>0){
                     	
                     	for(PromotionProduct pProduct:list){
                     		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
                     		
                     	}
                     	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,200);
                    	
                       if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
  					   {
  						   pageno1=Tools.parseInt(request.getParameter("pageno1"));
  					   }
                        for(int i=(pageno1-1)*36;i<productlist.size()&&i<pageno1*36;i++)
                        {
                        	Product goods=productlist.get(i);
                        	ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,goods.getId());
                        	 String theimgurl="";
                			 String imgalt=StringUtils.replaceHtml(goods.getGdsmst_gdsname());
                			 PromotionProduct pProduct=pproductlist.get(0);
                			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
                				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
                			 }else{
                				 theimgurl="http://images.d1.com.cn"+goods.getGdsmst_imgurl();
                			 }
                     %>
       
                    	  
        <%
           	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
        	   String gdsid = goods.getId();
        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
        	   long currentTime = System.currentTimeMillis();
        	%>
           	<dl>
           		<dt>
           			<div class="tj">
           				<a href='<%=ProductHelper.getProductUrl(goods) %>' target='_blank' title="<%=title %>" class="di"><%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></a>
           	
           				<a href='<%=ProductHelper.getProductUrl(goods) %>' target='_blank' title="<%=title %>"><img src='<%=theimgurl %>' alt="<%=title %>" /></a>
           			</div>
           		</dt>
           		<dd><ul>
           			<li class="title"><a href='<%=ProductHelper.getProductUrl(goods) %>' title="<%=title %>" target='_blank'><%=StringUtils.getCnSubstring(title,0,60) %></a></li>
           			<li>
           				<span class="sale">市场价：￥<%=Tools.getFormatMoney(goods.getGdsmst_saleprice()) %></span>
                        <span class="sale">原售价：￥<%=Tools.getFormatMoney(goods.getGdsmst_oldmemberprice()) %></span><br />
                    </li><%
                    if(Tools.longValue(goods.getGdsmst_ifhavegds()) == 0 && ProductStockHelper.canBuy(goods)){
                    %>
                    <li><a href="###" attr="<%=goods.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" /></a></li><%
                    }else{
                    %>
                    <li><a href="###"><img src="/res/images/product/qh.jpg" /></a></li><%
                    } %>
                </ul></dd>
           	</dl><%
           } %>
           </div>
       </td></tr>
   </table>
                    	 
				     <table width="769">
				     <tr><td height="10"></td></tr>
                      <%    if(productlist!=null&&productlist.size()>0)
                      {%>
                    	      
				      <tr><td heihgt="75" style=" text-align:center;">
				      <% 
				       //分页
					    
						String ggURL = Tools.addOrUpdateParameter(request,null,null);
						if(ggURL != null) 
							   {
							    ggURL.replaceAll("pageno1=[0-9]*","");
							     //ggURL.replaceAll("&id=[0-9]*","");
							   }
						//翻页
						int sum=0;
						if(productlist!=null&&productlist.size()>0)
						{
							for(Product us:productlist)
							{

									sum++;

							}
						}
						 int totalLength1 = sum;
						 	
						  int PAGE_SIZE = 36 ;
						  int currentPage1 = 1 ;
						  String pg1 ="1";
						  if(request.getParameter("pageno1")!=null)
						  {
						  	pg1= request.getParameter("pageno1");
						  }
						  if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
						  PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
						  int end1 = pBean1.getStart()+PAGE_SIZE;
						  if(end1 > totalLength1) end1 = totalLength1;
						  String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
						 // pageURL1 = pageURL1.replaceAll("&id=[^&]*","");
						  if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
					  %>
					  <span class="Pager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1&id=<%=id%>">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int j=pBean1.getStartPage();j<=pBean1.getEndPage()&&j<=pBean1.getTotalPages();j++){
					           		if(j==currentPage1){
					           		%><span class="curr"><%=j %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=j %>"><%=j %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span>
				      </td></tr>
				   
                     <% } }
                      %>
  
				   </table>			

</td>
	</tr>
</table>
<map name="jbthMap">
<area shape="rect" coords="3,2,157,47" href="?id=1"><area shape="rect" coords="158,1,298,46" href="?id=2"><area shape="rect" coords="297,0,432,47" href="?id=3">
<area shape="rect" coords="433,2,568,50" href="?id=4"><area shape="rect" coords="569,2,713,47" href="?id=5"><area shape="rect" coords="714,3,810,47" href="?id=6">
<area shape="rect" coords="810,2,974,57" href="?id=7">
</map>
<!-- End ImageReady Slices -->
</body>
</html>