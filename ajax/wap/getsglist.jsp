<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %>
<%!

public static ArrayList<SgGdsDtl> getsghot(String gdsid){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));//1上架
	clist.add(Restrictions.le("sggdsdtl_cls", new Long(5)));
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("sggdsdtl_gdsid", gdsid));
	}
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 200);
	//System.out.println("=b_list.size()==33===="+b_list.size());
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}
%>
<%
JSONObject json = new JSONObject();
JSONArray jsonarr=new JSONArray();
List<SgGdsDtl> sglist1=getsghot(""); 
if(sglist1!=null&&sglist1.size()>0){
	json.put("pstatus", "1");
	 int count=0;
	   
	   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    String	nowtime2= DateFormat.format( new Date());
	    DecimalFormat df2 = new DecimalFormat("0.00");
	    String gdsid="";
	    boolean	clsflag=false;

		long gdsnum=0;
		long buynum=0;
		long gdsnum2=0;
		   boolean issgflag=true; 
	    for(SgGdsDtl sg:sglist1){
 			gdsid = sg.getSggdsdtl_gdsid();
 		  Product goods=ProductHelper.getById(gdsid);
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
	        		jsonitem.put("p_gdsid",id);
	        		jsonitem.put("p_gdsname",title);
	        		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
	        		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
	        		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
	        		jsonitem.put("p_msprice",df2.format(msprice));
	        		jsonitem.put("p_issgflag",issgflag);
	        		jsonitem.put("p_buynum",buynum);
	        		jsonarr.add(jsonitem);
	        		
	 }
	 json.put("products", jsonarr);
	
}else{
	json.put("pstatus", "0");
}
out.print(json);
%>