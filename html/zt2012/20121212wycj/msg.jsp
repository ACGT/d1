<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String cardno=request.getParameter("msg");
String msg="";
String flag=request.getParameter("flag");
if("0".equals(flag)){//未中奖
	 msg="很遗憾，您没有中奖，送您特惠商品兑换码："+cardno+"一张 <br/>可超值兑换<a href=\"/html/zt2012/20121212wycj/dhindex.jsp\" target=\"_blank\" style=\"color:red;\">更多礼品》》</a><br/>特惠商品码已发送至您的邮箱"+lUser.getMbrmst_email();
}else if("2".equals(flag)){
	msg="恭喜您，抽中泰国进口3朵永不凋谢真玫瑰花<br/>中奖码："+cardno+"&nbsp;&nbsp;&nbsp;兑换截止2012年12月31日<br/>中奖码已发送至您的邮箱&nbsp;&nbsp;"+lUser.getMbrmst_email();
}else if("3".equals(flag)){
	msg="恭喜您，抽中【FEEL MIND】经典商务休闲真皮钱包+腰带2件套<br/>中奖码："+cardno+"&nbsp;&nbsp;&nbsp;兑换截止2012年12月31日<br/>中奖码已发送至您的邮箱&nbsp;&nbsp;"+lUser.getMbrmst_email();
}
%>

<div class="sys-dialog-content" style="border:none;">

			<!-- 弹窗内容 Start -->

			<div class="sys-dialog-content-hasico" style="padding-bottom:50px;padding-top:25px;">
				<%
if("0".equals(flag)){//未中奖
	%>
	<b class="ico ico-sad-big"></b>
<%}else{
	%>
	<b class="ico ico-smile-big"></b>

<%}
%>
				<p class="linewords" style="text-align:left; line-height:22px;padding-bottom:10px;"><%=msg %></p>
				

<div class="btn btn-dft btn-dft-big btn-dft-big-hover" style="float:left; " >
<%
if("0".equals(flag)){//未中奖
	%>
	<span onclick="window.location='http://www.d1.com.cn//html/zt2012/20121212wycj/dhindex.jsp'">马上兑换</span>
<%}else{
	%>
	<span onclick="window.location='http://www.d1.com.cn/market/1201/wangyi/'">马上兑换中奖商品</span>

<%}
%>
	

</div>
</div>
<!-- 弹窗内容 End -->

		</div>
