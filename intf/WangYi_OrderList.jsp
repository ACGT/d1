<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
//获取订单状态
 String checkOrderStatus(int orderstatus){
    String status = "0";
    switch (orderstatus)
    {
        case 0:
            status = "0";
            break;
        case 1:
        case 2:
            status = "1";
            break;
        case 3:
            status = "2";
            break;
        case 31:
            status = "2";
            break;
        case 5:
            status = "3";
            break;
        case 51:
            status = "3";
            break;
        case 6:
            status = "3";
            break;
        case 61:
            status = "3";
            break;
        case -1:
            status = "5";
            break;
        case -2:
            status = "5";
            break;
        case -3:
            status = "5";
            break;
        default:
        	 status = "5";
        	 break;
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
//判断接收值是否验证通过
 String check(HttpServletRequest request, HttpServletResponse response){
	 String start="";
	 String end="";
    if (Tools.isNull(request.getParameter("unionId")))
    {
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
    //if (unionId != BllMbrmst.GetWangYiUnionId())
    //{
    //    return "unionid错误！";
    //}
         String unionId = request.getParameter("unionId");
        //start = "20110916";
        //end = "20110917";
        String publicKey = "9eb3e06d015f81fb";
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
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList_wangyi("WangYi", format.parse(start), format.parse(end));
	//out.println(format.parse(start));
	//out.println(format.parse(end));
	
	//out.println(new Date());
	if(orderlist!=null){
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		 str.append("<orders>");
	  for(OrderBase base:orderlist){
		  String userid="";
		 /* if(base.getOdrmst_temp().contains("|")){
			  String[] temp=base.getOdrmst_temp().split("\\|");
			  
			  if(temp.length>=2){
				  userid=temp[1];
			  }
		  }else{
			  ArrayList<User163> userlist=UserHelper.getUser163Info(base.getOdrmst_mbrid());
			  if(userlist!=null){
				  userid=userlist.get(0).getWangyi_userid();
			  }
		  }
		 
		  if(userid.length()>0){*/
			  /*	   ArrayList<User163> userlist=UserHelper.getUser163Info(base.getOdrmst_mbrid());
		 if(userlist!=null){
			  userid=userlist.get(0).getWangyi_userid();
		  }*/
		 if (base.getOdrmst_temp()!=null){
				  String strwangyi=base.getOdrmst_temp();
				  String arrwangyi[]=strwangyi.split("\\|");
	    	 if (arrwangyi.length>1){
	    		 userid=arrwangyi[1];
	    		//strWangYiWid=arrwangyi[0];
	    	 }
		  }
			  String status=checkOrderStatus(base.getOdrmst_orderstatus().intValue());
		 
		  str.append("<order>");
		  str.append("<user_id>");
		  str.append(userid);
		  str.append("</user_id>");
		  str.append("<order_id>");
		  str.append(base.getId());
		  str.append("</order_id>");
		  str.append("<status>");
		  str.append(status);
		  str.append("</status>");
		  str.append("<order_time>");
		  str.append(Tools.stockFormatDate(base.getOdrmst_orderdate()));
		  str.append("</order_time>");
		  String cpa="0";
		  ArrayList<User163> userlist=UserHelper. getUser163ByRegDate(base.getOdrmst_mbrid(),format.parse(start), format.parse(end));
		 if(userlist!=null && userlist.size()>0){
			 cpa="1";
		 }
		  
		  if(status.equals("5")){
			  cpa="0";
		  }
		  str.append("<cpa>");
		  str.append(cpa);
		  str.append("</cpa>");
		 
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
                      else if (strOdrdtlRackCode.startsWith("020") || strOdrdtlRackCode.startsWith("030"))//服装
                      {
                          strRackCode = "2";
                      }
                      else if (strOdrdtlRackCode.startsWith("015009"))//饰品
                      {
                          strRackCode = "2";
                      }else if (!itembase.getOdrdtl_shopcode().equals("00000000")){
                    	  strRackCode="4";
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
                      str.append("<item>");
                      str.append("<item_id>");
                      str.append(itembase.getOdrdtl_gdsid());
                      str.append("</item_id>");
                      str.append("<category_id>");
                      str.append(strRackCode);
                      str.append("</category_id>");
                      str.append("<price>");
                      str.append(Tools.getDouble(price,2));
                      str.append("</price>");
                      str.append("<num>");
                      str.append(itembase.getOdrdtl_gdscount()+"");
                      str.append("</num>");
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