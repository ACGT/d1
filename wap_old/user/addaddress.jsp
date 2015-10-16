<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%  
	String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
	backurl=backurl.replace("#", "");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—添加收货人地址</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/wap.js")%>"></script>

</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>收货地址簿
    <br/>
    </div>
    <div id="first" style=" margin-top:2px; line-height:18px;">
    <input type="hidden" id="hdnMbrcstID" value="0" />
    		<input type="hidden" id="MbrcstAction" value="new_save_consignee" />
	     填写收货信息：<br/>
	    第1步/共3步<br/>
	    <span id="provtip" style="color:red; display:none;"></span>
	   &nbsp;<font color='red'>*</font>&nbsp;省/直辖市
	  <select id="ddlProvince"  onchange="ChangeProv(this)">
							<option value="0">==请选择==</option>
						</select>
						<br/>
						
		<input type="button" value="下一步" onclick="operation('2')" style="width:65px; padding:4px;">&nbsp;&nbsp;<a href="<%=backurl %>"  style=" text-decoration:underline">返回上一步</a>
		</div>				
		<div id="second" style=" margin-top:2px; line-height:18px; display:none;">
		 填写收货信息：<br/>
	           第2步/共3步<br/>
		<span id="citytip" style="color:red; display:none;"></span>
		&nbsp;<font color='red'>*</font>&nbsp;县/市/区 <select id="ddlCity" onchange="CheckCity()">
            <option value="">==请选择==</option>
        </select><br/>
        <input type="button" value="下一步" onclick="operation('3')" style="width:65px; padding:4px;">&nbsp;&nbsp;<a href="javascript:void(0)" onclick="operation('1')" style=" text-decoration:underline">返回上一步</a>
        </div>
        
        <div id="third" style=" margin-top:2px; line-height:18px; display:none;"> 
                 填写收货信息：<br/>
	       第3步/共3步<br/>
	       <table>
	       <tr><td>&nbsp;<font color='red'>*</font>&nbsp;收货人：</td><td><input type="text" id="txtName" onblur="CheckName()"/>
	                   <br/><span id="spanName"  style="color:#e53333;display:none"></span>
	       </td></tr>
	        <tr><td>&nbsp;<font color='red'>*</font>&nbsp;详细地址：</td><td><input type="text" id="txtRAddress" onblur="CheckRAddress()"/>
	             <br/>
	        </td></tr>
	         <tr><td> &nbsp;<font color='red'>*</font>&nbsp;邮政编码：</td><td><input type="text" id="txtRZipcode" maxlength="6"  onblur="CheckRZipcode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
	                  <br/><span id="spanRZipcode"  style="color:#e53333;display:none"></span>
	         </td></tr>
	          <tr><td>&nbsp;<font color='red'>*</font>&nbsp;手机号码：</td><td><input type="text" id="txtRPhone" onblur="CheckRPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
	                    <br/><span id="spanRPhone"  style="color:#e53333;display:none"></span>
	          </td></tr>
	           <tr><td>&nbsp;<font color='red'>*</font>&nbsp;邮箱</td><td><input type="text" id="txtREmail" maxlength="40"  onblur="CheckREmail()"/>
	                     <br/><span id="spanREmail"  style="color:#e53333;display:none"></span>
	            </td></tr>
	           <tr><td>&nbsp;固定电话：</td><td><input type="text" id="txtTelePhone" onblur="CheckTelePhone()" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')"/>
	                     <br/> <span id="spanTelePhone"  style="display:none"></span>
	           </td></tr>
	           
	                </table>
	      <span id="erroinfo"></span>
        <input type="button" value="提&nbsp;交" onclick="AddMbrcst_wap('new_save');"   style="width:65px; padding:4px;">&nbsp;&nbsp;<a href="javascript:void(0)" onclick="operation('2')" style=" text-decoration:underline">返回上一步</a>
       
        
       
        </div>
         
         
         
          <div id="info" style=" margin-top:2px; line-height:18px; display:none;"> </div>        
	  
 
   
</div>

 <script type="text/javascript">BindProvince();</script>

<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->
</body>
</html>
<script>
   function operation(flag)
   {
	   switch(flag)
	   {
	   case '1':
		   {
			   $("#first").css("display","block");
			   $("#second").css("display","none");
			   $("#third").css("display","none");
			   break;
		   }
	   case '2':
		   {
		   if($('#ddlProvince').val()=='')
		   {
			  
			   $('#provtip').html("请选择省份！");
			   $('#provtip').css("display","block");
			   break;
		   }
		   else
			   {
			       $('#provtip').css("display","none");
				   $("#first").css("display","none");
				   $("#second").css("display","block");
				   $("#third").css("display","none");
				   break;
			   }
		   }
	   case '3':
		   {
		   if($('#ddlCity').val()=='')
		   {
			   $('#citytip').html("请选择城市！");
			   $('#citytip').css("display","block");
			   break;
		   }
		   else
			   {
			       $('#citytip').css("display","none");
				   $("#first").css("display","none");
				   $("#second").css("display","none");
				   $("#third").css("display","block");
				   break;
			   }
		   }
		   default:
			   {
			   $("#first").css("display","block");
		   $("#second").css("display","none");
		   $("#third").css("display","none");
		   break;
			   }
	   }
   }
   

</script>

