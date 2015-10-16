<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
static ArrayList<SecKill> getTodayProduct(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.le("id","171"));
	listRes.add(Restrictions.le("mstjgds_starttime", new Date()));
	listRes.add(Restrictions.ge("mstjgds_endtime", new Date()));
	//listRes.add(Restrictions.eq("mstjgds_state", new Long(1)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("mstjgds_sort"));
	List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0, 9);
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
<title>24小时特价限时抢-D1优尚</title>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="cache-control: no-cache, no-store, must-revalidate "/>
<meta http-equiv="expires" content="wed, 26 feb 1997 08:21:57 gmt"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="/activities/limit.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/activities/ref.js")%>" charset="utf-8"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
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
       $("#h").text(the_H);
        $("#m").text(the_M);
        $("#s").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        the_s[the_s_index]--;
    }else{
    	window.location.reload(true);

    }
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);  %>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
  <%
    ArrayList<SecKill> list=getTodayProduct();
    if(list!=null && list.size()>0){
    	for(int i=0; i<list.size();i++){
    		SecKill ms=list.get(i);
        	Product product=ProductHelper.getById(ms.getMstjgds_gdsid())  ; 
        	SecKill ms2=list.get(0);
        	if(product!=null){
        		 
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
       		if(i==0){
       			
       		
    	%>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_01.jpg" width="980" height="163" alt=""/></td>
	</tr>
	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_02.jpg" width="980" height="140" alt=""/></td>
	</tr>
	<tr>
		<td align="left">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_03.jpg" width="353" height="65" alt=""/></td>
		<td  width="52" valign="top" align="center" style=" background: url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_04.jpg) no-repeat left top;">
			  <div align="center" style="font-size: 30px;width:50px"><span id="h" style="font-weight:bold;width:50px;color:white">0</span></div></td>
		<td  align="left" width="26">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_05.jpg" width="26" height="65" alt=""/></td>
		<td  width="44" valign="top" style=" background: url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_06.jpg) no-repeat left top;">
			 <div align="center" style="font-size: 30px; width:44px;"><span id="m" style="font-weight:bold;color:white">0</span></div></td>
		<td  align="left" width="28">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_07.jpg" width="28" height="65" alt=""/></td>
		<td  width="44" valign="top" style=" background: url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_08.jpg) no-repeat left top;">
			 <div align="center" style="font-size: 30px; width:44px;"><span id="s" style="font-weight:bold;color:white">0</span></div></td>
		<td colspan="2" align="left" width="433">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_09.jpg" width="433" height="65" alt=""/></td>
	</tr>
	<% if(result<0){
			 int tjjs=1; %>
			    <span class=time id=tjjs_1></span>
   <script language=javascript>
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
the_s[<%=tjjs%>]=(endDate.getTime()-startDate.getTime())/1000;setInterval("view_time(<%=tjjs%>,'tjjs_<%=tjjs%>')",1000);</script>
    <%}
    		
    	%>
    		<tr>
		
    <td  colspan="8" align="left" valign="top">
   <table width="100%"  border="0" cellpadding="0" cellspacing="0">
   <tr>
    <td width="558px" align="center" style="vertical-align:top; height:385px; background: url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_10.jpg) no-repeat;">
     <div style="position:relative;padding-left:40px; padding-top:15px;overflow:hidden;">
    <ul id="photoList">

    <li><a href="/product/<%=product.getId()%>" target="_blank"><img src="<%=ProductHelper.getImageTo400(product) %>" id="bigPhoto"  width="335" height="335" alt="" /></a></li>
    </ul>
</div>
    </td>
   <td width="422px" align="left" style="vertical-align:top;height:385px;background:url(http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_11-2.jpg) no-repeat left top;">

<div class="mingx" >
            <a href="/product/<%=product.getId()%>" target="_blank"><h2><%=Tools.clearHTML(product.getGdsmst_gdsname()) %></h2></a>
            <dl style="width:350px">
                <dt>推荐理由：</dt>
                <dd style="line-height:19px; height:90px;width:350px;"><%=ms.getMstjgds_memo() %></dd>
               
            </dl>
        </div>
       
         <div class="gus" style="padding-right:20px;">
         <table width="100%">
          <tr>
           <td> <dl>
         <dd style="height:2px">&nbsp;</dd>
         <dd style="margin-left:20px; margin-top:10px;"><strike style="color:red">市场价：<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue()) %>元 &nbsp; 会员价：<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue()) %>元</strike></dd>

                <dd style="margin-left:20px;height:35px;"><span class="hotj">抢购价：<%=ProductGroupHelper.getRoundPrice(ms.getMstjgds_tjprice().floatValue()) %>元</span></dd>
            </dl></td>
            <td align="right" valign="bottom">
       <%
 if(ms.getMstjgds_count().intValue()>=ms.getMstjgds_maxcount() || ms.getMstjgds_state().intValue()!=1){
	 %>
	
	 <img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/btn_jqqd_03.jpg"></img>
 <%}else{ %>
  <a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);">
	 <img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/btn_jqqd_02.jpg"></img></a>
  <%}
%>
            </td>
          </tr>
         </table>
        
        </div>	
        
        
        <div style="margin-bottom:15px; padding-top:8px;padding-left:30px;">
         <div style="float:left;width:200px; margin-top:1px;_margin-top:12px;"> <a href="<%=ms.getMstjgds_picurl()%>" target="_blank"><img src="<%=ms.getMstjgds_picstr() %>"  /></a></div>
      <div style="float:left;margin-left:20px; margin-top:15px;"> <a href="<%=ms.getMstjgds_picurl()%>" target="_blank"><span style="font-size:16px;font-weight:bold">查看更多产品>></span></a></div>
       
       
        </div>

    </td>
   </tr>
   </table>
   
   </td>
   
   </tr>

	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_13.jpg" width="980" height="1" alt=""/></td>
	</tr>
   <% }
