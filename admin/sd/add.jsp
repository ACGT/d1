<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>添加晒单</title>
<script src="/res/js/jquery-1.3.2.min.js"></script> 
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("upload.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/swfobject.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/jquery.uploadify.v2.1.4.js")%>"></script>
<script type="text/javascript">

</script>

</head>
<body>

<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "addshoworder");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date rdate = new Date(System.currentTimeMillis()-(long)(1*Tools.MONTH_MILLIS*Math.random())); 

%>
 <input type="hidden" value="" id="hw" />
	<input type="hidden" value="" id="hh" />
	<input type="hidden"  value="" id="himgurl" />
商品ID：<input type=text id="showgdsid" name="pid"  onblur="getsku(this.value)"/><br/>
用户名：<input type=text name="uid" id="uid"/><br/>
内容：<input type=text name="content" id="tcontent"/><br/>

晒单日期：<input type=text id="cdate" name="cdate" value="<%=sdf.format(rdate)%>"/>(保持这个格式)<br/>
<div style="float:left; ">晒单图片：</div>

<div id="fileQueue" class="sctpk" style="float:left; ">
        	 <input type="file" name="uploadify" id="uploadify" /> 
      		</div>
      		<div id="divshowmsg" style="float:left;padding-left:25px; display:none;"> 
      		<a id="aimg" target="_blank">
      		<img id="testimgs" style="display:block;border:none;" src="" /></a>
        	
		  </div>
		<div style="clear:both;height:20px;">&nbsp;</div>
		<input type="button" value="提交" onclick="cmtshoworder();"/>

</body>
</html>