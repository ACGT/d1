<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/html/public.jsp"%>
<%
	String actindex_name = request.getParameter("actindex_name");
	if(Tools.isNull(actindex_name)){
		out.print("{\"code\":0,message:\"请您填写专题名称！\"}");
		return;
	}
	String actindex_subad = request.getParameter("actindex_subad");
	if(Tools.isNull(actindex_subad)){
		out.print("{\"code\":0,message:\"请您填写subad！\"}");
		return;
	}
	String actindex_gourl = request.getParameter("actindex_gourl");
	String actindex_content = request.getParameter("actindex_content");
	if(Tools.isNull(actindex_content)){
		out.print("{\"code\":0,message:\"请您填写专题内容！\"}");
		return;
	}
	String actindex_areatbgcolor = request.getParameter("actindex_areatbgcolor");
	String actindex_areatcolor = request.getParameter("actindex_areatcolor");
	String actindex_areatitle = request.getParameter("actindex_areatitle");
	if(actindex_areatbgcolor.equals("0")){
		actindex_areatbgcolor="ffffff";	
	}
	if(actindex_areatcolor.equals("0")){
		actindex_areatcolor="ffffff";	
	}
	if(!check_url(actindex_content)&&!("13100902").equals(session.getAttribute("shopcodelog").toString())){
		  out.print("{\"code\":0,message:\"您所要保存的内容存在外链，请修改后保存！！\"}");
		  return;
	}
	
	//专题内容取出所有的a链接进行替换后保存（做到页面判断）
    //actindex_content = GetSubadContent(actindex_content,actindex_subad);
	String actindex_adduser = request.getParameter("actindex_adduser");
	if(Tools.isNull(actindex_adduser)){
		out.print("{\"code\":0,message:\"请您填写添加人！\"}");
		return;
	}
	String actindex_dectype=request.getParameter("actindex_dectype");
	String user_id = request.getSession().getAttribute("shopcodelog").toString();
	String id = request.getParameter("id");
	ActIndex act_list = null;
	if(id != null){
		act_list = (ActIndex)Tools.getManager(ActIndex.class).get(id);
	}else{
		act_list = new ActIndex();
	}
	//System.out.println("==============="+actindex_name);
	act_list.setActindex_name(actindex_name);
	act_list.setActindex_subad(actindex_subad); 
	act_list.setActindex_gourl(actindex_gourl);
	act_list.setActindex_areatbgcolor(actindex_areatbgcolor);
	act_list.setActindex_areatcolor(actindex_areatcolor);
	act_list.setActindex_areatitle(actindex_areatitle);
	try {  
		act_list.setActindex_dectype(Long.parseLong(actindex_dectype));
	} catch(NumberFormatException e){            
		e.printStackTrace();            
		System.out.println("这个字符串不能转化成Long型的。");        
	}
	act_list.setActindex_content(actindex_content);
	act_list.setActindex_adduser(actindex_adduser);
	
	if(null != id){
		act_list.setId(id);
		if(Tools.getManager(ActIndex.class).update(act_list, true)){
			out.print("{\"code\":1,message:\"更新成功！\"}");
		    return;
		}else{
			out.print("{\"code\":0,message:\"更新失败，请稍后重试！\"}");
		    return;
		}
	}else{
		act_list.setActindex_delflag(new Long(0));
		act_list.setActindex_shopcode(user_id);
		act_list.setActindex_createdate(new Date());
		Tools.getManager(ActIndex.class).create(act_list);
		out.print("{\"code\":1,message:\"添加成功！\"}");
	}

%>