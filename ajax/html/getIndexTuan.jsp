<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
List<ProductGroup> list = ProductGroupHelper.getTodayProductGroups();
if(list != null && !list.isEmpty()){
	for(ProductGroup pg : list){
		Product product = ProductHelper.getById(pg.getTgrpmst_gdsid());
		if(product == null) continue;
		Date endTime = pg.getTgrpmst_endtime();
		long time = (endTime != null?endTime.getTime():0)-System.currentTimeMillis();
		String title = Tools.clearHTML(product.getGdsmst_gdsname());
		%><h2>
			<span class="f_r">剩<span class="countdown" time="<%=time %>"><em></em>天<em></em>小时<em></em>分<em></em>秒</span></span></h2>
			<p class="f_l"><a href="http://www.d1.com.cn/tuan/" target="_blank"><img src="<%=pg.getTgrpmst_indeximg() %>" alt="<%=title %>" width="132" height="112" /></a></p>
			<p></p>
			<p style=" height:45px; overflow:hidden;"><a href="http://www.d1.com.cn/tuan/" target="_blank"><%=title %></a></p>
			<p class="c99">原价：<del>￥<%=pg.getTgrpmst_nprice() %></del></p>
	        <p class="price">￥<%=pg.getTgrpmst_sprice() %></p>
	        <p>已有<em><%=pg.getTgrpmst_hotmodulus() %></em>人购买</p>
	        <div class="clear"></div>
		<%
		break;
	}
}
%>