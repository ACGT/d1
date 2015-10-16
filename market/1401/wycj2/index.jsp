<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%Tools.setCookie(response,"rcmdusr_rcmid","110",(int)(Tools.DAY_MILLIS/1000*1)); %><%!
public static String Getp2013img(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 20);
	if(list!=null&&list.size()>0)
	{
		for(Promotion p:list)
		{
			if(p!=null)
			{
				
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" />");
				sb.append("</a>");
				
			}
		}
	}
	return sb.toString();
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function test(t){ 
	var i=1; 
	t.disabled=true; 
	CheckForm(t);
	var timer=setInterval(function(){i++;
	if(i>2){t.disabled=false;i=1;t.value="test";clearInterval(timer)}},1000) 
	} 
function CheckForm(obj){
	var code=$('#gdsdh_code').val();
	  if (code == ""){
			$.alert('请填写兑换码!');
	        return;
	    }
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/market/choosecart.jsp',
		cache: false,
		data: {id:code},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.code==1){
				$.alert(json.message);
			}else if(json.code==0){
				$.close(); 
				var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace

("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("选择商品",400,"choosesku.jsp?code="+code+"&gdsid="+json.message);
			
			}else if(json.code==2){
				 $('#imageField').attr('attr',code);
				    $.inCart(obj,{ajaxUrl:'dhInCard.jsp',width:400,align:'center'});
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>
<style type="text/css">
<!--
.cardnocs {
	border: 1px solid #CCCCCC;
	height: 36px;
	width: 240px;
	line-height:36px;
	font-size:18px;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980"   border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="7">
			 <a href="http://www.d1.com.cn/product/03300029" target="_blank" /><img src="http://images.d1.com.cn/market/1401/wycjbz.jpg" width="980" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_09.jpg" width="980" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_10.jpg" width="354" height="59" alt=""></td>
		<td colspan="3" background="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_11.jpg">
      <input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs"></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_12.jpg" width="368" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_13.jpg" width="369" height="44" alt=""></td>
		<td><input type="image" name="imageField" id=imageField onclick="test(this);" 

src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_14.jpg">
	  </td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_15.jpg" width="420" height="44" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/market/1205/wycj/wycjdh1205_16.jpg" width="980" height="27" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="353" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="15" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="191" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="52" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="367" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1205/wycj/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
</table>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1305/wydh/wydh_05.jpg" width="980" height="75" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" background="http://images.d1.com.cn/market/1305/wydh/wydh_06.jpg">
			<%
		request.setAttribute("reccode","8613");
		request.setAttribute("dxcode","110");
		request.setAttribute("length","50");


		%>		
		<jsp:include   page= "/html/gdsrecdx.jsp"   /></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1305/wydh/wydh_07.jpg" width="980" height="75" alt=""></td>
	</tr>
	<tr>
		<td colspan="2"  background="http://images.d1.com.cn/market/1305/wydh/wydh_08.jpg">
			<div style="white-space:normal; word-break:break-all;width:980px;"><%String strxls=Getp2013img("3395");
			out.print(strxls); %> </div></td>
	</tr>
</table>
<map name="Map" id="Map"><area shape="poly" coords="357,196" href="#" /></map>
<map name="Map3" id="Map3">
  <area shape="rect" coords="657,4,961,153" href="http://www.d1.com.cn/product/01719955" target="_blank" />
</map>
</center>
<%@include file="/inc/foot.jsp" %>


</body>
</html>
