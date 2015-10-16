<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include file="/wap/inc/islogin.jsp"%><%
String orderId = (String)session.getAttribute("OrderCacheId");
OrderBase order = OrderHelper.getById(orderId);
if(order == null){
	response.sendRedirect("/mindex.jsp");
	return;
}
if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	response.sendRedirect("/mindex.jsp");
	return;
}
String strOdrmstJcFlag = String.valueOf(order.getOdrmst_jcflag());
String strOdrmstMbrID = String.valueOf(order.getOdrmst_mbrid());//会员ID
double fltTktmstTktValue = Tools.doubleValue(order.getOdrmst_tktvalue());
double fltGiftFee = Tools.doubleValue(order.getOdrmst_giftfee());
double fltActurePayMoney = Tools.doubleValue(order.getOdrmst_acturepaymoney());//
long payId = Tools.longValue(order.getOdrmst_payid());//支付方式
long strOrderStatus = Tools.longValue(order.getOdrmst_orderstatus());//支付状态


//百分点信息
String strbfdsessionid = null;
String bfd_strbfdusrid = lUser.getId();
String bfd_strsessioinid = null;
String bfd_orderid = orderId;
String ckeBfdcookie = Tools.getCookie(request,"bfdadsessionid");
if(Tools.isNull(ckeBfdcookie)){
	int ibfdRdm = new Random().nextInt(100);//产生0到100的随机数
	strbfdsessionid = Tools.getDBDate()+ibfdRdm;
	bfd_strsessioinid = strbfdsessionid;
	if(Tools.isNull(bfd_strbfdusrid)){
		 bfd_strbfdusrid = strbfdsessionid;
	}
}else{
	if(Tools.isNull(bfd_strbfdusrid)){
		bfd_strbfdusrid = ckeBfdcookie;
	}
	bfd_strsessioinid = ckeBfdcookie;
}
String bfd_strgdsid = null,bfd_strgdscount = null , bfd_strprice = null , bfd_strgdsid2 = null;
List<OrderItemCache> itemList = OrderItemHelper.getOrderItemCacheByOrderId(orderId);
if(itemList != null && !itemList.isEmpty()){
	for(OrderItemCache ois : itemList){
		if(Tools.isNull(bfd_strgdsid)){
			bfd_strgdsid = "\"" + ois.getOdrdtl_gdsid() + "\"";
			bfd_strgdscount = String.valueOf(ois.getOdrdtl_gdscount());
			bfd_strprice = String.valueOf(ois.getOdrdtl_finalprice());
		}else{
			bfd_strgdsid = bfd_strgdsid + ",\"" + ois.getOdrdtl_gdsid() + "\"";
			bfd_strgdscount += "," + ois.getOdrdtl_gdscount();
			bfd_strprice += "," + ois.getOdrdtl_finalprice();
		}
	}
}
if(!Tools.isNull(bfd_strgdsid)){
	bfd_strgdsid2 = bfd_strgdsid.replaceAll("\",\"",",");
}


