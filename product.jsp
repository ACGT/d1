<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%>
<%@include file="/html/productpublic1.jsp"%>
<%@include file="/html/getComment.jsp" %><%!
//获取跳转链接
private static String getgdsurl(String gdsid){
	String rurl="";
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(8632)));
	clist.add(Restrictions.eq("spgdsrcm_gdsid",gdsid));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 1);
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			rurl=pp.getSpgdsrcm_otherlink();
		}
	}

  return rurl;

}
private static ArrayList<GdsImgDtl>  getgdsimgdtl(String gdsid){
	String rurl="";
	ArrayList<GdsImgDtl> rlist = new ArrayList<GdsImgDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsimgdtl_gdsid",gdsid));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("gdsimgdtl_sort"));
	
	List<BaseEntity> list = Tools.getManager(GdsImgDtl.class).getList(clist, listOrder, 0, 4);
	if(list!=null){
		for(BaseEntity be:list){
			GdsImgDtl pp = (GdsImgDtl)be;
			rlist.add(pp);
		}
	}

  return rlist;

}
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

private static BrandMst getbrandmst(String brandcode,String rackcode){
	BrandMst  brandm=null;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("id",brandcode));
	clist.add(Restrictions.eq("brandmst_rackcode",rackcode));
	
	
	List<BaseEntity> list = Tools.getManager(BrandMst.class).getList(clist, null, 0, 1);
	if(list!=null){
		for(BaseEntity be:list){
			brandm = (BrandMst)be;
		}
	}

  return brandm;

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
%>
<%
String id = request.getParameter("id");
if(Tools.isNull(id))id=request.getParameter("gdsid");
String gourl=getgdsurl(id);
if (!Tools.isNull(gourl)){
	response.sendRedirect(gourl);
 return;
}
if(id.equals("01414673")){
	response.sendRedirect("http://www.d1.com.cn");
	 return;
}

//------------------------记录商品来源链接--------------------------------------
String twohttpurl=request.getHeader("Referer");
if(Tools.isNull(twohttpurl))twohttpurl=request.getHeader("referer");
if (!Tools.isNull(twohttpurl)){
	try{
		twohttpurl=HitLogUtil.repbad(twohttpurl);
		twohttpurl =java.net.URLDecoder.decode(twohttpurl,"UTF-8");
   }
   catch(Exception ex){
 	  ex.printStackTrace();
   }
}


String gdsReferer="";
if (session.getAttribute("gdsReferer")!=null){
	gdsReferer=session.getAttribute("gdsReferer").toString();
}
if (Tools.isNull(gdsReferer)||URLDecoder.decode(gdsReferer,"UTF-8").indexOf(id+"\":")==-1){
	try{
	Map<String, Object> mapreferer = null;
	if (!Tools.isNull(gdsReferer)){
		gdsReferer=URLDecoder.decode(gdsReferer,"UTF-8");
	  JSONObject josnmap2 = JSONObject.fromObject(gdsReferer); 
	   mapreferer = (Map)josnmap2;
     }else{
    	 mapreferer= new HashMap<String,Object>();
     }
	   
	mapreferer.put(id,twohttpurl);
	String jsonmap=JSONObject.fromObject(mapreferer).toString();
	session.setAttribute("gdsReferer", URLEncoder.encode(jsonmap));
	//Tools.setCookie(response,"gdsReferer",URLEncoder.encode(jsonmap),(int)(Tools.DAY_MILLIS/1000*1));
	}
	catch(Exception ex){
		//Tools.removeCookie(response, "gdsReferer");
		session.removeAttribute("gdsReferer");
	   }
}

//------------------------------------------------------------------
Product product = ProductHelper.getById(id);
if(product == null){
	//response.setStatus(404);
	//response.setHeader( "Location", "http://www.d1.com.cn/product/"+request.getParameter("id"));
	//response.setHeader( "Connection", "close" );
	
     response.sendRedirect("/404.jsp");
	out.print("商品不存在！");
	return;
}
boolean phoneflag=false;
float phoneprice =0f;
Date nowday=new Date();

ArrayList<PromotionProduct> listphone= PromotionProductHelper.getPProductByCodeGdsid("9377",id);

if(listphone!=null && listphone.size()>0 ){
	PromotionProduct phonepp=listphone.get(0);
	if(phonepp!=null){
	Date dxsdate=phonepp.getSpgdsrcm_begindate();
	Date dxedate=phonepp.getSpgdsrcm_enddate();

	if(phonepp.getSpgdsrcm_tjprice()!=null&&nowday.getTime()>=dxsdate.getTime()
	&&dxedate.getTime()> nowday.getTime()){

		phoneflag=true;
		phoneprice=phonepp.getSpgdsrcm_tjprice().floatValue();
	}

	}
}
//if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=1){
//	response.sendRedirect("/index.jsp");
//	return;
//}

//if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==2)
//{
	//if(twohttpurl==null)
	//{
       //response.sendRedirect("http://www.d1.com.cn/productv.jsp?id="+id);	
	//}
	//else
	//{
	//	if(!twohttpurl.startsWith("http://admin.d1.com.cn:322"))
	//	{
		  //response.sendRedirect("http://www.d1.com.cn/productv.jsp?id="+id);	
	//	}
	//}
//}

String brandName = product.getGdsmst_brandname();//品牌
String rackCode = product.getGdsmst_rackcode();//类别
String gdsname = Tools.clearHTML(product.getGdsmst_gdsname());//物品名称
float saleprice = Tools.floatValue(product.getGdsmst_saleprice());//市场价
float memberprice = Tools.floatValue(product.getGdsmst_memberprice());//会员价
long discountendDate = Tools.dateValue(product.getGdsmst_discountenddate());//应该是秒杀结束的时间。
float oldmemberprice = Tools.floatValue(product.getGdsmst_oldmemberprice());//旧的会员价
float msprice = Tools.floatValue(product.getGdsmst_msprice());//秒杀价  闪购价
String skuname1 = product.getGdsmst_skuname1();//sku1
long buylimit = Tools.longValue(product.getGdsmst_buylimit());
long ifhavegds = Tools.longValue(product.getGdsmst_ifhavegds());//缺货标识
long validflag = Tools.longValue(product.getGdsmst_validflag());//是否下架，1未下架

long tj_buylimit = 0;//秒杀购买上限
long tj_saletoday = 0;//秒杀今日购买数
String rcmdgds_gdsid = null;
String dxtitle = "";
String endprice = "";

boolean ismiaosha = false;//是否是秒杀
boolean issgflag = false;//是否是闪购
boolean issgendflag = false;//是否是闪购
//市场用的独享
String dxmarket="";
if(request.getParameter("tj")!=null&&request.getParameter("tj").length()>0){
	dxmarket=request.getParameter("tj");
}
boolean isdx=false;
String dxid ="";
float dxprice = 0f;
//来源链接
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");

if(dxmarket!=null&&dxmarket.length()>0){
    String strpingan=Tools.getCookie(request, "PINGAN");
    if(!"pingan".equals(dxmarket.substring(0, 6)) || !"1".equals(strpingan))
    {
    	   if (httpurl!=null && httpurl.indexOf("d1.com.cn")<0)
    	    {
    	    	String strsrcurl=Tools.getCookie(request, "d1.com.cn.srcurl");
    	    	if(Tools.isNull(strsrcurl) || "null".equals(strsrcurl))
    	    	{
    	    	    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*3));
    	    	}
    	    }
    	    Tools.setCookie(response,"d1.com.cn.peoplercm.subad",dxmarket,(int)(Tools.DAY_MILLIS/1000*3));
    	   
    	    if(!"linktech".equals(dxmarket))
    	    {
    	        Lmclk lk = new Lmclk();
    	        lk.setLmclk_createdate(new Date());
    	        lk.setLmclk_uid("d1_1030");
    	        lk.setLmclk_linkurl("http//www.d1.com.cn/product/"+id);
    	        lk.setLmclk_from(httpurl);
    	        lk.setLmclk_ip(request.getRemoteAddr());
    	        lk.setLmclk_subad(dxmarket);
    	        Tools.getManager(Lmclk.class).create(lk);
    	    }
    }
	ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_uid", dxmarket);
	if(rcmdusr.getRcmdusr_enddate().after(new Date())&&rcmdusr.getRcmdusr_startdate().before(new Date()))
	{
	//设置cookie
	 Tools.setCookie(response,"rcmdusr_uid",dxmarket,(int)(Tools.DAY_MILLIS/1000*3));
	 Tools.setCookie(response,"rcmdusr_rcmid",rcmdusr.getRcmdusr_rcmid().toString(),(int)(Tools.DAY_MILLIS/1000*3));
	 dxid=rcmdusr.getRcmdusr_rcmid().toString();
	 rcmdusr.setRcmdusr_count(rcmdusr.getRcmdusr_count()+1);
	 Tools.getManager(ProductExpPrice.class).update(rcmdusr, false);
	 ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
	   if(expitem != null){	
		   isdx=true;
			dxprice = Tools.floatValue(expitem.getRcmdgds_memberprice());
			tj_buylimit = Tools.longValue(expitem.getRcmdgds_buylimit());
			tj_saletoday = Tools.longValue(expitem.getRcmdgds_saletoday());
			rcmdgds_gdsid = expitem.getRcmdgds_gdsid();
			if(!Tools.isNull(expitem.getRcmdgds_title())){
				dxtitle = expitem.getRcmdgds_title();
			}
		}else{
			dxprice = memberprice;
		}
	}
	else
	{
		dxprice = memberprice;
	}
}
else{
 	dxid=Tools.getCookie(request,"rcmdusr_rcmid");
	if(!Tools.isNull(dxid)){
		
		ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
		if(expitem != null){	
			isdx=true;
			dxprice = Tools.floatValue(expitem.getRcmdgds_memberprice());
			tj_buylimit = Tools.longValue(expitem.getRcmdgds_buylimit());
			tj_saletoday = Tools.longValue(expitem.getRcmdgds_saletoday());
			rcmdgds_gdsid = expitem.getRcmdgds_gdsid();
			if(!Tools.isNull(expitem.getRcmdgds_title())){
				dxtitle = expitem.getRcmdgds_title();
			}
		}else{
			dxprice = memberprice;
		}
	}
}

//获取团购价格
float tuanprice=0f;
int tuanflag=0;
List<PromotionProduct> tuanlist=PromotionProductHelper.getPProductByCode("7523");
if(tuanlist!=null&&tuanlist.size()>0)
{
    for(PromotionProduct pp:tuanlist)
    {
    	if(pp!=null)
    	{
    		if(pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().toString().equals(id)&&pp.getSpgdsrcm_enddate().after(new Date())&&pp.getSpgdsrcm_begindate().before(new Date()))
    		{
    			tuanprice=pp.getSpgdsrcm_tjprice().floatValue();
    			tuanflag=1;
    			int r=new Random().nextInt(10);
	        	if(r==0)
	        	{
	        		r=1;
	        	}
	        	
		        pp.setSpgdsrcm_tghit(pp.getSpgdsrcm_tghit().longValue()+r);
		        if(!Tools.getManager(PromotionProduct.class).update(pp,false))
		        {
		        	System.out.print("[团购商品]商品id："+id+"更改点击数目出错!");
		        }
    		}
    	}
    }
}



DecimalFormat df2 = new DecimalFormat("0.00");
long currentTime = System.currentTimeMillis();
float hyprice = 0;


SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
Date msedate=null;
if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
	Date sdate=product.getGdsmst_promotionstart();
	msedate=product.getGdsmst_promotionend();	

	if(nowday.getTime()>=sdate.getTime()&&msedate.getTime()> nowday.getTime()
			&&Tools.getDateDiff(ft.format(sdate),ft.format(msedate))<31
			&&product.getGdsmst_msprice().floatValue()>=0f){
		ismiaosha = true;
	}
	//System.out.println(Tools.getDateDiff(ft.format(sdate),ft.format(edate)));
	//System.out.println(sdate+"======="+edate);
}

int sgper=0;
long sgmaxnum=0;
long sgvbuy=0;
boolean isstockflag=ProductStockHelper.canBuy(product);
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
				if (!isstockflag ||sgmaxnum-sgvbuy<=0||sggdsdtl.getSggdsdtl_maxnum().longValue()<=sggdsdtl.getSggdsdtl_realbuynum().longValue() ||product.getGdsmst_validflag().longValue()==2){
					sgvbuy=sgmaxnum;

	             }
				if(sgper1>1||sggdsdtl.getSggdsdtl_maxnum().longValue()<=sggdsdtl.getSggdsdtl_realbuynum().longValue()
						||product.getGdsmst_validflag().longValue()!=1)sgper1=1.0f;
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
	   }else{
		   issgendflag=true;
	   }
		//}
	}
}

if(product.getGdsmst_validflag().longValue()!=1){
	sgper=100;
}

if(ismiaosha){
	hyprice = msprice;
}else{
	hyprice = memberprice;
}

endprice = String.valueOf(hyprice);



