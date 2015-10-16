<%@ page contentType="text/html; charset=UTF-8"%><%!
public static String getHeader(){
	/**
	"header":{"token":"b2a974e7bab36210bd79bde7b25d1017",   //百度提供的token
            "username":"jingdong",                        //百度账号用户名
            "password":"*********"                        //百度账号密码
           }
	*/
	StringBuilder sb=new StringBuilder();
	sb.append("\"header\":{\"token\":\"4526ec9e0e33efdb3dd5650c8da679d3\",");   //百度提供的token
	sb.append("\"username\":\"D1优尚网\",");                     //百度账号用户名
	sb.append("\"password\":\"Hellod1\"}");                     //百度账号密码
	return sb.toString();
      
}

%>