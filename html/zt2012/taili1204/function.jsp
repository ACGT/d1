<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
 static ArrayList<TaiLi2012> getexist(String cardno){
	ArrayList<TaiLi2012> rlist = new ArrayList<TaiLi2012>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("taili2012_cardno",cardno));
	List<BaseEntity> list = Tools.getManager(TaiLi2012.class).getList(clist, null, 0, 1);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((TaiLi2012)be);
	}
	return rlist ;
}
%><%
if(!Tools.isNull(request.getParameter("tailino"))){
	ArrayList<TaiLi2012> list=getexist(request.getParameter("tailino").replace("_4", "_1"));
	if(list!=null && list.size()>0){
		out.print("1");
	}else{
		out.print("0");
	}
	return;
}
%>