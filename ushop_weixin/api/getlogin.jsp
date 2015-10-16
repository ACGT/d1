<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%!
public static long getUseScoreshop(String mbrid,String shopcode) {
	ArrayList<UsrPoint> list = getUserScoreInfoshop(mbrid,shopcode);
	long realsocre=0;
	if(list!=null){
		for(UsrPoint userScore:list){
			if(userScore.getUsrpoint_score()!=null && (userScore.getUsrpoint_score().longValue() != 0)){
				realsocre+=userScore.getUsrpoint_score().longValue();
			}
		}
		
	}
	return realsocre;
}
public static ArrayList<UsrPoint> getUserScoreInfoshop(String mbrid,String shopcode){
	ArrayList<UsrPoint> rlist = new ArrayList<UsrPoint>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrpoint_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrpoint_shopcode",shopcode));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.desc("usrpoint_createdate"));
	List<BaseEntity> list = Tools.getManager(UsrPoint.class).getList(clist, olist, 0, 1000);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UsrPoint)be);
	}
	return rlist ;
}
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
}else{
	String showmsg = Tools.getCookie(request,"showmsg");
	json.put("status", "1");
	String uid=lUser.getMbrmst_uid();
	if((uid.endsWith("@@weixin")||uid.endsWith("@pingan")||uid.endsWith("@@Alipay"))&&lUser.getMbrmst_name().trim()!=null&&lUser.getMbrmst_name().trim().length()>0)
	{
		uid=lUser.getMbrmst_name().trim();
	}
	if(!Tools.isNull(showmsg) && uid.endsWith("caibei") && lUser.getMbrmst_name().trim().equals("QQ彩贝")){
		uid=URLDecoder.decode(showmsg,"GBK");
	}else if(!Tools.isNull(showmsg)  && lUser.getMbrmst_name().trim().equals("QQ登录用户")){
		uid=URLDecoder.decode(showmsg,"GBK");
		
	}else if(!Tools.isNull(showmsg) && (uid.endsWith("@51fanli") || uid.endsWith("xunlei") || uid.endsWith("@user360"))){
		uid=URLDecoder.decode(showmsg,"GBK");
	}
	json.put("username", uid.trim());
	if(!Tools.isNull(request.getParameter("u"))){
		json.put("userscore", (int)(getUseScoreshop(lUser.getId(),"14031201")));
		int utype=lUser.getMbrmst_specialtype().intValue();
		String typen="普通会员";
		if(utype!=0){
			 
	        	UserVip uv=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
	        	if(uv!=null){
	        		typen="白金VIP";
	        		utype=2;
	        	}else{
	        		typen="VIP";
	        		utype=1;
	        	}
		}
		json.put("usertype", typen);
		json.put("utype", utype);
	}
}
out.print(json);
%>