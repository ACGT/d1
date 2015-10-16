<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="../islogin.jsp" %><%
String Action = request.getParameter("Action");

boolean isAdd = false;
UserAddress address = null;

if("new_save_consignee".equals(Action)){//添加收货人
	isAdd = true;
}else if("update_save_consignee".equals(Action)){//修改收货人
	String strAddressId = request.getParameter("MbrcstID");
	address = UserAddressHelper.getById(strAddressId);
	if(address == null){
		out.print("iRet=-213;iMbrcstID=-1;");
		return;
	}
	if(!lUser.getId().equals(String.valueOf(address.getMbrcst_mbrid()))){
		out.print("iRet=-214;iMbrcstID=-1;");
		return;
	}
}else{
	out.print("您暂时无法进行操作");
	return;
}
String strName = request.getParameter("Name");//收货人姓名
strName = Tools.simpleCharReplace(strName);
if(Tools.isNull(strName)){
	out.print("iRet=-208;iMbrcstID=-1;");
	return;
}
int iByteLength = StringUtils.strLength(strName);
if(iByteLength > 20){
	out.print("iRet=-202;iMbrcstID=-1;");
	return;
}

long strSex = Tools.parseLong(request.getParameter("Sex"));//性别

String strProvinceID = request.getParameter("ProvinceID");//省份
long bProvince = Tools.parseLong(strProvinceID);
if(bProvince <= 0){
	out.print("iRet=-203;iMbrcstID=-1;");
	return;
}

String strCityID = request.getParameter("CityID");//城市
long sCityID = Tools.parseLong(strCityID);
if(sCityID <= 0){
	out.print("iRet=-204;iMbrcstID=-1;");
	return;
}

String strRAddress = request.getParameter("RAddress");//地址
strRAddress = Tools.simpleCharReplace(strRAddress);
if(Tools.isNull(strRAddress)){
	out.print("iRet=-209;iMbrcstID=-1;");
	return;
}
iByteLength = StringUtils.strLength(strRAddress);
if(iByteLength >200){
	out.print("iRet=-205;iMbrcstID=-1;");
	return;
}

String strRPhone = request.getParameter("RPhone");//手机
if(!Tools.isMobile(strRPhone)){
	out.print("iRet=-210;iMbrcstID=-1;");
	return;
}

String strTelePhone = request.getParameter("TelePhone");//固话

String strREmail = request.getParameter("REmail");//email
/*if(!Tools.isEmail(strREmail)){
	out.print("iRet=-211;iMbrcstID=-1;");
	return;
}*/

String strRZipcode = request.getParameter("RZipcode");//邮编
if(strRZipcode.length()>0 &&( !Tools.isMath(strRZipcode) || strRZipcode.length()!=6 )){
	out.print("iRet=-212;iMbrcstID=-1;");
	return;
}

//是否有相同的地址。
if(UserAddressHelper.isSameAddress(lUser.getId(),isAdd?"0":address.getId(),strName,strRAddress)){
	out.print("iRet=-206;iMbrcstID=-1;");
	return;
}

boolean isClearCache = false;

if(isAdd){
	address = new UserAddress();
	//查找当前用户有几个地址。
	long maxId = UserAddressHelper.getUserMaxId(lUser.getId());
	
	address.setMbrcst_id(new Long(maxId));
	address.setMbrcst_mbrid(Long.parseLong(lUser.getId()));
	address.setCreatedate(new Date());
}
address.setMbrcst_name(strName);
address.setMbrcst_rsex(new Long(strSex));
address.setMbrcst_relation("");
address.setMbrcst_countryid(new Long(1));
address.setMbrcst_provinceid(new Long(bProvince));
address.setMbrcst_cityid(new Long(sCityID));
address.setMbrcst_raddress(strRAddress);
address.setMbrcst_rzipcode(strRZipcode);
address.setMbrcst_remail(strREmail);
address.setMbrcst_rphone(strRPhone);
address.setMbrcst_rtelephonecode("");
address.setMbrcst_rtelephone(strTelePhone);
address.setMbrcst_rtelephoneext("");
address.setMbrcst_memo("");
address.setMbrcst_rthird(new Long(0));
address.setUpdatedate(new Date());
if(isAdd){
	address = (UserAddress)UserAddressHelper.manager.create(address);
	if(address != null && address.getId() != null){
		out.print("iRet=1;iMbrcstID=" + address.getId() + ";");
	}else{
		out.print("iRet=-207;iMbrcstID=-1;");
	}
}else{
	if(UserAddressHelper.manager.update(address,isClearCache)){
		out.print("iRet=1;iMbrcstID=" + address.getId() + ";");
	}else{
		out.print("iRet=-207;iMbrcstID=-1;");
	}
}
%>