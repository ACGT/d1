<%@ page contentType="text/html; charset=UTF-8"  language="java" pageEncoding="UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>

<%

if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	String powername = "d1odr_send";
	boolean is_power = chk_admpower(userid,powername);
	if(!is_power){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}

%>

<%!
/**
 * 对账单--odrmst
 */
 public static ArrayList<OrderCache> getOrderCacheList(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<OrderCache> list=new ArrayList<OrderCache>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		   String req_rname= request.getParameter("req_rname");
		   String req_odrid= request.getParameter("req_odrid");
		   String req_goodsodrid= request.getParameter("req_goodsodrid");
		   String orderdate_s= request.getParameter("orderdate_s");
		   String orderdate_e= request.getParameter("orderdate_e");
		   String req_odrstatus= request.getParameter("req_odrstatus");
		   String req_orddate = request.getParameter("req_orddate");
		   if(!Tools.isNull(req_odrid)){
			   listRes.add(Restrictions.eq("id", req_odrid));
		   }
		   if(!Tools.isNull(req_goodsodrid)){
			   listRes.add(Restrictions.eq("odrmst_goodsodrid", req_goodsodrid));
		   }
		   if(!Tools.isNull(req_rname)){
			   listRes.add(Restrictions.eq("odrmst_rname", req_rname));
		   }
		   if(!Tools.isNull(req_odrstatus)){
			   if(Tools.parseInt(req_odrstatus)==1){
				   listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(0)));
			   }else if(Tools.parseInt(req_odrstatus)==2){   
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(1)));
				   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(2)));
			   }else if(Tools.parseInt(req_odrstatus)==3){
				   listRes.add(Restrictions.le("odrmst_orderstatus",new Long(3)));
				   listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(31)));
				   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(5)));
				   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(6)));
			   }else if(Tools.parseInt(req_odrstatus)==4){
				   listRes.add(Restrictions.le("odrmst_orderstatus",new Long(5)));
				   listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(61)));
				   listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(31)));
			   }else if(Tools.parseInt(req_odrstatus)==5){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }else if(Tools.parseInt(req_odrstatus)==6){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }else if(Tools.parseInt(req_odrstatus)==7){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }
			   
			
		   }
			
		   if((!Tools.isNull(orderdate_s)||!Tools.isNull(orderdate_e))){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	            Date s=null;
	            Date e=null;
			   if(orderdate_s.length()>0&&orderdate_e.length()<=0){
			   	try{
			   		 s=format.parse(orderdate_s+" 00:00:00");
			   	  
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(orderdate_s.length()<=0&&orderdate_e.length()>0){
			   	try{
			   		
			   	     e=format.parse(orderdate_s+" 00:00:00");
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(orderdate_s.length()>0&&orderdate_e.length()>0){
			   	try{		
			   	     e=format.parse(orderdate_e+" 00:00:00");
			   	     s=format.parse(orderdate_s+" 00:00:00");
			   	}catch(Exception ex){
			   		System.out.print(ex);
			   	}
			   }
			   //if(datetype.equals("req_orderdate")){
			   if("1".equals(req_orddate)) {
				   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_orderdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_orderdate", e));
				   }			   
			   }else if("2".equals(req_orddate)) {
				   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_shipdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_shipdate", e));
				   }
			   }
			   //}
			   /*if(datetype.equals("req_validdate")){
				   if(!Tools.isNull(orderdate_s)){
				    listRes.add(Restrictions.ge("odrmst_validdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_validdate", e));
					   }
			   }
			   if(datetype.equals("req_shipdate")){
				   if(!Tools.isNull(orderdate_s)){
				    listRes.add(Restrictions.ge("odrmst_shipdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_shipdate", e));
					   }
			   }*/
		
		   }else{
			   if(Tools.isNull(req_odrid)&&Tools.isNull(req_goodsodrid)&&Tools.isNull(req_rname)){
			   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   try{
				   Date sDate=null;
				   if(Tools.parseInt(req_odrstatus)==2){
				    sDate=Tools.addDate(new Date(), -20);
				   }else{
					 sDate=Tools.addDate(new Date(), -7); 
				   }
			  
			  //System.out.println(format.format(sDate));
				   if("2".equals(req_orddate)) {
					   listRes.add(Restrictions.ge("odrmst_shipdate", sDate ));
				   }else {
					   listRes.add(Restrictions.ge("odrmst_orderdate", sDate ));
				   }
			   }
			   catch(Exception ex){
				   ex.printStackTrace();
			   }
			   }
		   }

		   if(!Tools.isNull(shopCode)){
			   listRes.add(Restrictions.eq("odrmst_sndshopcode", shopCode));
		   }

	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.desc("odrmst_orderdate"));
		List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, olist, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderCache)be);
		}
		return list;
	}
	/**
	 * 对账单--odrmst
	 */
	public static ArrayList<OrderMain> getOrderMainList(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<OrderMain> list=new ArrayList<OrderMain>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		   String req_rname= request.getParameter("req_rname");
		   String req_odrid= request.getParameter("req_odrid");
		   String req_goodsodrid= request.getParameter("req_goodsodrid");
		   String orderdate_s= request.getParameter("orderdate_s");
		   String orderdate_e= request.getParameter("orderdate_e");
		   String req_odrstatus= request.getParameter("req_odrstatus");
		   String req_orddate = request.getParameter("req_orddate");
		   
		   if(!Tools.isNull(req_odrid)){
			   listRes.add(Restrictions.eq("id", req_odrid));
		   }
		   if(!Tools.isNull(req_goodsodrid)){
			   listRes.add(Restrictions.eq("odrmst_goodsodrid", req_goodsodrid));
		   }
		   if(!Tools.isNull(req_rname)){
			   listRes.add(Restrictions.eq("odrmst_rname", req_rname));
		   }	   
		   //System.out.println(req_odrstatus);
		   if(!Tools.isNull(req_odrstatus)){
			   if(Tools.parseInt(req_odrstatus)==1){
				   listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(0)));
			   }else if(Tools.parseInt(req_odrstatus)==2){   
				   listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(1)));
				   listRes.add(Restrictions.le("odrmst_orderstatus",new Long(2)));
			   }else if(Tools.parseInt(req_odrstatus)==3){
				   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(31)));
				   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(5)));
				   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(6)));
			   }else if(Tools.parseInt(req_odrstatus)==4){
				   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(5)));
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(61)));
				   listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(31)));
			   }else if(Tools.parseInt(req_odrstatus)==5){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }else if(Tools.parseInt(req_odrstatus)==6){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }else if(Tools.parseInt(req_odrstatus)==7){
				   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
			   }
			   
			
		   }

		   if((!Tools.isNull(orderdate_s)||!Tools.isNull(orderdate_e))){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date s=null;
	         Date e=null;
			   if(orderdate_s.length()>0&&orderdate_e.length()<=0){
			   	try{
			   		 s=format.parse(orderdate_s+" 00:00:00");
			   	  
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(orderdate_s.length()<=0&&orderdate_e.length()>0){
			   	try{
			   		
			   	     e=format.parse(orderdate_e+" 00:00:00");
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(orderdate_s.length()>0&&orderdate_e.length()>0){
			   	try{
			   	     e=format.parse(orderdate_e+" 00:00:00");
			   	     s=format.parse(orderdate_s+" 00:00:00");
			   	}catch(Exception ex){
			   		//System.out.print(ex);
			   	}
			   }
			   //if(datetype.equals("req_orderdate")){
			   if("1".equals(req_orddate)) {
					//System.out.print(e);
				   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_orderdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					   
					    listRes.add(Restrictions.le("odrmst_orderdate", e));
				   }			   
			   }else if("2".equals(req_orddate)) {
				   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_shipdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_shipdate", e));
				   }
			   }
			   //}
			   /*if(datetype.equals("req_validdate")){
				   if(!Tools.isNull(orderdate_s)){
				    listRes.add(Restrictions.ge("odrmst_validdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_validdate", e));
					   }
			   }
			   if(datetype.equals("req_shipdate")){
				   if(!Tools.isNull(orderdate_s)){
				    listRes.add(Restrictions.ge("odrmst_shipdate", s));
				   }
				   if(!Tools.isNull(orderdate_e)){
					    listRes.add(Restrictions.le("odrmst_shipdate", e));
					   }
			   }*/
		
		   }else{
			   if(Tools.isNull(req_odrid)&&Tools.isNull(req_goodsodrid)&&Tools.isNull(req_rname)){
			   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   try{
				   Date sDate=null;
				   if(Tools.parseInt(req_odrstatus)==2){
				    sDate=Tools.addDate(new Date(), -20);
				   }else{
					 sDate=Tools.addDate(new Date(), -7); 
				   }
			  
			  //System.out.println(format.format(sDate));
				   if("2".equals(req_orddate)) {
					   listRes.add(Restrictions.ge("odrmst_shipdate", sDate ));
				   }else {
					   listRes.add(Restrictions.ge("odrmst_orderdate", sDate ));
				   }

			   }catch(Exception ex){
				   ex.printStackTrace();
			   }
			   }
		   }

		   if(!Tools.isNull(shopCode)){
			   listRes.add(Restrictions.eq("odrmst_sndshopcode", shopCode));
		   }


	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.desc("odrmst_orderdate"));
		List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, olist, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderMain)be);
		}
		return list;
	}	
	/**
		 * 对账单--odrmst_recent
		 */
		public static ArrayList<OrderRecent> getOrderRecentList(HttpServletRequest request,HttpServletResponse response,String shopCode){
			ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
			List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			String req_rname= request.getParameter("req_rname");
			   String req_odrid= request.getParameter("req_odrid");
			   String req_goodsodrid= request.getParameter("req_goodsodrid");
			   String orderdate_s= request.getParameter("orderdate_s");
			   String orderdate_e= request.getParameter("orderdate_e");
			   String req_odrstatus= request.getParameter("req_odrstatus");
			   String req_orddate = request.getParameter("req_orddate");
			   if(!Tools.isNull(req_odrid)){
				   listRes.add(Restrictions.eq("id", req_odrid));
			   }
			   if(!Tools.isNull(req_goodsodrid)){
				   listRes.add(Restrictions.eq("odrmst_goodsodrid", req_goodsodrid));
			   }
			   if(!Tools.isNull(req_rname)){
				   listRes.add(Restrictions.eq("odrmst_rname", req_rname));
			   }	   
			   //System.out.println(req_odrstatus);
			   if(!Tools.isNull(req_odrstatus)){
				   if(Tools.parseInt(req_odrstatus)==1){
					   listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(0)));
				   }else if(Tools.parseInt(req_odrstatus)==2){   
					   listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(1)));
					   listRes.add(Restrictions.le("odrmst_orderstatus",new Long(2)));
				   }else if(Tools.parseInt(req_odrstatus)==3){
					   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
					   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(31)));
					   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(5)));
					   //listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(6)));
				   }else if(Tools.parseInt(req_odrstatus)==4){
					   listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(5)));
					   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(61)));
					   listRes.add(Restrictions.ne("odrmst_orderstatus", new Long(31)));
				   }else if(Tools.parseInt(req_odrstatus)==5){
					   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
				   }else if(Tools.parseInt(req_odrstatus)==6){
					   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
				   }else if(Tools.parseInt(req_odrstatus)==7){
					   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(-1)));
				   }
				   
				
			   }

			   if((!Tools.isNull(orderdate_s)||!Tools.isNull(orderdate_e))){
					   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		         Date s=null;
		         Date e=null;
				   if(orderdate_s.length()>0&&orderdate_e.length()<=0){
				   	try{
				   		 s=format.parse(orderdate_s+" 00:00:00");
				   	  
				   	}catch(Exception ex){
				   		
				   	}
				   }
				   else if(orderdate_s.length()<=0&&orderdate_e.length()>0){
				   	try{
				   		
				   	     e=format.parse(orderdate_e+" 00:00:00");
				   	}catch(Exception ex){
				   		
				   	}
				   }
				   else if(orderdate_s.length()>0&&orderdate_e.length()>0){
				   	try{
				   	     e=format.parse(orderdate_e+" 00:00:00");
				   	     s=format.parse(orderdate_s+" 00:00:00");
				   	}catch(Exception ex){
				   		//System.out.print(ex);
				   	}
				   }
				   //if(datetype.equals("req_orderdate")){
				   if("1".equals(req_orddate)) {
						//System.out.print(e);
					   if(!Tools.isNull(orderdate_s)){
						    listRes.add(Restrictions.ge("odrmst_orderdate", s));
					   }
					   if(!Tools.isNull(orderdate_e)){
						   
						    listRes.add(Restrictions.le("odrmst_orderdate", e));
					   }			   
				   }else if("2".equals(req_orddate)) {
					   if(!Tools.isNull(orderdate_s)){
						    listRes.add(Restrictions.ge("odrmst_shipdate", s));
					   }
					   if(!Tools.isNull(orderdate_e)){
						    listRes.add(Restrictions.le("odrmst_shipdate", e));
					   }
				   }
				   //}
				   /*if(datetype.equals("req_validdate")){
					   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_validdate", s));
					   }
					   if(!Tools.isNull(orderdate_e)){
						    listRes.add(Restrictions.le("odrmst_validdate", e));
						   }
				   }
				   if(datetype.equals("req_shipdate")){
					   if(!Tools.isNull(orderdate_s)){
					    listRes.add(Restrictions.ge("odrmst_shipdate", s));
					   }
					   if(!Tools.isNull(orderdate_e)){
						    listRes.add(Restrictions.le("odrmst_shipdate", e));
						   }
				   }*/
			
			   }else{
				   if(Tools.isNull(req_odrid)&&Tools.isNull(req_goodsodrid)&&Tools.isNull(req_rname)){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				   try{
					   Date sDate=null;
					   if(Tools.parseInt(req_odrstatus)==2){
					    sDate=Tools.addDate(new Date(), -20);
					   }else{
						 sDate=Tools.addDate(new Date(), -7); 
					   }
				  
				  //System.out.println(format.format(sDate));
					   if("2".equals(req_orddate)) {
						   listRes.add(Restrictions.ge("odrmst_shipdate", sDate ));
					   }else {
						   listRes.add(Restrictions.ge("odrmst_orderdate", sDate ));
					   }

				   }catch(Exception ex){
					   ex.printStackTrace();
				   }
				   }
			   }

			   if(!Tools.isNull(shopCode)){
				   listRes.add(Restrictions.eq("odrmst_sndshopcode", shopCode));
			   }


		    List<Order> olist=new ArrayList<Order>();
		    olist.add(Order.desc("odrmst_orderdate"));
			List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, olist, 0, 3000);
			if(list2==null || list2.size()==0){
				return null;
			}
			for(BaseEntity be:list2){
				list.add((OrderRecent)be);
			}
			return list;
		}
		

		
		public static ArrayList<OrderBase> getOrderList(HttpServletRequest request,HttpServletResponse response,String shopCode){
			ArrayList<OrderBase> list=new ArrayList<OrderBase>();
			 String req_rname= request.getParameter("req_rname");
			   String req_odrid= request.getParameter("req_odrid");
			   String req_goodsodrid= request.getParameter("req_goodsodrid");
			   String orderdate_s= request.getParameter("orderdate_s");
			   String orderdate_e= request.getParameter("orderdate_e");
			   String req_odrstatus= request.getParameter("req_odrstatus");
			/*ArrayList<OrderCache> listcache=getOrderCacheList(request,response,shopCode);
			if(listcache!=null){
				for(OrderCache ordercache:listcache){
					list.add(ordercache);
				}
			}*/
			ArrayList<OrderMain> listmain=getOrderMainList( request,response,shopCode);
			if(listmain!=null){
				for(OrderMain ordermain:listmain){
					list.add(ordermain);
				}
			}
			if(Tools.isNull(req_odrstatus)||(!Tools.isNull(req_odrstatus)&&Tools.parseInt(req_odrstatus)>=3)){
			ArrayList<OrderRecent> listrecent=getOrderRecentList( request, response,shopCode);
			if(listrecent!=null){
				for(OrderRecent orderrecent:listrecent){
					list.add(orderrecent);
				}
			}
			}
			if(list==null || list.size()==0){
				return null;
			}
			return list;
		}
		public static  ArrayList<OrderItemBase> getOrderDetail(String odrid){
			ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
			List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			listRes.add(Restrictions.eq("odrdtl_odrid", odrid));

			List<BaseEntity> list2 = Tools.getManager(OrderItemCache.class).getList(listRes, null, 0, 20);
			if(list2==null || list2.size()==0){
			 list2 = Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 20);
			 if(list2==null || list2.size()==0){
					list2 = Tools.getManager(OrderItemRecent.class).getList(listRes, null, 0, 20);
				}
			}
			
			if(list2==null || list2.size()==0){
				return null;
			}
			for(BaseEntity be:list2){
				list.add((OrderItemBase)be);
			}
			return list;
		}
		
		public static boolean odrLimit(Date limitDay) {
			Calendar calendar = Calendar.getInstance();
		    int day = calendar.get(Calendar.DAY_OF_YEAR);
		    calendar.set(Calendar.DAY_OF_YEAR, day - 7);
		    
			return calendar.getTime().before(limitDay);
		}

	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<link href="images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>无标题文档</title>
