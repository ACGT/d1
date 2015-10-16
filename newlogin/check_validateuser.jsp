<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%><%@include file="/inc/islogin.jsp"%><%!
static ArrayList<User>  getByUserMail(String email){
			if(Tools.isNull(email)) return null;
			ArrayList<User> list=new ArrayList<User>();
			List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			listRes.add(Restrictions.eq("mbrmst_email", email));
			listRes.add(Restrictions.eq("mbrmst_mailflag", new Long(1)));
			List<BaseEntity> list2 = Tools.getManager(User.class).getList(listRes, null, 0, 10);
			if(list2==null || list2.size()==0){
				return null;
			}
			
			for(BaseEntity be:list2){
				list.add((User)be);
			}
			return list;
}
			%><%
String act = request.getParameter("act");
if("is_email".equals(act)){//检查Email
	String email = request.getParameter("email");
	if(email!= null && email.length()<64){
		if(Tools.isEmail(email)){
			ArrayList<User> list= getByUserMail(email);
			if(list!=null){
				for(User u:list){
					if(u.getId().equals(lUser.getId())){
						out.print("2");
						return;
					}else{
						out.print("1");
						return;
					}
					
				}
				
			}else{
				out.print("2");
				return;
			}
			
		}
	}
	out.print("0");
}else if("is_code".equals(act)){//检查验证码
	String code = request.getParameter("code");
	if(!Tools.isNull(code) && code.length() == 4){
		String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
		if(code.equals(vImageCode)){
			out.print("true");
			return;
		}
	}
	out.print("false");
}else if("is_tel".equals(act)){//检查手机号
	String tel = request.getParameter("tel");
	if(!Tools.isNull(tel)){
		if(Tools.isMobile(tel)){
		User user=UserHelper.getByUserPhone(tel);
			if(user==null){
				out.print("1");
				return;
			}else{
				if(user.getId().equals(lUser.getId())){
					out.print("1");
					return;
				}else{
					out.print("2");
					return;
				}
				
			}
			
		}
	}
	out.print("0");
}
%>