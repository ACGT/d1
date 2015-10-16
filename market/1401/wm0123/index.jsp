<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>服饰体验券-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function gettkt(flag){
                $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "gettkt.jsp",
                        data:{flag:flag},
    
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
<style>
.topbanner {
	background-image: url(http://images.d1.com.cn/zt2012/0123peifei/images/topbanner.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:750px;

}
.topbannerdiv{	position:relative; width:980px; height:110px; margin: 0px auto;padding-top:638px;}
.link1{ position:absolute;  width:300px; height:110px; bottom:0; left:150px; }
.link2{ position:absolute;  width:300px; height:110px; bottom:0; left:510px; }
</style>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->

<div style="background:#FCDCDF">
<div class="topbanner">
<div class="topbannerdiv" >
<a href="javascript:gettkt('1');" ><span class="link1"> 
</span></a>
<a href="javascript:gettkt('2');" ><span class="link2"> 
</span></a>
</div>
</div>
<center>
<table id="__01" width="980"   border="0" cellpadding="0" cellspacing="0"  >
	<tr>
		<td colspan="5"><a href="http://www.d1.com.cn/product/01518304?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_01.jpg" alt="" width="488" height="553" border="0"></a></td>
		<td colspan="4"><a href="http://www.d1.com.cn/product/01205421?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_02.jpg" alt="" width="492" height="553" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_03.jpg" width="980" height="115" alt=""></td>
	</tr>
	<tr>
		<td><a href="http://www.d1.com.cn/product/01517547?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_04.jpg" alt="" width="336" height="430" border="0"></a></td>
		<td colspan="5"><a href="http://www.d1.com.cn/product/05001203?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_05.jpg" alt="" width="345" height="430" border="0"></a></td>
		<td colspan="3"><a href="http://www.d1.com.cn/product/01518254?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_06.jpg" alt="" width="299" height="430" border="0"></a></td>
	</tr>
	<tr>
		<td><a href="http://www.d1.com.cn/product/01205420?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_07.jpg" alt="" width="336" height="464" border="0"></a></td>
    <td colspan="5"><a href="http://www.d1.com.cn/product/01516814?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_08.jpg" alt="" width="345" height="464" border="0"></a></td>
		<td colspan="3"><a href="http://www.d1.com.cn/product/01517028?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_09.jpg" alt="" width="299" height="464" border="0"></a></td>
	</tr>
		<tr>
		<td colspan="9">
			
<%request.setAttribute("code", "9152");
  request.setAttribute("length", "100");
  %>
  	 <jsp:include   page= "/html/gdsrec2013.jsp"   />
</td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_10.jpg" width="980" height="115" alt=""></td>
	</tr>
	<tr>
		<td colspan="4"><a href="http://www.d1.com.cn/product/01512997?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_11.jpg" alt="" width="466" height="420" border="0"></a></td>
		<td colspan="5"><a href="http://www.d1.com.cn/product/01505433?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_12.jpg" alt="" width="514" height="420" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2"><a href="http://www.d1.com.cn/product/03300029?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_13.jpg" alt="" width="354" height="474" border="0"></a></td>
		<td colspan="5"><a href="http://www.d1.com.cn/product/01517903?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_14.jpg" alt="" width="328" height="474" border="0"></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/product/01417542?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_15.jpg" alt="" width="298" height="474" border="0"></a></td>
	</tr>
		<tr>
		<td colspan="9">
			
<%request.setAttribute("code", "9153");
  request.setAttribute("length", "100");
  %>
  	  <jsp:include   page= "/html/gdsrec2013.jsp"   />
</td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_16.jpg" alt="" width="980" height="147"></td>
	</tr>
	<tr>
		<td colspan="3"><a href="http://www.d1.com.cn/product/02008175?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_17.jpg" alt="" width="394" height="202" border="0"></a></td>
		<td colspan="5"><a href="http://www.d1.com.cn/product/03000376?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_18.jpg" alt="" width="292" height="202" border="0"></a></td>
		<td><a href="http://www.d1.com.cn/product/01517687?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_19.jpg" alt="" width="294" height="202" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3"><a href="http://www.d1.com.cn/product/03003477?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_20.jpg" alt="" width="394" height="206" border="0"></a></td>
		<td colspan="5"><a href="http://www.d1.com.cn/product/01517890?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_21.jpg" alt="" width="292" height="206" border="0"></a></td>
		<td><a href="http://www.d1.com.cn/product/01205288?tj=mq1401qrj" target="_blank"><img src="http://images.d1.com.cn/zt2012/0123peifei/images/0123peifei_22.jpg" alt="" width="294" height="206" border="0"></a></td>
	</tr>

	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="336" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="18" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="40" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="72" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="22" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="193" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="4" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0123peifei/images/&#x5206;&#x9694;&#x7b26;.gif" width="294" height="1" alt=""></td>
	</tr>
</table>
</center>
</div>
<%@include file="/inc/foot.jsp"%>
</body>
</html>