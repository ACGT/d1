<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
 static ArrayList<TaiLi2012> getexist(String cardno){
	ArrayList<TaiLi2012> rlist = new ArrayList<TaiLi2012>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("taili2012_cardno",cardno));
	List<BaseEntity> list = Tools.getManager(TaiLi2012.class).getList(clist, null, 0, 1);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((TaiLi2012)be);
	}
	return rlist ;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>0利润 百款商品底价出售-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">

</style>
<script type="text/javascript">
$(document).ready(function() {
  // if($.trim($("#v").val())==0){
	 //  $("#trdx").hide();
  // }else{
//	   $("#trdx").show();
  // }
});
function getdx(){
var tailino=$("#tailino").val();
if(tailino!=null){
	var tlen=$.trim(tailino);
	if(tlen==0){
		$.alert("请输入台历号_4");
		}else{
		if(tailino.indexOf("_4")<0){
			$.alert("您输入错误，请输入台历号_4");	
		}else{
			$.ajax({
                type: "post",
                dataType: "text",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                url: "function.jsp",
                cache: false,
                data:{
               	 zf: "1",
               	tailino: tailino
    		      },error: function(XmlHttpRequest, textStatus, errorThrown){
                  //  $.alert('修改信息失败！');
                },success: function(msg){
                	//alert(msg);
                	 if(msg==0){
                		$.alert("您输入的台历号不存在，请重新输入");
                	 }
                	 else if(msg==1){
                		// $("#v").val("1");
                		// $("#trdx").show();
                		 $("#form1").submit();
                	 }
                }
                })
		}	
		}
	}
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<input type="hidden"  id="v"></input>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%
String no="";
String backurl = request.getHeader("referer");
int view=0;

	if(!Tools.isNull(request.getParameter("tailino")) && backurl.indexOf("index.jsp")>0){
		no=request.getParameter("tailino");
		ArrayList<TaiLi2012> list=getexist(no.replace("_4", "_1"));
		if(list!=null && list.size()>0){
			view=1;
		}
	}

%>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_01.jpg" width="980" height="126" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_02.jpg" width="980" height="163" alt=""/></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_03.jpg" width="191" height="52" alt=""/></td>
		<td style="background:url(http://images.d1.com.cn/zt2012/taili1204/images/tl_04.jpg); border:0px;width:112px; height:52px;" valign="top">
			<div style="padding-top:20px; padding-bottom:5px;">
			<form action="index.jsp" method="post" id="form1" name="form1">
			<input type="text" id="tailino" name="tailino" style="width:100px; height:22px;border: 1px solid #CCCCCC;" value="<%=no%>"></input>   
			</form>
			</div>
			
			</td>
		<td>
			<a href="javascript:getdx();"><img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_05.jpg" width="129" height="52" alt="" border="0"/></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_06.jpg" width="548" height="52" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_07-1.jpg" width="980" height="42" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/taili1204/images/tl_08.jpg" width="980" height="15" alt=""/></td>
	</tr>
		<tr id="trdx">
		<td colspan="4" valign="top">
	<%
	if(view==1){
		//out.print(">>>>>>>>>>>>>>>>>>>>");
	 Tools.setCookie(response,"rcmdusr_rcmid","147",(int)(Tools.DAY_MILLIS/1000*1));
		request.setAttribute("reccode","7548");
		request.setAttribute("dxcode","147");
		request.setAttribute("length","30");
%><jsp:include   page= "/html/gdsrecdx.jsp"   />
	<%}else{
		request.setAttribute("reccode","7548");
		request.setAttribute("length","30");
%><jsp:include   page= "/html/gdsrecdx.jsp"   />
	<%}
	%>
	</td>
	</tr>
	
</table>

</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>