<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
    if(lUser==null)
    {
    	response.setHeader("_d1-Ajax","2");
    	%>
    	$.inCart.close();Login_Dialog();
    	<%
    	return;
    }
    String gdsid="";
    if(UserHelper.isPtVip(lUser))
    {
    	out.print("{\"success\":false,\"message\":\"您已经是白金会员！\"}");
    	return;
    }
    if(UserHelper.isVip(lUser))
    {
    	gdsid="01205100";
    }
    else
    {
    	gdsid="01205099";
    }
    String gdsReferer="";
    if (session.getAttribute("gdsReferer")!=null){
    	gdsReferer=session.getAttribute("gdsReferer").toString();
    }
    if (URLDecoder.decode(gdsReferer).indexOf(gdsid+"\":")==-1){
    	gdsReferer="";
    	
    }else{
    	gdsReferer=URLDecoder.decode(gdsReferer);
    JSONObject  jsonob = JSONObject.fromObject(gdsReferer); 
    Map<String, Object> mapref = (Map)jsonob;
    gdsReferer=mapref.get(gdsid).toString();
    if (gdsReferer.length()>=400){
    	gdsReferer=gdsReferer.substring(0, 380);
    }
    }

    Product product=ProductHelper.getById(gdsid);
    if(product!=null&&product.getGdsmst_ifhavegds().longValue()==3){
    	Cart c = new Cart();
		c.setTitle("【升级白金会员】"+Tools.clearHTML(product.getGdsmst_gdsname()));
		c.setRefererurl(gdsReferer);
		c.setShopcode(product.getGdsmst_shopcode());
		c.setParentId("0");
		c.setProductId(product.getId());
		c.setAmount(new Long(1));
		c.setCreateDate(new Date());
		c.setCookie(CartHelper.getCartCookieValue(request,response));
		c.setHasChild(new Long(0));
		c.setHasFather(new Long(0));
		c.setIp(request.getRemoteHost());
		c.setMoney(Tools.getFloat(product.getGdsmst_memberprice(),2));
		c.setPrice(Tools.getFloat(product.getGdsmst_memberprice(),2));
		c.setOldPrice(product.getGdsmst_memberprice());
		c.setSkuId("");
		c.setType(new Long(18));//积分换购
		c.setUserId(lUser.getId());
		c.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice(),2));
		
		Tools.getManager(Cart.class).create(c);
		
		CartHelper.updateAllCartItems(request,response);
		
		if(c.getId()!=null){
			out.print("{\"success\":true,\"message\":\"已成功加入购物车，付款之后升级为白金，\"}");
			return;
		}else{
			out.print("{\"success\":false,\"message\":\"加入购物车失败，请稍后重试！\"}");
			return;
		}
    }

%>

