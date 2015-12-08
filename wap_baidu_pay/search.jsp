<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%
String backurl = request.getParameter("url");
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}
String act=request.getParameter("act");
if("post".equals(request.getMethod().toLowerCase())&&"search1".equals(act))
{
	String keyword=request.getParameter("search");
	if(keyword!=null&&keyword.length()>0)
	{
		response.sendRedirect("/wap/search.jsp?headsearchkey="+URLEncoder.encode(keyword,"utf-8"));
	}
}


    //一共有几个参数key_wds=搜索词,sort=排序字段,rackcode=分类,pg=当前页,headsearchkey=头部搜索词,asc=升降序
	String keyWords = request.getParameter("key_wds"),rackcode=request.getParameter("rackcode"),
		sort = request.getParameter("sort"),pg = request.getParameter("pg"),asc = request.getParameter("asc");
  // if(keyWords!=null&&keyWords.indexOf("施华洛")>=0){
	//   keyWords="";
  // }
	boolean isAsc = ("true".equals(asc)?true:false) ;
	
	String isAscStr = "";
	if(isAsc)isAscStr="true";
	else isAscStr="false";
			
	String sk = request.getParameter("headsearchkey");
	
	   //if(sk!=null&&sk.indexOf("施华洛")>=0){
		//   sk="";
	  // }
	
	if(!Tools.isNull(sk)){//重新搜索了
		
		if(sk.length()==8&&StringUtils.isDigits(sk)){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk);
			if(searchProduct!=null){
				response.sendRedirect("/wap/goods.jsp?productid="+searchProduct.getId());
				return;
			}
		}
	
		/*if(sk.length()==10&&sk.toUpperCase().startsWith("FA")){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dmfa12&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
	
		if(sk.length()==10&&sk.toUpperCase().startsWith("WE")){
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dmwe1110&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
			}
		}
		if(sk.length()==10&&sk.toUpperCase().startsWith("DM")){
		
			Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
			if(searchProduct!=null){
				if (searchProduct.getGdsmst_validflag()==1){
				if("01416134".equals(sk.substring(2))){
					boolean blngds=true;
					ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
					if(cartList!=null){
						for(Cart c123:cartList){
							if(c123.getType().longValue()==14&&c123.getProductId().equals("01416134")){
								blngds=false;
							}
						}
					}

					if(blngds){
					Cart cart =new Cart();
					cart.setAmount(new Long(1));
					cart.setCookie(CartHelper.getCartCookieValue(request, response));
					cart.setCreateDate(new Date());
					cart.setHasChild(new Long(0));
					cart.setHasFather(new Long(0));
					cart.setIp(request.getRemoteHost());
					cart.setMoney(new Float(0));
					cart.setOldPrice(new Float(0));
					cart.setPoint(new Long(0));
					cart.setPrice(new Float(0));
					cart.setSkuId("");
					cart.setTuanCode("");//注意parentId值
					cart.setProductId("01416134");
					cart.setType(new Long(14));
					cart.setUserId(CartHelper.getCartUserId(request, response));
					cart.setVipPrice(new Float(0));
					cart.setTitle("【网易DM刊赠品】"+searchProduct.getGdsmst_gdsname());
					Tools.getManager(Cart.class).create(cart);
					response.sendRedirect("/flow.jsp");
					return;
					}
					else
					{
						response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dm1215&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
						return;
					}
				}
				else{
				response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dm1215&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
				return;
				}
				}
			}
		}
		
		//这里看关键词是否需要跳转，如果需要跳转，直接跳转后不执行搜索
		KeySearch keySearch = (KeySearch)Tools.getManager(KeySearch.class).findByProperty("keysearch_txt",sk.trim());
		if(keySearch!=null&&!Tools.isNull(keySearch.getKeysearch_link())){
			response.sendRedirect(keySearch.getKeysearch_link());
			return;
		}
		*/
		keyWords = sk ;
		rackcode = null ;
		session.removeAttribute(SearchManager.search_result_session_key);//重新搜索的话把原来session的搜索结果清除
	}else{
		if(keyWords!=null)keyWords=keyWords.replaceAll(" ", "+");
		keyWords = Base64.decode(keyWords);//用base64编码传中文，免得出现乱码问题
		
		//if(keyWords!=null&&keyWords.indexOf("施华洛")>=0){
			//   keyWords="";
		  // }
	}
	
	if(keyWords!=null)keyWords=keyWords.replaceAll(" +"," ");//把多个空格替换成一个空格
	//搜索结果
	SearchResult sr = SearchManager.getInstance().searchProduct(
			request,response,
			rackcode,
			keyWords,
			60000);//缓存时间，毫秒
	
	final int PAGE_SIZE = 10 ;//每页多少个
	int currentPage = 1 ;//当前页
	
	if(StringUtils.isDigits(pg)){
		currentPage = new Integer(pg).intValue();
	}
	
	PageBean pb = new PageBean(sr.getTotalcount(rackcode),PAGE_SIZE,currentPage);//翻页的PageBean
		
	StringBuffer sb = new StringBuffer();
	sb.append("key_wds="+Base64.encode(keyWords)).append("&");
	
	if(!Tools.isNull(rackcode)){
		sb.append("rackcode="+rackcode+"&");
	}
	
	if(!Tools.isNull(sort)){
		sb.append("sort="+sort+"&");
	}
	
	if(!Tools.isNull(asc)){
		sb.append("asc="+asc+"&");
	}
	
	String pgQueryString = sb.toString();
	
	//搜索结果
	List<Product> list = sr.getProducts(rackcode, sort, isAsc, (currentPage-1)*PAGE_SIZE, PAGE_SIZE);
    if("post".equals(request.getMethod().toLowerCase()))
    {
    	int pagess=Tools.parseInt(request.getParameter("page"));
    	if(pagess<=0)
             response.sendRedirect(request.getRequestURI()+"?"+pgQueryString+"pg=1");
    	else if(pagess>pb.getTotalPages())
    		response.sendRedirect(request.getRequestURI()+"?"+pgQueryString+"pg="+pb.getTotalPages());
    	else
    	{
    		response.sendRedirect(request.getRequestURI()+"?"+pgQueryString+"pg="+pagess);
    	}
    }
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1-优尚网-搜索列表</title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
	padding-left: 3px
}

