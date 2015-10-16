<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,java.util.Map,java.util.HashMap,com.d1.bean.*,com.d1.helper.*"%>
<%@ include file="/hm.jsp" %>
<%
_HMT _hmt = new _HMT("52b93069093bdcdcff2185b66e5f26d3");
_hmt.setDomainName("m.d1.cn");
_hmt.setHttpServletObjects(request, response);
String _hmtPixel = _hmt.trackPageview();
%>
<img src="<%= _hmtPixel %>" width="0" height="0"  />


    <div class="top" id="top" style=" background:#FFDEAD; padding-top:2px; padding-bottom:2px;">
    <% 
    String info="";
    Map<String,Object> map = new HashMap<String,Object>();
    String uid="";
    User user=UserHelper.getLoginUser(request,response);
	if(user != null){
		uid=user.getMbrmst_uid();
	
		info="<span>您好,<a href=\"/wap/user\">"+StringUtils.getCnSubstring(uid,0,6)+"..."+"</a>&nbsp;&nbsp;<a href=\"/logout.jsp\" target=\"_self\">退出</a><a href=\"/wap/flow.jsp\">&nbsp;&nbsp;购物车("+new Long(CartHelper.getTotalProductCount(request,response))+")&nbsp;</a>&nbsp;&nbsp;<a href=\"/wap/user/forder.jsp\"/>查看订单</a></span>";
		
	
	}else{
		
		info="<span class=\"login\"><a href=\"/wap/login.jsp\">&nbsp;登录&nbsp;</a>|<a href=\"/wap/regist.jsp\">&nbsp;注册&nbsp;</a>|<a href=\"/wap/flow.jsp\">&nbsp;购物车("+new Long(CartHelper.getTotalProductCount(request,response))+")&nbsp;</a>&nbsp;&nbsp;<a href=\"/wap/user/forder.jsp\"/>查看订单</a></span>";
	}
    out.print(info);
%>
	</div>
	<a href="/mindex.jsp"><img src="http://images.d1.com.cn/wap/newlogo.jpg" /></a>
