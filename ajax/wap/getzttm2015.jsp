<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%!
public static List<SgGdsDtl> getSgHotList2(){
	
	List<SgGdsDtl> list=new ArrayList<SgGdsDtl>();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	clist.add(Restrictions.eq("sggdsdtl_cls", new Long(7)));

	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	
	List<BaseEntity> blist=Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 6);
	if(blist!=null){
		for(BaseEntity be:blist){
			SgGdsDtl sg=(SgGdsDtl)be ;
			list.add(sg);
		}
	}
	return list;
}
public static List<SgGdsDtl> getSgHotList(){
	
	List<SgGdsDtl> list=new ArrayList<SgGdsDtl>();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	clist.add(Restrictions.le("sggdsdtl_sdate", new Date()));
	clist.add(Restrictions.ge("sggdsdtl_edate", new Date()));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	
	List<BaseEntity> blist=Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0,4);
	if(blist!=null){
		for(BaseEntity be:blist){
			SgGdsDtl sg=(SgGdsDtl)be ;
			list.add(sg);
		}
	}
	return list;
}
%>
<%
JSONObject json = new JSONObject();
ArrayList<Promotion> zt_plist=new ArrayList<Promotion>(); 
zt_plist=PromotionHelper.getBrandListByCode("3893", -1);
ArrayList<Promotion> zt_plist2=PromotionHelper.getBrandListByCode("3896", -1);//
ArrayList<Promotion> zt_plist3=PromotionHelper.getBrandListByCode("3892", -1);
String pstatus="0";
if(zt_plist!=null&&zt_plist.size()>0){
	pstatus="1";
	JSONArray jsonarr = new JSONArray();
for(Promotion pm:zt_plist){
	//System.out.println(pm.getSplmst_picstr2()+"--------------------zttm"+pm.getSplmst_name());
	//if(Tools.isNull(pm.getSplmst_picstr2()))continue;
	JSONObject jsonitem = new JSONObject();
	jsonitem.put("pmpic",pm.getSplmst_picstr());
	jsonitem.put("pmurl",pm.getSplmst_url());
	jsonitem.put("pmtitle",pm.getSplmst_name());
	//long daytime=0;
	//if(pm.getSplmst_tjendtime()!=null){
		//daytime=(pm.getSplmst_tjendtime().getTime()-new Date().getTime())/1000;
	//}

	//jsonitem.put("pmtime", daytime);
	jsonarr.add(jsonitem);
}
json.put("pmlist",jsonarr);
}
if(zt_plist2!=null&&zt_plist2.size()>0){
	pstatus="1";
	JSONArray jsonarr = new JSONArray();
for(Promotion pm:zt_plist2){
	JSONObject jsonitem = new JSONObject();
	jsonitem.put("pmpic",pm.getSplmst_picstr());
	jsonitem.put("pmurl",pm.getSplmst_url());
	jsonitem.put("pmtitle",pm.getSplmst_name());
	jsonarr.add(jsonitem);
}
json.put("lblist",jsonarr);
}
if(zt_plist3!=null&&zt_plist3.size()>0){
	pstatus="1";
	JSONArray jsonarr = new JSONArray();
for(Promotion pm:zt_plist3){
	JSONObject jsonitem = new JSONObject();
	jsonitem.put("pmpic",pm.getSplmst_picstr());
	jsonitem.put("pmurl",pm.getSplmst_url());
	jsonitem.put("pmtitle",pm.getSplmst_name());
	jsonarr.add(jsonitem);
}
json.put("actpplist",jsonarr);
}
DecimalFormat df2 = new DecimalFormat("0.00");
List<PromotionProduct> phonedxlist= PromotionProductHelper.getPProduct("9377", 20);
if(phonedxlist!=null&&phonedxlist.size()>0){
	JSONArray jsonarr=new JSONArray();
	String gdsid="";
	Date nowday=new Date();
	int pdxnum=0;
	String dxtitle="";
	for(PromotionProduct pdx:phonedxlist){
		JSONObject jsonitem = new JSONObject();
		 gdsid = pdx.getSpgdsrcm_gdsid();
		  Product goods=ProductHelper.getById(gdsid);
		  Date sdate=pdx.getSpgdsrcm_begindate();
			Date edate=pdx.getSpgdsrcm_enddate();
         
			if(pdx.getSpgdsrcm_tjprice()!=null&&nowday.getTime()>=sdate.getTime()
			&&edate.getTime()> nowday.getTime()){
				dxtitle=pdx.getSpgdsrcm_gdsname();
				jsonitem.put("dx_gdsid",gdsid);
	     		jsonitem.put("dx_gdsname",dxtitle);
	     		jsonitem.put("dx_img",ProductHelper.getImageTo120(goods));
	     		jsonitem.put("dx_mprice",df2.format(pdx.getSpgdsrcm_tjprice()) );
	     		jsonitem.put("dx_saleprice",df2.format(goods.getGdsmst_saleprice()));
	     		jsonarr.add(jsonitem);
				pdxnum++;
			}
	}
	json.put("phonedxs", jsonarr);
}

