<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%@include file="/admin/public.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>日志汇总</title>
<style type="text/css">
  div{ font-size:14px; color:#aa44bb; line-height:25px;}
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  span{ color:#f00;}
  td{border-bottom:solid 1px #999999;border-right:solid 1px #999999; text-align:center;}
</style>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script language="javascript" type="text/javascript">
function Search(){
	var s=$('#s').val();
	var e=$('#e').val();
	var reg=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/;     
	if(s.length>0){	
		if(!s.match(reg))
		{        
			alert("对不起，您输入的起始时间格式不正确，请重新输入！");
			$('#s').val('');
			$('#s').focus();
			return false; 
		}	    
	}
	if(e.length>0){	
		if(!e.match(reg))
		{        
			alert("对不起，您输入的结束时间格式不正确，请重新输入！");
			$('#e').val('');
			$('#e').focus();
			return false; 
		}	    
	}
	$('#form1').submit();
}
</script>
</head>
<body style="padding-left:10px; background:#fff;">
<form id="form1" name="form1" method="post" action="getdata.jsp" target="right">
<div >
<br/>
<br/>
<br/>
         请输入时间范围：<br/>
       <input type="text" name="s" id="s"/><br/>
       至<br/>
       <input type="text" id="e" name="e"/><br/>
    <font style="color:#f00; font-size:16px; ">(注：时间格式为：2012-01-01)</font>
    <br/>
       <input type="button" id="btnsearch" value="查 询" onclick="Search();"/><br/><br/>

   
</div>
</form>
</body>
</html>




