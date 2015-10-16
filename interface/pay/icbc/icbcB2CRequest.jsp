<%@ page language="java" pageEncoding="GBK" import="org.apache.log4j.PropertyConfigurator,icbcB2C.model.*,icbcB2C.pay.*"%><%@include file="/html/header.jsp" %>
	<%    
		////////////////////////////////////请求参数//////////////////////////////////////
	/*	String strOdrID = request.getParameter("OdrID");
	strOdrID="130528004693";
if(Tools.isNull(strOdrID)){
	out.print("订单号出错！");
	return;
}
OrderBase order = OrderHelper.getById(strOdrID);
if(lUser==null){
	response.sendRedirect("/login.jsp");
}
if(order == null){
	out.print("查询订单出错！");
	return;
}
if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	out.print("查询订单出错。");
	return;
}
if(Tools.longValue(order.getOdrmst_orderstatus()) != 0){
	out.print("您的订单不在未支付状态！");
	return;
}
//防止刷页面
Long lastPostTime = (Long)Const.LIMIT_HASH_MAP.get(new Long(lUser.getId()));
if(lastPostTime!=null){
	if(System.currentTimeMillis()-lastPostTime.longValue()<Const.LIMIT_MILLSECONDS){
		out.println("请不要刷页面！");
		return;
	}
}
Const.LIMIT_HASH_MAP.put(new Long(lUser.getId()),new Long(System.currentTimeMillis()));

PropertyConfigurator.configure("D:/log4j.properties"); //加载log4j配置文件
		String total_fee = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney()));//订单总价
		String OrderDate=Tools.getDBDate();//交易时间
		String GoodsType="1";//虚拟商品/实物商品标志位  取值“0”：虚拟商品；取值“1”，实物商品。
		//String MerCustomID=lUser.getMbrmst_uid();//买家用户号
		//String MerCustomPhone=order.getOdrmst_pusephone();//买家联系电话
		//String GoodsAddress=order.getOdrmst_raddress();//收货地址
		String Amount=Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney())*100);//订单金额
		//String CarriageAmt="";//已含运费金额
		//String GoodsID="";//商品编号
		String GoodsName="D1优尚网" + strOdrID + "订单";//商品名称
		//String GoodsNum="";//商品数量
		String InstallmentTimes="1";//分期付款期数  1代表全额付款
		String Orderid=strOdrID;//订单号  
		IcbcB2CPay pay=new IcbcB2CPayImpl(); 
		TranData t=new TranData();//tranData对象
		List l=new ArrayList();
		
		t.setOrderDate(OrderDate);
		t.setGoodsType(GoodsType);
		//t.setMerCustomID(MerCustomID);
		//t.setMerCustomPhone(MerCustomPhone);
		//t.setGoodsAddress(GoodsAddress);
			
			OrderInfo o=new OrderInfo();//订单对象
			o.setAmount(Amount);
			//o.setCarriageAmt(CarriageAmt);
			//o.setGoodsID(GoodsID);
			o.setGoodsName(GoodsName);
			//o.setGoodsNum(GoodsNum);
			o.setInstallmentTimes(InstallmentTimes);
			o.setOrderid(Orderid);
			l.add(o);
				
		
	
		t.setOrderInfoVector(l);//将订单信息加到tranData对象中
		FormData fd=pay.createFormData("D:/b2c.xml",t);//调用CreateFormData方法，生成formData中的表单数据
		//request.setAttribute("InterfaceName", fd.getInterfaceName());	//生成的接口名称
		//request.setAttribute("InterfaceVersion", fd.getInterfaceVersion());	//生成的接口版本号
		//request.setAttribute("MerCert", fd.getMerCert());	//生成的交易数据
		//request.setAttribute("MerSignMsg", fd.getMerSignMsg());	//生成的订单签名数据
		//request.setAttribute("TranData", fd.getTranData());	//生成的商城证书公钥
	
		String interfaceName=fd.getInterfaceName();
		String interfaceVersion=fd.getInterfaceVersion();
		String merCert=fd.getMerCert();
		String merSignMsg= fd.getMerSignMsg();
		String tranData=fd.getTranData();
	
		
		
		String strPostUrl="https://mybank3.dccnet.com.cn/servlet/ICBCINBSEBusinessServlet";
		 StringBuilder strPost=new StringBuilder();
	    strPost.append("interfaceName"+interfaceName);
        strPost.append("&interfaceVersion="+interfaceVersion);
        strPost.append("&merCert="+merCert);
        strPost.append("&merSignMsg="+merSignMsg);
        strPost.append("&tranData="+tranData);
        
      //  String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
        
        
       // out.print(ret);*/
	%>
<!--  <form name="theForm" method="post" action="https://mybank3.dccnet.com.cn/servlet/ICBCINBSEBusinessServlet" >
		<INPUT NAME="interfaceName" TYPE="text" value="<%//=interfaceName %>" >
        <INPUT NAME="interfaceVersion" TYPE="text" value="<%//=interfaceVersion %>">
		<INPUT NAME="tranData" TYPE="text" value="<%//=tranData.toString() %>">
		<INPUT NAME="merSignMsg" TYPE="text" value="<%//=merSignMsg %>">
		<INPUT NAME="merCert" TYPE="text" value="<%//=merCert %>"> 
		<input type="submit" class="button" value="提交">
	</form>-->