int bjprice=0;
int vipprice=0;
if(rackCode!=null&&rackCode.length()>0&&(rackCode.startsWith("02")||rackCode.startsWith("03")||rackCode.startsWith("015009")))
{
	bjprice=(int)(memberprice*0.95);
	vipprice=(int)(memberprice*0.98);
}
else
{
	bjprice=(int)(memberprice*0.98);	
	vipprice=(int)(memberprice*0.99);
}

/*if(lUser!=null&&UserHelper.isPtVip(lUser)&&dxprice>bjprice)
{
    isdx=false;
}*/

endprice = (Tools.floatCompare(dxprice,0)==0 ? Tools.getFormatMoney(hyprice) : Tools.getFormatMoney(dxprice));

//获取白金独享的列表
ArrayList<PromotionProduct> ppbjdx=getbjdxlist(id);
PromotionProduct pbjdx=new PromotionProduct();
if(ppbjdx!=null&&ppbjdx.size()>0)
{
    pbjdx=ppbjdx.get(0);
    //if(lUser!=null&&UserHelper.isPtVip(lUser)){
    	//Tools.setCookie(response,"rcmdusr_uid",null,(int)(Tools.DAY_MILLIS/1000*3));	
    	//dxid=null;
    	//isdx=false;
   // }
}
if(pbjdx!=null&&pbjdx.getSpgdsrcm_tjprice()!=null&&pbjdx.getSpgdsrcm_tjprice().floatValue()!=0)
{
	endprice = String.valueOf(pbjdx.getSpgdsrcm_tjprice().floatValue());
}
//判断是否是200-100的商品

boolean flagbj200=false;
/*ArrayList<PromotionProduct> bjpromotionlist=gethdgoodslist(id);
if(bjpromotionlist!=null&&bjpromotionlist.size()>0)
{
	for(PromotionProduct ppbj:bjpromotionlist)
	{
		if(ppbj!=null)
		{
			if(ppbj.getSpgdsrcm_gdsid().equals(id))
			{
				flagbj200=true;
				break;
			}
		}
	}
}*/

boolean flagbjcp=false;
if(product.getGdsmst_specialflag().longValue()==0){
	flagbjcp=true;
}
	


String style = null;

if(isdx&& Tools.floatCompare(dxprice, memberprice) !=0){
	style = "<span>￥" + Tools.getFormatMoney(hyprice) + "</span>";
}else{
	if(tuanprice>0f)
	{
		if(Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0)
		{
		     style = "<span>￥" + Tools.getFormatMoney(oldmemberprice) + "</span>";
		}
		else{
			style = "<span>￥" + Tools.getFormatMoney(memberprice) + "</span>";
		}
	}
	else
	{
		if(ismiaosha)
		{
			style = "<span style=\"color:#C00000;\">￥" + Tools.getFormatMoney(oldmemberprice) + "</span>";
		}
		else
		{
	       style = "<span class='mbrprice'>￥" + Tools.getFormatMoney(hyprice) + "</span>";
		}
	}
}

String category = "";//最小的类别，在下面初始化了。

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

String gname=Tools.clearHTML(gdsname);

if(gname.indexOf("（")>0){
	gname=gname.substring(0,gname.indexOf("（"));

}

if(gname.indexOf("(")>0){
	gname=gname.substring(0,gname.indexOf("("));
}
String fxcontent="我在@D1优尚官网 发现了一个非常不错的商品："+gname+" 优尚价：￥"+memberprice+"。感觉不错，分享一下 ";

ProductHelper.addHistory(request,response,id);

List<Product> productList = null;//物品集合list，下面用到了。

Product giftProduct = GiftHelper.getGiftProductByProductId(id);//赠品，为null就是没有单品赠品

String show="";
if(request.getParameter("st")!=null&&request.getParameter("st").trim().length()>0){
	show=request.getParameter("st").trim();
}


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=gdsname %>【图片_价格_报价_怎么样】</title>
<meta name="keywords" content="<%=Tools.clearHTML(product.getGdsmst_gdsname()+(product.getGdsmst_keyword()==null?"":product.getGdsmst_keyword())) %>" />
<meta name="description" content="优尚网热卖产品<%=Tools.clearHTML(product.getGdsmst_gdsname())%>，在这你可以看到<%=Tools.clearHTML(product.getGdsmst_gdsname())%>的图片、评价、价格以及用户对他的使用感受，告诉你<%=Tools.clearHTML(product.getGdsmst_gdsname())%>怎么样，让您买的放心，用的开心。" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsinfo.css?"+System.currentTimeMillis())%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/sdshow.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/cloud-zoom.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/cloud-zoom.1.0.2.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/static.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/gdscoll.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmstlistCart.js")%>"></script>
<script type="text/javascript"  src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/wapcheck.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/result.js")%>"></script>

<script type="text/javascript">
if(checkMobile()){
	var url=document.URL;
	var rackcode="";
	 if(url.lastIndexOf("?")>0)
	   {
	        para=url.substring(url.lastIndexOf("?")+1,url.length);
			var arr=para.split("&");
			para="";
			for(var i=0;i<arr.length;i++)
			{
			   if(arr[i].split("=")[0]=="id"){
				   gdsid=arr[i].split("=")[1];
			   }else if(arr[i].split("=")[0]=="gdsid"){
				   gdsid=arr[i].split("=")[1];
			   }
			}
	   }else{
		   var arr=url.split("/product/");

		   if(arr[1]!=""){
			   gdsid=arr[1].substring(0,8);
		   }
	   }
	 if(gdsid!=""){
	   window.location.href="http://m.d1.cn/wap/product.html?id="+gdsid+"";
	 }
}
var the_s=new Array();
var lasttime=0;
function vms_time(){

    if(lasttime>0){
        var the_D=Math.floor((lasttime/3600)/24)
        var the_H=Math.floor((lasttime-the_D*3600*24)/3600);
        var the_M=Math.floor((lasttime-the_D*3600*24-the_H*3600)/60);
        var the_S=(lasttime-the_H*3600)%60;
        $("#pmstime").text(the_D+"天 "+the_H+":"+the_M+":"+the_S );
        lasttime--;
    }else{
   	 $("#pmstime").text("已结束");

    }
}

$(function(){
	  $('.cloud-zoom').attr('rel','adjustX:30');
	})

function hidehot(){
	$("#divhotimg").hide();
}
function showhot(){
	$("#divhotimg").show();
}



function view_time2(){
	var startDate= new Date();
	var endDate= new Date("2012/07/20 15:00:00");
	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
    if(lasttime>0){
    	var the_D=Math.floor((lasttime/3600)/24)
        var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
        var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
        var the_S=Math.floor((lasttime-the_H*3600)%60);
       if(the_D!=0){$("#topd").text(the_D);}
        if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
        $("#tops").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        lasttime--;
    }
}	
$(document).ready(function() {
	var startDate= new Date();
	var endDate= new Date("2012/07/20 15:00:00");
	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
    if(lasttime>0){
  setInterval(view_time2,1000);
    }

});
//X元选Y件
function CheckForm(obj){
	var checkgds = $('#tblList input[type=checkbox]:checked');
	var iSelectCnt = checkgds.length;
    if (iSelectCnt == 0){
    	$.alert('请选择商品!');
        return;
    }
    var iMaxCount = -1;
    var strMaxCount = $('#hdnMaxCount').val();
    if (strMaxCount != null && strMaxCount.length > 0){
    	iMaxCount = parseInt(strMaxCount, 10);
    }
    if (iMaxCount != -1){
    	if (iSelectCnt != iMaxCount){
    		$.alert('请选择' + iMaxCount + '件商品!');
            return;
        }
    }
    var arr = new Array();
    checkgds.each(function(i){
    	arr[i] = $(this).val();
    });
    $('#btnAddToCart').attr('attr',arr.toString());
    $.inCart1(obj,{ajaxUrl:'/html/zt2012/20120727polo/xsyListInCart.jsp',width:600,align:'center'},{'code':$(obj).attr("code")});
}
<%if(lUser!=null&&lUser.getMbrmst_uid().trim().equals("gjltest")){%>
function AddCom(){
  
    	   cdate=$("#commdate").val();
    	   ccontent=$("#commcontent").val();
    	    $.post("/ajax/user/usercomm.jsp",{"pid":"<%=id%>","ccontent":ccontent,"cdate":cdate,"m":new Date().getTime()},function(json){
    	    	if(json.success){
    	    		$.alert(json.message);
    	    	}else{
    	    		$.alert(json.message);
    	    	}
    	    },"json");
    	}
function comsup(t){
comid=$(t).attr("attr")
 $.post("/ajax/user/commup.jsp",{"comid":comid,"m":new Date().getTime()},function(json){
 	if(json.success){
 		$.alert(json.message);
 	}else{
 		$.alert(json.message);
 	}
 },"json");
}
  <%}%>
  

  
</script>
<style type="text/css">
.productadright2{position: fixed;_position: absolute;right: 0px;bottom: 130px;width: 100px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}
</style>
</head>

<body>
<a name="top1120"></a>
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="clear"></div>
<div class="productadright2">
<%List<Promotion> recrightList = PromotionHelper.getBrandListByCode("3894" , 1);
	if(recrightList != null && !recrightList.isEmpty()){
		for(Promotion p:recrightList)
		{
			String url=p.getSplmst_url();
			String img=p.getSplmst_picstr();
			 %>    
			 <a href="<%=url %>" target="_blank">
<img src="<%=img %>"  border="0"/></a>
<%}
		}%>
</div>
<!-- 中间内容-->

<div id="center">
	
		 <!-- banner -->
	
<!-- <a href="http://www.d1.com.cn/zhuanti/201303/szn0307/" target="_blank"><img src="http://images.d1.com.cn/images2013/index/banner130311.jpg" border="0"/></a>
	<a href="http://www.d1.com.cn/html/zt2013/20130116hd/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/des/20130118980X60.jpg" border="0"/></a>-->
 <%//if(!rackCode.startsWith("03")){%>
<!-- <a href="http://www.d1.com.cn/zhuanti/201305/lyq0522/" target="_blank"><img src="http://images.d1.com.cn/images2013/product/980-60-13.jpg" style="margin-top:-5px;" border="0"/></a> 
<%//}else{ %>
<a href="http://www.d1.com.cn/zhuanti/201304/fzbk0426/" target="_blank"><img src="http://images.d1.com.cn/images2013/product/980X60_2.jpg" style="margin-top:-5px;" border="0"/></a> 
-->
	 <!--链接导航-->
	 <% //}
       if(!rackCode.startsWith("012")){%>
		 <div class="dh">
			<img src="http://images.d1.com.cn/images2012/New/product/green.gif" width="20" height="35" align="top" style="margin-top:-10px;_margin-top:-12px;" />
			<a href="http://www.d1.com.cn/" target="_blank">首页</a><%
			if(!Tools.isNull(rackCode)){
				int size = rackCode.length();
				if(size >= 3){
					for (int i = 3; i <= size; i = i + 3){
						Directory directory = DirectoryHelper.getById(rackCode.substring(0,i));
						if(directory == null) continue;
						category = directory.getRakmst_rackname();
						if(!directory.getId().equals("015")){
							if(i==3){
								%>&nbsp;&gt;&nbsp;<a href="/result.jsp?productsort=<%=directory.getId() %>" target="_blank"><%=category %></a><%
							}else{
								%>&nbsp;&gt;&nbsp;<a href="/result.jsp?productsort=<%=directory.getId() %>" target="_blank"<%if(i==size){ %> class="othera"<%} %>><%=category %></a><%
							}
						}
					}
				}
			}
			%>
			>&nbsp;&nbsp;<%=gdsname  %>
	 	</div>    
	 <%} %>

	 <!--链接导航结束-->

		 <!-- 商品展示-->
		 <div class="goods_distop">
		  <!-- 商品展示-->
			    <div class="goods_new">
			    <div class="gs_l">
			    	<div class="gs_spname"><span>
 <%String shopindexurl="";
 String Shpmstbulletin="";
                        		ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(product.getGdsmst_shopcode());
                          if(shpmst!=null){
                              	  if(shpmst.getShpmst_index().longValue()==1){
                              		shopindexurl="http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname();
                        		  out.print("<a href=\"http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname()+"\" target=\"_blank\" >");
                        		  
                              	  }
                              	Shpmstbulletin=shpmst.getShpmst_bulletin();
                        	  out.print(shpmst.getShpmst_shopname());
                        	  if(shpmst.getShpmst_index().longValue()==1){
                        		  out.print("</a>");
                        	  }
                        	 
                          }
                        %>
