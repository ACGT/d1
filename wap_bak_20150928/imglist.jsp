<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%

String act=request.getParameter("act");
if("post".equals(request.getMethod().toLowerCase())&&"search1".equals(act))
{
	String keyword=request.getParameter("search");
	if(keyword!=null&&keyword.length()>0)
	{
		response.sendRedirect("/wap/search.jsp?headsearchkey="+URLEncoder.encode(keyword,"utf-8"));
	}
}
String id="";
if(request.getParameter("productid")!=null&&request.getParameter("productid").length()>0)
{
 id= request.getParameter("productid");
}

Product p = ProductHelper.getById(id);
if(p == null){
	out.print("<br/>商品不存在！");
	return;
}
   String infos="";
   long discountendDate = Tools.dateValue(p.getGdsmst_discountenddate());//应该是秒杀结束的时间。
	float saleprice = Tools.floatValue(p.getGdsmst_saleprice());//市场价
	float memberprice = Tools.floatValue(p.getGdsmst_memberprice());//会员价

	float oldmemberprice = Tools.floatValue(p.getGdsmst_oldmemberprice());//旧的会员价
	long currentTime = System.currentTimeMillis();
	float hyprice = 0;
	boolean ismiaosha=false;

	if(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS && Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0){
		ismiaosha = true;
		hyprice = oldmemberprice;
	}else{
		hyprice = memberprice;
	}
    		if(p.getGdsmst_imgurl()!=null&&p.getGdsmst_imgurl().length()>0)
    		{
    			String theimgurl=p.getGdsmst_imgurl();
   			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
   				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
   					}else{
   						theimgurl = "http://images.d1.com.cn"+theimgurl;
   					}
    			infos="<a href=\"/wap/goods.jsp?productid="+id+"\"><img src=\""+theimgurl+"\"/></a>";
    			
    		}
    		else
    		{
    			infos="图片不存在！";
    		}

%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-图片展示</title>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;color:#4b4b4b; padding-bottom:15px; line-height:21px;  padding-left:5px;}
ul{list-style:none; padding:0px;}
img{ border:none;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}

.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
</style>
</head>
<body style="padding-left:5px;">
<!-- 头部 -->
<%@ include file="/wap/inc/head.jsp" %>
<!-- 头部结束 -->
<br/>
 <table>
     <tr><td style="background:#f00; color:#fff;">&nbsp;<a href="/wap/goods.jsp?productid=<%= id %>"  style="color:#fff;"><b>简介</b></a>&nbsp;|&nbsp;<a href="/wap/imglist.jsp?productid=<%=id %>" style="color:#fff;"><b>图片</b></a>&nbsp;|&nbsp;
     <a href="/wap/goodsdetail.jsp?productid=<%= id %>" style="color:#fff;"><b>详情</b></a>&nbsp;|&nbsp;<a href="/wap/comment/commentlist.jsp?productid=<%= id%>" style="color:#fff;"><b>评论(<%=CommentHelper.getCommentLength(id)%>)</b></a>&nbsp;</td></tr>
     <tr><td>&nbsp;<b><%= p.getGdsmst_gdsname() %></b></td></tr>
     <tr><td>&nbsp;商品编号：<%= p.getId() %></td></tr>
    
     <tr><td>&nbsp;商品品牌：<%= p.getGdsmst_brandname() %></td></tr>
     <% if(ismiaosha)
    	 {
    	 out.print("<tr><td>&nbsp;<b>秒杀价：￥"+memberprice+"</b></td></tr>");
    	 out.print("<tr><td>&nbsp;会员价：￥"+oldmemberprice+"</td></tr>");
    	 }
    	 else
    	 {
    		 out.print("<tr><td>&nbsp;<b>会员价：￥"+memberprice+"</b></td></tr>");
    	 }%>
     <tr><td>&nbsp;市场价：<%= saleprice %></td></tr>
     <tr><td><%= infos %></td></tr>
						<%
                                        ///sku
                                         List<Sku> skuList=new ArrayList<Sku>();
									    if(!Tools.isNull(p.getGdsmst_skuname1())){
									    	skuList= SkuHelper.getSkuListViaProductId(id);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><tr><td><br/>&nbsp;我要购买(<%=p.getGdsmst_skuname1() %>)：<%
										    	out.print("<span id=\"sku\">");
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			
										    			String skuname = sku.getSkumst_sku1();
										    			if(p.getGdsmst_stocklinkty()!=null&&(p.getGdsmst_stocklinkty().longValue()==1||p.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(p.getId(), sku.getId())<ProductHelper.getVirtualStock(p.getId(), sku.getId())){
											    				%><a href="/wap/goodsend.jsp?gdsid=<%= id %>&skuId=<%= sku.getId() %>"  hidefocus="true" class="old"><%=skuname %></a>
											    				<%
										    				}
										    			}else{
										    			%><a href="/wap/goodsend.jsp?gdsid=<%= id %>&skuId=<%= sku.getId() %>" hidefocus="true" class="old"><span><%=skuname %></span></a><%
										    			}
										    		
										    		}
										    		out.print("</span>");
										    %>
										    </td></tr>
										    <%		
										    }
									    }%>
									    <tr><td>
									    <%
									       if(skuList==null||skuList.size()==0)
									       {%>
									    	   &nbsp;<a href="/wap/goodsend.jsp?gdsid=<%= id %>" >购买</a>
     
									       <%}
									    %>
									   
									     <% if(p.getGdsmst_ifhavegds().longValue() == 0){
		if(p.getGdsmst_validflag().longValue() == 1){
			if(ProductStockHelper.canBuy(p)){
				
				out.print("&nbsp;<a href=\"f_succ.jsp?id="+id+"\" );\">收藏</a>");
			}
		}
	}
	%>
	 </td></tr>
    
	
	 <tr><td style="background:#f00; color:#fff;">&nbsp;<a href="/wap/goods.jsp?productid=<%= id %>"  style="color:#fff;"><b>简介</b></a>&nbsp;|&nbsp;<a href="/wap/imglist.jsp?productid=<%=id %>" style="color:#fff;"><b>图片</b></a>&nbsp;|&nbsp;
     <a href="/wap/goodsdetail.jsp?productid=<%= id %>" style="color:#fff;"><b>详情</b></a>&nbsp;|&nbsp;<a href="/wap/comment/commentlist.jsp?productid=<%= id%>" style="color:#fff;"><b>评论(<%=CommentHelper.getCommentLength(id)%>)</b></a>&nbsp;</td></tr>
    
   </table>

    <div style="background:#a52a2a; padding:2px; margin-top:2px;">
	     <form id="search_1" method="post" action="imglist.jsp?act=search1">
	      <input id="search" name="search"/>
	      <input type="submit" value="搜商品 " class="search"/>
	      </form>
	      </div><br/>
      <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/wap/user/index.jsp">我的优尚</a>&nbsp;&nbsp;
<a href="">购物车</a>&nbsp;&nbsp;<a href="/wap/user/favorite.jsp">我的收藏</a><br/>
<a href="mindex.jsp">首页</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a><br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号

    <br/>
    </div>
</body>
</html>