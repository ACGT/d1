<%@ page contentType="text/html; charset=UTF-8"%>
<!--类型为6或者其他： 160*200每排四个商品 -->
<%if(c%4==1){%>
<dl style="height:260px;margin-right:100px;margin-left:20px;">
    <dt style="background:#fff;">
    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
    <img src="<%= !Tools.isNull(p.getGdsmst_fzimg())&&p.getGdsmst_fzimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_fzimg())?"":p.getGdsmst_fzimg().trim()%>" width="160" height="200">
    </a>
    </dt>
    <dd style="width:160px;margin:0px;">
    <span style="color:#8b8b8b;">
    <font style="display:block; width:85%; margin:0px auto;">
    <% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));  %></font>
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
<%}
    else if(c%4==2||c%4==3){%>
<dl style="height:260px;margin-right:100px;margin-left:0px;">
     <dt style="background:#fff;">
         <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
         <img src="<%= !Tools.isNull(p.getGdsmst_fzimg())&&p.getGdsmst_fzimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_fzimg())?"":p.getGdsmst_fzimg().trim()%>" width="160" height="200">
         </a>
     </dt>
     <dd style="width:160px;margin:0px;">
     <span style="color:#8b8b8b;">
     <font style="display:block; width:85%; margin:0px auto;">
     <% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));  %></font>
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
<%}else{%>
<dl style="height:260px;margin-right:20px;margin-left:0px;">
    <dt style="background:#fff;">
    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
    <img src="<%= !Tools.isNull(p.getGdsmst_fzimg())&&p.getGdsmst_fzimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_fzimg())?"":p.getGdsmst_fzimg().trim()%>" width="160" height="200">
    </a>
    </dt>
    <dd style="width:160px;margin:0px;">
    <span style="color:#8b8b8b;">
    <font style="display:block; width:85%; margin:0px auto;">
    <% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),40));  %></font>
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
<%}%>