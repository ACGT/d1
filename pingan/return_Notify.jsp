<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%@include file="../inc/islogin.jsp"%>
<%@page import="
com.pingan.cert.Verify.*,
com.pingan.cert.Interface.*,
java.io.BufferedReader,
java.io.InputStreamReader,
java.text.SimpleDateFormat,
java.util.Date,
java.util.Map,
javax.servlet.http.HttpServletRequest,
com.d1.bean.PingAnScorePay,
com.d1.util.Tools"
%>
<%StringBuffer sb = new StringBuffer();
String readLine;
BufferedReader responseReader;
//处理响应流，必须与服务器响应流输出的编码一致
responseReader = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
while ((readLine = responseReader.readLine()) != null) {
 sb.append(readLine).append("\n");
}
responseReader.close();
Map<String,String> map=null;
map=Tools.parseXML(sb.toString().replace("\n", ""));
String chkstr = "";
chkstr = chkstr + "PointsLeft=" + map.get("PointsLeft");
chkstr = chkstr + "&AmountLeft=" + map.get("AmountLeft");
chkstr = chkstr + "&PointsRedemed=" + map.get("PointsRedemed");
chkstr = chkstr + "&AmountRedemed=" + map.get("AmountRedemed");
chkstr = chkstr + "&STNumber=" + map.get("STNumber");
chkstr = chkstr + "&MemberID=" + map.get("MemberID");
chkstr = chkstr + "&Created=" + map.get("Created");
chkstr = chkstr + "&PointType=" + map.get("PointType");
chkstr = chkstr + "&TTNumber=" + map.get("TTNumber");
chkstr = chkstr + "&Ext1=" + map.get("Ext1");
chkstr = chkstr + "&ErrorCode=" + map.get("ErrorCode");
chkstr = chkstr + "&ErrorMessage=" + map.get("ErrorMessage");
chkstr = chkstr + "&BatchNo=" + map.get("BatchNo");
chkstr = chkstr + "&paSignature=" + map.get("paSignature");
boolean resultTrue = VerifyCertData.chkSign(chkstr);
String retErrorCode=null;
if (resultTrue){

   PingAnScorePay paodr=(PingAnScorePay)Tools.getManager(PingAnScorePay.class).findByProperty("pinganodr_ttnumber", map.get("TTNumber"));

if("00".equals(map.get("ErrorCode")) && !Tools.isNull(map.get("TTNumber"))){
     if(paodr==null){
     	/*pinganodr(pinganodr_operation,pinganodr_partner,pinganodr_memberId,pinganodr_amount,
     	 pinganodr_ttNumber,pinganodr_ttTime,pinganodr_param,pinganodr_odrID,
     	 pinganodr_status)
     	 values('Redemption','79_0','" + xstr[5] + "'," + xstr[3] + "
     	 ,'" + xstr[8] + "','" + xstr[6] + "','0902079','" + xstr[8] + "',0)";*/
     	 
     	SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
     	Date TTTime=format.parse(map.get("Created"));
     	paodr.setPinganodr_operation("Redemption");
     	paodr.setPinganodr_partner("79_0");
     	paodr.setPinganodr_memberid(map.get("MemberID"));
     	paodr.setPinganodr_amount(new Float(map.get("PointsRedemed")));
     	paodr.setPinganodr_ttnumber(map.get("TTNumber"));
     	paodr.setPinganodr_tttime(TTTime);
     	paodr.setPinganodr_param("0902079");
     	paodr.setPinganodr_odrid(map.get("TTNumber"));
     	paodr.setPinganodr_status(new Long(0));
      }
     else{
     	if(paodr.getPinganodr_status()<0 || paodr.getPinganodr_amount()!=new Float(map.get("PointsRedemed"))){
     		retErrorCode="订单状态或金额不正确";
     	}
     }
}
else{
	if(paodr!=null){
		if(paodr.getPinganodr_status()>0 && paodr.getPinganodr_amount()==new Float(map.get("PointsRedemed"))){
			{
				retErrorCode="订单状态出错";
			}
	}
}
}

}
else{
	retErrorCode="验签失败";
}

	StringBuffer strxml=new StringBuffer();
	strxml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><?Siebel-Property-Set EscapeNames=\"true\"?>");
	strxml.append("<PropertySet><SiebelMessage>");
	if (Tools.isNull(retErrorCode)){
		strxml.append("<ErrorCode>00</ErrorCode>");
		strxml.append("<ErrorMessage></ErrorMessage>");
	}
	else{
    	strxml.append("<ErrorCode>01</ErrorCode>");
    	strxml.append("<ErrorMessage>"+retErrorCode+"</ErrorMessage>");
	}

	strxml.append("</SiebelMessage></PropertySet>");
   System.out.print(strxml.toString());
%>
