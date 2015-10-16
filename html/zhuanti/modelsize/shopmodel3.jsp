<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 200*250每排四个商品 -->
<%if(c%4==1){%>
<dl style="height:310px;margin-left:8px;margin-right:55px; ">
	<dt style="background:#fff;">
	<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
	<img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250">
	</a>
	</dt>
	<dd style="width:200px; margin:0px;">
	<span style="color:#8b8b8b;">
	<font style="display:block; width:85%; margin:0px auto;">
	<% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));  %></font>
	<%  float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
		memprice=Tools.getFloat(p.getGdsmst_msprice(),1);%>	
		<font style="color:#7c7c7c;">促销价：</font>									 
	<%}
	%><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= memprice %></b></font></span>
    </dd>		         
</dl>
<%}else{%>
<dl style="height:310px;<% if(c%4!=0){out.print("margin-right:55px;");} else { out.print("margin-right:0px; ");} %> ">
	<dt style="background:#fff;">
	<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
	<img src="<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250().trim()%>" width="200" height="250">
	</a>
	</dt>
	<dd style="width:200px; margin:0px;">
	<span style="color:#8b8b8b;">
	<font style="display:block; width:85%; margin:0px auto;">
	<% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),50));  %></font>
	<%  float hyprice = 0;
		float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
		if(getmsflag(p)){
		memprice=Tools.getFloat(p.getGdsmst_msprice(),1);%>	
	<font style="color:#7c7c7c;">促销价：</font>									 
<%}%><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= memprice %></b></font></span>
	</dd>		         
</dl>
<%}%>