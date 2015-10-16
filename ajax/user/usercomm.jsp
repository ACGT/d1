<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<%
if(lUser==null||!lUser.getMbrmst_uid().trim().equals("gjltest")) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String content = request.getParameter("ccontent");
String cdateStr = request.getParameter("cdate");
String pid = request.getParameter("pid"); 
try{
	Date cdate = sdf.parse(cdateStr);
	if(cdate.after(new Date())){
		out.print("{\"code\":1,\"message\":\"评论时间必须小于当前时间！\"}");
		return;
	}else{
	if(pid!=null&&content!=null){
		Random rndcard = new Random();
		User mbr=null;
		for(int i=0;i<50;i++){
		String mid=9999+rndcard.nextInt(3899797)+"";
		mbr=UserHelper.getById(mid);
		if(mbr!=null&&mbr.getMbrmst_uid().trim().length()<15&&mbr.getMbrmst_finishdate()!=null)break;
		}
		String uid=mbr.getMbrmst_uid();
		long userlevel=-1;
		if(mbr.getMbrmst_specialtype().longValue()==1){
			UserVip uv=(UserVip)Tools.getManager(UserVip.class).get(mbr.getId());
			if(uv==null){
				userlevel=-2;
			}else{
				userlevel=-3;
			}
		}
		 Comment comment=new Comment();
		 comment.setGdscom_odrid("");//order id
		 
		 comment.setGdscom_mbrid(new Long(userlevel));
		 comment.setGdscom_uid(uid);
		 
		 comment.setGdscom_gdsid(pid);
		 
		 Product product = (Product)Tools.getManager(Product.class).get(pid);
		 comment.setGdscom_gdsname(product.getGdsmst_gdsname());
		 comment.setGdscom_content(content);
		 comment.setGdscom_createdate(cdate);
		 comment.setGdscom_status(new Long(1));
		 comment.setGdscom_level(new Long(5));
		 comment.setGdscom_operator("");
		 comment.setGdscom_replydate(null);
		 comment.setGdscom_checkStatue(new Long(0));
		 comment.setGdscom_replyContent("");
		 comment.setGdscom_replyStatus(new Long(0));
		 comment.setGdscom_pic1("");
		 comment.setGdscom_pic2("");
		 comment.setGdscom_pic3("");
		 comment.setGdscom_comp("");
		 comment.setGdscom_height("");
		 comment.setGdscom_sku1("");
		 comment.setGdscom_weight("");
		 Tools.getManager(Comment.class).create(comment);
		 
		 if(comment.getId()!=null){
			 out.print("{\"code\":0,\"message\":\"添加成功！\"}");
				return;
		 }
	}else{
		out.print("{\"code\":1,\"message\":\"评论添加错误ID或内容不能为空！\"}");
		return;
	}
	}
	}catch(Exception ex){
		out.print("{\"code\":1,\"message\":\"插入错误，有可能为时间格式错误，请检查后重新填写！\"}");
		return;
	}
%>