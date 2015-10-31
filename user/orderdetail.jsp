<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.*"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include file="/inc/islogin.jsp"%><%@include file="/ShowOrder/myshow.jsp"%><%
String orderid = "";
Double points = new Double(0);
if (request.getParameter("orderid") != null
		&& request.getParameter("orderid").length() > 0) {
	orderid = request.getParameter("orderid");
}
OrderBase ob = null;
ArrayList<OrderItemBase> oilist = new ArrayList<OrderItemBase>();
List<OrderItemBase> oilists = null;
ob = OrderHelper.getById(orderid);
OrderBase ohistory=OrderHelper.getHistoryById(orderid);
if (ob == null) {
	//
	ob = OrderHelper.getHistoryById(orderid);
	//ohistory= OrderHelper.getHistoryById(orderid);
}
if (ob == null) {
	response.sendRedirect("/");
	return;
}

if(!lUser.getId().equals(String.valueOf(ob.getOdrmst_mbrid()))){
	response.sendRedirect("/");
	return;
}
%><%!
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
       // con.setConnectTimeout(60000);
       // con.setReadTimeout(60000);
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
       // e.printStackTrace();
    }
    return content;
}
private static String getcom(String comname){
	String com="";
	 if(comname.indexOf("中通")>=0){
		   com="zhongtong";
	   }else if(comname.indexOf("宅急送")>=0){
		   com="zhaijisong";
	   }else if(comname.indexOf("优速")>=0){
		   com="yousu";
	   }else if(comname.indexOf("天天")>=0){
		   com="tiantian";
	   }else if(comname.indexOf("顺丰")>=0){
		   com="shunfeng";
	   }else if(comname.indexOf("圆通")>=0){
		   com="yuantong";
	   }else if(comname.indexOf("申通")>=0){
		   com="shentong";
	   }else if(comname.indexOf("全峰")>=0){
		   com="quanfeng";
	   }else if(comname.indexOf("汇通")>=0){
		   com="huitong";
	   }else if(comname.indexOf("EMS")>=0){
		   com="ems";
	   }else if(comname.indexOf("韵达")>=0){
		   com="yunda";									   
	   }
	
	return com;
}
private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
/*
<option value="EMS">EMS</option>
<option value="宅急送">宅急送</option>
<option value="圆通速递">圆通速递</option>
<option value="韵达快运">韵达快运</option>
<option value="顺丰快递">顺丰快递</option>
<option value="申通快递">申通快递</option>
<option value="中通快递">中通快递</option>
<option value="优速快递">优速快递</option>
<option value="天天快递">天天快递</option>
<option value="国通快递">国通快递</option>
<option value="汇通快递">汇通快递</option>
<option value="全峰快递">全峰快递</option>
<option value="百世汇通">百世汇通</option>*/

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


   
 

   
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>订单详情---<%=orderid  %></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/orderdetail.css")%>" rel="stylesheet" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/user/orderajax.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowDone.js")%>"></script>

</head>
 
