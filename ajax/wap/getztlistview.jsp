<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %>
<%!

//获取该商户的所有模块
private ArrayList<ShopModel> getShopModelList(String shopinfo_id)
{
	ArrayList<ShopModel> rlist = new ArrayList<ShopModel>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("shopmodel_infoid", new Long(shopinfo_id)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("shopmodel_sort"));
	List<BaseEntity> list = Tools.getManager(ShopModel.class).getList(clist, olist, 0, 22);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((ShopModel)be);
	}
	
	return rlist ;
	
}
	//根据传过来的商户缩写名查询出shopcode
	private ArrayList<ShpMst> getShopSM(String shopsname){
		ArrayList<ShpMst> rlist = new ArrayList<ShpMst>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("shpmst_shopsname", shopsname));
		List<BaseEntity> list = Tools.getManager(ShpMst.class).getList(clist, null, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShpMst)be);
		}
		return rlist ;
	}
	//获取首页商户的信息
		private ArrayList<ShopInfo> getShopInfoList(String shopcode)
	{
		ArrayList<ShopInfo> rlist = new ArrayList<ShopInfo>();
		List<Criterion> clist = new ArrayList<Criterion>();
		//List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.eq("shopinfo_indexflag", new Long(0)));//0为首页  3在专题页被设置的首页
		clist.add(Restrictions.sqlRestriction(" (shopinfo_indexflag = 3 or shopinfo_indexflag = 0)"));
		clist.add(Restrictions.eq("shopinfo_shopcode", shopcode));
		clist.add(Restrictions.eq("shopinfo_del", new Long(0)));//未被删除
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("shopinfo_createdate"));
		//List<BaseEntity> list = Tools.getManager(ShopInfo.class).getList(clist, null, 0, 1);
		List<BaseEntity> list = Tools.getManager(ShopInfo.class).getListCriterion(clist, olist, 0, 5);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShopInfo)be);
		}
		return rlist ;
		
	}
		//获取专题页商户的信息 
		private ShopInfo getShopInfoById(String zt_id)
		{ 
			ShopInfo shop_info = (ShopInfo)Tools.getManager(ShopInfo.class).get(zt_id);
			if(shop_info==null)return null;
			return shop_info ;
		}
		//获取新品
		public static ArrayList<Product> getProductList(String shopcode,int num){
			ArrayList<Product> list=new ArrayList<Product>();
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("gdsmst_createdate"));
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}	
			else
			{
				return null;
			}
		     return list;
		}
%>
<%
String id= request.getParameter("id");
String sc= request.getParameter("sc");
String mid= request.getParameter("mid");
if(!Tools.isNull(mid)){
	session.setAttribute("Wxhbfx201506", mid);
}

JSONObject json = new JSONObject();
if(Tools.isNull(sc)&&Tools.isNull(id)){
	json.put("pstatus", "0");
	out.print(json);
	return;
}
String shopcode="";
ShopInfo shopinfo=null;
if(!Tools.isNull(sc)){
List<ShpMst> shpmstl=	getShopSM(sc);
if(shpmstl.get(0)!=null){
	shopcode=shpmstl.get(0).getId();
	List<ShopInfo> shopinfolist= getShopInfoList(shopcode);
	if(shopinfolist!=null&&shopinfolist.size()>0){
		int sicount=shopinfolist.size();
	for(int i = 0 ;i<sicount;i++){
		if(shopinfolist.get(i).getShopinfo_indexflag() == 3){
			shopinfo=shopinfolist.get(i);
			break;
		}
	}
	if(shopinfo==null){
		shopinfo=shopinfolist.get(0);
	}
	}
}

}
if(!Tools.isNull(id)){
	 shopinfo= getShopInfoById(id);
}
if(shopinfo==null){
	json.put("pstatus", "0");
	out.print(json);
	return;
}
String siid=shopinfo.getId();
json.put("zttitle",shopinfo.getShopinfo_title());
List<ShopModel> smlist= getShopModelList(siid);

