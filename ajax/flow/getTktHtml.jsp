<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %>
<%!private static ArrayList<BrandPromotion> getBrandPromotionList(float cartmoney){
	ArrayList<BrandPromotion> list = new ArrayList<BrandPromotion>();
	
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	 clist.add(Restrictions.eq("brdtktmst_validflag",new Long(1)));
	 clist.add(Restrictions.le("brdtktmst_startdate", new Date()));
	 clist.add(Restrictions.ge("brdtktmst_enddate", new Date()));
	 clist.add(Restrictions.le("brdtktmst_gdsvalue",cartmoney));
	 
	 //if(cartmoney>=300&&cartmoney<500)
	 //{
		 //clist.add(Restrictions.ge("brdtktmst_gdsvalue",new Float(300)));
	 //}
	// else if(cartmoney>=500)
	 //{
		// clist.add(Restrictions.ge("brdtktmst_gdsvalue",new Float(500)));
	// }
	 
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("brdtktmst_gdsvalue"));
	 List<BaseEntity> rlist=Tools.getManager(BrandPromotion.class).getList(clist, olist, 0, 500);
	if(rlist==null||rlist.size()==0)return null;
	
	for(BaseEntity b:rlist){
		list.add((BrandPromotion)b);
	}
	
	return list ;
}


%>
<%
String payId = request.getParameter("payId");
String m_strTktid = null;//默认的优惠券ID
boolean m_iHdtjMemoFlag = false;//是否有活动特价标志。
float m_fltGdsAllMoney = CartHelper.getNormalProductMoney(request,response);//团购商品不参与优惠券的金额
boolean m_iIfHaveTkt = false;//是否有优惠券。
float m_fltBrdTktPrice = CartHelper.getBrandCutMoney(request,response);//品牌减免总金额。
//System.out.println("商户活动:"+m_fltBrdTktPrice);

//参加活动的价格推荐位
//float m_bjhdmoney=CartHelper.getbjhdProductMoney(request,response);//半价活动金额。
//System.out.println("半价活动金额:"+m_bjhdmoney);
float m_bjhdmoney=0f;
String ckePingAnLogin = request.getParameter("pingan.login");
%><table width="861" border="0" align="center" cellpadding="2" cellspacing="2">
	<tr>
	  	<td width="50" align="right">&nbsp;</td>
	  	<td colspan="6" valign="middle" class="t00" style=" font-size:15px; color:#000; font-weight:bold">
	   		<table border="0" cellpadding="0" cellspacing="2">
	   			<tr>
	   				<td align="right">输入优惠券号码：</td>
	   				<td><input type="text" name="req_tktpwd_cardno" id="txtCardNo"  style="width:250px;height:22px;border:solid 1px #759ebc; background-color:#f4f4f4"/></td>
	   				<td><input type="button" value="" onclick="ActivateTkt(<%="1".equals(ckePingAnLogin)?1:0 %>)" id="btnActivate" class="ActivateEquan"/></td>
	   				<td align="center" class="t00">注：部分优惠券由于不满足条件不能使用！<br/><a href="/user/ticket.jsp" target=_blank>查看我的所有优惠券</a></td>
	   			</tr>
	   		</table>
	   	</td>
	</tr>
