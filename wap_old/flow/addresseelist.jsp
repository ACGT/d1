<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/wap/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="application/vnd.wap.xhtml+xml;charset=utf-8" />

<title>D1优尚网- 收货地址管理</title>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px; padding-left:4px; }
ol,ul{list-style:none;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
img{ border:none;}
.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
.newli{ padding-left:8px;}
</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
  <%
    String ticketid = request.getParameter("ticketid");//优惠券ID
    String addressid = request.getParameter("addressid");//用户选择的地址ID
    String prepay=request.getParameter("prepay");//预付款
    String liuyan=request.getParameter("liuyan");//订单留言
    
    String url="ticketid="+ticketid+"&prepay="+prepay+"&liuyan="+liuyan;
    %>
       <div style=" background:#FFDEAD; padding:3px; width:100%;">
 收货地址管理 | <a href="/wap/user/addressprovince.jsp?op=add&<%=url %>&from=flow">添加</a>
    <br/>
    </div>
    <form id="faddr" method="post" action="">
    
  <%
    ArrayList<UserAddress> list = UserAddressHelper.getUserAddressList(lUser.getId());
	if(list!=null&&list.size()>0){
		if(Tools.isNull(addressid) || "null".equals(addressid.toLowerCase())){
			addressid=list.get(0).getId();
		}
		for(UserAddress ua:list){
			
			if(ua.getMbrcst_countryid().intValue()!=100 && Tools.isNull( ua.getMbrcst_memo())){
				%>
				<input type="radio" name="address" value="<%= ua.getId()%>" <% if(ua.getId().equals(addressid)) out.print("checked");%> /><%=ua.getMbrcst_raddress() %>
				  <a href="/wap/flowCheck1.jsp?<%=url %>&addressid=<%=ua.getId()%>">确定</a>&nbsp;&nbsp;  <a href="/wap/user/addressprovince.jsp?<%=url %>&addressid=<%=ua.getId()%>&id=<%=ua.getMbrcst_provinceid()%>&from=flow">修改</a>&nbsp;&nbsp;<a href="flowCheck_op.jsp?<%=url %>&addressid=<%=ua.getId()%>&deladdress=1">删除</a>
				<br/>
				<%
			}
		}%>
		

	<%}
	else
	{%>
		您还没有收货地址，<a href="/wap/user/addressprovince.jsp?op=add&<%=url %>&from=flow">马上去添加</a>
	<%}
    %>
     <p>
<a href="/wap/flowCheck1.jsp?<%=url %>&addressid=<%=addressid%>">返回上一页</a>
	    </p>
    </form>
</div>
<!-- 尾部 -->
<%@ include file="/wap/inc/userfoot.jsp" %>
<!-- 尾部结束 -->
</body>
</html>

