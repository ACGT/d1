<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %>
<%!public static boolean hasWangyiProduct(HttpServletRequest request,HttpServletResponse response){
	ArrayList<Cart> list = CartHelper.getCartItems(request,response);
	if(list == null || list.isEmpty()) return false;
	boolean b = false;
	for(Cart cart : list){
		if(Tools.longValue(cart.getType()) == 13){
			b = true;
			break;
		}
	}
	return b;
} 
public static boolean hasZqProduct(HttpServletRequest request,HttpServletResponse response){
	ArrayList<Cart> list = CartHelper.getCartItems(request,response);
	if(list == null || list.isEmpty()) return false;
	boolean b = false;
	if(list.size()==1){
	for(Cart c_23049 : list){
		if(c_23049.getType().longValue()==9){
			b=true;
			break;
		}
	}
	}
	return b;
}
//判断是否含有白金升级的商品
public static boolean hasbjsjProduct(HttpServletRequest request,HttpServletResponse response){
	ArrayList<Cart> list = CartHelper.getCartItems(request,response);
	if(list == null || list.isEmpty()) return false;
	boolean b = false;
	for(Cart c_23049 : list){
		if((c_23049.getProductId().equals("01205099")||c_23049.getProductId().equals("01205100"))&&c_23049.getType().longValue()==18){
			b=true;
			break;
		}
	}

	return b;
}
%><%
//得到支付方式
//收获地址
String addressId = request.getParameter("addressId");
UserAddress defaultAdd = UserAddressHelper.getById(addressId);//默认显示在前台的地址。
if(defaultAdd == null){
	out.print("{\"code\":-1,\"message\":\"找不到收货人！\"}");
	return;
}
if(!lUser.getId().equals(String.valueOf(defaultAdd.getMbrcst_mbrid()))){
	out.print("{\"code\":-1,\"message\":\"收货人地址错误！\"}");
	return;
}

//boolean istuan = CartHelper.hasGroupProduct(request,response);//购物车中是否有团购商品
boolean istuan = false ;//团购商品和其他一样，不用单独处理了，kk修改
boolean istuanDH = CartHelper.hasGroupDHProduct(request,response);//购物车中是否有团购兑换的物品
boolean iswyDH = hasWangyiProduct(request,response);//购物车中是否有网易兑换商品
boolean istx=hasZqProduct(request,response);//独享商品只能在线支付
boolean isbjsj=hasbjsjProduct(request,response);//白金升级
float totalMoney = CartHelper.getTotalPayMoney(request,response);//购物车总金额

List listPayInDr = null;//货到付款
List listPayNetType = null;//支付方式
List listPayNetBank = null;//网上银行
List listPayNetBank_FP = null;//快捷支付银行


boolean isShowCanHF = true;//是否显示货到付款
long m_strTrnbktPayID = 0;//标记默认选中的付款方式。
boolean m_strPayBankRdo = false;//是否输出显示银行电汇 
boolean m_strPayPost = true;//是否输出显示邮局汇款
boolean m_strWanLiTong = false;//是否输出显示万里通支付方式
boolean m_strShowCanHF = true;//是否输出显示货到付款
boolean isSelectPayShow = false;//是否默认选中网上支付的radio框
boolean isHFPOSPay = false;//是否支持POS机刷卡




ArrayList<ShpMst> shoplist=CartShopCodeHelper.getCartShopCode(request,response);
if(shoplist!=null){
for(ShpMst e:shoplist){
	if(!e.getId().equals("00000000")){
		m_strShowCanHF=false;
		break;
	}
}
}
//System.out.println(isShowCanHF);
//String ckeHzly = Tools.getCookie(request,"HZLY");
String ckeYiBao = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");//d1.com.cn.peoplercm.subad
if(totalMoney<100f)m_strShowCanHF = false;

