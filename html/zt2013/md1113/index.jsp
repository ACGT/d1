<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private ArrayList<LotOdrWin> lotwinlist(){
	ArrayList<LotOdrWin> list=new ArrayList<LotOdrWin>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> lotlist= Tools.getManager(LotOdrWin.class).getList(null, olist, 0, 80);
	if(lotlist==null || lotlist.size()==0) return null;
	for(BaseEntity be:lotlist){
		list.add((LotOdrWin)be);
	}
	return list;
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />


<title>双十一网购狂欢节</title>
</head>
<style>
body{ margin:0px; padding:0px;  font-size:12px;}
form{ padding:0px; margin:0px;}
  ul,li,dd,dt,dl{margin:0;padding:0}
.cyhead{
	margin:0 auto;
	background-image: url(http://images.d1.com.cn/zt2013/cj1311/cj11_01_01.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:384px;
}
.cyhead2{
	margin:0 auto;
	background-image: url(http://images.d1.com.cn/zt2013/cj1311/cj11_01_02.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:290px;
}
.bg01{background-image: url(http://images.d1.com.cn/zt2013/cj1311/bg01.jpg);
	background-repeat: no-repeat;
	background-position: left top; }
.hitcj{ width:980px; margin:0 auto; padding-top:50px; height:240px;}


.cjboxt {
	font-family: "微软雅黑";
	color: #FFFFFF;
	font-size: 50px;
	font-weight: bold;
}
.cjboxtxt{font-family: "微软雅黑";
	color: #FFFFFF;
	font-size: 23px;
	font-weight: bold;}
.cjboxbq {font-family: "微软雅黑";color: #f9af3a; font-size:14px;font-weight: bold;}
.cjboxnum{ font-family: "微软雅黑";font-size:60px; color:#fab324;font-weight: bold;}
.cjboxinput{ height:26px;}

.cjboxgdst{ font-size:12px;  color: #ffffff;}
.cjboxgdsp{font-family: "微软雅黑";color: #FFFF00;font-size:16px; }
.lotbutton{float:left;width:100%;text-align:center;margin-bottom:15px;margin-top: 10px;}


#scrollDiv{width:900px;height:235px; margin-top:8px;line-height:21px;overflow:hidden}
#scrollDiv li{height:21px; width:400px;padding-left:25px;color:#525252;text-align:left;float:left;overflow:hidden}

.pstime{margin:0 auto;height:35px; width:320px;padding-left:180px; padding-top:20px;}
.mdodr {
	height: 32px;
	width: 230px;
	line-height:30px;
}
</style>
<script type="text/javascript">
function getodr(obj){
	var orderid=$('#orderid').val();
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/html/zt2013/md1113/myprize.jsp',
		cache: false,
		data: {orderid:orderid},
		error: function(XmlHttpRequest){
			$.alert("免单抽奖出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			$.alert(json.message);
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>
<body>

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_01.jpg" width="980" height="156" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_02.jpg" width="980" height="207" alt=""></td>
	</tr>
	<tr>
		<td height="70" background="http://images.d1.com.cn/zt2013/mh1113/mh1113_03.jpg"><table width="100%" height="70" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="25%">&nbsp;</td>
            <td width="28%"><input name="orderid" id="orderid" type="text" class="mdodr"></td>
            <td width="47%">&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_04.jpg" usemap="#Mapmdcj" width="980" height="61" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_05.jpg" width="980" height="102" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_06.jpg" width="980" height="73" alt=""></td>
	</tr>
	
	<tr>
		<td height="240" background="http://images.d1.com.cn/zt2013/mh1113/mh1113_07.jpg">
<div id="scrollDiv">
              <ul>
              <%
              ArrayList<LotOdrWin> list=lotwinlist();
              if (list!=null)
              {
              for(LotOdrWin be:list){ 
            	  String Lotwin_uid="";
            	  if(be.getLotodrwin_uid().length()>4){
            		  Lotwin_uid=be.getLotodrwin_uid().substring(0,4);
                	  }
                	  else{
                		  Lotwin_uid=be.getLotodrwin_uid();
                	  }

            	double oround=Tools.getDouble(be.getLotodrwin_price(),3);
            	String Lotwin_memo="恭喜"+Lotwin_uid+"**，获得订单"+oround*100+"%免单机会。";
            	if(be.getLotodrwin_flag()!=null&&be.getLotodrwin_flag().longValue()==1){
              %>
              
			  <li><span style="color:#C00000"> <%=Lotwin_memo%></span></li>
      <%}else{ %>
       <li><%=Lotwin_memo%></li>
      <%}} }%>
			  </ul>
              </div>
			  <script>
function AutoScroll(obj){
$(obj).find("ul:first").animate({
marginTop:"-230px"
},288,function(){
//$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	for(i=1;i<=13;i++){
		$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
		}
	$(this).css({marginTop:"0px"})
});
}
$(document).ready(function(){
setInterval('AutoScroll("#scrollDiv")',5000)
});

</script>
</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_09.jpg" width="980" height="108" alt=""></td>
	</tr>
	<tr>
		<td bgcolor="#f0f0f0">
			<% request.setAttribute("code","8996");
		request.setAttribute("length","200");%>
      <jsp:include   page= "gdsrec.jsp"   />

			</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/mh1113/mh1113_11.jpg" width="980" height="75" alt=""></td>
	</tr>
	<tr>
		<td bgcolor="#f0f0f0">
<% request.setAttribute("code","8997");
		request.setAttribute("length","200");%>
      <jsp:include   page= "gdsrec.jsp"   />
			</td>
	</tr>
</table>
<map name="Mapmdcj" id="Mapmdcj">
<area shape="rect" coords="272,6,515,57" href="javascript:getodr(this);" />
</map>

<%@include file="/inc/foot.jsp"%>
</body>
</html>
