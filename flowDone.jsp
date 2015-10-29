<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%><%@include file="doneLm.jsp"%><%@include file="inc/islogin.jsp"%><%
String orderId = (String)session.getAttribute("OrderCacheId");
OrderBase order = OrderHelper.getById(orderId);
if(order == null){
	response.sendRedirect("/index.jsp");
	return;
}
if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	response.sendRedirect("/index.jsp");
	return;
}
String strOdrmstJcFlag = String.valueOf(order.getOdrmst_jcflag());
String strOdrmstMbrID = String.valueOf(order.getOdrmst_mbrid());//会员ID
double fltTktmstTktValue = Tools.doubleValue(order.getOdrmst_tktvalue());
double fltGiftFee = Tools.doubleValue(order.getOdrmst_giftfee());
double fltActurePayMoney = Tools.doubleValue(order.getOdrmst_acturepaymoney());//
double fltprepayvalue = Tools.doubleValue(order.getOdrmst_prepayvalue());//
Date orderdate=order.getOdrmst_orderdate();
long payId = Tools.longValue(order.getOdrmst_payid());//支付方式
long strOrderStatus = Tools.longValue(order.getOdrmst_orderstatus());//支付状态
String gdsidlist="02200096,02200097,02200095,02200094,03200050,03200049,03200064";
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2012-11-1 00:00:00";
if(new Date().before(df.parse(end))){
	List<OrderItemBase> itemlist=OrderItemHelper.getOdrdtlCacheByOrderId( orderId);
	if(itemlist!=null && itemlist.size()>0){
	for(OrderItemBase item:itemlist){
		if(item.getOdrdtl_gifttype().equals("0") && gdsidlist.indexOf(item.getOdrdtl_gdsid())>=0){
			BuyLimit blm = (BuyLimit)Tools.getManager(BuyLimit.class).findByProperty("gdsbuyonemst_gdsid", item.getOdrdtl_gdsid());
			if(blm!=null&&blm.getGdsbuyonemst_starttime()!=null&&blm.getGdsbuyonemst_endtime()!=null){
				if(blm.getGdsbuyonemst_starttime().getTime()<=System.currentTimeMillis()&&
						blm.getGdsbuyonemst_endtime().getTime()>=System.currentTimeMillis()){
					BuyLimitDtl bld = new BuyLimitDtl();
					bld.setGdsbuyonedtl_createtime(new Date());
					bld.setGdsbuyonedtl_gdsid(item.getOdrdtl_gdsid());
					bld.setGdsbuyonedtl_mbrid(new Long(lUser.getId()));
					bld.setGdsbuyonedtl_mstid(new Long(blm.getId()));
					bld.setGdsbuyonedtl_odrid(order.getId());
					Tools.getManager(BuyLimitDtl.class).txCreate(bld);
				}
			}
		}
	}
	}
}


String lmurl = "";