* html, * html body {
	background-image: url(about:blank);
	background-attachment: fixed;
}

table {
	border-collapse: collapse;
}

ol, ul {
	list-style: none;
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

img {
	border: none;
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
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="/wap/inc/head.jsp"%>
	<!-- 头部结束 -->
	<div>
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>>搜索结果 <br />
		</div>
		<table>
			<tr>
				<td>&nbsp;在购物中搜索<font style="color:#f00"><%=keyWords %></font>共找到<font
					style="color:#f00"><%=sr.getTotalcount(rackcode)%></font>个结果
				</td>
			</tr>
			<tr>
				<td>&nbsp;筛选：<%
         	String hotKeyCode = "000";
		    ArrayList<String> list123 = sr.getNextLevelRackcodes(rackcode) ;//得到下一级搜索分类列表
		    if(list123!=null&&list123.size()>0){
		    	if(list123!=null){
						int i = 0;
					    for(String s123:list123){
					    	if(i == 0) hotKeyCode = s123;
					    	i++;
					    	Directory dir = (Directory)Tools.getManager(Directory.class).get(s123);
					    	if(dir!=null){
					%> <a
					href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&rackcode=<%=s123%>"><%=dir.getRakmst_rackname()%></a>
					<span style="color: #aa2e44">(<%=sr.getTotalcount(s123)%>)
				</span>&nbsp;&nbsp; <%}}}//end if
                  }%>
				</td>
			</tr>
			<tr>
				<td>&nbsp;排序：<a
					href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=createtime&asc=false&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>">最新上架</a>
					<a
					href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=sales&asc=false&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>">热销排行</a>
					<a
					href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=price&asc=false&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>">价格↓</a>
					<a
					href="<%=request.getRequestURI()%>?key_wds=<%=Base64.encode(keyWords)%>&sort=price&asc=true&<%if(!Tools.isNull(rackcode))out.print("rackcode="+rackcode);%>">价格↑</a>
				</td>
			</tr>
		</table>
		<br />
		<table>
			<%
    int size = sr.getTotalcount(rackcode);
	System.out.println(keyWords+"--------"+size+"------rackcode="+rackcode+"-----------------------PAGE_SIZE="+PAGE_SIZE+"------"+currentPage);

    if(size>0)
    {
    	for(Product p:list)
    	{
    		if(p!=null)
    		{
    			long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
    			long currentTime = System.currentTimeMillis();
    			int score = CommentHelper.getLevelView(p.getId());
    			int comcount=CommentHelper.getCommentLength(p.getId());
    			String theimgurl=p.getGdsmst_recimg();
    			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
    				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
    					}else{
    						theimgurl = "http://images.d1.com.cn"+theimgurl;
    					}
    			
    		%>
			<tr>
				<td><a href="/wap/goods.jsp?productid=<%= p.getId() %>"><%= Tools.clearHTML(p.getGdsmst_gdsname()) %></a></td>
			</tr>
			<tr>
				<td><a href="/wap/goods.jsp?productid=<%= p.getId() %>"><img
						src="<%= theimgurl%>" width="120" height="120" /></a></td>
			</tr>
			<tr>
				<td>
					<%
    			if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
    				out.print("<font color='#f00'>秒杀价：￥"+p.getGdsmst_memberprice().longValue()+"</font>");
    				out.print("<font color='#f00'>会员价：￥"+p.getGdsmst_oldmemberprice().longValue()+"</font>");
				    }
    			else
    			{
    			out.print("<font color='#f00'>会员价：￥"+p.getGdsmst_memberprice().longValue()+"</font>");
    			}
    			%>
				</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #ccc;"><span
					style="float: left;">顾客评分：</span><span class="sa<%=score %>"
					style="float: left;"></span>(已有<a
					href="/wap/comment/commentlist.jsp?productid=<%= p.getId() %>"><%= comcount%></a>人评价)</td>
			</tr>
			<%}
    	}
    }
    %>
		</table>



		<tr>
			<td><a
				href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getCurrentPage()==1?1:pb.getPreviousPage() %>"
				class="pag1">上页</a> &nbsp; <a
				href="<%=request.getRequestURI() %>?<%=pgQueryString%>pg=<%=pb.getCurrentPage()==pb.getTotalPages()?pb.getTotalPages():pb.getNextPage() %>"
				class="pag1">下页</a> &nbsp;
				<form id="rpage"
					action="<%=request.getRequestURI() %>?<%=pgQueryString%>"
					method="post">
					<input id="page" name="page" type="text" style="width: 50px;"
						value="<%=pb.getCurrentPage() %>" />/<%= pb.getTotalPages() %>页
					<input type="submit" value="跳&nbsp;转" style="padding: 4px;" />
					<br />
					<a href="<%= backurl %>">返回上一页</a>
				</form></td>
		</tr>


		</table>
		<div style="background: #a52a2a; padding: 2px; margin-top: 2px;">
			<form id="search_1" method="post" action="search.jsp?act=search1">
				<input id="search" name="search" />
				<input type="submit" value="搜商品 " />

			</form>
		</div>
		<br />

		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>&nbsp;&nbsp; <a href="">购物车</a>&nbsp;&nbsp;<br />
			<a href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/regist.jsp">注册</a>&nbsp;&nbsp;<a
				href="/wap/html/help.jsp">帮助</a> <br /> 切换到<a
				href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号 <br />
		</div>



	</div>
</body>
</html>

