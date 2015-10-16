<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
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
<title>网易抽奖-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="http://mimg.127.net/xm/all/point_club/110622/css/style.css"		rel="stylesheet" type="text/css"/>
<link href="http://mimg.127.net/xm/all/point_club/progress/medaltalent/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<style>
.cardnotxt {
height: 27px;
_height: 24px;
width: 200px;
border: 2px ridge #CC0000;
vertical-align: middle;
background: #FFE7E7;
font-size: 16px;
}
</style>
<script type="text/javascript">
function chooseg(t,gid){ 
	var i=1; 
	t.disabled=true; 
	CheckForm(t,gid);
	var timer=setInterval(function(){i++;
	if(i>2){t.disabled=false;i=1;t.value="test";clearInterval(timer)}},1000) 
	} 
function CheckForm(obj,gid){
	var code="";
	if(gid==1){
	 code=$('#cardno').val();
	}else{
		code=$('#cardno2').val();
	}
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

("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("选择商品",500,"choosesku.jsp?code="+code+"&gdsid="+json.message+"&gid="+gid);
			
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

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<center>
<table id="__01" width="980" height="561" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1305/wydh/wydh_01.jpg" width="980" height="97" alt=""></td>
	</tr>
	<tr>
		<td width="490"><a href="http://www.d1.com.cn/product/01517598" target="_blank"><img src="http://images.d1.com.cn/market/1306/wydh/duihuan_02.jpg" width="490" height="201" alt="" border="0"></a></td>
		<td width="490" rowspan="2">
			<a href="http://www.d1.com.cn/zhuanti/201305/fm0528/" target="_blank"><img src="http://images.d1.com.cn/market/1306/wydh/duihuan_04.jpg" width="490" height="275"></a></td>
	</tr>
	<tr>
		<td height="77" background="http://images.d1.com.cn/market/1305/wydh/wydh_04.jpg"><table width="490" height="77" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="2%" height="39">&nbsp;</td>
            <td width="18%" align="right">请输入兑换码：</td>
            <td width="29%" align="left"><input name="cardno" type="text" id="cardno" class="cardnotxt"></td>
            <td width="1%">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2" align="center" valign="top"><input type="image" id="imageField" name="imageField" src="http://images.d1.com.cn/market/1305/wydh/dhan_06.jpg"  onclick="chooseg(this,1);" ></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
    </tr>
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
		<td colspan="2" background="http://images.d1.com.cn/market/1305/wydh/wydh_08.jpg">
			<%String strxls=Getp2013img("3395");
			out.print(strxls); %> </td>
	</tr>
	</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
