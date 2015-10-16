<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
//得到收货人地址列表
//收获地址
ArrayList<UserAddress> addressList = UserAddressHelper.getUserAddressList(lUser.getId());
if(addressList == null || addressList.isEmpty()){
	out.print("{\"success\":false,\"message\":\"找不到收货人！\"}");
	return;
}

String m_iLastMbrcstID = "0";//上一次使用的地址
StringBuilder sb = new StringBuilder();
int j=0;
for(UserAddress address:addressList){
	if(address.getMbrcst_countryid().intValue()!=100 && Tools.isNull( address.getMbrcst_memo())){
		j++;
	}
}
//if(j==0){
	//out.print("{\"success\":false,\"message\":\"找不到收货人！\"}");
	//return;
//}
if(j>0){
	sb.append("<table width=\"861\" border=\"0\" align=\"center\" cellpadding=\"4\" cellspacing=\"0\" id=\"tblTop5Mbrcst\">");
}
int size = addressList.size();
for(int i=0;i<size;i++){
	UserAddress address = addressList.get(i);
	if(address.getMbrcst_countryid().intValue()!=100 && Tools.isNull( address.getMbrcst_memo())){
		String id = address.getId();
		sb.append("<tr id=\"address_").append(id).append("\">");
		sb.append("<td align=\"right\" style=\"width:100px\"><input type=\"radio\" name=\"rdoMbrcstList\" value=\"").append(id).append("\"").append(id.equals(m_iLastMbrcstID)?" checked":"").append(" onclick=\"ChangeMbrcst(this)\" /></td>");
		sb.append("<td width=\"100\" class=\"t00\" id=\"tdName").append(id).append("\" align=\"left\">").append(address.getMbrcst_name()).append("</td>");
		sb.append("<td align=\"left\" class=\"t00\" id=\"tdAddress").append(id).append("\">").append(address.getMbrcst_raddress()).append("</td>");
		sb.append("<td width=\"40\" class=\"t00\"><a href=\"###\" onclick=\"javascript:GetUpdMbrcst('").append(id).append("')\">修改</a></td>");
		sb.append("<td width=\"40\" class=\"t00\"><a href=\"###\" onclick=\"javascript:DeleteMbrcst('").append(id).append("')\">删除</a></td>");
		sb.append("</tr>");
	}
	
}
if(j>0){
sb.append("</table>");
}

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));
map.put("message",sb.toString());
map.put("LastAddressID",m_iLastMbrcstID);

out.print(JSONObject.fromObject(map));
return;
%>