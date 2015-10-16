<%@ page contentType="text/html; charset=UTF-8" import=",com.d1.bean.id.SequenceIdGenerator,javax.xml.parsers.*,org.w3c.dom.*,java.net.*,java.security.*,java.util.*" %><%@include file="/inc/header.jsp" %><%!

ArrayList<UserQQ> getLktQQID(String strAcct){
	ArrayList<UserQQ> list=new ArrayList<UserQQ>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("mbrlktqq_acct", strAcct));
	List<BaseEntity> b_list = Tools.getManager(UserQQ.class).getList(clist, null, 0,10);
	if(b_list==null||b_list.size()==0)return null;
	
		for(BaseEntity be:b_list){
			list.add((UserQQ)be);
		}
	
	return list;
}

public String htmlEncode(String s) 
{
    return s.replaceAll("&","&amp;").replaceAll("\"","&quot;").replaceAll("'","&#039;").replaceAll("<","&lt;").replace(">","&gt;");
}

static String APP_KEY = "c2fe79badc9972b2c5caf3846101944b";  /**填入的APP_KEY*/
static String MERCHANT_ID = "d1bianli";	/**填入的APP_ID*/
static String URL_ADDRESS = "http://open.cb.qq.com/OpenAPI/openkey/get_user_address.php";
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
	
	for(int i = 0; i < keys.length; i++){
		singStr = singStr + maps.get(keys[i]);
	}
	singStr = singStr+APP_KEY;
	
	/**进行签名，注意考虑到md5加密输出的大小写问题，所有约定md5的输出均为小写**/
	singStr=MD5.to32MD5(singStr).toLowerCase();	
	
	 return singStr;
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

static ArrayList<UserAddress> getUserCaibeiAddressList(String userId,String address_id){
	
	if(userId==null||!StringUtils.isDigits(userId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
	clist.add(Restrictions.eq("mbrcst_countryid", new Long(100)));
	clist.add(Restrictions.eq("mbrcst_memo",address_id));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("createdate"));
	
	List<BaseEntity> list = Tools.getManager(UserAddress.class).getList(clist, olist, 0, 100);
	if(list==null||list.size()==0)return null ;
	
	ArrayList<UserAddress> rlist = new ArrayList<UserAddress>();
	for(BaseEntity be:list){
		rlist.add((UserAddress)be);
	}
	return rlist ;
}
static ArrayList<Province> getProvinceByName(String name){
	ArrayList<Province> list=new ArrayList<Province>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("prvmst_name", name));
	
	List<BaseEntity> mxlist= Tools.getManager(Province.class).getList(listRes, null, 0, 100);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((Province)be);
	}
	 return list;
}

%>

<%
//final String QQ_FANLI_CONNECT_KEY1 = "2375x0Yjlt1dl*g*U0%U9guepv%d61c@"; //TODO:这里先填写测试的key,后续上线前需要QQ彩贝给到正式的key替换这里
//final String QQ_FANLI_CONNECT_KEY2 = "@58o12U8rwr#pOk0$2y^nr!z^wsec4mg"; //TODO:这里先填写测试的key,后续上线前需要QQ彩贝给到正式的key替换这里

//final String QQ_FANLI_CONNECT_KEY1 = "caibei123test1";
//final String QQ_FANLI_CONNECT_KEY2 ="caibei123test2";
final String QQ_FANLI_CONNECT_KEY1 = "yhO8Dz4s5xHjaPTQmTgFpzhwTmGqA2f0";
final String QQ_FANLI_CONNECT_KEY2 ="i6hWFlpJS945XXVkRc2hLjOGFv8gwmqP";
final String MALL_HOME_PAGE_URL = "http://www.d1.com.cn"; //商家站点首页


//------------第一步：验证MD5------------
//将form参数按照字典序进行排序
Enumeration params = request.getParameterNames();
Vector vc = new Vector();
while( params.hasMoreElements() ) {
    vc.add( (String)params.nextElement() );
}
String[] paramArr = (String[])vc.toArray(new String[1]);
int paramLen = paramArr.length;
int tempLen  = paramLen - 1;
int i,j;
String tempStr = "";
for(i=0 ; i<tempLen ; i++) {
    for(j=i+1 ; j<paramLen ; j++) {
        if( paramArr[i].compareTo( paramArr[j] ) > 0 ) {
            tempStr = paramArr[i];
            paramArr[i] = paramArr[j];
            paramArr[j] = tempStr;
        }
    }
}

