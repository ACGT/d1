<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %><%!

public static ArrayList<OrderItemBase> getYxfxList(String cardno,Date start,Date end){
	ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(cardno)){
		listRes.add(Restrictions.like("odrdtl_tuancardno", cardno+"%"));
	}
	listRes.add(Restrictions.ge("odrdtl_shipstatus",new Long(2)));
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if(start!=null&&start.toString().length()>0){	
		listRes.add(Restrictions.ge("odrdtl_creatdate", start));		   
	}
    
	if(end!=null&&end.toString().length()>0){
		listRes.add(Restrictions.le("odrdtl_creatdate", end));		
	}
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("odrdtl_creatdate"));
	List<BaseEntity> list2 = Tools.getManager(OrderItemCache.class).getList(listRes, listOrder, 0, 5000);
	if(list2!=null && list2.size()>0){
	for(BaseEntity be:list2){
		list.add((OrderItemCache)be);
	}
	}
	List<BaseEntity> list3 = Tools.getManager(OrderItemMain.class).getList(listRes, listOrder, 0, 5000);
	if(list3!=null && list3.size()>0){
		for(BaseEntity be:list3){
			list.add((OrderItemMain)be);
		}
		}
	List<BaseEntity> list4 = Tools.getManager(OrderItemRecent.class).getList(listRes, listOrder, 0, 1000);
	if(list4!=null && list4.size()>0){
		for(BaseEntity be:list4){
			list.add((OrderItemRecent)be);
		}
		}
	return list;
}




%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />

<style type="text/css">
td{
border-bottom:solid 1px #999999;
border-right:solid 1px #999999;
}
</style>
</head>
<body>
<center>

