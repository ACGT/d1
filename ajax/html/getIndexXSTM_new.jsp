<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
List<Promotion> recommendList = PromotionHelper.getBrandListByCode("2772" , 3);

if(recommendList != null && !recommendList.isEmpty()){
%>
	<ul id="hot_male"><%
    long currentTime = System.currentTimeMillis();
	int i=0;
    for(Promotion recommend : recommendList){
    	Date endTime = recommend.getSplmst_tjendtime();
    	long time = (endTime != null?endTime.getTime():0)-currentTime;
    	i++;
    	%>
    	<% if(i==3)
    	{%>
    	<li style="margin-right:0px;">
    		<%}
    	else
    	{%>
    	<li>
    	<% }%>
        	<p style="z-index:999;"><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target="_blank" ><img src="<%=recommend.getSplmst_picstr() %>" width="315" height="400" alt="<%=Tools.clearHTML(recommend.getSplmst_name()) %>" /></a></p>
            <p class="retime">
            <span style="width:210px; display:block;float:left; text-align:left; padding-left:5px;">
	            &nbsp;&nbsp;<a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target="_blank" style="font-size:15px; color:#fff; "><b><%= Tools.clearHTML(recommend.getSplmst_name()) %></b></a>
	            <br/>&nbsp;&nbsp;活动倒计时：<span class="countdown" time="<%=time %>"><em></em>天<em></em>小时<em></em>分<em></em>秒</span>
            </span>
            <span style="display:block;  padding-top:5px;" >&nbsp;&nbsp;&nbsp;<a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target="_blank"><img src="http://images.d1.com.cn/Index/MaShangQiangGou.gif"></a></span>
            </p>
        </li><%
    	
    } %>
    </ul><%
} %>