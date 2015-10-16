<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-热销排行</title>
<meta name="description" content=""/>
<meta name="keywords" content=""/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index.css")%>" rel="stylesheet" type="text/css" media="screen" />
<SCRIPT language="javascript">
  function changbeijing(code)
	{
	  if (code='014001')
	  {
	     document.getElementById("hufu").style.backgroundImage='url(http://images.d1.com.cn/xinpin/fn.gif)';
		 }
	}
	
</SCRIPT>
<style>
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
.center {
	width: 980px; margin:0px auto;
}
.center_top {
	line-height: 30px;
	text-align: right;
	height: 30px;
	width: 950px;
	color: #000000;
	padding-right: 30px;
}
a:active {
	text-decoration: none;
}
#nav li{
	text-align:center;
	font-size:12px;
	background-image: url(http://images.d1.com.cn/xinpin/fenge.gif);
	background-repeat: no-repeat;
	background-position: right center;
}
#nav_head {
	background-image: url(http://images.d1.com.cn/xsph/top.jpg);
	background-repeat: no-repeat;
	width: 980px;
	height: 166px;
}
/*New Nav Style*/
#nav_wrap { width:980px; overflow:hidden; }
#nav{
	height:39px;
	position:relative;
	width:980px;
	background-image: url(http://images.d1.com.cn/xinpin/bjc.gif);
	background-repeat: repeat-x;
	margin-top: 0;
	margin-right: auto;
	margin-bottom: 0;
	margin-left: auto;
}
#nav .l{
	height:33px;
	width:2px;
	float:left;
	background-color: #bfbfbf;
	background-repeat: no-repeat;
}
#nav .r{
	height:33px;
	width:2px;
	float:right;
	background-color: #bfbfbf;
}
#nav .bt_qnav { float:right; }	
#nav .bt_qnav a{ width:31px; height:29px; line-height:39px;display:block;padding:9px 2px 0 0;}
#nav .c{ float:left;margin:0;padding:0}

