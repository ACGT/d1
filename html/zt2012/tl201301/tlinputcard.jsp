<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	   	 dStartDate =fmt.parse("2013-02-01");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,message:\"该台历券兑换已经过期！\"}");
	return;
}
String gdsid=request.getParameter("gdsid");
if(Tools.isNull(gdsid)){
	out.print("{\"success\":false,message:\"参数错误！\"}");	
	return;
}
if(!"01721234".equals(gdsid) && !"01415776".equals(gdsid)){
	out.print("{\"success\":false,message:\"参数错误！\"}");	
	return;
}
Product product=ProductHelper.getById(gdsid);
if(product==null){
	out.print("{\"success\":false,message:\"参数错误！\"}");	
	return;
}
%>

<script>

function checkcard(obj){
	var gdsid=$.trim($("#hgdsid").val());
	var tailino=$("#tailino").val();
	if(gdsid.length==0){
		$.alert("参数错误");
		return;
	}else if(gdsid!="01721234" && gdsid!="01415776"){
		$.alert("参数错误");
		return;
	}
	if(tailino!=null){
		var tlen=$.trim(tailino);
		if(tlen==0){
			$.alert("请输入台历号_1");
			}else{
			if(tailino.indexOf("_1")<0){
				$.alert("您输入错误，请输入台历号_1");	
			}else{
	            $.close();
	            $.inCart(obj,{ajaxUrl:'/html/zt2012/tl201301/tlincart.jsp?tailino='+tailino,width:400,align:'center'});
			}	
			}
		}
}
</script>

 <div class="form">
 <input type="hidden" id="hgdsid" value="<%=request.getParameter("gdsid")%>" />
<table cellpadding="0" cellspacing="0" >
<tr>
<td height="20px">&nbsp;</td>
</tr>
<tr><td align="center" valign="middle">请输入台历号：
<input type="text" id="tailino" name="tailino" style="width:120px; height:22px;border: 1px solid #CCCCCC;" ></input> 
</td><td align="center" width="120">
<a href="javascript:void(0)" attr="<%=request.getParameter("gdsid")%>" onclick="checkcard(this);" ><img src="http://images.d1.com.cn/images2012/New/user/sure.jpg" border="0"/></a>
</td></tr>


</table>
</div>
