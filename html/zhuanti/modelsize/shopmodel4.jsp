<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 240*300每排四个商品 -->
<dl style="height:360px;<% if(c%4!=0){out.print("margin-right:6px;");} else { out.print("margin-right:0px; ");} %> ">
	<dt style="background:#fff;">
    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
    <img src="<%= !Tools.isNull(p.getGdsmst_img240300())&&p.getGdsmst_img240300().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img240300())?"":p.getGdsmst_img240300().trim()%>" width="240" height="300">
    </a>
    </dt>
    <dd style="width:240px;margin:0px;">
    <span style="color:#8b8b8b;">
    <font style="display:block; width:85%; margin:0px auto;">
    <% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));  %></font>
    <% float hyprice = 0;
	float memprice=Tools.getFloat(p.getGdsmst_memberprice(),1);
	if(getmsflag(p)){
	memprice=Tools.getFloat(p.getGdsmst_msprice(),1);%>	
	<font style="color:#7c7c7c;">促销价：</font>									 
	<%}
	%><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= memprice %></b></font>
    </span>
    </dd>		         
</dl>