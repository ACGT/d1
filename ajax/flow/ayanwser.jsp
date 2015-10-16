<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%!

//获取今日问题
static ArrayList<AYQuestion> getTodayQuestion(){
	ArrayList<AYQuestion> list=new ArrayList<AYQuestion>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("questionFlag", new Long(1)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("qviewTime"));
	List<BaseEntity> list2 = Tools.getManager(AYQuestion.class).getList(listRes, listOrder, 0, 30);
	if(list2==null || list2.size()==0){
		return null;
	}
	
	for(BaseEntity be:list2){
		AYQuestion q=(AYQuestion)be;
		String s=Tools.getDate(new Date());
		String e=Tools.getDate(q.getQviewTime());
		if(s.equals(e)){
			list.add(q);
		}
		
	}
	return list; 
}
//判断是否已参加
boolean isexist(Long qid,String mbrid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("answer_mbrid", mbrid));
	listRes.add(Restrictions.eq("answer_qid", qid));
	List<BaseEntity> list2 = Tools.getManager(AYAnswer.class).getList(listRes, null, 0, 1);
	if(list2==null || list2.size()==0){
		return false;
	}
	return true;
}
%>
<%
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2012-08-13 00:00:00";
if(df.parse(end).before(new Date())){
	out.print("{\"code\":1,\"message\":\"该活动已结束！\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
String content=request.getParameter("answercontent");
if(Tools.isNull(content)){
	out.print("{\"code\":1,\"message\":\"请填写答案！\"}");
	return;
}

ArrayList<AYQuestion> qlist= getTodayQuestion();
if(qlist!=null && qlist.size()>0){
	AYQuestion q=qlist.get(0);
	if(isexist(new Long(q.getId()),lUser.getId())){
		out.print("{\"code\":1,\"message\":\"您今天已参加过该活动！\"}");	
	}else{
		AYAnswer answer=new AYAnswer();
		answer.setAnswer_content(content);
		answer.setAnswer_createdate(new Date());
		answer.setAnswer_mbrid(lUser.getId());
		answer.setAnswer_uid(lUser.getMbrmst_uid());
		answer.setAnswer_qid(new Long(q.getId()));
		Tools.getManager(AYAnswer.class).create(answer);
		out.print("{\"code\":1,\"message\":\"参加今日竞猜活动成功！\"}");
	}
	
	
}else{
	out.print("{\"code\":1,\"message\":\"问题不存在！\"}");
}



//out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
return;
%>