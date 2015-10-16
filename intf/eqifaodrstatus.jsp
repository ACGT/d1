<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
//判断接收值是否验证通过
 String check(HttpServletRequest request, HttpServletResponse response){
	 String start="";
	 String end="";
    
    String time= request.getParameter("d").trim();
    if(time.length()!=8 && time.length()!=10){
    	return "参数d格式错误!";
    }
     return "true";

} 
private static String cps(String rackcode,String specialflag)
{
    String strRet = "";
    if (rackcode.startsWith("015009"))
    {
        strRet = rackcode.substring(0, 6);
    }
    else if (rackcode.startsWith("02")||rackcode.startsWith("03"))
    {
        strRet = "017";
    }
    else
    {
        strRet = "0";
    }
    return strRet;
}
/**
 * 获取用券比例
 * @param tktvalue
 * @param odrid
 * @return
 */
public static double getTktRa(double tktvalue,String odrid,double allmoney )
{
	double retra=1;

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
	//String strcid="";
	/**
	if("325".equals(request.getParameter("cid"))){
		strcid="325";
	}else{
		strcid="4599";
	}**/
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList("eqifa", format.parse(start), format.parse(end));
	//out.println(format.parse(start));
	//out.println(format.parse(end));
	
	//out.println(new Date());
	if(orderlist!=null){
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		 str.append("<orders>");
	  for(OrderBase base:orderlist){
		  String userid="";
		 
		  String temp=base.getOdrmst_temp();
		 // int  i="4599yiqifa".length();
		 // int j=temp.indexOf("|");
		  String wi=temp.substring(5);
		  double fdtltktra=1;//计算用券比例
			 if (base.getOdrmst_tktvalue().doubleValue()>0)
			 {
			 	fdtltktra=getTktRa(base.getOdrmst_tktvalue().doubleValue(),base.getId(),base.getOdrmst_gdsmoney().doubleValue());
			 }
		  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  String strRackcode="";
	     	long iOdrdtlSpecialFlag=0;
		  if(orderitemlist!=null){
			  for(OrderItemBase itembase:orderitemlist){
				  strRackcode=itembase.getOdrdtl_rackcode();
	               iOdrdtlSpecialFlag=itembase.getOdrdtl_specialflag();
	               if (itembase.getOdrdtl_downflag().longValue()==20){
	            	   strRackcode="001";
		   	    	}else if(itembase.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0||
						  itembase.getOdrdtl_gdsname().indexOf("小栗舍")>=0 ||
						  itembase.getOdrdtl_gdsname().indexOf("YOUSOO")>=0){
		    			strRackcode="017009";
					  }else if (!itembase.getOdrdtl_shopcode().equals("00000000")&&!itembase.getOdrdtl_rackcode().startsWith("014")){
			    			 strRackcode="shop";
		    		}
		    		else{
		    			strRackcode=cps(itembase.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
		    		}
		  str.append("<order>");
		  str.append("<wi>");
		  str.append(wi);
		  str.append("</wi>");
		  str.append("<order_no>");
		  str.append(base.getId());
		  str.append("</order_no>");
		  str.append("<prod_no>");
		  str.append(itembase.getOdrdtl_gdsid());
		  str.append("</prod_no>");//<!--商品编号-->
		  str.append("<prod_name><![CDATA[");
		  str.append(Tools.clearHTML(itembase.getOdrdtl_gdsname()));
		  str.append("]]></prod_name>");//<!--商品名称-->
		  str.append("<prod_type><![CDATA[");
		  str.append(strRackcode);
		  str.append("]]></prod_type>");//<!--佣金分类-->
		  str.append("<amount>");
		  str.append(itembase.getOdrdtl_gdscount().longValue());
		  str.append("</amount>");//<!--商品数量-->
		  str.append("<price>");
		  str.append(Tools.getDouble(itembase.getOdrdtl_finalprice().doubleValue()*fdtltktra,2));
		  str.append("</price>");//<!--商品金额-->
		  str.append("<order_status>");
		  if(base.getOdrmst_orderstatus().longValue()>=0){
		  str.append(base.getOdrmst_orderstatus());
		  }else{
			  str.append(-1);
		  }
		  str.append("</order_status>");
		  str.append("<update_date>");
		  str.append(Tools.stockFormatDate(base.getOdrmst_orderdate()));
		  str.append("</update_date>");
		  str.append("<start_date>");
		  str.append(Tools.stockFormatDate(base.getOdrmst_orderdate()));
		  str.append("</start_date>");
		  str.append("<payment_status>");
		  str.append(base.getOdrmst_orderstatus());
		  str.append("</payment_status>");
		  str.append("<payment_type>");
		  str.append(base.getOdrmst_paymethod());
		  str.append("</payment_type>");
		  str.append("<fare>");
		  str.append(Tools.getDouble( base.getOdrmst_shipfee(), 2));
		  str.append("</fare>");
		  str.append("<favorable>");
		  str.append(Tools.getDouble(base.getOdrmst_tktvalue(),2));
		  str.append("</favorable>");
		 
		  str.append("</order>"); 
		}
	  }
	  }
		  str.append("</orders>"); 
	}
	
   }else{
	str.append(msg);
}
out.println(str.toString());
%>