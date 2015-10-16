<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!
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
				    $.inCart(obj,{ajaxUrl:'/ajax/flow/rosedhInCard.jsp',width:400,align:'center'});
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

.banner328 {
background-image: url(http://images.d1.com.cn/market/1404/wycj.jpg);
background-repeat: no-repeat;
background-position: center;
height: 311px;
}
.topbannerdiv{	position:relative; width:980px; height:311px; margin: 0px auto;}
.topbannerdiv .link1{ position:absolute;  width:250px; height:311px; bottom:0; left:0px; }
.topbannerdiv .link2{ position:absolute;  width:320px; height:311px; bottom:0; left:660px; }

-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div class="banner328">
  <div class="topbannerdiv">
   <a href="http://www.d1.com.cn/product/05002653" target="_blank"><div class="link1"></div></a>
     <a href="http://www.d1.com.cn/product/01205712" target="_blank"><div class="link2"></div></a>
    </div>
</div>
<center>
<table id="__01" width="980"   border="0" align="center" cellpadding="0" cellspacing="0">
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

</center>
<%@include file="/inc/foot.jsp" %>


</body>
</html>