//进行md5加密比较
String rawMd5Str = "";
for(i=0 ; i<paramLen ; i++) {
    if( paramArr[i]!=null&&paramArr[i].compareTo("Vkey") != 0 ) { //签名串不要Vkey这个参数
        rawMd5Str += request.getParameter(paramArr[i]);
    }
}

String md5_1    = ( MD5.to32MD5( rawMd5Str + QQ_FANLI_CONNECT_KEY1 ) ).toLowerCase();
String md5_2    = ( MD5.to32MD5( md5_1 + QQ_FANLI_CONNECT_KEY2 ) ).toLowerCase();

String vkey = request.getParameter("Vkey");
if( vkey != null && md5_2.compareTo(vkey) != 0 ) {
    //如果vkey检测不通过，那么跳转到商家首页
    //response.sendRedirect(MALL_HOME_PAGE_URL);
   // out.println(MALL_HOME_PAGE_URL + "<br>");
    return;
}
else{
	String url = request.getParameter("Url"); //目标地址
if(Tools.isNull(url)){
	url="http://www.d1.com.cn";
}

//-------------第二步,进行联合登录态的设置，
//这里由于跟各个商家的实现不同都会不一样，
//商家可以填充这里的逻辑,示例代码只给出伪码表示-------------
//------------第三步：设置提示语等信息给用户展示------------
//String view_info = htmlEncode( viewinfo.replaceAll("&nbsp;", " ") ).replaceAll(" ", "&nbsp;");
String viewinfo = request.getParameter("ViewInfo");
System.out.println(viewinfo);
String[] arr1 = viewinfo.split("\\&");
String[] arr2 = {};
HashMap viewinfoMap = new HashMap();
int arrLen = arr1.length;
for(i=0 ; i<arrLen ; i++) {
    arr2 = arr1[i].split("=");
    if( arr2.length > 1 ) {
        //这里的编码请自行指定
        viewinfoMap.put( arr2[0] , URLDecoder.decode(arr2[1],"UTF-8") );
    }
}

String showmsg = (String)viewinfoMap.get("ShowMsg");
String headShow=(String)viewinfoMap.get("HeadShow");
String jifenurl=(String)viewinfoMap.get("JifenUrl");
session.setAttribute("headShow",headShow);
session.setAttribute("jifenurl",jifenurl);
String openkey=(String)viewinfoMap.get("OpenKey");
//session.setAttribute("openkey",openkey);
 //  Tools.setCookie(response,"openkey",openkey,(int)(Tools.DAY_MILLIS/1000*1));//1天过期
//存入Cookie的时候使用encode，取出的时候再使用decode，这样解决中文乱码问题
//Cookie ck = new Cookie( "showmsg" , URLEncoder.encode(showmsg) );
//response.addCookie(ck);
/*取Cookie示例
Cookie[] cc = request.getCookies();
out.print(URLDecoder.decode(cc[0].getValue()) + "<br>");
*/


//用户的QQ昵称，根据需要保存cookie
String nickname = (String)viewinfoMap.get("NickName");
//System.out.println("d1gjl:"+request.getQueryString());
//response.addCookie(nickname);
//System.out.println("d1gjl2:"+showmsg);
//用户可使用的彩贝积分，根据需要保存cookie
String point =  (String)viewinfoMap.get("CBPoints") ;
//response.addCookie(point);

//购买后的返利比率，根据需要保存cookie
String bonus1=viewinfoMap.get("CBBonus").toString();
int index=bonus1.indexOf("%");
String bonus=bonus1;
if(index>0){
	bonus1=bonus1.substring(0, index);
	bonus =Float.parseFloat(bonus1)+"";
}
out.print(showmsg);
out.print(nickname);
//bonus
//统计字段，下单后需要回传
String attach = request.getParameter("Attach");
//ck = new Cookie( "attach" , attach );
//response.addCookie(ck);
String openID = request.getParameter("Acct");
//session.setAttribute("openid",acct);
// Tools.setCookie(response,"openid",acct,(int)(Tools.DAY_MILLIS/1000*1));//1天过期
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dxtime=null;
try{
	dxtime =fmt.parse("2012-1-15");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dxtime)>System.currentTimeMillis())
{
	 Tools.setCookie(response,"rcmdusr_rcmid","108",(int)(Tools.DAY_MILLIS/1000));
	    
}
//System.out.println("d1gjl2:"+nickname+"--------"+openID+"----"+showmsg);
//判断该用户是否存在
//ArrayList<UserQQ> list= getLktQQID(acct);
//UserQQ list123=(UserQQ)Tools.getManager(UserQQ.class).findByProperty("mbrlktqq_acct", acct);
QQLogin qq = null;
// synchronized(obj){
 	qq = QQLoginHelper.getByUid(openID);
