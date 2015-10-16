<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
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
 * 对账单--odrmst_cache
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
			   listRes.add(Restrictions.le("odrmst_orderstatus", new Long(61)));
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
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<link href="images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>无标题文档</title>
</head>
<script type="text/javascript">
function opengg() {
	 window.open("odr_gg.jsp","_blank", "height=400, width=620, top=0, left=255, toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no");
}

function sendForm(obj,odrid,odrnum){
	var shipcode="";
	var shipname="";
	shipcode=$('#shipcode'+odrnum).val();
	//shipname=$('#shipname').options[$('#shipname').selectedIndex].value
	shipname=$("#shipname"+odrnum).find("option:selected").text();
	//$.alert(shipcode);
	//$.alert(shipname);
	 if (shipname == ""){
		 $.alert('请选择快递公司!');
	        return;
	    }  
	if (shipcode == ""){
		$.alert('请填写发货单号!');
	        return;
	    }
	//return;
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/sendodr.jsp',
		cache: false,
		data: {shipname:shipname,shipcode:shipcode,odrid:odrid},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.code==1){
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function saveShipCode(obj,odrid,odrnum){
	var shipcode="";
	var shipname="";
	shipcode=$('#shipcode'+odrnum).val();
	//shipname=$('#shipname').options[$('#shipname').selectedIndex].value
	shipname=$("#shipname"+odrnum).find("option:selected").text();
	//$.alert(shipcode);
	//$.alert(shipname);
	 if (shipname == ""){
		 $.alert('请选择快递公司!');
	        return;
	    }  
	if (shipcode == ""){
		$.alert('请填写发货单号!');
	        return;
	    }
	//return;
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/saveShipCode.jsp',
		cache: false,
		data: {shipname:shipname,shipcode:shipcode,odrid:odrid},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.code==1){
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function SetCookie(name,value)//两个参数，一个是cookie的名子，一个是值
{
    var Days = 1; //此 cookie 将被保存 30 天
    var exp  = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
function getCookie(name)//取cookies函数        
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;

}
	
$(document).ready(function(){
	  //var req_odrstatus_ = $("#req_odrstatus_2").val();
	  //$("#req_odrstatus_1 option[value='"+req_odrstatus_+"']").attr("selected", true);
	  var gg = "<%=request.getParameter("gg")%>";
	  if(gg=="1") {
	  	opengg();
	  	//SetCookie("gg","1");
	  }
});

function excel_export(){
	var req_odrid = $("#req_odrid").val();//订单号
	var orderdate_s = $("#orderdate_s").val();//开始时间
	var orderdate_e = $("#orderdate_e").val();//结束时间
	var req_rname = $("#req_rname").val();//收件人
	var req_goodsodrid = $("#req_goodsodrid").val();//快递单号
	var req_odrstatus = $("#req_odrstatus_1").val();//发货状态
	var req_orddate = $("#req_orddate").val();//时间选择
	var hf = '/admin/odradmin/odr_detail.jsp?act=detail&req_odrid='+req_odrid+'&orderdate_s='+orderdate_s+'&orderdate_e='+orderdate_e+'&req_rname='+req_rname+'&req_goodsodrid='+req_goodsodrid+'&req_odrstatus='+req_odrstatus+'&req_orddate='+req_orddate;
	window.location.href = hf;
	/*
	var form = $("<form>");
	form.attr('style','display:none');
	form.attr('method','post');
	form.attr('action','/admin/odradmin/odrlist.jsp?act=export');
	form.attr('action','/admin/odradmin/odr_detail.jsp?act=detail');
	var req_odrid_v = $('<input>');
	req_odrid_v.attr('type','hidden');
	req_odrid_v.attr('name','req_odrid');
	req_odrid_v.attr('value',req_odrid);
	var orderdate_s_v = $('<input>');
	orderdate_s_v.attr('type','hidden');
	orderdate_s_v.attr('name','orderdate_s');
	orderdate_s_v.attr('value',orderdate_s);
	var orderdate_e_v = $('<input>');
	orderdate_e_v.attr('type','hidden');
	orderdate_e_v.attr('name','orderdate_e');
	orderdate_e_v.attr('value',orderdate_e);
	var req_rname_v = $('<input>');
	req_rname_v.attr('type','hidden');
	req_rname_v.attr('name','req_rname');
	req_rname_v.attr('value',req_rname);
	var req_goodsodrid_v = $('<input>');
	req_goodsodrid_v.attr('type','hidden');
	req_goodsodrid_v.attr('name','req_goodsodrid');
	req_goodsodrid_v.attr('value',req_goodsodrid);
	var req_odrstatus_1_v = $('<input>');
	req_odrstatus_1_v.attr('type','hidden');
	req_odrstatus_1_v.attr('name','req_odrstatus_1');
	req_odrstatus_1_v.attr('value',req_odrstatus_1);
	$('body').append(form);
	form.append(req_odrid_v);
	form.append(orderdate_s_v);
	form.append(orderdate_e_v);
	form.append(req_rname_v);
	form.append(req_goodsodrid_v);
	form.append(req_odrstatus_1_v);
	form.submit();
	form.remove();*/
}
</script>

<body style="overflow-x: hidden">

<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">
<form id="search1" name="search1" method="post" action="odrlist.jsp" >
<input type="hidden" name="act" value="list" />
<input type="hidden" value="<%= request.getParameter("req_odrstatus")%>" id="req_odrstatus_2"/>
  <tr>
    <td height="30" colspan="7">时间为空则默认为30天内&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #800000;">注：不选时间，默认显示当前月份数据，如需查询以前月份数据，请选择时间范围</span></td>
  </tr>
  <tr>
    <td width="59" height="40">订单号：</td>
    <td width="185"><input type="text" name="req_odrid" id="req_odrid" class="text" value="<%= request.getParameter("req_odrid")!=null?request.getParameter("req_odrid"):""%>"/></td>
    <td width="69">
    	<select name="req_orddate" id="req_orddate">
    		<option value="1" <% if("1".equals(request.getParameter("req_orddate"))){ out.print("selected"); } %>>订单日期</option>
    		<option value="2" <% if("2".equals(request.getParameter("req_orddate"))){ out.print("selected"); } %>>发货日期</option>
    	</select>
    		</td>
    <td width="186"><input type="text" name="orderdate_s" id="orderdate_s" class="text" value="<%= request.getParameter("orderdate_s")!=null?request.getParameter("orderdate_s"):""%>" onclick="WdatePicker();" /></td>
    <td width="26">至</td>
    <td colspan="2"><input type="text" name="orderdate_e" id="orderdate_e" class="text" value="<%= request.getParameter("orderdate_e")!=null?request.getParameter("orderdate_e"):""%>" onclick="WdatePicker();" />格式(2013-08-22)</td>
  </tr>
  <tr>
    <td height="40">收件人：</td>
    <td><input type="text" name="req_rname" id="req_rname" class="text" value="<%= request.getParameter("req_rname")!=null?request.getParameter("req_rname"):""%>"/></td>
    <td>快递单号：</td>
    <td><input type="text" name="req_goodsodrid" id="req_goodsodrid" class="text" value="<%= request.getParameter("req_goodsodrid")!=null?request.getParameter("req_goodsodrid"):""%>" /></td>
    <td>&nbsp;</td>
    <td width="152"><select name="req_odrstatus" class="text" id="req_odrstatus_1">
      <!--  <option value="">全部</option>
	  <option value="1">未支付</option>-->
	  <%String req_odrstatus= request.getParameter("req_odrstatus"); %>
	  <option value="" <%if("".equals(req_odrstatus)){out.println("selected");} %>>全部</option>
	  <option value="2" <%if(req_odrstatus==null || "2".equals(req_odrstatus)){out.println("selected");} %>>待发货</option>
	  <option value="3" <%if("3".equals(req_odrstatus)){out.println("selected");} %>>已发货</option>
	  <option value="4" <%if("4".equals(req_odrstatus)){out.println("selected");} %>>已妥投</option>
	  <option value="5" <%if("5".equals(req_odrstatus)){out.println("selected");} %>>已取消</option>
	  <!-- <option value="6">已退货</option>
	  <option value="7">已换货</option>-->
    </select></td>
    <td width="129">
    	<input type="submit" name="imageField" value="搜索"/>
	    <input type="button" onclick="excel_export();" name="imageField"  value="批量导出" />
    </td>
  </tr>
  </form>

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
        <td width="400" height="40">商品名称</td>
        <td width="100">单价(元)</td>
        <td width="100">数量</td>
        <td width="100">交易状态</td>
        <td width="103">应收款</td>
      </tr>
      <tr>
        <td colspan="5">
        <input type="hidden" id="shop_Code" name="shop_Code" value="<%=session.getAttribute("shopcodelog").toString()%>"/>
 <%
	String shopCode=session.getAttribute("shopcodelog").toString();
	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String ggURL = Tools.addOrUpdateParameter(request,null,null);
      ArrayList<OrderBase> list=new ArrayList<OrderBase>();
      String act=request.getParameter("act");
      System.out.println(act);
      if(act!=null&&act.equals("list")){
      list=getOrderList(request,response,shopCode);
      }
      /*
      if(act!=null&&act.equals("export")){
    	  ArrayList<OrderMain> om_list = getOrderMainList(request,response,shopCode);
    	  System.out.println("=11111111==="+om_list.size());
    	 
    	  ExcelExport.xlsDto2Excel(om_list);
    	  
      }*/
      //分页
      int pageno1=1;
      
      if(ggURL != null) 
      	   {
      	     ggURL.replaceAll("pageno1=[0-9]*","");
      	   }
      //翻页
        int totalLength1 = (list != null ?list.size() : 0);
        int PAGE_SIZE = 30;
        int currentPage1 = 1 ;
        String pg1 ="1";
        if(request.getParameter("pageno1")!=null)
        {
        	pg1= request.getParameter("pageno1");
        }
      
        if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
        PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
        int end1 = pBean1.getStart()+PAGE_SIZE;
        if(end1 > totalLength1) end1 = totalLength1;
        
      	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
      	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
      if(list!=null&&list.size()>0)
      {
     	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
 		   {
 			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
 		   }
 	    	 
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	  OrderBase odr=list.get(i);
 	    	 long odrstatus=odr.getOdrmst_orderstatus().longValue();
 	
 	    	 // User user=UserHelper.getById(odr.getOdrmst_mbrid().toString());
 	    	 //去掉取消的订单
 	    	ArrayList<OrderItemBase> listdetail= getOrderDetail(odr.getId());
 	    	ArrayList<OrderItemBase> listdetail1 = new ArrayList<OrderItemBase>();
 	    	for(int j=0;j<listdetail.size();j++) {
 	    		if(listdetail.get(j).getOdrdtl_shipstatus().longValue()>0) {
 	    			listdetail1.add(listdetail.get(j));
 	    		}
 	    	}
 	    	listdetail = listdetail1;
 	    	
 	    	  if (listdetail!=null&&listdetail.size()>0){
      %>
        
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linon">
		<!--  <form id="sendform" name="sendform" method="post"  >-->
		 <tr class="odrlistt">
        <td width="400" height="35" style="line-height:26px;"><table width="100%" height="35" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="87%" class="pdl8">订单编号：<a href="listdetail.jsp?odrid=<%=odr.getId() %>" target="rightdisplay" ><span class="spantxt"><%= odr.getId()%></span></a>&nbsp;&nbsp;<span><br>下单时间：<%=fmt.format(odr.getOdrmst_orderdate())%><br>送货时间：<%=(odr.getOdrmst_shipdate()==null?"":fmt.format(odr.getOdrmst_shipdate())) %></span></td>
            <td width="13%"><%if ((odrstatus>=1&&odrstatus<=3)||odrstatus==31) {%><a href="printdtl.jsp?odrid=<%=odr.getId() %>" target="_blank"><img src="images/print.jpg" width="26" height="26" border="0"  /></a><%} %></td>
          </tr>
        </table></td>
        <td colspan="3" width="300">
<%if ((odrstatus>=1&&odrstatus<=2)) {

%><select name="shipname<%=i %>" id="shipname<%=i %>" class="text">
<option value="EMS">EMS</option>
<option value="宅急送">宅急送</option>
<option value="圆通速递">圆通速递</option>
<option value="韵达快运">韵达快运</option>
<option value="顺丰快递">顺丰快递</option>
<option value="申通快递">申通快递</option>
<option value="中通快递">中通快递</option>
<option value="优速快递">优速快递</option>
<option value="天天快递">天天快递</option>
<option value="国通快递">国通快递</option>
<option value="汇通快递">汇通快递</option>
<option value="全峰快递">全峰快递</option>
<option value="百世汇通">百世汇通</option>
<option value="快捷速递">快捷速递</option>
<option value="微特派快递">微特派快递</option>
<option value="其它快递">其它快递</option>      </select>快递单号：
          <input name="shipcode<%=i %>" id="shipcode<%=i %>" type="text" class="text" size="16" />
          <%}
        if((odrstatus>=3) && !odrLimit(odr.getOdrmst_shipdate())) {
        	out.print(odr.getOdrmst_d1shipmethod()+"--单号："+odr.getOdrmst_goodsodrid());
        }
        
        if(odrstatus==3 && odrLimit(odr.getOdrmst_shipdate())) {
        	String shipname=odr.getOdrmst_d1shipmethod();
       	%>
          <select name="shipname<%=i %>" id="shipname<%=i %>" class="text">
<option value="EMS" <%if (!Tools.isNull(shipname)&&shipname.equals("EMS")){out.print("selected");}%> >EMS</option>
<option value="宅急送" <%if (!Tools.isNull(shipname)&&shipname.equals("宅急送")){out.print("selected");}%>>宅急送</option>
<option value="圆通速递" <%if (!Tools.isNull(shipname)&&shipname.equals("圆通速递")){out.print("selected");}%>>圆通速递</option>
<option value="韵达快运" <%if (!Tools.isNull(shipname)&&shipname.equals("韵达快运")){out.print("selected");}%>>韵达快运</option>
<option value="顺丰快递" <%if (!Tools.isNull(shipname)&&shipname.equals("顺丰快递")){out.print("selected");}%>>顺丰快递</option>
<option value="申通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("申通快递")){out.print("selected");}%>>申通快递</option>
<option value="中通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("中通快递")){out.print("selected");}%>>中通快递</option>
<option value="优速快递" <%if (!Tools.isNull(shipname)&&shipname.equals("优速快递")){out.print("selected");}%>>优速快递</option>
<option value="天天快递" <%if (!Tools.isNull(shipname)&&shipname.equals("天天快递")){out.print("selected");}%>>天天快递</option>
<option value="国通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("国通快递")){out.print("selected");}%>>国通快递</option>
<option value="汇通快递" <%if (!Tools.isNull(shipname)&&shipname.equals("汇通快递")){out.print("selected");}%>>汇通快递</option>
<option value="全峰快递" <%if (!Tools.isNull(shipname)&&shipname.equals("全峰快递")){out.print("selected");}%>>全峰快递</option>
<option value="百世汇通" <%if (!Tools.isNull(shipname)&&shipname.equals("百世汇通")){out.print("selected");}%>>百世汇通</option>
<option value="快捷速递" <%if (!Tools.isNull(shipname)&&shipname.equals("快捷速递")){out.print("selected");}%>>快捷速递</option>
<option value="微特派快递" <%if (!Tools.isNull(shipname)&&shipname.equals("微特派快递")){out.print("selected");}%>>微特派快递</option>
<option value="其它快递" <%if (!Tools.isNull(shipname)&&shipname.equals("其它快递")){out.print("selected");}%>>其它快递</option>
 
        </select>快递单号：
          <input name="shipcode<%=i %>" id="shipcode<%=i %>" type="text" class="text" size="16" value="<%=odr.getOdrmst_goodsodrid()%>"/>      	
       	<%
        }
        %>
          </td>
        <td nowrap="nowrap">
        <%String paystatus="未到款";
        
        if(odr.getOdrmst_payid()!=null&&odr.getOdrmst_payid().longValue()>0&&odr.getOdrmst_payid().longValue()!=44){
        	if(odrstatus==0){
        		paystatus="未到款";
        	}else if(odrstatus==1||odrstatus==2){
        		paystatus="已收款";
        	}
        }else{
        	if(odrstatus==0){
        		paystatus="未确认";
        	}else if(odrstatus==1){
        		paystatus="已确认";
        	}
        }
        if(odrstatus<0&&odrstatus!=-2){
        	paystatus="用户取消";
        }else if(odrstatus==-2){
        	paystatus="缺货取消";
        }else if(odrstatus==3){
        	paystatus="订单全发";
        }else if(odrstatus==31){
        	paystatus="部分发货";
        }else if(odrstatus==5 || odrstatus==51 || odrstatus==6 || odrstatus==61){
        	paystatus="交易完成";
        }
        if(odrstatus==1|| odrstatus==2){
        %>
        <input type="image" name="imageField2" src="images/send.jpg" onclick="sendForm(this,'<%=odr.getId() %>',<%=i %>);"  />
        <%}
        if(odrstatus==3 && odrLimit(odr.getOdrmst_shipdate())){
        %>
        <input type="button" name="imageField2" value="修改" onclick="saveShipCode(this,'<%=odr.getId() %>',<%=i %>);"  />
        <%}
out.print(paystatus);  %>
        
        </td>
		 </tr><!--  </form>-->
		 <%for(OrderItemBase itembase:listdetail){
			 long dtlstatus=itembase.getOdrdtl_shipstatus().longValue();
			 long dtlpurtype=itembase.getOdrdtl_purtype().longValue();
			 Product p=ProductHelper.getById(itembase.getOdrdtl_gdsid());
			 String shopgoodscode=p.getGdsmst_shopgoodscode();
			 %>
         <tr>
           <td height="40"  class="spantxt  pdl8"><a href="http://www.d1.com.cn/product/<%=p.getId() %>" target="_blank"><%=itembase.getOdrdtl_gdsname() %></a>(<%=itembase.getOdrdtl_sku1() %>)
           <%if(!Tools.isNull(shopgoodscode)){out.print("("+shopgoodscode+")");}%>
           </td>
           <td align="center"><%=Tools.getDouble(itembase.getOdrdtl_finalprice().doubleValue(), 2)%></td>
           <td align="center"><%=itembase.getOdrdtl_gdscount()%></td>
           <td align="center">
<%String status="";

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
           <td align="center"><%=Tools.getDouble(itembase.getOdrdtl_finalprice().doubleValue()*itembase.getOdrdtl_gdscount().longValue(), 2)%></td>
         </tr>
         <%} %>
    </table>
	 <%}
	   }
      }
%>
 
			</td>
        </tr>
           	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="7" height="45">
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
					           		}else{
					           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span> </td>
				     </tr><%}%>	
        
    </table></td>
  </tr>
  <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
</table>
</body>
</html>


