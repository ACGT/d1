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
%><% Tools.setCookie(response,"rcmdusr_rcmid","114",(int)(Tools.DAY_MILLIS/1000*1));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网 龙年转大运-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function CheckForm(obj){
	var code=$('#tlcard').val();
	  if (code == ""){
			$.alert('请填写台历券!');
	        return;
	    }
    $.post("/ajax/flow/tlcardget.jsp",{"code":code},function(json){
		if(json.success){
			$.alert(json.message);
			$('#tlcard').val(" "); 
			}
		else{
			$.alert(json.message);
		}
	},"json");
    
}
</script>
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
#scrollDiv{width:200px;height:220px;line-height:21px;overflow:hidden}
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
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="981" height="1000" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_01.jpg" width="980" height="179" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="179" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_02.jpg" width="206" height="111" alt=""></td>
		<td width="554" height="537" rowspan="5" background="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_03.jpg">
 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="530" height="530">
  <param name="movie" value="lncdjnew.swf" />
  <param name="quality" value="high" />
   <param name="wmode" value="transparent">
  <embed src="lncdjnew.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="530" height="530"></embed>
</object></td>
		<td width="220" height="270" rowspan="3" valign="top" background="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_04.jpg"><table width="220" height="273" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="22" height="37" rowspan="2">&nbsp;</td>
            <td height="13" colspan="2">&nbsp;</td>
            <td width="20" rowspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td width="73" height="27">中奖者</td>
            <td width="105">奖品</td>
          </tr>
          <tr>
            <td height="228">&nbsp;</td>
            <td colspan="2" valign="top">
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
marginTop:"-46px"
},200,function(){
$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
});
}
$(document).ready(function(){
setInterval('AutoScroll("#scrollDiv")',5000)
});

</script>
			</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="111" alt=""></td>
	</tr>
	<tr>
		<td width="206" height="37" background="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_05-1.jpg">&nbsp;&nbsp;&nbsp;<input type="text" name="tlcard" id="tlcard" class="tlput" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="37" alt=""></td>
	</tr>
	<tr>
		<td rowspan="3">
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_06-3.jpg" alt="" width="206" height="389" border="0" usemap="#Map"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="127" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_07.jpg" alt="" width="220" height="41" border="0" usemap="#Map2"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="41" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_08.jpg" width="220" height="221" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="221" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_09.jpg" width="980" height="65" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="65" alt=""></td>
	</tr>
	<tr>
		<td height="41" colspan="3"><%
		request.setAttribute("reccode","7274");
		request.setAttribute("dxcode","114");
		request.setAttribute("length","30");


		%><jsp:include   page= "../../gdsrecdx.jsp"   />
		</td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="41" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/lndzp_11.jpg" width="980" height="54" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="54" alt=""></td>
	</tr>
	<tr>
		<td height="124" colspan="3"><% request.setAttribute("code","7275");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226lndzy/分隔符.gif" width="1" height="124" alt=""></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>

<map name="Map" id="Map"><area shape="rect" id="buttl" coords="16,2,92,34" href="#" onclick="CheckForm(this);"  /></map>
<map name="Map2" id="Map2"><area shape="rect" coords="32,7,191,38" href="/user/lotlist.jsp" target="_blank" />
</map></body>
</html>