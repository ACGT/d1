<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.*"%><%@include
	file="/inc/header.jsp"%>
<%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%@include file="/ShowOrder/myshow.jsp"%>
<%!
/**
 * 快递查询接口方法
 * 
 * @param key
 *            ：商家用户key值，在http://www.kuaidi100.com/openapi申请的
 * @param com
 *            ：快递公司代码，在http://www.kuaidi100.com/openapi网上的技术文档里可以查询到
 * @param nu
 *            ：快递单号，请勿带特殊符号，不支持中文（大小写不敏感）
 * @return 快递100返回的url，然后放入页面iframe标签的src即可
 * @see
 */
public String searchkuaiDiInfo(String key, String com, String nu)
{
    String content = "";
    try
    {
        URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + key + "&com=" + com
                          + "&nu=" + nu);
        URLConnection con = url.openConnection();
        con.setAllowUserInteraction(false);
        InputStream urlStream = url.openStream();
        byte b[] = new byte[10000];
        int numRead = urlStream.read(b);
        content = new String(b, 0, numRead);
        while (numRead != -1)
        {
            numRead = urlStream.read(b);
            if (numRead != -1)
            {
                // String newContent = new String(b, 0, numRead);
                String newContent = new String(b, 0, numRead, "UTF-8");
                content += newContent;
            }
        }
        urlStream.close();
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
    return content;
}
private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
public int getPsid(String shipname){
	int psid=0;
	if(shipname.indexOf("EMS")>=0 ){
		psid=1;
	}else if(shipname.indexOf("圆通")>=0 ){
		psid=2;
	}else if(shipname.indexOf("韵达")>=0 ){
		psid=3;
	}else if(shipname.indexOf("顺丰")>=0 ){
		psid=4;
	}else if(shipname.indexOf("申通")>=0 ){
		psid=5;
	}else if(shipname.indexOf("中通")>=0 ){
		psid=6;
	}else if(shipname.indexOf("优速")>=0 ){
		psid=7;
	}else if(shipname.indexOf("天天")>=0 ){
		psid=8;
	}else if(shipname.indexOf("国通")>=0 ){
		psid=9;
	}else if(shipname.indexOf("汇通快递")>=0 ){
		psid=10;
	}else if(shipname.indexOf("全峰")>=0 ){
		psid=11;
	}else if(shipname.indexOf("百世汇通")>=0 ){
		psid=12;
	}else if(shipname.indexOf("宅急送")>=0 ){
		psid=13;
	}
	return psid;
}
public String getPsTitle(int psId)
   {
	   String result="";
	   switch(psId)
	   {
	   case 3002:
		   result="EMS";
		   break;
	   case 1011:
		   result="申通快递";
		   break;
	   case 4024:
		   result="北京乐运通";
		   break;
	   case 2001:
		   result="宅急送";
		   break;
	   default:
			   result="";
			   break;
	   }   
	   return result;
   }
/*
   public String getPsHref(int psId)
   {
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="http://www.ems.com.cn/";
			   break;
		   case 1011:
			   result="http://www.sto.cn/";
			   break;
		   case 4024:
			   result="http://www.leyuntong.com/";
			   break;
		   case 2001:
			   result="http://www.zjs.com.cn/WS_Business/WS_Business_GoodsTrack.aspx/";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
   }
*/
public String getPsHref(int psId)
{
	   String result="";
	   switch(psId)
	   {
		   case 1:
			   result="http://www.ems.com.cn/";
			   break;
		   case 2:
			   result="http://www.yto.net.cn/";
			   break;
		   case 3:
			   result="http://www.yundaex.com/";
			   break;	  
		   case 4:
			   result="http://www.sf-express.com/cn/sc";
			   break;
		   case 5:
			   result="http://www.sto.cn/";
			   break;
		   case 6:
			   result="http://www.zto.cn";
			   break;
		   case 11:
			   result="http://www.qfkd.com.cn";
			   break;
		   case 13:
			   result="http://www.zjs.com.cn/WS_Business/WS_Business_GoodsTrack.aspx/";
			   break;		   

		   default:
				   result="";
				   break;
	   }
	   return result;
}
public String getPsPhone(int psId)
{
	   String result="";
	   switch(psId)
	   {
	   
	       case 1:
		      result="11185";
			   break;
	       case 2:
			   result="010-81974057";
			   break;
	       case 3:
			   result="400-821-6789";
			   break;
	       case 4:
			   result="4008-111-111";
			   break;
		   case 5:
			   result="0571-82122222";
			   break;
		   case 6:
			   result="4008270270";
			   break;  
		   case 11:
			   result="4001-000-001";
			   break;
		   case 13:
			   result="400-6789000";
			   break;
	
		   
		   default:
				   result="";
				   break;
	   }
	   return result;
}

