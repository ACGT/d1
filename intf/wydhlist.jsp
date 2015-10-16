<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网易兑换列表</title>
<style type="text/css">
   h3{ font-size:14px; line-height:16px; margin-bottom:10px;}
   h3 a{ color:#333;}
</style>
<body>
  <div style="height:50px;">&nbsp;</div>
  
  <br/>
  <br/>
  <form id="form1" method="post" action="/intf/wydhorderlist.jsp" target="right">
  
  
  请选择查询的商品：<br/>
  <select id="sproduct" name="sproduct">
      <option value="mqwy1208nktxa">【网易兑换男士T恤】</option>
      <option value="mqwy1208ntx">【网易兑换打底衫】</option>
      <option value="mqwyjf1209wdk">【网易兑换FM时尚卫衣裤】</option>
      <option value="mqwy1209pj">【网易兑换羊绒大披肩】</option>
      <option value="mqwyjf1209my">【网易兑换FM时尚男卫裤】</option>
      <option value="mqwyjf1210nb">【网易兑换多功能钱包】</option>
      <option value="mqwyjf1210dk">【网易兑换打底裤】</option>
      <option value="mqwy1211mj">【网易兑换保暖棉马甲】</option>
      <option value="mq1211wyjfdk">【网易兑换厚打底裤】</option> 
  </select><br/><br/>
	  请输入时间范围：<br/>(时间格式：2012-1-1)<br/>
	  开始时间：<br/>
	 <input type="text" id="txtbegin" name="txtbegin"/>
	 <br/><br/>
	   结束时间：<br/>
	 <input type="text" id="txtend" name="txtend"/>
	 <br/>
	 <br/>
	 <input type="submit" value="查 询"/>
 </form>
</body>

</html>
