<%@ page contentType="text/html; charset=GBK" import="com.yeepay.*" %><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%><%!
//�Ƿ���ʾ����̨��ӡ������Ϣ
private static final boolean isDebug = true;

//��ӡ��־
private static void logInfo(String log){
	if(isDebug) System.err.println(Tools.stockFormatDate(new Date())+"��"+log);
}
%><%
String keyValue = Tools.formatString(PubConfig.get("YeepayKey"));   // �̼���Կ
String p1_MerId = Tools.formatString(PubConfig.get("YeepayPartner"));   // �̻����
String r0_Cmd 	= Tools.formatString(request.getParameter("r0_Cmd"));										  // ҵ������
String r1_Code  = Tools.formatString(request.getParameter("r1_Code"));										// ֧�����
String r2_TrxId = Tools.formatString(request.getParameter("r2_TrxId"));										// �ױ�֧��������ˮ��

String r3_Amt   = Tools.formatString(request.getParameter("r3_Amt"));											// ֧�����
String r4_Cur   = Tools.formatString(request.getParameter("r4_Cur"));											// ���ױ���
String r5_Pid   = Tools.formatString(request.getParameter("r5_Pid"));											// ��Ʒ����
String r6_Order = Tools.formatString(request.getParameter("r6_Order"));										// �̻�������

String r7_Uid   = Tools.formatString(request.getParameter("r7_Uid"));											// �ױ�֧����ԱID
String r8_MP    = Tools.formatString(request.getParameter("r8_MP"));											// �̻���չ��Ϣ
String r9_BType = Tools.formatString(request.getParameter("r9_BType"));										// ���׽����������
String hmac     = Tools.formatString(request.getParameter("hmac"));// ǩ������

boolean isOK = false;
logInfo("�ױ�֧����"+r3_Amt+"--->"+r6_Order+"--"+r8_MP);
// У�鷵�����ݰ�
isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code, 
		r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
if(isOK) {
	if(r1_Code.equals("1")) {
		double r3_amount = Tools.parseDouble(r3_Amt);
		//���������
		String url = "/index.jsp";
		//��ö���
		OrderBase order = OrderHelper.getById(r6_Order);
		if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
			OrderService os = (OrderService)Tools.getService(OrderService.class);
			int reValue = os.updateOrderStatus(order,r3_amount);
	        if(reValue == 0){
	        	logInfo("�ױ�֧����������"+r6_Order+"֧���ɹ���");
	        }
		}
		out.println("SUCCESS");
		if(r9_BType.equals("1")) {// ��Ʒͨ�ýӿ�֧���ɹ�����-������ض���
			response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
			return;
		} else if(r9_BType.equals("2")) {// ��Ʒͨ�ýӿ�֧���ɹ�����-��������Ե�ͨѶ
			// ����ڷ���������ʱ	����ʹ��Ӧ�����ʱ������Ӧ����"success"��ͷ���ַ�������Сд������
			out.println("SUCCESS");
		} else if(r9_BType.equals("3")) {// ��Ʒͨ�ýӿ�֧���ɹ�����-�绰֧������	
			
		}else{
			response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
			return;
		}
		// ����ҳ������ǲ���ʱ�۲���ʹ��
		out.println("<br>���׳ɹ�!<br>�̼Ҷ�����:" + r6_Order + "<br>֧�����:" + r3_Amt + "<br>�ױ�֧��������ˮ��:" + r2_TrxId);
	}
} else {
	out.println("����ǩ�����۸�!");
}
%>