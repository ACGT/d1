<%@ page language="java" pageEncoding="GBK" import="org.apache.log4j.PropertyConfigurator,icbcB2C.model.*,icbcB2C.pay.*"%><%@include file="/html/header.jsp" %>
	<%    
		////////////////////////////////////�������//////////////////////////////////////
	/*	String strOdrID = request.getParameter("OdrID");
	strOdrID="130528004693";
if(Tools.isNull(strOdrID)){
	out.print("�����ų���");
	return;
}
OrderBase order = OrderHelper.getById(strOdrID);
if(lUser==null){
	response.sendRedirect("/login.jsp");
}
if(order == null){
	out.print("��ѯ��������");
	return;
}
if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	out.print("��ѯ��������");
	return;
}
if(Tools.longValue(order.getOdrmst_orderstatus()) != 0){
	out.print("���Ķ�������δ֧��״̬��");
	return;
}
//��ֹˢҳ��
Long lastPostTime = (Long)Const.LIMIT_HASH_MAP.get(new Long(lUser.getId()));
if(lastPostTime!=null){
	if(System.currentTimeMillis()-lastPostTime.longValue()<Const.LIMIT_MILLSECONDS){
		out.println("�벻Ҫˢҳ�棡");
		return;
	}
}
Const.LIMIT_HASH_MAP.put(new Long(lUser.getId()),new Long(System.currentTimeMillis()));

PropertyConfigurator.configure("D:/log4j.properties"); //����log4j�����ļ�
		String total_fee = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney()));//�����ܼ�
		String OrderDate=Tools.getDBDate();//����ʱ��
		String GoodsType="1";//������Ʒ/ʵ����Ʒ��־λ  ȡֵ��0����������Ʒ��ȡֵ��1����ʵ����Ʒ��
		//String MerCustomID=lUser.getMbrmst_uid();//����û���
		//String MerCustomPhone=order.getOdrmst_pusephone();//�����ϵ�绰
		//String GoodsAddress=order.getOdrmst_raddress();//�ջ���ַ
		String Amount=Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney())*100);//�������
		//String CarriageAmt="";//�Ѻ��˷ѽ��
		//String GoodsID="";//��Ʒ���
		String GoodsName="D1������" + strOdrID + "����";//��Ʒ����
		//String GoodsNum="";//��Ʒ����
		String InstallmentTimes="1";//���ڸ�������  1����ȫ���
		String Orderid=strOdrID;//������  
		IcbcB2CPay pay=new IcbcB2CPayImpl(); 
		TranData t=new TranData();//tranData����
		List l=new ArrayList();
		
		t.setOrderDate(OrderDate);
		t.setGoodsType(GoodsType);
		//t.setMerCustomID(MerCustomID);
		//t.setMerCustomPhone(MerCustomPhone);
		//t.setGoodsAddress(GoodsAddress);
			
			OrderInfo o=new OrderInfo();//��������
			o.setAmount(Amount);
			//o.setCarriageAmt(CarriageAmt);
			//o.setGoodsID(GoodsID);
			o.setGoodsName(GoodsName);
			//o.setGoodsNum(GoodsNum);
			o.setInstallmentTimes(InstallmentTimes);
			o.setOrderid(Orderid);
			l.add(o);
				
		
	
		t.setOrderInfoVector(l);//��������Ϣ�ӵ�tranData������
		FormData fd=pay.createFormData("D:/b2c.xml",t);//����CreateFormData����������formData�еı�����
		//request.setAttribute("InterfaceName", fd.getInterfaceName());	//���ɵĽӿ�����
		//request.setAttribute("InterfaceVersion", fd.getInterfaceVersion());	//���ɵĽӿڰ汾��
		//request.setAttribute("MerCert", fd.getMerCert());	//���ɵĽ�������
		//request.setAttribute("MerSignMsg", fd.getMerSignMsg());	//���ɵĶ���ǩ������
		//request.setAttribute("TranData", fd.getTranData());	//���ɵ��̳�֤�鹫Կ
	
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
		<input type="submit" class="button" value="�ύ">
	</form>-->