String ip = request.getHeader("x-forwarded-for");
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
ip = request.getHeader("Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
ip = request.getHeader("WL-Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
ip = request.getRemoteAddr();
}

try{
	lmurl = DoneAct(orderId,request,response,lUser,ip);
}catch(Exception ex){
	ex.printStackTrace();
}


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单确认</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowDone.js")%>"></script>
<style type="text/css">
body{ margin:0px; padding:0px; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.center{margin:0px auto; padding-top:20px; }
table tr td span{ font-size:22px;color:#b43e58; font-family:'微软雅黑'}
table tr td  a{ color:#e60000; text-decoration:none;}
table tr td div{ margin:0px auto;}
</style>
</head>
<body>
<center>
    <div class="center">
   <%=lmurl%>
	   <table width="890" border="0" cellspacing="0" cellpadding="0">
	     <tr><td style=" text-align:center;"><a href="/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/smalllogo.jpg"/></a><img src="http://images.d1.com.cn/images2012/New/user/shoppingcarlogo.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/sureorder.jpg" /></td></tr>
	       <tr><td height="10"></td></tr>
	   </table><%//34 交通银行    
	   //37 广东发展银行
		if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43) || (payId >= 45 && payId <= 58))){
			int p = 0;
			switch ((int)payId){
				case 4:
				case 6:
				case 25:
				case 26:
				case 27:
				case 36:
				case 38:
				case 41:
				case 42:
				case 43:
				case 51:
				case 52:
				case 53:
				case 54:
				case 55:
				case 56:
				case 57:
				case 58:
					p=2;
					break;
				//case 34:
				//case 37:
				case 20:
				case 34:
				case 37:
				case 40:
				case 45:
				case 46:
				case 47:
				case 48:
				case 49:
				case 50:
					p=4;
					break;
				case 21:
					p=3;
					break;
				case 60:
					p=6;
					break;
				case 14:
				case 31:
					p=5;
					break;
				case 33:
				case 35:
				case 39:
					p=1;
					break;
			}
			String end2="2012-11-21 00:00:00";
			if(new Date().before(df.parse(end2))){
				if(payId==27){
					p=5;
				}
			}
	   %>
	   <form name="form1" method="post" action="/flowDone.jsp" id="form1" onsubmit="return false;">
	   <input type="hidden" name="OdrID" id="str_order_id" value="<%=orderId %>" />
	   <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
		  <tr>
		         <td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		   </tr>
		    <tr><td height="10"></td></tr>
		   <tr>
		   <td align="center" style="font-family:'宋体';">
		   <table>
		   <tr><td ><span style="color:black;font-size:14px;font-family:'宋体';">温馨提示：</span></td><td align="left"><span style="color:black;font-size:14px;font-family:'宋体';">1、请您在订单生成后</span><span style="color:red;font-size:14px;font-family:'宋体';">7天</span><span style="color:black;font-size:14px;font-family:'宋体';">内完成支付，逾期系统将自动取消本订单。</span></td></tr>
		   <tr><td ></td><td align="left"><span style="color:black;font-size:14px;font-family:'宋体';">2、由于商品的库存可能发生变化，建议您尽快支付。</span></td></tr>
		   </table>
		   </td>
		   </tr>
		   <tr>
		       <td height="315" style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/>您选择的付款方式为：<font color="#0234b9">网上支付</font>
			     <br/><br/>由于商品的库存可能发生变化，建议您尽快进行支付。
				 <br/><br/>您选择的支付平台/银行为：
				 <br/><br/><img src="http://images.d1.com.cn/PayImages/payid_<%=payId %>.png" />
				 <br/><br/><input type="button" id="send_button" onclick="payOrder(<%=p %>,this);" value="" style="border:none;color:#FFF;font-weight:bold;width:151px;height:45px;background:url(http://images.d1.com.cn/images2012/New/user/button_2_1.jpg) no-repeat;cursor:pointer" />
				  <br/>
                  </font>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table></form><%
		  }else if((payId ==60) && Tools.floatCompare(fltActurePayMoney,0) == 1){
			  %>
			  
	   <form name="form1" method="post" action="/flowDone.jsp" id="form1" onsubmit="return false;">
	   <input type="hidden" name="OdrID" id="str_order_id" value="<%=orderId %>" />
	   <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
		  <tr>
		         <td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		   </tr>
		    <tr><td height="10"></td></tr>
		   <tr>
		   <td align="center" style="font-family:'宋体';">
		   <table>
		   <tr><td ><span style="color:black;font-size:14px;font-family:'宋体';">温馨提示：</span></td><td align="left"><span style="color:black;font-size:14px;font-family:'宋体';">1、请您在订单生成后</span><span style="color:red;font-size:14px;font-family:'宋体';">7天</span><span style="color:black;font-size:14px;font-family:'宋体';">内完成支付，逾期系统将自动取消本订单。</span></td></tr>
		   <tr><td ></td><td align="left"><span style="color:black;font-size:14px;font-family:'宋体';">2、由于商品的库存可能发生变化，建议您尽快支付。</span></td></tr>
		   </table>
		   </td>
		   </tr>
		   <tr>
		       <td height="315" style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/>您选择的付款方式为：<font color="#0234b9">网上支付</font>
			     <br/><br/>由于商品的库存可能发生变化，建议您尽快进行支付。
				 <br/><br/>您选择的支付平台/银行为：
				 <br/><br/><img src="http://images.d1.com.cn/PayImages/payid_<%=payId %>.png" />
				 <br/><br/>
				 <div id="paywximg"></div>
				  <br/>
				 <font color="red"> 请打开微信，用微信里的“扫一扫”支付
				  
                  </font><br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table></form>
	   <script language="javascript">
	   weixinpayimg();
	   function weixinpayimg(){
				   $.ajax({
						type: "get",
						dataType: "json",
						url: '/interface/pay/weixinpay/webwxpay.jsp',
						data:{OdrID:<%=orderId%>},
						error: function(XmlHttpRequest){
							alert("内容错误！");
						},success: function(json){
								if(json.SUCCESS){
								$("#paywximg").html("<img src=\"/weixin/paywx_img.gif?<%=System.currentTimeMillis()%>\">");
								}else{
									$("#paywximg").html("<font style=\"color:red;\">获取支付信息失败</font>");
								}
						}
					});
					}
	   </script>
	   <%
	 
		}else if((payId ==0|| payId == 44) && Tools.floatCompare(fltActurePayMoney,0) == 1){
	   %>
	    <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
		  <tr>
		      <td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		  </tr>
		  <tr>
		       <td height="405" style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/> 您选择的付款方式为：<font color="#0234b9">
			      <%if (payId==44) { %>POS机刷卡<%}else{ %>货到付款<%} %></font>
			     <br/><br/>您在收货时需向送货人员支付：<font color="#e40000"><%=Tools.getFormatMoney(fltActurePayMoney) %>元</font>
				 <br/><br/>
						 <div style=" background:url(http://images.d1.com.cn/images2012/New/user/hdfkbg.jpg); width:713px; height:231px;">
						     <table width="713px;">
							    <tr>
								   <td width="268"></td>
								   <td style=" text-align:left; font-size:13px; font-weight:normal;">
								   <br/><br/><br/>
								   <font style=" font-weight:bold; font-size:14px;">温馨提示：</font>
								   <br/><br/>
								    1.D1优尚网所有包装均为带有D1优尚网标识的装用纸箱。
									<br/><br/>
									2.当您收到快递时，请务必<font color="red">先验货，再付款</font>。
									<br/><br/>
									3.验货过程中遇到任何问题，请及时致电D1优尚客服
									<br/>&nbsp;&nbsp;400-680-8666（09:00-18:00）
								   </td>
								</tr>
							 </table>
						 </div>
				  <br/>
				   <br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table>
	   <%
	   }else if(payId == 1 && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){
	   %>
	    <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
	     
		  <tr>
		      <td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		  </tr>
		  <tr>
		       <td height="420" style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/> 您选择的付款方式为：<font color="#0234b9">邮局汇款</font>
			     <br/><br/>汇款寄到：<%=PubConfig.get("PAY_POST_ADDRESS") %>
				 <br/><br/>邮政编码：<%=PubConfig.get("PAY_POST_ZIP") %>
				 <br/><br/>
						 <div style=" background:#f8f8f8; width:713px; height:211px;">
						     <table width="713px;">
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
									3.<font color="red">请您在订单生成后7天内完成支付，逾期系统将自动取消本订单。</font>
									<br/><br/>
									4.由于商品库存可能发生变化，建议您尽快进行汇款。收到款项后，安排发货。
									
								   </td>
								</tr>
							 </table>
						 </div>
				  <br/>
				   <br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table><%
	   }else if(payId == 2 && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){ %>
	    <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
		  <tr>
	      	<td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！您需支付<span><%=Tools.getFormatMoney(fltActurePayMoney) %>元</span></td>
		  </tr>
		  <tr>
		       <td height="475" style=" font-size:16px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
			      <br/><br/> 您选择的付款方式为：<font color="#0234b9">银行电汇</font>
			     <br/><br/>户名：<%=PubConfig.get("PAY_BANK_ACCOUNTNAME") %>
				 <br/><br/>开户行：<%=PubConfig.get("PAY_BANK_BANKNAME") %>
				 <br/><br/>账号：<%=PubConfig.get("PAY_BANK_ACCOUNTNO") %>
				 <br/><br/>
						 <div style=" background:#f8f8f8; width:713px; height:231px;">
						     <table width="713px;">
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
									3.<font color="red">请您在订单生成后7天内汇款，逾期系统将自动取消本订单。</font>
									<br/><br/>
									4.由于商品库存可能发生变化，建议您尽快进行汇款。收到款项后，安排发货。
									<br/><br/>
									5.对公帐号需48小时方可到账。
									<br/><br/>
									6.办理<font color="red">工商银行</font>电汇时请注意：由于一些储蓄所无对公业务，请到工商银行分理处办理。
								   </td>
								
								</tr>
								
							 </table>
						 </div>
				  <br/>
				   <br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table><%
	   }else if(payId == 29 && Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0){ %>
	   <form name="form1" method="post" action="/flowDone.jsp" id="form1" onsubmit="return false;">
	   <input type="hidden" name="OdrID" id="str_order_id" value="<%=orderId %>" />
	   <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
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
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table></form><%
	   }else if(Tools.floatCompare(fltActurePayMoney,0) == 0){//兑换券
		   %>
		   <table width="888" cellpadding="0" cellspacing="0" style=" border:solid 1px #c2c2c2; text-align:center;">
			  <tr>
		         <td height="60" style=" background-color:#ffecf2; line-height:60px; font-size:22px; font-family:'微软雅黑'; ">订单<span><%=orderId %></span>已成功提交！</span></td>
		   </tr>
		    <tr>
		       <td height="75" style=" font-size:14px; border-bottom:dashed 1px #c2c2c2;">
				 
			   </td>
		   </tr>
		   <tr>
		       <td height="315" style=" font-size:14px; font-weight:bold; border-bottom:dashed 1px #c2c2c2;">
				 <br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			   </td>
		   </tr>
	   </table>
		<%
	   }%>
	   <table><tr><td height="20"></td></tr></table>
	</div>
</center>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-25292063-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>


</body>
</html>