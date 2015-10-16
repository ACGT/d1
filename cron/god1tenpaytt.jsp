<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.io.*"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.criterion.SimpleExpression"%>

<%@page import="com.d1.bean.OrderBase"%>
<%@page import="com.d1.bean.OrderMain"%>
<%@page import="com.d1.bean.OrderCache"%>
<%@page import="com.d1.bean.OrderRecent"%>
<%@page import="com.d1.bean.OrderTenpay"%>
<%@page import="com.d1.bean.OrderItemCache"%>
<%@page import="com.d1.bean.Product"%>
<%@page import="com.d1.dbcache.core.BaseEntity"%>
<%@page import="com.d1.helper.SkuHelper"%>
<%@page import="com.d1.service.OrderTmallService"%>
<%@page import="com.d1.util.*"%>

<%@page import="java.net.*" %>



<%!
public static boolean tenpaytrue(String orderid){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("d1OrderId", orderid));//d1订单号
	
	List<BaseEntity> list = Tools.getManager(OrderTenpay.class).getList(clist, null, 0, 10000);
	boolean Tenpaystatus=true;
	if(list!=null&&list.size()>0){
		for(BaseEntity b:list){
			
			OrderTenpay ot = (OrderTenpay)b;
			if (ot.getStatus().longValue()==0){
		   Tenpaystatus=false;
		}
		}
		}

     return Tenpaystatus;
}
/**
 * 自己发货，即发货状态同步。每隔一段时间同步一次！根据情况而定！
 * 
 * @throws Exception
 */
public synchronized void orderStateSyncGoTenpay(HttpSession session) throws Exception{
	

			String d1OrderId ="130114000233";
			
			OrderBase order1 = (OrderMain)Tools.getManager(OrderMain.class).get(d1OrderId);
	
		
			if(order1!=null){//订单存在
				
				//System.out.println("同步发货状态..."+order1.getId()+" 运单号="+order1.getOdrmst_goodsodrid()+" 订单状态="+order1.getOdrmst_orderstatus());
				if((order1.getOdrmst_orderstatus().longValue()==3
						||order1.getOdrmst_orderstatus().longValue()==31)&&
						order1.getOdrmst_d1shipmethod()!=null&&
						order1.getOdrmst_goodsodrid()!=null&&
						order1.getOdrmst_goodsodrid().trim().length()>0){//实际发货状态
					String shipNumber = order1.getOdrmst_goodsodrid();//运单号
					String  shipmethod= order1.getOdrmst_d1shipmethod();
					//String shipNumber = "E123456";
					String postCode="999";
					String postTenpay = "其他";
					String postTele="";

					if(shipmethod!=null&&shipmethod.trim().equals("EMS")){ postTenpay="EMS"; postCode="1"; postTele="11185";}
					else if(shipmethod!=null&&(shipmethod.trim().equals("申通快递")
							||shipmethod.trim().equals("广州申通"))){
						postTenpay="申通"; postCode="3"; postTele="021-39206666"; }
					else if(shipmethod!=null&&(shipmethod.trim().equals("广州中通")
							||shipmethod.trim().equals("中通快递")))
						{ postTenpay="中通"; postCode="7"; postTele="021-59130908";}//顺丰
					else if(shipmethod!=null&&shipmethod.trim().equals("顺丰快递"))
						{ postTenpay="顺丰"; postCode="2"; postTele="4008111111";}//顺丰
					else if(shipmethod!=null&&(shipmethod.trim().equals("宅急送")
								||shipmethod.trim().equals("广州宅急送")))
						{ postTenpay="宅急送"; postCode="6"; postTele="4006789000";}//宅急送
					else if(shipmethod!=null&&(shipmethod.trim().equals("圆通速递")
								||shipmethod.trim().equals("广州圆通")))
					    { postTenpay="圆通"; postCode="4"; postTele="021-69777888";}//圆通
					else if(shipmethod!=null&&(shipmethod.trim().equals("韵达快运")
								||shipmethod.trim().equals("广州韵达")))
					    { postTenpay="韵达"; postCode="5"; postTele="021-62215588";}//圆通
					else postTenpay = shipmethod.trim();
					
					//根据运单号规则猜物流公司名字
					/*if(shipNumber.startsWith("E")||shipNumber.startsWith("e")){ postTenpay="EMS"; postCode="1"; postTele="11185";}
					else if((shipNumber.startsWith("36")||shipNumber.startsWith("268")||shipNumber.startsWith("568")||shipNumber.startsWith("468")||shipNumber.startsWith("58"))&&shipNumber.trim().length()==12)
						{  postTenpay="申通"; postCode="3"; postTele="021-39206666"; }
					else if((shipNumber.startsWith("6000")&&shipNumber.trim().length()==10))
						{ postTenpay="其他"; }//乐运通
					else if((shipNumber.startsWith("762")||shipNumber.startsWith("778"))&&shipNumber.trim().length()==12)
						{ postTenpay="中通"; postCode="7"; postTele="021-59130908";}//顺丰
					else if(shipNumber.startsWith("301")&&shipNumber.trim().length()==12)
						{ postTenpay="顺丰"; postCode="2"; postTele="4008111111";}//顺丰
					else if(shipNumber.trim().length()==10&&(shipNumber.startsWith("1")||shipNumber.startsWith("0")||shipNumber.startsWith("97")))
						{ postTenpay="宅急送"; postCode="6"; postTele="4006789000";}//宅急送
					else if(shipNumber.trim().length()==10)
					    { postTenpay="圆通"; postCode="4"; postTele="021-69777888";}//圆通
					else postTenpay = "其他";*/
				
					ArrayList<String> results=new ArrayList<String>();
					results.add("sign_type=md5");
					results.add("service_version=1.0");
					results.add("input_charset=gbk");
					results.add("sign_key_index=1");
					results.add("spid=1212236301");
					results.add("req_seq="+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
					results.add("deliver_result=0");
					results.add("deliver_desc=发货成功");
					results.add("deliver_time="+new SimpleDateFormat("yyyyMMdd").format(order1.getOdrmst_shipdate()==null?new Date():order1.getOdrmst_shipdate()));
					results.add("transport_code="+postCode);
					results.add("transport_info="+postTenpay);
					//results.add("transport_billno="+order1.getOdrmst_goodsodrid());
					results.add("transport_billno="+shipNumber);
					results.add("transport_phone="+postTele);
					
					System.out.println("<br/>"+results);
				
			        
				}
				}else{
				//System.out.println("d1订单不存在，修改订单状态失败。orderid="+d1OrderId);
				//aaa+="d1订单不存在，修改订单状态失败";
				
			}
			
	
	
}




%>


<%
orderStateSyncGoTenpay(request.getSession());


%>