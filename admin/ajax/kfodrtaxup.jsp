<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkkfmng.jsp"%>
<%

String odrid = request.getParameter("odrid");
String tatflag = request.getParameter("tatflag");
String taxtit = request.getParameter("taxtit");
String taxtxt = request.getParameter("taxtxt");
String memo = request.getParameter("memo");
String imgurl = request.getParameter("imgurl");


if(Tools.isNull(odrid)||(tatflag.equals("1")&& (Tools.isNull(taxtit)||Tools.isNull(taxtit)))){
	out.print("{\"code\":1,message:\"订单号错误或发票信息不能为空！\"}");
	return;
}

String ordertbl = "main";
OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(odrid);

if(order == null) {
	order = (OrderBase)Tools.getManager(OrderRecent.class).get(odrid);
	ordertbl = "recent";
}
if(order!=null){
	OdrTmTxt  otmt=(OdrTmTxt)Tools.getManager(OdrTmTxt.class).findByProperty("odrtmtxt_odrid", odrid);
    boolean isup=false;
    String otit="";
    String otxt="";
	if(otmt!=null){
		isup=true;
		    otit=otmt.getOdrtmtxt_taxtitle();
		    otxt=otmt.getOdrtmtxt_taxtxt();
	}
	String muser=session.getAttribute("kfadmin").toString();
	OdrTmLog otlog =new OdrTmLog();

	otlog.setOdrtmlog_odrid(odrid);
	otlog.setOdrtmlog_user(muser);
	otlog.setOdrtmlog_type("修改发票信息");
	String nlog="发票状态："+tatflag+"+发票头："+taxtit+"+发票内容："+taxtxt;
	String olog="发票状态："+order.getOdrmst_taxflag()+"+发票头："+otit
			+"+发票内容："+otxt;
	otlog.setOdrtmlog_oldtxt(olog);
	otlog.setOdrtmlog_ntxt(nlog);
	Tools.getManager(OdrTmLog.class).create(otlog);
	/*
	private String odrtmtxt_odrid;//订单号
		private String odrtmtxt_taxtitle;//发标抬头
		private String odrtmtxt_taxtxt;//发标内容
		private String odrtmtxt_tupimg;//退款上传截图
		private String odrtmtxt_user;//操作员
		private String odrtmtxt_update;//更新时间
	*/
	
	if(Tools.parseInt(tatflag)==1){
		if(!isup){
			otmt=new OdrTmTxt();
		}
	otmt.setOdrtmtxt_odrid(odrid);
	otmt.setOdrtmtxt_taxtitle(taxtit);
	otmt.setOdrtmtxt_taxtxt(taxtxt);
	otmt.setOdrtmtxt_user(muser);
	otmt.setOdrtmtxt_update(new Date());
	if(isup){
	Tools.getManager(OdrTmTxt.class).update(otmt, false);
	}else{
	Tools.getManager(OdrTmTxt.class).create(otmt);
	}
	order.setOdrmst_taxflag(Tools.parseLong(tatflag));
	}
	SimpleDateFormat fm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if(!Tools.isNull(memo)){
		memo="<font color=red>"+memo+"</font>";
	}
	order.setOdrmst_internalmemo(memo+"修改发票信息"+muser+fm.format(new Date())+order.getOdrmst_internalmemo());
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