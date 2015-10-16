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
zt_plist=PromotionHelper.getBrandListByCode("3805", -1);
ArrayList<Promotion> zt_plist2=PromotionHelper.getBrandListByCode("3896", -1);//
ArrayList<Promotion> zt_plist3=PromotionHelper.getBrandListByCode("3892", -1);
String pstatus="0";
if(zt_plist!=null&&zt_plist.size()>0){
	pstatus="1";
	JSONArray jsonarr = new JSONArray();
for(Promotion pm:zt_plist){
	//System.out.println(pm.getSplmst_picstr2()+"--------------------zttm"+pm.getSplmst_name());
	if(Tools.isNull(pm.getSplmst_picstr2()))continue;
	JSONObject jsonitem = new JSONObject();
	jsonitem.put("pmpic",pm.getSplmst_picstr());
	jsonitem.put("pmurl",pm.getSplmst_picstr2());
	jsonitem.put("pmtitle",pm.getSplmst_name());
	long daytime=0;
	if(pm.getSplmst_tjendtime()!=null){
		daytime=(pm.getSplmst_tjendtime().getTime()-new Date().getTime())/1000;
	}

	jsonitem.put("pmtime", daytime);
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
List<SgGdsDtl> sglist1=null;
//getSgHotList2(); 
DecimalFormat df2 = new DecimalFormat("0.00");
if(sglist1!=null&&sglist1.size()>0){
	JSONArray jsonarr=new JSONArray();
int count=0;

SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
 String	nowtime2= DateFormat.format( new Date());

	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
 String gdsid="";
 boolean	clsflag=false;

	long gdsnum=0;
	long buynum=0;
	long gdsnum2=0;
	   boolean issgflag=true; 
 for(SgGdsDtl sg:sglist1){
		gdsid = sg.getSggdsdtl_gdsid();
	  Product goods=ProductHelper.getById(gdsid);
	  Date sdate=goods.getGdsmst_promotionstart();
    	Date edate=goods.getGdsmst_promotionend();	
	  if(goods.getGdsmst_validflag().longValue()==1&&goods!=null
				&&((edate.getTime()>(new Date()).getTime())&&(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
	 JSONObject jsonitem = new JSONObject();
	 count++;
     	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
     	   String id = goods.getId();
     	   String shopcode=goods.getGdsmst_shopcode();
     	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
     	   issgflag=true;
     	   String brandname=goods.getGdsmst_brandname();
     	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
     	String gtitle="";
     	if(gname.length()<32){
     	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
     	}

     		
     		gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
             gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
        	
         	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

             if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
            	buynum=sg.getSggdsdtl_vallnum().longValue();
            	issgflag=false;
             }
     		float msprice=0f;
     		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
     		String pic=ProductHelper.getImageTo120(goods);
    
     		
     		jsonitem.put("p_gdsid",id);
     		jsonitem.put("p_gdsname",title);
     		jsonitem.put("p_img",pic);
     		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
     		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
     		jsonitem.put("p_msprice",df2.format(msprice));
     		jsonitem.put("p_issgflag",issgflag);
     		jsonitem.put("p_buynum",buynum);
     		jsonarr.add(jsonitem);
	  }
     		
}
json.put("products", jsonarr);
}

List<SgGdsDtl> sglist=getSgHotList(); 

if(sglist!=null&&sglist.size()>0){
	JSONArray jsonarr=new JSONArray();
int count=0;

SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
String	nowtime2= DateFormat.format( new Date());
Date nowtime=new Date();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
String gdsid="";
boolean	clsflag=false;

	long gdsnum=0;
	long buynum=0;
	long gdsnum2=0;
	   boolean issgflag=true; 
for(SgGdsDtl sg:sglist){
		gdsid = sg.getSggdsdtl_gdsid();
	  Product goods=ProductHelper.getById(gdsid);
	  Date sdate=goods.getGdsmst_promotionstart();
  	Date edate=goods.getGdsmst_promotionend();	
	  if(goods.getGdsmst_validflag().longValue()==1&&goods!=null
				&&((edate.getTime()>(new Date()).getTime())&&(sdate.getTime()<(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31))){
	 JSONObject jsonitem = new JSONObject();
	 count++;
   	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
   	   String id = goods.getId();
   	   String shopcode=goods.getGdsmst_shopcode();
   	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
   	   issgflag=true;
   	   String brandname=goods.getGdsmst_brandname();
   	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
   	String gtitle="";
   	if(gname.length()<32){
   	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
   	}

   		
   		gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
           gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
      	
       	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

           if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
          	buynum=sg.getSggdsdtl_vallnum().longValue();
          	issgflag=false;
           }
   		float msprice=0f;
   		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
   		String pic=goods.getGdsmst_img310();
  		if(!Tools.isNull(pic)){
  			if(pic.startsWith("/shopimg/")){
  				pic = "http://images1.d1.com.cn"+pic.trim();
  			}else{
  				pic = "http://images.d1.com.cn"+pic.trim();
  			}
  			}else{
  				pic=ProductHelper.getImageTo400(goods);
  			}
  		long daytime=0;
  			daytime=(edate.getTime()-nowtime.getTime())/1000;

   		jsonitem.put("p_gdsid",id);
   		jsonitem.put("p_gdsname",title);
   		jsonitem.put("p_img",pic);
   		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
   		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
   		jsonitem.put("p_msprice",df2.format(msprice));
   		jsonitem.put("p_issgflag",issgflag);
   		jsonitem.put("p_time",daytime);
   		jsonitem.put("p_buynum",buynum);
   		jsonarr.add(jsonitem);
	  }
   		
}
json.put("sglist", jsonarr);
}
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

json.put("status",pstatus);
out.print(json);
%>