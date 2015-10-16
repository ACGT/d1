<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
    private ArrayList<Bademail> getEmaillistByemail(String email)
    {
	   if(Tools.isNull(email)||email.length()<=0||!email.contains("@")) return null;
	   ArrayList<Bademail> rlist = new ArrayList<Bademail>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("email", email));
		List<BaseEntity> list = Tools.getManager(Bademail.class).getList(clist, null, 0, 100);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Bademail)be);
		}
		return rlist;
    }
%>
<%
if("post".equals(request.getMethod().toLowerCase())){//邮件退订
	String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
	String vCode = request.getParameter("code");
	if(vCode == null || vImageCode ==null || !vImageCode.equals(vCode)){
		Tools.outJs(out,"验证码输入错误，请重试！","back");
		return;
	}
	String email = request.getParameter("email");
	if(email != null) email = email.trim();
	if(!Tools.isEmail(email)){
		Tools.outJs(out,"邮箱地址格式有误，请修改","back");
		return;
	}
	ArrayList<Bademail> blist=getEmaillistByemail(email);
	if(blist!=null&&blist.size()>0)
	{
		//out.print("<script>alert(\"该邮箱已经退订接收邮件！\");return;</script>");
		Tools.outJs(out, "该邮箱已经退订接收邮件！", "back");
		return;
	}
	
	Bademail be=new Bademail();
	be.setEmail(email);
	be.setCreatedate(new Date());
	be=(Bademail)Tools.getManager(Bademail.class).create(be);
	if(be!=null)
	{
		Tools.outJs(out, "退订邮件成功！", "http://www.d1.com.cn");
	}
	
	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-邮件退订</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css">
.center{ width:770px; margin:0px auto; padding:10px; font-size:15px; line-height:25px; color:#333; padding-bottom:30px;}

</style>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
      <center>
      <div id="add" style="width:756px; height:433px; margin-top:20px; font-size:14px; color:#000; background:url('http://images.d1.com.cn/images2012/index2012/JULY/yjtd.jpg');">
        <form method="post" action="/html/bademail.jsp">
		<input TYPE="hidden" NAME="act" value="badmailadd">
		<table width="756" height="433">
		<tr><td height="190" colspan="2"></td></tr>		
		<tr><td align="right" width="325" height="40">请输入您的Email：</td><td align="left"><input type="text" name="email" id="email" onblur="is_emails(this.value);">&nbsp;&nbsp;<span id="email_Notice" style="color:#f00;"></span></td></tr>
		<tr><td align="right" height="40">*验证码：</td><td align="left"><input type="text" name="code" id="code" onblur="is_codes(this.value);" maxlength="4" style="width:118px;" />&nbsp;&nbsp;<img id="vPic" style="vertical-align:bottom;cursor:pointer;" width="60" height="24" onclick="this.src='/ImageCode?r='+Math.random();" alt="点击刷新验证码" />&nbsp;<span>看不清，&nbsp;<a href="###" onclick="$('#vPic').attr('src','/ImageCode?r='+Math.random());" title="点击刷新验证码" style="color:#0016aa;">换一张</a></span>&nbsp;<span id="code_Notice" style="color:#f00; "></span></td></tr>
		<tr><td height="50" colspan="2"></td></tr>
		<tr><td height="40" colspan="2" align="center"><input type="submit" value="   " style="width:122px; height:37px; border:none;background:url('http://images.d1.com.cn/images2012/index2012/JULY/suresubmit.jpg');" ></td></tr>	
		<tr><td colspan="2"></td></tr> 
		
		</table>
			
		</form>
         
      </div>
   
      
		

    </center>
   <div class="clear"></div>
    <!--尾部-->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束-->
</body>
</html>
		<script type="text/javascript">	
		function is_emails(v){
			if (v == ''){
		    	$("#email_Notice").html("邮箱地址不能为空，请输入").addClass('red');
		    	return;
			}
			if (!isEmail(v)){
				$("#email_Notice").html("邮箱地址格式有误，请修改").addClass('red');
				return;
			}
			$("#email_Notice").html("");
		}
		function is_codes(v){
			if(v==""){
				$("#code_Notice").html("验证码不能为空！").addClass('red');
		    	return;
			}
			if(v.length!=4 || !/^[0-9]{4}/.test(v)){
				$("#code_Notice").html("验证码输入错误！").addClass('red');
		    	return;
			}
			$("#code_Notice").html("");
		}
		$(function(){
			setTimeout(function(){$('#email').focus();},500);
			$('#vPic').attr('src','/ImageCode?r='+Math.random());
		});
       </script>