/*
   public String getPsPhone(int psId)
   {
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="11185";
			   break;
		   case 1011:
			   result="0571-82122222";
			   break;
		   case 4024:
			   result="010-83603381";
			   break;
		   case 2001:
			   result="400-6789000";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
   }
 */  
   public String getPsdate(int psId)
   {
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="5-7个工作日";
			   break;
		   case 1011:
			   result="3-5个工作日";
			   break;
		   case 4204:
			   result="1-2天（仅限北京地区）";
			   break;
		   case 2001:
			   result="3-5个工作日";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
   }
   
   public String getPsTele(int psId)
   {
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="11185";
			   break;
		   case 1011:
			   result="0571-82122222";
			   break;
		   case 4204:
			   result="010-83603381";
			   break;
		   case 2001:
			   result="400-6789-0000";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
   }
   
   
   
%>
<%
String orderid = "";
Double points = new Double(0);
if (request.getParameter("orderid") != null
		&& request.getParameter("orderid").length() > 0) {
	orderid = request.getParameter("orderid");
}
if(!Tools.isNull(orderid)){
response.sendRedirect("/wap/user/orderdetail.html?odrid="+orderid);
return;
}
OrderBase ob = null;
ArrayList<OrderItemBase> oilist = new ArrayList<OrderItemBase>();
List<OrderItemBase> oilists = null;
ob = OrderHelper.getById(orderid);
if (ob == null) {
	ob = OrderHelper.getHistoryById(orderid);
}
if (ob == null) {
	response.sendRedirect("/mindex.jsp");
	return;
}

if(!lUser.getId().equals(String.valueOf(ob.getOdrmst_mbrid()))){
	response.sendRedirect("/mindex.jsp");
	return;
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—<%=orderid  %></title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
	padding-left: 3px
}

* html, * html body {
	background-image: url(about:blank);
	background-attachment: fixed;
}

img {
	border: none;
}

