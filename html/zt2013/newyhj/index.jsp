<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private ArrayList<LotWinAct> lotwinlist(){
	ArrayList<LotWinAct> list=new ArrayList<LotWinAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> lotlist= Tools.getManager(LotWinAct.class).getList(null, olist, 0, 50);
	if(lotlist==null || lotlist.size()==0) return null;
	for(BaseEntity be:lotlist){
		list.add((LotWinAct)be);
	}
	return list;
}

private static ArrayList<LotCon> getLotCon(){
	ArrayList<LotCon> list=new ArrayList<LotCon>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotcon_winid", new Long(4)));
	//olist.add(Order.desc("id"));
	List<BaseEntity> mxlist= Tools.getManager(LotCon.class).getList(clist, null, 0,2);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((LotCon)be);
	}
	
	List<SimpleExpression> clist2 = new ArrayList<SimpleExpression>();
	clist2.add(Restrictions.eq("lotcon_flag", new Long(0)));
	clist2.add(Restrictions.ne("lotcon_winid", new Long(4)));
	//olist.add(Order.desc("id"));
	List<BaseEntity> mxlist2= Tools.getManager(LotCon.class).getList(clist2, null, 0,19);
	if(mxlist2==null || mxlist2.size()==0) return null;
	for(BaseEntity be:mxlist2){
		list.add((LotCon)be);
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


<title>新年大礼包</title>
</head>

<script type="text/javascript">
var wd=window.screen.width;
function gettkt(){
	 <%
	 if(lUser==null){
	 %>
	 $.close(); 	Login_Dialog();
			<%}else{
				
			%>
	$.close(); 
	var cardno=$('#tktcardno').val();
	var s3="";if((typeof c)!="undefined"){s3="?c="+encodeURIComponent(c);}else{s3=""+document.location;s3=s3.replace("http://","");s3=s3.substring(s3.indexOf("/"));s3="?c="+encodeURIComponent(s3);}$.load('优惠券刮开提示',450,'/html/zt2013/newyhj/gettkt.jsp?cardno='+cardno+'');
			<%
			}%>
}
if(wd<800){
	   window.location ='http://m.d1.cn/wap/nyeartkt/index.jsp ';
}

</script>
<body>

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table id="__01" width="980" height="646" border="0" cellpadding="0" cellspacing="0"  align="center">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1231/jihuo-980_01.gif" width="980" height="168" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1231/jihuo-980_02.gif" width="980" height="140" alt=""></td>
	</tr>
	<tr>
		<td height="45" background="http://images.d1.com.cn/zt2013/1231/jihuo-980_03.gif"><table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
		  <tr>
          
		    <td width="56%">&nbsp;</td>
		    <td width="21%">
		      <input type="text" name="tktcardno" style="width:180px;height:35px; line-height:32px;"  id="tktcardno">
	       </td>
		    <td width="11%"><input type="image" name="imageField" onclick="gettkt();" id="imageField" src="http://images.d1.com.cn/zt2013/1231/jihuo-980_03_2.gif"></td>
		    <td width="12%">&nbsp;</td>
	      </tr>
	    </table> </td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1231/jihuo-980_04.gif" width="980" height="152" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1231/jihuo-980_05.gif" width="980" height="141" alt=""></td>
	</tr>
</table>

<%@include file="/inc/foot.jsp"%>
</body>
</html>
