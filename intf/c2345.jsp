<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%!
public static Map getParameterMap(HttpServletRequest request) {
    // 参数Map
    Map properties = request.getParameterMap();
    // 返回值Map
    Map returnMap = new HashMap();
    Iterator entries = properties.entrySet().iterator();
    Map.Entry entry;
    String name = "";
    String value = "";
    while (entries.hasNext()) {
        entry = (Map.Entry) entries.next();
        name = (String) entry.getKey();
        Object valueObj = entry.getValue();
        if(null == valueObj){
            value = "";
        }else if(valueObj instanceof String[]){
            String[] values = (String[])valueObj;
            for(int i=0;i<values.length;i++){
                value = values[i] + ",";
            }
            value = value.substring(0, value.length()-1);
        }else{
            value = valueObj.toString();
           
        }
        returnMap.put(name, value);
    }
    return returnMap;
}
%>
<%
response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("UTF-8");



String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if (!Tools.isNull(httpurl)){
	try{
	       httpurl =java.net.URLDecoder.decode(httpurl,"UTF-8");
   }
   catch(Exception ex){
 	 // ex.printStackTrace();
	   response.sendRedirect("http://www.d1.com.cn");
   }
}
System.out.println(httpurl+"---------");
Map rmap=getParameterMap(request);

String fromip = request.getHeader("x-forwarded-for");
if(fromip == null || fromip.length() == 0 || "unknown".equalsIgnoreCase(fromip)) {
	fromip = request.getHeader("Proxy-Client-IP");
}
if(fromip == null || fromip.length() == 0 || "unknown".equalsIgnoreCase(fromip)) {
	fromip = request.getHeader("WL-Proxy-Client-IP");
}
if(fromip == null || fromip.length() == 0 || "unknown".equalsIgnoreCase(fromip)) {
	fromip = request.getRemoteAddr();
}
String strcp_key="0de04d25f205eddc9d521ea1f46dde9a";
    String strbid=rmap.get("bid").toString();
    String strurl=rmap.get("url").toString();
    String strext=rmap.get("ext").toString();
    String stractive_time=rmap.get("active_time").toString();
    String strfrom_url=rmap.get("from_url").toString();
    String strpassid=rmap.get("passid").toString();
    String strcompany_id=rmap.get("company_id").toString();
    String strsign=rmap.get("sign").toString();
    String strusername=rmap.get("username").toString();

   String signr=strbid+"#"+stractive_time+"#"+strcp_key+"#"+strpassid+"#"+strusername;
  
   String sign= MD5.to32MD5(signr, "Utf-8");
    //: $sign = md5(bid#active_time#cp_key#passid#username)
    		long acttime=(new Date()).getTime()/1000;
    		long mins=acttime-Tools.parseLong(stractive_time);
    		Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    	    Tools.setCookie(response,"C2345",strbid+"|"+strpassid+"|"+strusername+"|"+strext,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    	    
    	    IntfUtil.KillsCookies(response, "C2345");
    	    if (strurl!=null)
    	    {
    	        strurl=strurl.replace("*", "&");
    	    }
    	    if ("/inf/eqifa.jsp".equals(strurl))
    	    {
    	    	strurl="http://www.d1.com.cn";
    	    }
    	    System.out.println(mins+"========"+strsign+"----"+sign);
   if(mins/60>=15||!sign.equals(strsign)){
	String urlStr="http://cps.2345.com/server/gofailed/";
	String params="";
	
    
    
    String bid="2014070945";
    String signrnew=bid+"#"+acttime+"#"+strcp_key+"#"+strpassid+"#"+strusername;
    String signnew= MD5.to32MD5(signrnew, "Utf-8");
	params="bid="+bid+"&pre_bid="+strbid+"&url="+strurl+"&from_url="+httpurl+"&from_ip="+fromip;
	params+="&active_time="+acttime+"&ext="+strext+"&username="+strusername+"&pre_passid="+strpassid+"&pre_active_time="+stractive_time;
	params+="&pre_sign="+strsign+"&sign="+strbid;
	/*bid	合作网站编号, 是否为2345cps的判断	否
	pre_bid	异常的合作编号	否
	url	用户最终访问url，写入cookie后需跳转到该地址为空可跳转到首页	否
	from_url	请求来源url	否
	from_ip	异常的用户ip	否
	active_time	调用发起时间，精确到秒。	否
	ext	扩展字符串，需写入cookie，并保存到订单中，订单信息需写入数据库	是
	username	用户显示名称	是
	pre_passid	异常2345用户ID	是
	pre_active_time	异常的合作编号	否
	pre_sign	异常签名信息	否
	sign	签名信息	否*/
	  String reg= HttpUtil.getUrlContentByPost(urlStr, params, "utf-8");
	System.out.println("2345错误返回："+reg);
    }
   response.sendRedirect(strurl);
%>