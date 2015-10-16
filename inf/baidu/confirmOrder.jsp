<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="public.jsp"%><%!
/**
 * 对账单--odrmst_cache
 */
public static ArrayList<OrderCache> getOrderCacheList(String orderstatus,String odrid){
	ArrayList<OrderCache> list=new ArrayList<OrderCache>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(orderstatus)));
	listRes.add(Restrictions.eq("odrmst_mbrid", new Long(3285372)));
	listRes.add(Restrictions.gt("odrmst_printflag", new Long(0)));
	if(!Tools.isNull(odrid)){
	listRes.add(Restrictions.eq("odrmst_odrid", odrid));
	}
    List<Order> olist=new ArrayList<Order>();
    olist.add(Order.asc("odrmst_odrid"));
	List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, olist, 0, 100);
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
public static ArrayList<OrderMain> getOrderMainList(String orderstatus,String odrid){
	ArrayList<OrderMain> list=new ArrayList<OrderMain>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(orderstatus)));
	listRes.add(Restrictions.eq("odrmst_mbrid", new Long(3285372)));
	listRes.add(Restrictions.gt("odrmst_printflag", new Long(0)));
	if(!Tools.isNull(odrid)){
	listRes.add(Restrictions.eq("odrmst_odrid", odrid));
	}
    List<Order> olist=new ArrayList<Order>();
    olist.add(Order.asc("odrmst_odrid"));
	List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, olist, 0, 100);
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
	public static ArrayList<OrderRecent> getOrderRecentList(String orderstatus,String odrid){
		ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_orderstatus", new Long(orderstatus)));
		listRes.add(Restrictions.eq("odrmst_mbrid", new Long(3285372)));
		listRes.add(Restrictions.gt("odrmst_printflag", new Long(0)));
		if(!Tools.isNull(odrid)){
		listRes.add(Restrictions.eq("odrmst_odrid", odrid));
		}
	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.asc("odrmst_odrid"));
		List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, olist, 0, 100);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderRecent)be);
		}
		return list;
	}
	

	public static ArrayList<OrderBase> getOrderList(String orderstatus,String odrid){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		ArrayList<OrderCache> listcache=getOrderCacheList(orderstatus,odrid);
		if(listcache!=null){
			for(OrderCache ordercache:listcache){
				list.add(ordercache);
			}
		}
		ArrayList<OrderMain> listmain=getOrderMainList(orderstatus,odrid);
		if(listmain!=null){
			for(OrderMain ordermain:listmain){
				list.add(ordermain);
			}
		}
		ArrayList<OrderRecent> listrecent=getOrderRecentList(orderstatus,odrid);
		if(listrecent!=null){
			for(OrderRecent orderrecent:listrecent){
				list.add(orderrecent);
			}
		}
		if(list==null || list.size()==0){
			return null;
		}
		return list;
	}
	/*status 0同步过来的初始状态，1 已确认，2 已经发货 3，用户已经签收      -1同步失败   -2 用户拒收 
	*/
	public static ArrayList<OdrBaiDu> getOdrBaiDuList(String odrid){
		ArrayList<OdrBaiDu> list=new ArrayList<OdrBaiDu>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ne("odrbaidu_status", new Long(3)));
		listRes.add(Restrictions.ne("odrbaidu_status", new Long(-2)));
		if(!Tools.isNull(odrid)){
			listRes.add(Restrictions.eq("odrbaidu_d1odrid", odrid));
			}
		 List<Order> olist=new ArrayList<Order>();
		 olist.add(Order.asc("id"));
		List<BaseEntity> list2 = Tools.getManager(OdrBaiDu.class).getList(listRes, olist, 0, 100);
			if(list2==null || list2.size()==0){
				return null;
			}
			for(BaseEntity be:list2){
				list.add((OdrBaiDu)be);
			}
			return list;
	}
	public synchronized void GoconfirmOrder(String strheader,String odrid){
		StringBuilder sbgds=new StringBuilder();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		ArrayList<OdrBaiDu> odrlist= getOdrBaiDuList(odrid);
		     sbgds.append("{"+strheader+",");
		     sbgds.append("\"body\":{");
		     sbgds.append("\"order_list\":[");
		     int odrnum=odrlist.size();
		     for(int i=0;i<odrnum;i++){
		    	 OdrBaiDu odrbd=odrlist.get(i);
		      odrid=odrbd.getOdrbaidu_d1odrid();
		     OrderBase odrb=OrderHelper.getById(odrid);
		     if(odrb!=null){
		     sbgds.append("{\"wg_order_id\": \""+odrbd.getOdrbaidu_bdodrid()+"\",");    //微购订单号
		     sbgds.append("\"package_list\":[");
		     sbgds.append("{");
		                               sbgds.append("\"package_id\":\""+odrid+"\",");
		                               sbgds.append("\"create_time\":\""+format.format(odrb.getOdrmst_orderdate())+"\",");
		                               sbgds.append("\"product_list\":[");
		                               List<OrderItemBase> odritemlist=OrderHelper.getOrderItemList(odrid);
		                               if(odritemlist!=null){
		                            	   int odritemnumm=odritemlist.size();
		                            	   for(int j=1;j<odritemnumm;j++){
		                            		   OrderItemBase odritem=odritemlist.get(j);
		                                        sbgds.append("{");
		                                               sbgds.append("\"product_id\":\""+odritem.getOdrdtl_gdsid()+"\",");//商品ID
		                                               sbgds.append("\"product_type\": 0,");//0为普通商品；1为赠品
		                                               sbgds.append("\"price\": \""+Tools.getDouble(odritem.getOdrdtl_finalprice(),2)+"\",");//成交价格
		                                               sbgds.append("\"count\": \""+odritem.getOdrdtl_gdscount()+"\"");     //商品数量
		                                           if((j+1)>=odritemnumm){
		                                               	sbgds.append("}");  	  
		                                            }else{
		                                              sbgds.append("},");
		                                            }
		                                  	   }
		                               }
		                              sbgds.append("],");

		                               sbgds.append("\"post_fee\": \""+Tools.getDouble(odrb.getOdrmst_shipfee(),2)+"\","); //运费，保留小数点后面两位
		                               sbgds.append("\"sub_total\": \""+Tools.getDouble(odrb.getOdrmst_gdsmoney(),2)+"\""); //商品总价
		                               sbgds.append("\"discount\":'0.00',"); //优惠，具体价格
		                               sbgds.append("\"payment\": \""+Tools.getDouble(odrb.getOdrmst_acturepaymoney(),2)+"\","); //订单总价,商品价格+运费-优惠
		                               /*CONFIRM	确认
		                               FAILED	失败，确认失败
		                               SHIPPED	已经发货
		                               RECEIVED	用户已签收
		                               REJECT	用户拒收
		                               CANCELED	已取消*/
		                               String status="CONFIRM";
		                               String can_be="true";
		                               long odrstatus=odrb.getOdrmst_orderstatus().longValue();
		                               long printflag=odrb.getOdrmst_printflag().longValue();
		                               //status 0同步过来的初始状态，1 已确认，2 已经发货 3，用户已经签收      -1同步失败  -2 用户拒收 
		                              if((odrstatus==1||odrstatus==2)&&printflag>0){
		                            	   status="CONFIRM";
		                            	   can_be="false";
		                            	   odrbd.setOdrbaidu_status(new Long(1));
		                            	   Tools.getManager(OdrBaiDu.class).update(odrbd, false);
		                               }else  if(odrstatus==3||odrstatus==31){
		                            	   status="SHIPPED";
		                            	   can_be="false";
		                            	   odrbd.setOdrbaidu_status(new Long(2));
		                            	   Tools.getManager(OdrBaiDu.class).update(odrbd, false);
		                               }else  if(odrstatus==5||odrstatus==51||odrstatus==6||odrstatus==61){
		                            	   status="RECEIVED";
		                            	   can_be="false";
		                            	   odrbd.setOdrbaidu_status(new Long(3));
		                            	   Tools.getManager(OdrBaiDu.class).update(odrbd, false);
		                               }else  if(odrstatus==3||odrstatus==31){
		                            	   status="CANCELED";
		                            	   can_be="false";
		                            	   odrbd.setOdrbaidu_status(new Long(-2));
		                            	   Tools.getManager(OdrBaiDu.class).update(odrbd, false);
		                               }
		                               sbgds.append("\"package_status\": \""+status+"\","); //包裹单状态
		                               sbgds.append("\"can_be_canceled\": "+can_be+",");    //包裹是否可以被取消
		                               sbgds.append("\"need_sms\":false");              //是否需要短信通知客户
		                              sbgds.append("}");
		                      sbgds.append("]");
		             if((i+1)>=odrnum){
		            	sbgds.append("}");  	  
		              }else{
		              sbgds.append("},");
		              }
		        }
		     }
		     sbgds.append(" ]");

		   sbgds.append("}");
		 sbgds.append("}");
		 
		 
		 
		 String retstr=HttpUtil.postData("https://api.baidu.com/json/wg/v1/OrderService/confirmOrder", sbgds.toString(), "utf-8");

		 JSONObject json = JSONObject.fromObject(retstr);
		 String retheader=json.getString("header");
		 JSONObject  jsonheader = JSONObject.fromObject(retheader); 
		 String status=jsonheader.getString("status");
		 String desc=jsonheader.getString("desc");
		 if(!status.equals("0")){
			 String failures=jsonheader.getString("failures");
			  JSONObject failuresjson = JSONObject.fromObject(failures);
		  		int jsonLength = failuresjson.size(); 
		  		for (int i = 0; i < jsonLength; i++) { //创建订单明细
		  			JSONObject itemJson = JSONObject.fromObject(failuresjson.get(i)); 
		  			String content=itemJson.getString("content");
		  			String[] arrcontent=content.split(",");
		  			String errodrid=arrcontent[0];
		  			errodrid=errodrid.substring(12);
		  			OdrBaiDu odrbd2=(OdrBaiDu)Tools.getManager(OdrBaiDu.class).findByProperty("odrbaidu_d1odrid", errodrid);
		  			odrbd2.setOdrbaidu_status(new Long(-1));
		  			Tools.getManager(OdrBaiDu.class).update(odrbd2, false);
		  		}
			 
		 System.out.println("百度微购订单确认失败："+desc);
		 try{
		 FileWriter fw = new FileWriter(new File("/var/baiduerror.txt"),true);
		 fw.write(new Date()+"百度微购订单确认失败订单号："+failures+System.getProperty("line.separator"));
		  fw.flush();
		  fw.close();
		 }catch(Exception e){
			 e.printStackTrace();
		 }
		 }else{
		 	System.out.println("百度微购订单确认成功："+desc);
		 }
	}
	%>
<%
/*
OdrMst_orderstatus 
0：未处理  1：货付已确认 2：已到款 3：全部发货 31：部分发货 5：全部交易完成 51：部分交易完成 6：系统设置全部交易完成 61：系统设置部分交易完成 -1：用户取消 -2：缺货取消
*/
String odrid=request.getParameter("odrid");
String strheader=getHeader();
GoconfirmOrder(strheader,odrid);
%>