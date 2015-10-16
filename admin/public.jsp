<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*"%>

<%!
/**
 * 得到一个上传目录名
 * @return String
 */
public static String getUploadFilePath(String catname){
	
	Calendar calendar = Calendar.getInstance();
	
	int m = (calendar.get(Calendar.MONTH)+1);
	String month = null;
	if(m<10)month="0"+m;
	else month=m+"";
	
	int d = calendar.get(Calendar.DAY_OF_MONTH);
	String day = null;
	if(d<10)day="0"+d;
	else day = ""+d;
	
	String dirName = String.valueOf(calendar.get(Calendar.YEAR))+"/"+month+"/"+day+"/";
	return "/opt/shopimg/"+catname+"/"+dirName;
}
//判断权限是否有操作权限
public boolean chk_admpower(String userid ,String powername){
	 if(userid == null || powername == null){
		  return false;
	 }
	 ArrayList<AdminPower> aplist = AdminPowerHelper.getAwardByGdsid(userid, powername);
	 //System.out.println((aplist==null?0:aplist.size())+"+++++++++++++++++++");
	 if(aplist==null||aplist.size()<=0){
		  return false;
	 }
	 return true;
}

%>