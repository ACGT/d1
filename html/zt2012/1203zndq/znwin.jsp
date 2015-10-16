<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private ArrayList<LotWinAct> lotwinlist(){
	ArrayList<LotWinAct> list=new ArrayList<LotWinAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> lotlist= Tools.getManager(LotWinAct.class).getList(null, olist, 0, 50);
	if(lotlist==null || lotlist.size()==0) return null;
	for(BaseEntity be:lotlist){
		list.add((LotWinAct)be);
	}
	return list;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>优尚网9周年店庆抽大奖，5000元现金等你抽！-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
<!--
.tlput {
	width: 150px;
	border: 1px solid #C2C2C2;
	height: 26px;
	font-size:14px;
}
form{ padding:0px; margin:0px;}
  ul,li{margin:0;padding:0}
#scrollDiv{width:200px;height:230px; margin-top:36px;line-height:21px;overflow:hidden}
#scrollDiv li{height:21px;padding-left:8px;color:#525252;text-align:left}

#ZNcontainer {
	width:400px;
	height:300px;
	border:20px #99CC00 ridge;
	text-align:center;
	display:none;
	position:absolute;
	left:50%;
	top:50%;
	margin-left:-200px;
	margin-top:-150px;
	z-index:10;
	background-color:#99CC00;
}
ul,li{ list-style:none;}
#ZNmask {
	width:100%;
	height:100%;
	position:absolute;
	background-color:#000;
	left:0;
	top:0;
	z-index:8;
}
.STYLE2 {color: #EEEE00}
.jf1 {color: #FF0000}
.jf2 {color: #333333}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="981" height="1001" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_01.jpg" width="158" height="84" alt=""></td>
		<td colspan="2">
			<a href="znzhufu.jsp#add" target="_blank"><img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_02.jpg" alt="" width="270" height="84" border="0"></a></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_03.jpg" alt="" width="552" height="84" border="0" usemap="#Map4"></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="84" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_04.jpg" alt="" width="980" height="95" border="0" usemap="#Map3"></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="95" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="znzhufu.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_05.jpg" width="206" height="148" alt=""></a></td>
		<td colspan="2" rowspan="4" background="http://images.d1.com.cn/images2012/fkdzy/fkdzy_06.jpg" align="center">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="530" height="530">
  <param name="movie" value="zndq.swf" />
  <param name="quality" value="high" />
   <param name="wmode" value="transparent">
  <embed src="zndq.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="530" height="530"></embed>
</object>
		</td>
		<td rowspan="2" background="http://images.d1.com.cn/images2012/fkdzy/fkdzy_07_2.jpg">
		<div id="scrollDiv">
              <ul>
              <%
              ArrayList<LotWinAct> list=lotwinlist();
              if (list!=null)
              {
              for(LotWinAct be:list){ 
            	  String Lotwin8zn_uid="";
            	  if(be.getLotwin8zn_uid().length()>4){
            		  Lotwin8zn_uid=be.getLotwin8zn_uid().substring(0,4);
                	  }
                	  else{
                	   Lotwin8zn_uid=be.getLotwin8zn_uid();
                	  }

            	//String Lotwin8zn_uid=be.getLotwin8zn_uid().substring(0,4);
            	String Lotwin8zn_memo=be.getLotwin8zn_memo();
              %>
			  <li><%=Lotwin8zn_uid%>***&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%=Lotwin8zn_memo%></li>
      <%} }%>
			  </ul>
              </div>
			  <script>
function AutoScroll(obj){
$(obj).find("ul:first").animate({
marginTop:"-230px"
},200,function(){
//$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	for(i=1;i<=10;i++){
		$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
		}
	$(this).css({marginTop:"0px"})
});
}
$(document).ready(function(){
setInterval('AutoScroll("#scrollDiv")',5000)
});

</script>
		</td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="148" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="3" valign="top" background="http://images.d1.com.cn/images2012/fkdzy/fkdzy_08_3.jpg">
		
		<table width="100%" height="232" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" height="71">&nbsp;</td>
            <td width="98%">&nbsp;</td>
            <td width="1%">&nbsp;</td>
          </tr>
          <tr>
            <td height="34"></td>
            <td style="font-size:16px; font-weight:800">
            <%if (lUser!=null){
		float allpoint = UserScoreHelper.getRealScore(lUser.getId());//用户的总积分 %>
            <span class="jf2">您的现有积分</span>：<span class="jf1"><%=(int)allpoint%></span><%} %></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="100">&nbsp;</td>
            <td valign="top" align="left" style="line-height:18px; padding-left:18px;">
			<a href="znzhufu.jsp#add" target="_blank" style="font-size:14px; color:#FF0000;">送祝福得积分>></a><br />
<a href="indexp.jsp#tj" target="_blank" style="font-size:14px; color:#FF0000;">购物得积分>></a><br />
<a href="/user/" target="_blank" style="font-size:14px; color:#FF0000;">评论得积分>></a></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="127" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="/user/lotlist.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_09.jpg" width="220" height="41" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="41" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_10.jpg" width="220" height="238" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="238" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/fkdzy_11.jpg" width="980" height="55" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="55" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
		
<% request.setAttribute("code","7475");
		request.setAttribute("length","80");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   />
		</td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="1" height="212" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="158" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="48" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="222" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="332" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="220" height="1" alt=""></td>
		<td></td>
	</tr>
</table>

</center>
<%@include file="/inc/foot.jsp"%>

<map name="Map" id="Map"><area shape="rect" id="buttl" coords="16,2,92,34" href="#" onclick="CheckForm(this);"  /></map>
<map name="Map2" id="Map2"><area shape="rect" coords="32,7,191,38" href="/user/lotlist.jsp" target="_blank" />
</map>
<map name="Map3" id="Map3"><area shape="rect" coords="775,3,958,93" href="indexp.jsp#tj" target="_blank" />
</map>
<map name="Map4" id="Map4"><area shape="rect" coords="338,4,532,82" href="indexp.jsp#tj" target="_blank" />
</map></body>
</html>