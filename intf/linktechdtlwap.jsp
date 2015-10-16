<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@page import="
com.d1.bean.OrderBase,
com.d1.bean.OrderItemBase,
com.d1.helper.OrderHelper,
com.d1.helper.OrderItemHelper,
com.d1.util.MD5,
com.d1.util.Tools"
%><%!
/**
 * 获取用券比例
 * @param tktvalue
 * @param odrid
 * @return
 */
public  float getTktRa(float tktvalue,String odrid )
{
	//System.out.println("d1gjllkt:"+tktvalue+odrid);
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(odrid);
	float allmoney=0;
	float retra=1;
	for(OrderItemBase odrdtl:list)
	{
		if (!"000".equals(odrdtl.getOdrdtl_rackcode()) && Tools.isNull(odrdtl.getOdrdtl_gifttype()))
		{

			allmoney+=odrdtl.getOdrdtl_finalprice()*odrdtl.getOdrdtl_gdscount();
		}	
	}
	//System.out.println("d1gjllkmm:"+allmoney);
	if (allmoney!=0)
	{
		retra=Tools.getFloat(1-tktvalue/allmoney,3);
	}
	if(retra<0 || retra>1 || Tools.isNull(retra+"")){
		retra=1;
	}
	//System.out.println("d1gjllk22:"+retra);
	return retra;
}
%><%
String datee=request.getParameter("yyyymmdd");
String unionid=request.getParameter("unionid");
if (!"$linktech$".equals(unionid))return;
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
Date dEndDate=null;
Date dStartDate=null;
try {
	dEndDate = fmt2.parse(datee+" 23:59:59");
	dStartDate=fmt.parse(datee);
} catch (ParseException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
ArrayList<OrderBase> listlkt=OrderHelper.getOrderList("waplinktech",dStartDate, dEndDate);

ArrayList<OrderBase> listall=new ArrayList<OrderBase>();
if(listlkt!=null){
	for(OrderBase base1:listlkt){
		listall.add(base1);
	}
}

StringBuilder strbd = new StringBuilder();	
SimpleDateFormat format=new SimpleDateFormat("HHmmss");
String linktech_widarr="";
String mbruid="";
float lmtktra=1;
float tktvalue=0;
String linktech_str="";
String odrtemp="";
if(listall==null)return;
	for(OrderBase base:listall){
		tktvalue=base.getOdrmst_tktvalue().longValue();
		if(tktvalue>0){
			lmtktra=getTktRa(tktvalue,base.getId());
		}
		ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		if (orderitemlist==null)continue; 
		for(OrderItemBase itembase:orderitemlist){
		        linktech_str+="2"+"\t";
				linktech_str+=format.format(base.getOdrmst_orderdate())+"\t";
				odrtemp=base.getOdrmst_temp();
				//System.out.println("d1gjllkt:"+odrtemp);
				if (odrtemp.length()>8){
				linktech_widarr=odrtemp.substring(8,odrtemp.length());
				}
				//User user=(User)UserHelper.getById(base.getOdrmst_mbrid().toString());
				
					if (odrtemp.startsWith("qq_caibei")|| odrtemp.startsWith("caibei_qqlogin")
						|| odrtemp.startsWith("qq_login")){
				
					User user=(User)UserHelper.getById(base.getOdrmst_mbrid().toString());
					mbruid="";
					if(user!=null)mbruid=user.getMbrmst_uid();
					
					mbruid=mbruid.replace("qqlogin", "");
					mbruid=mbruid.replace("caibei", "");
					linktech_widarr="A100136514"+mbruid;
					if(odrtemp.startsWith("qq_caibei"))linktech_widarr=odrtemp.replace("qq_caibei", "");
					
					
					//linktech_widarr=odrtemp;
				}else if(odrtemp.startsWith("dxticket")){
					linktech_widarr="A100126293";
				}else if(odrtemp.startsWith("139ticket")){
					linktech_widarr="A100106638";
				}
				
				linktech_str+=linktech_widarr+"\t";
				linktech_str+=base.getId()+"\t";
				linktech_str+=itembase.getOdrdtl_gdsid() +"\t";
				linktech_str+=base.getOdrmst_mbrid().toString()+"\t";
				linktech_str+=itembase.getOdrdtl_gdscount().toString()+"\t";
	    		if (itembase.getOdrdtl_specialflag()==1 || itembase.getOdrdtl_gdsname().indexOf("优惠特价")>=0
	    			|| itembase.getOdrdtl_gdsname().indexOf("团购商品")>=0) {
				linktech_str+=Tools.getFloat(itembase.getOdrdtl_finalprice().longValue()*lmtktra,2)+"\t";
	    		}
	    		else{
	    			linktech_str+=Tools.getFloat((itembase.getOdrdtl_finalprice().longValue()*lmtktra),2)+"\t";
	    		}
				if ("qq_login".equals(base.getOdrmst_temp())){
					linktech_str+="qq_login"+"\t";
				}
				else{
					String strOdrdtl_rackcode=itembase.getOdrdtl_rackcode();
		    		String strodrdtl_shopcode=itembase.getOdrdtl_shopcode();
		    		Product product = ProductHelper.getById(itembase.getOdrdtl_gdsid());
		    		String strgds_brand="";  
		    		String strRackCode="";  
		    		if(product != null)
		    		  {
		    			strgds_brand=product.getGdsmst_brand();
		    		  }
		    		if (itembase.getOdrdtl_downflag().longValue()==20){
		    			strRackCode="001";
		   	    	}else if ("001346".equals(strgds_brand) || "001561".equals(strgds_brand) || "001564".equals(strgds_brand))
		    		{
		    			strRackCode=strgds_brand;
		    		}
		    		else if(!strodrdtl_shopcode.equals("00000000")&&!strOdrdtl_rackcode.startsWith("014") )
		    		{
		    			strRackCode="shop";
		    		}
		    		else if(strOdrdtl_rackcode.startsWith("02")||strOdrdtl_rackcode.startsWith("03"))
		    		{
		    			strRackCode="017";
		    		}
		    		else if(strOdrdtl_rackcode.startsWith("015009"))
		    		{
		    			strRackCode="015009";
		    		}
		    		else
		    		{
		    			strRackCode="other";
		    		}
					linktech_str+=strRackCode+"\t";
				}
		linktech_str+="100"+"\t";
		linktech_str+="\r\n";

		}
		
	}
	out.print(linktech_str);
	return;
%>