else{
if(i==1){%>
<tr>
		<td colspan="8">
<div id="activeProductsArea" class="tab-list" >
	<table border="0" cellspacing="0" cellpadding="0" >
	<%}
 if(i%4==1){%>
	  <tr><td width="25px">&nbsp;</td>
 <%}
%>
<td width="235" height="338" class="item-td"><div class="item-box">
<a href="/product/<%=product.getId()%>" target="_blank">
<img src="http://images.d1.com.cn<%=product.getGdsmst_imgurl() %>" class="photo" alt="<%=Tools.clearHTML(product.getGdsmst_gdsname()) %>" />
<h3><%=Tools.clearHTML(product.getGdsmst_gdsname()) %></h3>

</a>
<p>
市场价：￥<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice()) %>
<span class="gray">抢购价：￥<%=ProductGroupHelper.getRoundPrice(ms.getMstjgds_tjprice()) %></span><br />会员价：￥<%=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice()) %>
</p>
<% 
 if(ms.getMstjgds_count().intValue()>=ms.getMstjgds_maxcount() || ms.getMstjgds_state().intValue()!=1){
	 %>
	 	
	 <img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/qianggou_31_02.jpg"/></img>
 <%}else{ %>
 <a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);">
	 <img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/qianggou_31.jpg"></img></a>
  <%}
%>

</div></td>
 <% if(i%4==0){%>
	<td width="30px">&nbsp;</td></tr>
 <%}%>

<%}
if(i==list.size()-1 && i!=0){%>
</table>
</div>
</td></tr>
<%}}}} %>
	<tr>
		<td colspan="8">
			<img src="http://images.d1.com.cn/zt2011/20111219lndq/xsq/xsq_12.jpg" width="980" height="50" alt=""/></td>
	</tr>
	<tr>
		<td colspan="8">
<div id="activeProductsArea" class="tab-list" >
	<table border="0" cellspacing="0" cellpadding="0" >
	<tr>
	 <td>
	 	<% request.setAttribute("code","7248");
		request.setAttribute("length","50");%>
		<jsp:include   page= "gdssrm.jsp"   />
	 </td>
	</tr>
	</table>
	</div>
	</td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>

</body>
</html>