ul {
	list-style: none;
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
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>订单详情 <br />
		</div>
		&nbsp;订单号：<%=orderid %>
		<table width="100%">
			<tr>
				<td colspan="2" style="background: #FFDEAD; color: #f00;">&nbsp;收货信息</td>
			</tr>
			<tr>
				<td align="left" width="100">&nbsp;收货人：</td>
				<td><%=ob.getOdrmst_rname()%></td>
			</tr>
			<tr>
				<td align="left">&nbsp;收货地址：</td>
				<td><%=ob.getOdrmst_rprovince()%>，<%=ob.getOdrmst_rcity()%>，<%=ob.getOdrmst_raddress()%>，<%=ob.getOdrmst_rzipcode()%></td>
			</tr>
			<tr>
				<td align="left">&nbsp;联系方式：</td>
				<td>手机&nbsp;<% if(ob.getOdrmst_rphone()!=null&&ob.getOdrmst_rphone().length()>0){ out.print(ob.getOdrmst_rphone());}
					     else
					     { out.print(ob.getOdrmst_pmphone());}
					     %>，邮箱地址&nbsp;<%=ob.getOdrmst_remail()%></td>
			</tr>
			<tr>
				<td colspan="2" style="background: #FFDEAD; color: #f00;">&nbsp;送货方式</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp; <%if(!Tools.isNull(ob.getOdrmst_customerword())){ %>
					<%= ob.getOdrmst_customerword().substring(ob.getOdrmst_customerword().indexOf('[')+1, ob.getOdrmst_customerword().indexOf("务必送前联系,本人签收 须当面拆箱验货（化妆品拒收不可拆产品包装）")) %>
					<%} %>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="background: #FFDEAD; color: #f00;">&nbsp;订单追踪</td>
			</tr>

			<%
			
			Comment comment = null;


			long payType = Tools.longValue(ob.getOdrmst_paytype());//支付方式
			String os="";
			if(ob.getOdrmst_orderstatus().longValue()==-1 || ob.getOdrmst_orderstatus().longValue()==-2){
				os="用户取消";
			}else if(ob.getOdrmst_orderstatus().longValue()==-3){
				os="客服取消";
			}else if(ob.getOdrmst_orderstatus().longValue()==-4){
				os="系统取消";
			}
           	switch (Tools.parseInt(ob.getOdrmst_orderstatus().toString())) {
           		case 0: {
           %>
			<!--订单状态0--订单审核中-->
			<%
	    	      if(payType==4){//未支付，在线支付
	    	      %>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<% }else if(payType==1){//未支付，货到付款
	    	     %>

			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>

			<%}else{%>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<%}
	    	   %>


			<%
			  	    break;
			  	 }//订单被取消了。

			  	      		case -1:
			  	      		case -2:
			  	      		case -3:
			  	      		case -4:
			  	      		{
			  	      %>
			<!--订单状态2--用户取消-->


			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<tr>
				<td colspan="2">
					<%	if (ob.getOdrmst_canceldate() != null){
       					   		out.print(dateFormat.format(ob.getOdrmst_canceldate()));
			  	      		}%>&nbsp;&nbsp;<%=os %></td>
			</tr>

			<%
            		break;
            			}
            			case 1: {
            	%>

			<!--订单状态1--货到付款已确认-->
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_validdate()) %>&nbsp;&nbsp;<%=payType==4?"已成功支付":"订单已审核" %></td>
			</tr>

			<%
            	break;
            		}
            		case 3:
            		case 31: {
            			//out.println(ob.getOdrmst_realshipdate()+"====");
            			if(ob.getOdrmst_realshipdate() != null){//真实发货
            				
            %>
			<!--订单追踪-->
			<%
			  String d1shipmethod = ob.getOdrmst_d1shipmethod();
			  %>
			<tr>
				<td colspan="2" align="left"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<tr>
				<td colspan="2" align="left"><%=dateFormat.format(ob.getOdrmst_validdate()) %>&nbsp;&nbsp;<%=payType==4?"已成功支付":"订单已审核" %></td>
			</tr>
			<tr>
				<td colspan="2" align="left"><%=dateFormat.format(ob.getOdrmst_shipdate())%>&nbsp;&nbsp;备货完成</td>
			</tr>
			<tr>
				<td colspan="2" align="left"><%=dateFormat.format(ob.getOdrmst_realshipdate())%>&nbsp;&nbsp;快递配送</td>
			</tr>
			<tr>
				<td colspan="2">
					<%
					   if(!Tools.isNull(d1shipmethod)){
					   %> 货单号：<%=Tools.formatString(ob.getOdrmst_goodsodrid()) %> <br />
					<%
					   //String kdURL = getPsHref((int)Tools.longValue(ob.getOdrmst_d1shipid()));
					   //String kdPhone = getPsPhone((int)Tools.longValue(ob.getOdrmst_d1shipid()));
					   String kdURL = getPsHref(getPsid(d1shipmethod));
					   String kdPhone = getPsPhone(getPsid(d1shipmethod));
					   %> 配送公司：<%
						  if(Tools.isNull(kdURL)){
						  	%>[<%=d1shipmethod %>]<%
						  }else{
						    %><a href="<%=kdURL %>">[<%=d1shipmethod %>]
				</a>
					<%
						  } %><br /> <%if(!Tools.isNull(kdPhone)){ %>配送公司电话：<%=kdPhone %><br />
					<%} %> 发货时间：<%out.print(dateFormat.format(ob.getOdrmst_realshipdate())); %><br />
					<!-- 加物流提示开始 --> <a
					href="/wap/user/orderlogistics.jsp?orderid=<%=orderid%>"
					title="物流信息">物流信息查询</a><br /> <!-- 加物流提示结束 --> <%
					   } %> 商品收到了，请您尽快<a
					href="/wap/comment/addcomment1.jsp?orderid=<%=orderid%>">确认收货并评价</a>，您的评价对其他客户购买商品有很大的帮助！！！
				</td>
			</tr>


			<%
            }else{//可以发货了。
            	Date shipDate = ob.getOdrmst_shipdate();
                %>


			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_validdate()) %>&nbsp;&nbsp;<%=payType==4?"已成功支付":"订单已审核" %></td>
			</tr>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_shipdate())%>&nbsp;&nbsp;备货完成</td>
			</tr>
			<%
            }
            	break;
            		}
            		
            		
            		case 2:{
            			//网上支付已付款
            			%>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_validdate()) %>&nbsp;&nbsp;<%=payType==4?"已成功支付":"订单已审核" %></td>
			</tr>
			<%}
            			break;
            		case 5:
            		case 51:
            		case 6:
            		case 61: {
            			Date shipDate = ob.getOdrmst_shipdate();
            			Date realshipDate = ob.getOdrmst_realshipdate();
            %>
			<!--订单状态5--已完成-->

			<%
			  String d1shipmethod = ob.getOdrmst_d1shipmethod();
			  //System.out.println("777777777"+ob.getOdrmst_realshipdate());
			  %>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_validdate()) %>&nbsp;&nbsp;<%=payType==4?"已成功支付":"订单已审核" %></td>
			</tr>
			<tr>
				<td colspan="2"><%=ob.getOdrmst_shipdate() == null ? "" : dateFormat.format(ob.getOdrmst_shipdate())%>&nbsp;&nbsp;备货完成</td>
			</tr>
			<tr>
				<td colspan="2"><%=ob.getOdrmst_realshipdate() == null ? "" : dateFormat.format(ob.getOdrmst_realshipdate())%>&nbsp;&nbsp;快递配送
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<%
					   if(!Tools.isNull(d1shipmethod)){
					   %> 货单号：<%=Tools.formatString(ob.getOdrmst_goodsodrid()) %> <br />
					<%
					   //String kdURL = getPsHref((int)Tools.longValue(ob.getOdrmst_d1shipid()));
					   //String kdPhone = getPsPhone((int)Tools.longValue(ob.getOdrmst_d1shipid()));
					   String kdURL = getPsHref(getPsid(d1shipmethod));
					   String kdPhone = getPsPhone(getPsid(d1shipmethod));
					   %> 配送公司：<%
						  if(Tools.isNull(kdURL)){
						  	%>[<%=d1shipmethod %>]<%
						  }else{
						    %><a href="<%=kdURL %>">[<%=d1shipmethod %>]
				</a>
					<%
						  } %><br /> <%if(!Tools.isNull(kdPhone)){ %>配送公司电话：<%=kdPhone %><br />
					<%} %> 发货时间：<%out.print(ob.getOdrmst_shipdate() == null ? "" :dateFormat.format(ob.getOdrmst_shipdate())); %><br />

					<!-- 物流提示开始 --> <a
					href="/wap/user/orderlogistics.jsp?orderid=<%=orderid%>"
					title="物流信息">物流信息查询</a><br /> <!-- 物流提示结束 --> <%
					   } %>
				</td>
			</tr>


			<tr>
				<td colspan="2">
					<% if (ob.getOdrmst_finishdate() != null) {
			  		out.print(dateFormat.format(ob.getOdrmst_finishdate()));
			  	} else {
			  		out.print(dateFormat.format(new Date()));
			  	} %>&nbsp;&nbsp;已确认收货 <%
					    comment = getCommentbyOrderId(ob.getId());
			  	        if(comment==null)
			  	        {%> &nbsp;&nbsp;<a
					href="/wap/comment/addcomment1.jsp?orderid=<%= ob.getId() %>">马上去评价</a>
					<%}
			  	%>
				</td>
			</tr>



			<%
					    if(comment != null){
					    %>
			<tr>
				<td colspan="2"><%=dateFormat.format(comment.getGdscom_createdate()) %>&nbsp;&nbsp;已评价</td>
			</tr>
			<%
					    }%>


			<%
            		break;
            			}
            			default: {
            		           %>
			<!--订单状态0--订单审核中-->
			<%
            		    	      if(payType==4){//未支付，在线支付
            		    	      %>

			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<% }else if(payType==1){//未支付，货到付款
            		    	     %>

			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<%}else{%>
			<tr>
				<td colspan="2"><%=dateFormat.format(ob.getOdrmst_orderdate())%>&nbsp;&nbsp;订单生成</td>
			</tr>
			<%}
            				  	      	break;
            				  	      		}
           	}
