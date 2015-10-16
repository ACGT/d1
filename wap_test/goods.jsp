<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%!
//获取商品规格
private static String getGGInfo(Product product){
	if(product == null) return "";
	ProductStandard stand = ProductStandardHelper.getById(product.getGdsmst_stdid());
	if(stand == null) return "";
	StringBuilder sb = new StringBuilder();
	
	int count = 0;
	long[] showflag = new long[]{Tools.longValue(stand.getStdmst_showflag1()),Tools.longValue(stand.getStdmst_showflag2()),Tools.longValue(stand.getStdmst_showflag3()),Tools.longValue(stand.getStdmst_showflag4()),Tools.longValue(stand.getStdmst_showflag5()),Tools.longValue(stand.getStdmst_showflag6()),Tools.longValue(stand.getStdmst_showflag7()),Tools.longValue(stand.getStdmst_showflag8())};
	String[] atrname = new String[]{stand.getStdmst_atrname1(),stand.getStdmst_atrname2(),stand.getStdmst_atrname3(),stand.getStdmst_atrname4(),stand.getStdmst_atrname5(),stand.getStdmst_atrname6(),stand.getStdmst_atrname7(),stand.getStdmst_atrname8()};
	String[] stdvalue = new String[]{product.getGdsmst_stdvalue1(),product.getGdsmst_stdvalue2(),product.getGdsmst_stdvalue3(),product.getGdsmst_stdvalue4(),product.getGdsmst_stdvalue5(),product.getGdsmst_stdvalue6(),product.getGdsmst_stdvalue7(),product.getGdsmst_stdvalue8()};
	for(int i=0;i<showflag.length;i++){
		if(showflag[i] >0 && !Tools.isNull(stdvalue[i])){
			count++;
			    sb.append("&nbsp;");
				sb.append(Tools.trim(atrname[i])).append("：").append(stdvalue[i]);
				if(count!=showflag.length)
				{
					sb.append("<br/>");
				}
		
		}
	}
	if (count % 2 != 0){
		sb.append("<td></td></tr>");
	}
	
	return sb.toString();
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-商品详细</title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
	margin-left: 5px;
	width: 100%;
}

table {
	border-collapse: collapse;
}

fieldset, img {
	border: none;
}

address, caption, cite, code, dfn, th, var, em {
	font-weight: normal;
}

ol, ul {
	list-style: none;
	padding: 0px;
}

caption, th {
	text-align: left;
}

h1, h2, h3, h4, h5, h6 {
	font-size: 100%;
}

input, select, button {
	vertical-align: middle;
	font-size: 12px;
}

em {
	font-style: normal;
}

img {
	display: inline-block;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

.top {
	margin-top: 3px;
}

.top ul li {
	float: left;
	border-bottom: solid 1px #000;
}

.top ul li a {
	color: #000;
}

.top ul li a:hover {
	color: #aa2e44;
}

#search {
	width: 120px;
	height: 19px;
	float: left
}

#search1 {
	width: 120px;
	height: 19px;
	float: left
}

table tr td {
	padding-top: 2px;
	padding-bottom: 2px;
	line-height: 20px;
}

.rmfl span {
	display: block;
	width: 70px;
	margin-left: 3px;
	float: left;
	color: #aa2e44;
}

.rmfl li {
	float: left;
}

.keyword {
	background: #ffa07a;
	color: #f00;
}

.keyword a {
	color: #000;
}

.keyword a:hover {
	color: #aa2e44;
}

.tip_box {
	height: auto;
	line-height: 28px;
	border: 1px solid #ffe2a6;
	background-color: #fffadc;
	color: #ffa00e;
	text-align: center;
	margin-bottom: 15px;
}

