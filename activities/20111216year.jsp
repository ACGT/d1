<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
static ArrayList<SecKill> getTodayProduct(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.le("mstjgds_starttime", new Date()));
	listRes.add(Restrictions.ge("mstjgds_endtime", new Date()));
	//listRes.add(Restrictions.eq("mstjgds_state", new Long(1)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("mstjgds_sort"));
	List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((SecKill)be);
	}
	 return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>十重大礼贺新年 2012决战到底！满300元狂返200元-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/activities/ref.js")%>" charset="utf-8"></script>
<script type="text/javascript">
//限时抢购
var the_s=new Array();

function $getid(id)
{
    return document.getElementById(id);
}

function view_time(the_s_index,objid){

    if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index])/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        //if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) {$("#h").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#m").text(the_M);}
        $("#s").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";

    }
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="1801" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_01.gif" width="980" height="116" alt=""/></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_02.jpg" width="980" height="154" alt=""/></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_03.jpg" width="980" height="141" alt=""/></td>
	</tr>
	<tr>
		<td rowspan="3">
		<a href="http://www.d1.com.cn/zhuanti/20111220zyhk/" target="_blank">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_04.jpg" width="300" height="449" alt=""/></a></td>
		<td colspan="8">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_05.jpg" width="387" height="167" alt=""/></td>
		<td rowspan="3"><a href="http://www.d1.com.cn/jifen/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_06.gif" alt="" width="293" height="449" border="0" /></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_07.jpg" width="161" height="37" alt=""/></td>
		<td colspan="2" width="45" align="center" valign="top"  style=" background: url(http://images.d1.com.cn/zt2011/20111219lndq/xnsc_08.jpg) no-repeat left top;">
			 <span id="h" style="font-size: 24px;font-weight:bold;width:45px;color:white;">12</span></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_09.jpg" width="22" height="37" alt=""/></td>
		<td width="38" align="center" valign="top"  style=" background: url(http://images.d1.com.cn/zt2011/20111219lndq/xnsc_10.jpg) no-repeat left top;">
			 <span id="m" style="font-size: 24px;font-weight:bold;width:38px;color:white;">12</span></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_11.jpg" width="21" height="37" alt=""/></td>
		<td width="40" align="center" valign="top"  style=" background: url(http://images.d1.com.cn/zt2011/20111219lndq/xnsc_12.jpg) no-repeat left top;">
			<span id="s" style="font-size: 24px;font-weight:bold;width:40px;color:white;">12</span></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_13.jpg" width="60" height="37" alt=""/></td>
	</tr>
	<% 
	 ArrayList<SecKill> list=getTodayProduct();
    if(list!=null && list.size()>0){
        	SecKill ms2=list.get(0);
        	  java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
              String	nowtime= df.format(new Date());
            String tttime =df.format(ms2.getMstjgds_endtime());
             //String tttime ="2011/12/20 00:00:00";
              java.util.Calendar c1=java.util.Calendar.getInstance();
   			java.util.Calendar c2=java.util.Calendar.getInstance();
   			try
   			{
   			c1.setTime(df.parse(nowtime));
   			c2.setTime(df.parse(tttime));
   			}catch(java.text.ParseException e){
   			System.err.println("格式不正确");
   			}
   			int result=c1.compareTo(c2);
   			if(result==0)
   			System.out.println("c1相等c2");
   			else if(result<0)
   			System.out.println("c1小于c2");
   			else
   			System.out.println("c1大于c2");
   			if(result<0){
   			 int tjjs=1; %>
   			   <span class=time id=tjjs_1></span>
   <script language=javascript>
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
the_s[<%=tjjs%>]=(endDate.getTime()-startDate.getTime())/1000;setInterval("view_time(<%=tjjs%>,'tjjs_<%=tjjs%>')",1000);</script>
   <% }}
        	%>
	<tr>
		<td colspan="8">
			<a href="limittime.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_14.jpg" alt="" width="387" height="245" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_15.jpg" width="980" height="27" alt=""/></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/zhuanti/20111215xnzp/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_16.jpg" alt="" width="489" height="293" border="0"/></a></td>
		<td colspan="7">
		<a href="http://www.d1.com.cn/zhuanti/20111219sjdc/index.jsp" target="_blank">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_17.jpg" width="491" height="293" alt=""/></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/zhuanti/20111216sp/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_18.jpg" alt="" width="489" height="301" border="0"/></a></td>
		<td colspan="7">
		<a href="http://www.d1.com.cn/zhuanti/20111220NanRenBang/" target="_blank">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_19.jpg" width="491" height="301" alt=""/></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/zhuanti/20111214bag/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_20.jpg" alt="" width="489" height="319" border="0"/></a></td>
		<td colspan="7">
		<a href="http://www.d1.com.cn/zhuanti/20111219WQC/index.jsp" target="_blank">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xnsc_21.jpg" width="491" height="319" alt=""/></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="300" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="161" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="28" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="17" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="22" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="38" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="21" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="40" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="60" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/分隔符.gif" width="293" height="1" alt=""/></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>