<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加评论</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/admin/comments/del.js"></script>
<script type="text/javascript">
function getsku(gdsid){
	if($.trim(gdsid).length==8){
	  var   dllSub=$("#gdssku");
		$.ajax({
	      type: "GET",
	      url: "/admin/comments/getsku.jsp",
	      data: "gdsid="+gdsid,
	      success: function(data){
	          if (data != -1){
	        	  dllSub.empty();
	        	  $("<option value='-1'>==请选择==</option>").appendTo(dllSub);
	              var subject = data.split(",");
	              $.each(subject, function(){
	                  var opt = this.split("|");
	                  $("<option value=" + opt[0] + ">" + opt[1] + "</option>").appendTo(dllSub);
	              });
	             
	              $("#div1").show();
	            
	          }else{
	        	  dllSub.empty();
	        	  $("#theight").val('');
	        	  $("#tweight").val('');
	        	  $("#iscomp").val("-1");
	              $("#div1").hide();
	             
	          }
	      },error: function(request, settings){
	    	  dllSub.empty();
	    	
	      }
	  });
	}
	

}
function checksku(){
	
	var gdssku=$("#gdssku").val();
	
	if(gdssku!=null && gdssku!='undefined'){
		if(gdssku=="-1"){
			alert("请选择SKU");
			return false;
		}
		
	}
	return true;
}
function checkweight(){
	
	var gdssku=$("#gdssku").val();
	var weight=$.trim($("#tweight").val());
	if(gdssku!=null && gdssku!='undefined'){
		if(weight.length==0){
			alert("请输入体重");
			return false;
		}
	}
	return true;
}
function checkheight(){
	var gdssku=$("#gdssku").val();
	var height=$.trim($("#theight").val());
	if(gdssku!=null && gdssku!='undefined'){
		if(height.length==0){
			alert("请输入身高");
			return false;
		}
	}
	return true;
}
function checkuid(){
	var uid=$.trim($("#uid").val());
	if(uid.length==0){
		alert("请输入用户名");
		return false;
	}
	return true;
}
function checkcontent(){
	var content=$.trim($("#content").val());
	if(content.length==0){
		alert("请输入评论内容");
		return false;
	}
	return true;
}
function c(){
	if(!checksku()){return false;}
	else if(!checkweight()){return false;}
	else if(!checkheight()){return false;}
	else if(!checkuid()){return false;}
	else if(!checkcontent()){return false;}
	else return true;
}

function check(){
	//alert(111);
	if(c()){
		$("#form1").submit();
	}
}
</script>
</head>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "addcomment");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date rdate = new Date(System.currentTimeMillis()-(long)(1*Tools.WEEK_MILLIS*Math.random())); 

if("post".equals(request.getMethod().toLowerCase())){
	String pid = request.getParameter("pid");
	String uid = request.getParameter("uid");
	String content = request.getParameter("content");
	String cdateStr = request.getParameter("cdate");
	String sku=request.getParameter("gdssku");
	String height=request.getParameter("theight");
	String weight=request.getParameter("tweight");
	String comp=request.getParameter("iscomp");
	
	try{
	Date cdate = sdf.parse(cdateStr);
	if(cdate.after(new Date())){
		out.print("评论时间必须小于当前时间！");
	}else{
	if(pid!=null&&uid!=null&&content!=null){
		 Comment comment=new Comment();
		 comment.setGdscom_odrid("");//order id
		 
		 comment.setGdscom_mbrid(new Long(request.getParameter("userlevel")));
		 comment.setGdscom_uid(uid);
		 
		 comment.setGdscom_gdsid(pid);
		 
		 Product product = (Product)Tools.getManager(Product.class).get(pid);
		 comment.setGdscom_gdsname(product.getGdsmst_gdsname());
		 comment.setGdscom_content(content);
		 comment.setGdscom_createdate(cdate);
		 comment.setGdscom_status(new Long(1));
		 comment.setGdscom_level(new Long(request.getParameter("level")));
		 comment.setGdscom_operator("");
		 comment.setGdscom_replydate(null);
		 comment.setGdscom_checkStatue(new Long(0));
		 comment.setGdscom_replyContent("");
		 comment.setGdscom_replyStatus(new Long(0));
		 comment.setGdscom_pic1("");
		 comment.setGdscom_pic2("");
		 comment.setGdscom_pic3("");
		 comment.setGdscom_comp(comp);
		 comment.setGdscom_height(height);
		 comment.setGdscom_sku1(sku);
		 comment.setGdscom_weight(weight);
		 Tools.getManager(Comment.class).create(comment);
		 
		 if(comment.getId()!=null){
			 out.println(comment.getId()+"<br/>");
		 }
	}
	}
	}catch(Exception ex){
		out.print("插入错误，有可能为时间格式错误，请检查后重新填写！");
	}
	

}


%>
<body>
<div><a href="deletecomment.jsp" target="_blank">删除评论</a></div>
<form method=post id="form1">
商品ID：<input type=text name="pid"  onblur="getsku(this.value)"/><br/>
评价日期：<input type=text name="cdate" value="<%=sdf.format(rdate)%>"/>(保持这个格式)<br/>
用户名：<input type=text name="uid" id="uid"/><br/>
会员级别：<select name="userlevel">
		<option value="-1">普通会员</option>
		<option value="-2">VIP会员</option>
		<option value="-3">白金VIP</option>
	</select><br/>
评分：<select name="level">
		<option value="5">5</option>
		<option value="4">4</option>
		<option value="3">3</option>
	</select><br/>
<div id="div1" style="display:none;">
尺码：<select name="gdssku"  id="gdssku"></select><br/>	
身高：<input type=text name="theight" id="theight" />cm<br/>	
体重：<input type=text name="tweight" id="tweight" />kg<br/>	
是否合适：<select name="iscomp" >
		<option value="1">合适</option>
		<option value="2">偏大</option>
		<option value="3">偏小</option>
	</select><br/>
</div>	

评价内容：<input type=text name="content" id="content"/><br/>
<input type="button" value="提交" onclick="check();"/>
</form>
</body>
</html>