SimpleDateFormat msdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
List<PromotionProduct> phonemslist= PromotionProductHelper.getPromotionProductByCode("9675", 20);
if(phonemslist!=null&&phonemslist.size()>0){
	JSONArray jsonarr=new JSONArray();
	String gdsid="";
	Date nowday=new Date();
	int pdxnum=0;
	String dxtitle="";
	for(PromotionProduct pdx:phonemslist){
		JSONObject jsonitem = new JSONObject();
		gdsid=pdx.getSpgdsrcm_gdsid();
		  Product goods=ProductHelper.getById(gdsid);
		  float msprice=0f;
		  boolean ismiaoshao=false;
		 
  		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
  	  SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		 if(goods.getGdsmst_promotionstart()!=null&&goods.getGdsmst_promotionend()!=null
				 &&goods.getGdsmst_msprice()!=null){
		 	Date sdate=goods.getGdsmst_promotionstart();
		 	Date edate=goods.getGdsmst_promotionend();	
		 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
		 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
		 			&&goods.getGdsmst_msprice().floatValue()>=0f){
		 		ismiaoshao = true;
		 	}

		 }
		 String title=goods.getGdsmst_gdsename();
		 if(Tools.isNull(title)) title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		 if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
  		jsonitem.put("p_gdsid",gdsid);
  		jsonitem.put("p_gdsname",title);
  		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
  		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
  		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
  		jsonitem.put("p_msprice",df2.format(msprice));
  		jsonitem.put("p_ismiaoshao",ismiaoshao);
  		jsonitem.put("p_vstock", goods.getGdsmst_stocklinkty().longValue()==1?goods.getGdsmst_virtualstock().longValue():6);
		Date sdate=goods.getGdsmst_promotionstart();
		Date msedate=goods.getGdsmst_promotionend();	
		long  daytime=0;
		if(msedate!=null)daytime=(msedate.getTime()-new Date().getTime())/1000;
		long  msnslen=0;
		if(sdate!=null)msnslen=(sdate.getTime()-(new Date()).getTime())/1000;
		long  msnelen=0;
		if(msedate!=null)msnelen=((new Date()).getTime()-msedate.getTime())/1000;
			jsonitem.put("msnslen", msnslen);
			jsonitem.put("msnelen", msnelen);
			jsonitem.put("mseslen", daytime);
			jsonitem.put("mssdate",sdate!=null?msdf.format(sdate):"");
  		jsonarr.add(jsonitem);
	}
	json.put("phonems", jsonarr);
}


List<PromotionProduct> pnewlist= PromotionProductHelper.getPromotionProductByCode("9459", 3);
if(pnewlist!=null&&pnewlist.size()>0){
	JSONArray jsonarr=new JSONArray();
	String gdsid="";
	Date nowday=new Date();
	int pdxnum=0;
	String dxtitle="";
	for(PromotionProduct pdx:pnewlist){
		JSONObject jsonitem = new JSONObject();
		gdsid=pdx.getSpgdsrcm_gdsid();
		  Product goods=ProductHelper.getById(gdsid);
		  float msprice=0f;
		  boolean ismiaoshao=false;
		  String title=goods.getGdsmst_gdsename();
  		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
  	  SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		 if(goods.getGdsmst_promotionstart()!=null&&goods.getGdsmst_promotionend()!=null
				 &&goods.getGdsmst_msprice()!=null){
		 	Date sdate=goods.getGdsmst_promotionstart();
		 	Date edate=goods.getGdsmst_promotionend();	
		 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
		 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
		 			&&goods.getGdsmst_msprice().floatValue()>=0f){
		 		ismiaoshao = true;
		 	}

		 }

		 if(Tools.isNull(title)) title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		 if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
  		jsonitem.put("p_gdsid",gdsid);
  		jsonitem.put("p_gdsname",title);
  		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
  		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
  		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
  		jsonitem.put("p_msprice",df2.format(msprice));
  		jsonitem.put("p_ismiaoshao",ismiaoshao);
  		jsonitem.put("p_vstock",goods.getGdsmst_virtualstock().longValue());

  		jsonarr.add(jsonitem);
	}
	json.put("phonepnew", jsonarr);
}


List<PromotionProduct> phostlist= PromotionProductHelper.getPromotionProductByCode("9460", 20);
if(phostlist!=null&&phostlist.size()>0){
	JSONArray jsonarr=new JSONArray();
	String gdsid="";
	Date nowday=new Date();
	int pdxnum=0;
	String dxtitle="";
	for(PromotionProduct pdx:phostlist){
		JSONObject jsonitem = new JSONObject();
		gdsid=pdx.getSpgdsrcm_gdsid();
		  Product goods=ProductHelper.getById(gdsid);
		  float msprice=0f;
		  boolean ismiaoshao=false;
		  String title=goods.getGdsmst_gdsename();
  		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
  	  SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		 if(goods.getGdsmst_promotionstart()!=null&&goods.getGdsmst_promotionend()!=null
				 &&goods.getGdsmst_msprice()!=null){
		 	Date sdate=goods.getGdsmst_promotionstart();
		 	Date edate=goods.getGdsmst_promotionend();	
		 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
		 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
		 			&&goods.getGdsmst_msprice().floatValue()>=0f){
		 		ismiaoshao = true;
		 	}

		 }

		 if(Tools.isNull(title)) title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		 if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
  		jsonitem.put("p_gdsid",gdsid);
  		jsonitem.put("p_gdsname",title);
  		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
  		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
  		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
  		jsonitem.put("p_msprice",df2.format(msprice));
  		jsonitem.put("p_ismiaoshao",ismiaoshao);
  		jsonitem.put("p_vstock",goods.getGdsmst_virtualstock().longValue());

  		jsonarr.add(jsonitem);
	}
	json.put("phonephot", jsonarr);
}

json.put("status",pstatus);
out.print(json);
%>