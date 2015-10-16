<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/shhead.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<div id="left" style="background:url('/admin/SHManage/images/leftbg-1.jpg') no-repeat;">
    <ul>
      <li attr="admin/SHManage/Shop/SetIndex"><a href="/admin/SHManage/Shop/SetIndex.jsp">页面维护</a></li>
      <li attr="admin/SHManage/ShopRck/index"><a href="/admin/SHManage/ShopRck/index.jsp">店内分类</a></li>
      <li attr="admin/SHManage/Shop/zhuanti_list"><a href="/admin/SHManage/Shop/zhuanti_list.jsp">专题列表</a></li>
      <li attr="/admin/SHManage/Shop/SetIndex.jsp?index_flag=1"><a href="/admin/SHManage/Shop/SetIndex.jsp?index_flag=1">专题添加</a></li>
     <%
	String shop_code = request.getSession().getAttribute("shopcodelog").toString();//获取后台商户的id值
	if(shop_code != null && (shop_code.equals("00000000") || shop_code.equals("13100902"))){%>
	      <li attr="admin/SHManage/Actindex/Actindex_list"><a href="/admin/SHManage/Actindex/Actindex_list.jsp">邮件专题列表</a></li>
	      <li attr="admin/SHManage/Actindex/Actindex_add"><a href="/admin/SHManage/Actindex/Actindex_add.jsp">邮件专题添加</a></li>
	 <%}
	  %>
    
    </ul>
    <div><br>
 上下架QQ：2100387018<br>
客服QQ: 2830191426<br>
对账QQ：1764220940<br>
结款QQ：248872750<br>
服务监督QQ： 64835630<br>
    </div>
</div>
<%
     String url_file1 = request.getServletPath();
     if(url_file1 != null && url_file1.length()>0) url_file1 = url_file1.substring(1).replace(".jsp",""); 
	 String index_f =request.getParameter("index_flag");
%>
<script type="text/javascript">
var  url_file1='<%= url_file1%>';
var  index_f='<%= index_f%>';
if(index_f == 1){
	var step1='/admin/SHManage/Shop/SetIndex.jsp?index_flag=1';
}else if(index_f == 2){
	var step1='admin/SHManage/Shop/zhuanti_list';
}else{
	var step1=url_file1;
}

$(document).ready(function() {
	   $("#left ul").find("li").removeClass('class2');	
	   $("#left ul").find("li").each(function(i) {	
		   var flag1 = $(this).attr('attr');
		   if(index_f == 2){
			   step1 == flag1;
		   }
			if(step1 == flag1){
				$(this).addClass('class2');	
				$(this).css('color','#1a4977');
			} 
	   });
});
function Substring(str){ 
	var ss; // 声明变量。 
	ss = s.substring(0, 26); // 取子字符串。 
	return(ss); // 返回子字符串。 
} 
</script>