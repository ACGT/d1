<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<AYPrize> getprizelist(){
	ArrayList<AYPrize> list=new ArrayList<AYPrize>();
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("prize_createdate"));
	List<BaseEntity> list2 = Tools.getManager(AYPrize.class).getList(null, listOrder, 0, 1000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((AYPrize)be);
	}
	return list; 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚奥运活动中奖信息</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
<!--
.STYLE1 {color: #373737}
 ul,li{margin:0;padding:0}
.scrollDiv{width:800px;line-height:18px;overflow:hidden;padding-top:4px;}
.scrollDiv li{height:22px;padding-left:4px;color:#525252;text-align:left;}
ul,li{ list-style:none;}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@include file="/inc/head.jsp" %>

  <center>
<!-- ImageReady Slices (奥运活动2-1.tif) -->
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_01.jpg" width="980" height="141" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_02.jpg" width="980" height="143" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_03.jpg" width="980" height="138" alt=""></td>
	</tr>
	<tr>
		<td height="753" valign="top" background="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_04.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="4%">&nbsp;</td>
            <td width="93%" class="STYLE1">
             <%
	ArrayList<AYPrize> list=getprizelist();
            
	if(list!=null && list.size()>0){
		 int totalLength = (list != null ?list.size() : 0);
         int PAGE_SIZE = 30 ;
  	    int currentPage = 1 ;
  	    String pg = request.getParameter("pageno");
  	    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
  	    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
  	 
  	    int end = pBean.getStart()+PAGE_SIZE;
  	    if(end > totalLength) end = totalLength;
  	  String ggURL = Tools.addOrUpdateParameter(request,null,null);
 	 if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
 		String orderURL =ggURL.replaceAll("pageno=[0-9]+","&");
 		orderURL = orderURL.replaceAll("&+", "&");
 		if(!orderURL.endsWith("&")) orderURL = orderURL + "&";
 	
 		String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
 		
  	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
  	    pageURL = pageURL.replaceAll("&+", "&");
  	  List<AYPrize> gList = list.subList(pBean.getStart(),end);
	   if(gList != null && !gList.isEmpty()){
		%>
		<div id="scrollDiv1" class="scrollDiv">
      <ul>
	<%

	for(AYPrize prize:gList){
		String uid=prize.getPrize_muid();
		if(StringUtils.getCnLength(uid)>=3){
			uid= "***"+StringUtils.getCnSubstring(uid,3,uid.length());
			if(StringUtils.getCnLength(uid)>=15){
				uid= "***"+StringUtils.getCnSubstring(uid,3,15);
			}
		}else{
			uid="***"+uid;
		}
			%>
			<li>
			<%=uid+":"+prize.getPrize_content() +"   获奖发布日期："+Tools.getDate(prize.getPrize_createdate())%>
		</li>
	<%
	
	}%>
	</ul>
	</div>
	 <div class="clear"></div>
	  <div style="hieght:10px;">&nbsp;</div>
	  <% if(pBean.getTotalPages()>1){
        	   //System.out.print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
           %>
           <div class="GPager">
           	<span style="">共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           			if(i==1)
           			{%>
           				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
           			<%}
           			else
           			{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		    }
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
           </div><%}
	   }}
	%> </td>
            <td width="3%">&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727oy/images/aywin_05.jpg" width="980" height="25" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
</center>
<div class="clear"></div>
   <%@include file="/inc/foot.jsp" %>
</body>
</html>