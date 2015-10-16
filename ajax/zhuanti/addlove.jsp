<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<script type="text/javascript">
function keypress(tcontent){
	var tcontentvalue=$.trim($(tcontent).val());
	var len=0;
	$("#snum").html(tcontentvalue.length);
}
function checklen(){
	var tcontent=$.trim($("#tcontent").val());
	var len=tcontent.length;
	if(len>100){
		 $.alert('超过字数限制 ！');
	}else{
		var loveno=$("#loveno").val();
		var pid=$("#pid").val();
		$.ajax({
		    type: "post",
		    dataType: "text",
		    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		    url: "/ajax/zhuanti/1205newproduct.jsp",
		    cache: false,
		    data:{
		   	 loveno:loveno,ischeck:1,tcontent:tcontent,productid:pid
		      },error: function(XmlHttpRequest, textStatus, errorThrown){
		    },success: function(msg){
		    	 if(msg==0){
		    		 $.alert('参数错误！');
		    	 }else  if(msg==1){
		    		 $.alert('每个用户只能喜欢2款！');
		    	 }else  if(msg==3){
		    		 $.alert('添加成功！','提示',function(){
		    			 window.location.href="/html/zt2012/1205newproduct/index.jsp";
		    		 }
		    		 );
		    	 }else  if(msg==3){
		    		 $.alert('添加失败！');
		    	 }
		    	
		    }
		    }
		)
	}
}
</script>
<div style="padding:20px; font-size:12px; ">
<table >
<tr><td colspan="2">
<%
String loveno="";
if(!Tools.isNull(request.getParameter("loveno"))){
loveno=request.getParameter("loveno");	
}
String pid="";
if(!Tools.isNull(request.getParameter("productid"))){
	pid=request.getParameter("productid");	
}
%>

<input type="hidden" id="loveno" value="<%=loveno%>"/>
<input type="hidden" id="pid" value="<%=pid%>"/>
<textarea class="txtcontent" name="tcontent" id="tcontent" style=" width:420px; height:100px; border:solid 1px #acacac; " onkeydown='if (this.value.length>=100){event.returnValue=false}' onkeyup="keypress(this)"></textarea></td></tr>
<tr><td colspan="2" height="10px"></td></tr>
<tr><td><span style="color:red;" id="snum">0</span>/100</td><td align="right"><a href="###" onclick="checklen();"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/submit.jpg"/></a></td></tr>
</table>
</div>
