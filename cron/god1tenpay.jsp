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

public static OrderBase getorderlist(String orderid){
	OrderBase odrbase=null;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("odrmst_oldodrid", orderid));//d1订单号
	
	List<BaseEntity> b_list = Tools.getManager(OrderMain.class).getList(clist, null, 0, 10);
	
	if(b_list!=null){
		for(BaseEntity be:b_list){
			
			odrbase=(OrderBase)be;
			if((odrbase.getOdrmst_orderstatus().longValue()==3
					||odrbase.getOdrmst_orderstatus().longValue()==31)&&
					!Tools.isNull(odrbase.getOdrmst_d1shipmethod())&&
					odrbase.getOdrmst_goodsodrid()!=null&&
					odrbase.getOdrmst_goodsodrid().trim().length()>0){
				return odrbase;
				
			}
		}
	}	
b_list = Tools.getManager(OrderRecent.class).getList(clist, null, 0, 10);
	
	if(b_list!=null){
		for(BaseEntity be:b_list){
			
			odrbase=(OrderBase)be;
			if((odrbase.getOdrmst_orderstatus().longValue()==3
					||odrbase.getOdrmst_orderstatus().longValue()==31)&&
					!Tools.isNull(odrbase.getOdrmst_d1shipmethod())&&
					odrbase.getOdrmst_goodsodrid()!=null&&
					odrbase.getOdrmst_goodsodrid().trim().length()>0){
				return odrbase;
				
			}
		}
	}
	
     return null;
}
/**
 * 自己发货，即发货状态同步。每隔一段时间同步一次！根据情况而定！
 * 
 * @throws Exception
 */
public synchronized void orderStateSyncGoTenpay(HttpSession session) throws Exception{
	System.out.println("聚惠同步发货状态...");
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("status", new Long(1)));//状态为0的财付通订单表示没有同步过发货状态
	//clist.add(Restrictions.eq("d1OrderId", "191646083201"));//状态为0的财付通订单表示没有同步过发货状态
	
	List<BaseEntity> list = Tools.getManager(OrderTenpay.class).getList(clist, null, 0, 10000);
	//System.out.println("d1gjlteset"+list.size());
	if(list!=null&&list.size()>0){
		
		String aaa="";
		for(BaseEntity b:list){
			
			OrderTenpay ot = (OrderTenpay)b;
			//System.out.println(tenpaytrue(ot.getD1OrderId())+"同步发货状态..."+ot.getStatus());

			if(ot.getStatus().longValue()!=1)continue;
			if(!tenpaytrue(ot.getD1OrderId()))continue;
			String d1OrderId = ot.getD1OrderId();
			OrderBase order1 = getorderlist(d1OrderId);
			
			if(order1!=null){//订单存在
				
				if((order1.getOdrmst_orderstatus().longValue()==3
						||order1.getOdrmst_orderstatus().longValue()==31)&&
						!Tools.isNull(order1.getOdrmst_d1shipmethod())&&
						order1.getOdrmst_goodsodrid()!=null&&
						order1.getOdrmst_goodsodrid().trim().length()>0){//实际发货状态
					//System.out.println("同步发货状态..."+order1.getId()+order1.getOdrmst_d1shipmethod()+" 运单号="+order1.getOdrmst_goodsodrid()+" 订单状态="+order1.getOdrmst_orderstatus());

					String shipNumber = order1.getOdrmst_goodsodrid();//运单号
					String  shipmethod= order1.getOdrmst_d1shipmethod();
					//String shipNumber = "E123456";
					String postCode="999";
					String postTenpay = "其他";
					String postTele="";
					/*
					
顺丰快递
申通快递
广州宅急送
全峰快递
圆通速递
广州圆通
中通快递
韵达快运
广州中通
EMS
广州韵达
广州申通
宅急送
1	EMS	11185	http://www.ems.com.cn
2	顺丰	4008111111	http://www.sf-express.com
3	申通	021-39206666	http://www.sto.cn
4	圆通	021-69777888	http://www.yto.net.cn
5	韵达	021-62215588	http://www.yundaex.com
6	宅急送	4006789000	http://www.zjs.com.cn
7	中通	021-59130908	http://www.zto.cn
8	中铁
95105366	http://www.cre.cn
999	其他		

					*/
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
					results.add("transaction_id="+ot.getTenpayOrderId());
					results.add("sp_billno="+ot.getD1OrderId());
					results.add("transport_code="+postCode);
					results.add("transport_info="+postTenpay);
					//results.add("transport_billno="+order1.getOdrmst_goodsodrid());
					results.add("transport_billno="+shipNumber);
					results.add("transport_phone="+postTele);
					
					// System.out.println("<br/>"+results);
					//整理返回字符串编码
				    //System.out.println("55555");
				   Collections.sort(results);
				
			        String signtype = "";
			    
			        if(results!=null){
			        	for(String x:results){
			        		
			        		signtype+=x+"&";
			        	
			        	}
			        }
			        if(signtype.indexOf("&")==0)
			        {
			          signtype=signtype.substring(1, signtype.length());
			        }
			        
			       signtype+="sign="+com.d1.util.MD5.to32MD5(signtype+"key=qimenghaoyed1234567ymzou51665136");
			       // signtype+="sign="+com.d1.util.MD5.to32MD5(signtype+"key=123456");
				       
		            //String reend=HttpUtil.getUrlContentByPost("http://113.108.1.170/app/merchant/notify",signtype, "UTF-8");
		           // String reend=HttpUtil.getUrlContentByGet(StringUtils.encodeUrl("http://113.108.1.170/app/merchant/notify?"+signtype,"GBK"),"GBK");
		            String reend=HttpUtil.getUrlContentByGet(StringUtils.encodeUrl("http://juhui.tenpay.com/app/merchant/notify?"+signtype,"GBK"),"GBK");
		           //System.out.println("d1gjl:"+reend);
		            reend=reend.substring(reend.indexOf("<retcode>")+9,reend.indexOf("</retcode>"));
		           
		            if(reend.equals("0"))
		            {
						//修改同步状态
						System.out.print("聚惠同步发货成功:"+order1.getId()+"");
						Tools.getManager(OrderTenpay.class).clearListCache(ot);
						ot.setStatus(new Long(2));
						Tools.getManager(OrderTenpay.class).update(ot, true);
						
		            }	
		            
					//System.out.println(reend);	
					//aaa+=HttpUtil.getUrlContentByPost("http://113.108.1.170/app/merchant/notify", signtype, "UTF-8");
					
				}else{
					if(order1.getOdrmst_orderstatus().longValue()<0){
						Tools.getManager(OrderTenpay.class).clearListCache(ot);
						ot.setStatus(new Long(-1));
						Tools.getManager(OrderTenpay.class).update(ot, true);
					}
					
				}
				}else{
				//System.out.println("d1订单不存在，修改订单状态失败。orderid="+d1OrderId);
				aaa+="d1订单不存在，修改订单状态失败";
				
			}
			
		}
		//return aaa;
		
	}
	//return "没有要同步的数据";
	
}




%>


<%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
    orderStateSyncGoTenpay(request.getSession());
}
%>