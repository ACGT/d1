<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %>
<%!

%>
<%/*分类文字链：
女装：3755
男装：3765
化妆：3773
箱包皮具：3781
配饰名品：3787
居家生活：3794
 

分类图片：
女装：3816
男装：3817
化妆品：3818
箱包：3819
配饰名品：3820
居家：3821
 

商品推荐：
女装：9439
男装：9461
化妆品：9452
居家：9467
箱包：9473
配饰名品：9478

2015
面部护肤：大图广告位 3886   3845分类       9605推荐商品 
彩妆香水：大图广告位3887   3849分类      9611 推荐商品 
个人护理：大图广告位3888   3853分类       9618推荐商品 
男士护理：大图广告位3889   3857分类       9624推荐商品 
男人馆：大图广告位3890    3863分类       9673推荐商品 
女人街：大图广告位3891    3872分类      9674 推荐商品 


*/

String rckcodes="3886,3845,9605$3887,3849,9611$3888,3853,9618$3889,3857,9624$3890,3863,9673$3891,3872,9674";
//$3820,3787,9478$3821,3794,9467";
JSONObject json = new JSONObject();
String[] rckcodearr= rckcodes.split("\\$");
int rcklen=rckcodearr.length;
if(rcklen>0){
	JSONArray jsonlarr=new JSONArray();
	JSONObject jsonlitem = new JSONObject();
for(int l=0;l<rcklen;l++){
	JSONArray jsonarrrack=new JSONArray();
	JSONArray jsonarr=new JSONArray();
	String rckitem=rckcodearr[l];
	String[] codearr= rckitem.split(",");
	List<Promotion> adpic = PromotionHelper.getBrandListByCode(codearr[0] , 1);
	List<Promotion> rakpp = PromotionHelper.getBrandListByCode(codearr[1] , -1);
	List<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode(codearr[2],6);
      String rckad="";
      String rckadurl="";
    if(adpic!=null&&adpic.size()>0){
    	Promotion pt=adpic.get(0);
    	if(pt!=null){
    		 rckad=pt.getSplmst_picstr();
    	       rckadurl=pt.getSplmst_url();
    	}
    	
    }/*
    女装
    http://m.d1.cn/wap/result.html?rackcode=020
    男装
    http://m.d1.cn/wap/result.html?rackcode=030
    化妆品
    http://m.d1.cn/wap/result.html?rackcode=014
    箱包
    http://m.d1.cn/wap/result.html?rackcode=050
    居家
    http://m.d1.cn/wap/result.html?rackcode=012
    配饰
    http://m.d1.cn/wap/result.html?rackcode=015
    */
   String rcktitle="";
    String rckcode="";
    if(l==0){
    	rcktitle="面部护肤";
		rckcode="014001";
		
    }else if(l==1){
    	rcktitle="彩妆香水";
		rckcode="014003,014002";
		
    }else if(l==2){
    	rcktitle="个人护理";
		rckcode="014005";
    }else if(l==3){
		rcktitle="男士护理";
		rckcode="014010";
    }else if(l==4){
		rcktitle="男人馆";
		rckcode="030";
    }else if(l==5){
		rcktitle="女人街";
		rckcode="020";
    }
    jsonlitem.put("rcktitle", rcktitle);
    jsonlitem.put("rckcode", rckcode);
    jsonlitem.put("rckad", rckad);
  	jsonlitem.put("rckadurl", rckadurl);

    if(rakpp!=null&&rakpp.size()>0){
    	for(Promotion p:rakpp)
		{
  	      JSONObject jsonitem = new JSONObject();
  	      jsonitem.put("rckname", Tools.clearHTML(p.getSplmst_name()));
  	      jsonitem.put("rckurl", p.getSplmst_picstr2());
  	      jsonarrrack.add(jsonitem);
		}
    }
  	jsonlitem.put("rcks", jsonarrrack);
  	
    
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
	    if (pplist==null)continue;
	   int pcount=pplist.size();
		long gdsnum=0;
		long buynum=0;
		long gdsnum2=0;
		   boolean issgflag=false;
		   boolean ismiaoshao=false; 
	 for(int t=0; t<pcount;t++ )
     {
		
			   PromotionProduct pp = pplist.get(t);
			   gdsid = pp.getSpgdsrcm_gdsid();
			   Product goods=ProductHelper.getById(gdsid);
		 if(goods==null)break;
		  JSONObject jsonitem = new JSONObject();
			 count++;
		        	 
		        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
		        	   long currentTime = System.currentTimeMillis();
		        	    ismiaoshao=false; 
		        	    issgflag=false; 
		        	   String brandname=goods.getGdsmst_brandname();
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
		        		SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);
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
		        		String title=goods.getGdsmst_gdsename();
		 if(Tools.isNull(title)) title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
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
	 jsonlarr.add(jsonlitem);
 }
json.put("pstatus", "1");
 json.put("plist", jsonlarr);
}
out.print(json);
%>
