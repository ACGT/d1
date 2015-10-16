<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
List<Promotion> recommendList = PromotionHelper.getBrandListByCode("2720" , 4);
%><h2><a href="/sales/" class="more" target="_blank"><em>&gt;&gt;</em>更多特卖商品</a></h2>
<h1><a href="/sales/" title="限时特卖" target="_blank">限时特卖</a></h1><%
if(recommendList != null && !recommendList.isEmpty()){
%>
	<ul id="hot_male"><%
    long currentTime = System.currentTimeMillis();
    for(Promotion recommend : recommendList){
    	Date endTime = recommend.getSplmst_tjendtime();
    	long time = (endTime != null?endTime.getTime():0)-currentTime;
    %>
    	<li>
        	<p><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target="_blank"><img src="<%=recommend.getSplmst_picstr() %>" alt="<%=Tools.clearHTML(recommend.getSplmst_name()) %>" /></a></p>
            <p class="retime">活动倒计时：<span class="countdown" time="<%=time %>"><em></em>天<em></em>小时<em></em>分<em></em>秒</span></p>
        </li><%
    } %>
    </ul><%
} %>