.sa0, .sa1, .sa2, .sa3, .sa4, .sa5, .sa6, .sa7, .sa8, .sa9, .sa10 {
	width: 100px;
	height: 18px;
	background-image:
		url(http://images.d1.com.cn/images2011/commentimg/star.gif);
	background-repeat: no-repeat;
	overflow: hidden;
}

.sa0 {
	background-position: 0px 0px;
}

.sa1 {
	background-position: 0px -119px;
} /*半颗*/
.sa2 {
	background-position: 0px -21px;
}

.sa3 {
	background-position: 0px -139px;
}

.sa4 {
	background-position: 0px -40px;
}

.sa5 {
	background-position: 0px -160px;
}

.sa6 {
	background-position: 0px -58px;
}

.sa7 {
	background-position: 0px -182px;
}

.sa8 {
	background-position: 0px -77px;
}

.sa9 {
	background-position: 0 -204px;
}

.sa10 {
	background-position: 0px -97px;
}

.old {
	border: solid 1px #ccc;
	padding: 2px;
}

.current {
	border: solid 2px #f00;
	padding: 2px;
}
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="inc/head.jsp"%>
	<!-- 头部结束 -->
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

Product product = ProductHelper.getById(id);
if(product == null){
	out.print("<br/>商品不存在！");
	return;
}

String rackCode = product.getGdsmst_rackcode();
String category = "";//最小的类别，在下面初始化了。
String brandName = product.getGdsmst_brandname();//品牌
String gdsname=product.getGdsmst_gdsname();//名称
String skuname1=product.getGdsmst_skuname1();
//评论
int contentcount = CommentHelper.getCommentLength(id);
//显示星级
int score = CommentHelper.getLevelView(id);
long discountendDate = Tools.dateValue(product.getGdsmst_discountenddate());//应该是秒杀结束的时间。
float saleprice = Tools.floatValue(product.getGdsmst_saleprice());//市场价
float memberprice = Tools.floatValue(product.getGdsmst_memberprice());//会员价

float oldmemberprice = Tools.floatValue(product.getGdsmst_oldmemberprice());//旧的会员价
long currentTime = System.currentTimeMillis();
float hyprice = 0;
boolean ismiaosha=false;
boolean	msflag= CartHelper.getmsflag(product);

   
 
	hyprice = memberprice;
 


%>
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>
			<%
			if(!Tools.isNull(rackCode)){
				int size = rackCode.length();
				if(size >= 3){
					for (int i = 3; i <= size; i = i + 3){
						Directory directory = DirectoryHelper.getById(rackCode.substring(0,i));
						if(directory == null) continue;
						category = directory.getRakmst_rackname();
						if(i==3){
							%>><a
				href="/wap/resultlist.jsp?productsort=<%=directory.getId() %>"><%=category %></a>
			<%
						}else{
							%>><a
				href="/wap/resultlist.jsp?productsort=<%=directory.getId() %>"><%=category %></a>
			<%
						}
					}
				}
			}
			%>
			<br />
		</div>
		<div style="background: #f00; color: #fff;">
			&nbsp;<a href="/wap/goods.jsp?productid=<%= id %>"
				style="color: #fff;"><b>简介</b></a>&nbsp;|&nbsp;<a
				href="/wap/imglist.jsp?productid=<%=id %>" style="color: #fff;"><b>图片</b></a>&nbsp;|&nbsp;
			<a href="/wap/goodsdetail.jsp?productid=<%= id %>"
				style="color: #fff;"><b>详情</b></a>&nbsp;|&nbsp;<a
				href="/wap/comment/commentlist.jsp?productid=<%= id%>"
				style="color: #fff;"><b>评论(<%=CommentHelper.getCommentLength(id)%>)
			</b></a>&nbsp;
		</div>
		<table>

			<tr>
				<td>&nbsp;<b><%= product.getGdsmst_gdsname() %>
						<%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
      					%> &nbsp;<span style="color: red;">该商品不能使用优惠券</span> <%}%></b></td>
			</tr>
			<tr>
				<td>&nbsp;<img
					src="<% 
    		 String theimgurl="";
	 
     if(product.getGdsmst_recimg()!=null) {
    		  theimgurl=product.getGdsmst_recimg();

    	 } else{
    		 theimgurl=product.getGdsmst_otherimg3();
    		 }
    	 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
			 theimgurl = "http://images1.d1.com.cn"+theimgurl;
				}else{
					theimgurl = "http://images.d1.com.cn"+theimgurl;
				}
    	 out.print(theimgurl);
    		 %>"
					width="160" height="160" /></td>
			</tr>

			<tr>
				<td>&nbsp;商品编号：<%= product.getId() %></td>
			</tr>
			<% if(msflag){
    	 float sprice=Tools.floatValue(product.getGdsmst_msprice());
    	  
    	 out.print("<tr><td>&nbsp;<b>秒杀价：￥"+sprice+"</b></td></tr>");
    	 out.print("<tr><td>&nbsp;会员价：￥"+memberprice+"</td></tr>");
    	 }
    	 else
    	 {
    		 out.print("<tr><td>&nbsp;<b>会员价：￥"+memberprice+"</b></td></tr>");
    	 }%>
			<tr>
				<td>&nbsp;市场价：<%= saleprice %></td>
			</tr>

			<tr>
				<td style="border-bottom: solid 1px #333;"><span
					style="float: left;">&nbsp;顾客评分：</span><span class="sa<%=score %>"
					style="float: left;"></span></td>
			</tr>
			<tr>
				<td>&nbsp;<b>基本信息：</b></td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #333;">
					<%
					       if(!Tools.isNull(product.getGdsmst_stdvalue1())||!Tools.isNull(product.getGdsmst_stdvalue2())||!Tools.isNull(product.getGdsmst_stdvalue3())||!Tools.isNull(product.getGdsmst_stdvalue4())||!Tools.isNull(product.getGdsmst_stdvalue5())
					    		   ||!Tools.isNull(product.getGdsmst_stdvalue6())||!Tools.isNull(product.getGdsmst_stdvalue7())||!Tools.isNull(product.getGdsmst_stdvalue8())){
					    %> <%=getGGInfo(product) %> <%} %>
				</td>
			</tr>
			<%
                                        ///sku
                                         List<Sku> skuList=new ArrayList<Sku>();
									    if(!Tools.isNull(skuname1)){
									    	skuList= SkuHelper.getSkuListViaProductId(id);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><tr>
				<td><br />&nbsp;我要购买(<%=skuname1 %>)：<%
										    	out.print("<span id=\"sku\">");
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><a
					href="/wap/goodsend.jsp?gdsid=<%= id %>&skuId=<%= sku.getId() %>"
					hidefocus="true" class="old"><%=skuname %></a> <%
										    				}
										    			}else{
										    			%><a
					href="/wap/goodsend.jsp?gdsid=<%= id %>&skuId=<%= sku.getId() %>"
					hidefocus="true" class="old"><span><%=skuname %></span></a>
					<%
										    			}
										    		
										    		}
										    		out.print("</span>");
										    %></td>
			</tr>
			<%		
										    }
									    }%>
			<tr>
				<td>
					<%
									       if(skuList==null||skuList.size()==0)
									       {%> &nbsp;<a href="/wap/goodsend.jsp?gdsid=<%= id %>"
					style="background: #f00; color: #fff; display: block; padding: 3px; width: 40px; text-align: center;">购买</a>

					<%}
									    %> <% if(product.getGdsmst_ifhavegds().longValue() == 0){
		if(product.getGdsmst_validflag().longValue() == 1){
			if(ProductStockHelper.canBuy(product)){
				
				out.print("&nbsp;<a href=\"/wap/f_succ.jsp?id="+id+"\" );\">收藏</a>");
			}
		}
	}
	%>
				</td>
			</tr>



		</table>
		<div style="background: #f00; color: #fff;">
			&nbsp;<a href="/wap/goods.jsp?productid=<%= id %>"
				style="color: #fff;"><b>简介</b></a>&nbsp;|&nbsp;<a
				href="/wap/imglist.jsp?productid=<%=id %>" style="color: #fff;"><b>图片</b></a>&nbsp;|&nbsp;
			<a href="/wap/goodsdetail.jsp?productid=<%= id %>"
				style="color: #fff;"><b>详情</b></a>&nbsp;|&nbsp;<a
				href="/wap/comment/commentlist.jsp?productid=<%= id%>"
				style="color: #fff;"><b>评论(<%=CommentHelper.getCommentLength(id)%>)
			</b></a>&nbsp;
		</div>
		<div style="background: #a52a2a; padding: 2px; margin-top: 2px;">
			<form id="search_1" method="post"
				action="goodsdetail.jsp?act=search1">
				<input id="search" name="search" />
				<input type="submit" value="搜商品 " />

			</form>
		</div>
		<br />
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/wap/user/index.jsp">我的优尚</a>&nbsp;&nbsp; <a
				href="/wap/flow.jsp">购物车</a>&nbsp;&nbsp;<a
				href="/wap/user/favorite.jsp">我的收藏</a><br /> <a href="/mindex.jsp">首页</a>&nbsp;&nbsp;<a
				href="/wap/html/help.jsp">帮助</a> <br /> 切换到<a
				href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号 <br />
		</div>



	</div>




</body>
</html>