//存在设置登录状态
session.setAttribute("showmsg",URLEncoder.encode(showmsg,"GBK"));
Tools.setCookie(response,"showmsg", URLEncoder.encode(showmsg,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期


String userid="0";
if(qq!=null){
	//用QQ登录过
		//如果昵称更改，会员表做相应更改
		if(nickname != null && !nickname.equals(qq.getQqloginmbr_name())){
			qq.setQqloginmbr_name(nickname);
			QQLoginHelper.manager.update(qq,false);
		}
		session.setAttribute("showmsg","QQ用户："+nickname);
		Tools.setCookie(response,"showmsg", URLEncoder.encode("QQ用户："+nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
		UserHelper.setLoginUserId(session,qq.getQqloginmbr_mbrid()+"");
}
//不存在 创建账户  设置登录态
else{
	//System.out.println("3333:"+acct);
	//out.println("用户不存在");
	String strPwd = request.getParameter("Vkey");
	 if (strPwd.length() >= 48)
   {
       strPwd = strPwd.substring(strPwd.length() - 48, strPwd.length());
   }
	// System.out.println("11111111:");
	
      	
      	 
          	//不存在则添加新的数据。
          	User u = UserHelper.getByUsername("");
          	if(u == null){
          		Date currDate = new Date();
          		String pwd = MD5.to32MD5(String.valueOf(System.currentTimeMillis()),"UTF-8");
  				
  				u = new com.d1.bean.User();
  				u.setId(SequenceIdGenerator.generate("3"));
  				u.setMbrmst_uid(openID+"qqlogin");
  				u.setMbrmst_pwd(pwd);
  				u.setMbrmst_passwd(MD5.to32MD5(pwd));
  				u.setMbrmst_question("");
  				u.setMbrmst_answer("");
  				u.setMbrmst_createdate(currDate);
  				u.setMbrmst_modidate(currDate);
  				u.setMbrmst_lastdate(currDate);
  				u.setMbrmst_name("QQ登录用户");
  				u.setMbrmst_visittimes(new Long(0));
  				u.setMbrmst_sex(new Long(0));
  				u.setMbrmst_email("");
  				u.setMbrmst_hphone("");
  				u.setMbrmst_usephone("");
  				u.setMbrmst_haddr("");
  				u.setMbrmst_countryid(new Long(1));
  				u.setMbrmst_provinceid(new Long(1));
  				u.setMbrmst_cityid(new Long(1));
  				u.setMbrmst_postcode("");
  				u.setMbrmst_certifiertype(new Long(0));
  				u.setMbrmst_certifierno("");
  				u.setMbrmst_myd1type(new Long(0));
  				u.setMbrmst_myd1count(new Long(10));
  				u.setMbrmst_myd1codes("");
  				u.setMbrmst_specialtype(new Long(0));
  				u.setMbrmst_srcurl("");
  				u.setMbrmst_peoplercm("");
  				u.setMbrmst_subad("");
  				u.setMbrmst_temp("QQLOGIN");
  				u.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
  				u.setMbrmst_bookletflag(new Long(0));
  				u.setMbrmst_buyerrcount(new Long(0));
  				u.setMbrmst_buyquestionid("");
  				u.setMbrmst_downflag(new Long(0));
  				u.setMbrmst_magazineflag(new Long(0));
  				u.setMbrmst_validflag(new Long(0));
  				u.setMbrmst_rcmcount(new Long(0));
  				u.setMbrmst_ip("");
  				u.setMbrmst_bktstep(new Long(0));
  				u.setMbrmst_aliasname("");
  				u.setMbrmst_src(new Long(0));
  				u.setMbrmst_sendcount(new Long(0));
  				u.setMbrmst_replycount(new Long(0));
  				u.setMbrmst_kicktype(new Long(0));
  				u.setMbrmst_bbsAlllogintimes(new Long(0));
  				u.setMbrmst_bbsDaylogintimes(new Long(0));
  				u.setMbrmst_allsrc(new Long(0));
  				u.setMbrmst_jcsrc(new Long(0));
  				u.setMbrmst_goldsrc(new Long(0));
  				u.setMbrmst_goldallsrc(new Long(0));
  				u.setMbrmst_birthflag(new Long(0));
  				u.setMbrmst_tktmail(new Long(0));
  				u.setMbrmst_ip(request.getRemoteAddr());
  				u = (User)UserHelper.manager.create(u);
          	}
          	if(u != null && u.getId() != null){
  				qq = new QQLogin();
  				qq.setQqloginmbr_createdate(new Date());
  				qq.setQqloginmbr_mbrid(new Long(u.getId()));
  				qq.setQqloginmbr_name(nickname);
  				qq.setQqloginmbr_regflag(new Long(0));
  				qq.setQqloginmbr_uid(openID);
  				
  				QQLoginHelper.manager.create(qq);
  		
  				session.setAttribute("showmsg","QQ用户："+nickname);
  				Tools.setCookie(response,"showmsg", URLEncoder.encode("QQ用户："+nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
  				UserHelper.setLoginUserId(session,u.getId());
  			}
}
	//boolean bl=	UserHelper. createNewMbrLktQQ(acct,strPwd,nickname.replace("'", "''"),attach,bonus,point);
	//创建用户帐户失败 
	/*if(!bl) {
		
	        response.sendRedirect(url);
	        return;
	    }
	else{
		
		ArrayList<UserQQ> list2= getLktQQID(acct);
		if(list2!=null && list2.size()>0){
			userid=list2.get(0).getMbrlktqq_mbrid()+"";
			UserHelper.setLoginUserId(session,list2.get(0).getMbrlktqq_mbrid()+"");
			//out.println("用户已存在");
		}
	}*/
 
System.out.println("d1gjlQQURL1:"+userid);
/*
if(!userid.equals("0")){
	System.out.println("22222222:");
Map param = new HashMap<String,String>();
Date timestamp = new Date();
/*TODO: 请商户开发对每个参数进行赋值，每个参数的定义请参考debug.cb.qq.com*/
/*param.put("version","1.0");
param.put("merchant_id",MERCHANT_ID);
/*openid和openkey根据商户保存方式取出*/
/*param.put("openid",acct); 
param.put("openkey",openkey); 
param.put("charset","utf-8");
param.put("return_fmt","xml");
param.put("timestamp",(new SimpleDateFormat("yMdHms")).format(timestamp));

String sign = generate_sign(param);
//out.println(sign);
param.put("sign",sign);
//out.println(sign);
	System.out.println("222222=====:"+param);
String urlParam = get_urlencoded_string(param);
System.out.println("333333333=====222:"+urlParam);
String relData = do_get(URL_ADDRESS+"?"+urlParam);
System.out.println("333333333=====:"+relData);
 String info_xml=URLDecoder.decode( relData,"utf-8");
 InputStream in = null;
 try {
	 System.out.println("4444444:");
 	in = new ByteArrayInputStream(info_xml.getBytes("UTF-8"));
 	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
 	DocumentBuilder builder=factory.newDocumentBuilder();
 	Document doc=builder.parse(in);
 	doc.normalize();
 	String recode=doc.getElementsByTagName("ret_code").item(0).getFirstChild().getNodeValue();
 	int addresscount=Integer.parseInt(doc.getElementsByTagName("address_count").item(0).getFirstChild().getNodeValue());
 	if(recode.equals("0")){
 		 	NodeList links =doc.getElementsByTagName("shopping_address");
	    			for (int k=0;k<links.getLength();k++){
 		    		Element link=(Element) links.item(k);
 		    		String phone="";
 		    		if(link.getElementsByTagName("phone").item(0).getFirstChild()!=null){
 		    			phone=link.getElementsByTagName("phone").item(0).getFirstChild().getNodeValue();
 		    		}
 		    		ArrayList<Province> plist=getProvinceByName(link.getElementsByTagName("province").item(0).getFirstChild().getNodeValue());
 		    		String bProvince="1";
 		    		String sCityID="1";
 		    		if(plist!=null){
 		    			for(Province p:plist){
 		    				bProvince=p.getId();
 		    			}
 		    		}
 		    		ArrayList<City> clist=CityHelper. getCitysViaProvinceId(bProvince);
 		    		String ischecked="0";
 		    		if(clist!=null){
 		    			for(City c:clist){
 		    				if(link.getElementsByTagName("is_preferred").item(0).getFirstChild().getNodeValue().equals("1")){
 		    					ischecked="1";
 	    		    		} 
 		    				String citynme1=c.getCtymst_name().trim();
 		    				String citynme2="";
 		    				if(link.getElementsByTagName("dist").item(0).getFirstChild()!=null){
 		    					citynme2=link.getElementsByTagName("dist").item(0).getFirstChild().getNodeValue().trim();
 		    				}
 		    				//out.print(citynme1.length());
 		    				if(citynme1.length()>=2 && citynme2.length()>=2){
 		    					if(citynme1.substring(0,2).equals(citynme2.substring(0,2))){
 		    						sCityID=c.getId();
 		    						break;
 		    					}
 		    					else{
 		    						if(bProvince.equals("1")){
 		    							if(citynme2.equals("经济技术开发区")){
		    		    						sCityID="2537";
		    		    						break;
			    		    				}else{
			    		    					sCityID="1";
			    		    					break;
			    		    				}
 		    						}else{
 		    							citynme2=link.getElementsByTagName("city").item(0).getFirstChild().getNodeValue().trim();
 		    							if(citynme1.length()>=2 && citynme2.length()>=2 && !sCityID.trim().equals("1")){
 		    		    					if(citynme1.substring(0,2).equals(citynme2.substring(0,2))){
 		    		    						sCityID=c.getId();
 		    		    						break;
 		    		    					}
 		    							}
 		    						}
 		    					}
	    		    				
 		    				}
 		    				
 		    			}
 		    		}
 		    		boolean bl=true;
 		    		UserAddress address=null;
 		    		ArrayList<UserAddress> addresslist= getUserCaibeiAddressList(userid,link.getElementsByTagName("address_id").item(0).getFirstChild().getNodeValue());
 		    		if(addresslist!=null && addresslist.size()>0){
 		    			address=addresslist.get(0);
 		    		}else{
 		    			bl=false;
 		    			address=new UserAddress();
 		    			long maxId = UserAddressHelper.getUserMaxId(userid);
 		    			address.setMbrcst_id(new Long(maxId));
	    		    		address.setMbrcst_mbrid(new Long(userid));
	    		    		address.setCreatedate(new Date());
	    		    		address.setMbrcst_countryid(new Long(100));
	    		    		address.setMbrcst_memo(link.getElementsByTagName("address_id").item(0).getFirstChild().getNodeValue());
 		    		}
 		    		address.setMbrcst_provinceid(new Long(bProvince));
 		    		address.setMbrcst_cityid(new Long(sCityID));
						address.setMbrcst_name(link.getElementsByTagName("name").item(0).getFirstChild().getNodeValue());
						String addressstr="";
						if(link.getElementsByTagName("province").item(0).getFirstChild()!=null)addressstr=addressstr+link.getElementsByTagName("province").item(0).getFirstChild().getNodeValue();
						if(link.getElementsByTagName("city").item(0).getFirstChild()!=null)addressstr=addressstr+" "+link.getElementsByTagName("city").item(0).getFirstChild().getNodeValue();
						if(link.getElementsByTagName("dist").item(0).getFirstChild()!=null)addressstr=addressstr+" "+link.getElementsByTagName("dist").item(0).getFirstChild().getNodeValue();
						if(link.getElementsByTagName("address").item(0).getFirstChild()!=null)addressstr=addressstr+" "+link.getElementsByTagName("address").item(0).getFirstChild().getNodeValue();

 		    		address.setMbrcst_raddress(addressstr);
 		    		address.setMbrcst_relation("");
 		    		address.setMbrcst_remail("");
 		    		address.setMbrcst_rphone(link.getElementsByTagName("mobile").item(0).getFirstChild().getNodeValue());
 		    		address.setMbrcst_rsex(new Long(0));
 		    		address.setMbrcst_rtelephone(phone);
 		    		address.setMbrcst_rtelephonecode("");
 		    		address.setMbrcst_rtelephoneext(ischecked);
 		    		address.setMbrcst_rthird(new Long(0));
 		    		address.setMbrcst_rzipcode(link.getElementsByTagName("post_code").item(0).getFirstChild().getNodeValue());
 		    		address.setUpdatedate(new Date());
 		    		
 		    		if(bl){
 		    			if(UserAddressHelper.manager.update(address,true)){
 		    				out.print("修改成功");
 		    				
 		    			}
 		    		}else{
 		    			address = (UserAddress)UserAddressHelper.manager.create(address);
 		    			
 		    			//out.print(link.getElementsByTagName("address_id").item(0).getFirstChild().getNodeValue());
 		    			
 		    			if(address != null && address.getId() != null){
 		    				out.print("添加成功");
 		    			}
 		    		}
 		    		}
 	}
 	
 }catch(UnsupportedEncodingException e){
		e.printStackTrace();
	} finally{
		try{
			if(in != null) in.close();
			response.sendRedirect(url);
			return;
		} catch(IOException e){
			System.err.println("chanet close inputstream error!");
		}
	}
}*/
//跳转到目标地址
System.out.println("d1gjlQQURL:"+url);
//if(Tools.isNull(url)){
//	url="http://www.d1.com.cn";
//}
try{
response.sendRedirect(url);
}catch(UnsupportedEncodingException e){
	response.sendRedirect("http://www.d1.com.cn");
//out.print(url + "<br>");
}
}
//out.print(url + "<br>");

//return;

%>