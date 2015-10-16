<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<OrderCache> getOrderCacheList(String odrmst_subad,String cardno,Date s,Date e){
	ArrayList<OrderCache> list=new ArrayList<OrderCache>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(cardno)){
		listRes.add(Restrictions.like("odrmst_cardmemo", cardno+"%"));
	}
	if(s!=null){
		listRes.add(Restrictions.ge("odrmst_orderdate", s));	
	}
	if(e!=null){
		listRes.add(Restrictions.le("odrmst_orderdate", e));
	}
	listRes.add(Restrictions.like("odrmst_subad", odrmst_subad+"%"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("odrmst_orderdate"));
	List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, listOrder, 0, 2000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderCache)be);
	}
	return list;
}
public static ArrayList<OrderMain> getOrderMainList(String odrmst_subad,String cardno,Date s,Date e){
	ArrayList<OrderMain> list=new ArrayList<OrderMain>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(cardno)){
		listRes.add(Restrictions.like("odrmst_cardmemo", cardno+"%"));
	}
	if(s!=null){
		listRes.add(Restrictions.ge("odrmst_orderdate", s));	
	}
	if(e!=null){
		listRes.add(Restrictions.le("odrmst_orderdate", e));
	}
	listRes.add(Restrictions.like("odrmst_subad", odrmst_subad+"%"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("odrmst_orderdate"));
	List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, listOrder, 0, 2000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderMain)be);
	}
	return list;
}
public static ArrayList<OrderRecent> getOrderRecentList(String odrmst_subad,String cardno,Date s,Date e){
	ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(cardno)){
		listRes.add(Restrictions.like("odrmst_cardmemo", cardno+"%"));
	}
	if(s!=null){
		listRes.add(Restrictions.ge("odrmst_orderdate", s));	
	}
	if(e!=null){
		listRes.add(Restrictions.le("odrmst_orderdate", e));
	}
	listRes.add(Restrictions.like("odrmst_subad", odrmst_subad+"%"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("odrmst_orderdate"));
	List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, listOrder, 0, 2000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderRecent)be);
	}
	return list;
}
public static ArrayList<OrderBase> getOrderList(String odrmst_subad,String cardno,Date s,Date e){
	ArrayList<OrderBase> list=new ArrayList<OrderBase>();
	ArrayList<OrderCache> listcache=getOrderCacheList(odrmst_subad, cardno,s,e);
	if(listcache!=null){
		for(OrderCache ordercache:listcache){
			list.add(ordercache);
		}
	}
	ArrayList<OrderMain> listmain=getOrderMainList(odrmst_subad, cardno,s,e);
	if(listmain!=null){
		for(OrderMain ordermain:listmain){
			list.add(ordermain);
		}
	}
	ArrayList<OrderRecent> listrecent=getOrderRecentList(odrmst_subad, cardno,s,e);
	if(listrecent!=null){
		for(OrderRecent orderrecent:listrecent){
			list.add(orderrecent);
		}
	}
	if(list==null || list.size()==0){
		return null;
	}
	Collections.sort(list,new OrderTimeComparator());
	return list;
}
static String getstatus(int status){
	String orderstauts="";
	switch(status){
	case 0:
		orderstauts="未处理";
		break;
	case 1:
		orderstauts="货付已确认";
		break;
	case 2:
		orderstauts="已到款";
		break;
	case 3:
		orderstauts="全部发货";
		break;
	case 31:
		orderstauts="部分发货";
		break;
	case 5:
		orderstauts="全部交易完成";
		break;
	case 51:
		orderstauts="部分交易完成";
		break;
	case 6:
		orderstauts="系统设置全部交易完成";
		break;
	case 61:
		orderstauts="系统设置部分交易完成";
		break;
	case -1:
		orderstauts="用户取消";
		break;
	case -2:
		orderstauts="缺货取消";
		break;
	default:
		orderstauts="用户取消";
		break;
	}
	return orderstauts;
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
String odrmst_subad=request.getParameter("subad");
String ticketno=request.getParameter("ticketno");
String start_time=request.getParameter("start_time");
String end_time=request.getParameter("end_time");
if(Tools.isNull(odrmst_subad)){
	out.print("subad错误!");
	return;
}
if( (!odrmst_subad.startsWith("mqjs")) && (!odrmst_subad.startsWith("mqydyh"))){
	out.print("subad错误!");
	return;
}
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

Date s=null;
Date e=null;
if(!Tools.isNull(start_time)){
	if(Tools.isNumber(start_time)){
		start_time = start_time.substring(0, 4) + "-" + start_time.substring(4, 6) + "-" + start_time.substring(6, 8) + " 00:00:00";
	}
		try{
			s=format.parse(start_time);
		}catch(Exception ex){
			out.print("start_time格式错误");
			return;
		}
	
}
if(!Tools.isNull(end_time)){
	if(Tools.isNumber(end_time)){
		end_time = end_time.substring(0, 4) + "-" + end_time.substring(4, 6) + "-" + end_time.substring(6, 8) + " 23:59:59";
	}
	try{
		e=format.parse(end_time);
	}catch(Exception ex){
		out.print("end_time格式错误");
		return;
	}
}

ArrayList<OrderBase> list= getOrderList(odrmst_subad,ticketno,s,e);
String ggURL = Tools.addOrUpdateParameter(request,null,null);
if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
int totalLength = (list != null ?list.size() : 0);

int PAGE_SIZE = 30 ;
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
	List<OrderBase> list2=list.subList(pBean.getStart(), end);
	%>
	<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px; line-height:24px;">
	<tr><td style="border-top:solid 1px #999999;border-left:solid 1px #999999;">订单号</td><td style="border-top:solid 1px #999999;">订单日期</td><td style="border-top:solid 1px #999999;">订单金额</td><td style="border-top:solid 1px #999999;">优惠券金额</td><td style="border-top:solid 1px #999999;">实际支付金额</td><td style="border-top:solid 1px #999999;">订单状态</td><td style="border-top:solid 1px #999999;">订单详情</td></tr>
	<%
	for(OrderBase base:list2){
		%>
		<tr><td style="border-left:solid 1px #999999;"><%=base.getId() %></td><td><%=format.format(base.getOdrmst_orderdate()) %></td><td><%=Tools.getDouble(base.getOdrmst_ordermoney(),2) %></td>
		<td><%=Tools.getDouble(base.getOdrmst_tktvalue(),2) %></td><td><%=Tools.getDouble(base.getOdrmst_acturepaymoney(),2) %></td><td><%=getstatus(base.getOdrmst_orderstatus().intValue()) %></td>
	<td width="480px">
	<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
	<tr><td>商品编码</td><td>商品名称</td><td style="border:none;border-bottom:solid 1px #999999;">金额</td></tr>
	<%
	 ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
	  if(orderitemlist!=null){
		 
		 for(OrderItemBase itembase:orderitemlist){
			  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
			  if(product!=null){
				  %>	
				 <tr><td><%=product.getId() %></td><td><%=Tools.clearHTML(product.getGdsmst_gdsname()) %></td><td  style="border:none;border-bottom:solid 1px #999999;"><%=Tools.getDouble(itembase.getOdrdtl_finalprice(),2) %></td></tr>   
			<%  }
		 }
	  }
	%>
	</table>
	</td>
	</tr>
	<%}%>
	<tr><td colspan="7" height="30px" style="border:none;">&nbsp;</td></tr>
	</table>
	<%
           if(pBean.getTotalPages()>1){
        	 %>
           <div class="GPager">
           	<span style="color:#919191">共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
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
           </div><%}%>
<%}
%>
<div style="height:50px;">&nbsp;</div>
</center>
</body>
</html>