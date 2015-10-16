<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!
//获取订单状态
String checkOrderStatus(int orderstatus,int odrmst_printflag,int OdrMst_Refundtype){
  String status = "-99999998";
 if(orderstatus<0){
  	status = "3";
  }
  else if(orderstatus==0){
  	status = "1";
  }
  else if(odrmst_printflag==0){
  	status = "5";
  }
  else if(odrmst_printflag==1){
  	status = "6";
  }
  else if(orderstatus==51 || orderstatus==5 || orderstatus==61 || orderstatus==6){
  	status = "12";
  }
  else if(OdrMst_Refundtype>0){
  	status = "13";
  }
  return status;
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
//计算订单总佣金
static double gettotal(String odrid, double fltTktmstTktValue){
	double total=0;
	 ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(odrid);
	  if(orderitemlist!=null){
		  for(OrderItemBase itembase:orderitemlist){
			  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
			  if(product!=null){
				  String strRackCode="";
				  String strGdsmstBrand=product.getGdsmst_brand();
				  String strOdrdtlRackCode=itembase.getOdrdtl_rackcode();
				  double  iOdrdtlSpecialFlag=itembase.getOdrdtl_specialflag().doubleValue();
				  double price=0d;
				
				  double fdtltktra=1;//计算用券比例
					 if (fltTktmstTktValue>0)
					 {
					 	fdtltktra=getTktRa(fltTktmstTktValue,odrid);
					 }
                 if (strGdsmstBrand.equals("001346" )|| //F&M
                     strGdsmstBrand.equals("001561") ||//YouSoo
                     strGdsmstBrand.equals("001564"))//小栗舍

                 {
                     strRackCode = "1";
                 }
                 else if (strOdrdtlRackCode.startsWith("020") || strOdrdtlRackCode.startsWith("030"))//服装
                 {
                     strRackCode = "2";
                 }
                 else if (strOdrdtlRackCode.startsWith("015009"))//饰品
                 {
                     strRackCode = "2";
                 }
                 else
                 {
                     strRackCode = "3";
                 }
                 
                if (iOdrdtlSpecialFlag==1 || itembase.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(itembase.getOdrdtl_temp()))
	               {
	            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
	               }
	               else
	               {
	            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice()*fdtltktra, 2);
	               }
                 double yongjin=itembase.getOdrdtl_gdscount().intValue()*Tools.getDouble(price,2);
                 if("1".endsWith(strRackCode)){
               	  yongjin*=0.15;
                 }else  if("2".endsWith(strRackCode)){
               	  yongjin*=0.08;
                 }else  if("3".endsWith(strRackCode)){
               	  yongjin*=0.04;
                 }
                 total+=yongjin;
			  }
		  }
	  }
	  return total;
}
//判断接收值是否验证通过
 String check(HttpServletRequest request, HttpServletResponse response){
	 String start="";
	 String end="";
    if (Tools.isNull(request.getParameter("unionId")))
    {
        return "unionId错误!";
    }
    String unionId = request.getParameter("unionId");
    if(!"yijifen".equals(unionId)){
    	 return "unionId错误!";
    }
    String verifycode="";
    if (!Tools.isNull(request.getParameter("sd"))){
        start = request.getParameter("sd");
    }
    if (!Tools.isNull(request.getParameter("ed"))){
        end =request.getParameter("ed");
    }
    if (!Tools.isNull(request.getParameter("verifycode"))){
        verifycode =request.getParameter("verifycode").toLowerCase();
    }
       

        String publicKey = "al1kthd1ysomegvhthzt";
        String verifycode2 = "";
        String str = unionId + start + end + publicKey;
        verifycode2 = MD5.to32MD5(str).toLowerCase();
        if (verifycode.equals(verifycode2)){
            return "true";
        }
        else{
            return "verifycode错误！";
        }
} 