<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
    <div class="center">
    <%
    String str="";
 	if (ob == null) {
 		out.print("对不起,该订单不存在<a href=\"/Index.jsp\"><font color='red'>马上去购物</font></a>");
 	} else {
    
    //立即支付的处理
		    int ps = 0;
			double fltActurePayMoney = Tools.doubleValue(ob.getOdrmst_acturepaymoney());//
			long payId = Tools.longValue(ob.getOdrmst_payid());//支付方式
			long strOrderStatus = Tools.longValue(ob.getOdrmst_orderstatus());//支付状态
			
			
			if(payId == 29){//万里通支付
				ps = 6;
			}
			
			 Comment comment = null;
			
				if(Tools.floatCompare(fltActurePayMoney,0) == 1 && strOrderStatus == 0 && (payId == 4 || payId == 6 || payId == 14 || (payId >=16 && payId <=21) || (payId>=25 && payId<=27) || payId==30 || payId==31 || (payId >= 33 && payId <= 43) || (payId >= 45 && payId <= 58))){
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
						ps=2;
						break;
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
						ps=4;
						break;
					case 21:
						ps=3;
						break;
					case 14:
					case 31:
						ps=5;
						break;
					case 33:
					case 35:
    				case 39:
						ps=1;
						break;
					case 29:
						ps=6;
						break;
					default:
						{
							ps=1;
							break;
						}
				}
				SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    			String end2="2012-11-21 00:00:00";
    			
    				if(new Date().before(df.parse(end2))){
        				if(payId==27){
        					ps=5;
        				}
        			}
    			
			}
			long payType = Tools.longValue(ob.getOdrmst_paytype());//支付方式
			
           	switch (Tools.parseInt(ob.getOdrmst_orderstatus().toString())) {
           		case 0: {
           %>
	    	   <!--订单状态0--订单审核中-->
	    	   <%
	    	      if(payType==4){//未支付，在线支付
	    	      %>
	    	    	  <div class="orderdetail">
	    		      <div class="order_title">
	    			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：订单生成</b>
	    			  </div>
	    			  <div class="order_imglist">
	    			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
	    			  </div>
	    			    <div class="order_create">
	    				          <table>
	    						     <tr>
	    								<td width="170"> 
	    								<div class="tip">						
	    							        <span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%>
	    							         <br/>
	    							         <% 
	    							          if(ob.getOdrmst_orderdate()!=null)
											    {
											    	Calendar c=Calendar.getInstance();
													c.setTime(ob.getOdrmst_orderdate());
													c.add(Calendar.DATE, 15);
													if(new Date().before(c.getTime()))
													{%>
														 <input type="image" id="send_button" onclick="payOrder2(<%= ps %>,'<%= ob.getId() %>',this);" src="http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg" />
													<%}
													
											    }
	    							         %>
	    							        
	    							         <a href="javascript:void(0)" onclick="CancleOrderbtn(<%= ob.getId() %>,<%= ob.getType() %>)" >取消订单</a>
	    								</div>
	    							 </td>
	    							 <td width="170"><span><b>订单待付款</b></span></td>
	    							 </tr>
	    							  <tr>
	    							 <td colspan="2"><span style="color:red;">请在订单生成后7天完成支付，否则系统将自动取消该订单。</span></td>
	    							 </tr>
	    						  </table>
	    				 </div>
	    				
	    			  </div>
	    	<!--订单追踪-->	  
			  
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					   <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					   
					</table>
			  </div>
	    	     <% }else if(payType==1){//未支付，货到付款
	    	     %>
	    	    	  <div class="orderdetail">
		      <div class="order_title">
			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：订单生成</b>
			  </div>
			  <div class="order_imglist">
			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
			  </div>
			    <div class="order_create">
				          <table>
						     <tr>
							    <td width="170">
							    	<div class="tip">						
	    							        <span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%>
	    							         <br/>
	    							         <a href="javascript:void(0)" onclick="CancleOrderbtn(<%= ob.getId() %>,<%= ob.getType() %>)" >取消订单</a>
	    								</div>
							    </td>
								<td><span><b>订单待审核</b></span></td>
							 </tr>
						  </table>
				 </div>
				
			  </div>
			  
		<!--订单追踪-->	  
			  
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					   <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					</table>
			  </div>
	    	      <%}else{
	    	    	
	    	      %>
	    	    	<div class="orderdetail">
	    		      <div class="order_title">
	    			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：订单生成</b>
	    			  </div>
	    			  <div class="order_imglist">
	    			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
	    			  </div>
	    			    <div class="order_create">
	    				          <table>
	    						     <tr>
	    								<td> 
	    								<div class="tip">						
	    							        <span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/>
	    							<a href="javascript:void(0)" onclick="CancleOrderbtn(<%=ob.getId() %>,<%=ob.getType() %>)" >取消订单</a>
	    							         <br/>
	    							   	</div>
	    							 </td>
	    							 </tr>
	    						  </table>
	    				 </div>
	    				
	    			  </div>
	    	<!--订单追踪-->	  
			  
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					   <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					   
					</table>
			  </div>  
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
			  	      			if(strOrderStatus==-1 || strOrderStatus==-2){
			  	      			str="用户取消";
			  	      			}else if(strOrderStatus==-3){
			  	      			str="客服取消";
			  	      			}else if(strOrderStatus==-4){
			  	      			str="系统取消";
			  	      			}
			  	      %>
           <!--订单状态2--用户取消-->
       	      <div class="orderdetail">
       		      <div class="order_title">
       			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：<%=str %></b>
       			  </div>
       			  <div class="order_imglist">
       			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
       			  </div>
       			    <div class="order_create">
       				          <table>
       						     <tr>
       							    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/></td>
       								<td> <div class="tip">
       						
       							<span><b><%=str %></b></span><br/><%
       						     if (ob.getOdrmst_canceldate() != null){
       						     	out.print(dateFormat.format(ob.getOdrmst_canceldate()));
       						     }
       						       							%> 
       							   <br/>
       							 <div style=" margin-top:7px;">
       							 	 <%
       							 if(Tools.parseInt(ob.getOdrmst_orderstatus().toString())==-4){
       								%>	 
       								<span style="color:red;">超过7天未支付，系统自动取消</span>
       							  <%}
       							 %>	
       						  </div></div></td>
       							 </tr>
       						  </table>
       				 </div>
       				
       			  </div>
       			  
       		<!--订单追踪-->	  
       			  
       			  <div class="order_zz">
       					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
       					<table cellpadding="0" cellspacing="0" border="0">
       					   <tr><td colspan="3" height="20"></td></tr>
       					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate()) %></td><td><b>订单生成</b></td></tr>
       					   <tr><td width="50"></td><td width="200"><%
       					   	if (ob.getOdrmst_canceldate() != null){
       					   		out.print(dateFormat.format(ob.getOdrmst_canceldate()));
			  	      		}
       					   %></td><td><b><%=str %></b></td></tr>
       					</table>
       			  </div>
            	<%
            		break;
            			}
            			case 1: {
            	%>
            	
           <!--订单状态1--货到付款已确认-->
	      <div class="orderdetail">
		      <div class="order_title">
			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：库房备货中</b>
			  </div>
			  <div class="order_imglist">
			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
			  </div>
			    <div class="order_create">
				          <table>
						     <tr>
							    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/>
							    </td>
								<td width="170"><span><b><%=payType==4?"已成功支付":"订单已审核" %></b></span><br/><%
									out.print(dateFormat.format(ob.getOdrmst_validdate()) + "<br/>");
								%>
								</td>
								<td><span><b>库房备货中</b></span></td>
							 </tr>
						  </table>
				 </div>
				
			  </div>
			  
		    <!--订单追踪-->	  
			  
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					   <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate()) %></td><td><b>订单生成</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_validdate()) %></td><td><b><%=payType==4?"已成功支付":"订单已审核" %></b></td></tr>
					</table>
			  </div>
            <%
            	break;
            		}
            		case 3:
            		case 31: {
            			if(ob.getOdrmst_shipdate() != null){//真实发货
            				
            %>
         <!--订单状态4--快递配送中-->
	      <div class="orderdetail">
		      <div class="order_title">
			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：已发货</b>
			  </div>
			  <div class="order_imglist">
			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
			  </div>
			    <div class="order_create">
				          <table>
						     <tr>
							    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/></td>
								<td width="170"><span><b><%=payType==4?"已成功支付":"订单已审核" %></b></span><br/><%=dateFormat.format(ob.getOdrmst_validdate())%><br/></td>
								<td width="170"><span><b>备货完成</b></span><br/><%=dateFormat.format(ob.getOdrmst_shipdate())%> <br/></td>
								<td width="170">
								<span><b>已发货</b></span><br/><%=dateFormat.format(ob.getOdrmst_shipdate()) %>
								<br/>
								<!-- <font style="color:#f00">
								   受春节假期影响，您的货品会延迟发货和配送，请您谅解。								   
								</font> -->
								</td>
								<td> 
								<div class="tip">						
							        <span><b>待确认收货</b></span>
							       
							        	 <br/>
									<a href="javascript:void(0)" onclick="tipdialog(<%= orderid %>)"><img src="http://images.d1.com.cn/images2012/New/user/qrsh_pj.jpg" width="114" height="27" style="vertical-align:middle;" /></a><br/>
									<br/>评价1件商品获赠10个积分
							        
							       
								</div>
							 </td>
							 </tr>
						  </table>
						
							
							
						
						
				 </div>
				
			  </div>
			  
		<!--订单追踪-->	  
			  <%
			  String d1shipmethod = ob.getOdrmst_d1shipmethod();
			  %>
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					   <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_validdate())%></td><td><b><%=payType==4?"已成功支付":"订单已审核" %></b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_shipdate())%></td><td><b>备货完成</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_shipdate())%></td><td><b>已发货</b></td></tr><%
					   if(!Tools.isNull(d1shipmethod)){
					   %>
					   <tr><td width="50"></td><td width="200"></td><td>货单号：<%=Tools.formatString(ob.getOdrmst_goodsodrid()) %><!-- <font style="color:#f00">受春节假期影响，快递运单信息可能暂停更新，货品可能滞留在中转站，请您谅解。</font> -->
					   <br/><%
					   String kdURL = getPsHref(getPsid(d1shipmethod));
					   String kdPhone = getPsPhone(getPsid(d1shipmethod));
					   %>
						      配送公司：<%
						  if(Tools.isNull(kdURL)){
						  	%>[<%=d1shipmethod %>]<%
						  }else{
						    %><a href="<%=kdURL %>" target="_blank">[<%=d1shipmethod %>]</a><%
						  } %><br/>
						   <%if(!Tools.isNull(kdPhone)){ %>配送公司电话：<%=kdPhone %><br /><%} %>
							             
						   发货时间：<%out.print(dateFormat.format(ob.getOdrmst_shipdate())); %><br />
	
					   </td></tr>
					   
					   <%	
					   /*if(d1shipmethod.indexOf("韵达")>=0){
					   String backstr=HttpUtil.getUrlContentByGet("http://join.yunda.ancto.com/query/json.php?partnerid=yunda&mailno="+ob.getOdrmst_goodsodrid()+"&charset=utf8","utf-8");
						if(!Tools.isNull(backstr)){
					   JSONObject  jsonob = JSONObject.fromObject(backstr); 
					 	 String json_order_search = jsonob.getString("mailno");  
					 	 JSONArray jsons = jsonob.getJSONArray("steps");  
					     int jsonLength = jsons.size();  
					       for (int i = 0; i < jsonLength; i++) {  
					    	   JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
					    	 String  address=  tempJson.getString("address");
					    	 String  time=  tempJson.getString("time");
					    	 String  remark=  tempJson.getString("remark");
					    	out.print("<tr><td width=\"50\"></td>");
					    	out.print("<td width=\"200\">"+time+"</td>");
					    	out.print("<td>"+address+remark+"</td></tr>");
					       }
						}*/
					   //}else{
						   /*zhongtong	中通 
						   zhaijisong	宅急送
						   youshuwuliu	优速 
						   tiantian	天天 
						   shunfeng	顺丰 
						   yuantong	圆通 
						   shentong	申通
						   quanfengkuaidi	全峰 
						   huitongkuaidi	汇通 
						   guotongkuaidi	国通 
						   ems              EMS
						   http://api.kuaidi100.com/api?id=[]&com=[]&nu=[]&valicode=[]&show=[0|1|2|3]&muti=[0|1]&order=[desc|asc]
							   b1a8923eac35cde8
							   
							  个别快递公司用另一个接口http://www.kuaidi100.com/applyurl?key=[]&com=[]&nu=[] 
								   */
								   int apitype=1;
					   String com=getcom(d1shipmethod);
					   if(!Tools.isNull(com)){
						 
			   String gourl="http://api.ickd.cn/?id=103771&secret=eae96b9aac0097cd94eda25af53f6b6e&com="+com+"&nu="+ob.getOdrmst_goodsodrid()+"&type=json&encode=utf8";
					   
					   //"http://api.kuaidi100.com/api?id=b1a8923eac35cde8";
		        // gourl=gourl+"&com="+com+"&nu="+ob.getOdrmst_goodsodrid()+"&show=0&muti=1&order=desc";
			   String backstr="";
			   try{
				   backstr= HttpUtil.getUrlContentByGet(gourl,"utf-8");
							 }catch(Exception ex){
									
								}	  
			   if(!Tools.isNull(backstr)){ 
			   JSONObject  jsonob = JSONObject.fromObject(backstr); 
				 String k100status = jsonob.getString("status");
				 if(Tools.parseInt(k100status)>0){
			 	 JSONArray jsons = jsonob.getJSONArray("data");  
			     int jsonLength = jsons.size();  
			       for (int i = 0; i < jsonLength; i++) {  
			    	   JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
			    	 String  context=  tempJson.getString("context");
			    	 String  time=  tempJson.getString("time");
			      	out.print("<tr><td width=\"50\"></td>");
			    	out.print("<td width=\"200\">"+time+"</td>");
			    	out.print("<td>"+context+"</td></tr>");
			       }
				 }else{
					 out.print("<tr><td width=\"50\"></td>");
				    	out.print("<td width=\"200\"></td>");
				    	out.print("<td>"+jsonob.getString("message")+"</td></tr>");
				 }
		   }else{
			   out.print("<tr><td width=\"50\"></td>");
		    	out.print("<td width=\"200\"></td>");
		    	out.print("<td>接口出现异常或物流单暂无结果!</td></tr>");
	
		   }
			}
					   } %>
					    <tr><td width="50"></td><td width="200"></td><td>
					      <%
							        if(ohistory==null){
							        	%>
					    商品收到了，请您尽快<a href="javascript:void(0)" onclick="tipdialog(<%= orderid %>)" ><span style=" font-size:12px; color:#c20000; text-decoration:underline;"><b>确认收货并评价</b></span></a>，您的评价对其他客户购买商品有很大的帮助！！！
					    评价1件商品还能获赠10个积分！
					    <%} %>
					     </td></tr>    
					</table>
			  </div>
            <%
            }else{//可以发货了。
            	Date shipDate = ob.getOdrmst_shipdate();
                %>
         <!--订单状态4--快递配送中-->
	      <div class="orderdetail">
		      <div class="order_title">
			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：等待配送</b>
			  </div>
			  <div class="order_imglist">
			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
			  </div>
			    <div class="order_create">
				          <table>
						     <tr>
							    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/></td>
								<td width="170"><span><b><%=payType==4?"已成功支付":"订单已审核" %></b></span><br/><%=dateFormat.format(ob.getOdrmst_validdate())%><br/></td>
								<td width="170"><span><b>备货完成</b></span><br/><%=shipDate!=null?dateFormat.format(shipDate):"" %><br/></td>
								<td width="170"><span><b>等待配送</b></span></td>
							 </tr>
						  </table>
				 </div>
				
			  </div>
			  
		<!--订单追踪-->	  
			  
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					   <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_validdate()) %></td><td><b><%=payType==4?"已成功支付":"订单已审核" %></b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=shipDate!=null?dateFormat.format(shipDate):"" %></td><td><b>备货完成</b></td></tr>
					</table>
			  </div><%
            }
            	break;
            		}
            		
            		
            		case 2:{
            			//网上支付已付款
            			%><div class="orderdetail">
		      <div class="order_title">
			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：库房备货中</b>
			  </div>
			  <div class="order_imglist">
			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
			  </div>
			    <div class="order_create">
				          <table>
						     <tr>
							    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%></td>
								<td width="170"><span><b><%=payType==4?"已成功支付":"订单已审核" %></b></span><br/><%=dateFormat.format(ob.getOdrmst_validdate())%></td>
								<td width="170"><span><b>库房备货中</b></span></td>
								<td></td>
							 </tr>
						  </table>
				 </div>
				
			  </div>
			  
		<!--订单追踪-->	  
			  
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					    <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_validdate())%></td><td><b><%=payType==4?"已成功支付":"订单已审核" %></b></td></tr>
				    </table>
			  </div><%}
            			break;
            		case 5:
            		case 51:
            		case 6:
            		case 61: {
            			Date shipDate = ob.getOdrmst_shipdate();
            			Date realshipDate = ob.getOdrmst_shipdate();
            %>
            	<!--订单状态5--已完成-->
	      <div class="orderdetail">
		      <div class="order_title">
			      <b>订单号：<%=orderid %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：交易完成</b>
			  </div>
			  <div class="order_imglist">
			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" />
			  <img src="http://images.d1.com.cn/images2012/New/user/order_suc.jpg" />
			  </div>
			    <div class="order_create">
				          <table>
						     <tr>
							    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%></td>
								<td width="170"><span><b><%=payType==4?"已成功支付":"订单已审核" %></b></span><br/><%=dateFormat.format(ob.getOdrmst_validdate()) %></td>
								<td width="170"><span><b>备货完成</b></span><br/><%=shipDate!=null?dateFormat.format(shipDate):"" %></td>
								<td width="170"><span><b>快递配送</b></span><br/><%=realshipDate!=null?dateFormat.format(realshipDate):"" %></td>
                                <td width="170"><span><b>已确认收货</b></span><br/><%
                                	if (ob.getOdrmst_finishdate() != null) {
                                		out.print(dateFormat.format(ob.getOdrmst_finishdate()));
                                	} else {
                                		out.print(dateFormat.format(new Date()));
                                	}
                                %>
                                </td><%
                               comment = getCommentbyOrderId(ob.getId());
                                %>
								<td><%
								if(comment == null && ohistory==null){
									%><div class="tip">						
								        <span><b>已完成（未评价）</b></span><br/>
								        <a href="/comment/addcomment.jsp?orderid=<%=orderid%>" target="_blank"><img src="http://images.d1.com.cn/images2012/New/user/qr_pj.jpg" style="vertical-align:middle;" /></a>
								        <br/><br/>评价1件商品获赠10个积分
								       
									</div><%
								}else if (comment == null && ohistory!=null){
									%><span><b>已完成</b></span><br/><%
									out.print(dateFormat.format(ohistory.getOdrmst_finishdate()));
								}
								else {
									%><span><b>已完成（已评价）</b></span><br/><%
									out.print(dateFormat.format(comment.getGdscom_createdate()));
								}
								%>
							 </td>
							 </tr>
						  </table>
				 </div>
				
			  </div>
			  
		<!--订单追踪-->	  
			  <%
			  String d1shipmethod = ob.getOdrmst_d1shipmethod();
			  %>
			  <div class="order_zz">
					<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
					<table cellpadding="0" cellspacing="0" border="0">
					    <tr><td colspan="3" height="20"></td></tr>
					   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=dateFormat.format(ob.getOdrmst_validdate())%></td><td><b><%=payType==4?"已成功支付":"订单已审核" %></b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=shipDate!=null?dateFormat.format(shipDate):""  %></td><td><b>库房备货</b></td></tr>
					   <tr><td width="50"></td><td width="200"><%=realshipDate!=null?dateFormat.format(realshipDate):"" %></td><td><b>快递配送</b></td></tr><%
						if(!Tools.isNull(d1shipmethod)){
						%>
					    <tr><td width="50"></td><td width="200"></td><td>货单号：<%=Tools.formatString(ob.getOdrmst_goodsodrid()) %><br/><%
					   String kdURL = getPsHref(getPsid(d1shipmethod));
					   String kdPhone = getPsPhone(getPsid(d1shipmethod));
					   %>
						配送公司：<%
							if(Tools.isNull(kdURL)){
						    	%>[<%=d1shipmethod %>]<%
						    }else{ %><a href="<%=kdURL %>" target="_blank">[<%=d1shipmethod %>]</a><%} %><br/>
						   <%if(!Tools.isNull(kdPhone)){ %>配送公司电话：<%=kdPhone %><br /><%} %>
							             
						   发货时间：<%out.print(realshipDate!=null?dateFormat.format(realshipDate):""); %><br />
						        
					   </td></tr><% 

						   int apitype=1;
						
								   String com=getcom(d1shipmethod);
								   if(!Tools.isNull(com)){
									 
						   String gourl="http://api.ickd.cn/?id=103771&secret=eae96b9aac0097cd94eda25af53f6b6e&com="+com+"&nu="+ob.getOdrmst_goodsodrid()+"&type=json&encode=utf8";
								   
								   //"http://api.kuaidi100.com/api?id=b1a8923eac35cde8";
					        // gourl=gourl+"&com="+com+"&nu="+ob.getOdrmst_goodsodrid()+"&show=0&muti=1&order=desc";
						   String backstr="";
						   try{
							   backstr=HttpUtil.getUrlContentByGet(gourl,"utf-8");
										 }catch(Exception ex){
												
											}	  
						   if(!Tools.isNull(backstr)){ 
						   JSONObject  jsonob = JSONObject.fromObject(backstr); 
							 String k100status = jsonob.getString("status");
							 if(Tools.parseInt(k100status)>0){
						 	 JSONArray jsons = jsonob.getJSONArray("data");  
						     int jsonLength = jsons.size();  
						       for (int i = 0; i < jsonLength; i++) {  
						    	   JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
						    	 String  context=  tempJson.getString("context");
						    	 String  time=  tempJson.getString("time");
						      	out.print("<tr><td width=\"50\"></td>");
						    	out.print("<td width=\"200\">"+time+"</td>");
						    	out.print("<td>"+context+"</td></tr>");
						       }
							 }else{
								 out.print("<tr><td width=\"50\"></td>");
							    	out.print("<td width=\"200\"></td>");
							    	out.print("<td>"+jsonob.getString("message")+"</td></tr>");
							 }
					   }else{
						   out.print("<tr><td width=\"50\"></td>");
					    	out.print("<td width=\"200\"></td>");
					    	out.print("<td>接口出现异常或物流单暂无结果!</td></tr>");
				
					   }
						}
					   } %>
					  <tr><td width="50"></td><td width="200"><%
					  	if (ob.getOdrmst_finishdate() != null) {
					  		out.print(dateFormat.format(ob.getOdrmst_finishdate()));
					  	} else {
					  		out.print(dateFormat.format(new Date()));
					  	}
					  %></td><td><b>已确认收货</b></td></tr>
					    <%
					    if(comment != null){
					    %>
					    	<tr><td width="50"></td><td width="200"><%=dateFormat.format(comment.getGdscom_createdate()) %></td><td><b>已评价</b></td></tr><%
					    }
					    else
					    {%>
					    <tr><td width="50"></td><td width="200"></td><td>
					      <%
							        if(ohistory==null){
							        	%>
					    您还没有对商品进行评价，现在就<a href="/comment/addcomment.jsp?orderid=<%=orderid%>" target="_blank"><span style=" font-size:12px; color:#c20000; text-decoration:underline;"><b>开始评价</b></span></a>吧，您的评价对其他客户购买商品有很大的帮助！！！
					    评价1件商品还能获赠10个积分！
					    <%} %>
					     </td></tr>  
					    	  <%}%>
					    </table>
			  </div>
            	<%
            		break;
            			}
            			default: {
            		           %>
            		    	   <!--订单状态0--订单审核中-->
            		    	   <%
            		    	      if(payType==4){//未支付，在线支付
            		    	      %>
            		    	    	  <div class="orderdetail">
            		    		      <div class="order_title">
            		    			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：订单生成</b>
            		    			  </div>
            		    			  <div class="order_imglist">
            		    			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
            		    			  </div>
            		    			    <div class="order_create">
            		    				          <table>
            		    						     <tr>
            		    								<td width="170"> 
            		    								<div class="tip">						
            		    							        <span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%>
            		    							         <br/>
            		    							          <% 
	    							          if(ob.getOdrmst_orderdate()!=null)
											    {
											    	Calendar c=Calendar.getInstance();
													c.setTime(ob.getOdrmst_orderdate());
													c.add(Calendar.DATE, 15);
													if(new Date().before(c.getTime()))
													{%>
														 <input type="image" id="send_button" onclick="payOrder2(<%= ps %>,'<%= ob.getId() %>',this);" src="http://images.d1.com.cn/images2012/New/user/hyzx_ljzf.jpg" />
													<%}
													
											    }
	    							         %>
	    							         <a href="javascript:void(0)" onclick="CancleOrderbtn(<%= ob.getId() %>,<%= ob.getType() %>)" >取消订单</a>
            		    								</div>
            		    							 </td>
            		    							 <td width="170"><span><b>订单待付款</b></span></td>
            		    							 </tr>
            		    						  </table>
            		    				 </div>
            		    				
            		    			  </div>
            		    	<!--订单追踪-->	  
            				  
            				  <div class="order_zz">
            						<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
            						<table cellpadding="0" cellspacing="0" border="0">
            						   <tr><td colspan="3" height="20"></td></tr>
            						   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
            						   
            						</table>
            				  </div>
            		    	     <% }else if(payType==1){//未支付，货到付款
            		    	     %>
            		    	    	  <div class="orderdetail">
            			      <div class="order_title">
            				      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：订单生成</b>
            				  </div>
            				  <div class="order_imglist">
            				  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
            				  </div>
            				    <div class="order_create">
            					          <table>
            							     <tr>
            								    <td width="170"><span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/>
            								    </td>
            									<td> 
            									<div class="tip">						
            								        <span><b>订单待审核</b></span><br/>
            								<a href="javascript:void(0)" onclick="CancleOrderbtn(<%= ob.getId() %>,<%= ob.getType() %>)" >取消订单</a>
            									</div>
            								 </td>
            								 </tr>
            							  </table>
            					 </div>
            					
            				  </div>
            				  
            			<!--订单追踪-->	  
            				  
            				  <div class="order_zz">
            						<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
            						<table cellpadding="0" cellspacing="0" border="0">
            						   <tr><td colspan="3" height="20"></td></tr>
            						   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
            						</table>
            				  </div>
            		    	      <%}else{%>
            		    	    	<div class="orderdetail">
            		    		      <div class="order_title">
            		    			      <b>订单号：<%=orderid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态：订单生成</b>
            		    			  </div>
            		    			  <div class="order_imglist">
            		    			  <img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" /><img src="http://images.d1.com.cn/images2012/New/user/white_direc.jpg" />
            		    			  </div>
            		    			    <div class="order_create">
            		    				          <table>
            		    						     <tr>
            		    								<td> 
            		    								<div class="tip">						
            		    							        <span><b>订单生成</b></span><br/><%=dateFormat.format(ob.getOdrmst_orderdate())%><br/>
            		    							<a href="javascript:void(0)" onclick="CancleOrderbtn(<%= ob.getId() %>,<%= ob.getType() %>)" >取消订单</a>
            		    							         <br/>
            		    							   	</div>
            		    							 </td>
            		    							 </tr>
            		    						  </table>
            		    				 </div>
            		    				
            		    			  </div>
            		    	<!--订单追踪-->	  
            				  
            				  <div class="order_zz">
            						<span><b>订单追踪</b>&nbsp;<img src="http://images.d1.com.cn/images2012/New/user/order_add.jpg" /></span>
					<br/>
            						<table cellpadding="0" cellspacing="0" border="0">
            						   <tr><td colspan="3" height="20"></td></tr>
            						   <tr><td width="50"><b>时间</b></td><td width="200"><%=dateFormat.format(ob.getOdrmst_orderdate())%></td><td><b>订单生成</b></td></tr>
            						   
            						</table>
            				  </div>  
            		    	      <%}
            				  	      	break;
            				  	      		}

	}	%>
			 
			 
			  <!--商品清单-->
			  <div class="order_userinfo">
					
					<table cellpadding="0" cellspacing="0" border="0" width="980">
					   <tr><td height="55" >
					     &nbsp;&nbsp;&nbsp;&nbsp;<span><b>收货人信息：</b></span>
					     <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ob.getOdrmst_rname()%>，<%=ob.getOdrmst_rcountry()%>，<%=ob.getOdrmst_rprovince()%>，<%=ob.getOdrmst_rcity()%>，<%=ob.getOdrmst_raddress()%>，<%=ob.getOdrmst_rzipcode()%>，
					     <% if(ob.getOdrmst_rphone()!=null&&ob.getOdrmst_rphone().length()>0){ out.print(ob.getOdrmst_rphone());}
					     else
					     { out.print(ob.getOdrmst_pmphone());}
					     %>，<%=ob.getOdrmst_remail()%>
					   </td></tr>
					    <tr><td height="55" >
					     &nbsp;&nbsp;&nbsp;&nbsp;<span><b>配送方式：</b></span>
					     <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					      <% if(ob.getOdrmst_d1shipmethod()!=null){ out.print(ob.getOdrmst_d1shipmethod());} else {out.print("");}%>   
					    </td></tr>
					    <tr><td height="55" >
					     &nbsp;&nbsp;&nbsp;&nbsp;<span><b>付款方式：</b></span>
					     <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=getPayMethod(ob.getOdrmst_paytype().toString())%>
					   </td></tr>
					    <tr><td height="55" >
					     &nbsp;&nbsp;&nbsp;&nbsp;<span><b>客户留言：</b></span>
					     <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= (ob.getOdrmst_customerword()==null?"":ob.getOdrmst_customerword().replace("<br>","<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")) %>
					   </td></tr>
					   <tr><td></td></tr>
					</table>
			  </div>
			  
		   <!--金额-->  
			   <div class="order_gdsinfo">
					<span><b>商品清单</b></span><br/><br/>
					 <table width="930"  border="0" cellspacing="1"  cellpadding="0" id="ordert" >
		   
				     <tr style=" color:#a25663;" height="33"><td class="d1">订单号</td><td width="340" class="d1">商品名称/编号</td><td class="d1">单价</td><td class="d1">数量</td><td class="d1">小计</td><td class="d1">商品状态</td>
				     </tr>
				     <%
				     oilist = OrderItemHelper.getOdrdtlListByOrderId(orderid);
				     		if (oilist == null) {
				     			oilists = OrderItemHelper
				     					.getOdrdtHistorylByOrderId(orderid);
				     		}
				     		if (oilist != null && oilist.size() > 0) {
				     			for (OrderItemBase oi : oilist) {
				     %>
				        	<tr height="70"><td><A href="/user/orderdetail.jsp?orderid=<%=orderid%>"><%=orderid%></A></td>
						     <td style=" padding-left:6px;">
						     <%
						     	Product p = ProductHelper.getById(oi.getOdrdtl_gdsid());
						     				if (p != null) {
						     					 int h=60;
			             		    		    	boolean	ishshowsd=false;//是否显示晒单
			    				     				//发货或完成
			    				     				if(ob.getOdrmst_orderstatus()>=3 && oi.getOdrdtl_shipstatus()>=1 && getMyShowByOrder(lUser.getId(),ob.getId(),oi.getOdrdtl_gdsid(),oi.getId())==0 ){
			    				     					ishshowsd=true;
			    				     					h=85;
			    				     				}
			    				     				 String  smallimg=p.getGdsmst_smallimg();	
					             		    		   if(smallimg!=null){
					             		    			  if(smallimg.startsWith("/shopimg/gdsimg")){
					             		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
					    				     						}else{
					    				     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
					    				     						}
					             		    		   }
						     %>
						        	

								       <span style="float:left;width:60px;height:<%=h%>px;">
			             		    		 <table>
					<tr><td> <img src="<%=smallimg%>" width="50" height="50" style=" float:left; vertical-align:bottom" /></td></tr>
					 <%
			    						        	 if(ishshowsd){
			    						        		 %>
			    						        		 <tr><td height="26" valign="middle"> 
			    						        	 <!--  <a href="/ShowOrder/showorder.jsp?odtlid=<%=oi.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0" title="每晒一件商品并通过审核将额外获得30积分" alt="每晒一件商品并通过审核将额外获得30积分"/></a>
			    						        	 -->
			    						        	 </td></tr>
					 <%} %>
					</table>
					  
			    						        	 </span>
								       <div class="sptitle" style=" display:block;padding-top:5px; width:233px;  overflow:hidden"><a href="/product/<%=p.getId()%>" target="_blank"><%=p.getGdsmst_gdsname()%></a><br/><%=p.getId()%>&nbsp;&nbsp;
								        <%  if(oi.getOdrdtl_sku1()!=null&&oi.getOdrdtl_sku1().length()>0) out.print("[&nbsp;"+p.getGdsmst_skuname1()+"："+oi.getOdrdtl_sku1()+"&nbsp;]"); %></div></td><td>￥<%= Tools.getFloat(oi.getOdrdtl_finalprice().floatValue(),2)%></td><td><%=oi.getOdrdtl_gdscount()%></td><td><span><b>￥<%=Tools.getDouble(oi.getOdrdtl_totalmoney(),2)%></b></span></td>
								       <td>
								          <%
								          if(ob.getOdrmst_orderstatus()==-1||ob.getOdrmst_orderstatus()==-2||ob.getOdrmst_orderstatus()==-3)
								          {
								        	  out.print("取消<br>");
								          }
								          else
								          {		
								        	  if (oi.getOdrdtl_purtype().longValue()==-14){
								        		  out.print("拆单发货取消<br>");
								        	  }else{
								           	switch (Tools.parseInt(oi.getOdrdtl_shipstatus().toString())) {
				          						case 1:
				          						case 2:
				          						case 3:
				          							out.print("");
				          							break;
				          						case -2:
				          							out.print("用户取消<br>");
				          							break;
				          						case -1:
				          							out.print("用户取消<br>");
				          							break;
				          						case -3:
				          							out.print("客服取消<br>");
				          							break;
				          						case -4:
				          							out.print("系统取消<br>");
				          							break;
				          						default:
				          								out.print("");
					          							break;
			          							
			          						}
								           }
								          }
								          %><%
								        	  String subodrid=oi.getId();
								        	  OdrShopTh odrshopth=(OdrShopTh)Tools.getManager(OdrShopTh.class).findByProperty("odrshopth_subodrid", new Long(subodrid));
								        	  long lstatus=-1;
								        	  long thtype=-1;
								        	  if(odrshopth==null){
								        	  %>
											 	<%
											 		if(thtype<0 && lstatus<0) {
												 		out.println(getOrderStatuByPaytype1(ob.getId(),oi.getId(), ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString()));
											 		}
											 	%>
								        	  <%}else{
								        		  thtype = odrshopth.getOdrshopth_thtype().longValue();//1退货 2换货
								        		  lstatus = odrshopth.getOdrshopth_status().longValue();//退换货状态
								        		  
								        		  out.println(getthtkLink(ob.getId(),oi.getId(),thtype,lstatus));
								        	  }
								          %>
								      
								       </td>
								        
									     
									      
								       </tr>
								        <%
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
								        				for (OrderItemBase oi : oilists) {
								        %>
					        	<tr height="70"><td><A href="/user/orderdetail.jsp?orderid=<%=orderid%>"><%=orderid%></A></td>
							     <td style=" padding-left:6px;">
							     <%
							     	Product p = ProductHelper.getById(oi
							     							.getOdrdtl_gdsid());
							     					if (p != null) {
							     						 String  smallimg=p.getGdsmst_smallimg();	
						             		    		   if(smallimg!=null){
						             		    			  if(smallimg.startsWith("/shopimg/gdsimg")){
						             		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
						    				     						}else{
						    				     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
						    				     						}
						             		    		   }
							     %>
							        	 <img src="<%=smallimg%>" width="50" height="50" style=" float:left; vertical-align:bottom" />
									       <div class="sptitle"><a href="/product/<%=p.getId()%>" target="_blank"><%=p.getGdsmst_gdsname()%></a>
								           <br/><%=p.getId()%>&nbsp;&nbsp;
								          <%  if(oi.getOdrdtl_sku1().length()>0) out.print("[&nbsp;"+p.getGdsmst_skuname1()+"："+oi.getOdrdtl_sku1()+"&nbsp;]"); %>
									       
									       </div></td><td>￥<%= Tools.getFloat(oi.getOdrdtl_finalprice().floatValue(),2) %></td><td><%=oi.getOdrdtl_gdscount()%></td><td><span><b>￥<%=Tools.getDouble(oi.getOdrdtl_totalmoney(),2)%></b></span></td>
									       <td>
									          <%
									          	switch (Tools.parseInt(oi.getOdrdtl_shipstatus().toString())) {
									          						case 1:
									          							out.print("正在配货");
									          							break;
									          						case 2:
									          						case 3:
									          							out.print("已发货");
									          							break;
									          						case -2:
									          							out.print("缺货取消");
									          							break;
									          						case -1:
									          							out.print("用户取消");
									          							break;
									          						case -3:
									          							out.print("退货取消");
									          							break;
									          						case -4:
									          							out.print("系统取消");
									          							break;
									          						default:
									          								out.print("正在配货");
										          							break;
									          							
									          						}
									          %>
									       
									       </td>
									    
									       </tr>
									     <%
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
				     
		   		   </table>
		        
					 <table width="930"  border="0" cellspacing="1" cellpadding="0" class="ordert1" >
					 <tr><td height="20"></td></tr>
		               <tr><td><span><b>商品金额合计(￥<%= OrderHelper.getOrderTotalProductMoney(orderid) %>)<font style=" font-size:14px; ">&nbsp;+&nbsp;</font>运费(￥<%=OrderHelper.getOrderExpressFee(orderid) %>)<font style=" font-size:14px; ">&nbsp;-&nbsp;</font>优惠(￥<%= OrderHelper.getOrderTotalCut(orderid) %>)<% if(OrderHelper.getOrderTotalCut1(orderid)>0f)
		               {
		            	   out.print("<font style=\" font-size:14px;\">&nbsp;-&nbsp;</font>预存款("+OrderHelper.getOrderTotalCut1(orderid)+")");
		               }
		            	   %>=订单总金额(￥<%=OrderHelper.getOrderTotalMoney(orderid) %>)</b></span></td></tr>
					   <tr><td><span><b><font color="#e2403e;" style=" font-size:14px;">订单总金额合计：<%=OrderHelper.getOrderTotalMoney(orderid)%>元</font></b></span></td></tr>
					  <%if(payId == 60&&strOrderStatus == 0){ %>
					   <tr><td height="20">
					    <br/><br/>
					    <a name="wxPay"></a>
				 <div id="paywximg"></div>
				  <br/>
				 <font color="red"> 请打开微信，用微信里的“扫一扫”支付
				  
                  </font><br/>
				  <img src="http://images.d1.com.cn/images2012/New/user/sologo.jpg" style=" vertical-align:bottom;" /><font color="#e60000" style=" font-size:16px; font-weight:normal;font-family:'宋体';">特别提示：<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0603" target="_blank"  style="font-family:'宋体';">D1优尚购物安全提醒</a></font>
			 
	   <script language="javascript">
	   weixinpayimg();
	   function weixinpayimg(){
				   $.ajax({
						type: "get",
						dataType: "json",
						url: '/interface/pay/weixinpay/webwxpay.jsp',
						data:{OdrID:<%=orderid%>},
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
					   
					   </td></tr>
					   <%} %>
					   <tr><td style=" text-align:left;"><span style=" font-size:14px;"><b><%
							   if (Tools.isNull(chePingAn)){
								   if(points > 0){
									   if(comment != null || Tools.dateValue(ob.getOdrmst_shipdate()) < System.currentTimeMillis()-Tools.MONTH_MILLIS){
										   %>您本次购物已获得积分：<font color="#e2403e"><%=ProductGroupHelper.getRoundPrice(new Float(ob.getOdrmst_acturepaymoney().floatValue()+ob.getOdrmst_prepayvalue().floatValue())) %></font>分<%
									   }else{
										   %>您本次购物将获得积分：<font color="#e2403e"><%=ProductGroupHelper.getRoundPrice(new Float(ob.getOdrmst_acturepaymoney().floatValue()+ob.getOdrmst_prepayvalue().floatValue())) %></font>分<%
									   }
								   }
							   }
					   
					   
					   %></b></span>
					   <%if (Tools.isNull(chePingAn)){ %>
					   &nbsp;&nbsp;<a href="/help/helpnew.jsp?code=0104" target="_blank">积分规则</a>
					   <%} %>
					   </td></tr>
					  <tr><td height="20"></td></tr>
		   		    </table>
					
			  </div>
			  
			  <!--虚线-->
			   <table width="980" border="0" cellspacing="0" cellpadding="0">
			     <tr><td style=" border:dashed 1px #c2c2c2;"></td></tr>
				 <tr><td height="50"></td></tr>
			  </table>
			  
			  
			
		
            <%
			  			  					            	}
			  			  					            %>
 
		  </div>
 
 <div class="clear"></div>
   
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
 
 
 
</body>
</html>

