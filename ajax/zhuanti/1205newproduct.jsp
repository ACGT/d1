<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static int getlovelength(String loveno,String userid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("userid", userid));
	return Tools.getManager(Userlove.class).getLength(listRes);
	
}
%>
<%

SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	   	 dStartDate =fmt.parse("2012-06-10");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("5");
}	
String loveno=request.getParameter("loveno");
String ischeck=request.getParameter("ischeck");
String content=request.getParameter("tcontent");
String pid=request.getParameter("productid");
if(Tools.isNull(loveno)){
	out.print("0");
	return;
}
if(!Tools.isNumber(loveno)){
	out.print("0");
	return;
}
if(lUser == null){
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog("/html/zt2012/1205newproduct/index.jsp");<%
}else{
	int len=getlovelength(loveno,lUser.getId());
	if(len>=2){
		out.print("1");
	}else{
		if(Tools.isNull(ischeck)){
			out.print("2");
		}else{
			Userlove love=new Userlove();
			love.setLoveno(new Long(loveno));
			love.setLovecontent(content);
			love.setUserid(lUser.getId());
			love.setCreatedate(new Date());
			love.setProductid(pid);
			love=(Userlove)Tools.getManager(Userlove.class).create(love);
			if(love!=null){
				out.print("3");
			}else{
				out.print("4");
			}
		}
		
	}
}
%>