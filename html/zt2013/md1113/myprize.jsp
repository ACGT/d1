<%@ page contentType="text/html; charset=GBK"%><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,
com.d1.bean.LotCon"%><%
User lUser = UserHelper.getLoginUser(request, response);
%><%!

public static OrderBase getOrder(String orderId){
	if(Tools.isNull(orderId)) return null;
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);
	return order;
}
/** 
* ������� 
* @param d ������ 
* @param day ��ӵ����� 
* @return ��Ӻ������ 
* @throws ParseException 
*/ 
public static Date addDate(Date d,long day) throws ParseException { 

long time = d.getTime(); 
day = day*24*60*60*1000; 
time+=day; 
return new Date(time); 

} 

private void addtkt(double ordermoney,double orderround,String mbrid,String mbruid,String odrid){
	double cardvalue=Tools.getDouble(ordermoney*orderround,0);
	if(cardvalue<1f)cardvalue=1f;
	long gdsvalue=10;
	String memotxt="";
	String winname="";
	 /*
	tktcrd_cardno,tktcrd_mbrid,tktcrd_value,tktcrd_realvalue,tktcrd_discount,
	tktcrd_type,tktcrd_validflag,tktcrd_enddate,tktcrd_validates,tktcrd_validatee,
	tktcrd_memo) values('"&cardnotitle&mbrid&randvalue&"',"&mbrid&","&gdsvalue&",
	"&cardvalue&",0.15,'004001',1,'"&now()+15&"','"&now()&"','"&now()+15&"','����齱�ȯ') ")
	 */
	 Random rndcard = new Random();
	 String cardno="papmdcj1311"+mbrid+rndcard.nextInt(20000);
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),30);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }

		 Ticket tktmst=new Ticket();
		 tktmst.setTktmst_value(new Float(cardvalue));
		 tktmst.setTktmst_type("004001");
		 tktmst.setTktmst_mbrid(Tools.parseLong(mbrid));
		 tktmst.setTktmst_validflag(new Long(0));
		 tktmst.setTktmst_createdate(startdate);
		 tktmst.setTktmst_validates(startdate);
		 tktmst.setTktmst_validatee(enddate);
		 tktmst.setTktmst_rackcode("000");
         tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("11���ⵥ���");
         Tools.getManager(Ticket.class).create(tktmst);
	
	
         LotOdrWin odrwin=new LotOdrWin();
         odrwin.setLotodrwin_odrid(odrid);
         odrwin.setLotodrwin_flag(new Long(0));
         odrwin.setLotodrwin_price(orderround);
         odrwin.setLotodrwin_uid(mbruid);
         odrwin.setLotodrwin_createtime(new Date());
         
	 Tools.getManager(LotOdrWin.class).create(odrwin);
}
%>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2013-12-01");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"code\":1,\"message\":\"�ⵥ��Ѿ�������\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}

SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
String stime=df3.format(new Date())+" 00:00:00";
String etime =df3.format(new Date())+" 23:59:59";
java.util.Date   starttime=df2.parse(stime); 
java.util.Date   endtime=df2.parse(etime);

String odrid=request.getParameter("orderid");
if(Tools.isNull(odrid))
{
	out.print("{\"code\":1,\"message\":\"�齱�����Ų���Ϊ�գ�\"}");
	return;
}
odrid=odrid.trim();
LotOdrWin lotwin=(LotOdrWin)Tools.getManager(LotOdrWin.class).findByProperty("lotodrwin_odrid", odrid);
if(lotwin!=null){
	out.print("{\"code\":1,\"message\":\"�˶����Ѿ�������ⵥ���\"}");
	return;
}


 OrderBase  order= getOrder(odrid);
 String sdate="2013-11-01 00:00:00";
 String edate="2013-11-21 00:00:00";
 if(order==null){
	 out.print("{\"code\":1,\"message\":\"�˶��������ڣ�\"}");
		return;
 }
 long orderstatus=order.getOdrmst_orderstatus().longValue();
 if(orderstatus==1||orderstatus==2||orderstatus==3||orderstatus==31){
	 out.print("{\"code\":1,\"message\":\"�˶���δ��ᣬ��ȷ���ջ����ٳ��ⵥ��\"}");
		return; 
}
 
 String mbrid=lUser.getId();
 
 if(mbrid.equals(order.getOdrmst_mbrid()+"")&&df2.parse(sdate).before(order.getOdrmst_orderdate())
		 &&order.getOdrmst_orderdate().before(df2.parse(edate))
		 &&(orderstatus==5||orderstatus==51||orderstatus==6||orderstatus==61)){
	// if(mbrid.equals(order.getOdrmst_mbrid()+"")&&order.getOdrmst_orderdate().getMinutes()>df2.parse(sdate).getMinutes()){
	 Random rnd = new Random();
	   long rndvalue=(long)rnd.nextInt(1000);
	   
	   String mbruid=lUser.getMbrmst_uid();
double omoney=order.getOdrmst_acturepaymoney()+order.getOdrmst_prepayvalue();
double orderround=0f;
if(omoney<=100f){
	if (rndvalue>=0&&rndvalue<=9){
		orderround=0.5f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����50%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}else if (rndvalue>=10 && rndvalue<=310){
		orderround=0.2f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����20%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}else{
		orderround=0.1f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����10%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}
		
}else if(omoney>100f&&omoney<=500f){
	if (rndvalue>=0&& rndvalue<=9){
		orderround=0.5f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����20%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}else if (rndvalue>=10 && rndvalue<=110){
		orderround=0.1f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����10%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}else{
		orderround=0.05f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����5%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}
}else if(omoney>500f){
	if (rndvalue>=0&&rndvalue<=9){
		orderround=0.2f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����20%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}else if (rndvalue>=10 && rndvalue<=100){
		orderround=0.1f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����10%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}else{
		orderround=0.05f;
		addtkt(omoney,orderround,mbrid,mbruid,odrid);
		out.print("{\"code\":2,\"message\":\"��ϲ�����5%�ⵥ���ᣬ�ⵥ�����ֽ�ȯ����ʽ���ŵ������˻���30������Ч!\"}");
		   return;
	}
}
 }else{
	 out.print("{\"code\":1,\"message\":\"�˶������ܲ����ⵥ���\"}");
		return;
 }
%>