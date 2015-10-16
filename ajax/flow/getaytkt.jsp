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

private void addtkt(int tkttype,String mbrid,String mbruid){
	long cardvalue=0;
	long gdsvalue=0;
	String rackcode="000";
	 switch (tkttype)
	    {
	       case 1:
	        	cardvalue=100;
	        	gdsvalue=300;
	        	rackcode="017";
                break;
	        case 2:
	        	cardvalue=10;
	        	gdsvalue=10;
	            break;
	        case 3:
	        	cardvalue=100;
	        	gdsvalue=100;
	            break;
	        case 4:
	        	cardvalue=10;
	        	gdsvalue=100;
	            break;
	        case 5:
	        	cardvalue=30;
	        	gdsvalue=200;
	            break;
	        case 6:
	        	cardvalue=20;
	        	gdsvalue=100;
	            break;
	    }
	 Random rndcard = new Random();
	 String cardno="paoyun1207"+mbrid;
	 PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", Tools.parseLong(mbrid));
	 if(pauser!=null){
		 cardno="pa"+cardno;
	 }
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),7);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }
	 if (tkttype==3){
		 TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
		 tktcrd.setTktcrd_value(new Long(gdsvalue));
		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("004001");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(startdate);
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("���˻��");
		 tktcrd.setTktcrd_rackcode("000");
		 tktcrd.setTktcrd_payid(new Long(-1));
		 Tools.getManager(TicketCrd.class).create(tktcrd);
	 }
	 else{
		 Ticket tktmst=new Ticket();
		 tktmst.setTktmst_value(new Float(cardvalue));
		 tktmst.setTktmst_type("004001");
		 tktmst.setTktmst_mbrid(Tools.parseLong(mbrid));
		 tktmst.setTktmst_validflag(new Long(0));
		 tktmst.setTktmst_createdate(startdate);
		 tktmst.setTktmst_validates(startdate);
		 tktmst.setTktmst_validatee(enddate);
		 tktmst.setTktmst_rackcode(rackcode);
         tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("���˻��");
         Tools.getManager(Ticket.class).create(tktmst);
	 }
}
%>
<%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}

SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2012-8-13");
	 
	 }
catch(Exception ex){
	ex.printStackTrace();
}

String ndate=fmt.format(new Date());
Date date = null;
try {
 date = format.parse(ndate);
} catch (ParseException e) {
 e.printStackTrace();
}
AYQuestion qus=(AYQuestion)Tools.getManager(AYQuestion.class).findByProperty("qviewTime",date );
if (qus==null){
	out.print("{\"success\":false,\"message\":\"������ȯ����� �Ѿ����꣡\"}");
	return;
}
SimpleDateFormat fmttime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
ndate=ndate+" "+qus.getQuestiontktend();
Date endtkttime=fmttime.parse(ndate);

if(Tools.dateValue(endtkttime)<System.currentTimeMillis()){
	out.print("{\"success\":false,\"message\":\"������ȯ����� �Ѿ����꣡\"}");
	return;
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"message\":\"������ȯ��Ѿ�������\"}");
	return;
}

SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
String stime=df3.format(new Date())+" 00:00:00";
String etime =df3.format(new Date())+" 23:59:59";
java.util.Date   starttime=df2.parse(stime); 
java.util.Date   endtime=df2.parse(etime);



	Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(1000);
   String mbrid=lUser.getId().trim();
   String mbruid=lUser.getMbrmst_uid();
   String cardt="paoyun1207"+lUser.getId().trim();
   String PingAnlogin = Tools.getCookie(request,"PINGAN");
   if(!Tools.isNull(PingAnlogin)){
   	cardt="pa"+cardt;
   }
   Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno",cardt);
   TicketCrd tktcrd=(TicketCrd)Tools.getManager(TicketCrd.class).findByProperty("tktcrd_cardno", cardt);
   
	
   if(tktcard!=null||tktcrd!=null) {
	   //System.out.println("gjltest:"+tktcard.getTktmst_cardno());
   	out.print("{\"success\":false,\"message\":\"���Ѿ�����Ż�ȯ�ˣ�һ���û�����һ�ţ�\"}");
   	return;
   }
  
   
   /*
1----300-100����ȯ  30%      ����700
2----10Ԫ������ȯ  10%       600-700
3----15%����ȯ   5%          550-600
4----100-10Ԫȯ   20%        350-550
5----200-30Ԫȯ   25%        100-350
6----100-20Ԫȯ    10%        1-100
   */
   if (rndvalue>700){
	   addtkt(1,mbrid,mbruid);
	   out.print("{\"success\":true,\"message\":\"��ϲ�����100Ԫ�Ż�ȯ��������300Ԫ���ã�7������Ч!\"}");
	   return;
   }
   else if(rndvalue>600 && rndvalue<=700){
	   addtkt(2,mbrid,mbruid);
	   out.print("{\"success\":true,\"message\":\"��ϲ�����10Ԫ�Ż�ȯ��ȫ��ͨ�ã�7������Ч!\"}");
	   return;
   }
   else if(rndvalue>550 && rndvalue<=600){
	   addtkt(3,mbrid,mbruid);
	   out.print("{\"success\":true,\"message\":\"��ϲ�����100Ԫ�Ż�ȯ��ȫ��������Ʒ��15�����⣬7������Ч!\"}");
	   return;
   }
   else if(rndvalue>350 && rndvalue<=550){
	   addtkt(4,mbrid,mbruid);
	   out.print("{\"success\":true,\"message\":\"��ϲ�����10Ԫ�Ż�ȯ��ȫ������100Ԫ���ã�7������Ч!\"}");
	   return;
   }
   else if(rndvalue>100 && rndvalue<=350){
	   addtkt(5,mbrid,mbruid);
	   out.print("{\"success\":true,\"message\":\"��ϲ�����30Ԫ�Ż�ȯ��ȫ������200Ԫ���ã�7������Ч!\"}");
	   return;
   }
   else if(rndvalue>=0 && rndvalue<=100){
	   addtkt(6,mbrid,mbruid);
	   out.print("{\"success\":true,\"message\":\"��ϲ�����20Ԫ�Ż�ȯ��ȫ������100Ԫ���ã�7������Ч!!\"}");
	   return;
   }

%>