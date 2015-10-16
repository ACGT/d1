<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>笑迎2012 罪爱降价飓疯 69元封顶-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
<!--
body {
	background-color: #FFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.time{ height:21px; line-height:21px; font-size:14px; font-weight:800; color:#fff;}
.daynum{ color:#FF0000;}
.hour {
	color:#ffffff; font-size:24px; font-family:"微软雅黑"; font-weight:800; width:66px; float:right; line-height:30px; text-align:center;
}
.minute {
	color:#ffffff; font-size:24px;font-family:"微软雅黑";font-weight:800; width:66px; float:right;line-height:30px;text-align:center;
}
.second {
	color:#ffffff; font-size:24px;font-family:"微软雅黑";font-weight:800; width:60px; float:right;line-height:30px;text-align:center;
}
-->
</style>
<script language="javascript">

//限时抢购
var the_s=new Array();

function $getid(id)
{
    return document.getElementById(id);
}

function view_time(the_s_index,objid){

    if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index])/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        html = "";
		html1 = "";
		html2 = "";
        //if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) html1 = '<div class="hour">'+(the_H)+"</div>";
        if(the_D!=0 || the_H!=0 || the_M!=0) html2 = '<div class="minute">'+the_M+"</div>";
        html += '<div class="second">'+the_S+"</div>";
        $getid(objid).innerHTML = html+html2+html1;
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";

    }
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="1601" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_01.jpg" width="980" height="150" alt=""/></td>
	</tr>
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_02.jpg" width="980" height="178" alt=""/></td>
	</tr>
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_03.jpg" width="980" height="188" alt=""/></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01408158.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_04.jpg" alt="" width="147" height="144" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01411498.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_05.jpg" alt="" width="133" height="144" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01416157.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_06.jpg" alt="" width="144" height="144" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01412672.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_07.jpg" alt="" width="144" height="144" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01413436.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_08.jpg" alt="" width="151" height="144" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415931.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_09.jpg" alt="" width="129" height="144" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415780.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_10.jpg" alt="" width="132" height="144" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01415728.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_11.jpg" alt="" width="148" height="155" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01415934.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_12.jpg" alt="" width="132" height="155" border="0"/></a></td>
		<td colspan="6" background="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_13.jpg"><table width="440" height="155" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="121" height="100">&nbsp;</td>
            <td width="217">&nbsp;</td>
            <td width="102">&nbsp;</td>
          </tr>
          <tr>
            <td height="45">&nbsp;</td>
            <td><%
           // SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			
            String tttime ="2011/12/9 00:00:00";
           // Date d = new Date(System.currentTimeMillis()+30*24*3600*1000l);
           java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
           String	nowtime= df.format(new Date());
           java.util.Calendar c1=java.util.Calendar.getInstance();
			java.util.Calendar c2=java.util.Calendar.getInstance();
			try
			{
			c1.setTime(df.parse(nowtime));
			c2.setTime(df.parse(tttime));
			}catch(java.text.ParseException e){
			System.err.println("格式不正确");
			}
			int result=c1.compareTo(c2);
			if(result==0)
			System.out.println("c1相等c2");
			else if(result<0)
			System.out.println("c1小于c2");
			else
			System.out.println("c1大于c2");
		 if(result<0){
			 int tjjs=1;
			 %>
		 
<div style=" width:200px; line-height:30px; float:left;" align="right">	
<span class=time id=tjjs_1></span>
   <script language=javascript>
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
the_s[<%=tjjs%>]=(endDate.getTime()-startDate.getTime())/1000;setInterval("view_time(<%=tjjs%>,'tjjs_<%=tjjs%>')",1000);</script><br />
	</div>
<%}%></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="10"></td>
            <td></td>
            <td></td>
          </tr>
        </table></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415859.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_14.jpg" alt="" width="130" height="155" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01411687.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_15.jpg" alt="" width="130" height="155" border="0"/></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01405770.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_16.jpg" alt="" width="146" height="152" border="0"/></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01413705.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_17.jpg" alt="" width="134" height="152" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415800.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_18.jpg" alt="" width="146" height="152" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415568.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_19.jpg" alt="" width="143" height="152" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415861.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_20.jpg" alt="" width="151" height="152" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01408310.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_21.jpg" alt="" width="128" height="152" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415576.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_22.jpg" alt="" width="132" height="152" border="0"/></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01415878.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_23.jpg" alt="" width="146" height="135" border="0"/></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01415600.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_24.jpg" alt="" width="134" height="135" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01415768.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_25.jpg" alt="" width="144" height="135" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01416122.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_26.jpg" alt="" width="144" height="135" border="0"/></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01415574.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_27.jpg" alt="" width="151" height="135" border="0"/></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01413442.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_28.jpg" alt="" width="131" height="135" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01412363.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_29.jpg" alt="" width="130" height="135" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_30.jpg" width="980" height="61" alt=""/></td>
	</tr>
	<tr>
		<td height="59" colspan="13"><%request.setAttribute("code","7126");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_32.jpg" width="980" height="54" alt=""/></td>
	</tr>
	<tr>
		<td height="52" colspan="13"><%request.setAttribute("code","7127");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_34.jpg" width="980" height="54" alt=""/></td>
	</tr>
	<tr>
		<td height="69" colspan="13"><%request.setAttribute("code","7128");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td colspan="13">
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/jjjf_36.jpg" width="980" height="54" alt=""/></td>
	</tr>
	<tr>
		<td height="95" colspan="13"><%request.setAttribute("code","7129");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="146" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="1" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="1" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="132" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="144" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="2" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="142" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="1" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="150" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="1" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="128" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="2" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111128hzp/分隔符.gif" width="130" height="1" alt=""/></td>
	</tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>