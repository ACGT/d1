<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*,java.text.*"%>

<%! 
//得到评价的ID
public static Comment getCommentbyOrderId(String orderId){
	   List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	   listRes.add(Restrictions.eq("gdscom_odrid" , orderId));
	   
	   List list = Tools.getManager(Comment.class).getList(listRes , null , 0 , 1);
	   
	   if(list == null || list.isEmpty()) return null;
	   
	   return (Comment)list.get(0);
}

public static String getthtkLink(String orderid, String suborderid, long thtype, long lstatus) {
	String result = "";
	if(thtype==1) {
		if(lstatus==0) {
			result = "<a href='/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>等您退货</A>";
		}else if(lstatus==1) {
			result = "<a href='/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>已退货（待退款）</A>";
		}else if(lstatus==2) {
			result = "<a href='/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>已退款</A>";
		}
	}else if(thtype==2) {
		if(lstatus==0) {
			result = "<a href='/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>等您退回换货</A>";
		}else if(lstatus==1) {
			result = "<a href='/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>已退货(待换货)</A>";
		}else if(lstatus==2) {
			result = "<a href='/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>换货完成</A>";
		}	
	}
	
	return result;
}

public String getOrderStatuByPaytype1(String orderid, String suborderid, String paytype,String odrstatu)
{
    String result="";
    int type = Tools.parseInt(paytype);
    if(type==1){
		switch(Tools.parseInt(odrstatu))
		{
			case 0:
			{
				result="";
				break;
			}
			case 1:
			{
				result="";
				break;
			}
			case -1:
			case -2:
			{
				result="";
				break;
			}
			case -3:
			{
				result="";
				break;
			}
			case -4:
			{
				result="";
				break;
			}
			case 3:
			case 31:
			{
				result="<a href='/user/thtkorder.jsp?orderid="+orderid+"&subodrid="+suborderid+"' target='_blank' class='a'>退换货处理</a>";
				break;
			}
			case 5:
			case 51:
			case 6:
			case 61:
			{
				result="<a href='/user/thtkorder.jsp?orderid="+orderid+"&subodrid="+suborderid+"' target='_blank' class='a'>退换货处理</a>";
				break;
			}
			default:
			{
				result="";
				break;
			}
		}
	}
    else
    {
    	switch(Tools.parseInt(odrstatu))
		{
			case 1:
			{
				result="";
				break;
			}
			case -1:
			case -2:
			{
				result="";
				break;
			}
			case -3:
			{
				result="";
				break;
			}
			case -4:
			{
				result="";
				break;
			}
			case 2:
				result="";
				break;
			case 3:
			case 31:
			{
				result="<a href='/user/thtkorder.jsp?orderid="+orderid+"&subodrid="+suborderid+"' target='_blank' class='a'>退换货处理</a>";
				break;
			}
			case 5:
			case 51:
			case 6:
			case 61:
			{
				result="<a href='/user/thtkorder.jsp?orderid="+orderid+"&subodrid="+suborderid+"' target='_blank' class='a'>退换货处理</a>";
				break;
			}
			default:
			{
				result="";
				break;
			}
		}
    }
	return result;
}


    //根据付款类型和订单状态获取显示的订单状态
    public String getOrderStatuByPaytype(String paytype,String odrstatu)
	{
	    String result="";
	    int type = Tools.parseInt(paytype);
	    if(type==1){
			switch(Tools.parseInt(odrstatu))
			{
				case 0:
				{
					result="订单待审核";
					break;
				}
				case 1:
				{
					result="订单已确认<br/>库房配货中";
					break;
				}
				case -1:
				case -2:
				{
					result="用户取消";
					break;
				}
				case -3:
				{
					result="客服取消";
					break;
				}
				case -4:
				{
					result="系统取消";
					break;
				}
				case 3:
				case 31:
				{
					result="已发货";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					result="已完成";
					break;
				}
				default:
				{
					result="订单待审核";
					break;
				}
			}
		}
	    else
	    {
	    	switch(Tools.parseInt(odrstatu))
			{
				case 1:
				{
					result="库房备货中";
					break;
				}
				case -1:
				case -2:
				{
					result="用户取消";
					break;
				}
				case -3:
				{
					result="客服取消";
					break;
				}
				case -4:
				{
					result="系统取消";
					break;
				}
				case 2:
					result="已支付";
					break;
				case 3:
				case 31:
				{
					result="已发货";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					result="已完成";
					break;
				}
				default:
				{
					result="等待付款";
					break;
				}
			}
	    }
		return result;
	}
    
    public String getOrderStatuByPaytype4(long orderid, String paytype,String odrstatu)
	{
	    String result="";
	    int type = Tools.parseInt(paytype);
	    if(type==1){
			switch(Tools.parseInt(odrstatu))
			{
				case 0:
				{
					result="订单待审核";
					break;
				}
				case 1:
				{
					result="订单已确认<br/>库房配货中";
					break;
				}
				case -1:
				case -2:
				{
					result="用户取消";
					break;
				}
				case -3:
				{
					result="客服取消";
					break;
				}
				case -4:
				{
					result="系统取消";
					break;
				}
				case 3:
				case 31:
				{
					result="已发货";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					result="已完成";
					break;
				}
				default:
				{
					result="订单待审核";
					break;
				}
			}
		}
	    else
	    {
	    	switch(Tools.parseInt(odrstatu))
			{
				case 1:
				{
					result="库房备货中";
					break;
				}
				case -1:
				case -2:
				{
					result="用户取消";
					break;
				}
				case -3:
				{
					result="客服取消";
					break;
				}
				case -4:
				{
					result="系统取消";
					break;
				}
				case 2:
					result="已支付";
					break;
				case 3:
				case 31:
				{
					result="已发货";
					result+="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\" class=\"a\">确认收货并评价</a>";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					result="已完成";
					break;
				}
				default:
				{
					result="等待付款";
					break;
				}
			}
	    }
		return result;
	}
   //根据付款类型获取付款方式的显示
    public String getPayMethod(String Paytype)
    {
    	String result="";
    	switch(Tools.parseInt(Paytype))
    	{
              case 1:
              {
            	  result="货到付款";
            	  break;
              }
              case 2:
              {
            	  result="邮局汇款";
            	  break; 
              }
              case 3:
              {
            	  result="银行电汇";
            	  break;
              }
              default:
              {
                 result="在线支付";
                 break;
              }
    	}
    	return result;
    	
    }
   
    int getMyShowByOrder(String odrid,String gdsid,String odtlid){
    	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
    	listRes.add(Restrictions.eq("myshow_odrid", odrid));
    	listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
    	listRes.add(Restrictions.eq("myshow_subodrid", odtlid));
    	return Tools.getManager(MyShow.class).getLength(listRes);
    	
    }
    //是否显示“我要晒单”
  public  boolean isShowOrder(String odrid){
    	List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(odrid.trim());
    	if(list==null || list.size()==0){
    		return false;
    	}
    	for(OrderItemBase item:list){
    		if(item.getOdrdtl_shipstatus()>=1){//未取消的商品
    			if(getMyShowByOrder(item.getOdrdtl_odrid(),item.getOdrdtl_gdsid(),item.getId())==0){
    				return true;
    			}
    		}
    		
    	}
     return false;
    }
    public String getOpreatBypayandstatus(String paymethod,String orderstatus,String orderid,String flag)
    {
    	String result="";
        OrderBase ob=OrderHelper.getById(orderid);
        if(ob==null)
        {
        	ob=OrderHelper.getHistoryById(orderid);
        }
        int ps = 0;
        
        boolean isShowPayButton = false;
        if(ob!=null)
        {
        	double fltActurePayMoney = Tools.doubleValue(ob.getOdrmst_acturepaymoney());//
        	long payId = Tools.longValue(ob.getOdrmst_payid());//支付方式
        	long strOrderStatus = Tools.longValue(ob.getOdrmst_orderstatus());//支付状态
        	
        	if(payId == 29){
        		isShowPayButton = true;//万里通支付
        		ps = 6;
        	}
        	
        	if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43) || (payId >= 45 && payId <= 58))){
        		isShowPayButton = true;
    			switch ((int)payId){
    				case 4:
    				case 6:
    				case 25:
    				case 26:
    				case 27:
    				
    				
    				case 36:
    				
    				case 38:
    				
    				
    				case 41:
    				case 42:
    				case 43:
    				case 51:
					case 52:
					case 53:
					case 54:
					case 55:
					case 56:
					case 57:
					case 58:
    					ps=2;
    					break;
    				case 20:
    				case 34:
    				case 37:
    				case 40:
    				case 45:
    				case 46:
    				case 47:
    				case 48:
    				case 49:
    				case 50:
    					ps=4;
    					break;
    				case 21:
    					ps=3;
    					break;
    				case 14:
    				case 31:
    					ps=5;
    					break;
    				case 33:
    				case 35:
    				case 39:
    					ps=1;
    					break;
    				default:{
    						ps=1;
    						break;
    					}
    			}
    			SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    			String end2="2012-11-21 00:00:00";
    			try{
    				if(new Date().before(df.parse(end2))){
        				if(payId==27){
        					ps=5;
        				}
        			}
    			}catch(Exception e){
    				
    			}
    			
        	}
        	
        }
    	
    	switch(Tools.parseInt(paymethod))
    	{
    		case 1:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			case 0:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
				case -1:
				case -2:
				case -3:
				case -4:
				{
					//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
					result="----";
					break;
				}
				case 1:
				{
					result="----";
					break;
				}
				case 3:
				case 31:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					Comment com=getCommentbyOrderId(orderid);
					if(com==null)
					{
						result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
					}
					else
					{
						result="----";
						}
					break;
					
				}
				default:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
    			}
    			break;
    		}
    		case 2:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			    case 0:
    			    {
    						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
    						break;
    			    }
		    		
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					
					case 1:
					case 3:
					case 31:
					{
					    result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";

						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		case 3:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
	    			case 0:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
					case -1:
					case -2:
					case -3:
					case -4:			
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					case 1:
					case 3:
					case 31:
					{
						result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		default:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
		    		case 0:
					{
					    //result="<a href=\"\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\"  /></a><br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					    
					    if(ob.getOdrmst_orderdate()!=null)
					    {
					    	Calendar c=Calendar.getInstance();
							c.setTime(ob.getOdrmst_orderdate());
							c.add(Calendar.DATE, 15);
							if(new Date().before(c.getTime()))
							{
								if(ps==6){
									result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

								}else{
								result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								}
							}
							else
							{
								result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								
							}
							
					    	   
					    }
					     break;
					}
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					case 1:
					case 3:
					case 31:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						if(isShowPayButton){
							if(ob.getOdrmst_orderdate()!=null)
						    {
						    	Calendar c=Calendar.getInstance();
								c.setTime(ob.getOdrmst_orderdate());
								c.add(Calendar.DATE, 15);
								if(new Date().before(c.getTime()))
								{
									if(ps==6){
										result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

									}else{
									result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									}
								}
								else
								{
									result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									
								}
								
						    	   
						    }
						}
					    break;
					    
					}
    		  }
    			break;
    	  }
    	}
    	return result;
    }
    public String getOpreatBypayandstatus2(String paymethod,String orderstatus,String orderid,String flag)
    {
    	String result="";
        OrderBase ob=OrderHelper.getById(orderid);
        if(ob==null)
        {
        	ob=OrderHelper.getHistoryById(orderid);
        }
        int ps = 0;
        
        boolean isShowPayButton = false;
        if(ob!=null)
        {
        	double fltActurePayMoney = Tools.doubleValue(ob.getOdrmst_acturepaymoney());//
        	long payId = Tools.longValue(ob.getOdrmst_payid());//支付方式
        	long strOrderStatus = Tools.longValue(ob.getOdrmst_orderstatus());//支付状态
        	
        	if(payId == 29){
        		isShowPayButton = true;//万里通支付
        		ps = 6;
        	}
        	
        	if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43) || (payId >= 45 && payId <= 58))){
        		isShowPayButton = true;
    			switch ((int)payId){
    				case 4:
    				case 6:
    				case 25:
    				case 26:
    				case 27:
    				
    				
    				case 36:
    				
    				case 38:
    				
    				
    				case 41:
    				case 42:
    				case 43:
    				case 51:
					case 52:
					case 53:
					case 54:
					case 55:
					case 56:
					case 57:
					case 58:
    					ps=2;
    					break;
    				case 20:
    				case 34:
    				case 37:
    				case 40:
    				case 45:
    				case 46:
    				case 47:
    				case 48:
    				case 49:
    				case 50:
    					ps=4;
    					break;
    				case 21:
    					ps=3;
    					break;
    				case 14:
    				case 31:
    					ps=5;
    					break;
    				case 33:
    				case 35:
    				case 39:
    					ps=1;
    					break;
    				case 60:
    					ps=6;
    					break;
    				default:{
    						ps=1;
    						break;
    					}
    			}
    			SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    			String end2="2012-11-21 00:00:00";
    			try{
    				if(new Date().before(df.parse(end2))){
        				if(payId==27){
        					ps=5;
        				}
        			}
    			}catch(Exception e){
    				
    			}
        	}
        	
        }
    	
    	switch(Tools.parseInt(paymethod))
    	{
    		case 1:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			case 0:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
				case -1:
				case -2:
				case -3:
				case -4:
				{
					//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
					result="----";
					break;
				}
				case 1:
				{
					result="----";
					break;
				}
				case 3:
				case 31:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"tipdialog1("+orderid+")\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					Comment com=getCommentbyOrderId(orderid);
					if(com==null)
					{
						result="<a href=\"/comment/test.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
					}
					else
					{
						result="----";
						}
					break;
					
				}
				default:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
    			}
    			break;
    		}
    		case 2:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			    case 0:
    			    {
    						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
    						break;
    			    }
		    		
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					
					case 1:
					case 3:
					case 31:
					{
					    result="<a href=\"javascript:void(0)\" onclick=\"tipdialog1("+orderid+")\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";

						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							result="<a href=\"/comment/test.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		case 3:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
	    			case 0:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
					case -1:
					case -2:
					case -3:
					case -4:			
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					case 1:
					case 3:
					case 31:
					{
						result="<a href=\"/comment/test.jsp?orderid="+orderid+"\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							result="<a href=\"/comment/test.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		default:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
		    		case 0:
					{
					    //result="<a href=\"\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\"  /></a><br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					    
					    if(ob.getOdrmst_orderdate()!=null)
					    {
					    	Calendar c=Calendar.getInstance();
							c.setTime(ob.getOdrmst_orderdate());
							c.add(Calendar.DATE, 15);
							if(new Date().before(c.getTime()))
							{
								if(ps==6){
									result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

								}else{
								result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								}
							}
							else
							{
								result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								
							}
							
					    	   
					    }
					     break;
					}
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					case 1:
					case 2:
					case 3:
					case 31:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog1("+orderid+")\"><img src=\"http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg\"  /></a><br/><a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							result="<a href=\"/comment/test.jsp?orderid="+orderid+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/qr_pj.jpg\" style=\"vertical-align:middle;\" /></a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						if(isShowPayButton){
							if(ob.getOdrmst_orderdate()!=null)
						    {
						    	Calendar c=Calendar.getInstance();
								c.setTime(ob.getOdrmst_orderdate());
								c.add(Calendar.DATE, 15);
								if(new Date().before(c.getTime()))
								{
									if(ps==6){
										result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

									}else{
									result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									}
								}
								else
								{
									result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									
								}
								
						    	   
						    }
						}
					    break;
					    
					}
    		  }
    			break;
    	  }
    	}
    	return result;
    }
    public String getOpreatBypayandstatus1(String paymethod,String orderstatus,String orderid,String flag)
    {
    	String result="";
        OrderBase ob=OrderHelper.getById(orderid);
        if(ob==null)
        {
        	ob=OrderHelper.getHistoryById(orderid);
        }
        int ps = 0;
        
        boolean isShowPayButton = false;
        if(ob!=null)
        {
        	double fltActurePayMoney = Tools.doubleValue(ob.getOdrmst_acturepaymoney());//
        	long payId = Tools.longValue(ob.getOdrmst_payid());//支付方式
        	long strOrderStatus = Tools.longValue(ob.getOdrmst_orderstatus());//支付状态
        	
        	if(payId == 29){
        		isShowPayButton = true;//万里通支付
        		ps = 6;
        	}
        	
        	if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43) || (payId >= 45 && payId <= 58))){
        		isShowPayButton = true;
    			switch ((int)payId){
    				case 4:
    				case 6:
    				case 25:
    				case 26:
    				case 27:
    				
    				
    				case 36:
    				
    				case 38:
    				
    				
    				case 41:
    				case 42:
    				case 43:
    				case 51:
					case 52:
					case 53:
					case 54:
					case 55:
					case 56:
					case 57:
					case 58:
    					ps=2;
    					break;
    				case 20:
    				case 34:
    				case 37:
    				case 40:
    				case 45:
    				case 46:
    				case 47:
    				case 48:
    				case 49:
    				case 50:
    					ps=4;
    					break;
    				case 21:
    					ps=3;
    					break;
    				case 14:
    				case 31:
    					ps=5;
    					break;
    				case 33:
    				case 35:
    				case 39:
    					ps=1;
    					break;
    				case 60:
    					ps=6;
    					break;
    				default:{
    						ps=1;
    						break;
    					}
    			}
    			SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    			String end2="2012-11-21 00:00:00";
    			try{
    				if(new Date().before(df.parse(end2))){
        				if(payId==27){
        					ps=5;
        				}
        			}
    			}catch(Exception e){
    				
    			}
        	}
        	
        }
    	
    	switch(Tools.parseInt(paymethod))
    	{
    		case 1:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			case 0:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
				case -1:
				case -2:
				case -3:
				case -4:
				{
					//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
					result="----";
					break;
				}
				case 1:
				{
					result="----";
					break;
				}
				case 3:
				{
					//全部发货的时候显示退换货处理
					result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					break;
				}
				case 31:
				{

					//4个月内才能评价
					if(OrderHelper.getHistoryById(orderid)==null){
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\" class=\"a\">确认收货并评价</a>";
					}
					
					//System.out.println(orderid+isShowOrder(orderid));
					if(isShowOrder(orderid)){
						
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
					}
					result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
					//退换货申请
					result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					Comment com=getCommentbyOrderId(orderid);
					if(com==null && OrderHelper.getHistoryById(orderid)==null){
					result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
					if(isShowOrder(orderid)){
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						//退换货申请
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					}
					}else if(isShowOrder(orderid)){
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						//退换货申请
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					}
					else
					{
						result="----";
					}
					
					break;
					
				}
				default:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
    			}
    			break;
    		}
    		case 2:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			    case 0:
    			    {
    						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
    						break;
    			    }
		    		
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					
					case 1:
					case 3:
					{
						//全部发货的时候显示退换货处理
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 31:
					{
						if(OrderHelper.getHistoryById(orderid)==null&&Tools.parseInt(orderstatus)!=1){
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\" class=\"a\">确认收货并评价</a>";
						if(isShowOrder(orderid)){
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						}
						}
						result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						//退换货申请
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null && OrderHelper.getHistoryById(orderid)==null){

							result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
							 if(isShowOrder(orderid)){
									//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
								//退换货申请
								result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
								}
						}else if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		case 3:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
	    			case 0:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
					case -1:
					case -2:
					case -3:
					case -4:			
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					case 1:
					case 3:
					{
						//全部发货的时候显示退换货处理
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 31:
					{
						if(OrderHelper.getHistoryById(orderid)==null&&Tools.parseInt(orderstatus)!=1){
						result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" class=\"a\">确认收货并评价</a>";
						if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						}
						}
						result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						//退换货申请
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							if(OrderHelper.getHistoryById(orderid)==null){
						result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
						if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}
						}else if(isShowOrder(orderid)){
								//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
							}
						}
						else
						{
							result="----";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		default:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
		    		case 0:
					{
					    //result="<a href=\"\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\"  /></a><br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					    
					    if(ob.getOdrmst_orderdate()!=null)
					    {
					    	Calendar c=Calendar.getInstance();
							c.setTime(ob.getOdrmst_orderdate());
							c.add(Calendar.DATE, 15);
							if(new Date().before(c.getTime()))
							{
								if(ps==6){
									result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

								}else{
								result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								}
							}
							else
							{
								result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								
							}
							
					    	   
					    }
					     break;
					}
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="----";
						break;
					}
					case 1:
					case 2:
					case 3:
					{
						//全部发货的时候显示退换货处理
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 31:
					{
						if(OrderHelper.getHistoryById(orderid)==null&&Tools.parseInt(orderstatus)!=1&&Tools.parseInt(orderstatus)!=2){
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\"  class=\"a\">确认收货并评价</a>";
						if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						}
						}
						result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						//退换货申请
						result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null && OrderHelper.getHistoryById(orderid)==null)
						{
					result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
					 if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						//退换货申请
							result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}	
						}else if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}
					
						else
						{
							result="----";

							}


						break;
					}
					default:
					{
						if(isShowPayButton){
							if(ob.getOdrmst_orderdate()!=null)
						    {
						    	Calendar c=Calendar.getInstance();
								c.setTime(ob.getOdrmst_orderdate());
								c.add(Calendar.DATE, 15);
								if(new Date().before(c.getTime()))
								{
									if(ps==6){
										result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

									}else{
									result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									}
								}
								else
								{
									result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									
								}
								
						    	   
						    }
						}
					    break;
					    
					}
    		  }
    			break;
    	  }
    	}
    	return result;
    }
    
      
    public String getOpreatBypayandstatus3(String paymethod,String orderstatus,String orderid,String flag)
    {
    	String result="";
        OrderBase ob=OrderHelper.getById(orderid);
        if(ob==null)
        {
        	ob=OrderHelper.getHistoryById(orderid);
        }
        int ps = 0;
        
        boolean isShowPayButton = false;
        if(ob!=null)
        {
        	double fltActurePayMoney = Tools.doubleValue(ob.getOdrmst_acturepaymoney());//
        	long payId = Tools.longValue(ob.getOdrmst_payid());//支付方式
        	long strOrderStatus = Tools.longValue(ob.getOdrmst_orderstatus());//支付状态
        	
        	if(payId == 29){
        		isShowPayButton = true;//万里通支付
        		ps = 6;
        	}
        	
        	if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43) || (payId >= 45 && payId <= 58))){
        		isShowPayButton = true;
    			switch ((int)payId){
    				case 4:
    				case 6:
    				case 25:
    				case 26:
    				case 27:
    				
    				
    				case 36:
    				
    				case 38:
    				
    				
    				case 41:
    				case 42:
    				case 43:
    				case 51:
					case 52:
					case 53:
					case 54:
					case 55:
					case 56:
					case 57:
					case 58:
    					ps=2;
    					break;
    				case 20:
    				case 34:
    				case 37:
    				case 40:
    				case 45:
    				case 46:
    				case 47:
    				case 48:
    				case 49:
    				case 50:
    					ps=4;
    					break;
    				case 21:
    					ps=3;
    					break;
    				case 14:
    				case 31:
    					ps=5;
    					break;
    				case 33:
    				case 35:
    				case 39:
    					ps=1;
    					break;
    				case 60:
    					ps=6;
    					break;
    				default:{
    						ps=1;
    						break;
    					}
    			}
    			SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    			String end2="2012-11-21 00:00:00";
    			try{
    				if(new Date().before(df.parse(end2))){
        				if(payId==27){
        					ps=5;
        				}
        			}
    			}catch(Exception e){
    				
    			}
        	}
        	
        }
    	
    	switch(Tools.parseInt(paymethod))
    	{
    		case 1:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			case 0:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
				case -1:
				case -2:
				case -3:
				case -4:
				{
					//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
					result="";
					break;
				}
				case 1:
				{
					result="";
					break;
				}
				case 3:
				{
					//全部发货的时候显示退换货处理
					//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					result = "<a href='javascript:void(0)' onclick='tipdialog(188220092125)''><img src='http://images.d1.com.cn/images2012/New/user/qrsh_pj.jpg' width='114' height='27' style='vertical-align:middle;''></a>";
					break;
				}
				case 31:
				{

					//4个月内才能评价
					if(OrderHelper.getHistoryById(orderid)==null){
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\" class=\"a\">确认收货并评价</a>";
					}
					
					//System.out.println(orderid+isShowOrder(orderid));
					if(isShowOrder(orderid)){
						
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
					}
					result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
					//退换货申请
					//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					break;
				}
				case 5:
				case 51:
				case 6:
				case 61:
				{
					Comment com=getCommentbyOrderId(orderid);
					if(com==null && OrderHelper.getHistoryById(orderid)==null){
					result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
					if(isShowOrder(orderid)){
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						//退换货申请
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					}
					}else if(isShowOrder(orderid)){
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						//退换货申请
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
					}
					else
					{
						result="";
					}
					
					break;
					
				}
				default:
				{
					result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					break;
				}
    			}
    			break;
    		}
    		case 2:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
    			    case 0:
    			    {
    						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
    						break;
    			    }
		    		
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="";
						break;
					}
					
					case 1:
					case 3:
					{
						//全部发货的时候显示退换货处理
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 31:
					{
						if(OrderHelper.getHistoryById(orderid)==null&&Tools.parseInt(orderstatus)!=1){
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\" class=\"a\">确认收货并评价</a>";
						if(isShowOrder(orderid)){
						//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						}
						}
						result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						//退换货申请
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null && OrderHelper.getHistoryById(orderid)==null){

							result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
							 if(isShowOrder(orderid)){
									//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
								//退换货申请
								//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
								}
						}else if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}
						else
						{
							result="";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		case 3:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
	    			case 0:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
					case -1:
					case -2:
					case -3:
					case -4:			
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="";
						break;
					}
					case 1:
					case 3:
					{
						//全部发货的时候显示退换货处理
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 31:
					{
						if(OrderHelper.getHistoryById(orderid)==null&&Tools.parseInt(orderstatus)!=1){
						result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" class=\"a\">确认收货并评价</a>";
						if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						}
						}
						result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						//退换货申请
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null)
						{
							if(OrderHelper.getHistoryById(orderid)==null){
						result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
						if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}
						}else if(isShowOrder(orderid)){
								//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
							}
						}
						else
						{
							result="";
							}
						break;
					}
					default:
					{
						result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
						break;
					}
    			}
    			break;
    		}
    		default:
    		{
    			switch(Tools.parseInt(orderstatus))
    			{
		    		case 0:
					{
					    //result="<a href=\"\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\"  /></a><br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
					    system.out.println("d1gjl=============001");
					    if(ob.getOdrmst_orderdate()!=null)
					    {
					    	Calendar c=Calendar.getInstance();
							c.setTime(ob.getOdrmst_orderdate());
							c.add(Calendar.DATE, 15);
							if(new Date().before(c.getTime()))
							{
								system.out.println("d1gjl====002=========ps=="+ps);
								if(ps==6){
									result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

								}else{
								result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								}
							}
							else
							{
								result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
								
							}
							
					    	   
					    }
					     break;
					}
					case -1:
					case -2:
					case -3:
					case -4:
					{
						//result="<a href=\"javascript:void(0)\" onclick=\"RecoverOrderbtn("+orderid+","+flag+")\"  class=\"a\">恢复订单</a>";
						result="";
						break;
					}
					case 1:
					case 2:
					case 3:
					{
						//全部发货的时候显示退换货处理
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 31:
					{
						if(OrderHelper.getHistoryById(orderid)==null&&Tools.parseInt(orderstatus)!=1&&Tools.parseInt(orderstatus)!=2){
						result="<a href=\"javascript:void(0)\" onclick=\"tipdialog("+orderid+")\"  class=\"a\">确认收货并评价</a>";
						if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						}
						}
						result+="<a href=\"/user/orderdetail.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">订单追踪</a>";
						//退换货申请
						//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						break;
					}
					case 5:
					case 51:
					case 61:
					case 6:
					{
						Comment com=getCommentbyOrderId(orderid);
						if(com==null && OrderHelper.getHistoryById(orderid)==null)
						{
					result="<a href=\"/comment/addcomment.jsp?orderid="+orderid+"\" target=\"_blank\"  class=\"a\">立即评价</a>";
					 if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
						//退换货申请
							//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}	
						}else if(isShowOrder(orderid)){
							//result+="<a href=\"/ShowOrder/showorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">我要晒单</a>";
							//退换货申请
							//result+="<a href=\"/user/thtkorder.jsp?orderid="+orderid+"\" target=\"_blank\" class=\"a\">退换货处理</a>";
						}
					
						else
						{
							result="";

							}


						break;
					}
					default:
					{
						system.out.println("d1gjl=============002");
						if(isShowPayButton){
							if(ob.getOdrmst_orderdate()!=null)
						    {
						    	Calendar c=Calendar.getInstance();
								c.setTime(ob.getOdrmst_orderdate());
								c.add(Calendar.DATE, 15);
								if(new Date().before(c.getTime()))
								{
									system.out.println("d1gjl=============ps=="+ps);
									if(ps==6){
										result="<a href=\"/user/orderdetail.jsp?orderid='"+orderid+"#wxPay'\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" /></a>"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";

									}else{
									result="<input type=\"image\" id=\"send_button\" onclick=\"payOrder2("+ps+",'"+orderid+"',this);\" src=\"http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg\" />"+"<br/><a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									}
								}
								else
								{
									result="<a href=\"javascript:void(0)\" onclick=\"CancleOrderbtn("+orderid+","+flag+")\"  class=\"a\">取消订单</a>";
									
								}
								
						    	   
						    }
						}
					    break;
					    
					}
    		  }
    			break;
    	  }
    	}
    	return result;
    }
%>