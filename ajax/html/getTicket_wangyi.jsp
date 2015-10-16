<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
static Date addDate(Date d,long day) throws ParseException { 

long time = d.getTime(); 
day = day*24*60*60*1000; 
time+=day; 
return new Date(time); 

} 
%>
<%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}
if(!Tools.isNull(request.getParameter("code"))){
	
	Tuandh tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", request.getParameter("code"));
	if(tuandh==null){
		out.print("1");
		return;
	}
	if(tuandh.getTuandh_status().longValue()==2){
		out.print("2");
		return;
	}
	Random rndcard = new Random();
	 String cardno="sdhjh1203"+lUser.getId()+rndcard.nextInt(20000);
	
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),30);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }

	 int i=0;
	 int j=0;
		 TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(lUser.getId()));
		 tktcrd.setTktcrd_value(new Long(100));
		 tktcrd.setTktcrd_realvalue(new Long(100));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("003005");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(startdate);
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("网易兑换码换优惠券！");
		 tktcrd.setTktcrd_payid(new Long(-1));
		 Tools.getManager(TicketCrd.class).create(tktcrd);
			if(tktcrd!=null){
				i=1;
			}
		 Ticket tktmst=new Ticket();
		 tktmst.setTktmst_value(new Float(50));
		 tktmst.setTktmst_type("003005");
		 tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		 tktmst.setTktmst_validflag(new Long(0));
		 tktmst.setTktmst_createdate(startdate);
		 tktmst.setTktmst_validates(startdate);
		 tktmst.setTktmst_validatee(enddate);
		 tktmst.setTktmst_rackcode("017");
         tktmst.setTktmst_gdsvalue(new Float(200));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("网易兑换码换优惠券！");
         Tools.getManager(Ticket.class).create(tktmst);
		if(tktmst!=null){
			j=1;
		}
		if(i==1 && j==1){
			tuandh.setTuandh_status(new Long(2));
			tuandh.setTuandh_yztime(new Date());
			tuandh.setTuandh_mbrid(new Long(lUser.getId()));
			if(Tools.getManager(Tuandh.class).update(tuandh, true)){
				out.print("0");
			}
			
		}
}
%>