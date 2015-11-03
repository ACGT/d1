<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %><%@include file="/html/getComment.jsp" %><%!
private static SgLog getSglog(String gdsid,String ip){
	SgLog  sglog=null;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sglog_gdsid",gdsid));
	clist.add(Restrictions.eq("sglog_ip",ip));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("sglog_createdate"));
	
	List<BaseEntity> list = Tools.getManager(SgLog.class).getList(clist, listOrder, 0, 1);
	if(list!=null){
		for(BaseEntity be:list){
			sglog = (SgLog)be;
		}
	}

  return sglog;

}
private static int getSglognum(String gdsid){
	ArrayList<SgLog> rlist = new ArrayList<SgLog>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sglog_gdsid",gdsid));
	
	List<BaseEntity> list = Tools.getManager(SgLog.class).getList(clist, null, 0, 10000);
	if(list!=null&&list.size()>0){
		return list.size();
	}

  return 0;

}
public static long gettimemin (Date d){
	long time = d.getTime(); 
	long min=time/(60*1000);
	return min;
}
/**
 * 根据物品对象获得物品所在的组
 * @param product - 物品对象
 * @return GoodsGroup
 */
public static GoodsGroup getGroup(Product product){
	if(product == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_gdsid", product.getId()));
	
	List<Order> listorder=new ArrayList<Order>();
	listorder.add(Order.desc("id"));
		
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, listorder, 0, 1);
	
	if(list == null || list.isEmpty()) return null;
	
	GoodsGroupDetail gd = (GoodsGroupDetail)list.get(0);
	
	long ggId = Tools.longValue(gd.getGdsgrpdtl_mstid());
	if(ggId <= 0) return null;
	
	return (GoodsGroup)Tools.getManager(GoodsGroup.class).get(String.valueOf(ggId));
}

/**
 * 根据分组对象获得此物品的所在分组的列表
 * @param GoodsGroup - 分组对象
 * @return List<GoodsGroupDetail>
 */
public static List<GoodsGroupDetail> getGroupDetail(GoodsGroup gg){
	if(gg == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(gg.getId())));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
	
	if(list == null || list.isEmpty()) return null;
	
	int size = list.size();
	
	List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
	for(int i=0;i<size;i++){
		GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
		Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		if(goods == null) continue;
		
		ggdList.add(ggd);
	}
	//只有一件物品了，也就没必要显示出来了。
	if(ggdList.size() <= 1) return null;
	
	return ggdList;
}
public boolean JudgeIsMoblie(HttpServletRequest request) {
    boolean isMoblie = false;
    String[] mobileAgents = { "iphone", "android", "phone", "mobile", "wap", "netfront", "java", "opera mobi",
            "opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
            "nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
            "docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
            "techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
            "wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
            "pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
            "240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac",
            "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs",
            "kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi",
            "mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port",
            "prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem",
            "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v",
            "voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-",
            "Googlebot-Mobile" };
    if (request.getHeader("User-Agent") != null) {
        for (String mobileAgent : mobileAgents) {
            if (request.getHeader("User-Agent").toLowerCase().indexOf(mobileAgent) >= 0) {
                isMoblie = true;
                break;
            }
        }
    }
    return isMoblie;
}
public static void setCookie(HttpServletResponse response , String name , String value , int expireTime){
	Cookie userIdCookie = new Cookie(name, value);
	userIdCookie.setPath("/");
	userIdCookie.setMaxAge(expireTime);
	response.addCookie(userIdCookie);
}
%>
<%JSONObject json = new JSONObject();
String id=request.getParameter("id");
String dxmarket=request.getParameter("tj");
Product p=ProductHelper.getById(id);
if(p==null){
	json.put("pstatus", "0");
	return;
}else{
	json.put("pstatus", "1");
String gdsname = Tools.clearHTML(p.getGdsmst_gdsname());//物品名称
String gdsename = Tools.clearHTML(p.getGdsmst_gdsename());//物品名称
float saleprice = Tools.floatValue(p.getGdsmst_saleprice());//市场价
float memberprice = Tools.floatValue(p.getGdsmst_memberprice());//会员价
float msprice = Tools.floatValue(p.getGdsmst_msprice());//秒杀价  闪购价
String skuname1 = p.getGdsmst_skuname1();//sku1
long buylimit = Tools.longValue(p.getGdsmst_buylimit());
long ifhavegds = Tools.longValue(p.getGdsmst_ifhavegds());//缺货标识
long validflag = Tools.longValue(p.getGdsmst_validflag());//是否下架，1未下架
DecimalFormat df2 = new DecimalFormat("0.00");
String shopcode=p.getGdsmst_shopcode();
float hyprice = 0;

boolean isdx=false;
String dxid ="";
float dxprice = 0f;
if(dxmarket!=null&&dxmarket.length()>0){
ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_uid", dxmarket);
if(rcmdusr.getRcmdusr_enddate().after(new Date())&&rcmdusr.getRcmdusr_startdate().before(new Date()))
{
//设置cookie
 setCookie(response,"rcmdusr_uid",dxmarket,(int)(Tools.DAY_MILLIS/1000*3));
setCookie(response,"rcmdusr_rcmid",rcmdusr.getRcmdusr_rcmid().toString(),(int)(Tools.DAY_MILLIS/1000*3));
 dxid=rcmdusr.getRcmdusr_rcmid().toString();
 rcmdusr.setRcmdusr_count(rcmdusr.getRcmdusr_count()+1);
 Tools.getManager(ProductExpPrice.class).update(rcmdusr, false);
 ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
   if(expitem != null){	
	   isdx=true;
		dxprice = Tools.floatValue(expitem.getRcmdgds_memberprice());

	}else{
		dxprice = memberprice;
	}
}
else
{
	dxprice = memberprice;
}
}


json.put("gdsid", id);
json.put("pgdsname", gdsname);
json.put("pgdsename", gdsename);
json.put("pimg", ProductHelper.getImageTo400(p));
json.put("ptktflag", p.getGdsmst_specialflag().longValue()==1?true:false);
String endprice = "";

boolean ismiaosha = false;//是否是秒杀
boolean issgflag = false;//是否是闪购
Date nowday=new Date();
SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
Date msedate=null;
Date sdate=null;
if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null&&p.getGdsmst_msprice()!=null){
	 sdate=p.getGdsmst_promotionstart();
	msedate=p.getGdsmst_promotionend();	

	if(nowday.getTime()>=sdate.getTime()&&msedate.getTime()> nowday.getTime()
			&&Tools.getDateDiff(ft.format(sdate),ft.format(msedate))<31
			&&p.getGdsmst_msprice().floatValue()>=0f){
		ismiaosha = true;
	}
	//System.out.println(Tools.getDateDiff(ft.format(sdate),ft.format(edate)));
	//System.out.println(sdate+"======="+edate);
}

