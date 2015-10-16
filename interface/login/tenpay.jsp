<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%><%!
/////////
private Map<String,String> parameters = new HashMap<String,String>();

/**
 * 生成md5的sign码
 * @return String
 */
private String createSign(){
	StringBuilder sb = new StringBuilder();
	
	List<String> keys = new ArrayList<String>(parameters.keySet());
	Collections.sort(keys);
	
	for(String key : keys){
		String value = parameters.get(key);
		if(!Tools.isNull(value) && "sign".compareTo(key)!=0 && "key".compareTo(key)!=0){
			sb.append(key).append("=").append(value).append("&");
		}
	}
	sb.append("key=").append(PubConfig.get("TenPaySPKey"));
	
	String sign = MD5.to32MD5(sb.toString());
	
	return sign;
}

/**
 * 生成用户的目标跳转地址
 */
public String getAuthorizationURL() {
	parameters.put("sign_type", "md5");//签名类型
	parameters.put("sign_encrypt_keyid", "0");
	parameters.put("input_charset", "UTF-8");
	parameters.put("service", "login");//服务名称
	parameters.put("chnid", PubConfig.get("TenPayPartner"));//商户名
	parameters.put("chtype", "0");//Chnid类型。0：商户号，默认值为0,1:财付通账户
	parameters.put("redirect_url", PubConfig.get("TenPayLoginRedirectUrl"));//回调地址
	parameters.put("tmstamp", String.valueOf(System.currentTimeMillis()/1000));
	
	//生成sign
	parameters.put("sign", createSign());
	
	StringBuilder sb = new StringBuilder();
	
	List<String> keys = new ArrayList<String>(parameters.keySet());
	Collections.sort(keys);
	
	try {
		for(String key : keys){
			String value = parameters.get(key);
			if (null != value && "key".compareTo(key) != 0){
				sb.append(key).append("=").append(URLEncoder.encode(value, "GBK")).append("&");
            }
		}
		//去掉最后一个&
        if (sb.length() > 0){
        	int length = sb.length();
            sb.delete(length-1, length);
        }
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
	
	return PubConfig.get("TenPayLoginUrl")+"?"+sb.toString();
}
%><%
response.sendRedirect(getAuthorizationURL());
%>