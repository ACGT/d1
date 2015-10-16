<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="/inc/islogin.jsp" %>
<%!
ArrayList<Profileinfo> getProfile(String mbrid){
	  ArrayList<Profileinfo> rlist = new ArrayList<Profileinfo>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("profile_mbrid",mbrid));
		
		List<BaseEntity> list = Tools.getManager(Profileinfo.class).getList(clist, null, 0, 1);
		if(list==null||list.size()==0)return null;	
		for(BaseEntity be:list){
			Profileinfo pp = (Profileinfo)be;
				rlist.add(pp);
			}
		return rlist ;
}
%>
<%
String height=request.getParameter("height");
String weight=request.getParameter("weight");
String color=request.getParameter("color");
String category=request.getParameter("category");
String xw=request.getParameter("xw");
String yw=request.getParameter("yw");
String shoessize=request.getParameter("shoessize");
String money=request.getParameter("money");
if(!Tools.isNull(color)){
	color=","+color;
}
if(!Tools.isNull(category)){
	category=","+category;
}
ArrayList<Profileinfo> plist= getProfile(lUser.getId());
if(plist!=null){
	Profileinfo pinfo=plist.get(0);
	pinfo.setProfile_shoesize(shoessize);
	pinfo.setProfile_category(category);
	pinfo.setProfile_color(color);
	pinfo.setProfile_height(height);
	pinfo.setProfile_money(money);
	pinfo.setProfile_weight(weight);
	pinfo.setProfile_xw(xw);
	pinfo.setProfile_yw(yw);
	if(Tools.getManager(pinfo.getClass()).update(pinfo, true)){
		out.print("{\"success\":true,\"message\":\"保存成功！\"}");
		return;
	}
	out.print("{\"success\":false,\"message\":\"保存失败！\"}");
	return;
}else{
	Profileinfo pinfo=new Profileinfo();
	pinfo.setProfile_shoesize(shoessize);
	pinfo.setProfile_xw(xw);
	pinfo.setProfile_yw(yw);
	pinfo.setProfile_category(category);
	pinfo.setProfile_color(color);
	pinfo.setProfile_date(new Date());
	pinfo.setProfile_height(height);
	pinfo.setProfile_mbrid(lUser.getId());
	pinfo.setProfile_money(money);
	pinfo.setProfile_weight(weight);
	pinfo=(Profileinfo)Tools.getManager(pinfo.getClass()).create(pinfo);
	if(!Tools.isNull(pinfo.getId())){
		out.print("{\"success\":true,\"message\":\"保存成功！\"}");
		return;
	}
	out.print("{\"success\":false,\"message\":\"保存失败！\"}");
	return;
}
%>