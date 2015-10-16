<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkkfmng.jsp"%>
<%
String rname = request.getParameter("rname");
String prv = request.getParameter("prv");
//System.out.println(shipname);
String city = request.getParameter("city");
String phone = request.getParameter("phone");
String addr = request.getParameter("addr");
String zipcode = request.getParameter("zipcode");

String odrid=request.getParameter("odrid");
if(Tools.isNull(odrid)||Tools.isNull(prv)||Tools.isNull(city)||Tools.isNull(phone)
		||Tools.isNull(addr)||Tools.isNull(zipcode)){
	out.print("{\"code\":1,message:\"收货人信息不能为空！\"}");
	return;
}
String ordertbl = "main";
OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(odrid);

if(order == null) {
	order = (OrderBase)Tools.getManager(OrderRecent.class).get(odrid);
	ordertbl = "recent";
}
if(order!=null&&order.getOdrmst_orderstatus().longValue()>0&&order.getOdrmst_orderstatus().longValue()<3){
	try {
		OdrTmLog otlog =new OdrTmLog();
		String muser=session.getAttribute("kfadmin").toString();
		otlog.setOdrtmlog_odrid(odrid);
		otlog.setOdrtmlog_user(muser);
		otlog.setOdrtmlog_type("修改收货人");
		String nlog="省："+prv+"+市："+city+"+电话："+phone+"+地址："+addr+"+邮编："+zipcode+"+收货人："+rname;
		String olog="省："+order.getOdrmst_rprovince().trim()+"+市："+order.getOdrmst_rcity().trim()+"+电话："+order.getOdrmst_rphone().trim()+"+地址："+order.getOdrmst_raddress().trim()+"+邮编："+order.getOdrmst_rzipcode().trim()+"+收货人："+order.getOdrmst_rname().trim();
		otlog.setOdrtmlog_oldtxt(olog);
		otlog.setOdrtmlog_ntxt(nlog);
		Tools.getManager(OdrTmLog.class).create(otlog);
		
		order.setOdrmst_rprovince(prv);
		order.setOdrmst_rcity(city);
		order.setOdrmst_rphone(phone);
		order.setOdrmst_raddress(addr);
		order.setOdrmst_rzipcode(zipcode);
		order.setOdrmst_rname(rname);
		/*
		private String odrtmlog_odrid;//订单号
	private String odrtmlog_user;//操作员
	private String odrtmlog_type;//日志操作类型
	private String odrtmlog_oldtxt;//历史记录
	private String odrtmlog_ntxt;//修改记录
		*/
		SimpleDateFormat fm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		order.setOdrmst_internalmemo("修改收货人地址"+muser+fm.format(new Date())+order.getOdrmst_internalmemo());

		if(ordertbl.equals("main")) {
			Tools.getManager(OrderMain.class).update(order, true);
		}
		else if (ordertbl.equals("recent")) {
			Tools.getManager(OrderRecent.class).update(order, true);
		}
	
		out.print("{\"code\":1,message:\"修改收货人成功！\"}");
		return;
	} catch (Exception e) {
		e.printStackTrace();
		out.print("{\"code\":1,message:\"修改收货人失败！\"}");
		return;
	}
}else{
	out.print("{\"code\":1,message:\"修改收货人失败！\"}");
	return;
}

%>