</table><%
List<Ticket> list1 = TicketHelper.getAllLoginUserAvaiableTickets(request,response,payId);
List<TicketCrd> list2 = TicketHelper.getAllLoginUserAvaiableTicketCrds(request,response,payId);
if((list1 != null && !list1.isEmpty()) || (list2 != null && !list2.isEmpty()) || Tools.floatCompare(m_fltBrdTktPrice,0)==1||m_bjhdmoney>=200f){
	%><table width="861" border="0" align="center" cellpadding="2" cellspacing="2">
		<tr id="trPingAnHead">
			<td width="50">&nbsp;</td>
			<td></td>
			<td align="center" class="t02">面值</td>
			<td align="center" class="t02">使用条件</td>
			<td align="center" class="t02">有效期</td>
			<td align="center" class="t02">类型</td>
			<td align="center" class="t02">支持商家</td>
		</tr>
		<%
		if(m_bjhdmoney>=200f){
			%>
				<tr>
				<td align="right">&nbsp;</td>
				<td align="right" class="t00">
					<input type="radio" name="tktid" id="bjhdtkt"  value="bjhdtkt" onclick="loadprice();"/><input type="hidden" id="tktpayid_bjhdtkt" value=''>
				</td>
				<td align="center" class="t00">100</td>
				<td align="center" class="t00">满200减100</td>
				<td align="center" class="t00">仅本次购物可用</td>
				<td align="center" class="t00">满200减100活动</td>
				<td align="center" class="t00">-</td>
			</tr>
			<%
		}
		if(Tools.floatCompare(m_fltBrdTktPrice,0)==1){
			ArrayList<BrandPromotion> brandplist=getBrandPromotionList(CartHelper.getNormalProductMoneypp(request, response));
			//System.out.print(CartHelper.getNormalProductMoney(request, response));
			if(brandplist!=null&&brandplist.size()>0)
			{
			%>
				<tr>
				<td align="right">&nbsp;</td>
				<td align="right" class="t00">
					<input type="radio" name="tktid" id="brdtkt"  value="brdtkt" onclick="loadprice();"/><input type="hidden" id="tktpayid_brdtkt" value=''>
				</td>
				<td align="center" class="t00"><%=Tools.getFormatMoney(m_fltBrdTktPrice) %></td>
				<td align="center" class="t00"><%= brandplist.get(0).getBrdtktmst_title()!=null?brandplist.get(0).getBrdtktmst_title():"" %></td>
				<td align="center" class="t00">仅本次购物可用</td>
				<td align="center" class="t00">活动减免</td>
				<td align="center" class="t00">-</td>
			</tr>
			<%
			}
		}
		if(list1 != null && !list1.isEmpty()){
			for(Ticket ticket : list1){
			
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
				
				%><tr>
					<td align="right">&nbsp;</td>
					<td align="right" class="t00"><input type="radio" name="tktid" value="<%=ticket.getId() %>" payId="<%=ticket.getTktmst_payid() %>" onclick="loadprice();" /></td>
					<td align="center" class="t00"><%=Tools.floatValue(ticket.getTktmst_value()) %></td>
					<td align="center" class="t00">满<%=Tools.getFormatMoney(Tools.floatValue(ticket.getTktmst_gdsvalue())) %>元使用</td>
					<td align="center" class="t00"><%=Tools.getDate(ticket.getTktmst_validates()) %>至<%=Tools.getDate(ticket.getTktmst_validatee()) %></td>
					<td align="center" class="t00">按金额减免</td>
					<td align="center" class="t00"><%=shopname %></td>
				</tr><%
			}
		}
		if(list2 != null && !list2.isEmpty() && CartHelper.getShopNormalProductMoney(request, response,"00000000")>0){
			
			float m_fltGdsAllMoney2=0f;
			m_fltGdsAllMoney2=CartHelper.getShopNormalProductMoney(request, response,"00000000");
	
			for(TicketCrd ticket : list2){
				
				PayMethod pay = null;
				m_fltGdsAllMoney=m_fltGdsAllMoney2;
				if(Tools.longValue(ticket.getTktcrd_payid()) != -1){
					pay = PayMethodHelper.getById(String.valueOf(ticket.getTktcrd_payid()));
					if(pay == null) continue;
				}
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
				
				%><tr>
					<td align="right">&nbsp;</td>
					<td align="right" class="t00"><input type="radio" name="tktid" value="crd<%=ticket.getId() %>" payId="<%=ticket.getTktcrd_payid() %>" onclick="loadprice();" /></td>
					<td align="center" class="t00"><%=iTkt_value %></td>
					<td align="center" class="t00">按商品金额<%=NumberUtils.getMaxPrice(fltTktcrdDiscount*100) %>%减免<%=iTkt_value %>元</td>
					<td align="center" class="t00"><%=Tools.getDate(ticket.getTktcrd_validates()) %>至<%=Tools.getDate(ticket.getTktcrd_validatee()) %></td>
					<td align="center" class="t00">按百分比减免</td>
					<td align="center" class="t00">优尚网自营<%//=pay!=null?pay.getPaymst_name():"-" %></td>
				</tr><%
			}
		}
	%></table><%
}
%>