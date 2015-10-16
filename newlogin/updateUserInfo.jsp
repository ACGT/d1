<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="/inc/islogin.jsp" %>
<%!
public static Date stringToDate(String str) {
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date date = null;
    try {
        date = format.parse(str); 
    } catch (ParseException e) {
        e.printStackTrace();
    }
    //date = java.util.Date.valueOf(str);
                                         
    return date;
}
%>
<%

String strName = request.getParameter("Name");//收货人姓名
strName = Tools.simpleCharReplace(strName);
if(Tools.isNull(strName)){
	out.print("-208");
	return;
}
int iByteLength = StringUtils.strLength(strName);
if(iByteLength > 20){
	out.print("-202");
	return;
}

long strSex = Tools.parseLong(request.getParameter("Sex"));//性别
if(strSex != 0 && strSex != 1) strSex = 0;

String strProvinceID = request.getParameter("ProvinceID");//省份
long bProvince = Tools.parseLong(strProvinceID);
if(bProvince <= 0){
	out.print("-203");
	return;
}

String strCityID = request.getParameter("CityID");//城市
long sCityID = Tools.parseLong(strCityID);
if(sCityID <= 0){
	out.print("-204");
	return;
}

String strRAddress = request.getParameter("RAddress");//地址
strRAddress = Tools.simpleCharReplace(strRAddress);
if(Tools.isNull(strRAddress)){
	out.print("-209");
	return;
}


String strRPhone = request.getParameter("RPhone");//手机
if(!Tools.isMobile(strRPhone)){
	out.print("-210");
	return;
}

String strTelePhone = request.getParameter("TelePhone");//固话

String strREmail = request.getParameter("REmail");//email
if(!Tools.isEmail(strREmail)){
	out.print("-211");
	return;
}

String strRZipcode = request.getParameter("RZipcode");//邮编
if(!Tools.isMath(strRZipcode) || strRZipcode.length()!=6){
	out.print("-212");
	return;
}
String year=request.getParameter("year");
if(!Tools.isNull(year)){
	int y=Integer.valueOf(year).intValue();
	int y2=Integer.valueOf(Calendar.getInstance().getTime().toLocaleString().substring(0, 4)).intValue();
	if(!Tools.isMath(year) || year.length()!=4 || y<1900 || y>y2){
		out.print("-213");
		return;
	}
}

boolean isClearCache = false;
String birth=year+"-"+request.getParameter("month")+"-"+request.getParameter("day");
User user=lUser;
//判断邮箱、手机号是否修改
String oldemail=user.getMbrmst_email();
String oldtel=user.getMbrmst_usephone();
//System.out.println("qqqqqqqqqqqqqqqqqqqqq"+oldtel);
if(!oldemail.equals(strREmail)){
	user.setMbrmst_mailflag(new Long(0));
}
if(!oldtel.equals(strRPhone)){
	user.setMbrmst_phoneflag(new Long(0));
}
//System.out.println(stringToDate(birth));
user.setMbrmst_birthday(stringToDate(birth));
user.setMbrmst_countryid(new Long(1));
user.setMbrmst_cityid(new Long(sCityID));
user.setMbrmst_email(strREmail);
user.setMbrmst_name(strName);
user.setMbrmst_provinceid(new Long(bProvince));
user.setMbrmst_postcode(strRZipcode);
user.setMbrmst_haddr(strRAddress);
user.setMbrmst_mphone(strRPhone);
user.setMbrmst_sex(new Long(strSex));
user.setMbrmst_usephone(strRPhone);
user.setMbrmst_hphone(strTelePhone);


Tools.getManager(user.getClass()).clearListCache(user);
if(Tools.getManager(user.getClass()).update(user, true)){
	int addrcount = UserAddressHelper.getUserAddressLength(user.getId());
	if(addrcount==0){
		UserAddress address = new UserAddress();
			//查找当前用户有几个地址。
			long maxId = UserAddressHelper.getUserMaxId(lUser.getId());
			
			address.setMbrcst_id(new Long(maxId));
			address.setMbrcst_mbrid(Long.parseLong(lUser.getId()));
			address.setCreatedate(new Date());
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
         UserAddressHelper.manager.create(address);
	}
	
	out.print("1"); 
		return;
	}else{
out.print("-1"); 
return;
		}

%>