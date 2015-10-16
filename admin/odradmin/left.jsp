<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%><%@include file="/admin/chkshop.jsp"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/shhead.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<div id="left1">
    <ul>
      <li attr="/admin/odradmin/index.jsp?req_odrstatus=2"><a href="/admin/odradmin/index.jsp">订单列表</a></li>
      <li attr="/admin/odradmin/indexth.jsp"><a href="/admin/odradmin/indexth.jsp">订单退换货</a></li>
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