String pstatus="0";
if(smlist!=null&&smlist.size()>0){
	JSONArray jsonlarr=new JSONArray();
	JSONObject jsonlitem = new JSONObject();
	int smcount=smlist.size();
for(int l=0;l<smcount;l++){
	ShopModel sm=smlist.get(l);
	String sm_list=sm.getShopmodel_list();
	List<Product> plist=null;
	List<PromotionProduct> pplist=null;
	String[] ppstrlist=null;
	int pcount=0;
	int ptype=0;
	if(!Tools.isNull(sm_list)){
		ppstrlist=sm_list.split(",");
		pcount=ppstrlist.length;
		int gdsnum=sm.getShopmodel_gdsnum().longValue()==0?100:sm.getShopmodel_gdsnum().intValue();

		if(sm_list.indexOf("all")>=0){
			 plist=getProductList(sm_list.substring(0,8),gdsnum);
			 pcount=plist.size();
			 ptype=1;
		}else if(ppstrlist[0].length()==4){
			 
			pplist=PromotionProductHelper.getPProductByCode(ppstrlist[0],gdsnum);
			if(pplist!=null){
			 	pcount=pplist.size();
			 	ptype=2;
			}
		}
	}
if(pstatus.equals("0")&&(pcount>0||smcount>0)){
	pstatus="1";
}

JSONArray jsonarr=new JSONArray();

	
    
    DecimalFormat df = new DecimalFormat("0.0");
    int shipstatus=0;
    long orderstatus=0;
    String statustxt="";
    
    int count=0;
	   
	   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    String	nowtime2= DateFormat.format( new Date());
	    DecimalFormat df2 = new DecimalFormat("0.0");
	    String gdsid="";
	    boolean	clsflag=false;

		long gdsnum=0;
		long buynum=0;
		long gdsnum2=0;
		String mdname="";
		   boolean issgflag=false;
		   boolean ismiaoshao=false; 
		   Product goods=null;
		   String title ="";
		   SimpleDateFormat msdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	 for(int t=0; t<pcount;t++ )
     {
		 mdname="";
		 title="";
		 if(ptype==0){
			 gdsid=ppstrlist[t];
			 goods=ProductHelper.getById(gdsid);
		   }else if(ptype==1){
			 goods=plist.get(t);
		   }else{
			   PromotionProduct pp = pplist.get(t);
			   gdsid = pp.getSpgdsrcm_gdsid();
			   goods=ProductHelper.getById(gdsid);
			   mdname=pp.getSpgdsrcm_briefintrduce();
			   title=pp.getSpgdsrcm_gdsname();
		   }
		 if(goods==null)break;
		  JSONObject jsonitem = new JSONObject();
			 count++;
			     if(Tools.isNull(title)) title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
		        	   long currentTime = System.currentTimeMillis();
		        	   
		        	   if(Tools.isNull(mdname)&&!Tools.isNull(goods.getGdsmst_title()))mdname=goods.getGdsmst_title();
		        	    ismiaoshao=false; 
		        	    issgflag=false; 
		        	   String brandname=goods.getGdsmst_brandname();
		        	   
		        	   SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		      		 if(goods.getGdsmst_promotionstart()!=null&&goods.getGdsmst_promotionend()!=null
		      				 &&goods.getGdsmst_msprice()!=null){
		      		 	Date sdate=goods.getGdsmst_promotionstart();
		      		 	Date edate=goods.getGdsmst_promotionend();	
		      		 	Date nowday=new Date();
		      		  
		      		 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
		      		 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
		      		 			&&goods.getGdsmst_msprice().floatValue()>=0f){
		      		 		ismiaoshao = true;
		      		 	}

		      		 }
		      		
		        			clsflag=false;
		        		//D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id);
		        		 gdsnum=0;
		        		 buynum=0;
		        		 gdsnum2=0;

		        		float msprice=0f;
		        		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
		        		//int comnum= CommentHelper.getCommentLength(id);
		        		jsonitem.put("p_gdsid",gdsid);
		        		jsonitem.put("p_gdsname",title);
		        		jsonitem.put("p_mdname",mdname);
		        		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
		        		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
		        		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
		        		jsonitem.put("p_msprice",df2.format(msprice));
		        		jsonitem.put("p_ismiaoshao",ismiaoshao);
		        		jsonitem.put("p_issgflag",issgflag);
		        		//jsonitem.put("p_comnum",comnum);
		        		jsonitem.put("p_vstock",goods.getGdsmst_stocklinkty().longValue()==1?goods.getGdsmst_virtualstock().longValue():6);
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
	 //System.out.println("开始图文编辑模块啦##########################");
	 //20160111修改：商家后专题编辑的图文编辑模块的${}功能 :${1234} 1234是广告推荐位的id,查出 1234的所有列表，显示图片和链接begin，看没有注释的代码真的很痛苦
     String realContent="";
     realContent=sm.getShopmodel_content();
	if(sm.getShopmodel_type()==1){
	 String[] splList=sm.getShopmodel_list().split(",");
     for(int i=0;i<splList.length;i++){
     	String[] tmp={splList[i]+""};
     	List<Promotion> splmstList=PromotionHelper.getBrandList(tmp);
    	 	String content_tmp="";
    	 	for(Promotion prmt:splmstList){
	        	
    	 		content_tmp+="<div><a href="+prmt.getSplmst_url()+"><img src="+prmt.getSplmst_picstr()+"></img></a></div>";
	        	
	       	 }
    	 	
    	 realContent= realContent.replace("${"+splList[i]+"}", content_tmp);
    	
     }
	}//图文编辑模块的${}功能 end
	 jsonlitem.put("products", jsonarr);
	 jsonlitem.put("ptitle", sm.getShopmodel_txt()!=null?sm.getShopmodel_txt():"");
	 jsonlitem.put("ptitlecolor", sm.getShopmodel_txtcolor()!=null?sm.getShopmodel_txtcolor():"");
	 jsonlitem.put("ptitlebg", sm.getShopmodel_title()!=null?sm.getShopmodel_title():"");
	 jsonlitem.put("pcontent", realContent);
	 jsonlarr.add(jsonlitem);
 }
 json.put("pstatus", pstatus);
 json.put("pinfotxt", shopinfo.getShopinfo_bgimg()!=null?shopinfo.getShopinfo_bgimg():"");
 json.put("pbanner", shopinfo.getShopinfo_wapbanner()!=null?shopinfo.getShopinfo_wapbanner():"");
 json.put("pbgcolor", shopinfo.getShopinfo_bgcolor()!=null?shopinfo.getShopinfo_bgcolor():"");
 json.put("plist", jsonlarr);
}
out.print(json);
%>
