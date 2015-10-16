<%@ page contentType="text/html; charset=GBK"%><%@page import="java.util.*,java.io.*"%><%!
public String stringToASCII(String transParam) {
	// 不满足要求，直接返回null
	if (transParam == null || transParam.length() == 0) {
		return null;
	}

	char[] transChars = transParam.toCharArray();
	String ascii = "";

	// 字符转换为数字，并拼接为ASCII码
	int charASCII = -1;
	for (int i = 0; i < transChars.length; i++) {
		charASCII = (int) transChars[i];

		// 如果为73(I)、79(O)，自增
		if (charASCII == 73 || charASCII == 79) {
			charASCII++;
		}
		ascii += charASCII;
	}

	return ascii;
}
%><%

	Enumeration<String> params = request.getParameterNames();

	ArrayList<String> list = new ArrayList<String>();
	/*
	HashMap<String,String> map = new HashMap<String,String>();
	*/
	while(params.hasMoreElements()){
		String p = params.nextElement();
		//list.add(stringToASCII(p));
		list.add(p);
		//map.put(stringToASCII(p), p);
	}
	
	Collections.sort(list);
	
    String queryString = "";
    
    if(list!=null){
    	for(String x:list){
    		//String p = map.get(x);
    		//if(!p.equals("sign")){
    	   // queryString+=p+"="+request.getParameter(p)+"&";	}
    	   if(!x.equals("sign"))
    	   {
    		   queryString+=x+"="+request.getParameter(x)+"&";
    	   }
    	
    	}
    }
    //queryString="input_charset=gbk&product_id=01710457&req_seq=1320891028&service_version=1.0&sign_key_index=1&sign_type=md5&";
	queryString += "key=zyshu910320flzhen930622clhuang87";
	//queryString += "key=123456";
	//out.println("=====queryString========"+queryString+"===============");
	
	String sign = com.d1.util.MD5.to32MD5(queryString);
	
	
	sign = sign.toUpperCase();
	
	System.out.println("=======sign======"+sign+"================");
	
	String  service_version=request.getParameter("service_version");
    String  input_charset=request.getParameter("input_charset");
    String  sign_key_index=request.getParameter("sign_key_index");
    String  req_seq=request.getParameter("req_seq"); 
    String  sign_type=request.getParameter("sign_type");
    String arg1=request.getParameter("arg1");
    String arg2=request.getParameter("arg2");
    String arg3=request.getParameter("arg3");
    String arg4=request.getParameter("arg4");

    boolean result=false;
	if(!sign.equals(request.getParameter("sign"))){
		//System.out.println("验证未通过");
		result=false;
	}else{
		//System.out.println("验证通过");
		result=true;
	}
	
	//result=true;
	

%>