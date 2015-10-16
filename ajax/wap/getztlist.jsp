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
		if(sm_list.indexOf("all")>=0){
			 plist=getProductList(sm_list.substring(0,8),50);
			 pcount=plist.size();
			 ptype=1;
		}else if(ppstrlist[0].length()==4){
			 pplist=PromotionProductHelper.getPProductByCode(ppstrlist[0],50);
			 pcount=pplist.size();
			 ptype=2;
		}
	}
if(pstatus.equals("0")&&pcount>0){
	pstatus="1";
}

JSONArray jsonarr=new JSONArray();

	
    
    DecimalFormat df = new DecimalFormat("0.00");
    int shipstatus=0;
    long orderstatus=0;
    String statustxt="";
    
    int count=0;
	   
	   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    String	nowtime2= DateFormat.format( new Date());
	    DecimalFormat df2 = new DecimalFormat("0.00");
	    String gdsid="";
	    boolean	clsflag=false;

		long gdsnum=0;
		long buynum=0;
		long gdsnum2=0;
		   boolean issgflag=false;
		   boolean ismiaoshao=false; 
		   Product goods=null;
	 for(int t=0; t<pcount;t++ )
     {
		 String pptitle="";
		 if(ptype==0){
			 gdsid=ppstrlist[t];
			 goods=ProductHelper.getById(gdsid);
		   }else if(ptype==1){
			 goods=plist.get(t);
		   }else{
			   PromotionProduct pp = pplist.get(t);
			   gdsid = pp.getSpgdsrcm_gdsid();
			   goods=ProductHelper.getById(gdsid);
			   pptitle=pp.getSpgdsrcm_gdsname();
		   }
		 if(goods==null)break;
		  JSONObject jsonitem = new JSONObject();
			 count++;
		        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
		        	   long currentTime = System.currentTimeMillis();
		        	    ismiaoshao=false; 
		        	    issgflag=false; 
		        	   String brandname=goods.getGdsmst_brandname();
		        	   if(!Tools.isNull(pptitle))title=pptitle;
		        	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
		        	String gtitle="";
		        	if(gname.length()<32){
		        	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
		        	}

		        			ismiaoshao=CartHelper.getmsflag(goods);
		        			clsflag=false;
		        		//D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id);
		        		 gdsnum=0;
		        		 buynum=0;
		        		 gdsnum2=0;
		        		if(ismiaoshao){
		        		SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
		        		  if(sg!=null&&sg.getSggdsdtl_status().longValue()==1){
		        			   gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
		        	             gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
		        	        	
		        	         	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

		        	             if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
		        	             	  gdsnum=0;
		  
		        	             }
		        			  
		    			     if(sg.getSggdsdtl_maxnum().longValue()>sg.getSggdsdtl_realbuynum().longValue()
		    					&&sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()>0){
		    			    	 issgflag=true ;
		    			     }
		        		  }
		        		}
		        		float msprice=0f;
		        		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
		        		//int comnum= CommentHelper.getCommentLength(id);
		        		jsonitem.put("p_gdsid",gdsid);
		        		jsonitem.put("p_gdsname",title);
		        		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
		        		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
		        		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
		        		jsonitem.put("p_msprice",df2.format(msprice));
		        		jsonitem.put("p_ismiaoshao",ismiaoshao);
		        		jsonitem.put("p_issgflag",issgflag);
		        		//jsonitem.put("p_comnum",comnum);
		        		jsonarr.add(jsonitem);
     }
	 jsonlitem.put("products", jsonarr);
	 jsonlitem.put("ptitle", sm.getShopmodel_txt()!=null?sm.getShopmodel_txt():"");
	 jsonlitem.put("ptitlecolor", sm.getShopmodel_txtcolor()!=null?sm.getShopmodel_txtcolor():"");
	 jsonlitem.put("ptitlebg", sm.getShopmodel_title()!=null?sm.getShopmodel_title():"");
	 jsonlarr.add(jsonlitem);
 }
 json.put("pstatus", pstatus);
 json.put("pbanner", shopinfo.getShopinfo_wapbanner()!=null?shopinfo.getShopinfo_wapbanner():"");
 json.put("pbgcolor", shopinfo.getShopinfo_bgcolor()!=null?shopinfo.getShopinfo_bgcolor():"");
 json.put("plist", jsonlarr);
}
out.print(json);
%>
