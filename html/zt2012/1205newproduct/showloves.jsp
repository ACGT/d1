<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<Userlove> getlovelist(String loveno){
	ArrayList<Userlove> list=new ArrayList<Userlove>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("loveno", new Long(loveno)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("createdate"));
	List<BaseEntity> list2 = Tools.getManager(Userlove.class).getList(listRes, listOrder, 0, 1000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((Userlove)be);
	}
	return list; 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>喜欢的理由预览-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">

</script>
<style type="text/css">

  ul,li{margin:0;padding:0}
.scrollDiv{width:950px;height:300px;line-height:18px;overflow:hidden}
.scrollDiv li{height:100px;padding-left:4px;color:#525252;text-align:left}
ul,li{ list-style:none;}

</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%
String loveno=request.getParameter("loveno");
if(Tools.isNull(loveno)){
	out.print("参数错误");
	return;
}
if(!Tools.isNumber(loveno)){
	out.print("参数错误");
	return;
}
%>
		<div style="padding-top:30px; padding-left:15px; padding-right:15px;">
	<table style="border:none;" cellpadding="0" cellspacing="0">
<tr> <td colspan="2" align="left"><span style="font-size:22px; color:#666666; font-weight:bold;">来看看大家对<%=loveno %>号商品的热议吧</span></td></tr>
	<tr> <td colspan="2" style="border-bottom:solid 1px #FE8f9C; width:100%;">&nbsp;</td></tr>
	<tr><td height="10px;" >&nbsp;</td></tr>
	
	
	<tr> <td colspan="2">
	<%
	ArrayList<Userlove> list=getlovelist(loveno);
	if(list!=null && list.size()>0){
		%>
		<div id="scrollDiv1" class="scrollDiv">
      <ul>
	<%
	int i=1;
	for(Userlove love:list){
		String uid=UserHelper.getById(love.getUserid()).getMbrmst_uid();
		if(StringUtils.getCnLength(uid)>=3){
			uid= "***"+StringUtils.getCnSubstring(uid,3,uid.length());
			if(StringUtils.getCnLength(uid)>=15){
				uid= "***"+StringUtils.getCnSubstring(uid,3,15);
			}
		}else{
			uid="***";
		}
		String pid=love.getProductid();
		String pname="";
		Product p=ProductHelper.getById(pid);
		if(p!=null){
		pname=Tools.clearHTML(p.getGdsmst_gdsname());	
		}
		if(StringUtils.getCnLength(uid)<8){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,50)+"...";
		}
		if(StringUtils.getCnLength(uid)>10){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,42)+"...";
		}if(StringUtils.getCnLength(uid)>14){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,36)+"...";
		}
		if(i%2==1){
			%>
			<li>
			<div style="float:left;">
	 <%}else{%>
		<div style="float:right;">
		<%} %>
		 <table style="border:none;" cellpadding="0" cellspacing="0">
	  <tr>	 <td align="left" style="color:#666666;"><%=uid %>喜欢  <span style="color:#FE8F9C;font-weight:bold;font-size:13px;"><%=love.getLoveno() %>号</span>  <a href="/product/<%=pid%>"><%=pname %></a> </td></tr>
	<tr> <td align="left" valign="top" style="background :url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_179.jpg) no-repeat; height:61px; width:454px;">
	
	<div style="padding-top:20px; padding-left:25px; color:#FFFFFF;"><%=StringUtils.getCnSubstring(Tools.clearHTML(love.getLovecontent()), 0, 140)  %></div>
	</td></tr>
	  </table>	
		</div>
		
	<%
	if(i%2==0){%>
		</li>
	<%}
	i++;
	}%>
	</ul>
	</div>
	<%}
	%>
	
	 
	</td></tr>
	
	</table>
	</div>
	<div class="clear"></div>

</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>