</span></div>
					<!-- 商品展示-->
					<div class="gs_right_spimg" style="position:relative;">
					<% ArrayList<GdsImgDtl> imgdtllist= getgdsimgdtl(id); 
					if(imgdtllist!=null&&imgdtllist.size()>0){
						String bigimg=product.getGdsmst_bigimg();
						if(!Tools.isNull(bigimg)){
							if(bigimg.startsWith("/shopimg/gdsimg")){
								bigimg = "http://images1.d1.com.cn"+bigimg.trim();
							}else{
								bigimg = "http://images.d1.com.cn"+bigimg.trim();
							}
							}
					%>
					<div class="gdsblock">
					 <%if(product.getGdsmst_validflag().longValue()==1&& product.getGdsmst_shopcode().equals("00000000")&&product.getGdsmst_virtualstock().longValue()>0)
							     {%> 
							    	 <span style="position:absolute; width:125px; height:36px; dislay:block; background:url('http://images.d1.com.cn/images2015/act/gdssf.jpg'); right:20px; top:10px; z-index:5000;"></span>
           				 
							     <%}%>
 <a href="<%=bigimg%>" class="cloud-zoom" id='zoom1'><img src="<%=ProductHelper.getImageTo400(product) %>" /></a>
 <ul>
<li>
   <a href="<%=bigimg %>" class="cloud-zoom-gallery" 
 rel="useZoom: 'zoom1', smallImage: '<%=ProductHelper.getImageTo400(product) %>'">
 <img src="<%=ProductHelper.getImageTo80(product) %>" width="60" height="60" /></a></li>
 <%for(GdsImgDtl dtlimg:imgdtllist) {%>
  <li>
 <a href="http://images1.d1.com.cn<%=dtlimg.getGdsimgdtl_bigimg() %>" class="cloud-zoom-gallery" 
 rel="useZoom: 'zoom1', smallImage: 'http://images1.d1.com.cn<%=dtlimg.getGdsimgdtl_midimg() %>'" target="_blank">
 <img src="http://images1.d1.com.cn<%=dtlimg.getGdsimgdtl_smallimg() %>" /></a>
  </li>
 <%} %>

 </ul>
</div>
					<%
					}else{
					%>
					
							<img src="<%=ProductHelper.getImageTo400(product) %>" width="400" height="400"  alt="<%= Tools.clearHTML(product.getGdsmst_gdsname()) %>"/>
							<!-- 200-50的图标 -->
							<%
							     if(product.getGdsmst_validflag().longValue()==1&& product.getGdsmst_shopcode().equals("00000000")&&product.getGdsmst_virtualstock().longValue()>0)
							     {%> 
							    	 <a href="" title="晚上22点前支付，即可在当日由圆通快递发出"><span style="position:absolute; width:125px; height:36px; dislay:block; background:url('http://images.d1.com.cn/images2015/act/gdssf.jpg'); right:20px; top:10px; z-index:5000;"></span></a> -->
           				 
							     <%}
							 
							     if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009"))&&Tools.longValue(product.getGdsmst_specialflag()) != 1)
							     {%>
							    	<!-- <a href="http://www.d1.com.cn/zhuanti/201303/szn0307/" target="_blank"><span style="position:absolute; width:89px; height:125px; dislay:block; background:url('http://images.d1.com.cn/images2013/product/400-fz.png'); left:4px; top:10px; z-index:5000;"></span></a> -->
           				 
							     <%}
							 if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("014"))&&Tools.longValue(product.getGdsmst_specialflag()) != 1)
						     {%>
						    	<!--<a href="http://www.d1.com.cn/zhuanti/201303/szn0307/" target="_blank"><span style="position:absolute; width:89px; height:125px; dislay:block; background:url('http://images.d1.com.cn/images2013/product/400-zp.png'); left:4px; top:10px; z-index:5000;"></span></a>-->
       				 
						     <%}
						
							 }
							%>	<% String bigimg=product.getGdsmst_bigimg();
							 if(bigimg!=null&&bigimg.startsWith("/shopimg/gdsimg")){
								 bigimg = "http://images1.d1.com.cn"+bigimg;
								}else{
									bigimg = "http://images.d1.com.cn"+bigimg;
								}
							%>
							  
							<div class="fdtp"><img src="http://images.d1.com.cn/images2012/New/fdtp.gif" style="border:none;" align="top" /><a href="<%=bigimg %>" target="_blank">&nbsp;点击放大图片</a></div>
							
							<div class="share">
								<img src="http://images.d1.com.cn/images2012/New/p_013-2.png" />&nbsp;&nbsp;
								<a href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','<%=ProductHelper.getImageTo400(product) %>','<%=fxcontent %>','http://www.d1.com.cn/gdsinfo/<%=id %>.asp','utf-8'));" title="分享到新浪微博" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/sina.gif" alt="分享到新浪微博" /></a>
								<a title="分享到搜狐微博" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','<%=ProductHelper.getImageTo400(product) %>','<%=fxcontent %>','http://www.d1.com.cn/gdsinfo/<%=id %>.asp','utf-8'));" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/sohuwb.gif" width="18" height="17" alt="分享到搜狐微博" /></a>
								<a href="javascript:void(0)" onclick="postToWb();return false;" title="转播到腾讯微博" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/wb.gif" alt="转播到腾讯微博" /></a>
								<script type="text/javascript">
								function postToWb(){
			                        var _t = encodeURI(document.title);
			                        _t=encodeURI('<%=fxcontent.replace("@D1优尚官网","@D1优尚网") %>');
			                        var _url = encodeURIComponent('http://www.d1.com.cn/gdsinfo/<%=id %>.asp');
			                        var _appkey = encodeURI("7d55b7e157054243b4a6bd7a826cbc40");//你从腾讯获得的appkey
			                        var _pic = encodeURI('<%=ProductHelper.getImageTo400(product) %>');//（例如：var _pic='图片url1|图片url2|图片url3....）
			                        var _site = 'http://www.d1.com.cn/gdsinfo/<%=id %>.asp';//你的网站地址
			                        var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
			                        window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
			                    }
								(function(){
			                        var p = {
			                        url:'http://www.d1.com.cn/gdsinfo/<%=id %>.asp',
			                        desc:'<%=fxcontent %>',/*默认分享理由(可选)*/
			                        summary:'<%=fxcontent %>',/*摘要(可选)*/
			                        title:'<%=fxcontent %>',/*分享标题(可选)*/
			                        site: 'http://www.d1.com.cn/gdsinfo/<%=id %>.asp', /*分享来源 如：腾讯网(可选)*/
			                        pics:'<%=ProductHelper.getImageTo400(product) %>' /*分享图片的路径(可选)*/
			                        };
			                        var s = [];
			                        for(var i in p){
			                        s.push(i + '=' + encodeURIComponent(p[i]||''));
			                        }
			                        document.write(['<a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?',s.join('&'),'" target="_blank" title="分享到QQ空间" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/qq.gif" alt="分享到QQ空间" /></a>'].join(''));
			                        })();
								</script>
						
							
							</div>
							 <%
							 //if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=2){
							// if((rackCode.startsWith("020")||rackCode.startsWith("030"))&&!rackCode.startsWith("020011")&&!rackCode.startsWith("020012")&&!rackCode.startsWith("030011")){%>
							
					    	<!--  <a href="/gdscoll/freegdscoll.jsp?id=<%= id%>"  rel="nofollow" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/DIYdp.gif" style="border:none;"/></a><br/>
					    	 <font style="font-family:'微软雅黑'; font-size:14px; ">服饰搭配购买，立享<font style="color:#aa0000">95折</font></font> -->
					         <%//}
							// }
					      %>
					</div>
					</div>
					<!-- 商品展示结束-->
				 	<!--商品信息说明-->
				     <div class="gs_right_spContent">
				     <div class="gs_right_title">
					<h1 style="text-align:left;">
					<%=gdsname %>
					
					<%
						out.print("<span style=\"color:#4b4b4b;font-size:14px; font-weight:normal\"><br/>"+(!Tools.isNull(product.getGdsmst_title())?product.getGdsmst_title():"")+"&nbsp;</span>");
					if(isdx){
						out.print("<span style=\"color:#c00;font-size:14px;\"><br/>该商品为独享特价商品，只支持在线支付</span>");
						}
					if(isdx&&product.getGdsmst_specialflag().longValue()!=1){
					out.print("<span style=\"color:#c00;font-size:14px;\"><br/>独享特价商品不能用券</span>");
					}
					SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
					Date endDate=null;
					boolean endflag=true;
					try{
						endDate =fmt.parse("2013-12-17");
					 }
					catch(Exception ex){
						ex.printStackTrace();
					}
					if(Tools.dateValue(endDate)<System.currentTimeMillis())
					{
						endflag=false;
					}
					if(endflag){

					if(product.getGdsmst_brand().equals("001564")&&product.getGdsmst_rackcode().startsWith("020")){ %>
					<a href="http://www.d1.com.cn/product/01517654" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>小栗舍品牌商品满99元送猫眼石蝴蝶毛衣链</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001691")&&product.getGdsmst_rackcode().startsWith("020")){ %>
					<a href="http://www.d1.com.cn/product/02300233" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>诗若漫品牌商品满99元送纪念版糖果色女士钱包</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001346")&&product.getGdsmst_rackcode().startsWith("030")){ %>
					<a href="http://www.d1.com.cn/product/03200078" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>FEEL MIND品牌商品满99元送美式休闲贴布棒球帽 </span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001819")){ %>
					<a href="http://www.d1.com.cn/product/04000543" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>楚薇薇品牌商品满99元送竹炭加厚拉绒多色连裤袜</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001806")){ %>
					<a href="http://www.d1.com.cn/product/02200265" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>欣缘木子品牌商品满99元送加厚加长男女仿羊绒围巾</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001753")){ %>
					<a href="http://www.d1.com.cn/product/04000570" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>花君品牌商品满99元送温暖多色明星款围巾</span></a> 
					 <br/>
					 <%}
					/*001753：花君品牌商品满99元送温暖多色明星款围巾04000570  
					001815：偌缃惜品牌商品满99元送保暖毛线针织半指手套04000003  
					001458：以诗萜品牌商品满88元送弥妮黑白性感女士内裤 02002035  
					001457：以比赞品牌商品满88元送弥妮黑白性感女士内裤  02002035  

					001801：谷翼崎品牌商品满99元送趣味搞笑防风打火机01517648  
					000151：Zippo商品满99元送Zippo火机油133ML
					01502751  
					000201：卡西欧品牌商品满99元送卸表带器 01503651 */
					if(product.getGdsmst_brand().equals("001815")){ %>
					<a href="http://www.d1.com.cn/product/04000003" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>偌缃惜品牌商品满99元送保暖毛线针织半指手套</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001458")){ %>
					<a href="http://www.d1.com.cn/product/02002035" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>以诗萜品牌商品满88元送弥妮黑白性感女士内裤</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001457")){ %>
					<a href="http://www.d1.com.cn/product/02002035" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>以比赞品牌商品满88元送弥妮黑白性感女士内裤</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("001801")){ %>
					<a href="http://www.d1.com.cn/product/01517648" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>谷翼崎品牌商品满99元送趣味搞笑防风打火机</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("000151")){ %>
					<a href="http://www.d1.com.cn/product/01502751" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>Zippo商品满99元送Zippo火机油133ML</span></a> 
					 <br/>
					 <%}
					if(product.getGdsmst_brand().equals("000201")){ %>
					<a href="http://www.d1.com.cn/product/01503651" target="_blank">
					  <span style="color:#c00;font-size:20px;"><br/>卡西欧品牌商品满99元送卸表带器</span></a> 
					 <br/>
					 <%}
					}
					if(httpurl!=null&&httpurl.indexOf("club.mail.163.com/jifen/lottery")>0
							&&"01516824".equals(product.getId())){ %> <br/><span style="color:#c00;font-size:25px;">网易的兑换码已经发完，如果您想购买此商品，  <br/>可以联系在线客服QQ号：2830191426   索取39元包邮兑换码。<br/></span><a href="http://www.d1.com.cn/market/1211/wydhyksd/index.jsp" target="_blank"><span style="color:#c00;font-size:25px;">兑换页面 请点击>></span></a><%} %>
					
					<%if(Tools.longValue(product.getGdsmst_specialflag()) == 1&&!"01720068".equals(product.getId())&&!"01720270".equals(product.getId())
					&&!"01720843".equals(product.getId()) &&!"02000396".equals(product.getId())
					&&!"01517302".equals(product.getId())&&!"01517367".equals(product.getId())){ %><br/><span style="color:red;font-size:14px;">该商品不能使用优惠券</span><%} %>
					<%if(issgflag&&!isdx&&hyprice>10f) {
						out.print("<span style=\"color:red;font-size:14px;\">闪购商品特价，仅限在线支付</span>");
					}
					%>
					</h1>
					</div>
					
					<%
					if(!issgflag&&!ismiaosha&&!isdx){
						if(lUser!=null&&UserHelper.isPtVip(lUser)){
							hyprice=bjprice;
						}else if(lUser!=null&&UserHelper.isVip(lUser)){
							hyprice=vipprice;
						}
					}
					if(isdx){
						hyprice=dxprice;
					}
					%>
