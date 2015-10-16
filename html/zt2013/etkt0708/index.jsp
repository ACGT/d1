<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>服饰体验券-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>
<%if(session.getAttribute("wapurl_flag")==null){%>
if(checkMobile()){
	window.location.href="http://m.d1.cn/wap/etkt.html";
}
<%}%>
</script>
<script type="text/javascript">
function gettkt(){
                $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "gettkt.jsp",
                        success: function(json) {
                           if (json.urlflag){

                              $.alert(json.message,'提示',function(){
                                        this.location.href="/newlogin/valitel.jsp";
                                });
                                }else{
                                $.alert(json.message);
                                }
                        }

                        });
        }
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2013/etktimg.jpg"  alt=""  usemap="#Mapgettkt" >
			<map name="Mapgettkt" id="Mapgettkt"><area shape="rect" coords="502,144,819,296" href="javascript:gettkt();" />
			</td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>