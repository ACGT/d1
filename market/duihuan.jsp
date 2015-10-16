<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/dh/listCart.js")%>"></script>
<script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>
 
if(checkMobile()){
	window.location.href="http://m.d1.cn/wap/dh.html";
}
 
</script>
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
				var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("选择商品",400,"chooseskunew.jsp?code="+code);
			
			}else if(json.code==2){
				 $('#imageField').attr('attr',code);
				    $.inCart(obj,{ajaxUrl:'/ajax/flow/dhInCart.jsp',width:400,align:'center'});
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
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_07.jpg" width="980" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_08.jpg" width="344" height="67" alt=""></td>
		<td colspan="3" background="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_09.jpg"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs"></td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_10.jpg" width="383" height="67" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="3">
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_11.jpg" width="371" height="88" alt=""></td>
		<td colspan="5">
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_12.jpg" width="609" height="14" alt=""></td>
	</tr>
	<tr>
		<td><input type="image" name="imageField" id=imageField onclick="CheckForm(this);" src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_13.jpg">			</td>
		<td colspan="4" background="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_14.jpg">
		
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/dddh1202_15.jpg" width="609" height="24" alt=""></td>
	</tr>
	    <%
	  StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList =null;
			//PromotionHelper.getBrandListByCode("2856" , (int)50);
	if(recommendList != null && !recommendList.isEmpty()){
		%>
	<tr>
	  <td colspan="9">
	
	  <table width="980" height="19" border="0" cellpadding="0" cellspacing="0">
	<% int i=0;
		for(Promotion p:recommendList)
		{
			if (i==0 || (float)i/3==(int)i/3){
			sb.append("<tr>");
			}
			sb.append("<td width=\"326\" ><a href=\"")
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
	
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="326" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="17" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="199" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="85" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/dangdangdh/分隔符.gif" width="296" height="1" alt=""></td>
	</tr>
</table>
<%@include file="/inc/foot.jsp" %>
</body>
</html>