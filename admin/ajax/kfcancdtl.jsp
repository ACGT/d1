<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkkfmng.jsp"%>
<%

String odrid = request.getParameter("odrid");
if(Tools.isNull(odrid)){
	out.print("{\"code\":1,message:\"订单号错误\"}");
	return;
}

String ordertbl = "main";
OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(odrid);

if(order!=null&&order.getOdrmst_mbrid().longValue()==1544012&&order.getOdrmst_orderstatus().longValue()==2){
	 try{   
		 String muser=session.getAttribute("kfadmin").toString();
	        OrderService os = (OrderService)Tools.getService(OrderService.class);
	    	os.cancelOrder(order);
            order.setOdrmst_canceldate(new Date());
			SimpleDateFormat fm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			order.setOdrmst_internalmemo("取消订单"+muser+fm.format(new Date())+order.getOdrmst_internalmemo());
			 order.setOdrmst_prnflag(new Long(0));
	    	
	    	if(!Tools.getManager(order.getClass()).update(order, true))
	    	{
	    		out.print("{\"success\":false,\"message\":\"更新订单取消时间失败！\"}");
	    		
	        	  return;
	    	}
	    List<OrderItemBase> list=OrderItemHelper.getOdrdtlByOrderId(odrid);

 	if(list!=null&&list.size()>0)
 	{
 		for(OrderItemBase oib:list)
 		{
 			if(oib!=null)
 			{
 				 if(oib.getOdrdtl_shipstatus().longValue()==1){
 					   
 					  oib.setOdrdtl_shipstatus(new Long(-1));
 					 oib.setOdrdtl_purtype(new Long(-1));
 	               Tools.getManager(OrderItemMain.class).update(oib, true);
 	
 				   }
 			}
 			
 		}
 	
 	}
	 }
     catch(Exception ex)
     {
   	//  ex.printStackTrace();
   	  out.print("{\"success\":false,\"message\":\"订单取消失败！\"}");
   	  return;
     }

  
}else{
	out.print("{\"code\":1,message:\"取消失败！\"}");
	return;
}

%>