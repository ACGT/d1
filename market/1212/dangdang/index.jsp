<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private ArrayList<LotWinAct> lotwinlist(){
	ArrayList<LotWinAct> list=new ArrayList<LotWinAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> lotlist= Tools.getManager(LotWinAct.class).getList(null, olist, 0, 100);
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
<title>当当客户幸运抽奖页面-D1优尚网</title>
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
#scrollDiv{width:320px;height:300px; margin-top:8px;line-height:21px;overflow:hidden}
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
.cardno {
	height: 26px;
	width: 180px;
	border: 1px solid #CCCCCC;
}
-->
</style>
<script type="text/javascript">
function CheckForm(obj){
	var code=$('#cardno').val();
	  if (code == ""){
			$.alert('请填写抽奖码!');
	        return;
	    }
    $.post("wycjcard.jsp",{"code":code},function(json){
		if(json.success){
			$.alert(json.message);
			$('#cardno').val(" "); 
			}
		else{
			$.alert(json.message);
		}
	},"json");
    
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="1501" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_01.jpg" width="980" height="247" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_02.jpg" width="442" height="31" alt=""></td>
		<td colspan="3"><input type="text" name="cardno" id="cardno" class="cardno" />
			</td>
		<td colspan="2">
		<input type="image" name="imageField" src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_04.jpg"  onclick="CheckForm(this);" />
		</td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_05.jpg" width="245" height="31" alt=""></td>
	</tr>
	<tr>
		<td height="569" style="padding-left:25px;padding-top:10px;" colspan="4" background="http://images.d1.com.cn/market/1212/dangdang/ddcj2_06.jpg">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="530" height="530">
  <param name="movie" value="ddcj.swf" />
  <param name="quality" value="high" />
   <param name="wmode" value="transparent">
  <embed src="ddcj.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="530" height="530"></embed>
</object>		</td>
		<td colspan="4" background="http://images.d1.com.cn/market/1212/dangdang/ddcj2_07.jpg">
		 <table width="417" height="565" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="45" height="213">&nbsp;</td>
              <td width="326">&nbsp;</td>
              <td width="46">&nbsp;</td>
            </tr>
            <tr>
              <td height="302">&nbsp;</td>
              <td valign="top"><div id="scrollDiv">
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
            	if(be.getLotwin8zn_winid()!=null&&(be.getLotwin8zn_winid().longValue()==7||be.getLotwin8zn_winid().longValue()==8)){
              %>
              
			  <li><span style="color:#C00000"><%=Lotwin8zn_uid%>***&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%=Lotwin8zn_memo%></span></li>
      <%}else{ %>
       <li><%=Lotwin8zn_uid%>***&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%=Lotwin8zn_memo%></li>
      <%}} }%>
			  </ul>
              </div>
			  <script>
function AutoScroll(obj){
$(obj).find("ul:first").animate({
marginTop:"-230px"
},288,function(){
//$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	for(i=1;i<=13;i++){
		$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
		}
	$(this).css({marginTop:"0px"})
});
}
$(document).ready(function(){
setInterval('AutoScroll("#scrollDiv")',5000)
});

</script></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="50">&nbsp;</td>
              <td valign="top"></td>
              <td>&nbsp;</td>
            </tr>
          </table>	
		</td>
	</tr>
	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_08.jpg" width="980" height="66" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_09.jpg" width="247" height="287" alt=""></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_10.jpg" alt="" width="240" height="287" border="0"></td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_11.jpg" width="243" height="287" alt=""></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/03300070" target="_blank"><img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_12.jpg" alt="" width="250" height="287" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_13.jpg" width="247" height="287" alt=""></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01516804" target="_blank"><img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_14.jpg" alt="" width="240" height="287" border="0"></a></td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_15.jpg" width="243" height="287" alt=""></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01517474" target="_blank"><img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_16.jpg" alt="" width="250" height="287" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/market/1212/dangdang/ddcj2_17.jpg" width="980" height="13" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="247" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="195" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="45" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="76" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="81" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="86" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1212/dangdang/分隔符.gif" width="245" height="1" alt=""></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>