if(istuanDH && Tools.floatCompare(totalMoney,0) == 0){//totalMoney==0
	//全部为团购兑换商品,则全额E券支付
	out.print("{\"code\":0,\"message\":\"全部为团购兑换商品,则全额E券支付！\"}");
	return;
}else if(istuanDH || iswyDH || istx||isbjsj){//totalMoney>0
//}else if(istuanDH){//totalMoney>0
	//团购兑换商品+其它商品，则必须为在线支付
	m_strPayBankRdo=false;m_strPayPost=false;m_strWanLiTong=false;m_strShowCanHF = false;
}else if(!Tools.isNull((String)session.getAttribute("AlipayToken"))){
	//支付宝支付
	PayMethod pay = PayMethodHelper.getById("20");
	if(pay == null){
		out.print("{\"code\":-1,\"message\":\"找不到支付宝支付方式！\"}");
		return;
	}
	listPayNetType = new ArrayList();
	listPayNetType.add(pay);
	//只显示在线支付宝支付。并且支付宝默认选中
	m_strTrnbktPayID = Tools.parseLong(pay.getId());
	isSelectPayShow = true;
	m_strPayBankRdo=false;m_strPayPost=false;m_strWanLiTong=false;m_strShowCanHF = false;
}else{
	//绑定网上支付
	//绑定货到付款
	if(istuan){
		isShowCanHF = false;//团购不能显示货到付款
	}else{
		isShowCanHF = UserAddressHelper.supportPayAfterReceived(defaultAdd.getId());
	}
	if (isShowCanHF){
		UserAddress posua = (UserAddress)Tools.getManager(UserAddress.class).get(defaultAdd.getId());
		if(posua==null){
			isHFPOSPay=false;
		}
		else{
			
			Long provinceid = posua.getMbrcst_provinceid();
	        if(provinceid.longValue()==1){
	        	isHFPOSPay=true;
	        }
		}

	}

	//绑定银行电汇
	//if(!istuan && Tools.isNull(ckeHzly) && Tools.isNull(ckeYiBao)){
		//m_strPayBankRdo = true;
	//}
	if(!istuan && Tools.isNull(ckeYiBao)){
		m_strPayBankRdo = true;
	}

	//绑定邮局汇款
	if(istuan){
		m_strPayPost = false;
	}else if("mqybzf1209".equals(ckeYiBao)){
		m_strPayPost = false;
		m_strShowCanHF=false;
	}

	//绑定万里通支付方式
	String ckeWanLiTong = Tools.getCookie(request,"pingan.login");
	if("1".equals(ckeWanLiTong)){
		m_strWanLiTong = true;
	}else{
		ckeWanLiTong = Tools.getCookie(request,"pingan%2Elogin");
		if("1".equals(ckeWanLiTong)){
			m_strWanLiTong = true;
		}
	}
}
//闪购商品包邮
ArrayList<Cart> c_list = CartHelper.getCartItems(request, response);
if(c_list!=null&&c_list.size()>0){
for(Cart c:c_list){
if(c.getType().longValue()==20&&c.getTitle().startsWith("【闪购】")){
	               isShowCanHF=false;
					break;
					}
}
}

////////////////////////////////////////
List list = PayMethodHelper.getPayNet();
if(list == null || list.isEmpty()){
	out.print("{\"code\":-1,\"message\":\"查询网上支付方式出错！\"}");
	return;
}
listPayNetType = new ArrayList();
listPayNetBank = new ArrayList();
listPayNetBank_FP = new ArrayList();
listPayInDr=new ArrayList();
int size = list.size();
for(int i=0;i<size;i++){
	PayMethod pm = (PayMethod)list.get(i);
	long lPayId = Tools.parseLong(pm.getId());//支付ID
	
	boolean blnIsDelete = false;//是否删除
	
	String m_strTrnbktTemp = "";//参见buy/getPayHTml1.aspx.cs 是原来购物车中一个字段 trnbkt_payid 支付ID
	
	if (m_strTrnbktTemp.equals("QQ") && lPayId != 25){
		blnIsDelete = true;
	}
	//else if("HZLY".equals(ckeHzly) && lPayId != 32){
		//blnIsDelete = true;
	//}
	else if("mqybzf1209".equals(ckeYiBao) && lPayId != 14&& lPayId != 27){
		blnIsDelete = true;
		
	}
	//else if(lPayId == 32 && Tools.isNull(ckeHzly)){
		//blnIsDelete = true;
	//}
	
	if(!blnIsDelete){
		long kind = Tools.longValue(pm.getPaymst_kind());
		if(kind ==2){//在线支付
			listPayNetType.add(pm);
		}else if(kind == 1){//网上银行
			listPayNetBank.add(pm);
		}else if(kind == 3){//快捷支付银行
			listPayNetBank_FP.add(pm);
		}
	}
}
List indrlist=PayMethodHelper.getPaylist(new Long(1));
int Indrsize = indrlist.size();
for(int i=0;i<Indrsize;i++){
	PayMethod indrpm = (PayMethod)indrlist.get(i);
//货到付款
		listPayInDr.add(indrpm);
}

