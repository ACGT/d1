<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
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
					var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("选择商品",400,"choosesku.jsp?code="+code);
				
				}else if(json.code==2){
					 $('#imageField').attr('attr',code);
					    $.inCart(obj,{ajaxUrl:'ppsInCard1.jsp',width:400,align:'center'});
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
<table id="__01" width="980"  align="center"  border="0" cellpadding="0" cellspacing="0">
	   <%
	  StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode("3254" , (int)21);
	if(recommendList != null && !recommendList.isEmpty()){
		%>
	<tr>
	  <td colspan="7">
	
	  <table width="980"  border="0" cellpadding="0" cellspacing="0">
	<% int i=0;
		for(Promotion p:recommendList)
		{
			if (i==0 || (float)i/3==(int)i/3){
			sb.append("<tr>");
			}
			sb.append("<td width=\"326\"><a href=\"")
				.append(p.getSplmst_url().trim()).append("\">")
				.append("<img src=\"").append(p.getSplmst_picstr()==null?"":p.getSplmst_picstr()).append("\"  border=\"0\" />")
				.append("</a></td>");
			i++;
          if ((float)i/3==(int)i/3){
			sb.append("</tr>");
			}
			
  }
		if ((float)i/3!=(int)i/3){
			  for(int k=1;k<=(3-(i%3));k++){
				  sb.append("<td></td>"); 
			  }
			  sb.append("</tr>");
		  }
  out.print(sb.toString());
 
  %>
</table>

</td>
  </tr>
  <%
	
	}
	  %>
		<td colspan="7">
			<img src="http://images.d1.com.cn/market/1202/cftdh/cftdh_04.jpg" width="980" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1202/cftdh/cftdh_05.jpg" width="354" height="59" alt=""></td>
		<td colspan="3" background="http://images.d1.com.cn/market/1202/cftdh/cftdh_06.jpg"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs"></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1202/cftdh/cftdh_07.jpg" width="368" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1202/cftdh/cftdh_08.jpg" width="369" height="44" alt=""></td>
		<td>
		<input type="image" name="imageField" id=imageField onclick="CheckForm(this);" src="http://images.d1.com.cn/market/1202/cftdh/cftdh_09.jpg">	
			</td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1202/cftdh/cftdh_10.jpg" width="420" height="44" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/market/1202/cftdh/cftdh_11.jpg" width="980" height="27" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="313" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="41" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="15" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="191" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="52" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="22" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/cftdh/分隔符.gif" width="346" height="1" alt=""></td>
	</tr>
</table>
<%@include file="/inc/foot.jsp" %>
</body>
</html>