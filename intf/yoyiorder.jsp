<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!

static double getTktRa(double tktvalue,String odrid )
{
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(odrid);
	double allmoney=0;
	double retra=1;
	for(OrderItemBase odrdtl:list)
	{
		if (!"000".equals(odrdtl.getOdrdtl_rackcode()) && Tools.isNull(odrdtl.getOdrdtl_gifttype()))
		{
			allmoney+=odrdtl.getOdrdtl_finalprice()*odrdtl.getOdrdtl_gdscount();
		}	
	}
	if (allmoney!=0)
	{
		retra=Tools.getDouble(1-tktvalue/allmoney,3);
	}
	if(retra<0 || retra>1 ){
		retra=1;
	}
	
	return retra;
}
%><%
StringBuffer str=new StringBuffer();

	String time= request.getParameter("d").trim();
	String end="";
	String start="";
	
		start = time + " 00:00:00";
	    end = time + " 23:59:59";

	
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList("YOYI", format.parse(start), format.parse(end));
	//out.println(format.parse(start));
	//out.println(format.parse(end));
	
	//out.println(new Date());
	if(orderlist!=null){
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		 str.append("<result>");
		 String YOYI_id="";
		 String YOYI_cid="";
		 String userid="";
		 long odrmst_orderstatus=0;
		 long OdrDtl_shipstatus=0;
		 long yoyi_status=1;
		 long yoyi_dtlstatus=1;
	  for(OrderBase base:orderlist){
		  userid="";
		  YOYI_id="";
		  YOYI_cid="";
		  yoyi_status=1;
		  String temp=base.getOdrmst_temp();
		  int j=temp.indexOf("|");
		  YOYI_id=temp.substring(4,j);
		  if (temp.length()>j+1){
			  YOYI_cid=temp.substring(j+1);
		  }
          odrmst_orderstatus=base.getOdrmst_orderstatus().longValue();
          if (odrmst_orderstatus==3 || odrmst_orderstatus==31 
        		  || odrmst_orderstatus==5 || odrmst_orderstatus==51
        		  || odrmst_orderstatus==6 || odrmst_orderstatus==61){
        		  yoyi_status=2;
                 }
        		  else if (odrmst_orderstatus<0){
        		  yoyi_status=3;
        		  }
		  str.append("<data>");
		  str.append("<yoyisid>"+YOYI_id+"</yoyisid>");
		  str.append("<yoyiscid>"+YOYI_cid+"</yoyiscid>");
		  str.append("<orderinfo>");
		  str.append("<orderid>"+base.getId()+"</orderid>");
		  str.append("<totalprices>"+Tools.getDouble(base.getOdrmst_ordermoney(),2)+"</totalprices>");
		  str.append("<orderstatus>"+yoyi_status+"</orderstatus>");
		  str.append("<time>"+format.format(base.getOdrmst_orderdate())+"</time>");

		  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  if(orderitemlist!=null){
			  for(OrderItemBase itembase:orderitemlist){
				  yoyi_dtlstatus=1;
				  OdrDtl_shipstatus=itembase.getOdrdtl_shipstatus().longValue();
				  if (OdrDtl_shipstatus==3 || OdrDtl_shipstatus==2){
						  yoyi_dtlstatus=2;
				  }
						  else if (odrmst_orderstatus<0){
						  yoyi_dtlstatus=3;
			           }
			  str.append("<goodsinfo>");
              str.append("<goodsid>"+itembase.getOdrdtl_gdsid()+"</goodsid>");
              str.append("<goodsname>"+Tools.clearHTML(itembase.getOdrdtl_gdsname())+"</goodsname>");
              str.append("<goodstype>"+itembase.getOdrdtl_rackcode()+"</goodstype>");
              str.append("<goodsnum>"+itembase.getOdrdtl_gdscount().longValue()+"</goodsnum>");
              str.append("<goodsprice>"+Tools.getDouble(itembase.getOdrdtl_finalprice(),2)+"</goodsprice>");
              str.append("<goodsstatus>"+yoyi_dtlstatus+"</goodsstatus>");
              str.append("</goodsinfo>");
			  }
		  }
	 
		  str.append("</orderinfo>"); 
		  str.append("</data>"); 
		  
	  }
		  str.append("</result>"); 
	
	}
out.println(str.toString());
%>