%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单确认</title>
<style type="text/css">
    body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px;}
    a {text-decoration:none;color:#4169E1}
	a:hover {color:#aa2e44}
	.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
	img{ border:none;}
	input{ width:150px;}
</style>
</head>
<body>
<%@ include file="/wap/inc/head.jsp" %>

	  <%
		if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43))){
			int p = 0;
			String paymethod="手机支付";
			if(payId==20){
				paymethod="支付宝支付";
			}
			switch ((int)payId){
				case 4:
				case 6:
				case 25:
				case 26:
				case 27:
				case 34:
				case 35:
				case 36:
				case 37:
				case 38:
				case 39:
				case 40:
				case 41:
				case 42:
				case 43:
					p=2;
					break;
				case 20:
					p=4;
					break;
				case 21:
					p=3;
					break;
				case 14:
				case 31:
					p=5;
					break;
				case 33:
					p=1;
					break;
			}
	   %>
	   <form name="form1" method="post" action="/flowDone.jsp" id="form1" onsubmit="return false;">
	   <input type="hidden" name="OdrID" id="str_order_id" value="<%=orderId %>" />
	   <table width="98%" cellpadding="0" cellspacing="0">
		  <tr>
		     <td height="30" style=" background-color:#ffecf2; line-height:30px; font-size:22px; font-family:'微软雅黑'; ">订单已成功提交！
		     </td>
		   </tr>
		   <tr><td><span>订单号：<%=orderId %></span></td></tr>
		    <tr><td>应支付金额：<span style="color:red;"><%=Tools.getFormatMoney(fltActurePayMoney) %></span>元</td></tr>
		   <tr><td>您选择的付款方式为：<font color="#0234b9"><%=paymethod %></font>
			  <br/><span style="color:red;">由于商品的库存可能发生变化，建议您尽快进行支付。</span></td></tr>
		   <tr><td height="10px"></td></tr>
		   <tr><td><a href="/wap/flow/zhifu.jsp?payId=<%=p %>&OdrID=<%=orderId %>">去支付>></a></td></tr>
		   <tr><td height="10px"></td></tr>
		   <tr><td>您可以在<a href="/wap/user/">我的优尚</a>中查看订单</td></tr>
	   </table></form><%
	   }else if((payId == 0 || payId==44) && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){
	   %>
	    <table width="98%" cellpadding="0" cellspacing="0">
		  <tr>
		     <td height="30" style=" background-color:#ffecf2; line-height:30px; font-size:22px; font-family:'微软雅黑'; ">订单已成功提交！
		     </td>
		   </tr>
		   <tr><td><span>订单号：<%=orderId %></span></td></tr>
		    <tr><td>应支付金额：<span style="color:red;"><%=Tools.getFormatMoney(fltActurePayMoney) %></span>元</td></tr>
		   <tr><td height="10px"></td></tr>
		   <tr><td>您可以在<a href="/wap/user/">我的优尚</a>中查看订单</td></tr>
	   </table>
	   <%
	   }else if(payId == 1 && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){
	   %>
	    <table  cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
	     
		  <tr>
		      <td height="30" style=" background-color:#ffecf2; line-height:30px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		  </tr>
		  <tr>
		       <td  style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/> 您选择的付款方式为：<font color="#0234b9">邮局汇款</font>
			     <br/><br/>汇款寄到：<%=PubConfig.get("PAY_POST_ADDRESS") %>
				 <br/><br/>邮政编码：<%=PubConfig.get("PAY_POST_ZIP") %>
				 <br/><br/>
						 <div style=" background:#f8f8f8;">
						     <table>
							    <tr>
								   <td width="50"></td>
								   <td style=" text-align:left; font-size:13px; font-weight:normal;">
								   <br/><br/>
								   <font style=" font-weight:bold; font-size:14px;">温馨提示：</font>
								   <br/><br/>
								    1.请务必在汇款简短留言中准确注明您的<font color="red">姓名</font>和<font color="red">订单号</font>。
									<br/><br/>
									2.请准确填写汇款信息和应支付金额，以便为您处理订单。
									<br/><br/>
									3.由于商品库存可能发生变化，建议您尽快进行汇款。收到款项后，安排发货。
									<br/><br/>
									4.订单生成10日内未收到您的汇款，本订单将被取消。
								   </td>
								</tr>
							 </table>
						 </div>
				  <br/>
				  <br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:18px; font-weight:normal;">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table><%
	   }else if(payId == 2 && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){ %>
	    <table  cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
		  <tr>
	      	<td height="30" style=" background-color:#ffecf2; line-height:30px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		  </tr>
		  <tr>
		       <td style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/> 您选择的付款方式为：<font color="#0234b9">银行电汇</font>
			     <br/><br/>户名：<%=PubConfig.get("PAY_BANK_ACCOUNTNAME") %>
				 <br/><br/>开户行：<%=PubConfig.get("PAY_BANK_BANKNAME") %>
				 <br/><br/>账号：<%=PubConfig.get("PAY_BANK_ACCOUNTNO") %>
				 <br/><br/>
						 <div style=" background:#f8f8f8; ">
						     <table >
							    <tr>
								   <td width="50"></td>
								   <td style=" text-align:left; font-size:13px; font-weight:normal;">
								   <br/><br/>
								   <font style=" font-weight:bold; font-size:14px;">温馨提示：</font>
								   <br/><br/>
								    1.请务必在电汇单“事由”一栏处准确注明您的<font color="red">姓名</font>和<font color="red">订单号</font>。
									<br/><br/>
									2.请准确填写汇款信息和应支付金额，以便为您处理订单。
									<br/><br/>
									3.由于商品库存可能发生变化，建议您尽快进行汇款。收到款项后，安排发货。
									<br/><br/>
									4.对公帐号需48小时方可到账。
									<br/><br/>
									5.办理<font color="red">工商银行</font>电汇时请注意：由于一些储蓄所无对公业务，请到工商银行分理处办理。
								   </td>
								
								</tr>
							 </table>
						 </div>
				  <br/>
				  <br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:18px; font-weight:normal;">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table><%
	   }else if(payId == 29 && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){ %>
	   <form name="form1" method="post" action="/flowDone.jsp" id="form1" onsubmit="return false;">
	   <input type="hidden" name="OdrID" id="str_order_id" value="<%=orderId %>" />
	   <table cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
		  <tr>
		         <td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		   </tr>
		   <tr>
		       <td height="315" style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/>您选择的付款方式为：<font color="#0234b9">平安万里通积分支付</font>
			     <br/><br/>由于商品的库存可能发生变化，建议您尽快进行支付。
				 <br/><br/>您选择的支付平台为：
				 <br/><br/><img src="http://images.d1.com.cn/images2012/New/flow/payid_<%=payId %>.png" />
				 <br/><br/><input type="button" id="send_button" onclick="payOrder(6,this);" value="" style="border:none;color:#FFF;font-weight:bold;width:151px;height:45px;background:url(http://images.d1.com.cn/images2012/New/user/button_2_1.jpg) no-repeat;cursor:pointer" />
				  <br/><br/>
				  <br/>
				   <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:18px; font-weight:normal;">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table></form><%
	   }else if(Tools.floatCompare(fltActurePayMoney,0) == 0){//兑换券
		   %>
		  <table width="98%" cellpadding="0" cellspacing="0">
		  <tr>
		     <td height="30" style=" background-color:#ffecf2; line-height:30px; font-size:22px; font-family:'微软雅黑'; ">订单已成功提交！
		     </td>
		   </tr>
		   <tr><td><span>订单号：<%=orderId %></span></td></tr>
		    <tr><td>应支付金额：<span style="color:red;"><%=Tools.getFormatMoney(fltActurePayMoney) %></span>元</td></tr>
		   <tr><td height="10px"></td></tr>
		   <tr><td>您可以在<a href="/wap/user/">我的优尚</a>中查看订单</td></tr>
	   </table>
		<%
	   }%>
	   <table><tr><td height="20"></td></tr></table>
<%@ include file="/wap/inc/userfoot.jsp" %>


</body>
</html>