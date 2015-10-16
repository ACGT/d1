<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %><%!

public static ArrayList<SgGdsDtl> getsghot(String gdsid){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));//1上架
	clist.add(Restrictions.le("sggdsdtl_cls", new Long(5)));
	clist.add(Restrictions.le("sggdsdtl_sdate", new Date()));
	clist.add(Restrictions.ge("sggdsdtl_edate", new Date()));
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


List<SgGdsDtl> sglist1=getsghot(""); 
if(sglist1!=null&&sglist1.size()>0){
	json.put("pstatus", "1");
}else{
	json.put("pstatus", "0");
	out.print(json);
	return;
}
JSONArray jsonarr=new JSONArray();

	String pg=request.getParameter("pg"),psize=request.getParameter("psize");
	int sgcount=sglist1.size();
	if(Tools.isNull(pg))pg="1";
	if(Tools.isNull(psize))psize="15";
	int ipg=Tools.parseInt(pg);
	int ipsize=Tools.parseInt(psize);
	PageBean pBean1 = new PageBean(sgcount,ipsize,ipg);
	if(ipg>pBean1.getCurrentPage()){
		json.put("pstatus", "0");
		out.print(json);
		return;
	}
	
	int pbegin = (pBean1.getCurrentPage()-1)*ipsize;
    int pend = pbegin + ipsize;
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
		   boolean issgflag=true;
	 for(int t=pbegin; t<sgcount&&t<pend;t++ )
     {
		 SgGdsDtl sg = sglist1.get(t);
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
	        		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
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
	 json.put("products", jsonarr);

out.print(json);
%>
