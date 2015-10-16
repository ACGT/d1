<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
List<ProductGroup> list = ProductGroupHelper.getTodayProductGroups();
if(list != null && !list.isEmpty()){
	for(ProductGroup pg : list){
		Product product = ProductHelper.getById(pg.getTgrpmst_gdsid());
		if(product == null) continue;
		Date endTime = pg.getTgrpmst_endtime();
		long time = (endTime != null?endTime.getTime():0)-System.currentTimeMillis();
		String title = Tools.clearHTML(product.getGdsmst_gdsname());
		%>
		<div style="width: 352px;text-align:center; height:42px;background: url('http://images.d1.com.cn/Index/tck.jpg')"><span onclick="javascript:closeSC()" style="cursor:pointer; float:right; padding-right:5px; margin-top:12px;"><img src="http://images.d1.com.cn/Index/cha.gif"/></span></div>
		<div style="width:322px;padding-top:10px; padding-left:9px; padding-right:5px;">
		<table cellspacing="0" cellpadding="0" border="0"><tr><td width="152" colspan="2">
		<a href="/tuan/index.jsp" target="_blank">
		<img src="<%=pg.getTgrpmst_indeximg() %>" alt="<%= title %>" style="border:none;" width="332" height="138"></a>
		</td></tr>
		<tr><td height="5" colspan="2"></td></tr>
		<tr style="background-color:#e6e6e6; color:#070707; font-size:14px; "><td height="24" >
		<span style="line-height:30px; padding-top:2px; over-flow:hidden;">&nbsp;倒计时：<span id="newspan" class="countdown" time="<%=time %>"><em style="font-size:15px; color:#e00001;"></em>天<em style="font-size:15px; color:#e00001;"></em>小时<em style="font-size:15px; color:#e00001;"></em>分<em style="font-size:15px; color:#e00001;"></em>秒</span></span>
		</td>
		<td style=" text-align:right"><b><font style=" color:#e00001"><%=pg.getTgrpmst_hotmodulus() %></font></b></font>人已团购&nbsp;&nbsp;</td></tr>
		</table></div>
		
		<%
		break;
	}
}
%>