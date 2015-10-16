<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include file="/inc/islogin.jsp"%><%

String id = (String)session.getAttribute("FindPassword");

FindPassword fp = FindPasswordHelper.getById(id);
//无权限
if(fp == null || !fp.getSelf_mbruid().equals(lUser.getId())){
	response.sendRedirect("/user/");
	return;
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——重置密码</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/user/regist.js")%>"></script>
<script type="text/javascript">
function is_pwd(v){
	if(v.length < 6 || v.length>14){
		$("#pass_Notice").html("密码长度必须为6-14位").addClass('red');
		return false;
    }else if(/ /.test(v) == true){
    	$("#pass_Notice").html("密码中不能包含空格").addClass('red');
    	return false;
    }else{
        $("#pass_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
        return true;
    }
}
function issame(){
	var pwd=$("#password").val();
	var repwd=$("#password2").val();
	if(pwd!=repwd){
		$("#pass2_Notice").html("两次输入密码不一致").addClass('red');
		return false;
	}else{
		  $("#pass2_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
		  return true;
	}
}

function user_update(){
	var pwd=$("#password").val();
	var repwd=$("#password2").val();
	if(is_pwd(pwd) && issame()){
		$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/ajax/user/resetpwd.jsp",
            cache: false,
            data:{
		        pwd: pwd,
		        repwd:repwd
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
                $.alert('修改密码失败！');
            },success: function(strRet){
            	//alert(strRet);
            	 if(strRet==-1){$.alert('您没有权限进行操作或操作超时，请重新进行找回密码操作！');}
            	 else if(strRet==-2){$.alert('新密码格式错误，密码长度6-14位，支持数字、符号、字母！');}
            	 else if(strRet==-3){$.alert('两次输入新密码不一致！');}
            	 else if(strRet==-4){$.alert('原密码不能为空！');}
            	 else if(strRet==0){$.alert('重置密码失败！请稍后再试！');}
            	 else if(strRet==1){$.alert('重置密码成功！');top.location.href="/user/";}

            }
            }
		)
	}
	
}
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
 <!--右侧-->

   <div class="mbr_right">

       <div class="updatepwd">

            <form name="form_update" id="form_update" action="/user/changepassword.jsp?act=update" method="post" onsubmit="return false;">
		  
	        <table border="0" cellspacing="0" cellpadding="0" class="t_update">

			    <tr>

				    <td colspan="3" height="10">

					 

					</td>

				</tr>

			    <tr>

				    <td colspan="3">

					   <font color="#8b2d3d" style=" font-size:15px;"><b>&nbsp;&nbsp;修改密码</b>

					</td>

				</tr>

				 <tr>

				    <td  style="text-align:right;">请输入新密码：</td><td><input type="password" name="password" id="password" onfocus="pass_focus();" onblur="is_pwd(this.value);" maxlength="14" /></td>
				    <td>&nbsp;<span id="pass_Notice"></span></td>

				</tr>

				 <tr>

				    <td style="text-align:right;">请在此输入新密码：</td><td><input type="password" name="password2" id="password2" onfocus="pass2_focus();" onblur="issame();" maxlength="14"/></td>
				    <td>&nbsp;<span id="pass2_Notice" ></span></td>

				</tr>

				<tr height="10">

				    <td></td><td><font color="#c2c2c2">密码长度6-14位，请正确填写</font></td><td></td>

				</tr>

				<tr>

				    <td colspan="3" style=" height:10px;"></td>

				</tr>

				<tr height="10">

				    <td></td><td>
				    <a href="javascript:void(0);" onclick="user_update();"><img style=" border:none; width:61px; heihgt:26px;" src="http://images.d1.com.cn/images2012/New/user/sure.jpg"></img></a>
				  
				    </td><td></td>

				</tr>

			</table>
             </form>
	   </div>

	</div>

  
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>



