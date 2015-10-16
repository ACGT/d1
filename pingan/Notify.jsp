<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%@include file="../inc/islogin.jsp"%>
<%@page import="
com.pingan.cert.Verify.*,
com.pingan.cert.Interface.*,
com.d1.bean.OrderBase,
com.d1.bean.PingAnUser,
com.d1.helper.OrderHelper,
com.d1.helper.UserHelper,
java.net.URLEncoder,
java.text.SimpleDateFormat,
java.util.Date
"%>
<%
String  PointsLeft=request.getParameter("PointsLeft");		//剩余积分
			String  AmountLeft=request.getParameter("AmountLeft");	    //剩余金额
			String  PointsRedemed=request.getParameter("PointsRedemed");	//扣减积分
			String  AmountRedemed=request.getParameter("AmountRedemed");	//扣减金额
			String  STNumber=request.getParameter("STNumber");			//万里通交易流水号
			String  MemberID=request.getParameter("MemberID");			//万里通会员编号
			String  Created=request.getParameter("Created");			//创建时间
			String  PointType=request.getParameter("PointType");			//点数类型
			String  TTNumber=request.getParameter("TTNumber");			//D1订单号	
			String  sysDate=request.getParameter("sysDate");				//时间戳
			String  Ext1=request.getParameter("Ext1");					//扩展参数
			String  ErrorCode=request.getParameter("ErrorCode");			//错误代码
			String  ErrorMessage=request.getParameter("ErrorMessage");	//错误描述
			String  paSignature=request.getParameter("paSignature");		//签名
			
			String strsign=request.getQueryString();
			
			boolean resultTrue = VerifyCertData.chkSign(strsign);

			if (!resultTrue){
				System.out.println("验签失败");
				return;
			}
			 //05/11/2009 11:24:04平安传系统时间明文格式 
			try{
			String strDecodeSysDate= URLDecoder.decode(sysDate,"UTF-8");
			java.util.Date   nows=new   java.util.Date();   
			SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
			
			Date dsys=format.parse(strDecodeSysDate);
			long   mins=(dsys.getTime()-nows.getTime())/(60*1000);  
			  if(mins>5)
			  {
				    System.out.println("验证超时");
				    return;
			  }
			}
			catch (Exception ex)
			{
				 ex.printStackTrace();
			}
			if(!"00".equals(ErrorCode)){
				System.out.println("D1订单号："+TTNumber+"支付失败！");
			    return;
			}
			else{
				OrderBase order=OrderHelper.getById(TTNumber);
				if(order==null){System.out.print("订单号不存在");return;}
				PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", order.getOdrmst_mbrid());
				//System.out.println("d1gjlpa:"+pauser);
				//System.out.println("d1gjlpa:"+order.getOdrmst_orderstatus()+" "+order.getId());
				if (pauser==null || order.getOdrmst_orderstatus().longValue()!=0){
					System.out.print("会员号存在或订单状态不对！");return;
				}
				/*
				synchronized(order){
				SimpleDateFormat fmtr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+fmtr.format(new Date())+"万里通积分支付自动收款<br>");
			    order.setOdrmst_validdate(new Date());
			    order.setOdrmst_orderstatus(new Long(2));
			    order.setOdrmst_getmoney(Tools.getFloat(new Float(AmountRedemed), 2));
			   Tools.getManager(order.getClass()).update(order, true);*/
			  // System.out.println("d1gjlpa:"+TTNumber);
			   PingAnScorePay pinganodr=new PingAnScorePay();
			    pinganodr.setPinganodr_operation("Redemption");
			    pinganodr.setPinganodr_partner("79_0");
			    pinganodr.setPinganodr_memberid(MemberID);
			    pinganodr.setPinganodr_amount(new Float(AmountRedemed));
			    pinganodr.setPinganodr_ttnumber(TTNumber);
			    pinganodr.setPinganodr_tttime(order.getOdrmst_orderdate());
			    pinganodr.setPinganodr_param("0902079");
			    pinganodr.setPinganodr_odrid(TTNumber);
			    pinganodr.setPinganodr_status(new Long(0));
			    pinganodr = (PingAnScorePay)Tools.getManager(PingAnScorePay.class).create(pinganodr);
			    OrderService os =  (OrderService)Tools.getService(OrderService.class);
			    os.updateOrderStatus(order,Tools.parseFloat(AmountRedemed));
			    
			    //System.out.println("d1gjlpa:"+AmountRedemed);
			  
                
				//}
			    out.print("支付成功！");
			    
			}
%>