%><%
StringBuffer str=new StringBuffer();
String msg=check(request,response);
if(msg=="true"){
	//out.print("验证通过");
	String start= request.getParameter("sd");
	String end= request.getParameter("ed");
	start = start.substring(0, 4) + "-" + start.substring(4, 6) + "-" + start.substring(6, 8) + " 00:00:00";
    end = end.substring(0, 4) + "-" + end.substring(4, 6) + "-" + end.substring(6, 8) + " 23:59:59";
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList("Yijifen", format.parse(start), format.parse(end));
	//out.println(format.parse(start));
	//out.println(format.parse(end));
	
	//out.println(new Date());
	SimpleDateFormat SFORMATE = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	if(orderlist!=null){
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		 str.append("<orders>");
	  for(OrderBase base:orderlist){
		  String Thkey="";
		 if(base.getOdrmst_temp().contains("|")){
			  String[] temp=base.getOdrmst_temp().split("\\|");
			  if(temp.length>=2){
				  Thkey=temp[1];
			  }
		  }

			  String status=checkOrderStatus(base.getOdrmst_orderstatus().intValue(),base.getOdrmst_printflag().intValue(),base.getOdrmst_refundtype
					  ().intValue());
		 
		  str.append("<order>");
		  str.append("<userid>");
		  str.append(base.getOdrmst_mbrid());//用户id？
		  str.append("</userid>");
		  str.append("<sonumber>");
		  str.append(base.getId());
		  str.append("</sonumber>");
		  str.append("<soamount>");
		  str.append(Tools.getDouble(base.getOdrmst_ordermoney(),2));
		  str.append("</soamount>");
		  str.append("<status>");
		  str.append(status);
		  str.append("</status>");
		  str.append("<commission>");
		  str.append(Tools.getDouble(gettotal(base.getId(), Tools.doubleValue(base.getOdrmst_tktvalue())),2));//订单佣金
		  str.append("</commission>");
		  str.append("<date>");
		  str.append(SFORMATE.format(base.getOdrmst_orderdate()));
		  str.append("</date>");
		  str.append("<updateTime>");
		  str.append("");//修改时间？
		  str.append("</updateTime>");
		  str.append("<thkey>");
		  str.append(Thkey);
		  str.append("</thkey>");
		  
		  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  if(orderitemlist!=null){
			  str.append("<items>");
			  for(OrderItemBase itembase:orderitemlist){
				  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
				  if(product!=null){
					  String strRackCode="";
					  String strGdsmstBrand=product.getGdsmst_brand();
					  String strOdrdtlRackCode=itembase.getOdrdtl_rackcode();
					  double  iOdrdtlSpecialFlag=itembase.getOdrdtl_specialflag().doubleValue();
					  double price=0d;
					  double fltTktmstTktValue = Tools.doubleValue(base.getOdrmst_tktvalue());
					  double fdtltktra=1;//计算用券比例
						 if (fltTktmstTktValue>0)
						 {
						 	fdtltktra=getTktRa(fltTktmstTktValue,base.getId());
						 }
                      if (strGdsmstBrand.equals("001346" )|| //F&M
                          strGdsmstBrand.equals("001561") ||//YouSoo
                          strGdsmstBrand.equals("001564"))//小栗舍

                      {
                          strRackCode = "1";
                      }
                      else if (strOdrdtlRackCode.startsWith("02") || strOdrdtlRackCode.startsWith("03"))//服装
                      {
                          strRackCode = "2";
                      }
                      else if (strOdrdtlRackCode.startsWith("015009"))//饰品
                      {
                          strRackCode = "2";
                      }
                      else
                      {
                          strRackCode = "3";
                      }
                      
                     if (iOdrdtlSpecialFlag==1 || itembase.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(itembase.getOdrdtl_temp()))
		               {
		            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
		               }
		               else
		               {
		            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice()*fdtltktra, 2);
		               }
                      double yongjin=itembase.getOdrdtl_gdscount().intValue()*Tools.getDouble(price,2);
                     String rname="";
                     Directory dir=DirectoryHelper.getById(strOdrdtlRackCode);
                     if(dir!=null){
                    	 rname=dir.getRakmst_rackname().trim(); 
                     }
                      str.append("<item>");
                      str.append("<itemcode>");
                      str.append(itembase.getOdrdtl_gdsid());
                      str.append("</itemcode>");
                      str.append("<itemname>");
                      str.append(Tools.clearHTML(itembase.getOdrdtl_gdsname()));
                      str.append("</itemname>");
                      str.append("<quantity>");
                      str.append(itembase.getOdrdtl_gdscount()+"");
                      str.append("</quantity>");
                      str.append("<unioncode>");
                      str.append(rname);
                      str.append("</unioncode>");
                      str.append("<unitprice>");
                      str.append(Tools.getDouble(price,2));
                      str.append("</unitprice>");
                      str.append("<extendprice>");
                      str.append(Tools.getDouble(yongjin,2));//需结算佣金的金额
                      str.append("</extendprice>");
                      if("1".endsWith(strRackCode)){
                    	  yongjin*=0.15;
                      }else  if("2".endsWith(strRackCode)){
                    	  yongjin*=0.08;
                      }else  if("3".endsWith(strRackCode)){
                    	  yongjin*=0.04;
                      }
                      str.append("<itemcommission>");
                      str.append(Tools.getDouble(yongjin,2));//订单项结算佣金
                      str.append("</itemcommission>");
                      str.append("<transactionnumber>");
                      str.append("");//商品流水号 
                      str.append("</transactionnumber>");
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