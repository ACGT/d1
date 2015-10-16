<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="../islogin.jsp" %><%@include file="public.jsp" %><%
    String orderid = request.getParameter("orderid");
    int flag=Tools.parseInt(request.getParameter("flag"));
    //System.out.print(orderid+"     "+flag);
    if(orderid!=null&&orderid.length()>0&&flag>=0)
    {
    	OrderBase ob;
    	ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
	    switch(flag)
	    {
		    case 1:
		    case 2:
		    case 3:
		    {
		    	ob=OrderHelper.getById(orderid.trim());
		    	list=OrderItemHelper.getOdrdtlListByOrderId(orderid.trim());
		    	break;
		    }
		    case 0:
		    case 4:
		    {
		    	ob=OrderHelper.getHistoryById(orderid.trim());
		    	list=OrderItemHelper.getOdrdtlListByOrderId(orderid.trim());
		    	break;
		    }
		   
		    default:
		    {
		    	ob=OrderHelper.getById(orderid.trim());
		    	list=OrderItemHelper.getOdrdtlListByOrderId(orderid.trim());
		    	break;
		    }
	    
	    }
	    if(ob!=null&&ob.getOdrmst_mbrid().toString().equals(lUser.getId())&&ob.getOdrmst_orderstatus().longValue()==0)
	    {
	    	
	          try{   
		        OrderService os = (OrderService)Tools.getService(OrderService.class);
		    	os.cancelOrder(ob);
		    	ob.setOdrmst_ourmemo(ob.getOdrmst_ourmemo()+"<br/>"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"用户自行取消<br/>");
		    	ob.setOdrmst_canceldate(new Date());
		    	if(!Tools.getManager(ob.getClass()).update(ob, true))
		    	{
		    		out.print("{\"success\":false,\"message\":\"更新订单取消时间失败！\"}");
		    		
		        	  return;
		    	}
	          }
	          catch(Exception ex)
	          {
	        	//  ex.printStackTrace();
	        	  out.print("{\"success\":false,\"message\":\"订单取消失败！\"}");
	        	  return;
	          }
	   
	  
	    	if(list!=null&&list.size()>0)
	    	{
	    		for(OrderItemBase oib:list)
	    		{
	    			if(oib!=null)
	    			{
	    				if(oib.getOdrdtl_tuancardno()!=null&&oib.getOdrdtl_tuancardno().length()>0)
		    			{
		    				Tuandh t=TuandhHelper.getTuandhByCardno(oib.getOdrdtl_tuancardno().trim());
		    				if(t!=null)
		    				{
			    				t.setTuandh_status(new Long(0));
			    				t.setTuandh_odrid("");
			    				t.setTuandh_memo(t.getTuandh_memo()+orderid);
			    				
			    				if(!Tools.getManager(Tuandh.class).update(t, false))
			    				{
			    					 out.print("{\"success\":false,\"message\":\"优惠券失败！\"}");
			    					 return;
			    				}
		    				}
		    			}
	    			}
	    			
	    		}
	    			//update tuandh set tuandh_status=0,tuandh_odrid='',tuandh_memo=tuandh_memo+odrdtl_odrid from tuandh join   
	    				//	 odrdtl on tuandh_cardno=odrdtl_tuancardno 
	    				//	where (odrdtl_tuancardno is not null and odrdtl_tuancardno <>'') and odrdtl_odrid=@odrid    判断odrdtl_tuancardno
	    
	    	}
	    	
	    }
	    	
	    	
		    //Tools.getManager(ob.getClass()).clearListCache(ob);
		    //ob.setOdrmst_orderstatus(new Long(-1));
		    //ob.setOdrmst_tktid(new Long(0));
		    //ob.setOdrmst_tktvalue(new Float(0));
		    //ob.setOdrmst_prepayvalue(new Float(0));
		    //if(Tools.getManager(ob.getClass()).update(ob,true))
		    //{
		    	//恢复券
		    //	if(ob.getOdrmst_tktid()!=null&&ob.getOdrmst_tktid()>0)
		    //	{
		   // 	  Ticket t= TicketHelper.getById(ob.getOdrmst_tktid().toString());
		    //	  Tools.getManager(t.getClass()).clearListCache(t);
		    //	  t.setTktmst_validflag(new Long(0));
		    //	  t.setTktmst_uodrid("");
		    //	  Tools.getManager(ob.getClass()).update(ob,true);
		    	  
		    			    		
		    //	}
		    	//恢复预存款
		    //	if(ob.getOdrmst_prepayvalue()!=null&&ob.getOdrmst_prepayvalue()>0)
		    //	{
		    //		Prepay p=new Prepay();
		    //		p.setPrepay_createdate(new Date());
		    //		p.setPrepay_log("恢复订单"+ob.getId()+"所用的预存款");
		    //		p.setPrepay_type(new Long(4));
		    //		p.setPrepay_mbrid(new Long(lUser.getId()));
		    //		p.setPrepay_memo("");
		    //		p.setPrepay_odrid("");
		    //		p.setPrepay_status(new Long(0));
		    //		p.setPrepay_value(ob.getOdrmst_prepayvalue());
		    //		p.setPropay_operator(lUser.getMbrmst_uid());
		   // 		Tools.getManager(p.getClass()).create(p);
		   // 	}
	
	    else
	    {
	    	 out.print("{\"success\":false,\"message\":\"您无权进行此项操作！\"}");
	    	 return;
	    }
		//删除在gdscoll_order表里的数据
		if(ob!=null){
		   ArrayList<Gdscoll_Order> lslist=Gdscoll_OrderHelper.getGdscoll_OrderByOrdid(ob.getId());
		   if(lslist!=null&&lslist.size()>0){
			   for(Gdscoll_Order go:lslist)
			   {
				   if(go!=null){
				     Tools.getManager(Gdscoll_Order.class).delete(go);
				   }
			   }
		   }
		}
		//取消订单时同时删除一个用户只能购买一个的明细
		 ArrayList<BuyLimitDtl> blist= getbuylimitByOrder(lUser.getId(),ob.getId());
		if(blist!=null && blist.size()>0){
			 Tools.getManager(BuyLimitDtl.class).delete(blist.get(0));
		}else{
		Date s=new Date(ob.getOdrmst_orderdate().getTime()-Tools.MINUTE_MILLIS);
		Date e=new Date(ob.getOdrmst_orderdate().getTime()+Tools.MINUTE_MILLIS);
		//System.out.println(Tools.stockFormatDate(s)+">>>>>");
		ArrayList<BuyLimitDtl> buylist= getbuylimit (lUser.getId(),s,e);
		   if(buylist!=null && buylist.size()>0){
			  // System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQq");
		  
			   BuyLimitDtl bl=buylist.get(0);
			   Tools.getManager(BuyLimitDtl.class).delete(bl);
		   }
		}
	    out.print("{\"success\":true,\"message\":\"订单取消成功！\"}");
    }
    else
    {
    	 out.print("{\"success\":false,\"message\":\"参数不正确\"}");
    	 return;
    }
    	
%>