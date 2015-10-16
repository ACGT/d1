<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static final String SEPERATOR = ","; 
public static final String BRACER = "\""; 
public static final String NEWLINE = "\n"; 
public static final String REGEX_SPECIAL = ".*[,\n\"].*"; 
public static String write(String[] valuesInLine) throws IOException { 
int count = 0; 
StringBuffer out=new StringBuffer(); 
for (String value: valuesInLine) { 
if (count != 0) 
out.append(SEPERATOR); 
count++; 
if (value.contains(SEPERATOR) || value.contains(BRACER) || value.contains(NEWLINE)) { 
	if (value.contains(BRACER)) { 
	value = value.replace(BRACER, BRACER + BRACER); 
	} 
	if (value.contains(NEWLINE)) { 
	value = value.replace(NEWLINE,"< br />"); 
	} 

out.append(BRACER + value + BRACER); 
} 
else 
out.append(BRACER + value + BRACER); 
} 
out.append(NEWLINE); 
return out.toString(); 
} 
%><%
ArrayList<ProductResult> list=ProductResultHelper.getTodayOtherProductGroups();
if(list!=null && list.size()>0){
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	StringBuffer stbProList=new StringBuffer();
	 stbProList.append("bid,");//商户编号
     stbProList.append("outer_id,");  //商品编号
     stbProList.append("bc_id,");//分类编号
     stbProList.append("brand_name,");//品牌中文名称：中文英文全名。
     stbProList.append("sale_title,");//商品标题
     stbProList.append("item_des,");//商品描述
     stbProList.append("market_price,");//市场价格
     stbProList.append("sale_price,");//商城价格
     stbProList.append("pic_url,");//主打图片大于250x250
     stbProList.append("has_storage,");//0无货，1有货，-1下架
     stbProList.append("source_url,");//商品详情页地址
     /*可选开始*/
     stbProList.append("main_props,");//商品主要属性串：格式如p1:p1;p2:v2。
     stbProList.append("item_image,");//实物图片
     stbProList.append("peoplegroup,");//适用人群:1女士，2男士，99全部
     stbProList.append("item_name,");//产品名称一般是品牌名+类别+型号、货号等
     stbProList.append("brand_ename,");//品牌英文文名称：请尽量提供，以便准确对应。
     stbProList.append("brand_alias,");//品牌别名：请尽量提供，以便准确对应。
     stbProList.append("item_alias,");//产品别名：
     stbProList.append("product_code,");//产品型号
     stbProList.append("recommend_des,");//推荐语：0-1000个字符
     stbProList.append("item_summary,");//商品简介：0-1000个字符
     stbProList.append("is_offergift,");//是否有优惠赠品：
     stbProList.append("offergift,");//描述
     stbProList.append("is_new,");//是否新品：true是，false不是
     stbProList.append("has_invoice,");//是否可开具发票：true可，false不可
     stbProList.append("free_delivery,");//是否免快递费：true免，false不免
     stbProList.append("cash_on_delivery,");//是否支持货到付款：true是，false不是
     stbProList.append("quality_guarantee,");//是否正品保证：true是，false不是
     stbProList.append("noreason_return,");//是否无理由退换货：true是，false不是
     stbProList.append("reserve,");//否可预订：true是，false不是
     stbProList.append("reserve_des,");//预订描述：0-200个字符
     stbProList.append("has_certificate,");//是否可出具鉴定证书：true可，false不可
     stbProList.append("sale_num,");//销售数量：
     stbProList.append("after_service,");//售后服务说明：
     stbProList.append("other_service,");//其他服务说明，多个服务以英文分号分隔
     stbProList.append("time_on_market,");//指商品的在世界或者中国的上市时间
     stbProList.append("time_on_sale,");//本商城上架时间：指本商城开始卖这款产品的开始时间
     stbProList.append(format.format(new Date()));
     stbProList.append("\n");
	StringBuffer w=new StringBuffer();
	for(ProductResult r:list){
		String img="http://images.d1.com.cn"+r.getGdsmst_bigimg().trim();
		String url="http://www.d1.com.cn/product/"+r.getGdsmst_gdsid().trim();
		String strsex="99";
		if(r.getGdsmst_sex().intValue()==1){
			strsex="1";
		}else if(r.getGdsmst_sex().intValue()==0){
			strsex="2";
		}
		String[] result=new String[]{"2059",r.getGdsmst_gdsid(),r.getGdsmst_rackcode().substring(0, 6),r.getGdsmst_brandname(),Tools.clearHTML(r.getGdsmst_gdsname().trim()),r.getGdsmst_briefintrduce(),Tools.getDouble(r.getGdsmst_saleprice().doubleValue(), 2)+"",Tools.getDouble(r.getGdsmst_memberprice().doubleValue(), 2)+"",img,"1",url,",",",",strsex,",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",",","};
	w.append(write(result));
	}
	stbProList.append(w.toString());
	out.print(stbProList.toString());
	return;
}else{
	out.print("查询商品列表出错");
	return;
}
%>