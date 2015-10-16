<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!

//获得百分点推荐的物品集合，length是集合的长度
private static List<Product> getBfdList(String strGdsList , int length){
	if(Tools.isNull(strGdsList) || length <= 0) return null;
	
	String[] ids = strGdsList.split(",");
	
	if(ids == null || ids.length == 0) return null;
	
	List<Product> list = new ArrayList<Product>();
	int count = 0;
	for(int i=0;i<ids.length&&count<length;i++){
		Product product = ProductHelper.getById(ids[i]);
		if(!ProductHelper.isShow(product)) continue;
		list.add(product);
		count++;
	}
	
	return list;
}

%><%
String strBFDData = request.getParameter("bfdgdsid");
String strBFDReqid = request.getParameter("reqid");

if(Tools.isNull(strBFDData) || Tools.isNull(strBFDReqid)){
	out.print("{\"success\":false}");
	return;
}

String[] arrBFDData = strBFDData.split(",");

if(arrBFDData == null){
	out.print("{\"success\":false}");
	return;
}

if(arrBFDData.length <= 0){
	out.print("{\"success\":false}");
	return;
}

List<Product> list = getBfdList(strBFDData,12);
if(list == null || list.isEmpty()){
	out.print("{\"success\":false}");
	return;
}

int size = list.size();
if(size % 4 != 0) size = size-size%4;

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));

StringBuilder sb = new StringBuilder();
sb.append("<table width='885' border='0' cellpadding='0' cellspacing='0'>");
sb.append("<tr class='othergoods'>");
sb.append("<td colspan='7'>").append("<div class='car_title'>您可能还喜欢以下商品</div>").append("</td>");
sb.append("</tr>");
sb.append("<tr class='trscroll'>");
sb.append("<td colspan='7'>");
sb.append("<div class='con'>");
sb.append("<div id='carousel_container'>");
sb.append("<div id='left_scroll'").append(size<5?" style='visibility:hidden;'":"").append("></div>");
sb.append("<div id='carousel_inner'>");
sb.append("<ul id='carousel_ul'>");
for(int i=0;i<size;i++){
	Product product = list.get(i);
	String title = Tools.clearHTML(product.getGdsmst_gdsname());
	sb.append("<li>");
	sb.append("<a href='").append(ProductHelper.getProductUrl(product)).append("' title='").append(title).append("' target='_blank'>");
	sb.append("<img alt='").append(title).append("' src='").append(ProductHelper.getImageTo160(product)).append("' class='pic' /></a>");
	sb.append("<a href='").append(ProductHelper.getProductUrl(product)).append("' class='title' title='").append(title).append("' target='_blank'>").append(StringUtils.getCnSubstring(title,0,50)).append("</a>");
	sb.append("<span class='span1'>￥").append(Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_memberprice()))).append("</span><span class='span2'>￥").append(Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_saleprice()))).append("</span><br/>");
	if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(product)){
		sb.append("<a href='###' attr='").append(product.getId()).append("' onclick='addCart(this);'><img src='http://images.d1.com.cn/images2011/sales/tm004.gif' class='add'></a>");
	}else{
		sb.append("<a href='###'><img src='http://images.d1.com.cn/images2012/New/product/qh.jpg' class='add'></a>");
	}
	sb.append("</li>");
}
sb.append("</ul></div>");
sb.append("<div id='right_scroll'").append(size<5?" style='visibility:hidden;'":"").append("></div>");
sb.append("</div></div></td></tr></table>");
map.put("content",sb.toString());
map.put("size",new Integer(size));

out.print(JSONObject.fromObject(map));
%>