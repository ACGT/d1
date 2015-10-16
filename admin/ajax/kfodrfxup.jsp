<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkkfmng.jsp"%>
<%

String odrid = request.getParameter("odrid");
String tmfx = request.getParameter("tmfx");
String imgurl = request.getParameter("imgurl");


if(Tools.isNull(odrid)||Tools.isNull(tmfx)||Tools.isNull(imgurl)){
	out.print("{\"code\":1,message:\"订单号错误或返现金额截图信息不能为空！\"}");
	return;
}

String ordertbl = "main";
OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(odrid);

if(order == null) {
	order = (OrderBase)Tools.getManager(OrderRecent.class).get(odrid);
	ordertbl = "recent";
}
if(order!=null&&order.getOdrmst_tmfxstatus().longValue()==0){

	OdrTmLog otlog =new OdrTmLog();
	String muser=session.getAttribute("kfadmin").toString();
	otlog.setOdrtmlog_odrid(odrid);
	otlog.setOdrtmlog_user(muser);
	otlog.setOdrtmlog_type("修改返现信息");
	String nlog="返现信息："+tmfx+"+上传图片："+imgurl;
	otlog.setOdrtmlog_oldtxt(nlog);
	otlog.setOdrtmlog_ntxt(nlog);
	Tools.getManager(OdrTmLog.class).create(otlog);
	
	
	order.setOdrmst_tmfx(new Float(Tools.parseFloat(tmfx)));
	order.setOdrmst_tmfximg("http://images1.d1.com.cn"+imgurl);
	order.setOdrmst_tmfxstatus(new Long(1));
	SimpleDateFormat fm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	order.setOdrmst_internalmemo("修改返现信息"+muser+fm.format(new Date())+order.getOdrmst_internalmemo());

	if(ordertbl.equals("main")) {
		Tools.getManager(OrderMain.class).update(order, true);
	}
	else if (ordertbl.equals("recent")) {
		Tools.getManager(OrderRecent.class).update(order, true);
	}
	out.print("{\"code\":1,message:\"修改成功！\"}");
	return;

}else{
	out.print("{\"code\":1,message:\"修改失败！\"}");
	return;
}

%>