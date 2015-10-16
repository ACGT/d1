<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——0元团购订单号信息</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("../res/js/d1.js")%>"></script>

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
           <td width="1%">&nbsp;</td>
           <td width="99%"> <font color="#8b2d3d" style=" font-size:15px;"><b>&nbsp;&nbsp;0元团购订单号</b></td>
         </tr>
         
         <tr>
           <td>&nbsp;</td>
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="19%">&nbsp;</td>
               <td width="81%">&nbsp;</td>
             </tr>
              <%
              ArrayList<TuanDraw> list=new ArrayList<TuanDraw>();
              List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	          clist.add(Restrictions.eq("userId",lUser.getId()));
	          	List<Order> olist = new ArrayList<Order>();
	          	olist.add(Order.desc("id"));
	          	List<BaseEntity> list1= Tools.getManager(TuanDraw.class).getList(clist, olist, 0, 50);
	          	if(list1!=null && list1.size()>0)
	          	{
		          	for(BaseEntity be:list1){
		          		list.add((TuanDraw)be);
		          	}
	          	}
              SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
              if (list!=null)
              {
              for(TuanDraw be:list){ 
            	String createtime=format.format(be.getCreatedate());
              %>
	      <tr>
               <td><%=createtime%></td>
               <td>恭喜您，您已成功参加0元抽奖活动，您的订单号是<font color='red'><%= be.getCode() %></font>，开奖时间为2012年1月16日。</td>
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



