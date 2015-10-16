<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
String txt_shopname = request.getParameter("txt_shopname");
String txt_password = request.getParameter("txt_password");
String url = request.getParameter("url");

if(Tools.isNull(url)) url = "/";

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(false));
map.put("redirect" , url);

if(Tools.isNull(txt_shopname)){
	map.put("message","请输入用户名！");
	out.print(JSONObject.fromObject(map));
	return;
}
if(Tools.isNull(txt_password)){
	map.put("message","请输入登录密码！");
	out.print(JSONObject.fromObject(map));
	return;
}
//开始认证。

ShopReg shopusr=(ShopReg)Tools.getManager(ShopReg.class).findByProperty("shopreg_name", txt_shopname);
if(shopusr == null){
	map.put("message","商户名或密码不正确！");
	out.print(JSONObject.fromObject(map));
	return;
}
if(shopusr != null&&1!=shopusr.getShopreg_type().longValue()){
	map.put("message","商户名或密码不正确！");
	out.print(JSONObject.fromObject(map));
	return;
}

//System.err.println(user.getMbrmst_passwd()+"--"+MD5.to32MD5(txt_password,"UTF-8"));

  if(!MD5.to32MD5(txt_password).equals(shopusr.getShopreg_pwd())){
	map.put("message","密码不正确！");
	out.print(JSONObject.fromObject(map));
	return;
}
	session.setAttribute("dfadmin", shopusr.getShopreg_name());
	session.setAttribute("dfshopcode", shopusr.getShopreg_shopcode());
	if(session.getAttribute("type_flag")!=null){
		session.removeAttribute("type_flag");
	}
//登录成功处理。
//LoginLogHelper.createLog(user);
map.put("redirect","/admin/dfmng");
	
map.put("success",new Boolean(true));
map.put("message","登录成功！");

out.print(JSONObject.fromObject(map));
%>