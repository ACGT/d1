<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%@page import="
com.d1.bean.OrderBase,
com.d1.bean.OrderItemBase,
com.d1.bean.PingAnScorePay,
com.d1.bean.PingAnUser,
com.d1.helper.OrderHelper,
com.d1.helper.OrderItemHelper,
com.d1.util.MD5,
com.d1.util.Tools"
%><%!private static String strcut(String str){
	String strret=str.substring(0,(str.length()-3));
	try{
	 strret=java.net.URLEncoder.encode(strret,"UTF-8");
	}
	catch(Exception ex){
		 return null;
	}
	return strret.toUpperCase();
	} %><%
String strPinganYdmm = "1-O73UW3";
String strpartner = "79_0";
//获取参数值
String strmethod=request.getParameter("method");
String strMemberNumber=request.getParameter("MemberNumber");
String strTTNumber=request.getParameter("TTNumber");
String strStartDate=request.getParameter("StartDate");
String strEndDate=request.getParameter("EndDate");
String strReqPaSignature=request.getParameter("paSignature");

String strPaSignature=MD5.to32MD5(strStartDate+strEndDate+strPinganYdmm, "UTF-8");
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date dEndDate=null;
try{
	 if(!Tools.isNull(strStartDate)){
   	 dStartDate =fmt.parse(strStartDate);
   	 //String StartDate = fmt2.format(dStartDate);
   	 }
   	 if(!Tools.isNull(strEndDate)){
   		 dEndDate =fmt.parse(strEndDate);
   		// String EndDate = fmt2.format(dEndDate);
   		 }
   	 if (strPaSignature.equals(strReqPaSignature)){
   		 
   	 }
}
catch(Exception ex){
	 ex.printStackTrace();
}
System.out.println(dStartDate);
System.out.println(dEndDate);
//if(!strReqPaSignature.equals(strPaSignature)){
//	 System.out.print("签名错误！");return null;    		 
//}
//partner;memberid;amount;tttime;ttnumber;ext1,ext2;ext3;mediumsource;proprice$|$proprice2;pronum1$|$pronum2;
//procate1$|$procate2;prodname1$|$prodname2;prold1$|$prold2@@
ArrayList<OrderBase> orderlist=OrderHelper.getOrderList_pingan(dStartDate, dEndDate, strTTNumber, strMemberNumber);
StringBuilder strbd = new StringBuilder();	
String strbdprice="";
String strbdpronum="";
String strbdprocate="";
String strbdproname="";
String strbdproid="";
if(orderlist==null)return;
	for(OrderBase base:orderlist){
		PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", base.getOdrmst_mbrid());
		if (pauser==null)continue;
		ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		if (orderitemlist==null)continue; 
		strbd.append(strpartner+";");
		strbd.append(pauser.getMbrmstpingan_memberid()+";");
		strbd.append(base.getOdrmst_acturepaymoney()+";");
		strbd.append(fmt.format(base.getOdrmst_orderdate())+";");
		strbd.append(base.getOdrmst_id()+";");
		strbd.append(";;;;");
		 strbdprice="";
		 strbdpronum="";
		 strbdprocate="";
		 strbdproname="";
		 strbdproid="";
		for(OrderItemBase itembase:orderitemlist){
			strbdprice+=itembase.getOdrdtl_finalprice().toString()+"$|$";
			strbdpronum+=itembase.getOdrdtl_gdscount().toString()+"$|$";
			strbdprocate+=itembase.getOdrdtl_rackcode()+"$|$";
			strbdproname+=Tools.clearHTML(itembase.getOdrdtl_gdsname())+"$|$";
			strbdproid+=itembase.getOdrdtl_gdsid()+"$|$";
		 }
		strbd.append(strcut(strbdprice)+";");
		strbd.append(strcut(strbdpronum)+";");
		strbd.append(strcut(strbdprocate)+";");
		strbd.append(strcut(strbdproname)+";");
		strbd.append(strcut(strbdproid)+"@@");
	}
	
    if(!Tools.isNull(strbd.toString())){
    	//out.print(strbd.toString());
       out.print(strbd.substring(0,strbd.length()-2));
    }


%> 