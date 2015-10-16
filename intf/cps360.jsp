<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="../inc/header.jsp"%><%!
static ArrayList<User360> getUser360(String qid){
	ArrayList<User360> list=new ArrayList<User360>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("mbr360_qid", qid));
	List<BaseEntity> mxlist= Tools.getManager(User360.class).getList(listRes, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((User360)be);
	}
	 return list;
}
%>
<%

String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if (!Tools.isNull(httpurl)){
	try{
	       httpurl =java.net.URLDecoder.decode(httpurl,"UTF-8");
   }
   catch(Exception ex){
 	  ex.printStackTrace();
   }
}
/*
bid 合作网站编号,与预先分配的bid值相同，用来做判断 字符串 1001 否 

qihoo_id 360业务编号,需写入cookie，并保存到订单 字符串 36010 可以 
url 用户最终访问url，写入cookie后需跳转到该地址，如为空可跳转到首页 url地址 http://hao.360.cn 可以 
from_url 请求来源url url地址 http://hao.360.cn 可以 
active_time 调用发起时间，精确到秒。 unix时间戳 1328780065 否 
ext 扩展字符串，需写入cookie，并保存到订单中 字符串 a001 可以 
qid 360用户ID,需写入cookie，并保存到订单中 字符串 10001 用户未登录为空 
qmail 用户邮箱地址 邮箱 cps@example.com 用户未登录为空 

qname 用户显示名称，显示在网站，帮助用户识别  字符串 360用户 用户未登录为空 
sign 签名信息, 
计算方法: $sign = md5(bid#active_time#cp_key#qid#qmail#qname);
*/
    String bid=request.getParameter("bid");
    String qihoo_id="";
    if(!Tools.isNull(request.getParameter("qihoo_id"))){
    	qihoo_id=request.getParameter("qihoo_id");
    }
    String strurl=request.getParameter("url");
    String from_url=request.getParameter("from_url");
    String active_time=request.getParameter("active_time");
    String ext="";
    if(!Tools.isNull(request.getParameter("ext"))){
    	ext=request.getParameter("ext");
    }
    String qid="";
    if(!Tools.isNull(request.getParameter("qid"))){
    	qid=request.getParameter("qid");
    }
    String qmail="";
    if(!Tools.isNull(request.getParameter("qmail"))){
    	qmail=request.getParameter("qmail");
    }
    String qname="";
    if(!Tools.isNull(request.getParameter("qname"))){
    	qname=request.getParameter("qname");
    }
    String sign=request.getParameter("sign");
    String rbid=PubConfig.get("cps360_bid");
   
    long verifytime=System.currentTimeMillis()/1000;
    String cp_key=PubConfig.get("cps360_cpkey");
    if (Tools.isNull(strurl))
    {
    	strurl="http://www.d1.com.cn/";
     }
    strurl=strurl.replace("*", "&");
    if (!Tools.isNull(rbid) && rbid.equals(bid)){
    	
    	 //不管是否签名认证成功，都需要将qid、qihoo_id、ext等参数信息记录到到cookie中(可以写到一个变量中)，cookie有效期时间为30天。在用户下单时，需要从cookie中获取这些信息，并保存到订单中。
        Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*30));//30天过期
       Tools.setCookie(response,"CPS360",qid+"|"+qihoo_id+"|"+ext,(int)(Tools.DAY_MILLIS/1000*30));//30天过期
       IntfUtil.KillsCookies(response, "CPS360");
    	// $sign = md5(bid#active_time#cp_key#qid#qmail#qname);
    	String strcode=bid+"#"+active_time+"#"+cp_key+"#"+qid+"#"+qmail+"#"+qname;
    	String verifycode=MD5.to32MD5(strcode, "utf-8").toLowerCase();
    	if(verifytime-Tools.parseLong(active_time) <=15*60 && sign.equals(verifycode)){
    	
    		/*
    		if(!Tools.isNull(qid)){
    			String strflmbrid=null;
    			User360 user360=(User360)Tools.getManager(User360.class).findByProperty("mbr360_qid", qid);
    			if(user360!=null){
    				out.print(qid);
    				if(UserHelper.getById(user360.getMbr360_mbrid().toString())!=null){
    				UserHelper.setLoginUserId(session,user360.getMbr360_mbrid().toString());
    				Tools.setCookie(response,"showmsg", URLEncoder.encode(qname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
    		    	
    				}
    			}else{
    				String strMbrID= SequenceIdGenerator.generate("3");
    				 boolean buser=IntfUtil.CreateUser(strMbrID, qid+"@user360",MD5.to32MD5(qid+active_time), qname, "cps360");
    				 if(buser){
    					 User360 nuser360=new User360();
    					 nuser360.setMbr360_mbrid(Tools.parseLong(strMbrID, 0));
    					 nuser360.setMbr360_qid(qid);
    					 nuser360.setMbr360_qihoo_id(qihoo_id);
    					 nuser360.setMbr360_qmail(qmail);
    					 nuser360.setMbr360_qname(qname);
    					 Tools.getManager(User360.class).create(nuser360);
    					 UserHelper.setLoginUserId(session,nuser360.getMbr360_mbrid().toString());
    					 Tools.setCookie(response,"showmsg", URLEncoder.encode(qname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
    				    	
    				 }
    			}
    		}
    		*/
    	}else{//签名验证失败或检查超时进行以下处理
    		String url="http://open.union.360.cn/gofailed";
    		String strcode2=rbid+"#"+verifytime+"#"+cp_key;
        	String newverifycode=MD5.to32MD5(strcode2, "utf-8");
        	String postdata="bid="+rbid+"&active_time="+verifytime+"&sign="+newverifycode+"&pre_bid="+bid+"&pre_active_time="+active_time+"&pre_sign="+sign+"&qid="+qid+"&qname="+qname+"&qmail="+qmail+"&from_url="+from_url+"&from_ip="+request.getRemoteAddr();
    	IntfUtil.GetPostData(url, postdata);
    	}
    	
    }
response.sendRedirect(strurl);
%>