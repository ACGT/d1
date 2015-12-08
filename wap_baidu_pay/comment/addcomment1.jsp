<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品评价 - D1优尚</title>
<style type="text/css">
body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

input {
	width: 150px;
}
</style>
</head>
<body>

	<%@ include file="../inc/head.jsp"%>

	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="/wap/user/index.jsp">我的优尚</a>>发表评论
			<br />
		</div>
		<form id="form1" name="form1"
			action="operation.jsp?orderid=<%=request.getParameter("orderid") %>"
			method="post">
			<%
      if(!Tools.isNull(request.getParameter("orderid"))){
    	  OrderBase base=OrderHelper.getById(request.getParameter("orderid"));
    	  if(base!=null){
    		  if(!lUser.getId().equals(String.valueOf(base.getOdrmst_mbrid()))){
					out.println("你没有权限进行操作！");
    			  return;
    		  }
    		 
    			 int status= base.getOdrmst_orderstatus().intValue();
    			
    			 if(status == 3 || status == 31){
    			  if(status==3){
    				  status=5;
    				  //out.print(">>>>>>>>>>>>>>>>>>>>>>>>");
    			  }else if(status==31){
    				  status=51;
    			  }
    			 base.setOdrmst_orderstatus(new Long(status));
    			 base.setOdrmst_finishdate(new Date());
    			 Tools.getManager(base.getClass()).clearListCache(base);
    			 if(!Tools.getManager(base.getClass()).update(base, true)){
    				 out.println("设置交易完成失败！");
    					return;
  					}else{
    			 // out.print(">>>>>>>>>>>>>>>>>>>>>>>>");
  					}
    			 }
    			// ArrayList<OrderItemBase> itemlist=null;
    			// out.print(base.getId());
    			 ArrayList<OrderItemBase> itemlist=OrderItemHelper.getMyOrderDetail(base.getId());
  				
    		 
    	  %>
			<table border="0" width="100%">
				<tr>
					<td height="5">&nbsp;</td>
				</tr>
				<tr>
					<td class="peisong_body" align="left"
						style="padding-left: 5px; padding-bottom: 5px"><span
						style="font-size: 13px; font-weight: bold">交易已经完成，感谢您惠顾D1优尚，欢迎您对本次交易及所购商品进行评价。</span>
					</td>
				</tr>

				<tr>
					<td class="peisong_body" align="left" valign="middle"
						style="padding-left: 4px; padding-right: 4px">
						<div style="background-color: #FEEEF1;">
							<span style="font-size: 12px;">感谢您的参与，成功评价1个商品，您将获得10个积分（</span><span
								style="font-size: 12px; color: red;">平安万里通用户除外</span><span
								style="font-size: 12px;">）。</span>
						</div>

					</td>
				</tr>

			</table>
			<%
    	 if(itemlist!=null && itemlist.size()>0){
    		 %>
			<table width="100%">
				<% int i=1;
    		 for(OrderItemBase item:itemlist){
    			
    		 
    			 Product product= ProductHelper.getById(item.getOdrdtl_gdsid());
				
				 String linkurl="";
				 if(product!=null){
					 linkurl="/wap/goodsdetail.jsp?productid="+product.getId();
				 } %>
				<tr style="border-collapse: collapse;">

					<td align="left" style="padding-left: 4px"><input
						type="hidden" name="productid"
						value="<%=item.getOdrdtl_gdsid() %>" /> <input type="hidden"
						name="productname" value="<%=item.getOdrdtl_gdsname() %>" /> <a
						href='<%=linkurl %>'><%=item.getOdrdtl_gdsname()%></a></td>

				</tr>

				<tr>
					<td>

						<div id="mark"
							style="padding-left: 4px; margin-left: 0px; float: left">

							<input type="radio" value="5" name="rlevel<%=i%>"
								checked="checked">5星</input> <input type="radio" value="4"
								name="rlevel<%=i%>">4星</input> <input type="radio" value="3"
								name="rlevel<%=i%>">3星</input> <input type="radio" value="2"
								name="rlevel<%=i%>">2星</input> <input type="radio" value="1"
								name="rlevel<%=i%>">1星</input>

						</div>
					</td>
				</tr>
				<tr>
					<td style="padding-left: 4px">请输入评论内容（100字以内）：</td>
				</tr>
				<tr>
					<td style="padding-left: 4px"><textarea class="txtcontent"
							name="tcontent" id="tcomment<%=i %>"
							onkeydown='if (this.value.length>=100){event.returnValue=false}'
							onkeyup="keypress<%=i%>(this.value)"></textarea> <br /> <span
						id="content<%=i%>" style="color: red"></span></td>
				</tr>

				<%  
           i++;
				 }%>
				<tr>
					<td align="center"><input type="submit" value="提交"></input></td>
				</tr>
			</table>

			<%}else{
    		  out.println("该订单不存在");
    	    	  return;
    		  }
    	  
    		 }
      }else{
    	  out.println("参数错误");
    	  return;
      }
     %>
		</form>
	</div>


	<div class="clear"></div>
	<%@ include file="../inc/userfoot.jsp"%>

</body>
</html>