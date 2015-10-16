<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%><%@include file="/admin/chkshop.jsp"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/shhead.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<div id="left1">
    <ul>
    <%String shopcode=session.getAttribute("shopcodelog").toString() ;
    if(shopcode!=null&&shopcode.equals("00000000")){
    %>
      <li attr="/admin/SHManage/shopact/actlist.jsp"><a href="/admin/SHManage/shopact/actlist.jsp">活动列表</a></li>
      <li attr="/admin/SHManage/shopact/actadd.jsp"><a href="/admin/SHManage/shopact/actadd.jsp">满减活动添加</a></li>
      <%}else{
    D1ActTb acttbleft=(D1ActTb)Tools.getManager(D1ActTb.class).findByProperty("d1acttb_shopcode", shopcode);
    if(acttbleft!=null){
    	
    %>
      <li attr="/admin/SHManage/shopact/acttbup.jsp"><a href="/admin/SHManage/shopact/acttbup.jsp?id=<%=acttbleft.getId()%>">满减活动设置</a></li>
      <%}else{ %>
      <li attr="/admin/SHManage/shopact/actadd.jsp"><a href="/admin/SHManage/shopact/actadd.jsp">满减活动设置</a></li>
      <%} 
      }%>
      <li>&nbsp;</li>
    </ul>
</div>
<script type="text/javascript">

$(document).ready(function() {

	   $("#left ul").find("li").each(function(i) {		   
		   $(this).click(function(){			
					$("#left ul").find("li").removeClass('class2');					
					$(this).addClass('class2');	
					$(this).css('color','#1a4977');
					$('#rightdisplay').attr("src",$(this).attr('attr'));
					
		   });
		  
		   });
});
</script>