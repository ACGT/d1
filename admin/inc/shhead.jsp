<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/shhead.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<%
ShpMst shpmsthead = (ShpMst)Tools.getManager(ShpMst.class).get(session.getAttribute("shopcodelog").toString());
String shop_s_name = "";//商户缩写名
if(shpmsthead!=null){
	shop_s_name = shpmsthead.getShpmst_shopname();
}

%>
<div id="Header">
<div id="top" >
  <div id="top_1">
      <span class="ShowWelcome" id="ShowWelcome"><% if(session.getAttribute("shopadmin")==null){%><a href="/admin/SHManage/Login.jsp" >请登录</a> <%} else {%>您好，<b><%=shop_s_name%></b>&nbsp;<a href="/admin/SHManage/Logout.jsp" >[退出]</a><%} %></span>
      <div id="menu">
     <ul>
         <li style="width:72px;"><a href="#">首页</a></li>
         <li style="width:104px;"><a href="/admin/SHManage/ShopRck/index.jsp" attr="admin/SHManage/ShopRck/index">我的店铺</a></li>
         <li  style="width:108px;"><a href="/admin/SHManage/ProductLR.jsp" attr="admin/SHManage/ProductLR">商品管理</a></li>
         <li  style="width:108px;"><a href="/admin/SHManage/shopact/index.jsp" attr="admin/SHManage/shopact/index">促销管理</a></li>
         <li><a href="/admin/odradmin/index.jsp" attr="admin/odradmin/index">订单管理</a></li>
         <li  style="width:110px;"><a href="#">配送管理</a></li>
         <li><a href="/admin/jsmbr/jsmstshoplist.jsp?jsmst_shpcode=<%=session.getAttribute("shopcodelog").toString()%>">结算管理</a></li>
         <li><a href="#">账号管理</a></li>
         <li style="width:80px;"><a href="#">帮助</a></li>

     </ul>
      </div>
  </div>
  
  
</div>
</div>
<div class="clear"></div>
<%
     String url_file = request.getServletPath();
     if(url_file != null && url_file.length()>0) url_file = url_file.substring(1).replace(".jsp",""); 

%>
<script>
var  url_file='<%= url_file%>';
var step=url_file;
$(document).ready(function() {
	   $("#menu").find("a").each(function(i) {
			  var flag = $(this).attr('attr');
				if(step == flag){
					$(this).addClass('newhover');
					$(this).css('color','#ffffff');
				}   
		   });
});

</script>




