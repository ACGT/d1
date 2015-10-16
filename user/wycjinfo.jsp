<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><%!
private ArrayList<LotWinAct> lotwinlist(String mbrid){
	ArrayList<LotWinAct> list=new ArrayList<LotWinAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotwin8zn_mbrid",Tools.parseLong(mbrid)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> lotlist= Tools.getManager(LotWinAct.class).getList(clist, olist, 0, 50);
	if(lotlist==null || lotlist.size()==0) return null;
	for(BaseEntity be:lotlist){
		list.add((LotWinAct)be);
	}
	return list;
}
ArrayList<Wyhfcj> getwycjInfo(String mbrid){
	ArrayList<Wyhfcj> list=new ArrayList<Wyhfcj>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wycjinfo_mbrid", mbrid));
	//clist.add(Restrictions.eq("wycjinfo_gdsid", gdsid));
	List<BaseEntity> mxlist= Tools.getManager(Wyhfcj.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	
	for(BaseEntity be:mxlist){
		list.add((Wyhfcj)be);
	}
	return list;
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——中奖信息</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("../res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("../res/js/user/regist.js")%>"></script>

</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
 <!--右侧-->

   <div class="mbr_right">
   <div style="width:768px; border:#c2c2c2 solid 1px; background-color:#f6f6f6; padding-top:15px;
       font-size:13px;  color:#333; font-weight:bold; heihgt:auto; padding-bottom:20px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="9%">&nbsp;</td>
           <td width="91%"> <font color="#8b2d3d" style=" font-size:15px;"><b>&nbsp;&nbsp;中奖信息</b></td>
         </tr>
         
         <tr>
           <td>&nbsp;</td>
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td >兑换码</td>
               <td >抽奖时间</td>
               <td >有效期</td>
             </tr>
              <%
              ArrayList<Wyhfcj> list=getwycjInfo(lUser.getId());
              SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
              if (list!=null)
              {
              for(Wyhfcj be:list){ 
              %>
	      <tr> <td><a href="http://www.d1.com.cn//html/zt2012/20121212wycj/dhindex.jsp" target="_blank"> <%=be.getWycjinfo_cardno()%></a></td>
               <td><%=format.format(be.getWycjinfo_date())%></td>
               <td>2012年12月31日</td>
             </tr>
      <%} }%>
             
           </table></td>
         </tr>
       </table>
</div>
	</div>

  
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>