<div class="pprice">
  <div  class="ppricep" 
  <%
  	if ((issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) {
  %>
  	style="background-color:#666666"
  <%
  	}
  %>
  >
   <table width="240" height="80" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="55" width="160" class="p_mp del">￥<%=df2.format(hyprice)%></td>
    <td>
    	<%
    		if (!(issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) {
    	%>
    	<span  class="p_pz"><%=Tools.getFloat(hyprice*10/saleprice, 1) %>折</span>
    	<%
    		}
    	%>
    </td>
  </tr>
  <tr>
    <td height="25"  class="p_sp">市场价：￥<s><%=df2.format(saleprice)%></s></td>
    <td></td>
  </tr>
</table>

       </div>
 
       <div class="<%if ((issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) { %>ppricet1<%}else {%>ppricet<%} %>">
      <%
      if (isdx){
    		out.print("独享价");
      }
	  else if ((issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) {
%>
	<font style="font-size:16px">
		<b>抢<br/>
		  光<br/>
		  了</b>
	</font>
<%
	  }
      else if(issgflag) {%>
<img src="http://images.d1.com.cn/images2013/product/p_007.png" width="55" height="25" />
<%
}else if (ismiaosha){
	out.print("促销价");
}else{
	if(lUser!=null&&UserHelper.isPtVip(lUser)){
		out.print("白金价");
	}else if(lUser!=null&&UserHelper.isVip(lUser)){
		out.print("VIP价");
	}else{
	out.print("D1价");
	}
}

%>
</div>
       
       </div>
		 <!--促销区-->
		
       <div class="p_cxtxt">
       <% 
  
    	 
    	   if(!isdx&&issgflag){
	
	%>
        <table width="100%">
  <tr>
  <td width="70%">
  <div  style="height:21px; padding-left:<%=400*sgper/100-100%>px">已售：<%=sgvbuy %> </div>
<div style="height:8px; padding-left:<%=400*sgper/100-4%>px">
       <img src="http://images.d1.com.cn/images2013/product/p_005.jpg" width="8" height="5" />
       </div>
       <table width="400" height="4px;">
  <tr>
    <td width="<%=sgper %>%" bgcolor="<%if((issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) {out.print("#666666");} else {out.print("#018e32");}%>"></td>
    <td  width="<%=100-sgper %>%"  bgcolor="#be1625"></td>
  </tr>
</table>
</td>
<td width="30%" valign="bottom">&nbsp;&nbsp;限量<%=sgmaxnum %></td>
</tr>
</table>
<%}
if(!isdx&&ismiaosha){
  java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
              String	nowtime= df.format(new Date());
            String tttime =df.format(msedate);
%>
 <script language=javascript>
		var startDate2= new Date("<%=nowtime%>");var endDate2= new Date("<%=tttime%>");
		lasttime=(endDate2.getTime()-startDate2.getTime())/1000;
		setInterval(vms_time,1000);</script>
<table width="100%" height="30" >
  <tr>
    <td width="5%" ><img src="http://images.d1.com.cn/images2013/product/p_006.jpg" width="21" height="21" /></td>
    <td width="30%">剩余时间：<span id="pmstime">
    
    </span></td>
    <td width="65%" style="color:#bc1622">
    	<%
    		if ((issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) {
    			out.println("已经抢光了下次请早!");
    		}
    		else if(issgflag && (sgmaxnum > sgmaxnum*sgper/100))out.print("闪购商品，到期恢复原价"); %>
    </td>
  </tr>
</table>
<%} 
if(!issgflag&&!isdx&&!ismiaosha) {
	if(lUser!=null&&UserHelper.isPtVip(lUser)){
		%>
		
<div class="p_vipp">会员 价：￥<s><%=df2.format(memberprice) %></s>&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;  VIP价：￥<s><%=df2.format(vipprice)  %></s></div>
	<%
	}else if(lUser!=null&&UserHelper.isVip(lUser)){
		%>
		
		<div class="p_vipp">会员 价：￥<s><%=df2.format(memberprice) %></s>&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;  白金价：￥<%=df2.format(bjprice)  %></div>
			<%
	}else{
%>
		
		<div class="p_vipp">VIP价：￥<%=df2.format(vipprice) %>&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;  白金价：￥<%=df2.format(bjprice)  %></div>
			<%
	}
%>

<%} %>
       </div>
        <!--促销区-->
					
				     
                         <table border="0" cellpadding="0" cellspacing="0" width="100%">	
                         <%D1ActTb acttb=CartHelper.getShopD1actFlag(product.getGdsmst_shopcode(),id); 
                         if(acttb!=null){
                        	 
                        	 String acttxt="";
								String goshopurl="";
								if(acttb.getD1acttb_acttype().longValue()==0){

									if(shpmst!=null&&shpmst.getShpmst_index().longValue()==1&&
											!Tools.isNull(shpmst.getShpmst_shopsname())){
									goshopurl="http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname();
									}else{
										if(shpmst!=null)goshopurl="http://www.d1.com.cn/shopbrand.jsp?sc="+shpmst.getId();
									}
									if(shpmst!=null&&shpmst.getId().equals("00000000")){
									goshopurl="http://www.d1.com.cn/html/zt2014/nzdc/index.jsp";
									}
								}else if(acttb.getD1acttb_acttype().longValue()==1){
									goshopurl="http://www.d1.com.cn/html/result_rec.jsp?aid="+acttb.getD1acttb_ppcode();
								}else if(acttb.getD1acttb_acttype().longValue()==2){

									goshopurl="http://www.d1.com.cn/shopbrand.jsp?sc="+acttb.getD1acttb_shopcode()+"&brand="+acttb.getD1acttb_brandcode();
								}else if(acttb.getD1acttb_acttype().longValue()==3){

									goshopurl="http://www.d1.com.cn/result.jsp?shopd1=1&productsort="+acttb.getD1acttb_ppcode();
								
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
                         %>			             
								 <tr height="35">
							     <td colspan="3">
							     
                                  <span style="width:44px;height:21px;display:block; background:#ca101d; line-height:21px;text-align:center;color:#fff;float:left">满减</span>
                                  <span style="width:460px;height:21px;float:left;line-height:21px;display:block;padding-left:15px;"><a href="<%=goshopurl %>" target="_blank" style="color:#ca101d"><%=acttxt %><font style="color:#4b4b4b">&nbsp;&nbsp;&nbsp;查看活动商品</font></a></span>
							 </td>	
							  </tr>
							 <%}%>
							 <%
							 if("1".equals(chePingAn)){
							 %>
							 <tr><td colspan="3">
							 	<font color=#F47320>积分兑换需要：<font size=+1><b><%=(int)hyprice*500 %></b></font>分<br />现金购买此商品可获得：<font size=+1><b><%=(int)hyprice*30 %></b></font>分</font>
							 </td></tr><%} %>
							 <tr height="30">
							     <td colspan="3">商品编码：<%=id %>
							 </td>
							 <% if(!Tools.isNull(product.getGdsmst_brand())&&!product.getGdsmst_brand().equals("000000")){ %>
							 </tr>
							  <tr height="30">
							     <td colspan="3"><%
							
								 String rackcode_temp = product.getGdsmst_rackcode();
								 if(rackcode_temp!=null&&rackcode_temp.length()>=3){
									 rackcode_temp = rackcode_temp.substring(0,3);
									 String brandcode=product.getGdsmst_brand().trim();
									 String url="/result.jsp?productsort="+rackcode_temp+"&brand="+brandcode+"";
									 ArrayList<Brand> blist=BrandHelper. getBrandInfo(rackcode_temp,brandcode);
									 if(blist!=null && blist.size()>0){
										 if(!Tools.isNull(blist.get(0).getBrand_url())){
											 url=blist.get(0).getBrand_url();
										 }
									 }
									 
							 %>
							 品　　牌：<font color="#c0000">[<a href="<%=url %>" target=_blank rel="nofollow"><%=brandName %></a>]</font>
							      <%
								 }
							
							 
							 %>
							 </td>
							 </tr>
<% } %>
							<tr height="30">
							     <td colspan="3"> 服　　务：由 <%if(!Tools.isNull(shopindexurl)){%><a href="<%=shopindexurl%>" target="_blank"><%} %><span style="color:#ff0000"><%=shpmst.getShpmst_shopname() %></span><%if(!Tools.isNull(shopindexurl)){%></a> <%} %>发货，开具发票并提供售后服务。
							    <%  if (!Tools.isNull(Shpmstbulletin)){
                        	  out.print("<br>　　　　　<span style=\"color:#cc0000\">"+Shpmstbulletin+"</span>");
                        	  }%>
							     </td></tr>
						     <tr height="30">
							     <td colspan="3">
							     	<div style="float:left; padding-top:6px;">顾客评分：</div>
							     	<div class="sa<%=score %>" style="float:left;" ></div>
							     	
								    <div style="float:left;padding-top:6px;"><a href="#cmt2" onclick="$('#sdLink').hide();$('#commLink').show();$('#ssd').hide();$('#scomment').show();"  rel="nofollow"><%if(contentcount>0) {%>(已有<%=contentcount %>人评价)<%} %></a>
								     &nbsp; &nbsp; &nbsp; &nbsp;
								    <% 
								    ArrayList<MyShow> showlist=null;
								    //ShowOrderHelper.getAllShowByGdsid(product.getId());
								    int showlen=0;
								   %>
								    </div>
								    
								 </td>
						     </tr>
							 <tr>
							     <td colspan="3">
								     <div class="spgg"><% 
									    //颜色
									    GoodsGroup group = getGroup(product);
									    if(group != null){
										    List<GoodsGroupDetail> groupList = getGroupDetail(group);
										    if(groupList!= null && !groupList.isEmpty()){
										    	int count=0;
										    	for(GoodsGroupDetail ggd : groupList)
										    	{
										    		String gId = Tools.trim(ggd.getGdsgrpdtl_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		if(goods!=null&&goods.getGdsmst_validflag().longValue()==1&&goods.getGdsmst_ifhavegds().longValue()==0)
										    		{
										    			count++;
										    		}
										    	
										    	}							    	
                                                if(count>1)
                                                {										    	
										    	%><div id="skuname2" class="skuname1">
										    	<p>选择<%=Tools.formatString(group.getGdsgrpmst_stdname()) %>：<font id="sizecount2"></font></p>
									    		<ul><%
									    		String selectSku2 = "";
										    	for(GoodsGroupDetail ggd : groupList){
										    		String gId = Tools.trim(ggd.getGdsgrpdtl_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		if(goods!=null&&goods.getGdsmst_validflag().longValue()==1)
										    		{
										    		%><li<%if(product.getId().equals(goods.getId())){ selectSku2 = ggd.getGdsgrpdtl_stdvalue(); %> class="select"<%} %>>
										    		<a href="<%=ProductHelper.getProductUrl(goods) %>"  attr="<%=ggd.getId() %>" hidefocus="true"<%if(product.getId().equals(goods.getId())){ %> class="current"<%} %>><img src="<%=ProductHelper.getImageTo80(goods) %>" />
										    		<i></i>
										    		</a>
										    		<br/><%=ggd.getGdsgrpdtl_stdvalue() %></li><%
										    		}
										    	}
										    	%></ul>
										    	</div>
										    	<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script><%
										        }
										    }
									    }
									    
									    ///sku
									     List<Sku> skuList=new ArrayList<Sku>();
									    if(!Tools.isNull(skuname1)){
									    	int showsku=1;
									    	if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
									    		showsku=0;
									    	}
									    	//System.out.println(showsku);
										   	 skuList = SkuHelper.getSkuListViaProductIdO(id,showsku);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname" class="skuname">
										    		<p>选择<%=skuname1 %>：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font>
										    		<%  ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(id);
										    		
										    		
										    		   if(list!=null&&list.size()>0 || (product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0))
										    		   {
										    			   String sizeinfo="";
											    		   if(product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0){
											    			   sizeinfo= getsizeinfo(product);
											    		   }
										    			   if((list.size()>0&& list.get(0).getGdsatt_content().length()>0) || !Tools.isNull(sizeinfo)){
										    		    %>
										    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">(尺寸对照表)</font></p>
										    		      <div id="ccdzb_img" style="position:absolute;display:none; z-index:2222;<%if(!Tools.isNull(sizeinfo)) {%>border:1px solid black;background-color:#ffffff;<%} %>" onmouseover="ccdzb()" onmouseout="ccdzb1()">
										    		    <%
										    		      if(!Tools.isNull(sizeinfo)){
													    		 out.print(sizeinfo);
													    	  }else{%>
										    		    <%= list.get(0).getGdsatt_content() %>
										    		      <%  }%>
										    		    </div>
										    			  <%   }
										    			   
										    		  }
										    		   else
										    		   {%>
										    			   </p>
										    		   <%
										    		   
										    		   }
										    		%>
										    		
										    		<ul>
										    		<%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><li><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li><%
										    				}
										    				else
										    				{
										    					if(sku.getSkumst_vstock().longValue()<=0){ %>
										    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
										    					<%}
										    					else
										    					{%>
										    						<li><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
										    					<%}
										    				}
										    			}else{
										    	           if(sku.getSkumst_validflag()!=null&&sku.getSkumst_validflag().longValue()==1)
										    	           {
										    	        	   if(sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()<=0&&product.getGdsmst_ifhavedate()!=null&&product.getGdsmst_ifhavedate().after(new Date()))
										    	        	   {
										    			%><li><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" flag="1" onclick="choosesku20120717(this)" hidefocus="true"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li><%
										    	               }
										    	        	   else
										    	        	   {%>
										    	        		   <li><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" flag="0" onclick="choosesku20120717(this)" hidefocus="true"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
										    	        	   <%}
										    	           }
										    			}
										    		}
										    		%>



										    		
										    		
										    		
										    		</ul>
										    	</div><div class="clear"></div><%
										    }
									    }
									   
									    %>
										<div>
											<span>购买数量：</span>&nbsp;&nbsp;
											<a href="###" title="减1" class="minus" onclick="addorminus('minus',<%=buylimit %>,'<%=endprice %>')" ><img src="http://images.d1.com.cn/Index/images/j_a.png"  /></a>
										    <input type="text" id="num_input" objNum="1" value="1" onkeyup="keynum(this,<%=endprice %>);" maxlength='3' class="num" />
										    <a href="###" title="加1" class="add" onclick="addorminus('add',<%=buylimit %>,'<%=endprice %>')"><img src="http://images.d1.com.cn/Index/images/a_j.png"  /></a><br />
										    <%
										    if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==0){
										    	Date ifhaveDate = product.getGdsmst_ifhavedate(); 
												if(ifhaveDate != null){//那就是有到货期限。
													if(ifhaveDate.after(new Date()))
													{
													  	if(!Tools.isNull(skuname1)){
													    	String str="";
													    	for(int i=0;i<skuList.size();i++){
												    			Sku sku = skuList.get(i);
												    			String skuname = sku.getSkumst_sku1();
												    			if(sku.getSkumst_validflag()!=null&&sku.getSkumst_validflag().longValue()==1&&sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()==0)
												    			{
												    				str+=skuname+"，";
												    			}
													    	}
													    	if(str.length()>0)
													    	{
															   out.print("<br/><font style=\"color:#f66500\">该商品"+skuname1+str+"预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
													    	}
													    }
													    else
													    {
													    	if(product.getGdsmst_ifhavegds()!=null&&(product.getGdsmst_ifhavegds().longValue()==0)){
														  	out.print("<br/><font style=\"color:#f66500\">该商品预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
													    	}
													    }
												    }
													}
													
												  
													
												
										    	
										    }
										    %>
										</div>
										<div class="clear"></div>
								
										<%
										if(giftProduct != null&&giftProduct.getGdsmst_validflag()!=null&&giftProduct.getGdsmst_validflag().longValue()==1){
											String giftTitle = Tools.clearHTML(giftProduct.getGdsmst_gdsname());
										%>
										<div class="breakall" style="width:100%;">
											<font color="#892e3f"><b>赠品：</b></font><a href="<%=ProductHelper.getProductUrl(giftProduct) %>" target="_blank" title="<%=giftTitle %>"><%=StringUtils.getCnSubstring(giftTitle,0,44) %></a>
										</div><%
										} %>
									 </div>
								 </td>
							 </tr>
							 <tr height="60"><td colspan="3" valign="middle"><%
							if(ifhavegds == 0){
								//System.out.println(1);
								if(validflag == 1){
									//System.out.println(2);
									if(isstockflag){
										//System.out.println(3);
										 if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==0)
										 { 
											 //System.out.println(4);
								                Date ifhaveDate1 = product.getGdsmst_ifhavedate(); 
									            	if ((issgflag && (sgmaxnum == sgmaxnum*sgper/100))||!isstockflag) {
									            	%>
									            		<img id="gwc0718" src="http://images.d1.com.cn/images2014/product/allout.png" />
									            	<%
									            	}
									            	else if(skuList != null && !skuList.isEmpty()){%>
									            	 <a href="javascript:void(0)" onclick="ShowAJax1('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2014/product/frgwc.png" /></a>
									            	<%}
									            	else
									            	{
									            		if(product.getGdsmst_ifhavegds()!=null&&(product.getGdsmst_ifhavegds().longValue()==1||product.getGdsmst_ifhavegds().longValue()==2)){
														  	
									                  %>
								                <a href="javascript:void(0)" onclick="ShowAJax1('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2012/index2012/ydgsp.jpg" /></a>
						                         <%    }
									            		else{%>
									            			<a href="javascript:void(0)" onclick="ShowAJax1('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2014/product/frgwc.png" /></a>
									            		<%}
									            	}
										 }
									    else
									    {%>
							             <a href="javascript:void(0)" onclick="ShowAJax1('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2014/product/frgwc.png" /></a>
							            <%} %>
							 <div class="frgwc_div" id="frgwc" style="display:none;z-index:1999;">
							 <div class="frgwcitem">
							    <span style="position:relative;overflow:hidden;">
							    	<font id="countgdsmst1">1</font>件商品加入购物车
							    	<a href="###" class="ui-dialog-titlebar-close ui-corner-all" onclick="$('#frgwc').hide();"><span class="ui-icon ui-icon-closethick">close</span></a>
							    </span>
								<ul>
								<li>
								<%
								String smallimg=product.getGdsmst_smallimg();
								if(smallimg.startsWith("/shopimg/gdsimg")){
									smallimg = "http://images1.d1.com.cn"+smallimg;
								}else{
									smallimg = "http://images.d1.com.cn"+smallimg;
								} %>
								    <img src="<%=smallimg %>" width="80" height="80" />
									<div style="height:80px;"> <font style="_font-size:12px; "><b>
                                        <%=gdsname %></b></font>
									<br/><br/>
									    加入数量：<font id="countgdsmst2">1</font><br/>
									    总计金额:￥<font id="countgdsmst3"><%=endprice %></font><br/>
									</div>
								
								</li>
								</ul>
								<div class="gwcbtn"><a href="/flow.jsp" target="_blank" onclick="display_hide('frgwc');"><img src="http://images.d1.com.cn/images2012/New/viewcart.gif" alt="查看购物车" /></a><a href="javascript:void(0)" onclick="display_hide('frgwc')"><img src="http://images.d1.com.cn/Index/images/jxgw.jpg" alt="继续购物" /></a>							</div>
							 </div>
							 </div>
							 <%
									}else
										{%>
											<img src="http://images.d1.com.cn/images2014/product/yqg.png"  />
										<%}
							 
								}else if(validflag != 4){
									if(id.equals("02001470")||id.equals("03000384")
											||id.equals("03000385")||id.equals("02001469")){
										%>
										<img src="http://images.d1.com.cn/images2013/product/shouqin.jpg"  />
										<%
									}else{
									%><img src="http://images.d1.com.cn/images2014/product/yqg.png" /><%
									}
									}
							 }else if(ifhavegds == 1){//有到货时间
								Date ifhaveDate = product.getGdsmst_ifhavedate(); 
								if(ifhaveDate != null){//那就是有到货期限。
									long spanDay = (ifhaveDate.getTime()-System.currentTimeMillis())/Tools.DAY_MILLIS+1;
									if(spanDay > 0){
										%><span class="dhtx">暂时缺货，预计<%=spanDay %>天到货</span><%
									}else{
										%><span class="dhtx">暂时缺货，近期将到货！</span><a href="###" onclick="emailTZ('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/dhnotice.gif" align="absmiddle" /></a><%
									}
								}else{
									%><span class="dhtx">暂时缺货，近期将到货！</span><a href="###" onclick="emailTZ('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/dhnotice.gif" align="absmiddle" /></a><%
								}
							 }else if(ifhavegds == 2){//缺货时间未定
								%><span class="dhtx">暂时缺货，到货时间未定！</span><a href="###" onclick="emailTZ('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/dhnotice.gif" align="absmiddle" /></a><%
							 }else if(ifhavegds == 3){//非卖品
								%><span class="dhtx">此商品为非卖品，暂时不能订购！</span><%
							 } %>
							 &nbsp;&nbsp;<a href="###" onclick="addFavorite('<%=id %>');"><img src="http://images.d1.com.cn/images2014/product/jrsc.png" /></a>
							  
							 </td></tr>
							 <!--   <tr><td colspan="3">消费1元积1分 评论/分享得积分。</td></tr>-->
							 <tr><td colspan="3" height="8"></td></tr>
							 <%
							 List<YhNews> yhNewsList = YhNewsHelper.getYhNewsList(product,4);
							 if(giftProduct != null || (yhNewsList != null && !yhNewsList.isEmpty())){
							 %>
							
							 <tr>
							     <td colspan="3">
								    <div class="zxyh">
									    <font color="#892e3f"><b>最新优惠：</b></font>
									    <ul><%
									    if(yhNewsList != null && !yhNewsList.isEmpty()){
									    for(YhNews info : yhNewsList){
									    	String title = Tools.clearHTML(info.getYhnews_title());
									    %>
										<li><a href="<%=Tools.trim(info.getYhnews_link()) %>" title="<%=title %>" target="_blank" class="anew" rel="nofollow"><%=title %></a></li><%
										}} %>
										</ul>
									</div>
									<div class="clear"></div>
								 </td>
							 </tr><%
							 } %>
						 </table>		 
					 </div>
					  <!--商品信息说明结束-->
				  </div>
				 <!-- 商品展示结束-->
				<div class="clear"></div>
		 </div>
	    <div class="goodsshow">
		    
			 
			 <!--商品展示右侧-->
			<div class="gs_right">
			    
				
				 
				 <!-- 最佳组合-->
				 <a name="gdsgrp"></a>
				 <%  String zhsp="";
				     zhsp=getGdscoll(product);
				 if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=2)
				 {
				 //String zhsp = getGdspkt(product);
				
				 //if(id.equals("01715898")||id.equals("03000042")||id.equals("02000034")||id.equals("01711848")||id.equals("01711853")||id.equals("03000033")||id.equals("02000023")||id.equals("01711849")||id.equals("01711854")||id.equals("01715900")||id.equals("01717061")||id.equals("03000040")||
						 //id.equals("02000033")||id.equals("01716995")||id.equals("01716996")||id.equals("03000068")||id.equals("02000032")||id.equals("01711846")||id.equals("01711851")||id.equals("03000018")||id.equals("02000021")||id.equals("03000017")||id.equals("02000020")||id.equals("01717060")){
					 //zhsp=getGdscoll0719(product);
				 //}
				// else
				// {
					
				// }
				// String zhsp=getGdscoll(product);
				 %><%=zhsp!=null?zhsp:"" %>
				 <%} %>
				 <!-- 最佳组合结束-->
				
				<!-- 相关商品 -->
				<%if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==2)
				 {%>
				<% 
				request.setAttribute("code", rackCode);
			    request.setAttribute("length", 12);
			%>
				<jsp:include   page= "/html/getProductCList.jsp"   />
				<%} %>
				 <!--商品信息描述-->
				 <div style=" text-align:left;" ><a name="cmt"></a>
				  <%
				 boolean isdp=false;
				 if ("001346".equals(product.getGdsmst_brand())||"001691".equals(product.getGdsmst_brand())
			    		 ||"001564".equals(product.getGdsmst_brand()) || product.getGdsmst_rackcode().startsWith("02") || product.getGdsmst_rackcode().startsWith("03")){
				ArrayList<Gdscolldetail> scolllist=GdscollHelper.getGdscolldetailBygdsid(product.getId().trim());
				 if(scolllist!=null && scolllist.size()>0){
					 for(Gdscolldetail d:scolllist){
						 Gdscoll scoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(d.getGdscolldetail_gdscrollid().toString()) ;
							if(scoll!=null && scoll.getGdscoll_flag().longValue()==1){
								isdp=true;
							}
					 }
					 
				 }}
					if(isdp){ %>
					 <div id="divhotimg" style="padding-left:160px;"><img src="http://images.d1.com.cn/images2012/product/hot.gif"/></div>
				  <%}
				 %>
				 <div id="goodsinfotab" class="zh_title"><a href="#cmt" class="newa" onclick="showhot();" attr="info">商品信息</a>
				<%
				    if(isdp){%>
				    	<a href="#cmt" onclick="hidehot();" attr="dp">搭配推荐</a>
				    <%}
				if(showlen>0){%>
					<a href="#cmt" attr="sd">优格晒单</a>
				<%}				
				%>
			
					
					 <a href="#cmt" attr="com">顾客评论</a><a href="#cmt" attr="q">商品问答</a><a href="#cmt"  attr="q">售后及配送</a>
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=9&&"015002003".equals(product.getGdsmst_rackcode().substring(0, 9))) { %><a href="#cmt" attr="zippo">关于Zippo</a><%} %>
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=3&&"014".equals(product.getGdsmst_rackcode().substring(0, 3))) { %><a href="#cmt" attr="zpbz">正品保证</a><%} %>
					<!-- <a href="#top1120" style="background:none;padding-right:0px; margin-right:0px; margin-top:5px; border:none; float:right;" onclick="ShowAJax1('<%=id %>')"><img  src="http://images.d1.com.cn/images2012/index2012/nov/gwc.jpg" width="93" height="23"/></a>	-->			
					
					</div>
					<div class="clear"></div>
					<div id="content_list_info">
					<!-- 商品信息-->
					<span style="display:block">
					 <div class="goods_info">
					 <%  
					      if(!Tools.isNull(product.getGdsmst_stdvalue1())||!Tools.isNull(product.getGdsmst_stdvalue2())||!Tools.isNull(product.getGdsmst_stdvalue3())||!Tools.isNull(product.getGdsmst_stdvalue4())||!Tools.isNull(product.getGdsmst_stdvalue5())
					    		   ||!Tools.isNull(product.getGdsmst_stdvalue6())||!Tools.isNull(product.getGdsmst_stdvalue7())||!Tools.isNull(product.getGdsmst_stdvalue8())){
					    //if(!Tools.isNull(getGGInfo(product))){ --%>
					    <div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/Info.jpg" />商品基本信息</div>
						<div class="goods_content_list">
							<%=getGGInfo(product) %>
						</div>
						<%} %>
						<%if (product.getGdsmst_briefintrduce()!=null&&product.getGdsmst_briefintrduce().length()>25) {%>
						<div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/Info.jpg" />商品简介</div>
						<div class="goods_content_list">
							<%String gdsduct=product.getGdsmst_briefintrduce().replace("\r", "<br>");
							gdsduct=product.getGdsmst_briefintrduce().replace("\n", "<br>");
							out.print(gdsduct);  %>
						</div>
						<%} %>
						<div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/spxq.jpg" />商品详情</div>					
						    
						<div class="goods_content goods_info_con">
						<% if(phoneflag){ %>
					 	<img src="http://images1.d1.com.cn/shopimg/gdsimg/201507/image/ef88a5d0-1800-4949-8c3d-dcc5a8ffb6c8.jpg">
						<div style="text-align:center;font-size:16px;color:#666666">
						<span style="text-decoration:line-through">会员价：<%=memberprice%>元</span><span style="color:#ff4040;font-size:20px;">&nbsp;&nbsp;微信秒杀价：<font style="font-size:36px"><%=phoneprice%></font>元</span>
					   </div>
					    <%}
						
						BrandMst brandmst=getbrandmst(product.getGdsmst_brand(),product.getGdsmst_rackcode().substring(0,3));
						if(brandmst!=null&&!Tools.isNull(brandmst.getBrandmst_authorization()))out.print("<a href=\""+brandmst.getBrandmst_page()+"\" target=\"_blank\"><img src=\""+brandmst.getBrandmst_authorization()+"\" width=\"750\"></a>");
						if ("001564".equals(product.getGdsmst_brand())){
						String strxls=Getp2013img("3386");
						out.print(strxls);
						}
						if ("001346".equals(product.getGdsmst_brand())){
							String strxls=Getp2013img("3393");
							out.print(strxls);
							}
						if ("001691".equals(product.getGdsmst_brand())){
							String strxls=Getp2013img("3392");
							out.print(strxls);
							}
						if ("001561".equals(product.getGdsmst_brand())){
							String strxls=Getp2013img("3394");
							out.print(strxls);
							}
						String aaa= product.getGdsmst_detailintruduce();
						       aaa=aaa.replace("‘","'");
						       aaa=aaa.replace("’","'");
						       if(!aaa.contains("<DIV id=2012test></DIV>")){
						       if(brandName.equals("诗若漫")&&aaa.indexOf("http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg")>=0)
						        {
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\" width=\"750\">", "");
						       
						        }
						        else if(brandName.equals("AleeiShe 小栗舍")&&aaa.contains("http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg"))
						        {
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\">","");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\">", "");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\">", "");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\" width=\"750\">", "");
						        	
						        }
						        else if(brandName.equals("FEEL MIND")&&aaa.indexOf("http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg")>=0)
						        {
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\" width=\"750\">", "");
						        	
						        }
						       }
						        else{}
						       out.print(aaa);	   
						    %>
						    <p id="20121023test"></p>
						</div>
						<%if (!"01517418".equals(product.getId())){ %>
						<%=getBrandName(product) %>
						<%} %>
						
					 </div>
					 </span>
					<!--商品信息结束-->
						 <%
						 if(isdp)
						 {
					 %>
					<span style="display:none;">
					<div id="divdp"></div>
					<script type="text/javascript">ggdscoll_product('','','',"<%=product.getId()%>")</script>
					</span>
					<!--搭配推荐结束-->
					<%} %>
				<%
				   
				if(showlen>0){%>
					 <span style="display:none;"></span>  
				<%}				
				%>
					<span style="display:none;"></span>
				  
					<!--商品问答-->
					<span style="display:none;">
					<div class="spwd">
					    <div class="wxts">
					    	<div class="textbox1">温馨提示：因厂家更改商品包装、产地或者更换随机附件等没有任何提前通知，且每位咨询者购买情况、提问时间等不同，为此以下回复仅对提问者3天内有效，其他网友仅供参考！若由此给您带来不便请多多谅解，谢谢！</div>
						</div>
						<div class="spwdlist">
						   <div class="spwdsub">
							 <div class="zxcontent_hf"><%
							List list = GoodsAskHelper.getlistByProductId(id,0,2);
							 if(list != null && !list.isEmpty()){
								 int size = list.size();
							 %>
							 <table width="768"><%
							 for(int i=0;i<size;i++){
								 GoodsAsk ask = (GoodsAsk)list.get(i);
								 String lblmember = "";
								 String lblmberuid ="";
								 if(Tools.longValue(ask.getGdsask_mbrid()) ==0){
									 lblmember = "游客";
									 lblmberuid = "游客";
								 }else{
									 lblmberuid = getUid(ask.getGdsask_uid());
									 User user = UserHelper.getById(String.valueOf(ask.getGdsask_mbrid()));
									 lblmember = UserHelper.getLevelText(user);
								 }
							 %>
							 <tr class="<%=i%2==0?"bc":"bc1" %>">
							     <td>
								     <table>
								     <tr><td height="10"></td></tr>
								     <tr style="width:768px;">
								     	<td style=" text-align:right; width:798px;">
								     		用户：<input type="text" id="lblmbruid" class="<%=i%2==0?"bcother":"bcother1" %>" value="<%=lblmberuid %>" style=" color:#464646; border:none; text-align:center; width:120px;" />
								     		&nbsp; &nbsp;<input type="text" id="lblmember" value="<%=lblmember %>" class="<%=i%2==0?"bcother":"bcother1" %>" style="color:#464646;border:none; text-align:center;  width:60px;" />
								     		&nbsp; &nbsp;<%=Tools.stockFormatDate(ask.getGdsask_createdate()) %>
								     	</td>
								     </tr>
								     <tr>
								     	<td><img src="http://images.d1.com.cn/Index/images/zxnr.jpg" />&nbsp;咨询内容：<%=Tools.clearHTML(ask.getGdsask_content()) %></td>
								     </tr>
								     <tr><td  height="10"></td></tr>
								     <tr>
								     	<td style=" color:#ac4d61;"><img src="http://images.d1.com.cn/Index/images/wthf.jpg" />&nbsp;D1回复：<%=ask.getGdsask_replyContent() %></td>
								     </tr>
								     <tr><td  height="10"></td></tr>
									 </table>
								 </td>
							 </tr><%
							 } %>
							 </table><%
							 } %>
							 </div>
						   </div>
						   <div class="clear"></div>
						   <br/>
						   <hr style="border:solid 10px #fff; width:100%; +width:768px;" /> 
						   <div class="fbzx">发表咨询 </div>
						   <div class="fbzx_sm">
						   	声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、<br />
				                               产地等参数，所以该回复仅在当时对提问者有效，其他网友仅供参考！咨询回复的工作时间为：周一至周日：9:00至21:00，请耐心等待工作人员的回复。

						   </div>
						   
						   <div class="zxlx">
						   <font style=" color:#000; font-weight:bold; ">咨询类型</font>
						      <input id="Radio6" name="asktype" type="radio" checked="checked"  value="1"/><label for="Radio6">商品咨询</label>
						      <input id="Radio7" name="asktype" type="radio"  value="2"/><label for="Radio7">库存及配送</label>
						      <input id="Radio8" name="asktype" type="radio"  value="3"/><label for="Radio8">支付问题</label>
						      <input id="Radio9" name="asktype" type="radio"  value="4"/><label for="Radio9">发票及保修</label>
						      <input id="Radio10" name="asktype" type="radio"  value="5"/><label for="Radio10">促销及赠品</label>
							  <br/><br/>
						   <font style="color:#000; font-weight:bold;">咨询内容</font><br/>
						   <textarea id="txtcontent" class="zxtext"></textarea>
						   <br/><br/>
						   <a href="javascript:void(0)" onclick="AddAsk()"><img src="http://images.d1.com.cn/Index/images/submit.jpg" /></a>
						   </div>
						</div>
					</div>
					</span>
					
					<!--商品问答结束-->
					
					<!--售后服务-->
					<span style="display:none;">
					<script>//getSHFW();</script>
							<%if (shpmst!=null){
							out.println(shpmst.getShpmst_afterSaleservice());
						}%>
						<p><strong>D1</strong><strong>商品退换货一般性规定：</strong> <br />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D1保证所售出的商品都是通过正规渠道配货发货，您享有与其它途径购买的商品同样的服务。如果您所购买的产品存在质量问题，在未经使用的情况下，您可以享受  30 天退换货的服务。 <br />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 申请退换货可以自助操作：登录官网&nbsp; <a href="http://www.d1.com.cn/user/selforder.jsp"><span style="color:#ff0000;font-size:14px;">订单查询</span></a>&nbsp; ，点击  退换货申请，按步骤操作即可。如需人工帮助，请咨询在线客服：  <a href="#" style="CURSOR: pointer" onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&amp;sid=4006808666&amp;eid=218808P8z8p8y8y8q8x8z&amp;o=www.d1.com.cn&amp;q=7&amp;ref='+document.location, '_blank', 'height=544, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');" ><span style="color:#ff0000;font-size:14px;">在线客服</span></a> <br />
  <strong>&nbsp;</strong>以下情况不予办理退换货： <br />
  （1）任何非由本公司出售的商品，不予办理退换货； <br />
  （2）任何已使用商品，不予办理退换货，但有质量问题除外； <br />
  （3）密封产品原包装打开，非质量问题不予退换； <br />
  （4）因人为疏忽或使用不当而导致的商品损坏不予退换； <br />
  （5）任何事先注明不在退换货范围的特殊商品，不予退换； <br />
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- </p>
					</span>
					<!--售后服务结束-->
					
					<!--支付配送-->
					<!--<span style="display:none;">
					<script>//getzfps();</script>
						
					</span>-->
					<!--支付配送结束-->
					<!-- 关于Zippo开始 -->
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=9&&"015002003".equals(product.getGdsmst_rackcode().substring(0, 9))) { %>
					<span style="display:none;">
					<script>getZippo();</script>
					</span>
					<%} %>
					<!-- 关于Zippo结束 -->
					
					<!-- 正品保证开始 -->
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=3&&"014".equals(product.getGdsmst_rackcode().substring(0, 3))) { %>
                    <span style="display:none;">
                     <a name="zpbz"></a>
					<script>getZpbz();</script>
					</span>
			<%} %>
					<!-- 正品保证结束 -->
					
					
					<!-- 商品晒单开始 -->
					<hr style=" border:5px solid #fff" />
					<div style="line-height:1px;height:1px;baclground:#FFF;">
					<a name="sd"></a></div>
					<%
					if(showlen>0){
						%>
					
					<div class="zh_title" id="sdLink"><a href="javascript:void(0)" class="newa">优格晒单</a></div>
					<!--商品晒单-->
					<span id="ssd">
					<%
					
						 int currentPageIndex=1;
						 int pagesize=15;
						 PageBean pBean = new PageBean(showlen,pagesize,currentPageIndex);
						 int end = pBean.getStart()+pagesize;
					 	    if(end > showlen) end = showlen;
					 	 
					 	  List<MyShow> list2 =showlist.subList(pBean.getStart(),end);
					 	 int size=list2.size();
					 	   if(list2!=null && size>0){
					 		%>
					 		<div style="width:750px;padding-top:15px;" name="sdCont" id="SdContent">
					 		<%   
					 		   int row=size/3;//得到行数,及每列个数
					 		   int last=size%3;
					 		   int l1=0; int l2=0; 
					 		   if(last==1){
					 			   l1=1;
					 		   }else if(last==2){
					 			  l1=1;
					 			  l2=1;
					 		   }
					 		   for(int i=0;i<size;i++){
					 			  MyShow show1=list2.get(i); 
				 				  Product p=ProductHelper.getById(show1.getMyshow_gdsid());
				 				
				 				 String uid=show1.getMyshow_mbruid();
				 				 if(uid.trim().length()<6){
				 					 uid="***"+uid+"***";
				 				 }else{
				 					 uid="***"+uid.substring(0, 5)+"***";
				 				 }
				 				String imgurl="http://images1.d1.com.cn";
								if( show1.getMyshow_img400500().indexOf("/uploads/sd/")>=0){
									imgurl="http://d1.com.cn";
								}
					 			   if(i==0){
					 					%>   
					 					<div style="float:left; padding-left:15px;">
					 				  <% }else if(i==row+l1){
					 					 %>   
					 					 </div>
					 					  <div style="float:left; ">
					 				   <% }else if(i==2*row+l1+l2){
						 					 %>   
						 					 </div>
						 					  <div style="float:left;">
						 				   <% }
						 				    if(p!=null){
				 				  %>   
				 				   <div  class="poster_grid poster_wall pins" > 
									<div class="new_poster"> 
									<div class="np_pic hover_pic">   
									<a target="_blank" href="<%=imgurl+show1.getMyshow_img400500() %>" class="pic_load">
									<img width="200" title="" src="<%=imgurl+show1.getMyshow_img240300() %>" onmouseover="sdimg_over('<%= show1.getId()%>')" onmouseout="sdimg_out('<%= show1.getId()%>')" class="goods_pic" /></a> 
					 
									</div> 
									<div class="comm_box"> 
									<p class="l18_f posterContent"><table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr><td align="left"><b><%=uid %></b></td><td align="right" width="100"><%= new SimpleDateFormat("yyyy-MM-dd").format(show1.getMyshow_createdate())  %></td></tr><tr><td colspan="2" align="left"><%=Tools.clearHTML(show1.getMyshow_content()) %></td></tr></tr>
									</table></p> 
									</div>
									
									  </div>
									  </div>
									  <div style="clear:both;"></div>
									   <div class="floatdp" id="floatdp<%=show1.getId() %>" style="display:none;" >
									  
									   </div>
					 			  <%  }
						 				    if(i==size-1){
						 				    	%>
						 				    	</div>
						 				   <%  }
					 		  }
					 		   
					 		%>
					 		 <div style="clear:both;height:15px;">&nbsp;</div>
					 		 <%    if(pBean.getTotalPages()>1){ %>
							<table cellpadding="0" cellspacing="0" border="0"> <tr>
								<td><div class="GPager">
						           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
						           	<%if(pBean.getCurrentPage()>1){ %><a href="#sdCont" onclick="pro_showorder('<%=id %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
						           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
						           		if(i==1){
						           		%><span class="curr"><%=i %></span><%
						           		}else{
						           		%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=i %>);"><%=i %></a><%
						           		}
						           	}%>
						           	<%if(pBean.hasNextPage()){%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
						           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
						           </div></td>
							</tr></table><%
							} %>
					 		</div>
					 		
						
					<%}}else{
						%>
						<div  id="sdLink">
						</div>
						<span id="ssd">
					<%}
					%>
					</span>
					<!-- 商品晒单结束 -->
					<!-- 商品评论开始 -->
					<hr style=" border:5px solid #fff" />
					<div style="line-height:1px;height:1px;baclground:#FFF;">
					<a name="cmt2"></a></div>
					<div class="zh_title" id="commLink" style="display:none;"><a href="javascript:void(0)" class="newa">顾客评论</a></div>
					<!--顾客评论-->
					<span id="scomment" style="display:none;">
					    	 <div style="padding-top:10px; font-size:14px; font-weight:bold; color:#000;"><a name="cmtCnt"></a>
					    		<img src="http://images.d1.com.cn/Index/images/gkpl_star.gif" style="vertical-align:text-bottom" />顾客评论
					    		<%if(lUser!=null&&lUser.getMbrmst_uid().trim().equals("gjltest")){
					    			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					    			Date rdate =null;
					    			for(int i=0;i<100;i++){
					    				  rdate = new Date(System.currentTimeMillis()-(long)(0.3*Tools.MONTH_MILLIS*Math.random())); 
					    				if(rdate.getHours()>8)break;
					    			}
					    		%>
					    			评价日期：<input type=text name="commdate" id="commdate" value="<%=sdf.format(rdate)%>"/>(保持这个格式)
					    			评价内容：<input type=text name="commcontent" id="commcontent" style="width:320px;" />&nbsp;<a href="javascript:void(0)" onclick="AddCom()">添加</a>
					    		<%}%>
					    	</div>
					    	<%
					    	int commentLength = contentcount;
					    	int PAGE_SIZE = 10 ;
					    	PageBean pBean =null; 
					    	String strs="";
					    	List<Comment> commentlist = new ArrayList<Comment>();
					    	pBean=new PageBean(contentcount,PAGE_SIZE,1);
					    	strs=id;
					    	commentlist=getCommentListPage(commentlists,pBean.getStart(),PAGE_SIZE);							    
					    	
					    	if(commentlist != null && !commentlist.isEmpty()){
					    		//int size = commentlist.size();
					    		int avgscore=CommentHelper.getLevelView(id);
					    	%>
					    	<div style="background-color:#F4F4F4;">
								<table cellpadding="0" cellspacing="0" style="margin-left:10px; margin-right:20px; margin-top:10px; margin-bottom:10px; width:95%; line-height:28px;">
									<tr>
					                  <td><div style="float:left">
					                        <div style="float:left;font-size:12px">购买过的顾客评分 |</div>
					                         <div class="sa<%=score %>" style="float:left;" ></div>
					                       </div></td>
					                     <td  align="right"></td>
					                 </tr>
								</table>
							</div>
							<div style="padding-top:10px" id="commentContent">
								<table cellpadding="0" cellspacing="0" style="font-size:12px; width:100%">
										    	
						 <%SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						 for(Comment comment:commentlist){
							 User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
								//if(user == null) continue;
								String hfusername = getUid(comment.getGdscom_uid());
								String level = UserHelper.getLevelText(user);
								if(comment.getGdscom_mbrid().intValue()==-1){
									level="普通会员";
								}
								else if(comment.getGdscom_mbrid().intValue()==-2){
									level="VIP会员";
								}
								else if(comment.getGdscom_mbrid().intValue()==-3){
									level="白金会员";
								}
							 %>
							 <tr>
								<td>
								<div id="comment" class="m">
					                <div class="mc" >
					                    <div id="divitem" class="item">
					                        <div class="user">
					                            <div class="u-icon">
					                               <img src="<%=UserHelper.getLevelImage(level) %>" width="70" height="70" />                      
					                            </div>
					                            <div class="u-name">
					                             <span><%=hfusername %></span><br>
					                             <span><%=level %></span>
					                            </div>
					                       
					                        </div>
					                        <div class="i-item">
					                        <div class="o-topic">
					                          <div style="float:left"><strong class="topic">
					                            <label style="font-weight:bold">评分：</label>
					                            </strong>
					                            <img src="http://images.d1.com.cn/images2012/New/gds_star<%=comment.getGdscom_level() %>.gif" />
					                            <%if(lUser!=null&&lUser.getMbrmst_uid().trim().equals("gjltest")){ %>
					                           <a href="javascript:void(0)" attr="<%=comment.getId()%>" onclick="comsup(this)">隐藏</a>
					                            <%} %>
					                            </div>
					                            
					                            <div style="float:right"><span class="date-comment">
					                           <%=df.format(comment.getGdscom_createdate()) %>
					                            </span></div>
					                            
					                        </div>
					                        <div class="o-topic" style="border:none;" >
					                             <div style="line-height:26px;" class="comment-content">
					                                 <dl>
					                                    <dd><%=comment.getGdscom_content() %></dd>
					                                  </dl>
					                             </div>
					                             <%/*
					                        if((product.getGdsmst_rackcode().startsWith("020")|| product.getGdsmst_rackcode().startsWith("030")) && !Tools.isNull(product.getGdsmst_skuname1()) && !Tools.isNull(comment.getGdscom_sku1())){
					                        	String h="";
					                        	String w="";
					                        	String c="";
					                        	if(!Tools.isNull(comment.getGdscom_height())){
					                        		h=comment.getGdscom_height()+"cm";
					                        	}
					                        	if(!Tools.isNull(comment.getGdscom_weight())){
					                        		w=comment.getGdscom_weight()+"kg";
					                        	}
					                        	//System.out.println(comment.getGdscom_comp()+"zzzzzzzzzzzzzzzz");
					                        	if("1".equals(comment.getGdscom_comp().trim())){
					                        		c="合适";
					                        	}
					                        	else if("2".equals(comment.getGdscom_comp().trim())){
					                        		c="偏大";
					                        	}
					                        	else if("3".equals(comment.getGdscom_comp().trim())){
					                        		c="偏小";
					                        	}*/
					                        	%>	
					                        	 <!-- <p style="color:black;padding-top:5px;">尺码：<%//=comment.getGdscom_sku1() %>&nbsp;&nbsp;&nbsp;&nbsp;身高：<%//=h %>&nbsp;&nbsp;&nbsp;&nbsp;体重：<%//=w %>&nbsp;&nbsp;&nbsp;&nbsp;顾客认为：<%//=c %></p>-->
					                       <% //}
					                        %>
					                              
					                        </div>
					                       
					                        <div class="comment-content">
					                           <dl>
					                           <dd>
					                           <%
					                            if(!Tools.isNull(comment.getGdscom_replyContent())){
					                            	 %>	
					                            	 <p style="color:#892D3D;line-height:26px;" >D1优尚回复：<%=comment.getGdscom_replyContent() %></p>
					                          <%  }
					                           %>
					                            
					                           </dd>
					                           </dl>    
					                        </div>
					                        </div>
					                        <div class="corner tl"></div>
					                     
					                    </div>
					                </div>
					
					        </div>
								</td>
							</tr><%
						}
						 if(pBean.getTotalPages()>1){ %>
							<tr>
								<td><div class="GPager">
						           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
						           	<%if(pBean.getCurrentPage()>1){ %><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
						           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
						           		if(i==1){
						           		%><span class="curr"><%=i %></span><%
						           		}else{
						           		%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=i %>);"><%=i %></a><%
						           		}
						           	}%>
						           	<%if(pBean.hasNextPage()){%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
						           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
						           </div></td>
							</tr><%
							} %>
							</table> </div>
						<%
					}else{
					%><div class="commentmore" id="commentmore" > 还没有会员进行评论。</div><%
				} %>
				   </span> 
				    <!-- 商品评论结束 -->
					</div>
				
					 <%
            
              Directory dir= DirectoryHelper.getById(product.getGdsmst_rackcode().toString());
              if(dir!=null)
              {
            	  String str=dir.getRakmst_rackname();
            	  if(str.length()>0)
                  {%>
                 	
                 	
     		        <%  //String newtag=getXGSS(id).replace('，', ',');
                 	     ArrayList<Tag> elist=new ArrayList<Tag>();
                 	     ArrayList<Tag> alist=new ArrayList<Tag>();
                 	     ArrayList<Tag> listsss=TagHelper.getTags();
                 	     if(listsss!=null&&listsss.size()>0)
                 	     {
                 	    	 for(Tag t:listsss)
                 	    	 {
                 	    		 if(t!=null&&t.getTag_key()!=null&&t.getTag_key().length()>0&&t.getTag_key().indexOf(str)>=0)
                 	    		 {
                 	    			 alist.add(t);
                 	    		 }
                 	    	 }
                 	     }
                 	     
                 	     if(alist!=null)
                 	     {
                 	    	 for(int i=0;i<alist.size();i++)
                 	    	 {
                 	    		
                 	    		 for(int j=i;j<alist.size()-1;j++)
                 	    		 {
                 	    			 Tag ti=alist.get(i);
                 	    			 Tag tj=alist.get(j+1);
                 	    			 if(ti.getTag_key().equals(tj.getTag_key()))
                 	    			 {
                 	    				 ti=null;
                 	    			 }
                 	    			 elist.add(tj);
                 	    		 }
                 	    	 }
                 	     }
     					
                 	     if(elist!=null&&elist.size()>0)
                 	     {
                 	        
                 	     %>
                 	    	   <div class="xgss" id="xgss">
                 	               <em style="border:none;">相关搜索：  </em>
                 	    	<%  
                 	    	    if(elist.size()<=15)
                 	    	    {
                 	    	    	for(int i=0;i<elist.size();i++)
    		     					{
    		     						Tag cc=elist.get(i);
    		     						if(cc!=null)
    		     						{
    		     						
    		     					%>
    		     		            	<em><a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
    		     		            <%
    		     						}
    		     					}
                 	    	    }
                 	    	    else
                 	    	    {
                 	    	    	
                 	   			    int num = new Random().nextInt(elist.size()-15);
	                 	   			for(int i=num;i<num+15;i++)
			     					{
			     						Tag cc=elist.get(i);
			     						if(cc!=null)
			     						{
			     						
			     					%>
			     		            	<em><a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
			     		            <%
			     						}
			     					}
                 	    	    }
                 	    	   %>
                 	             </div>
                 	    <%}
     		            
                 }
                 
                 
                 }%>
                  <div class="clear"></div>
				</div>
				 
				 <!--商品信息描述结束-->
				 <div class="clear"></div>
				
			</div>
		     <!--商品展示右侧结束-->
		     
		     <!--商品展示左侧-->
			  <div class="gs_left">
			  
			  	  <%
			       //获取该商品的前十个商品
			       ArrayList<Product> rlist=new ArrayList<Product>();
			       rlist=getTenProduct(id);
			       if(rlist!=null&&rlist.size()>0)
			       {%>
			    	   <div class="gs_left_por" style="display:none;">
			    	   <div class="gs_left_content">
					   <%  for(Product p:rlist)
						   {
						       if(p!=null)
						       {
						           String title=Tools.clearHTML(p.getGdsmst_gdsname());
						       %>
						    	 <div class="gs_left_content_sub">
							  
							 <div class="gs_left_content_r">
							 	<a href="<%=ProductHelper.getProductUrl(p) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
							 	<span class="span1">￥<%=p.getGdsmst_memberprice() %></span><span class="span2">￥<s><%=p.getGdsmst_saleprice() %></s></span>
							 </div>
				         </div>
						 <hr/>  
						       <%}
						   }
					   %>
					   	 </div>
					   </div>
			       <%}
			   
			  %>
			  
			
			 <!--购买过本商品的用户还购买过-->
			 <% productList = GetAboutProduct(product.getId());
		     //System.out.print(product.getId());
			 if(productList != null && !productList.isEmpty()){					
				 int size = productList.size();				 
				 %>
			 
				 <div class="gs_left_por">

				     <div class="gs_left_ltitle" style=" text-align:center; margin-top:10px;" >-------&nbsp;&nbsp;看了又看&nbsp;&nbsp;-------</div><%
				
					 %>
					 <div class="gs_left_content"><%
					 for(Product goods : productList){
						 if(!ProductHelper.isNormal(goods)) continue;
						 if(goods.getGdsmst_validflag().longValue()!=1)continue;
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
						 float g_l_mprice= goods.getGdsmst_memberprice().floatValue();
						 if(CartHelper.getmsflag(goods)){
							 g_l_mprice= goods.getGdsmst_msprice().floatValue();
						 }
						 if(title!=null&&title.trim().length()>28){
							title=title.trim().substring(0,28);
						 }
					 %>
					 <div class="p_l_gds">
 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo160(goods) %>" alt="<%=title %>" align="middle" width="160" height="160" /></a>
<br /><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a>
<br /><span  class="lmprice">￥<%=df2.format(g_l_mprice) %></span>&nbsp;&nbsp;&nbsp;<span class="lsprice">￥<s><%=goods.getGdsmst_saleprice() %></s></span>
</div><%
						} %>
						 <div style=" height:25px;"></div>
					 </div><%
				 	 %>
				 </div>
				 <!-- 浏览过该商品的用户还浏览过商品-->
				 <%}
			      else{
			    	  String linked=product.getGdsmst_linkgds();
					     //List<RackcodeTop> hotList = RcktopHelper.getHotMale(rackCode,5);
						 if(!Tools.isNull(linked)){
							 linked=linked.replace(",", ";").replace("；", ";");
							if(linked.startsWith(";")){
								 linked=linked.substring(1, linked.length()-1);
							 }
							 String[] linklist=null;
							 if(linked.contains(";")){
								 linklist= linked.split(";");
							 }
							// if(linked.contains(",")){
							//	 linklist=linked.split(",");
							// }
							if(linklist!=null){
						 int size = linklist.length;
						 %>
						 <!--相关商品-->
						 <div class="gs_left_por">
						     <div class="gs_left_ltitle" style="  text-align:center;">-购买过本商品的用户还购买过-</div>
							 <div class="gs_left_content"><%
							 for(int i=0;i<size;i++){
								 Product goods = ProductHelper.getById(linklist[i]);
								 if(goods==null)continue;
								 if(goods.getGdsmst_validflag().longValue()!=1)continue;
								 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
								 float g_l_mprice= goods.getGdsmst_memberprice().floatValue();
								 if(CartHelper.getmsflag(goods)){
									 g_l_mprice= goods.getGdsmst_msprice().floatValue();
								 }
								 if(title!=null&&title.trim().length()>28){
									title=title.trim().substring(0,28);
								 }
							 %>
							 	 <div class="p_l_gds">
 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo160(goods) %>" alt="<%=title %>" align="middle" width="160" height="160" /></a>
<br /><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a>
<br /><span  class="lmprice">￥<%=df2.format(g_l_mprice) %></span>&nbsp;&nbsp;&nbsp;<span class="lsprice">￥<s><%=goods.getGdsmst_saleprice() %></s></span>
</div><%
								} %>
							 </div>
						 </div>
				 <!--相关商品--><%}
				 } else{
					 List<RackcodeTop> hotList = RcktopHelper.getHotMale(rackCode,5);
					 if(hotList!=null && hotList.size()>0){
						 %>
						 <!--本类热卖排行-->
						 <div class="gs_left_por">
				     <div class="gs_left_ltitle" style="  text-align:center;">-购买过本商品的用户还购买过-</div>
					 <div class="gs_left_content"><%
					 for(RackcodeTop codeTop : hotList){
						 Product goods = ProductHelper.getById(codeTop.getRcktop_gdsid());
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
                         if(goods==null||goods.getGdsmst_validflag().longValue()!=1)continue;
					  float g_l_mprice= goods.getGdsmst_memberprice().floatValue();
								 if(CartHelper.getmsflag(goods)){
									 g_l_mprice= goods.getGdsmst_msprice().floatValue();
								 }
								 if(title!=null&&title.trim().length()>28){
									title=title.trim().substring(0,28);
								 }
							 %>
							 	 <div class="p_l_gds">
 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo160(goods) %>" alt="<%=title %>" align="middle" width="160" height="160" /></a>
<br /><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a>
<br /><span  class="lmprice">￥<%=df2.format(g_l_mprice) %></span>&nbsp;&nbsp;&nbsp;<span class="lsprice">￥<s><%=goods.getGdsmst_saleprice() %></s></span>
</div><%
						} %>
					 </div>
				 </div>
					<% }
				 }
				 }%>
				 
				 
				  <!--最近浏览的商品-->
				 <div class="gs_left_por">
				     <div class="gs_left_ltitle" style=" text-align:center;">-----最近浏览的商品-----</div><%
					 productList = ProductHelper.getHistoryList(request);
					 if(productList != null && !productList.isEmpty()){
						 int size = productList.size();
					 %>
					 <div class="gs_left_content"><%
					 for(Product goods : productList){
						 if(!ProductHelper.isNormal(goods)) continue;
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
					  float g_l_mprice= goods.getGdsmst_memberprice().floatValue();
								 if(CartHelper.getmsflag(goods)){
									 g_l_mprice= goods.getGdsmst_msprice().floatValue();
								 }
								 if(title!=null&&title.trim().length()>28){
									title=title.trim().substring(0,28);
								 }
							 %>
							 	 <div class="p_l_gds">
 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo160(goods) %>" alt="<%=title %>" align="middle" width="160" height="160" /></a>
<br /><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a>
<br /><span  class="lmprice">￥<%=df2.format(g_l_mprice) %></span>&nbsp;&nbsp;&nbsp;<span class="lsprice">￥<s><%=goods.getGdsmst_saleprice() %></s></span>
</div><%
						} %>
						 <div style=" height:25px;"></div>
					 </div><%
				 	} %>
				 </div>
				 <!-- 最近浏览的商品结束-->
			</div>
		     <!--商品展示左侧结束-->
		     
		</div>
	 <!-- 商品展示结束-->
	 