int pageSize = 4;//支付方式的每行分页

StringBuilder sb = new StringBuilder();
sb.append("<table bgcolor=\"#dce6ee\" width=\"861\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"2\">");
sb.append("<tr>");
sb.append("<td width=\"80\" align=\"right\">&nbsp;</td>");
sb.append("<td align=\"left\" class=\"t00\" colspan=\"3\"><strong class=\"t55\">请选择支付方式</strong>");

sb.append("</td></tr>");
//在线支付
sb.append("<tr>");
sb.append("<td align=\"right\" width=\"80\"><input type=\"radio\" id=\"rdoPayShow1\"").append(isSelectPayShow?" checked":"").append(" onclick=\"ShowPayNet();paykindrchange();HidePayIndr();\" /></td>");
sb.append("<td class=\"t01\" width=\"70\"><strong>网上支付</strong></td>");
sb.append("<td class=\"t00\" colspan=\"2\">即时到帐，支持绝大数银行借记卡及部分银行信用卡，使用网上支付购物满<strong class=\"t14\">100</strong>元享受免邮费优惠。</td>");
sb.append("</tr>");
sb.append("<tr id=\"trPayNet\" style=\"display:none\">");
sb.append("<td align=\"right\">&nbsp;</td>");
sb.append("<td colspan=\"3\" class=\"t01\">");
	sb.append("<table width=\"90%\" align=\"center\" cellpadding=\"10\" bgcolor=\"#FFFFFF\" class=\"tb13-c\" id=\"tblPayNetList\">");
	sb.append("<tr><td colspan=\"8\"><span class=\"t00\">支持以下支付平台：</span>");
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			Date dStartDate=null;
			try{
				   	 dStartDate =fmt.parse("2013-10-19");
				 }
			catch(Exception ex){
				ex.printStackTrace();
			}
			if(Tools.dateValue(dStartDate)>System.currentTimeMillis())
			{
				sb.append("&nbsp;&nbsp;<span style=\"padding-left:50px\" ><a href=\"http://fun.yeepay.com/\" target=\"_blank\"><span style=\"color:red;\"> 易宝10年感恩献礼 百万豪礼等你赢</a></a></span>");
			}	
	sb.append("</td></tr>");
		if(listPayNetType != null && !listPayNetType.isEmpty()){
			size = listPayNetType.size();
			int pg = size/pageSize+(size%pageSize==0?0:1);
			for(int i=0;i<pg;i++){
				sb.append("<tr>");
				for(int j=0;j<pageSize;j++){
					int index = i*pageSize+j;
					if(size > index){
						PayMethod pm = (PayMethod)listPayNetType.get(index);
						sb.append("<td><input type=\"radio\" name=\"req_payid\" value=\"").append(pm.getId()).append("\" onclick=\"paykindrchange();\"></td>");
						sb.append("<td><img src=\"http://images.d1.com.cn/PayImages/spayid_").append(pm.getId()).append(".png\"></td>");
					}else{
						//万里通积分支付
						if(m_strWanLiTong){
							sb.append("<td><input type=\"radio\" name=\"req_payid\" value=\"29\" id=\"id_paykindr3\" onclick=\"paykindrchange();\"></td>");
							sb.append("<td><img src=\"http://images.d1.com.cn/PayImages/spayid_29.jpg\"></td>");
						 
						}
						sb.append("<td></td><td></td>");
					}
				}
				sb.append("</tr>");
			}
		}
		//网上银行
		sb.append("<tr><td class=\"t00\" colspan=\"8\"><span style=\"color:#000000\">网银支付</span>&nbsp;&nbsp;需开通网银：</td></tr>");
		if(listPayNetBank != null && !listPayNetBank.isEmpty()){
			size = listPayNetBank.size();
			int pg = size/pageSize+(size%pageSize==0?0:1);
			for(int i=0;i<pg;i++){
				sb.append("<tr>");
				for(int j=0;j<pageSize;j++){
					int index = i*pageSize+j;
					if(size > index){
						PayMethod pm = (PayMethod)listPayNetBank.get(index);
						sb.append("<td><input type=\"radio\" name=\"req_payid\" value=\"").append(pm.getId()).append("\" onclick=\"paykindrchange();\"></td>");
						sb.append("<td><img src=\"http://images.d1.com.cn/PayImages/spayid_").append(pm.getId()).append(".png\"></td>");
					}else{
						sb.append("<td></td><td></td>");
					}
				}
				sb.append("</tr>");
			}
		}
		//快捷支付银行
				sb.append("<tr><td class=\"t00\" colspan=\"8\"><span style=\"color:#000000\">快捷支付</span>&nbsp;&nbsp;一步验证，无需网银：</td></tr>");
				if(listPayNetBank_FP != null && !listPayNetBank_FP.isEmpty()){
					size = listPayNetBank_FP.size();
					int pg = size/pageSize+(size%pageSize==0?0:1);
					for(int i=0;i<pg;i++){
						sb.append("<tr>");
						for(int j=0;j<pageSize;j++){
							int index = i*pageSize+j;
							if(size > index){
								PayMethod pm = (PayMethod)listPayNetBank_FP.get(index);
								sb.append("<td><input type=\"radio\" name=\"req_payid\" value=\"").append(pm.getId()).append("\" onclick=\"paykindrchange();\"></td>");
								sb.append("<td><img src=\"http://images.d1.com.cn/PayImages/spayid_").append(pm.getId()).append(".png\"></td>");
							}else{
								sb.append("<td></td><td></td>");
							}
						}
						sb.append("</tr>");
					}
				}
	sb.append("</table>");