boolean phoneflag=false;
if(JudgeIsMoblie(request)&&!isdx){
	ArrayList<PromotionProduct> listphone= PromotionProductHelper.getPProductByCodeGdsid("9377",id);
	
	if(listphone!=null && listphone.size()>0 ){
		PromotionProduct phonepp=listphone.get(0);
		if(phonepp!=null){
		Date dxsdate=phonepp.getSpgdsrcm_begindate();
		Date dxedate=phonepp.getSpgdsrcm_enddate();

		if(phonepp.getSpgdsrcm_tjprice()!=null&&nowday.getTime()>=dxsdate.getTime()
		&&dxedate.getTime()> nowday.getTime()){
			ismiaosha=false;
			phoneflag=true;
			memberprice=phonepp.getSpgdsrcm_tjprice();
		}

		}
	}
}
int sgper=0;
long sgmaxnum=0;
long sgvbuy=0;
boolean isstockflag=ProductStockHelper.canBuy(p);
if(ismiaosha){
	//if(CartHelper.getsgbuy(id)){
	
	String productip = request.getHeader("x-forwarded-for");
			if(productip == null || productip.length() == 0 || "unknown".equalsIgnoreCase(productip)) {
				productip = request.getHeader("Proxy-Client-IP");
			}
			if(productip == null || productip.length() == 0 || "unknown".equalsIgnoreCase(productip)) {
				productip = request.getHeader("WL-Proxy-Client-IP");
			}
			if(productip == null || productip.length() == 0 || "unknown".equalsIgnoreCase(productip)) {
				productip = request.getRemoteAddr();
			}
			SgGdsDtl sggdsdtl=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
			if(sggdsdtl!=null&&sggdsdtl.getSggdsdtl_status().longValue()==1){
				issgflag=true;
				sgmaxnum=sggdsdtl.getSggdsdtl_vallnum().longValue();
				sgvbuy=sggdsdtl.getSggdsdtl_vbuynum().longValue()+sggdsdtl.getSggdsdtl_vusrnum().longValue();
				
				 
				float sgper1=(sggdsdtl.getSggdsdtl_vbuynum().floatValue()+sggdsdtl.getSggdsdtl_vusrnum().floatValue())/sggdsdtl.getSggdsdtl_vallnum().floatValue();
				if (!isstockflag ||sgmaxnum-sgvbuy<=0||sggdsdtl.getSggdsdtl_maxnum().longValue()<=sggdsdtl.getSggdsdtl_realbuynum().longValue() ||p.getGdsmst_validflag().longValue()==2){
					sgvbuy=sgmaxnum;

	             }
				if(sgper1>1||sggdsdtl.getSggdsdtl_maxnum().longValue()<=sggdsdtl.getSggdsdtl_realbuynum().longValue()
						||p.getGdsmst_validflag().longValue()!=1)sgper1=1.0f;
						sgper= (int)Tools.getFloat(sgper1*100, 0);
						
						
			if(sggdsdtl.getSggdsdtl_maxnum().longValue()>sggdsdtl.getSggdsdtl_realbuynum().longValue()
					&&sggdsdtl.getSggdsdtl_vallnum().longValue()-sggdsdtl.getSggdsdtl_vbuynum().longValue()-sggdsdtl.getSggdsdtl_vusrnum().longValue()>0){
				SgLog sglogf=getSglog(id,productip);
		
		if( (sglogf==null||(sglogf.getSglog_createdate()!=null&&(gettimemin(new Date())-gettimemin(sglogf.getSglog_createdate()))>15))){

		SgLog sglog=new SgLog();
	    sglog.setSglog_gdsid(id);
	    sglog.setSglog_ip(productip);
	    sglog.setSglog_createdate(new Date());
	    Tools.getManager(SgLog.class).create(sglog);
	    if(getSglognum(id)%2==0){
	    int xsnum=sggdsdtl.getSggdsdtl_xsnum().intValue();
	    Random rndcard = new Random();
		int addbuynum= rndcard.nextInt(xsnum);
	    long vbuynum=sggdsdtl.getSggdsdtl_vbuynum().longValue()+xsnum;
	    sggdsdtl.setSggdsdtl_vbuynum(new Long(vbuynum));
	    Tools.getManager(SgGdsDtl.class).update(sggdsdtl, false);
	    }
		}
	   }
		//}
	}
}