</div>
<div class="clear"></div>
<div class="productadright">
<!--  <img src="http://images.d1.com.cn/images2014/product/wixinp.jpg" width="100" height="150" />-->
<img src="http://images.d1.com.cn/images2012/New/p_015.jpg" width="74" height="125" border="0" usemap="#productadrightMap" />
<map name="productadrightMap" id="productadrightMap">
  <area shape="rect" coords="4,2,72,61" href="#" style="CURSOR: pointer" onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&amp;sid=4006808666&amp;eid=218808P8z8p8y8y8q8x8z&amp;o=www.d1.com.cn&amp;q=7&amp;ref='+document.location, '_blank', 'height=544, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');" />
  <area shape="rect" coords="5,62,71,117" href="#top1120" />
</map>
</div>


<!--中间内容结束-->
<%@include file="inc/foot.jsp" %>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<%
if(zhsp != null){
%>
<script type="text/javascript">
var t1 = $("#zhtab > a");
var c1 = $("#content_list > div");
new switch_tags(t1, c1, "newa", 0, "click");
</script><%
}%>
<script type="text/javascript">
	var t2 = $("#goodsinfotab > a");
	var c2 = $("#content_list_info > span");
	var flag=0;		
	var show='<%=show%>';
	t2.each(function(i){
	    if($(this).attr('attr')==show){
	    	flag=i;
	    }
	});
	if(flag!=0){ t2.eq(0).attr('className','');
	c2.eq(0).css('display','none');
	}
	 var obj = t2.eq(flag);
     if(obj.attr('attr')=='com'){
     	$('#sdLink').hide();
 		$('#commLink').hide();
 		$('#ssd').hide();
 		$('#scomment').show();
 		
     }
     else if(obj.attr('attr')=='sd'){
     	$('#sdLink').hide();
 		$('#ssd').show();
 		$('#commLink').hide();
 		$('#scomment').hide();
     }
     else{
     	$('#sdLink').show();
 		$('#commLink').show();
 		$('#ssd').show();
 		$('#scomment').show();
     }
	
	new switch_tags(t2, c2, "newa", flag, "click",2);