sb.append("</tr>");
//货到付款
if(m_strShowCanHF){
sb.append("<tr id=\"trPayID0\"").append(isShowCanHF?"":" style=\"display:none;\"").append(">");
sb.append("<td align=\"right\" width=\"80\"><input type=\"radio\" id=\"rdoPayShow2\" onclick=\"ShowPayInDr();HidePayNet();\" /></td>");
sb.append("<td class=\"t01\" width=\"70\"><strong>货到付款</strong></td>");
sb.append("<td class=\"t00\" colspan=\"2\">商品正确再支付货款</span>，如有问题请当面拒收，立即联系客服。&nbsp;&nbsp;<a href=\"http://www.zjs.com.cn/WS_Business/WS_Bussiness_CityArea.aspx?id=6\" target=\"_blank\">快速查看货到付款地区</a></td>");
sb.append("</tr>");
sb.append("<tr id=\"trPayindr\" style=\"display:none\">");
sb.append("<td align=\"right\">&nbsp;</td>");
sb.append("<td colspan=\"3\" class=\"t01\">");
sb.append("<table width=\"90%\" align=\"center\" cellpadding=\"10\" bgcolor=\"#FFFFFF\" class=\"tb13-c\" id=\"tblPayInDrList\">");
sb.append("<tr><td colspan=\"5\" >货到付款：全国每单收取<span style=\"color:#ff0000\">10</span>元运费。</td></tr>");
if(listPayInDr != null && !listPayInDr.isEmpty()){
	size = listPayInDr.size();
	int pg = size/pageSize+(size%pageSize==0?0:1);
	for(int i=0;i<pg;i++){
		sb.append("<tr>");
		for(int j=0;j<pageSize;j++){
			int index = i*pageSize+j;
			if(size > index){

				PayMethod pm = (PayMethod)listPayInDr.get(index);
				if ((isHFPOSPay&&Tools.parseFloat(pm.getId())==44)||Tools.parseFloat(pm.getId())!=44){
				sb.append("<td><input type=\"radio\" name=\"req_payid\" value=\"").append(pm.getId()).append("\" onclick=\"paykindrchange();\">");
				}
				if(Tools.parseFloat(pm.getId())==0){
				sb.append("现金支付</td><td></td>");
				}else if(Tools.parseFloat(pm.getId())==44&&isHFPOSPay){
				sb.append("POS机支付</td><td></td>");
				}
				
			}else{
				sb.append("<td></td><td></td>");
			}
		}
		sb.append("</tr>");
	}
}
sb.append("</table>");
sb.append("</td>");
sb.append("</tr>");
}

