<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!

//判断接收值是否验证通过
 String check(HttpServletRequest request, HttpServletResponse response){
	 String start="";
	 String end="";
    if (Tools.isNull(request.getParameter("cid")))
    {
        return "活动ID错误!";
    }
    else{
    	if(!"4599".equals(request.getParameter("cid"))&&!"325".equals(request.getParameter("cid"))){
    		return "活动ID错误!";
    	}
    }
    String time= request.getParameter("d").trim();
    if(time.length()!=8 && time.length()!=10){
    	return "参数d格式错误!";
    }
     return "true";

} 
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
String msg=check(request,response);
if(msg=="true"){
	//out.print("验证通过");
	String time= request.getParameter("d").trim();
	String end="";
	String start="";
	
	if(time.length()==8){//年月日形式
		start = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8) + " 00:00:00";
	    end = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8) + " 23:59:59";
	}else if(time.length()==10){//年月日时形式
		start = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8)+" "+time.substring(8, 10)+ ":00:00";
	    end = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8)+" "+time.substring(8, 10)+ ":59:59";
	}
	
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String strcid="";
	if("325".equals(request.getParameter("cid"))){
		strcid="325";
	}else{
		strcid="4599";
	}
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList(strcid+"yiqifa", format.parse(start), format.parse(end));
	//out.println(format.parse(start));
	//out.println(format.parse(end));
	
	//out.println(new Date());
	if(orderlist!=null){
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		 str.append("<orders>");
	  for(OrderBase base:orderlist){
		  String userid="";
		 
		  String temp=base.getOdrmst_temp();
		  int  i="4599yiqifa".length();
		  int j=temp.indexOf("|");
		  String wi=temp.substring(i,j);
		  String fbt="";
		  if (temp.length()>j+1){
		  fbt=temp.substring(j+1);
		  }
		  str.append("<order>");
		  str.append("<wi>");
		  str.append(wi);
		  str.append("</wi>");
		  str.append("<fbt>");
		  str.append(fbt);
		  str.append("</fbt>");
		  str.append("<order_time>");
		  str.append(Tools.stockFormatDate(base.getOdrmst_orderdate()));
		  str.append("</order_time>");
		  str.append("<order_no>");
		  str.append(base.getId());
		  str.append("</order_no>");
		  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  if(orderitemlist!=null){
			  str.append("<items>");
			  for(OrderItemBase itembase:orderitemlist){
				  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
				  if(product!=null){
					  String strRackCode="";
					  String strOdrdtlRackCode=itembase.getOdrdtl_rackcode();
					  double  iOdrdtlSpecialFlag=itembase.getOdrdtl_specialflag().doubleValue();
					  double price=0d;
					  double fltTktmstTktValue = Tools.doubleValue(base.getOdrmst_tktvalue());
					  double fdtltktra=1;//计算用券比例
						 if (fltTktmstTktValue>0)
						 {
						 	fdtltktra=getTktRa(fltTktmstTktValue,base.getId());
						 }
						 if (itembase.getOdrdtl_downflag().longValue()==20){
							 strRackCode="001";
				   	    	}else if(itembase.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0||
								  itembase.getOdrdtl_gdsname().indexOf("小栗舍")>=0 ||
								  itembase.getOdrdtl_gdsname().indexOf("YOUSOO")>=0){
						  strRackCode="017009";
					  }else if (!itembase.getOdrdtl_shopcode().equals("00000000")&&!itembase.getOdrdtl_rackcode().startsWith("014")){
						  strRackCode="shop";
			    		}
			    		else{
			    		    if (strOdrdtlRackCode.startsWith("015009"))
			    		    {
			    		    	strRackCode = strOdrdtlRackCode.substring(0, 6);
			    		    }
			    		    else if (strOdrdtlRackCode.startsWith("020") || strOdrdtlRackCode.startsWith("030"))
			    		    {
			    		    	strRackCode = strOdrdtlRackCode.substring(0, 3);
			    		    }
			    		    else
			    		    {
			    		    	strRackCode = "0";
			    		    }
			    		}
			    		
		               if (iOdrdtlSpecialFlag==1 || itembase.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(itembase.getOdrdtl_temp()))
		               {
		            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
		               }
		               else
		               {
		            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice()*fdtltktra, 2);
		               }
                     
                      str.append("<item>");
                      str.append("<prod_no>");
                      str.append(itembase.getOdrdtl_gdsid());
                      str.append("</prod_no>");
                      str.append("<prod_name>");
                      str.append(Tools.clearHTML(itembase.getOdrdtl_gdsname()));
                      str.append("</prod_name>");
                      str.append("<prod_type>");
                      str.append(strRackCode);
                      str.append("</prod_type>");
                      str.append("<amount>");
                      str.append(itembase.getOdrdtl_gdscount()+"");
                      str.append("</amount>");
                      str.append("<price>");
                      str.append(Tools.getDouble(price,2));
                      str.append("</price>");
                     
                      str.append("</item>");
                      
				  }
			  }
			  str.append("</items>"); 
		  }
		//}
		 
		  str.append("</order>"); 
	  }
		  str.append("</orders>"); 
	}
	
   }else{
	str.append(msg);
}
out.println(str.toString());
%>