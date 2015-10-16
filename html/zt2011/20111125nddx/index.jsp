<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>年底答谢专场 暖流扑面三重礼 全场买一赠一-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
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
        var the_H=Math.floor((the_s[the_s_index]-the_D*3600)/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_D*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        html = "倒计时: ";
        //if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) html += '&nbsp;<span class="hour">'+(the_H)+"</span>小时";
        if(the_D!=0 || the_H!=0 || the_M!=0) html += '&nbsp;<span class="minute">'+the_M+"</span>分";
        html += '&nbsp;<span class="second">'+the_S+"</span>秒";
        $getid(objid).innerHTML = html;
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
<table id="__01" width="981" height="4546" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_01.jpg" width="980" height="73" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="73" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_02.jpg" width="642" height="215" alt=""></td>
		<td colspan="6" rowspan="2">
			<a href="/product/01205253" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_03.jpg" alt="" width="338" height="417" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="215" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_04-1.jpg" width="642" height="202" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="202" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_05.jpg" width="980" height="67" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="67" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_06.jpg" width="14" height="473" alt=""></td>
		<td colspan="3">
		<div style="position:relative;left;width:467px;height:473px;z-index:1;">
		<div style="position:absolute;width:185px;height:30px; margin-top:430px; margin-left:275px;z-index:999;">
		<span class=time id=tjjs_1></span>
		 <SCRIPT language=javascript>
var startDate= new Date("2011/12/5 15:27:59");var endDate= new Date("2011/12/7 12:0:0");the_s[1]=(endDate.getTime()-startDate.getTime())/1000;setInterval("view_time(1,'tjjs_1')",1000);</SCRIPT>
		</div>
			<a href="/product/01415970" target="_blank"><img src="http://images.d1.com.cn/shopadmin/splimg/201112/diao111205_jai.jpg" alt="" width="467" height="473" border="0"></a> </div>
			  
 
			</td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_08.jpg" width="14" height="473" alt=""></td>
		<td colspan="8">
			
		<div style="position:relative;left;width:467px;height:473px;z-index:1;">
		<div style="position:absolute;width:185px;height:30px; margin-top:430px; margin-left:275px;z-index:999;">
		<span class=time id=tjjs_2></span>
				   <SCRIPT language=javascript>
var startDate= new Date("2011/12/5 15:27:59");var endDate= new Date("2011/12/7 12:0:0");the_s[2]=(endDate.getTime()-startDate.getTime())/1000;setInterval("view_time(2,'tjjs_2')",1000);</SCRIPT>
		</div>
			<a href="/product/01516274" target="_blank"><img src="http://images.d1.com.cn/shopadmin/splimg/201112/kaxiou111205_jai.jpg" alt="" width="467" height="473" border="0"></a> </div>
	
 
</td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_10.jpg" width="18" height="473" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="473" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_11.jpg" width="980" height="85" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="85" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/html/brand/brand16.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_12.jpg" alt="" width="480" height="281" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/html/brand/brand74.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_13-1.jpg" alt="" width="242" height="281" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/html/brand/brand26.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_14-1.jpg" alt="" width="258" height="281" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="281" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/html/brand/brand16.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_15.jpg" alt="" width="480" height="274" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014002002, 014002001" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_16.jpg" alt="" width="242" height="274" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/html/brand/brand144.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_17.jpg" alt="" width="258" height="274" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="274" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/zt2011/1125aleeishe/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_18.jpg" alt="" width="258" height="296" border="0"></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/html/zt2011/20111117nz/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_19.jpg" alt="" width="241" height="296" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/zt2011/20111123only/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_20.jpg" alt="" width="481" height="296" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="296" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/lt_b.asp?productsortflag=0&productsort=017001&productname=伊自尚&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/20111128103330909.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_21.jpg" alt="" width="258" height="274" border="0"></a></td>
		<td colspan="5">
			<a href=" http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=017001&productname=韩依依&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/201111281069453.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_22.jpg" alt="" width="240" height="274" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/html/zt2011/20111123only/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_23.jpg" alt="" width="482" height="274" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="274" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/html/zt2011/20111104sp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_24.jpg" alt="" width="481" height="298" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/zt2011/20110927thsp/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_25.jpg" alt="" width="241" height="297" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/html/zt2011//20110920sp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_26.jpg" alt="" width="258" height="297" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="297" alt=""></td>
	</tr>
	<tr>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/html/zt2011/20111128byg/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_27.jpg" alt="" width="240" height="274" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/html/zt2011/20111128hcst/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_28.jpg" alt="" width="259" height="274" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="http://www.d1.com.cn/html/zt2011/20111104sp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_29.jpg" alt="" width="481" height="273" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="273" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=017005&productname=包客隆&sequence=2" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_30.jpg" alt="" width="258" height="297" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/html/zt2011/20111116myzy/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_31.jpg" alt="" width="240" height="297" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/html/zt2011/20111123qty/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_32.jpg" alt="" width="482" height="297" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="297" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=017006010&productname=S.K.T&sequence=1" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_33.jpg" alt="" width="258" height="274" border="0"></a></td>
		<td colspan="6">
			<a href=" http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=017003010002,017003010001,017003010001,017003010003&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/2011112811119930.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_34.jpg" alt="" width="241" height="274" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/zt2011/20111123qty/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_35.jpg" alt="" width="481" height="274" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="274" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/html/zt2011/20111125pj" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_36.jpg" alt="" width="483" height="298" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/zt2011/20111128blwt" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_37.jpg" alt="" width="240" height="298" border="0"></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/html/result.asp?productsortflag=0&productsort=017002007&productbrand=烎&sequence=2" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_38.jpg" alt="" width="257" height="298" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="298" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="http://www.d1.com.cn/html/zt2011/20111125pj" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_39.jpg" alt="" width="481" height="274" border="0"></a></td>
		<td colspan="9">
			<a href="http://www.d1.com.cn/html/zt2011/20111128pb" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_40.jpg" alt="" width="243" height="274" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/zt2011/20111128sbdk" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_41.jpg" alt="" width="256" height="274" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="274" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn//html/zt2011/20111121zippo/" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_42.jpg" alt="" width="258" height="298" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=015002004057&sequence=2&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/20111125165910980.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_43.jpg" alt="" width="240" height="298" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=015002004001&sequence=2&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/20111125143348706.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_44.jpg" alt="" width="482" height="298" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="298" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=015008&sequence=2&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/20111125143739997.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_45.jpg" alt="" width="258" height="293" border="0"></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=015002004049&productname=聚利时&sequence=2&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/20111125143558551.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_46.jpg" alt="" width="241" height="293" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/result_b.asp?productsortflag=0&productsort=015002004001&sequence=2&img=http://images.d1.com.cn/edit/UploadFile/gdsimg/201111/20111125143348706.jpg" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111125nddx/nddx_47.jpg" alt="" width="481" height="293" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="293" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="244" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="222" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="3" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="143" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="79" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="238" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111125nddx/分隔符.gif" width="18" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
</center>


<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>