<%
if(session.getAttribute("wydhorderpwd")!=null)
{
	String wydhcode="";
	if(request.getParameter("sproduct")!=null&&request.getParameter("sproduct").length()>0){
		wydhcode=request.getParameter("sproduct");
	}
	else{  return;}
	float price=0f;
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String lsstar="";
	String lsend="";
	
	if(wydhcode.equals("mqwy1208nktxa")){
		price=25.0f;
	    lsstar="2012-8-22 00:00:00";
	    lsend="2012-9-21 23:59:59";
	    
	}
	else if(wydhcode.equals("mqwy1208ntx"))
	{
		price=19.9f;
		lsstar="2012-8-29 00:00:00";
		lsend="2012-9-20 23:59:59";
	}
	else if(wydhcode.equals("mqwyjf1209wdk"))
	{
		price=55.0f;
		lsstar="2012-9-16 00:00:00";
		lsend="2012-10-31 23:59:59";
	}
	else if(wydhcode.equals("mqwy1209pj")){
		price=25.0f;
		lsstar="2012-9-27 00:00:00";
		lsend="2012-10-31 23:59:59";
	}
	else if(wydhcode.equals("mqwyjf1209my")){
		price=55.0f;
		lsstar="2012-10-15 00:00:00";
		lsend="2012-10-29 23:59:59";
	}
	else if(wydhcode.equals("mqwyjf1210nb")){
		price=29.0f;
		lsstar="2012-10-22 00:00:00";
		lsend="2012-11-15 23:59:59";
	} 
	else if(wydhcode.equals("mqwyjf1210dk")){
		price=9.0f;
		lsstar="2012-11-07 00:00:00";
		lsend="2012-11-26 23:59:59";
	}	 
	else if(wydhcode.equals("mqwy1211mj")){
		price=79.0f;
		lsstar="2012-11-19 00:00:00";
		lsend="2012-11-30 23:59:59";
	}	 
	else if(wydhcode.equals("mq1211wyjfdk")){
		price=39.0f;
		lsstar="2012-11-27 00:00:00";
		lsend="2012-12-15 23:59:59";
	}	 
	else{
		price=10.0f;
    }
		
    String dhcardno=wydhcode;
    //获取日期
    String start=request.getParameter("txtbegin");
    String ends=request.getParameter("txtend");
    
    ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
    if(start.length()>0&&ends.length()<=0){
    	try{
    		Date lss=format.parse(lsstar);
    	    Date lse=format.parse(lsend);
    	    Date s=format.parse(start+" 00:00:00");
    	    if(s.before(lss)||s.after(lse)){
    	    	list= getYxfxList(dhcardno,lss,lse);
    	    }
    	   
    	    else
    	    {
    	    	list= getYxfxList(dhcardno,format.parse(start+" 00:00:00"),lse);
    	    }
    	
    	}catch(Exception ex){
    		
    	}
    }
    else if(start.length()<=0&&ends.length()>0){
    	try{
    		Date lss=format.parse(lsstar);
    	    Date lse=format.parse(lsend);
    	    Date e=format.parse(ends+" 00:00:00");
			 if(e.after(lse)||e.before(lss))
			 {
				 list= getYxfxList(dhcardno,lss,lse);
			 }
			
			 else
			 {
				 list= getYxfxList(dhcardno,lss,format.parse(ends+" 23:59:59"));
			 }
    	}catch(Exception ex){
    		
    	}
    }
    else if(start.length()>0&&ends.length()>0){
    	try{
    		Date lss=format.parse(lsstar);
    	    Date lse=format.parse(lsend);
    	    Date e=format.parse(ends+" 00:00:00");
    	    Date s=format.parse(start+" 00:00:00");
    	    if(s.before(lss))
    	    {
    	    	s=lss;
    	    }
    	    if(e.after(lse))
    	    {
    	    	e=lse;
    	    }
    	list= getYxfxList(dhcardno,s,e);
    	}catch(Exception ex){
    		System.out.print(ex);
    	}
    }
    else{
    	list= getYxfxList(dhcardno,null,null);
    }
    
    if(wydhcode.equals("mqwyjf1209my"))
    {
    	if(list!=null&&list.size()>0)
    	{
    		ArrayList<OrderItemBase> oiblist=new ArrayList<OrderItemBase>();
    		
    		for(OrderItemBase oib:list)
    		{
    			if(oib.getOdrdtl_gdsid()!=null&&oib.getOdrdtl_gdsid().length()>0&&(oib.getOdrdtl_gdsid().equals("03000152")
    					||oib.getOdrdtl_gdsid().equals("03000153")||oib.getOdrdtl_gdsid().equals("03000156")||oib.getOdrdtl_gdsid().equals("03000151")
    					||oib.getOdrdtl_gdsid().equals("03000155")||oib.getOdrdtl_gdsid().equals("03000154")))
    			{
    				oiblist.add(oib);
    			}
    		}
    		if(oiblist!=null&&oiblist.size()>0)
    		{
    			list.clear();
    			list.addAll(oiblist);
    		}
    	}
    }
    

    String ggURL = Tools.addOrUpdateParameter(request,null,null);
	if (ggURL!=null){
	  ggURL=ggURL.replace("wydhpwd=nktxa0824", "");
	}
	if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
	int totalLength = (list != null ?list.size() : 0);

    int PAGE_SIZE =50 ;
    int currentPage = 1 ;
	String pg = request.getParameter("pageno");
	if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
	PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
	
	int end = pBean.getStart()+PAGE_SIZE;
	if(end > totalLength) end = totalLength;
	String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
	
    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
    pageURL = pageURL.replaceAll("&+", "&");
    if(list!=null && list.size()>0){
	List<OrderItemBase> list2=list.subList(pBean.getStart(), end);
	%>
	<table id="__01" width="1114"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px; line-height:24px;">
	<tr><td width="50" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">序号</td>
	<td width="100" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">订单号</td>
	  <td width="150" style="border-top:solid 1px #999999;">兑换码</td>
	  <td width="160" style="border-top:solid 1px #999999;">订单日期</td>
	  <td width="100" style="border-top:solid 1px #999999;">商品编码</td>
	  <td style="border-top:solid 1px #999999;">商品名称</td>
	  <td style="border-top:solid 1px #999999;" width="100" ><span style="border:none;border-bottom:solid 1px #999999;">金额</span></td>
	</tr>
		<%
		float allmoney=0f;
		float yjallmoney=0f;
		long gdscount=0;
		long count=1;
		String uporderid="";
		gdscount=list.size();
		allmoney=gdscount*price;
		if (list2!=null){
		for(OrderItemBase base:list2){
			OrderBase ofx=OrderHelper.getById(base.getOdrdtl_odrid());
			if(ofx!=null&&ofx.getOdrmst_orderstatus().longValue()>=1){
			%>
			<tr><td style="border-left:solid 1px #999999;"><%=((currentPage-1)*50+count) %></td>
			<td style="border-left:solid 1px #999999;"><%=base.getOdrdtl_odrid() %></td>
			  <td><%=base.getOdrdtl_tuancardno() %></td>
			  <td><%=format.format(base.getOdrdtl_creatdate()) %></td>
			  <td><%=base.getOdrdtl_gdsid() %></td>
		      <td><%=Tools.clearHTML(base.getOdrdtl_gdsname()) %></td>
		      <td><span style="border:none;border-bottom:solid 1px #999999;"><%=Tools.getDouble(price,2) %></span></td>
		  </tr>
		<% count++;
		  }
		}}%>
	<tr><td colspan="6" height="30" style="border:none;">&nbsp;</td></tr>
	</table>
	<%     allmoney=Tools.getFloat(allmoney,2);
	       if(wydhcode.equals("mqwy1208nktxa")||wydhcode.equals("mqwy1208ntx")){
		    yjallmoney=allmoney*0.05f;
	       }        
	      else{
		    yjallmoney=allmoney*0.2f;
	       }			
			yjallmoney=Tools.getFloat(yjallmoney,2);
            if(pBean.getTotalPages()>0){
        	 %>
           <div class="GPager">
           	<span style="color:#919191">商品数：<span class="rd"><%=gdscount %></span>&nbsp;&nbsp;总金额：<span class="rd"><%=allmoney %></span>&nbsp;&nbsp;总佣金：<span class="rd"><%=yjallmoney %></span>&nbsp;&nbsp;&nbsp;&nbsp;共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
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
           </div>
           <%}
}
%>
<div style="height:50px;">&nbsp;</div>
<%  }
if(session.getAttribute("wydhorderpwd")==null){ %>
<div style="height:100px;">&nbsp;</div>
<form id="wydhorder" method="post" action="wydhorderlist.jsp">
<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cccccc" style="line-height:28px;">
  <tr>
    <td width="27%" bgcolor="#FFFFFF">密码：</td>
    <td width="73%" bgcolor="#FFFFFF"><input type="password"  id="wydhpwd" name="wydhpwd"></td>
  </tr>
  
  <tr>
    <td bgcolor="#FFFFFF">&nbsp;</td>
    <td bgcolor="#FFFFFF"><input type="submit" value="登陆"/>&nbsp;</td>
  </tr>
</table>
</form>
<%} 
%>
</center>
</body>
</html>