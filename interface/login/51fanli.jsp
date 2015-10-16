<%@ page contentType="text/html; charset=GBK"%>
<%@page import="
com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,
javax.net.ssl.*,
com.d1.bean.id.SequenceIdGenerator,
com.d1.bean.User,
com.d1.helper.UserHelper,
java.io.UnsupportedEncodingException,
java.net.URLDecoder,
java.text.SimpleDateFormat,
java.util.Date
"%><%!
static ArrayList<UserAddress> getFanliAddressList(String userId,String username){
	
	if(userId==null||!StringUtils.isDigits(userId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
	clist.add(Restrictions.eq("mbrcst_name", username));
	
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
static ArrayList<Province> getAllProvince(){
	ArrayList<Province> list=new ArrayList<Province>();
	//List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	//listRes.add(Restrictions.eq("prvmst_name", name));
	
	List<BaseEntity> mxlist= Tools.getManager(Province.class).getList(null, null, 0, 100);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((Province)be);
	}
	 return list;
}
%>
<%
if(!Tools.isNull( request.getParameter("channel_id")) && !Tools.isNull( request.getParameter("u_id"))){
	 String strchannelid=request.getParameter("channel_id");
	    String stru_id=request.getParameter("u_id");
	    String strurl="http://www.d1.com.cn";
	    if(!Tools.isNull( request.getParameter("target_url"))){
	    	strurl=	request.getParameter("target_url");
	    }
	    Tools.setCookie(response,"d1.com.cn.srcurl","http://www.51fanli.com",(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    Tools.setCookie(response,"51FANLI",strchannelid+"|"+stru_id,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    IntfUtil.KillsCookies(response, "51FANLI");
	    String tracking_code="";
	    if(!Tools.isNull(request.getParameter("tracking_code"))){
	    	tracking_code=request.getParameter("tracking_code");
	    }
	    Tools.setCookie(response,"tracking_code",tracking_code,(int)(Tools.DAY_MILLIS/1000*3));//3天过期  效果追踪识别码,提交订单有用
	    String username=request.getParameter("username");
	    if(Tools.isNull(username) || "null".equals(username)){
	    	username="";
	    }
    	Tools.setCookie(response,"fanliusername",username,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    if(!Tools.isNull( request.getParameter("syncname")) && "true".equals(request.getParameter("syncname"))){//是否联合登录
	    	if(!Tools.isNull(request.getParameter("username"))){
	    		String showmsg=URLDecoder.decode(request.getParameter("username"),"GBK");
	    		Tools.setCookie(response,"showmsg", URLEncoder.encode(showmsg,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
	    	
	    	}
	    	 String action_time=request.getParameter("action_time");
	    	String code=request.getParameter("code");
	    	String  shop_key="667fa3f64e9bc8bd";
	    	String verifycode=MD5.to32MD5(username + shop_key + action_time);
	    	long verifytime=System.currentTimeMillis()/1000;
	    	String strusersafekey=request.getParameter("usersafekey");
	    	String pwd=request.getParameter("pwd");
	    	String stremail=request.getParameter("email");
	    	String strname=request.getParameter("name");
	    	String strsyncaddress=request.getParameter("syncaddress");
	    	String strprovince=request.getParameter("province");
	    	String strcity=request.getParameter("city");
	    	String strarea=request.getParameter("area");
	    	String straddress=request.getParameter("address");
	    	String strzip=request.getParameter("zip");
	    	String strphone=request.getParameter("phone");
	    	String strmobile=request.getParameter("mobile");
	    	// 如果当前服务器的时间和action_time参数的时间差距在5分钟内，返回true，否则返回false
	    	if(verifytime-Tools.parseLong(action_time) <=5*60 && code.equals(verifycode)){
		    		//if(redir_type.equals("0")){//模式1：用返利网账号联合登录（redir_type = 0）
		    			//System.out.print("密码"+pwd);
		    				String strflmbrid=null;
		    				UserFanLi userfanli=(UserFanLi)Tools.getManager(UserFanLi.class).findByProperty("mbrmstfanli_username", username);
		    				if(userfanli!=null){
		    				 if(userfanli.getMbrmstfanli_usersafekey().equals(strusersafekey)){
		    					 if(Tools.parseBoolean(strsyncaddress)){
		    						 userfanli.setMbrmstfanli_name(strname);
		    						 userfanli.setMbrmstfanli_province(strprovince);
		    						 userfanli.setMbrmstfanli_city(strcity);
		    						 userfanli.setMbrmstfanli_area(strarea);
		    						 userfanli.setMbrmstfanli_address(straddress);
		    						 userfanli.setMbrmstfanli_zip(strzip);
		    						 userfanli.setMbrmstfanli_phone(strphone);
		    						 userfanli.setMbrmstfanli_mobile(strmobile);
		    						 Tools.getManager(UserFanLi.class).update(userfanli, true);
		    					 }
		    					 strflmbrid=userfanli.getMbrmstfanli_mbrid().toString();
		    					 User puser=UserHelper.getById(strflmbrid);
		    					 if(puser!=null){
		    						 if(Tools.isNull(puser.getMbrmst_passwd())){
		    							 puser.setMbrmst_passwd(MD5.to32MD5(pwd));
		    							 Tools.getManager(User.class).update(puser, true);
		    						 }
		    						 
		    					 }
		    				 }
		    			 }
		    			 else{
		    				 String strMbrID= SequenceIdGenerator.generate("3");
		    				 boolean buser=IntfUtil.CreateUser(strMbrID, username,MD5.to32MD5(pwd), strname, "51fanli");
		    				if (buser){
		    			    	UserFanLi user=new UserFanLi();
		    			    	user.setMbrmstfanli_mbrid(new Long(strMbrID));
		    			    	user.setMbrmstfanli_uid(stru_id);
		    		    		user.setMbrmstfanli_username(username);
		    		    		user.setMbrmstfanli_usersafekey(strusersafekey);
		    		    		user.setMbrmstfanli_email(stremail);
		    		    		user.setMbrmstfanli_name(strname);
		    		    		user.setMbrmstfanli_province(strprovince);
		    		    		user.setMbrmstfanli_city(strcity);
		    		    		user.setMbrmstfanli_area(strarea);
		    		    		user.setMbrmstfanli_address(straddress);
		    		    		user.setMbrmstfanli_zip(strzip);
		    		    		user.setMbrmstfanli_phone(strphone);
		    		    		user.setMbrmstfanli_mobile(strmobile);
		    		    		user.setMbrmstfanli_createdate(new Date());
		    		    		Tools.getManager(UserFanLi.class).create(user);
		    		    		strflmbrid=user.getMbrmstfanli_mbrid().toString();
		    			    }
		    				 User puser=UserHelper.getById(strflmbrid);
	    					 if(puser!=null){
	    						puser.setMbrmst_passwd(MD5.to32MD5(pwd));
	    						Tools.getManager(User.class).update(puser, true);
	    					 }
		    			 }
		    				 if(strflmbrid!=null){
		    					 User puser=UserHelper.getById(strflmbrid);
		    					 if(puser!=null){
		    						//puser.setMbrmst_passwd(MD5.to32MD5(pwd));
		    						//Tools.getManager(User.class).update(puser, true);
		    						 
		    						 if(Tools.parseBoolean(strsyncaddress)){
			    						ArrayList<Province> plist=getAllProvince();
			    		 		    		String bProvince="1";
			    		 		    		String sCityID="1";
			    		 		    		if(plist!=null){
			    		 		    			for(Province p:plist){
			    		 		    				if(p.getPrvmst_name().indexOf(strprovince)>=0 || strprovince.indexOf(p.getPrvmst_name())>=0){
			    		 		    					bProvince=p.getId();
			    		 		    				}
			    		 		    				
			    		 		    			}
			    		 		    		}
			    		 		    		ArrayList<City> clist=CityHelper. getCitysViaProvinceId(bProvince);
			    		 		    	
			    		 		    		if(clist!=null){
			    		 		    			for(City c:clist){
			    		 		    			
			    		 		    				String citynme1=c.getCtymst_name().trim();
			    		 		    				String citynme2=strarea;
			    		 		    				
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
			    		 		    							citynme2=strcity;
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
			    		 		    		ArrayList<UserAddress> addresslist= getFanliAddressList(strflmbrid,strname);
			    		 		    		if(addresslist!=null && addresslist.size()>0){
			    		 		    			address=addresslist.get(0);
			    		 		    		}else{
			    		 		    			bl=false;
			    		 		    			address=new UserAddress();
			    		 		    			long maxId = UserAddressHelper.getUserMaxId(strflmbrid);
			    		 		    			address.setMbrcst_id(new Long(maxId));
			    			    		    		address.setMbrcst_mbrid(new Long(strflmbrid));
			    			    		    		address.setCreatedate(new Date());
			    			    		    		address.setMbrcst_countryid(new Long(1));
			    			    		    		address.setMbrcst_memo("");
			    		 		    		}
			    		 		    		address.setMbrcst_provinceid(new Long(bProvince));
			    		 		    		address.setMbrcst_cityid(new Long(sCityID));
			    							address.setMbrcst_name(strname);
			    		 		    		address.setMbrcst_raddress(strprovince+strcity+strarea+straddress);
			    		 		    		address.setMbrcst_relation("");
			    		 		    		address.setMbrcst_remail(stremail);
			    		 		    		address.setMbrcst_rphone(strmobile);
			    		 		    		address.setMbrcst_rsex(new Long(0));
			    		 		    		address.setMbrcst_rtelephone(strphone);
			    		 		    		address.setMbrcst_rtelephonecode("");
			    		 		    		address.setMbrcst_rtelephoneext("");
			    		 		    		address.setMbrcst_rthird(new Long(0));
			    		 		    		address.setMbrcst_rzipcode(strzip);
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
		    					 UserHelper.setLoginUserId(session,strflmbrid);
		    					//out.print(">>>>>>>>>>>");
		    				 }
		    				 response.sendRedirect(strurl);
		    		//}else{//模式2：用商城账号联合登录：（redir_type = 1）
		    			
		    		//}
		    	
	    	}else{
	    		response.sendRedirect(strurl);
	    	}
	    	
	    }else{
	    	response.sendRedirect(strurl);
	    }

}
%>