String memo="";
if(!Tools.isNull(ob.getOdrmst_customerword()) && !"null".equals(ob.getOdrmst_customerword().toLowerCase())){
	memo=ob.getOdrmst_customerword().replace("<br>","<br/>&nbsp;");
}
String paymethod=getPayMethod(ob.getOdrmst_paytype().toString());
if(ob.getOdrmst_payid().intValue()==0){
	paymethod+="-现金支付";
	 }else if(ob.getOdrmst_payid().intValue()==44){
		 paymethod+="-POS机刷卡";
	}else if(ob.getOdrmst_payid().intValue()==20){
		 paymethod="手机支付宝（在线支付）";
	}
	%>
			<tr>
				<td colspan="2" style="background: #FFDEAD; color: #f00;">&nbsp;付款方式</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp; <%=paymethod%> <%
 if(ob.getOdrmst_payid().intValue()==20 && ob.getOdrmst_orderstatus().longValue()==0){
	 %> <br />
				<a href="/interface/pay/wapalipay/Trade.jsp?OdrID=<%=orderid%>">去支付>></a>
					<%}
 %>
				</td>
			</tr>

			<tr>
				<td colspan="2" style="background: #FFDEAD; color: #f00;">&nbsp;顾客留言</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;<%=memo%></td>
			</tr>
			<tr>
				<td colspan="2" style="background: #FFDEAD; color: #f00;">&nbsp;商品清单</td>
			</tr>
			<tr>
				<td colspan="2">
					<%
				     	oilist = OrderItemHelper.getOdrdtlListByOrderId(orderid);
				     		if (oilist == null) {
				     			oilists = OrderItemHelper.getOdrdtHistorylByOrderId(orderid);
				     		}
				     		int i=0;
				     		if (oilist != null && oilist.size() > 0) {
				     			for (OrderItemBase oi : oilist) {
				     				i++;
				    
						     	Product p = ProductHelper.getById(oi.getOdrdtl_gdsid());
						     				if (p != null) {
						     %> <%=i %>、<a href="/wap/goods.jsp?productid=<%=p.getId()%>"><%=p.getGdsmst_gdsname()%></a>
					<br /> <% if(oi.getOdrdtl_sku1()!=null&&oi.getOdrdtl_sku1().length()>0&&p.getGdsmst_skuname1()!=null&&p.getGdsmst_skuname1().length()>0)
						        		{
						        		  out.print("&nbsp;"+p.getGdsmst_skuname1()+"："+oi.getOdrdtl_sku1()+"<br/>");
						        		}%> &nbsp;小计：￥<%=Tools.getDouble(oi.getOdrdtl_totalmoney(),2)%><br />
					&nbsp;数量：<%=oi.getOdrdtl_gdscount()%><br /> <%
								        	if (ob.getOdrmst_orderstatus() == 5
								        							|| ob.getOdrmst_orderstatus() == 51
								        							|| ob.getOdrmst_orderstatus() == 3
								        							|| ob.getOdrmst_orderstatus() == 31
								        							|| ob.getOdrmst_orderstatus() == 6
								        							|| ob.getOdrmst_orderstatus() == 61) {
								        						points += oi.getOdrdtl_spendcount();
								        					}

								        				} else {
								        					out.print("此商品不存在");
								        				}
								        			}

								        		} else {
								        			if (oilists != null && oilists.size() > 0) {
								        				for (OrderItemBase oi : oilists) { i++;
								        				Product p = ProductHelper.getById(oi.getOdrdtl_gdsid());
									     				if (p != null) {
									     %> <%=i %>、<a
					href="/wap/goods.jsp?productid=<%=p.getId()%>"><%=p.getGdsmst_gdsname()%></a>
					<br /> <% if(oi.getOdrdtl_sku1()!=null&&oi.getOdrdtl_sku1().length()>0&&p.getGdsmst_skuname1()!=null&&p.getGdsmst_skuname1().length()>0)
									        		{
									        		  out.print("&nbsp;"+p.getGdsmst_skuname1()+"："+oi.getOdrdtl_sku1()+"<br/>");
									        		}%> &nbsp;小计：￥<%=Tools.getDouble(oi.getOdrdtl_totalmoney(),2)%><br />
					&nbsp;数量：<%=oi.getOdrdtl_gdscount()%><br /> <%
									     	if (ob.getOdrmst_orderstatus() == 5
									     								|| ob.getOdrmst_orderstatus() == 51
									     								|| ob.getOdrmst_orderstatus() == 3
									     								|| ob.getOdrmst_orderstatus() == 31
									     								|| ob.getOdrmst_orderstatus() == 6
									     								|| ob.getOdrmst_orderstatus() == 61) {
									     							points += oi.getOdrdtl_spendcount();
									     						}

									     					} else {
									     						out.print("此商品不存在");
									     					}
									     				}

									     			}
									     		}
									     %>
				</td>
			</tr>
			<tr>
				<td>&nbsp;商品金额：&nbsp;</td>
				<td>￥<%= OrderHelper.getOrderTotalProductMoney(orderid) %>元
				</td>
			</tr>
			<tr>
				<td>&nbsp;+&nbsp;运费：&nbsp;</td>
				<td>￥<%=OrderHelper.getOrderExpressFee(orderid) %>元
				</td>
			</tr>
			<tr>
				<td>&nbsp;-&nbsp;优惠：&nbsp;</td>
				<td>￥<%= OrderHelper.getOrderTotalCut(orderid) %>元
				</td>
			</tr>
			<% if(OrderHelper.getOrderTotalCut1(orderid)>0f)
		               {
		            	   out.print("<tr><td>&nbsp;-&nbsp;预存款：&nbsp;</td><td>￥"+OrderHelper.getOrderTotalCut1(orderid)+"元</td></tr>");
		               }
		     %>
			<tr>
				<td>订单总金额：</td>
				<td>￥<%=OrderHelper.getOrderTotalMoney(orderid) %>元
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<%
							   
								   if(points > 0){
									   if(comment != null || Tools.dateValue(ob.getOdrmst_realshipdate()) < System.currentTimeMillis()-Tools.MONTH_MILLIS){
										   %>您将获得<%=ProductGroupHelper.getRoundPrice(new Float(points)) %>积分<%
									   }else{
										   %>您将获得<%=ProductGroupHelper.getRoundPrice(new Float(points)) %>积分分<%
									   }
								   }
							
					   %>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;<a href="myorder.jsp">返回我的订单>></a></td>
			</tr>
		</table>

	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->

</body>
</html>

