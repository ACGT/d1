<%@ page contentType="text/html; charset=UTF-8"%><%@ page language="java" %><%@ page language="java" %>
<%@ page import = "java.net.*" %><%@ page import = "java.security.*" %><%@include file="/inc/header.jsp" %><%!
	static String APP_KEY = "c2fe79badc9972b2c5caf3846101944b";  /**填入的APP_KEY*/
	static String MERCHANT_ID = "d1bianli";	/**填入的APP_ID*/
	static String URL_ADDRESS = "http://open.cb.qq.com/OpenAPI/openkey/get_user_address.php";
	public String MD5(String s) 
	{
	    char hexDigits[] = {'0', '1', '2', '3', '4',
	                        '5', '6', '7', '8', '9',
	                        'A', 'B', 'C', 'D', 'E', 
	                        'F' };
	    try {
	        byte[] btInput = s.getBytes();
	        /*获得MD5摘要算法的 MessageDigest 对象*/
	        MessageDigest mdInst = MessageDigest.getInstance("MD5");
	        /*使用指定的字节更新摘要*/
	        mdInst.update(btInput);
	        /*获得密文*/
	        byte[] md = mdInst.digest();
	        /*把密文转换成十六进制的字符串形式*/
	        int j = md.length;
	        char str[] = new char[j * 2];
	        int k = 0;
	        for (int i = 0; i < j; i++) {
	            byte byte0 = md[i];
	            str[k++] = hexDigits[byte0 >>> 4 & 0xf];
	            str[k++] = hexDigits[byte0 & 0xf];
	        }
	        return new String(str);
	    }
	    catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	/**
	 * @brief    发送GET请求到彩贝地址接口
	 * @param    $url    - 发送GET请求的地址
	 * @param    $params - 请求中的所有参数
	 * @return   请求收到的响应
	 */
	public String  do_get(String strUrl) throws IOException{
		StringBuilder sb = new StringBuilder();
		URL url = new URL(strUrl);
		URLConnection cn = url.openConnection();

		BufferedReader br = new BufferedReader(new InputStreamReader(
				cn.getInputStream()));
		
		String line = null;
		while ((line = br.readLine()) != null) {
			sb.append(line);
		}
		return sb.toString();
	}
	
	/**
	 * @brief    计算加密串
	 * @param    $params - 生成sign所需要用到的参数
	 * @return   sign
	 **/
	public String generate_sign(Map maps) 
	throws CloneNotSupportedException {
		Object[] keys = maps.keySet().toArray();
		/**
		 *对keys按字母字典排序,冒泡算法;
		 **/
		boolean issort = false;
		Object tmp = "";
		String singStr = "";
		while(!issort){
			issort = true; 
			for(int i = 0;i < keys.length-1;i++){
				if(((String)keys[i]).compareTo((String)keys[i+1]) > 0){
					tmp = keys[i+1];
					keys[i+1] = keys[i];
					keys[i] = tmp;
					issort = false;
				}
			}
		}
		
		String str="";
		for(int i = 0; i < keys.length; i++){
			str+="|"+maps.get(keys[i]);
			singStr = singStr + maps.get(keys[i]);
		}
		//System.out.print(str);
		singStr = singStr+APP_KEY;
		
		/**进行签名，注意考虑到md5加密输出的大小写问题，所有约定md5的输出均为小写**/
			
		 String sing = MD5(singStr).toLowerCase();
		 return sing;
	}
	/**
	 * @brief 对字符串进行URL编码，遵循rfc1738 urlencode
	 * @param 需要用到的参数
	 * @return URL编码后的字符串
	 */
	public String get_urlencoded_string(Map maps){
		
		 Iterator iter = maps.entrySet().iterator();
		 String param = "";
		 while(iter.hasNext()){
				Map.Entry entry = (Map.Entry)iter.next();
				String key = (String)entry.getKey();
				String value = URLEncoder.encode((String)entry.getValue());
				param = param+"&"+key+"="+value;
		 }
		 if(param.length() > 1)
		 	param.substring(1);
		 return param;
	}
%>
<%
	/*主逻辑开始，商户只需添加或修改本demo中的TODO部分*/
	if(!Tools.isNull(Tools.getCookie(request,"openid")) && !Tools.isNull(Tools.getCookie(request,"openkey"))){
		out.println(Tools.getCookie(request,"openid"));
		out.println(Tools.getCookie(request,"openkey"));
		//String openid 	=Tools.getCookie(request,"openid");		/*填入oenid*/
		//String openkey 	= Tools.getCookie(request,"openkey");	/*填入openkey*/
		String openid 	= "F58BB073D94C417CF0D043A201CCD9D3";		/*填入oenid*/
	String openkey 	= "3B5538536E2843C401F7B5CAFF5B0103B5938DFB0EE4B84489DAEC188F3620AD63120C169E472B39FBD50ACF45DF0C0E";	/*填入openkey*/
		Map params = new HashMap<String,String>();
		Date timestamp = new Date();
		/*TODO: 请商户开发对每个参数进行赋值，每个参数的定义请参考debug.cb.qq.com*/
		params.put("version","1.0");
		params.put("merchant_id",MERCHANT_ID);
		/*openid和openkey根据商户保存方式取出*/
		params.put("openid",openid); 
		params.put("openkey",openkey); 
		params.put("charset","utf-8");
		params.put("return_fmt","xml");
		params.put("timestamp",(new SimpleDateFormat("yMdHms")).format(timestamp));
		
		String sign = generate_sign(params);
		params.put("sign",sign);
		String urlParam = get_urlencoded_string(params);
		String relData = do_get(URL_ADDRESS+"?"+urlParam);
		out.println(relData);
	}
	
%>