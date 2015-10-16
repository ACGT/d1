<%@ page language="java" contentType="text/html; charset=UTF-8" import="icbcB2C.model.*,icbcB2C.notify.*"%><%@include file="/html/header.jsp" %><%@include file="../PayConfig.jsp"%>
<%  /*
if(lUser==null){
	response.sendRedirect("/login.jsp");
}
	String strNotifyData=request.getParameter("strNotifyData");
String signMsg="";
IcbcB2CNotifyImpl notify=new IcbcB2CNotifyImpl();
NotifyData notifyData=new NotifyData();
if(!Tools.isNull(strNotifyData)){
notifyData=notify.createNotifyData(strNotifyData, signMsg, "D:/b2c.xml");//"D:/b2c.xml"为配置文件的存放路径，商户自行更改。
//如果验签失败，或者证书有误等原因，notifyData的返回值都为null，具体原因，请商户自行查看生成的日志。
if(notifyData==null)
{
	System.out.println("返回值为null，解析银行通知消息报错。");
	
}
else
{
	//打印出解析出的notifyData各项信息
	
	System.out.println("Comment:"+notifyData.getComment());//错误描述
	System.out.println("CurType:"+notifyData.getCurType());//支付币种
	System.out.println("InterfaceName:"+notifyData.getInterfaceName());//接口名称
	System.out.println("InterfaceVersion:"+notifyData.getInterfaceVersion());//接口版本号
	System.out.println("JoinFlag:"+notifyData.getJoinFlag());//客户联名标志
	System.out.println("MerID:"+notifyData.getMerID());//商户代码
	System.out.println("NotifyData:"+notifyData.getNotifyData());//NotifyData的明文XML串
	System.out.println("NotifyDate:"+notifyData.getNotifyDate());//返回通知日期时间
	System.out.println("OrderDate:"+notifyData.getOrderDate());//交易日期时间
	System.out.println("TranBatchNo:"+notifyData.getTranBatchNo());//批次号
	System.out.println("TranStat:"+notifyData.getTranStat());//订单处理状态
	System.out.println("UserNum:"+notifyData.getUserNum());//联名会员号
	System.out.println("VerifyJoinFlag:"+notifyData.getVerifyJoinFlag());//检验联名标志
	
	String remark=notifyData.getComment();
	String transtatus=notifyData.getTranStat();
	List orderInfoList=notifyData.getSubOrderInfoList();
	for(int i=0;i<orderInfoList.size();i++)
	{
		int num=i+1;
		
		NotifyOrderInfo notifyOrderInfo=(NotifyOrderInfo)orderInfoList.get(i);
		System.out.println("orderid:"+notifyOrderInfo.getOrderid());//订单号
		System.out.println("amount:"+notifyOrderInfo.getAmount());//订单金额
		System.out.println("installmentTimes:"+notifyOrderInfo.getInstallmentTimes());//分期付款期数
		System.out.println("merAcct:"+notifyOrderInfo.getMerAcct());//商户账号
		System.out.println("tranSerialNo:"+notifyOrderInfo.getTranSerialNo());//银行指令序号
		
		String orderid=notifyOrderInfo.getOrderid();
		String ordermoney=notifyOrderInfo.getAmount();
		if("1".equals(transtatus)){
			/*OrderBase order = OrderHelper.getById(orderid);
			if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
				
				double r3_amount = Tools.parseDouble(ordermoney);
				
				OrderService os = (OrderService)Tools.getService(OrderService.class);
				int reValue = os.updateOrderStatus(order,r3_amount);
		        if(reValue == 0){
		        	logInfo("工商银行，订单："+orderid+"支付成功！");
		        }
			}*/
			/*System.out.println("工商银行，订单："+orderid+"支付成功！");
			logInfo("工商银行，订单："+orderid+"支付成功！");
		}else{
			System.out.println("工商银行，订单："+orderid+"支付失败！错误描述："+remark);
			logInfo("工商银行，订单："+orderid+"支付失败！错误描述："+remark);
		}
		
	}
	
}
}else{

System.out.println("返回参数为空！");

}*/
	%>