#nav li { float:left; list-style:none; }
#nav li .v a{
	width:65px;
	height:33px;
	display:block;
	color:#000000;
	float:left;
	font-family:"宋体";
	font-size: 14px;
	line-height: 33px;
}
#nav li .x a{
	width:195px;
	height:33px;
	display:block;
	color:#000000;
	float:left;
	font-family:"宋体";
	font-size: 14px;
	line-height: 33px;
	background-repeat: no-repeat;
	background-position: center bottom;
}
#nav li .v a:hover,#nav li .v .sele{
	color:#116406;
	line-height:33px;
	font-size:14px;
	background-image: url(http://images.d1.com.cn/xinpin/fn.gif);
	background-repeat: no-repeat;
	background-position: center bottom;
	height: 39px;
	width: 65px;
}
/*分页样式*/
.Pager{overflow:hidden;_zoom:1;color: #4B4B4B;text-align:center;}
.Pager .span{margin-right:30px;}
.Pager .rd{color:#CC0000;}
.Pager a{font-size:12px;text-decoration: none;color: #8B8B8B;line-height: 28px;padding: 3px 8px 3px 8px;border: 1px solid #A4A4A4;background-image: url(http://images.d1.com.cn/images2010/pgbg.gif);margin:0 5px;}
.Pager a:hover{color:#AA2E44;}
.Pager .curr{font-size: 12px;text-decoration: none;color: #8B8B8B;line-height: 28px;padding: 3px 8px 3px 8px;border: 1px solid #A4A4A4;background-color: #CDCDCD;}

</style>
</head>
<body>
<div id="wrapper">
	<!-- 头部开始 -->
	<%@include file="/inc/head.jsp"%>
	<!-- 头部结束 -->
	<!-- 中间内容 -->
	
	<%  String rackcode=""; 
	    if(request.getParameter("productsort")!=null&&request.getParameter("productsort").length()>0)
	    {
	    	rackcode=request.getParameter("productsort");
	    }
	    
	    ArrayList<Product> lall=new ArrayList<Product>();//商品集合
	    
	    String[] rackcodes=new String[10];
	    if(rackcode.length()>0)
	    {
			    if(rackcode.indexOf(",")>0)
		 	    {
		 		   rackcodes=rackcode.split(",");
		 		   for(int i=0;i<rackcodes.length;i++)
		 		   {
		 			   if(rackcodes[i]!=null&&rackcodes[i].length()>0)
		 			   {
		 		   			ArrayList<Product> sublist=ProductHelper.getProductListByRCodeOrdercount(rackcodes[i], 100/rackcodes.length);
		 		   			if(sublist!=null&&sublist.size()>0)
		 		   			{
		 		   				lall.addAll(sublist);
		 		   			}
		 			   }
		 		   }
		 	   }
		 	   else
		 	   {
		 		    		  
		 		   lall=ProductHelper.getProductListByRCodeOrdercount(rackcode, 100);
		 		   
		 	   }
	    }
	    else
	    {
	    	lall=ProductHelper.getProductListByRCodeOrdercount(rackcode, 500);
	    }
	    
	   // if(lall!=null)
	      //  Collections.sort(lall,new com.d1.comp.SalesComparator());

	        String ggURL = Tools.addOrUpdateParameter(request,null,null);
	        if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
	       //翻页
	         int totalLength = (lall != null ?lall.size() : 0);
	 		
	 		int PAGE_SIZE = 28 ;
	  	    int currentPage = 1 ;
	  	   String pg ="1";
	  	    if(request.getParameter("pageno")!=null)
	  	    {
	  	    	pg= request.getParameter("pageno");
	  	    }
	  	    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
	  	    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
	  	   
	  	    int end = pBean.getStart()+PAGE_SIZE;
	  	    if(end > totalLength) end = totalLength;
	 		
	 		String pageURL = ggURL.replaceAll("pageno=[^&]*","");
	  	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
	  	    
	
	
	%>
	
	  <div class="center">
	      <DIV id=nav_wrap>
				<div id="nav_head"></div>
				<DIV id=nav>
				<DIV class=l></DIV>
					<UL class=c>
					  <LI ><SPAN class=v ><A href="index.jsp?productsort=014001"  <%if(rackcode=="014001"){%> class="sele" <%}%>  >护肤品</A></SPAN> </LI>
					  <LI><SPAN class=v  ><A href="index.jsp?productsort=014003"  <%if(rackcode=="014003"){%> class="sele" <%}%>>彩妆</A></SPAN> </LI>
					  <LI><SPAN class=v  ><A href="index.jsp?productsort=014002" <%if(rackcode=="014002"){%> class="sele" <%}%>>香水</A></SPAN> </LI>
					  <LI><SPAN class=v ><A href="index.jsp?productsort=017001"  <%if(rackcode=="017001"){%> class="sele" <%}%>>女装</A></SPAN> </LI>
					  <LI><SPAN class=v ><A href="index.jsp?productsort=017007"  <%if(rackcode=="017007"){%> class="sele" <%}%>>女鞋</A></SPAN> </LI>
					  <LI><SPAN class=v ><A href="index.jsp?productsort=017005"  <%if(rackcode=="017005"){%> class="sele" <%}%>>女包</A></SPAN> </LI>
					  <LI><SPAN class=v  ><A href="index.jsp?productsort=015009,015002014"<% if(rackcode=="015009"||rackcode=="015002014"){%> class="sele" <%}%>>饰品</A></SPAN> </LI>
					  <LI><SPAN class=v  ><A href="index.jsp?productsort=017002 "<%if(rackcode=="017002") {%> class="sele" <%}%>>男装</A></SPAN> </LI>
					  <LI><SPAN class=v ><A href="index.jsp?productsort=015002004"  <%if(rackcode=="0115002004"){%> class="sele" <%}%>>手表</A></SPAN> </LI>
					  <LI><SPAN class=v ><A href="index.jsp?productsort=017002011" <%if(rackcode=="017002011"){%> class="sele" <%}%>>皮具</A></SPAN> </LI>
					  <LI><SPAN class=v  ><A href="index.jsp?productsort=015002003" <%if(rackcode=="015002003"){%> class="sele" <%}%>>zippo</A></SPAN> </LI>
					  <LI><SPAN class=v  ><A href="index.jsp?productsort=014001018" <%if(rackcode=="014001018"){%> class="sele" <%}%>>男士护肤</A></SPAN> </LI>
					  <LI><span class=x ><a href="index.jsp"><img src="http://images.d1.com.cn/xsph/all.jpg" border="0" /></a></span></LI>
					  </UL>
				<DIV class=r></DIV>
				</DIV><!--nav-->
			</DIV><!--nav_wrap-->
			<!-- 商品列表 -->
			
			<div class="center_top">共有<span style="color:#F85F00;" id=gdssum><%= lall.size() %></span>件商品</div>
			 <% if(lall!=null&&lall.size()>0)
	           {
	        	    int num=0;
	        	    int Page=1;
	        	    if(request.getParameter("pageno")!=null)
	        	    {
	        	    	Page=Tools.parseInt(request.getParameter("pageno"));
	        	    }
	        	    for(int i=((Page-1)*28);i<Page*28&&i<lall.size();i++)
	        	    {
	        	    	Product p=lall.get(i);
	        	    //}
	        	    //for(Product p:lall)
	        	    //{
	        	    	if(p==null)
	        	    	{
	        	    		continue;
	        	    	}
	        	    	num++;
	        	    	String gdsid=p.getId();
		    			String imgurl=p.getGdsmst_imgurl();	
		    			if(num%4==1)
		    			{%>
		    				   <div style="margin:0px auto; width:980px;overflow:hidden;">
		    			<%}
		    			if(num==lall.size()+1)
		    			{%>
		    				</div>
		    			<%}
	        	    	if(num%4==0)
	        	    	{
                        %>
                              <div style=" width:204px; overflow:hidden; float:left;margin-right:0px;">
							     <div style="text-align:center; width:202px; border:solid 1px #ccc; overflow:hidden; font-size:13px; ">
								 <a href="/product/<%= gdsid %>" target="_blank" title="<% 

StringUtils.replaceHtml(p.getGdsmst_gdsname()); %>">
								 <img src="http://images.d1.com.cn<%= imgurl %>" width="200" height="200"/>
								 </a><br/>
								 <!-- 显示特价图标 -->
								 <% Date d=new Date();
								    if(p.getGdsmst_discountenddate().after(d) && p.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+Tools.DAY_MILLIS*30))&& p.getGdsmst_memberprice()!=p.getGdsmst_oldmemberprice()&&p.getGdsmst_oldmemberprice()!=0)
								    { %>
								 <div style="position:absolute;z-index:999; margin-top:-206px; margin-left:-2px; _margin-top:-224px;  _margin-left:-102px;  +margin-top:-224px; +margin-left:-102px;"><img src="http://images.d1.com.cn/images2010/tejia2.gif" /> </div>	
							 <% } %>
								 
								</div>
								 <div class="content" style="padding-top:2px;">
								  <a href="/product/<%= gdsid %>" target="_blank">【<%= Tools.getFloat(p.getGdsmst_memberprice()/p.getGdsmst_saleprice()*10, 1)  %>折】<%= p.getGdsmst_gdsname() %>  </a><br/>
								 <!-- 是否添加运费 -->
									<% if(p.getGdsmst_addshipfee()>0) 
									{
									%>
									   <a href="http://www.d1.com.cn/help/help.asp?code=0402" target="_blank"><font color="#f00">本商品属于超重商品，运费另计</font></a><br/>
									<% }%>
								 
								 
								    <span style="font-size:18px; font-weight:800; color:red">￥<%= p.getGdsmst_memberprice()%></span>
								    <span style="text-decoration: line-through; padding-left:16px; font-size:14px; color:#4D4D4D">￥<%= p.getGdsmst_saleprice() %></span>
								   <!-- 判断是否是平安用户 -->
								   <% if(Tools.getCookie(request, "PINGAN")=="1"&&Tools.getCookie(request,"rcmdusr_rcmid")=="24")
								      {	
									   ProductExpPriceItem pei=ProductExpPriceHelper.getExpPrice(gdsid, "24");
									        if(pei!=null)
									        {%>									        	

												<font color=#666666>万里通会员价：</font><font color="#ee0000"><%=pei.getRcmdgds_memberprice()  %>元</font><br/>
									        <%}
									        else
									        {%>									        	

												<font color=#666666>万里通会员价：</font><font color="#ee0000"><%= p.getGdsmst_memberprice()  %>元</font><br/>
									        <%}
								      }
								   %> 
								 
								 </div>	
							    </div>
							   </div>
	                    <hr style=" height:10px; background-color:#fff; width:978px;  border:solid 1px #fff; +border:solid 10px #fff; +height:auto; _border:solid 10px #fff; _height:auto;">

                        <%	
	        	    	}
	        	    	else
	        	    	{%>
	        	    		     <div style=" width:204px; overflow:hidden; float:left; 

margin-right:54px;">
							     <div style="text-align:center; width:202px; border:solid 1px #ccc; overflow:hidden; font-size:13px; ">
								 <a href="/product/<%= gdsid %>" target="_blank" title="<% 

StringUtils.replaceHtml(p.getGdsmst_gdsname()); %>">
								 <img src="http://images.d1.com.cn<%= imgurl %>" width="200" height="200"/>
								 </a><br/>
								 <!-- 显示特价图标 -->
								 <% Date d=new Date();
								    if(p.getGdsmst_discountenddate().after(d) && p.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+Tools.DAY_MILLIS*30))&& p.getGdsmst_memberprice()!=p.getGdsmst_oldmemberprice()&&p.getGdsmst_oldmemberprice()!=0)
								    { %>
								 <div style="position:absolute;z-index:999; margin-top:-206px; margin-left:-2px; _margin-top:-224px; _margin-left:-102px; +margin-top:-224px; +margin-left:-102px;"><img src="http://images.d1.com.cn/images2010/tejia2.gif" /> </div>	
								 <% } %>
								 
								</div>
								 <div class="content" style="padding-top:2px;">
								  <a href="/product/<%= gdsid %>" target="_blank">【<%= Tools.getFloat(p.getGdsmst_memberprice()/p.getGdsmst_saleprice()*10, 1)  %>折】<%= p.getGdsmst_gdsname() %>  </a><br/>
								 <!-- 是否添加运费 -->
									<% if(p.getGdsmst_addshipfee()>0) 
									{
									%>
									   <a href="http://www.d1.com.cn/help/help.asp?code=0402" target="_blank"><font color="#f00">本商品属于超重商品，运费另计</font></a><br/>
									<% }%>
								 
								  
								    <span style="font-size:18px; font-weight:800; color:red">￥<%= p.getGdsmst_memberprice()%></span>
								    <span style="text-decoration: line-through; padding-left:16px; font-size:14px; color:#4D4D4D">￥<%= p.getGdsmst_saleprice() %></span>
								   <!-- 判断是否是平安用户 -->
								   <% if(Tools.getCookie(request, "PINGAN")=="1"&&Tools.getCookie(request,"rcmdusr_rcmid")=="24")
								      {	
									   ProductExpPriceItem pei=ProductExpPriceHelper.getExpPrice(gdsid, "24");
									        if(pei!=null)
									        {%>									        	

												<font color=#666666>万里通会员价：</font><font color="#ee0000"><%=pei.getRcmdgds_memberprice()  %>元</font><br/>
									        <%}
									        else
									        {%>									        	

												<font color=#666666>万里通会员价：</font><font color="#ee0000"><%= p.getGdsmst_memberprice()  %>元</font><br/>
									        <%}
								      }
								   %> 
								 
								 </div>	
											

				
							   </div>
	        	    		
	        	    	<%}
	        	    	
	        	    }
	           }	
	        	
	        %>
	     
	     
	     </div>
	     
	    <!-- 分页 -->
	    <%
           if(pBean.getTotalPages()>1){
           %>
           <div class="Pager" style="margin:0px auto; width:980px;overflow:hidden;">
           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<a href="<%=pageURL %>pageno=1">首页</a><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getPreviousPage()%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a>
           </div><%}%>	
			
			
	  
	  </div>
	
	<!-- 中间内容结束 -->
	
	
	<div class="clear"></div>
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp"%>
	<!-- 尾部结束 -->

</div>

</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script> 
<script type="text/javascript" language="javascript"> 
 $(document).ready(function() {
        $("#newgdslist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
    });
</script>