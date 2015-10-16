<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%
float lastmoney=0f;
if(!Tools.isNull(request.getParameter("lastmoney"))){
	lastmoney=Tools.parseFloat(request.getParameter("lastmoney"),2);
}
String type=request.getParameter("type");
String brandname="AleeiShe 小栗舍";
String  gdsname="纪念版天使树脂烛台摆件";
String step="s1";
if(!Tools.isNull(type)){
	if("1".equals(type)){
		brandname="AleeiShe 小栗舍";
		gdsname="价值69元纪念版天使树脂烛台摆件";
		step="s1";
	}else if("2".equals(type)){
		brandname="AleeiShe 小栗舍";
		gdsname="价值159元纪念版蝴蝶彩绘烛台摆件";
		step="s2";
	}else if("3".equals(type)){
		brandname="诗若漫";
		gdsname="价值59元的加厚珍珠绒打底裤";
		step="s4";
	}else if("4".equals(type)){
		brandname="FEEL MIND";
		gdsname="价值79元的同品牌纯牛皮腰带";
		step="s3";
	}
}
%>
<script>
function back(){
	$.close();
}
</script>
<div align="center">
<p style="font-weight:bold;padding-top:20px;">您只需再购买
<span style="color:red;"><%=Tools.getFloat(lastmoney,2)%></span>
元的<%=brandname %>品牌商品即可获得</p>
<p style="padding-top:20px;"><a href="http://www.d1.com.cn/zhuanti/20121112syyzp/syyzp.jsp#<%=step %>" target="_blank"><%=gdsname %>(了解详情)</a></p>
<p style="padding-top:20px;"><a href="javascript:back();" id="shopcar_b_watch" title="立即结算"><img src="http://images.d1.com.cn/images2012/3.png" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/flowCheck.jsp"  id="shopcar_b_goon" title="继续购物"><img src="http://images.d1.com.cn/images2012/4.png" /></a></p>
</div>