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
		if(product == null || Tools.longValue(product.getGdsmst_validflag()) != 1) continue;
		list.add(product);
		count++;
	}
	
	return list;
}

private static final String[] arrtitle = new String[] {"经常跟该商品一起购买的商品", "浏览过本商品的用户最终购买", "浏览过本商品的用户还浏览过", "基于您购买历史的推荐", "基于您购物车商品的推荐", "基于您浏览历史的推荐", "购买过本商品的用户还购买过", "个性化热销榜"};

//获得百分点的html
private static String getrctdata(String strRctData, int iRedid, String strBFDReqid, String strBFDPercent, String strBFDShowstyle){
	if(Tools.isNull(strRctData) || iRedid > arrtitle.length) return "";
	List<Product> list = getBfdList(strRctData,12);
	if(list == null || list.isEmpty()) return "";

	//只有要求%的时候才进行此代码块
	Map<String,String> bfddic = null;
	if (!Tools.isNull(strBFDPercent) && iRedid == 2){
		bfddic = new HashMap<String,String>();
		String[] arrDicBFDData = strRctData.split(",");
		String[] arrDicBFDPercent = strBFDPercent.split(",");
		
		if(arrDicBFDData != null && arrDicBFDPercent != null && arrDicBFDData.length==arrDicBFDPercent.length){
			for (int i = 0; i < arrDicBFDPercent.length; i++){
	            bfddic.put(arrDicBFDData[i], arrDicBFDPercent[i]);
	        }
		}
	}

	String strTitle = arrtitle[iRedid - 1];
	
	StringBuilder sb = new StringBuilder();
	//非现实百分比用户购买
	if(iRedid != 2){
		sb.append("<div class=\"gs_left_por\">");
		sb.append("<div class=\"gs_left_ltitle\">").append(strTitle).append("</div>");
		sb.append("<div class=\"gs_left_content\">");
		for(Product product : list){
			String title = Tools.clearHTML(product.getGdsmst_gdsname());
			sb.append("<div class=\"gs_left_content_sub\">");
			sb.append("<a href=\"").append(ProductHelper.getProductUrl(product)).append("?req_id="+strBFDReqid+"\" title=\"").append(title).append("\" target=\"_blank\">").append("<img src=\"http://images.d1.com.cn").append(product.getGdsmst_smallimg()).append("\" alt=\"").append(title).append("\" width=\"60\" height=\"60\" align=\"middle\" /></a>");
			sb.append("<div class=\"gs_left_content_r\">");
			sb.append("<a href=\"").append(ProductHelper.getProductUrl(product)).append("?req_id="+strBFDReqid+"\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a><br/>");
			sb.append("<span class=\"span1\">￥").append(product.getGdsmst_memberprice()).append("</span><span class=\"span2\">￥").append(product.getGdsmst_saleprice()).append("</span>");
			sb.append("</div></div><HR/>");
		}
		sb.append("<div class=\"gs_left_content_sub_tail\"><span><a href=\"http://www.baifendian.com/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/product/bfd_yq.jpg\" style=\"vertical-align:text-bottom; vertical-align:middle\0;\"/>百分点推荐引擎</a></span></div>");
		sb.append("</div></div>");
	}else{
		sb.append("<div class=\"gs_left_por\">");
		sb.append("<div class=\"gs_left_ltitle\">").append(strTitle).append("</div>");
		sb.append("<div class=\"gs_left_content\">");
		for(Product product : list){
			String title = Tools.clearHTML(product.getGdsmst_gdsname());
			String strPercent = (bfddic == null?"0":bfddic.get(product.getId()));
			sb.append("<div class=\"gs_left_content_zzgm\">");
			sb.append("<span class=\"span_1\">").append(Tools.parseFloat(strPercent)*100).append("%的顾客看完后购买了该商品</span>");
			sb.append("<a href=\"").append(ProductHelper.getProductUrl(product)).append("?req_id="+strBFDReqid+"\" title=\"").append(title).append("\" target=\"_blank\">").append("<img src=\"http://images.d1.com.cn").append(product.getGdsmst_otherimg3()).append("\" alt=\"").append(title).append("\" width=\"120\" height=\"120\" align=\"middle\" /></a>");
			sb.append("<span><a href=\"").append(ProductHelper.getProductUrl(product)).append("?req_id="+strBFDReqid+"\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a></span><br/><br/>");
			sb.append("<span class=\"span_2\">￥").append(product.getGdsmst_memberprice()).append("</span><span class=\"span_3\">￥").append(product.getGdsmst_saleprice()).append("</span>");
			sb.append("</div><hr/>");
		}
		sb.append("<div class=\"gs_left_content_sub_tail\"><span><a href=\"http://www.baifendian.com/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/New/product/bfd_yq.jpg\" style=\"vertical-align:text-bottom; vertical-align:middle\0;\"/>百分点推荐引擎</a></span></div>");
		sb.append("</div></div>");
	}
	
	return sb.toString();
}

%><%
String strBFDData = request.getParameter("bfdgdsid");
String strBFDType = request.getParameter("bfdtype");
String strBFDPercent = request.getParameter("bfdpercent");
String strBFDReqid = request.getParameter("reqid");
String strBFDShowstyle = request.getParameter("showstyle");

if(Tools.isNull(strBFDData) || Tools.isNull(strBFDType) || Tools.isNull(strBFDReqid)){
	out.print("{\"success\":false}");
	return;
}
String[] arrBFDData = strBFDData.split("\\|");
String[] arrBFDType = strBFDType.split("\\|");
String[] arrBFDReqid = strBFDReqid.split("\\|");
String[] arrBFDPercent = null;
if(!Tools.isNull(strBFDPercent)){
	arrBFDPercent = strBFDPercent.split("\\|");
}

if(arrBFDData == null || arrBFDType==null||arrBFDReqid==null){
	out.print("{\"success\":false}");
	return;
}

if(arrBFDPercent != null && arrBFDPercent.length != arrBFDData.length){
	out.print("{\"success\":false,\"ss\":"+arrBFDPercent.length+"}");
	return;
}

if(arrBFDData.length != arrBFDType.length || arrBFDType.length != arrBFDReqid.length){
	out.print("{\"success\":false,\"ss\":2}");
	return;
}

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));

for (int i = 0; i < arrBFDType.length; i++){
	String strgetrctdata = "";
	if(arrBFDPercent != null){
		strgetrctdata = getrctdata(arrBFDData[i],Tools.parseInt(arrBFDType[i]),arrBFDReqid[i],arrBFDPercent[i],strBFDShowstyle);
	}else{
		strgetrctdata = getrctdata(arrBFDData[i],Tools.parseInt(arrBFDType[i]),arrBFDReqid[i],null,strBFDShowstyle);
	}
	map.put("strrec"+arrBFDType[i]+"_data",strgetrctdata);
}
out.print(JSONObject.fromObject(map));
%>