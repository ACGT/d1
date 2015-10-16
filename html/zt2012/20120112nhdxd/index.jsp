<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<SecKill> getTodayProduct(){
	ArrayList<SecKill> list=new ArrayList<SecKill>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.gt("id","188"));
	//listRes.add(Restrictions.le("mstjgds_starttime", new Date()));
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
static ArrayList<ProductGroup> getProductGroups(){
	ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("tgrpmst_state", new Long(1)));
	clist.add(Restrictions.ge("tgrpmst_priority", new Long(6)));
	clist.add(Restrictions.le("tgrpmst_priority", new Long(11)));
	clist.add(Restrictions.lt("tgrpmst_starttime", new Date()));
	clist.add(Restrictions.ge("tgrpmst_endtime", new Date()));
	
	//加入排序条件，按加入购物车时间排序
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("tgrpmst_priority"));
	olist.add(Order.desc("id"));
	List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 6);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((ProductGroup)be);
	}
	return rlist ;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚年惠大行动-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">

var lasttime=0;

function view_time2(){

    if(lasttime>0){
        var the_D=Math.floor((lasttime/3600)/24)
        var the_H=Math.floor(lasttime/3600);
        var the_M=Math.floor((lasttime-the_H*3600)/60);
        var the_S=(lasttime-the_H*3600)%60;
        //if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) {$("#h").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#m").text(the_M);}
        $("#s").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        lasttime--;
    }else{
    	//window.location.reload(true);

    }
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
 <%
 String img="";
 String	nowtime="";
 String tttime="";
 String url="http://www.d1.com.cn/";
 String content="";
    ArrayList<SecKill> list=getTodayProduct();
    if(list!=null && list.size()>0){
    	for(int i=0; i<list.size();i++){
    		SecKill ms=list.get(i);
        	Product product=ProductHelper.getById(ms.getMstjgds_gdsid())  ; 
        	if(product!=null){
        		img=ms.getMstjgds_picstr().trim();
        		 url="/product/"+product.getId();
                  java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                  nowtime= df.format(new Date());
                 tttime =df.format(ms.getMstjgds_endtime());
                 content=ms.getMstjgds_memo();
        	}
    	}
    }
%>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_01.jpg" width="980" height="116" alt=""/></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_02.jpg" width="980" height="138" alt=""/></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_03.jpg" width="980" height="126" alt=""/></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_04.jpg" width="980" height="134" alt=""/></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_05.jpg" width="980" height="19" alt=""/></td>
	</tr>
	<tr>
		<td rowspan="4">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_06.jpg" width="9" height="444" alt=""/></td>
		<td colspan="4" rowspan="4" bgcolor="#8A0601"> <a href="<%=url %>" target="_blank"> <img src="<%=img%>"></img></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_08.jpg" width="272" height="122" alt=""/></td>
	</tr>
	<tr>
		<td height="79" background="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_09.jpg">
		<div style="margin-top:15px; margin-left:40px;">
		<div style="float:left; width:40px;"><span id="h" style="color:#FFFFFF; font-size:30px; font-weight:bold; ">0</span></div>
		<div style="float:left; margin-left:40px; width:40px;"><span id="m" style="color:#FFFFFF; font-size:30px; font-weight:bold">0</span></div>
		<div style="float:left; margin-left:40px; width:40px;"><span id="s" style="color:#FFFFFF; font-size:30px; font-weight:bold">0</span></div>

		</div>
		 <script language=javascript>
		var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
		 lasttime=(endDate.getTime()-startDate.getTime())/1000;
		//alert(lasttime);
		setInterval(view_time2,1000);</script>
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_10.jpg" width="272" height="29" alt=""/></td>
	</tr>
	<tr>
		<td height="214" bgcolor="#8A0601" valign="top">
		<div style="margin-left:40px; margin-right:30px; margin-top:0px; color:#FFFFFF;text-align:left;">
		<span style="font-size:15px; font-weight:bold; line-height:30px; ">推荐理由：</span><br/>
		<span style="line-height:26px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %></span>
		</div>
		
		</td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_12.jpg" width="980" height="113" alt=""/></td>
	</tr>
	
	<tr>
		<td colspan="6" bgcolor="#FDEFEC">
		 <%
    	
    		ArrayList<ProductGroup> pplist= getProductGroups();
		 String imgurl="";
    	if(pplist!=null && pplist.size()>0){%>
    		<table  border="0" cellspacing="0" cellpadding="0" >
    		
    		<%for(int i=0;i<pplist.size();i++){
    			ProductGroup pproduct=pplist.get(i);
    			if(!Tools.isNull(pproduct.getTgrpmst_actimg())){
    				imgurl=pproduct.getTgrpmst_actimg().trim();
    			}
    			if((i+1)%3==1){
    				%>
    				<tr>
    				<td width="8"></td>
    			<%}%>
    			<td width="316"><a href="/tuan/tuandetail.jsp?ID=<%=pproduct.getId() %>" target="_blank"><img src="<%=imgurl %>" border="0"></img></a></td><td width="5"></td>
    		<%if((i+1)%3==0){%>
    		</tr>
    		<%}}%>
    		
    		</table>
    		<%
    	}
    	
    %>
		</td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_19.jpg" width="980" height="102" alt=""/></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/sales/salesviews.jsp?id=92" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_20.jpg" alt="" width="489" height="196" border="0"/></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/sales/salesviews.jsp?id=183" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_21.jpg" alt="" width="491" height="196" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/sales/salesviews.jsp?id=143" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_22.jpg" alt="" width="489" height="190" border="0"/></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/sales/salesviews.jsp?id=211" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_23.jpg" alt="" width="491" height="190" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/zhuanti/20120111NZQC/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_24.jpg" alt="" width="489" height="188" border="0"/></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/sales/salesviews.jsp?id=212" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_25.jpg" alt="" width="491" height="188" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/zhuanti/20120111DZQC/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_26.jpg" alt="" width="980" height="142" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/zhuanti/20120111DZQC/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_27.jpg" alt="" width="980" height="180" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_28.jpg" width="980" height="103" alt=""/></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/nhdxd_29.jpg" width="980" height="96" alt=""/></td>
	</tr>
	<tr>
		<td colspan="6"><% request.setAttribute("code","7358");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/分隔符.gif" width="9" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/分隔符.gif" width="320" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/分隔符.gif" width="160" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/分隔符.gif" width="163" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/分隔符.gif" width="56" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20120113nhdxd/分隔符.gif" width="272" height="1" alt=""/></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>