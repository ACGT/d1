<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*"%>

<%!
/**
 * 得到一个上传目录名
 * @return String
 */
public static String getUploadFilePath(){
	
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
	return dirName;
}

%>