</script>
<script type="text/javascript">
$(document).ready(function(){
	var objxg=$("#xgss");
	if(objxg!=null)
		{
		  objxg.css("display","none");
		}
    $('#settings').mouseover(function(){
		$('#opciones').slideToggle();
		$('#settings').hide();
		$(this).toggleClass("cerrar");
    });
	$('#opciones').mouseover(function(){
		$('#opciones').show();
		$('#settings').hide();
	}).mouseout(function(){
		$('#opciones').hide();
		$('#settings').show();
	});
	//$(".goods_info_con").find("img").lazyload({effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
	$('#hyyhsmLink').hover(function(){
		var o = $(this).offset();
		$('#hyyhsm').show().css("left",($(this).offset().left-100)+"px");
	},function(){
		$('#hyyhsm').toggle();
	});
	$('#hyyhsm').hover(function(){
		var o = $(this).offset();
		$('#hyyhsm').show().css("left",($(this).offset().left)+"px");
	},function(){
		$('#hyyhsm').toggle();
	});
	var gdscolldiv=$('#2012test');
	if(gdscolldiv.length<=0){
	   ggdscoll1('','','','<%= id %>');
	}	
	
	
	//导航栏浮动
	var m=$("#goodsinfotab").offset().top;  
	$(window).bind("scroll",function(){
    var i=$(document).scrollTop(),
    g=$("#goodsinfotab");
	if(i>=m)
	
		 g.addClass('newbanner1120');
	}
    else{g.removeClass('newbanner1120');}
    
   
	});

function AddAsk(){
    var asktypevalue = $("input[name='asktype']:checked").val(); //咨询类型
    if(asktypevalue == null || asktypevalue == ""){
    	$.alert("请选择咨询类型！");
    	return;
    }
    var content = $("#txtcontent").val(); //咨询内容
    if(content == null || content == ""){
    	$.alert("请填写咨询内容！");
    	return;
    }
    $.post("/ajax/product/addAsk.jsp",{"gdsask_gdsid":"<%=id %>","gdsask_type":asktypevalue,"gdsask_content":content,"m":new Date().getTime()},function(json){
    	if(json.success){
    		$.alert(json.message);
    		$("#txtcontent").val("");
    	}else{
    		$.alert(json.message);
    	}
    },"json");
}

<%
if(ismiaosha){
%>xsms_gdsmst('mscontent');<%
}
%>

function ccdzb()
{
  var top=$('#skuname').offset().top+$('#skuname p').height()-5;
  var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
  $("#ccdzb_img").css("top",top);
  $("#ccdzb_img").css("right",right);
  $("#ccdzb_img").css("display","block");

}
function ccdzb1()
{
	$("#ccdzb_img").css("display","none");
}
</script>

 <%

 if((!Tools.isNull(Dspeqifa)||(DspSubad!=null&&DspSubad.startsWith("mqyqfdsp")))){


	String userid="";
	if(lUser!=null)userid=lUser.getId();
	Directory dirdsp = DirectoryHelper.getById(rackCode);
%>
<!--亿玛DSP部署  -->
<script type="text/javascript"> 
    _adwq.push([ '_setDataType','view']); 
     _adwq.push(['_setCustomer','<%=userid%>']);  
    _adwq.push(['_setItem',
        '<%=id%>', 
       '<%=gdsname%>',     
        '<%=df2.format(Tools.parseFloat(endprice))%>',   
       '1', 
       '<%=rackCode%>',   
        '<%=dirdsp.getRakmst_rackname()%>'
    ]); 

    _adwq.push([ '_trackTrans' ]); 
</script> 
<!--亿玛DSP部署  -->
<%} %>



</body>
</html>