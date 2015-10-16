<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/shhead.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<div id="left">
    <ul>
      <li attr="admin/SHManage/ProductM"><a href="/admin/SHManage/ProductM.jsp">商品维护</a></li>
      <li attr="admin/SHManage/ProductLR"><a href="/admin/SHManage/ProductLR.jsp">新建商品</a></li>
      <li attr="admin/SHManage/GoodsGroup/GoodsGroupList"><a href="/admin/SHManage/GoodsGroup/GoodsGroupList.jsp">商品关联</a></li>
      <li>搭配管理</li>
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

%>
<script type="text/javascript">
var  url_file1='<%= url_file1%>';
if(url_file1=='admin/SHManage/UpdateP'){
	url_file1='admin/SHManage/ProductM';
}
if(url_file1=='admin/SHManage/GoodsGroup/Add'||url_file1=='admin/SHManage/GoodsGroup/Update'){
	url_file1='admin/SHManage/GoodsGroup/GoodsGroupList';
}
var step1=url_file1;
$(document).ready(function() {
	   $("#left ul").find("li").removeClass('class2');	
	   $("#left ul").find("li").each(function(i) {	
		   var flag1 = $(this).attr('attr');		   
			if(step1 == flag1){
				$(this).addClass('class2');	
				$(this).css('color','#1a4977');
			} 
	   });
});
</script>