</head>
<body style="overflow-x: hidden">

<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr>
    <td class="menuodrtd"  colspan="7">订单列表</td>
  </tr>
    <tr>
      <td height="2" colspan="7" bgcolor="#449ae7"></td>
    </tr>
    <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="7">
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="lin">
      <tr class="odrt">
        <td width="10%" >订单日期</td>
        <td width="10%">订单号</td>
        <td width="8%">收货人</td>
        <td width="15%">地址</td>
        <td width="10%">电话</td>
        <td width="10%">产品编码</td>
        <td width="15%">商品明细</td>
        <td width="5%">数量</td>
        <td width="5%">订单金额</td>
        <td width="5%">SKU</td>
        <td width="5%">状态</td>
      </tr>
 <%
   String shopCode=session.getAttribute("shopcodelog").toString();
   String act=request.getParameter("act");
   ArrayList<OrderBase> list1=null;
      if(act!=null&&act.equals("detail")){
    	  list1 = getOrderList(request,response,shopCode);
    	  //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	  //System.out.println("===list1.size:"+list1);
    	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if(list1!=null&&list1.size()>0){
    	  for(int i = 0;i<list1.size();i++){
    		  ArrayList<OrderItemBase> list2 = getOrderDetail(list1.get(i).getId());
   	    	ArrayList<OrderItemBase> listdetail1 = new ArrayList<OrderItemBase>();
   	    	for(int j=0;j<list2.size();j++) {
   	    		if(list2.get(j).getOdrdtl_shipstatus().longValue()>0) {
   	    			listdetail1.add(list2.get(j));
   	    		}
   	    	}
   	    	list2 = listdetail1;

    		  if(list2 != null && list2.size()>0){
				for(int j = 0;j<list2.size();j++){
					String rprovince = list1.get(i).getOdrmst_rprovince()==null?"":list1.get(i).getOdrmst_rprovince();
					String rcity = list1.get(i).getOdrmst_rcity()==null?"":list1.get(i).getOdrmst_rcity();
					String raddress = list1.get(i).getOdrmst_raddress()==null?"":list1.get(i).getOdrmst_raddress();
					%>
				<tr>	
				<td valign="center" align="center"><%=sdf.format(list1.get(i).getOdrmst_orderdate()) %></td>
        		<td valign="center" align="center" ><%= list1.get(i).getId()==null?"":list1.get(i).getId()%></td>
        		<td valign="center" align="center"><%= list1.get(i).getOdrmst_rname()==null?"":list1.get(i).getOdrmst_rname()%></td>
        		<td valign="center" align="center" ><%= rprovince +"&nbsp;"+ rcity +"&nbsp;"+ raddress%></td>
        		<td valign="center" align="center" ><%= list1.get(i).getOdrmst_rphone()==null?"":list1.get(i).getOdrmst_rphone()%></td>
        		<td valign="center" align="center" ><%=list2.get(j).getOdrdtl_gdsid()==null?"":list2.get(j).getOdrdtl_gdsid() %></td>
        		<td valign="center" align="center" ><%=list2.get(j).getOdrdtl_gdsname()==null?"":list2.get(j).getOdrdtl_gdsname() %></td>
        		<td valign="center" align="center" ><%=list2.get(j).getOdrdtl_gdscount()==null?"":list2.get(j).getOdrdtl_gdscount() %></td>
        		<td valign="center" align="center" ><%
	        		Double d = list2.get(j).getOdrdtl_finalprice();
	        		if(d != null){
	        			out.println(Tools.getDouble(d,2));
	        		}else{
	        			out.println("");
	        		}
        		%></td>
        		<td valign="center" align="center" ><%=list2.get(j).getOdrdtl_sku1()==null?"":list2.get(j).getOdrdtl_sku1() %></td>
        		<td valign="center" align="center" >
        <%
   			 long dtlstatus=list2.get(j).getOdrdtl_shipstatus().longValue();
   			 long dtlpurtype=list2.get(j).getOdrdtl_purtype().longValue();
        	String status="";

			if(dtlstatus==1&&dtlpurtype>=0){
				status="未发货";
			}else if(dtlstatus==-1||(dtlpurtype<0&&dtlstatus==1)){
				status="商家取消";
			}else if(dtlstatus==-2||dtlpurtype<0){
				status="用户取消";
			}else if(dtlstatus==-3||dtlpurtype<0){
				status="退货";
			}else if(dtlstatus==-4||dtlpurtype<0){
				status="换货";
			}else if(dtlstatus==2||dtlstatus==3){
				status="已发货";
			}
			out.print(status);
		%>

        		</td>
        		</tr>
				<%}
    		  }
    	  }
      }
}
%>
        
		
</table>
</td>
</tr>
</table>
</body>
</html>