if(ismiaosha){
	hyprice = msprice;
}else{
	hyprice = memberprice;
}
//评论
int contentcount =0;
ArrayList<Comment> commentlists=getCommentList(id);
contentcount=commentlists.size();
//显示星级
int score = 0;
score=getLevelView1019(id);
if(score==0){
	score=10;
}
D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id); 
String acttxtt="";
String acttxt="";
String goshopurl="";
if(acttb!=null){
	 
	 
		if(acttb.getD1acttb_acttype().longValue()==0){
			acttxtt="满减";
			goshopurl="http://m.d1.cn/wap/shopbrand.html?sc="+shopcode;
		}
		
		if(acttb.getD1acttb_acttype().longValue()==1){
			acttxtt="专区满减";
			goshopurl="http://m.d1.cn/wap/rec.html?code="+acttb.getD1acttb_ppcode();
		}
		if(acttb.getD1acttb_acttype().longValue()==2){
			acttxtt="品牌满减";
			goshopurl="http://m.d1.cn/wap/shopbrand.html?sc="+acttb.getD1acttb_shopcode()+"&brand="+acttb.getD1acttb_brandcode();
		}
		if(acttb.getD1acttb_acttype().longValue()==3){
			String ppcode=acttb.getD1acttb_ppcode();
			acttxtt="";
			if("020".equals(ppcode))acttxtt="女装满减";
			if("030".equals(ppcode))acttxtt="男装满减";
			if("050".equals(ppcode))acttxtt="箱包满减";
			if("012".equals(ppcode))acttxtt="居家满减";
			if("015".equals(ppcode))acttxtt="名品饰品满减";
			goshopurl="http://m.d1.cn/wap/result.html?rackcode="+ppcode+"&shopd1=1";
		}

	 if(acttb.getD1acttb_enum1()>0){
		 acttxt+="满"+acttb.getD1acttb_snum1()+"减"+acttb.getD1acttb_enum1();
	 }
	 if(acttb.getD1acttb_enum2()>0){
		 acttxt+="&nbsp;&nbsp;满"+acttb.getD1acttb_snum2()+"减"+acttb.getD1acttb_enum2();
	 }
	 if(acttb.getD1acttb_enum3()>0){
		 acttxt+="&nbsp;&nbsp;满"+acttb.getD1acttb_snum3()+"减"+acttb.getD1acttb_enum3();
	 }
}
ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
String shopname="";
if(shpmst!=null){
	shopname=shpmst.getShpmst_shopname();
}
json.put("shoptxt", "由 "+shopname+" 发货并提供售后服务");
json.put("acttxtt", acttxtt);
json.put("acttxt", acttxt);
json.put("acturl", goshopurl);
json.put("hyprice", hyprice);
json.put("memberprice", p.getGdsmst_memberprice());
json.put("saleprice", saleprice);
json.put("ismiaosha", ismiaosha);
json.put("isstockflag", isstockflag);
json.put("issgflag", issgflag);
json.put("isdxflag", isdx);
json.put("dxprice", dxprice);
json.put("isphone", phoneflag);
json.put("sgmaxnum", sgmaxnum);
json.put("sgvbuy", sgvbuy);
json.put("sgper", sgper);
json.put("comscore", score);
json.put("contentcount", contentcount);

SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
if(msedate!=null&&sdate!=null){
json.put("msedate", DateFormat.format(msedate));
json.put("mssdate", DateFormat.format(sdate));
json.put("nowdate", DateFormat.format(new Date()));
}


JSONArray jsongrp = new JSONArray();
JSONArray jsonsku = new JSONArray();

//颜色
GoodsGroup group = getGroup(p);
if(group != null){
    List<GoodsGroupDetail> groupList = getGroupDetail(group);
    if(groupList!= null && !groupList.isEmpty()){
    	int count=0;									    	
    
		String selectSku2 = "";
    	for(GoodsGroupDetail ggd : groupList){
    		String gId = Tools.trim(ggd.getGdsgrpdtl_gdsid());
    		Product goods = ProductHelper.getById(gId);
    		if(goods!=null&&goods.getGdsmst_validflag().longValue()==1)
    		{
    			JSONObject jgrpd = new JSONObject();
    			selectSku2 = ggd.getGdsgrpdtl_stdvalue();
    			jgrpd.put("grpgdsid", goods.getId());
    			jgrpd.put("grpsku2", selectSku2);
    			jgrpd.put("grpgdsimg", ProductHelper.getImageTo80(goods));
    			jgrpd.put("grpggdid", ggd.getId());
    			if(gId.equals(id)){
    			jgrpd.put("grpggdselected", true);
    			}else{
    			jgrpd.put("grpggdselected", false);
    			}
    			jsongrp.add(jgrpd);
    		}
    	}
    	
    	
    }
}
json.put("gdsgrp", jsongrp);

///sku
List<Sku> skuList=new ArrayList<Sku>();
if(!Tools.isNull(skuname1)){
	int showsku=1;
	if(p.getGdsmst_stocklinkty()!=null&&(p.getGdsmst_stocklinkty().longValue()==0||p.getGdsmst_stocklinkty().longValue()==3)){
		showsku=0;
	}
  	 skuList = SkuHelper.getSkuListViaProductIdO(id,showsku);
   if(skuList != null && !skuList.isEmpty()){
   	int size = skuList.size();
   		for(int i=0;i<size;i++){
   			JSONObject jgrpd = new JSONObject();
   			Sku sku = skuList.get(i);
   			String skuname = sku.getSkumst_sku1();
   			if(p.getGdsmst_stocklinkty()!=null&&(p.getGdsmst_stocklinkty().longValue()==1||p.getGdsmst_stocklinkty().longValue()==2)){
   				if(CartItemHelper.getProductOccupyStock(p.getId(), sku.getId())<ProductHelper.getVirtualStock(p.getId(), sku.getId())){
	    				jgrpd.put("skuname",skuname);
	    				jgrpd.put("skuid",sku.getId());
	    				jsonsku.add(jgrpd);
   				}
   				else
   				{
   					if(sku.getSkumst_vstock().longValue()>0){
   						jgrpd.put("skuname",skuname);
	    				jgrpd.put("skuid",sku.getId());
	    				jsonsku.add(jgrpd);
   					}
   				}
   			}else{
   	           if(sku.getSkumst_validflag()!=null&&sku.getSkumst_validflag().longValue()==1)
   	           {
   	        	jgrpd.put("skuname",skuname);
				jgrpd.put("skuid",sku.getId());
				jsonsku.add(jgrpd);
   	           }
   			}
   	 		
   		}
  

   }
   
}

json.put("gdssku", jsonsku);
}
out.print(json);
%>