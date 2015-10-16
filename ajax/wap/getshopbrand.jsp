<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %>
<%!
private ArrayList<Product> GetGoods(String shopcode,String brand)
{
	ArrayList<Product> result=new ArrayList<Product>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();	
	if(!Tools.isNull(brand))clist.add(Restrictions.eq("gdsmst_brand", brand));
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
	clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
	List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 6000);	
	if(b_list!=null){
		for(BaseEntity be:b_list){
			result.add((Product)be);
		}
	}	
	return result;
}
%>
<%
JSONObject json = new JSONObject();
String sc=request.getParameter("sc");
if(Tools.isNull(sc)){
	json.put("pstatus", "0");
}
String brand=request.getParameter("brand");

List<Product>  pplist=GetGoods(sc,brand);
if(pplist==null&&pplist.size()<=0){

	json.put("pstatus", "0");
	out.print(json);
	return;
}
json.put("pstatus", "1");
JSONArray jsonarr=new JSONArray();

	String pg=request.getParameter("pg"),psize=request.getParameter("psize");
	int sgcount=pplist.size();
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
    json.put("page_total", sgcount);
    
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
	 for(int t=pbegin; t<sgcount&&t<pend;t++ )
     {
		 
		   
		  Product goods=pplist.get(t);
		  gdsid = goods.getId();
		  JSONObject jsonitem = new JSONObject();
			 count++;
		        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		        	   String id = goods.getId();
		        	   String shopcode=goods.getGdsmst_shopcode();
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
		        		jsonitem.put("p_gdsid",id);
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
	 json.put("products", jsonarr);

out.print(json);
%>
