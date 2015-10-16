<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "-1");
}else{

String m_strTktid = null;//默认的优惠券ID
boolean m_iHdtjMemoFlag = false;//是否有活动特价标志。
float m_fltGdsAllMoney = CartHelper.getNormalProductMoney(request,response);//团购商品不参与优惠券的金额
boolean m_iIfHaveTkt = false;//是否有优惠券。
List<Ticket> list1 = TicketHelper.getAllLoginUserAvaiableTickets(request,response,"");
List<TicketCrd> list2 = TicketHelper.getAllLoginUserAvaiableTicketCrds(request,response,"");
int status=0;
JSONArray jsonarr=new JSONArray();
if(list1 != null && !list1.isEmpty()){
	
	for(Ticket ticket : list1){
	JSONObject jsonitem=new JSONObject();
		PayMethod pay = null;
		String shopcode=ticket.getTktmst_shopcodes();
		
		if(Tools.isNull(shopcode))shopcode="00000000";
		String shopname="不限";
		if(!shopcode.equals("11111111")){
		   ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
		   if(shpmst!=null){
			   shopname=shpmst.getShpmst_shopname();
		   }
		}
		float cartMoney_2344 = 0f ;//可以打折的商品总金额
		if(!Tools.isNull(ticket.getTktmst_sprckcodeStr()))cartMoney_2344=CartHelper.getCartSprckcodePayMoney(request, response, ticket.getTktmst_sprckcodeStr());
		else if (ticket.getTktmst_brandname()!=null&&ticket.getTktmst_brandname().length()>0){
			cartMoney_2344=CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktmst_brandname().trim(),shopcode);
			}
		else if(Tools.isNull(ticket.getTktmst_rackcode())||"000".equals(ticket.getTktmst_rackcode()))cartMoney_2344=CartHelper.getShopNormalProductMoney(request,response,shopcode);
		else cartMoney_2344=CartHelper.getTotalRackcodePayMoney2(request,response,ticket.getTktmst_rackcode(),shopcode);
		
		if(cartMoney_2344<ticket.getTktmst_gdsvalue())continue;
		
		if(Tools.longValue(ticket.getTktmst_payid()) != -1){
			pay = PayMethodHelper.getById(String.valueOf(ticket.getTktmst_payid()));
			if(pay == null) continue;
		}
		if(status==0)status=1;
		jsonitem.put("tkt_type",1);
		jsonitem.put("tkt_id",ticket.getId());
		jsonitem.put("tkt_value",ticket.getTktmst_value());
		jsonitem.put("tkt_gdsvalue",ticket.getTktmst_gdsvalue());
		jsonitem.put("tkt_memo","满"+Tools.getFormatMoney(Tools.floatValue(ticket.getTktmst_gdsvalue()))+"元使用");
		jsonitem.put("tkt_shopname",shopname);
		
		jsonarr.add(jsonitem);
	}
}
if(list2 != null && !list2.isEmpty() && CartHelper.getShopNormalProductMoney(request, response,"00000000")>0){
	
	float m_fltGdsAllMoney2=0f;
	m_fltGdsAllMoney2=CartHelper.getShopNormalProductMoney(request, response,"00000000");

	for(TicketCrd ticket : list2){
		JSONObject jsonitem=new JSONObject();
		
		if (ticket.getTktcrd_brandname()!=null&&ticket.getTktcrd_brandname().length()>0){
			if(CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktcrd_brandname().trim(),"00000000")>0){
				m_fltGdsAllMoney=CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktcrd_brandname().trim(),"00000000");
			}
			else{
				continue;
				
			}
		}
		if(!Tools.isNull(ticket.getTktcrd_rackcode())&&!"000".equals(ticket.getTktcrd_rackcode())){
			m_fltGdsAllMoney=CartHelper.getTotalRackcodePayMoney2(request,response,ticket.getTktcrd_rackcode(),"00000000");
			if(m_fltGdsAllMoney<=0){
				continue;
			}
		}
		float fltTktcrdDiscount = Tools.floatValue(ticket.getTktcrd_discount());
		long iTktCrdRealValue = Tools.longValue(ticket.getTktcrd_realvalue());
		float iTkt_value = Tools.getFloat(m_fltGdsAllMoney*fltTktcrdDiscount,2);
		iTkt_value=Tools.getFloat(iTkt_value, 0);
		if(ticket.getTktcrd_realvalue()!=null){
			if(iTkt_value>ticket.getTktcrd_realvalue().floatValue())iTkt_value=Tools.getFloat(ticket.getTktcrd_realvalue().floatValue(),2);
		}
		if(status==0)status=1;
		jsonitem.put("tkt_type",2);
		jsonitem.put("tkt_id",ticket.getId());
		jsonitem.put("tkt_value",iTkt_value);
		jsonitem.put("tkt_gdsvalue",0);
		jsonitem.put("tkt_memo","按商品金额"+NumberUtils.getMaxPrice(fltTktcrdDiscount*100)+"%减免"+iTkt_value+"元");
		jsonitem.put("tkt_shopname","优尚网自营");
		jsonarr.add(jsonitem);
	}
}
if(status>0){
	json.put("status", "1");
	json.put("tickets",jsonarr);
}else{
	json.put("status", "0");
}

}
out.print(json);
%>