/*if(m_strShowCanHF){
	sb.append("<tr id=\"trPayID0\"").append(isShowCanHF?"":" style=\"display:none;\"").append(">");
		sb.append("<td align=\"right\" style=\"width:100px\">");
		sb.append("<input id=\"id_paykindr1\" type=\"radio\" name=\"req_payid\" value=\"0\" onclick=\"paykindrchange();HidePayNet();\">");
		sb.append("</td>");
		sb.append("<td class=\"t01\" style=\"width:100px\"><strong>货到付款</strong></td>");
		sb.append("<td class=\"t00\">请认准<span style=\"color:#f00\">D1优尚专用包装</span>，<span style=\"color:#f00\">商品正确再支付货款</span>，如有问题请当面拒收，立即联系客服。</td>");
		sb.append("<td class=\"t00\"><a href=\"http://www.zjs.com.cn/WS_Business/WS_Bussiness_CityArea.aspx?id=6\" target=\"_blank\">快速查看货到付款地区</a></td>");
	sb.append("</tr>");
}*/
//银行电汇
if(m_strPayBankRdo){
	sb.append("<tr id=\"trPayID2\">");
	sb.append("<td align=\"right\" style=\"width:80px\"><input type=\"radio\" id=\"paybank1\" name=\"req_payid\" value=\"2\" onclick=\"paykindrchange();HidePayNet();HidePayIndr();\"></td>");
	sb.append("<td class=\"t01\" style=\"width:70px\"><strong>银行电汇</strong></td>");
	sb.append("<td class=\"t00\">转帐后1-3个工作日内到帐</td>");
	sb.append("<td class=\"t00\"><a href=\"/help/helpnew.jsp?code=0202\" target=\"_blank\">查看账户信息</a></td>");
	sb.append("</tr>");
}
//邮局汇款
if(m_strPayPost&&1==2){
	sb.append("<tr id=\"trPayID1\">");
	sb.append("<td align=\"right\" style=\"width:80px\"><input id=\"id_paykindr2\" type=\"radio\" name=\"req_payid\" value=\"1\" onclick=\"paykindrchange();HidePayNet();HidePayIndr();\"></td>");
	sb.append("<td class=\"t01\" style=\"width:70px\"><strong>邮局汇款</strong></td>");
	sb.append("<td class=\"t00\">汇款后3-7个工作日内到帐</td>");
	sb.append("<td class=\"t00\"><a href=\"/help/helpnew.jsp?code=0204\" target=\"_blank\">查看汇款信息</a></td>");
	sb.append("</tr>");
}
//万里通积分支付
if(m_strWanLiTong){
	sb.append("<tr id=\"trPayID29\">");
	sb.append("<td align=\"right\" style=\"width:80px\"><input type=\"radio\" id=\"id_paykindr3\" name=\"req_payid\" value=\"29\" onclick=\"paykindrchange();HidePayNet();HidePayIndr;\"/></td>");
	sb.append("<td class=\"t01\" style=\"width:70px\"><strong>万里通积分支付</strong></td>");
	sb.append("<td colspan=\"2\" class=\"t00\">&nbsp;</td>");
	sb.append("</tr>");
}
sb.append("</table>");
Map<String,Object> map = new HashMap<String,Object>();
map.put("code",new Integer(1));
map.put("message",sb.toString());
out.print(JSONObject.fromObject(map));
%>