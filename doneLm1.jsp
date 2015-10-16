<%@page import="java.io.DataOutputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@include file="pinganpost.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@page import="
java.io.UnsupportedEncodingException,
java.text.DateFormat,
java.text.SimpleDateFormat,
javax.net.*,
javax.servlet.http.Cookie,
javax.servlet.http.HttpServletRequest,
javax.servlet.http.HttpServletResponse,
javax.servlet.http.HttpSession,
com.pingan.cert.Interface.*,
com.d1.bean.*,
com.d1.helper.*,
com.d1.util.*,java.io.*,
com.d1.bean.OrderBase,
com.d1.bean.OrderItemCache,
com.d1.bean.PingAnUser,
com.d1.bean.Product,
com.d1.bean.QQLogin,
com.d1.bean.User,
com.d1.helper.OrderHelper,
com.d1.helper.OrderItemHelper,
com.d1.helper.ProductHelper,
com.d1.helper.QQLoginHelper,
com.d1.helper.UserHelper,
com.d1.helper.TicketFlagHelper,
javax.xml.parsers.*,org.w3c.dom.*,java.net.*,java.security.*,java.util.*
" %><%!

public static String DoneAct(String orderId, HttpServletRequest request,HttpServletResponse response,User user,String ip) throws UnsupportedEncodingException
{
	 OrderBase order = OrderHelper.getById(orderId);
	 HttpSession session = request.getSession();
	 if(order == null){
	 	return "查询订单信息出错！";
	 }
	 if(! user.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	 	return "您无法查看该订单！";
	 }
	 //String strOdrmstJcFlag = String.valueOf(order.getOdrmst_jcflag());
	 String strOdrmstMbrID = String.valueOf(order.getOdrmst_mbrid());//会员ID
	 double fltTktmstTktValue = Tools.doubleValue(order.getOdrmst_tktvalue());
	 //float fltGiftFee = Tools.floatValue(order.getOdrmst_giftfee());
	//用户ID
	 String strLt_user_id = user.getId();
	// String strLt_user_name = order.getOdrmst_pname();
	// String strMerchantID = "d1bianli";
	 String strMbrmstTemp = user.getMbrmst_temp();
	 
	 /**
	  * 联盟Cookies
	  */
	 String strLtinfo = Tools.getCookie(request,"LTINFO");//buy/ltfront.asp
	 String strLianmeng = Tools.getCookie(request,"d1.com.cn.peoplercm");//buy/liangmeng.asp
	 String strSubad = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");//buy/liangmeng.asp
	 String strPlinfo = Tools.getCookie(request,"PLINFO");//pluslink 的 cookies buy/pluslink_d1_front.asp
	 String strChanet = Tools.getCookie(request,"CHANET");//chanet 的 cookies buy/chanet.asp
	 String strEqifa = Tools.getCookie(request,"EQIFA");//eqifa 的 cookies buy/eqifa.asp
	 String strEQIFAsrc = Tools.getCookie(request,"EQIFAsrc"); //eqifa 的 cookies buy/eqifa.asp,用于区分是sem还是cps
	 String strYiqifa = Tools.getCookie(request,"YIQIFA");//yiqifa 的 cookies buy/yiqifa.asp
	 String strYiqifa_Cid = Tools.getCookie(request,"YIQIFA_Cid");//yiqifa 的 cookies buy/yiqifa.asp
	 String strLele = Tools.getCookie(request,"LELE");//乐乐 的 cookies buy/eqifa.asp
	 String strLele_S = Tools.getCookie(request,"LELE_s");//'乐乐 的 cookies buy/eqifa.asp
	 String strYeedou = Tools.getCookie(request,"yeedou");//一兜 的 cookies buy/yeedou.asp
	 String strWEIYI = Tools.getCookie(request,"WEIYI");//唯一 的 cookies buy/Redirect.asp
	 String strAigoVip = Tools.getCookie(request,"AigoVip");//贵宾网 的 cookies /include/header2007.asp
	 String strPingan = Tools.getCookie(request,"PINGAN");//贵宾网 的 cookies /include/header2007.asp
	 String strYOYI = Tools.getCookie(request,"YOYI");//YOYI 的 cookies buy/YOYI.asp
	 String strIPVGOU = Tools.getCookie(request,"IPVGOU");//联通 的 cookies intf/IPVGOU.asp
	 String strSOHUVIP = Tools.getCookie(request,"SOHUVIP");//SOHUVIP 的 cookies intf/SOHUVIP.asp
	 String strFANLI = Tools.getCookie(request,"51FANLI");//返利网 的 cookies intf/51FANLI.asp
	 String strHZLY = Tools.getCookie(request,"HZLY");//惠众联银 的 cookies buy/hzly.asp
	 String strLhdlTemp = Tools.getCookie(request,"lhdltemp");//'联合登陆 的 cookies
	 String strYiGao = Tools.getCookie(request,"YIGAO");//'亿起发cpc的亿告接口 的 cookies intf/yigao.asp
	 String strD1_Kefu =(String)session.getAttribute("d1kf_userid");//客服下单
	 String strWangYi = Tools.getCookie(request,"wangyi");//网易
	 //忆起发，成果，领可特，51返利 购物券在联盟中不返利

	 	String strCardMemo = order.getOdrmst_cardmemo();
	 	long validflag=1;
	 	boolean existstkt=TicketFlagHelper.existsTicketFlag(strCardMemo,new Long(validflag));
	 	boolean bgdsdh=getgdsdh(orderId);
	 	//需要查询数据库
	 	if(existstkt || bgdsdh){
	 		strLtinfo = "";strLianmeng = "";strPlinfo = "";strChanet = "";strEqifa = "";strYiqifa_Cid = "";
	         strYiqifa = "";strLele = "";strYeedou = "";strWEIYI = "";strAigoVip = "";strPingan = "";
	         strYOYI = "";strIPVGOU = "";strSOHUVIP = "";strFANLI = "";strLhdlTemp = "";strYiGao = "";
	         strWangYi = "";
	 	}

	 //10、平安Cookie
	 if("pingan".equals(strMbrmstTemp)){
	 	IntfUtil.KillsCookies(response , "PINGAN");
	 }
	 //11、客户下单
	 if(!Tools.isNull(strD1_Kefu)||ip.equals("211.103.223.202")){
	 	strLtinfo = "";strLianmeng = "";strPlinfo = "";strChanet = "";strEqifa = "";strYiqifa_Cid = "";
	     strYiqifa = "";strLele = "";strYeedou = "";strWEIYI = "";strAigoVip = "";strPingan = "";
	     strYOYI = "";strIPVGOU = "";strSOHUVIP = "";strFANLI = "";strLhdlTemp = "";strYiGao = "";
	     strWangYi = "";
	     IntfUtil.KillsCookies(response , "d1_kefu");
	     
	     IntfUtil.DelCookie(response , "d1.com.cn.srcurl");
	 }
	 QQLogin qqLogin=QQLoginHelper.getByMbrid(Long.parseLong(user.getId()));
	 String isQQLoginUser="";
	 if (qqLogin!=null)
	 {
	 isQQLoginUser=qqLogin.getQqloginmbr_uid();
	 if (!Tools.isNull(isQQLoginUser)){
		 isQQLoginUser=isQQLoginUser.trim();
	 }
	 UserQQ userqq=(UserQQ)Tools.getManager(UserQQ.class).findByProperty("mbrlktqq_acct",isQQLoginUser);
	 if (userqq==null){
		 isQQLoginUser="";
	 }
	 if(Tools.isNull(strLtinfo)){
	 	if (!Tools.isNull(isQQLoginUser))
	 	{
	 	strLianmeng = "";strPlinfo = "";strChanet = "";strEqifa = "";strYiqifa_Cid = "";
	     strYiqifa = "";strLele = "";strYeedou = "";strWEIYI = "";strAigoVip = "";strPingan = "";
	     strYOYI = "";strIPVGOU = "";strSOHUVIP = "";strFANLI = "";strLhdlTemp = "";strYiGao = "";
	     strWangYi = "";
	 	}
	 }
	 }
	 boolean isfanli=false;
	 //返利网：直接通过联合登录账号登录
	 if(user.getMbrmst_uid().endsWith("@51fanli") && user.getMbrmst_temp().trim().equals("51fanli")){
		 isfanli=true;
		 strLtinfo = "";strLianmeng = "";strPlinfo = "";strChanet = "";strEqifa = "";strYiqifa_Cid = "";
		     strYiqifa = "";strLele = "";strYeedou = "";strWEIYI = "";strAigoVip = "";strPingan = "";
		     strYOYI = "";strIPVGOU = "";strSOHUVIP = "";strLhdlTemp = "";strYiGao = ""; strWangYi = "";
	 }
	 //商户合作下单13、清空Cookie
	 if ("8".equals(strOdrmstMbrID)){
	 	strLtinfo = "";strLianmeng = "";strPlinfo = "";strChanet = "";strEqifa = "";strYiqifa_Cid = "";
	     strYiqifa = "";strLele = "";strYeedou = "";strWEIYI = "";strAigoVip = "";strPingan = "";
	     strYOYI = "";strIPVGOU = "";strSOHUVIP = "";strFANLI = "";strLhdlTemp = "";strYiGao = "";
	     strWangYi = "";
	 }
	//14、来源地址
	 String strSrcurl = Tools.getCookie(request,"d1.com.cn.srcurl");
	 if(!Tools.isNull(strSrcurl)){
	 	strSrcurl = URLDecoder.decode(strSrcurl,"UTF-8");
	 }
	 OrderHelper.updateOdrmstCacheSrcurl(orderId,strSrcurl);
	 
	 //两个都不为空的时候，取linktech
	 if(!Tools.isNull(strLtinfo) && !Tools.isNull(strPlinfo)){
	 	strPlinfo = "";
	 }
	 double fdtltktra=1;//计算用券比例
	 if (fltTktmstTktValue>0)
	 {
	 	fdtltktra=getTktRa(fltTktmstTktValue,orderId);
	 }
	 String retUrl="";//联盟返回链接地址
	 
	 if(!Tools.isNull(strWangYi))//网易返利
	 {
		 postWangyi(order,orderId,fdtltktra,strWangYi);
	 }
	
	 if(!Tools.isNull(strLtinfo) || !Tools.isNull(isQQLoginUser))  //领克特strLtinfo
	 {
		 retUrl= postLKT(order,orderId,fdtltktra,isQQLoginUser,strLtinfo,strLt_user_id);
	 }
	 if(!Tools.isNull(strPlinfo))//领克特多参数
	 {
		 retUrl=postPlinfo(order,orderId,fdtltktra,strPlinfo,user.getMbrmst_uid(), user.getMbrmst_name());
	 }
	 if(!Tools.isNull(strChanet))//成果网
	 {
		 retUrl=postChanet(order,orderId,fdtltktra,strChanet);
	 }
	 if(!Tools.isNull(strEqifa))//亿起发
	 {
		retUrl= postEqifa(order,orderId,fdtltktra,strEqifa,strEQIFAsrc);
	 }
	 if(!Tools.isNull(strYiqifa))//亿起发
	 {
		 retUrl= postYiqifa(order,orderId,fdtltktra,strYiqifa,strYiqifa_Cid);
	 }
	 if(!Tools.isNull(strLele))//乐乐
	 {
		 postLele(order,orderId,fdtltktra,strLele,strLele_S);
	 }
	 if(!Tools.isNull(strYeedou))//一兜
	 {
		 retUrl=postYeedou(order,orderId,fdtltktra,strYeedou);
	 }
	 if(!Tools.isNull(strWEIYI))//唯一
	 {
		 postWeiyi(order,orderId,fdtltktra,strWEIYI,user.getId());
	 }
	 if(!Tools.isNull(strIPVGOU))//联通IPVGOU
	 {
		 postIpvgou(order,orderId,fdtltktra,strIPVGOU);
	 }
	 if(!Tools.isNull(strSOHUVIP))//搜狐VIP
	 {
		 postSohuvip(order,orderId,fdtltktra,strSOHUVIP);
	 }
	 if(!Tools.isNull(strAigoVip))//贵宾网
	 {
		 OrderHelper.updateOdrmstCacheTemp(orderId,strAigoVip);
	 }
	 if(!Tools.isNull(strPingan))//平安万里通
	 {
			try{
				postPingan(order,orderId);
			}catch(Exception ex){
				ex.printStackTrace();
			}
	 }
	 if(!Tools.isNull(strYOYI))//优易互通
	 {
		 OrderHelper.updateOdrmstCacheTemp(orderId,"YOYI"+strYOYI);
	 }
	// if(!Tools.isNull(strFANLI))//返利网
	 //{
	//	 retUrl=retUrl= postFanli(order,orderId,fdtltktra,strFANLI);
	 //}
	 if(!Tools.isNull(strFANLI) || isfanli)//返利网
	 {
		// System.out.print("111111111111111111111111111111");
		 String tracking_code=Tools.getCookie(request,"tracking_code");
		 String username=Tools.getCookie(request,"fanliusername");
		return postFanli(order,orderId,fdtltktra,strFANLI,user,tracking_code,username);
		
	 }
	 if(!Tools.isNull(strHZLY))//惠众联银
	 {
		 OrderHelper.updateOdrmstCacheTemp(orderId,strHZLY);
	 }
	 if(!Tools.isNull(strLhdlTemp))//联合登录
	 {
		 OrderHelper.updateOdrmstCacheTemp(orderId,strLhdlTemp);
	 }
	 if(!Tools.isNull(strYiGao))//亿起发亿告
	 {
		 retUrl= postYigao(order,orderId,strYiGao);
	 }
	 if((!Tools.isNull(strLianmeng) && strLianmeng.startsWith("lianmeng")) || !Tools.isNull(strSubad) )//站内联盟
	 {
		 if (!Tools.isNull(strLianmeng)){
		 UPLianmeng(order,strLianmeng,strSubad);
		 }
		 else{
			 UPSubAd(order,strSubad);
		 }
	 }
	 if(!Tools.isNull(strD1_Kefu))//D1优尚客服下单
	 {
		 OrderHelper.updateOdrmstCacheTemp(orderId,"D1客服下单_" + strD1_Kefu);
	 }
	 if (!Tools.isNull(retUrl) && Tools.isNull(strPlinfo)){
		 retUrl= "<img src=\""+retUrl+"\" width=1 height=1 style=display:none>";
	 }
	 return retUrl;
}
public static boolean getgdsdh(String odrid )
{
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlCacheByOrderId(odrid);
	boolean retbool=false;
	if(list!=null){
		for(OrderItemBase odrdtl:list)
		{
			if (!Tools.isNull(odrdtl.getOdrdtl_tuancardno()))
			{
				retbool=true;break;
			}	
		}
	}

	return retbool;
}

/**
 * 获取用券比例
 * @param tktvalue
 * @param odrid
 * @return
 */
public static double getTktRa(double tktvalue,String odrid )
{
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlCacheByOrderId(odrid);
	double allmoney=0;
	double retra=1;
	for(OrderItemBase odrdtl:list)
	{
		if (!"000".equals(odrdtl.getOdrdtl_rackcode()) && Tools.isNull(odrdtl.getOdrdtl_gifttype()))
		{
			allmoney+=odrdtl.getOdrdtl_finalprice()*odrdtl.getOdrdtl_gdscount();
		}	
	}
	if (allmoney!=0)
	{
		retra=Tools.getDouble(1-tktvalue/allmoney,3);
	}
	
	if(retra<0 || retra>1 ){
		retra=1;
	}
	
	return retra;
}
public static void postWangyi(OrderBase order ,String orderId,double fdtltktra,String strWangYi)
{
	OrderHelper.updateOdrmstCacheTemp(orderId,"WangYi" + strWangYi);
	List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
  	String strRackcode="";
  	String strGdsId="";
  	String strNum="";
  	String strPrice="";
  	String strType="";
  	String strPostUrl="http://gouwu.youdao.com/fanxian/order";
  	long    lodtdtlSpecialFlag=0;
  	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
	    		Product product=ProductHelper.getById(dtlcache.getOdrdtl_gdsid());
	    		
            String strGdsBrand=product.getGdsmst_brand();
 	    	  if ("001346".equals(strGdsBrand) || "001561".equals(strGdsBrand) || "001564".equals(strGdsBrand))
	    	  {
	    		strRackcode="1";
	    	  }
	    	  else if(strRackcode.startsWith("017") || strRackcode.startsWith("015009")){
	    		 strRackcode="2";
	    	  }
	    	  else {
	    		  strRackcode="3";
	    	  }
	    	  double flOdrdtlFinalPrice=0;
            if (lodtdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
            {
            	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
            }
            else
            {
            	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
            }
            if(Tools.isNull(strGdsId)){
           	 strGdsId=dtlcache.getOdrdtl_gdsid();
      	     	 strNum=dtlcache.getOdrdtl_gdscount().toString();
      	     	 strPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(), 2)+"";
      	     	 strType=strRackcode;
            }
            else{
           	 strGdsId+="||"+dtlcache.getOdrdtl_gdsid();
      	     	 strNum+="||"+dtlcache.getOdrdtl_gdscount().toString();
      	     	 strPrice+="||"+flOdrdtlFinalPrice;
      	     	 strType+="||"+strRackcode;
            }
            
             
           
	    	}
	    	 String arrwangyi[]=strWangYi.split("\\|");
	    	 String strWangYiUid="";
	    	 //String strWangYiWid=null;
	    	 if (arrwangyi.length>1){
	    		strWangYiUid=arrwangyi[1];
	    		//strWangYiWid=arrwangyi[0];
	    	 }
	    	 DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	 StringBuilder strPost=new StringBuilder();
	    	  strPost.append("wid=1102" );
         strPost.append("&userId="+strWangYiUid);
         strPost.append("&mt="+fmt.format(order.getOdrmst_orderdate()));
         strPost.append("&on="+orderId);
         strPost.append("&pid="+strGdsId );
         strPost.append("&pp="+strPrice);
         strPost.append("&pn="+strNum);
         strPost.append("&ct="+strType);
      String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
  	}
}
 /**
  * 领克特返利linktech
  * @param orderId
  * @param fdtltktra
  * @param isQQLoginUser
  * @param strLtinfo
  * @param strLt_user_id
  * @return
  */
public static String postLKT(OrderBase order ,String orderId,double fdtltktra,String isQQLoginUser,String strLtinfo,String strLt_user_id)
{
	String strOdrmstTemp = "linktech" + strLtinfo;
	 if (!Tools.isNull(strLtinfo)){
		if(strLtinfo.indexOf("A100060164")>=0)
		{
			strOdrmstTemp="qq_caibei";

			if(!Tools.isNull(isQQLoginUser))
			{
				strOdrmstTemp = "caibei_qqlogin";
			}
		}
	 }
	 else
	 {
		 strOdrmstTemp = "qq_login";
	 }
	OrderHelper.updateOdrmstCacheTemp(orderId, strOdrmstTemp);
	String strLt_o_cd = orderId;//订单号串
	String strLt_p_cd ="";   //商品编码串：||A||B
	String strLt_it_cnt = ""; //商品数量串：||A||B
	String strLt_price = "";  //商品价格串：||A||B
	String strLt_c_cd = "";   //商品分类串：||A||B   
	String strRackCode = "";
	List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		Product product = ProductHelper.getById(dtlcache.getOdrdtl_gdsid());
	    		String strgds_brand="";  
	    		if(product != null)
	    		  {
	    			strgds_brand=product.getGdsmst_brand();
	    		  }
	    		String strOdrdtl_rackcode=dtlcache.getOdrdtl_rackcode();
	    		if ("001346".equals(strgds_brand) || "001561".equals(strgds_brand) || "001564".equals(strgds_brand))
	    		{
	    			strRackCode=strgds_brand;
	    		}
	    		else if(strOdrdtl_rackcode.startsWith("017"))
	    		{
	    			strRackCode="017";
	    		}
	    		else if(strOdrdtl_rackcode.startsWith("015009"))
	    		{
	    			strRackCode="015009";
	    		}
	    		else
	    		{
	    			strRackCode="other";
	    		}
	    		double fproductfinalprice=0;
	    		if (fdtltktra<1)
	    		{
	    			fproductfinalprice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra,2);
	    		}
	    		else
	    		{
	    			fproductfinalprice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
	    		}
	    		if (Tools.isNull(strLt_p_cd))
	    		{
	    			strLt_p_cd=dtlcache.getOdrdtl_gdsid();
	    			strLt_it_cnt=dtlcache.getOdrdtl_gdscount().toString();
	    			strLt_price=fproductfinalprice+"";
	    			strLt_c_cd=strRackCode;
	    			if((!Tools.isNull(isQQLoginUser)&& Tools.isNull(strLtinfo)) || strLtinfo.indexOf("A100060164")>=0)
	    			{
	    				strLt_c_cd="qq_login";
	    			}
	    		}
	    		else
	    		{
	    			strLt_p_cd+= "||" +dtlcache.getOdrdtl_gdsid();
	    			strLt_it_cnt+= "||" +dtlcache.getOdrdtl_gdscount();
	    			strLt_price+= "||" +fproductfinalprice;
	    			if((!Tools.isNull(isQQLoginUser)&& Tools.isNull(strLtinfo)) || strLtinfo.indexOf("A100060164")>=0)
	    			{
	    				strLt_c_cd+= "||qq_login";
	    			}
	    			else
	    			{
	    				strLt_c_cd+= "||" +strRackCode;
	    			}
	    			
	    		}
	    		
	    		}
	    	StringBuilder stbUrl = new StringBuilder();
	        String strurl="http://service.linktech.cn/purchase_cps.php";
	        if (!Tools.isNull(strLtinfo))
           {
	        if (strLtinfo.startsWith("A100060164"))
	        {
	        	 if (strLt_user_id.indexOf("caibei")>=0)
                {
                    strLt_user_id = strLt_user_id.substring(0, strLt_user_id.length() - 6);
                }
                else if (strLt_user_id.indexOf("qqlogin")>=0)
                {
                    strLt_user_id = strLt_user_id.substring(0, strLt_user_id.length() - 7);
                }
	       
                strLtinfo = strLtinfo.replace("99999999", strLt_user_id);
	        }
                stbUrl.append("a_id="+strLtinfo);
                stbUrl.append("&m_id=d1bianli&mbr_id="+strLt_user_id);
                stbUrl.append("("+order.getOdrmst_rname()+")&o_cd="+strLt_o_cd+"");
                stbUrl.append("&p_cd="+strLt_p_cd);
                stbUrl.append("&price="+strLt_price );
                stbUrl.append("&it_cnt="+strLt_it_cnt);
                stbUrl.append("&c_cd="+strLt_c_cd);
	        }
	        else if (!Tools.isNull(isQQLoginUser))
	        {
	        	 stbUrl.append("a_id=A100060164" + isQQLoginUser);
                stbUrl.append("&m_id=d1bianli&mbr_id="+isQQLoginUser);
                stbUrl.append("&o_cd="+strLt_o_cd);
                stbUrl.append("&p_cd="+strLt_p_cd);
                stbUrl.append("&price="+strLt_price);
                stbUrl.append("&it_cnt="+strLt_it_cnt );
                stbUrl.append("&c_cd="+strLt_c_cd);
           }
     
	       // String ret=   IntfUtil.GetPostData(strurl, stbUrl.toString());
	        //System.out.println("d1gjllmret:"+ret);
   	
        return strurl+"?"+stbUrl.toString();
   }
return "";
}
 /**
  * pluslink多参数
  * @param order
  * @param orderId
  * @param fdtltktra
  * @param strPlinfo
  * @param strMbrmstUID
  * @param strMbrmstName
  */
public static String postPlinfo(OrderBase order ,String orderId,double fdtltktra,String strPlinfo,String strMbrmstUID,String strMbrmstName)
{
	 String strOdrmstTemp = "pluslink" + strPlinfo;
	 OrderHelper.updateOdrmstCacheTemp(orderId,strOdrmstTemp);
 	List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
 	String strRackcode="";
 	long iOdrdtlSpecialFlag=0;
 	double flOdrdtlFinalPrice=0;
 	String strPostUrl="http://www.pluslink.cn/service/pl_cps.php";
 	SimpleDateFormat dTime =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//完整的时间

 	if(odrdtl != null && !odrdtl.isEmpty()){
 		String returl="";
    	for(OrderItemCache dtlcache : odrdtl){
    		strRackcode=dtlcache.getOdrdtl_rackcode();
           iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
           if ("1".equals(iOdrdtlSpecialFlag) || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
           {
           	flOdrdtlFinalPrice=dtlcache.getOdrdtl_finalprice();
           }
           else
           {
           	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
           }
           StringBuilder strPost=new StringBuilder();
           strPost.append("plinfo="+strPlinfo);
           strPost.append("&user_id="+strMbrmstUID);
           strPost.append("&user_name="+strMbrmstName);
           strPost.append("&product_id="+dtlcache.getOdrdtl_gdsid());
           strPost.append("&R_date="+ dTime.toString());
           strPost.append("&order_code="+orderId);
           strPost.append("&product_count="+dtlcache.getOdrdtl_gdscount());
           strPost.append("&product_price="+flOdrdtlFinalPrice);
           strPost.append("&product_category_code="+strRackcode);
           System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
          // String ret=IntfUtil.GetPostData(strPostUrl, strPost.toString());
           returl+="<img src="+strPostUrl+"?"+strPost.toString()+" width=1 height=1 style=display:none>";
    	}
    	return returl;
 	}
 	return "";
}
/**
* 成果网
* @param order
* @param orderId
* @param fdtltktra
* @param strChanet
*/
public static String postChanet(OrderBase order ,String orderId,double fdtltktra,String strChanet)
{
	    OrderHelper.updateOdrmstCacheTemp(orderId,"chanet");
		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
	     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strChanet0="";
     	String strPostUrl="http://www.chanet.com.cn/ec.cgi";
         	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               if (dtlcache.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0)
               {
               	strChanet0=strChanet0+"FM/"+flOdrdtlFinalPrice+"/"+dtlcache.getOdrdtl_gdscount().toString()+ ":";
               }
               else
               {
               	strChanet0= strChanet0 + cps_chanet(dtlcache.getOdrdtl_rackcode())+ "/"+flOdrdtlFinalPrice+"/"+dtlcache.getOdrdtl_gdscount().toString()+ ":";
               }
              
	    	}
	    	strChanet0=strChanet0.substring(0, strChanet0.length()-1);
	    	 StringBuilder strPost=new StringBuilder();
            strPost.append("t=803&i="+orderId);
            strPost.append("&o="+strChanet0);
            System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
           //String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
           return strPostUrl+"?"+strPost.toString();
     	}
	 return "";
}
private static String cps_chanet(String rackcode)
{
    String strcps_chanet = "";
    if (rackcode.startsWith("015009") || rackcode.startsWith("017"))
    {
        strcps_chanet = "C";
    }
    else
    {
        strcps_chanet = "B";
    }
    return strcps_chanet;
}
/**
 * 亿起发eqifa
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strEqifa
 * @param strEQIFAsrc
 */
public static String postEqifa(OrderBase order ,String orderId,double fdtltktra,String strEqifa,String strEQIFAsrc)
{//cps
	 if ("emar_cps".equals(strEQIFAsrc.toLowerCase()) && !Tools.isNull(strEQIFAsrc)){
		 OrderHelper.updateOdrmstCacheTemp(orderId,"eqifa"+strEqifa);
	 }
	 else{//sem
		 OrderHelper.updateOdrmstCacheTemp(orderId,"semeqf"+strEqifa+"|"+strEQIFAsrc);
	 }
		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strEqifa0="";
     	String strPostUrl="http://o.yiqifa.com/adv/d1bl.jsp";

     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
	    		if(dtlcache.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0){
	    			strRackcode="017009";
	    		}
	    		else{
	    			strRackcode=cps(dtlcache.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
	    		}
	    		
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               
               strEqifa0 = strEqifa0 + dtlcache.getOdrdtl_gdsid()+ "/" + flOdrdtlFinalPrice + "/" +dtlcache.getOdrdtl_gdscount() + "/" + strRackcode + ",";
             
	    	}
	    	strEqifa0=strEqifa0.substring(0, strEqifa0.length()-1);
	    	DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	 StringBuilder strPost=new StringBuilder();
	    	strPost.append("website_id="+strEqifa );
           strPost.append("&order_user=");
           strPost.append("&order_id="+orderId);
           strPost.append("&orderdetail="+strEqifa0);
           strPost.append("&order_time="+fmt.format(order.getOdrmst_orderdate()));
           strPost.append("&src="+strEQIFAsrc);
          //String ret=  IntfUtil.GetPostData(strPostUrl, strPost.toString());
          return strPostUrl+"?"+strPost.toString();
           // System.out.println("d1gjllmret:"+ret);
     	}
     	 return "";
}
/**
 * 亿起发yiqifa
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strYiqifa
 * @param strYiqifa_Cid
 */
public static String postYiqifa(OrderBase order ,String orderId,double fdtltktra,String strYiqifa,String strYiqifa_Cid)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,strYiqifa_Cid + "yiqifa" + strYiqifa);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://o.yiqifa.com/servlet/handleCpsIn";
     	String strYiqifa_gdsid ="";
     	String strYiqifa_gdsname = "";
     	String strYiqifa_rackcode ="";
     	String strYiqifa_gdscount = "";
     	String strYiqifa_finalprice = "";
     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
	    		if(dtlcache.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0){
	    			strRackcode="017009";
	    		}
	    		else{
	    			strRackcode=cps(dtlcache.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
	    		}
	    		
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }

               strYiqifa_gdsid+=dtlcache.getOdrdtl_gdsid()+"|";
               try{
            	   strYiqifa_gdsname+=URLEncoder.encode(dtlcache.getOdrdtl_gdsname(),"UTF-8")+"|";
                   }
                   catch(Exception ex)
                   {
                   	ex.printStackTrace();
                   }
               
               strYiqifa_rackcode+=strRackcode+"|";
               strYiqifa_gdscount+=dtlcache.getOdrdtl_gdscount().toString()+"|";
               strYiqifa_finalprice+=flOdrdtlFinalPrice+"|";
	    	}
	    	String arrstryiqifa[]=strYiqifa.split("\\|");
	    	String strYiqifa_Wid="";
	    	String strFtb="";
	    	if (arrstryiqifa.length>0){
	    		strYiqifa_Wid=arrstryiqifa[0];      	    		
	    	}
	    	if(arrstryiqifa.length>1) {
	    		strFtb=arrstryiqifa[1];
     	    }
	    	DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	StringBuilder strPost=new StringBuilder();
	    	String sd="";
	    	 try{
	    		 sd= URLEncoder.encode(fmt.format(order.getOdrmst_orderdate()),"UTF-8");
                 }
                 catch(Exception ex)
                 {
                 	ex.printStackTrace();
                 }
	    	strPost.append("cid="+strYiqifa_Cid);
           strPost.append("&wid="+strYiqifa_Wid);
           strPost.append("&on="+orderId);
           strPost.append("&pn="+cutend(strYiqifa_gdsid));
           strPost.append("&pna="+cutend(strYiqifa_gdsname));
           strPost.append("&ct="+cutend(strYiqifa_rackcode));
           strPost.append("&ta="+cutend(strYiqifa_gdscount));
           strPost.append("&pp="+cutend(strYiqifa_finalprice));
           strPost.append("&sd="+sd);
           strPost.append("&fbt="+strFtb+"&encoding=UTF-8");
           System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
         // String ret=  IntfUtil.GetPostData(strPostUrl, strPost.toString());
          return strPostUrl+"?"+strPost.toString();
     	}
     	 return "";
}
private static String cutend(String str)
{
	 str=str.substring(0, str.length()-1);
	 return str;
}
private static String cps(String rackcode,String specialflag)
{
    String strRet = "";
    if (rackcode.startsWith("015009"))
    {
        strRet = rackcode.substring(0, 6);
    }
    else if (rackcode.startsWith("017"))
    {
        strRet = rackcode.substring(0, 3);
    }
    else
    {
        strRet = "0";
    }
    return strRet;
}
//获取订单状态
static String checkOrderStatus(int orderstatus,int odrmst_printflag,int OdrMst_Refundtype){
String status = "0";
if(orderstatus==-1 || orderstatus==-2){
	status = "-1";
}
else if(orderstatus==0){
	status = "1";
}
else if(odrmst_printflag==0){
	status = "2";
}
else if(odrmst_printflag==1){
	status = "3";
}
else if(orderstatus==31 || orderstatus==3){
	status = "4";
}
else if(orderstatus==51 || orderstatus==3){
	status = "5";
}
else if(OdrMst_Refundtype>0){
	status = "7";
}
return status;
}
//支付类型
static String getpaymethod(int payid){
	String pid="3";
	
	 if(payid==1){
		 pid="2"; 
	 }
	 else if(payid==4){
		 pid="1"; 
	 }
	return pid;	
}
/**
* 乐乐
* @param order
* @param orderId
* @param fdtltktra
* @param strLele
* @param strLele_S
*/
public static void postLele(OrderBase order ,String orderId,double fdtltktra,String strLele,String strLele_S)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,"lele" + strLele + "-" + strLele_S);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://59.151.26.108:8013/Qimeng.aspx";
     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
	    		strRackcode=cps(dtlcache.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
	    		
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               StringBuilder strPost=new StringBuilder();
               DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
               strPost.append("user=QimengData&pwd=LeleData-Qimeng");
               strPost.append("&orderNo="+orderId);
               strPost.append("&productType="+strRackcode);
               strPost.append("&price="+flOdrdtlFinalPrice);
               strPost.append("&sum="+dtlcache.getOdrdtl_gdscount().toString());
               strPost.append("&orderTime="+fmt.format(order.getOdrmst_orderdate()));
               strPost.append("&unionId="+strLele);
               strPost.append("&subUnionId="+strLele_S);
               System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
              String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
               System.out.println("d1gjllmret:"+ret);
	    	}//for

	    	
     	}
	 
}
/**
 * 一兜
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strYeedou
 */
public static String postYeedou(OrderBase order ,String orderId,double fdtltktra,String strYeedou)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,"yeedou" + strYeedou);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://interface.yeedou.com/merchant/d1.aspx";
     	String strYeedou_gdsid ="";
     	String strYeedou_rackcode ="";
     	String strYeedou_gdscount = "";
     	String strYeedou_finalprice = "";
     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
	    		strRackcode=cps(dtlcache.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               strYeedou_gdsid+=dtlcache.getOdrdtl_gdsid()+",";
               strYeedou_rackcode+=strRackcode+",";
               strYeedou_gdscount+=dtlcache.getOdrdtl_gdscount().toString()+",";
               strYeedou_finalprice+=flOdrdtlFinalPrice+",";
	    	}
  	     StringBuilder strPost=new StringBuilder();
  	   DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  	     strPost.append("itemno="+cutend(strYeedou_gdsid));
        strPost.append("&buynum="+cutend(strYeedou_gdscount));
        strPost.append("&itemprice="+cutend(strYeedou_finalprice));
        strPost.append("&category="+cutend(strYeedou_rackcode));
        strPost.append("&orderno="+orderId);
        strPost.append("&orderdate="+fmt.format(order.getOdrmst_orderdate()));
        strPost.append("&source="+strYeedou);
       System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
       //String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
       return strPostUrl+"?"+strPost.toString();
     	}
     	 return "";
}
/**
 * 唯一
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strWEIYI
 * @param strMbrid
 */
public static void postWeiyi(OrderBase order ,String orderId,double fdtltktra,String strWEIYI,String strMbrid)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,"WEIYI" + strWEIYI);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://track.weiyi.com/orderpush.aspx";
     	String strWeiyi_gdsid ="";
     	String strWeiyi_rackcode ="";
     	String strWeiyi_gdscount = "";
     	String strWeiyi_finalprice = "";
     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
	    		if(dtlcache.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0){
	    			strRackcode="017009";
	    		}
	    		else{
	    			strRackcode=cps(dtlcache.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
	    		}
	    		
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               strWeiyi_gdsid+=dtlcache.getOdrdtl_gdsid()+"|";
               strWeiyi_rackcode+=strRackcode+"|";
               strWeiyi_gdscount+=dtlcache.getOdrdtl_gdscount().toString()+"|";
               strWeiyi_finalprice+=flOdrdtlFinalPrice+"|";
	    	}
	    	
	    	StringBuilder strPost=new StringBuilder();
	    	SimpleDateFormat DtimeWeiyi = new SimpleDateFormat("yyyyMMddHHmmss");//
	    	strPost.append("mid=d1bianli");
           strPost.append("&pwd=");
           strPost.append("&odate="+DtimeWeiyi.format(order.getOdrmst_orderdate()));
           strPost.append("&cid="+strWEIYI);
           strPost.append("&bid="+strMbrid);
           strPost.append("&oid="+orderId);
           strPost.append("&pid="+strWeiyi_gdsid);
           strPost.append("&ptype="+strWeiyi_rackcode);
           strPost.append("&pnum="+strWeiyi_gdscount);
           strPost.append("&price="+strWeiyi_finalprice);
           strPost.append("&ostat=0");
           System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
           String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
            System.out.println("d1gjllmret:"+ret);
     	}
	 
}
/**
 * 联通IPVGOU
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strIPVGOU
 */
public static void postIpvgou(OrderBase order ,String orderId,double fdtltktra,String strIPVGOU)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,strIPVGOU);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://zhejiang.ipvgou.com/zzvcom/sendOrderDataParam.action";
     	String strIpvgou_gdsid ="";
     	String strIpvgou_gdscount = "";
     	String strIpvgou_finalprice = "";
        double flIpvgou_summoney = 0;
       int iIpvgou_sumcount = 0;
       double flIpvgou_sumflmoney = 0;
       String strIpvgou_flmoney="";
     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               double flIpvgou_fl=0;
               flIpvgou_summoney+=Tools.getDouble(flOdrdtlFinalPrice*dtlcache.getOdrdtl_gdscount(),2);
               iIpvgou_sumcount+=dtlcache.getOdrdtl_gdscount();
              
               strIpvgou_gdsid+=dtlcache.getOdrdtl_gdsid()+",";
               strIpvgou_gdscount+=dtlcache.getOdrdtl_gdscount().toString()+",";
               strIpvgou_finalprice+=flOdrdtlFinalPrice+",";
               if(strRackcode.startsWith("017") || strRackcode.startsWith("015009")){
               	flIpvgou_fl = 0.12f;
               }
               else{
               	flIpvgou_fl = 0.06f;
               }
               double flTemp=Tools.getDouble(flOdrdtlFinalPrice*dtlcache.getOdrdtl_gdscount()*flIpvgou_fl,2);
               strIpvgou_flmoney+=flTemp+",";
               flIpvgou_sumflmoney+=flTemp;
	    	}
	    	String arrstrIpvgou[]=strIPVGOU.split("\\||");
	    	String strIpvgou_Wid="";
	    	if(arrstrIpvgou.length>1) {
	    		strIpvgou_Wid=arrstrIpvgou[1];
     	    }
	    	StringBuilder strPost=new StringBuilder();
	    	DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	strPost.append("spcode=d1&unionParams="+strIpvgou_Wid);
           strPost.append("&orderCode="+orderId);
           strPost.append("&orderTime="+fmt.format(order.getOdrmst_orderdate()));
           strPost.append("&fanli="+flIpvgou_sumflmoney);
           strPost.append("&orderMoney="+flIpvgou_summoney);
           strPost.append("&orderTotalMoney="+order.getOdrmst_acturepaymoney().toString());
           strPost.append("&productCount="+iIpvgou_sumcount);
           strPost.append("&productId="+strIpvgou_gdsid);
           strPost.append("&productNum="+strIpvgou_gdscount);
           strPost.append("&productPrice="+strIpvgou_finalprice);
           strPost.append("&productFlMoney="+strIpvgou_flmoney);
           System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
           String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
            System.out.println("d1gjllmret:"+ret);
     	}
	 
}
 /**
  * 搜狐VIP
  * @param order
  * @param orderId
  * @param fdtltktra
  * @param strSOHUVIP
  */
public static void postSohuvip(OrderBase order ,String orderId,double fdtltktra,String strSOHUVIP)
{
	    OrderHelper.updateOdrmstCacheTemp(orderId,strSOHUVIP);
     	String strPostUrl="http://vip.sohu.com/interface/vipactivity_ret.jsp";
         String arrstrSohuvip[]=strSOHUVIP.split("\\|");
         String strSohuCode = "";
       String strSohuUID ="";
         if (arrstrSohuvip.length>1){
         	strSohuCode="2viP%D1@#*sohu"+arrstrSohuvip[1];
         	strSohuCode=MD5.to32MD5(strSohuCode);
         	strSohuUID=arrstrSohuvip[1];
         }

	    StringBuilder strPost=new StringBuilder();
	   strPost.append("app=d1&act=2&userid="+strSohuUID );
	   strPost.append("&om="+order.getOdrmst_acturepaymoney());
	   strPost.append("&code="+strSohuCode);
	   System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
      String ret= IntfUtil.GetPostData(strPostUrl, strPost.toString());
       System.out.println("d1gjllmret:"+ret);

}
/**
* 平安万里通
* @param order
* @param orderId
* @param fdtltktra
* @param strPingan
*/
public static void postPingan(OrderBase order ,String orderId)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,"pingan");

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
		 String strProNum = "";//商品数量
		 String strProId = ""; //商品编码
		 String strProdCate = ""; //商品分类
		 String strProName = "";//商品名称
		 String strProPrice = "";//商品单价
     	String strPostUrl="https://www.wanlitong.com/synOrderInfo.do";

     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
             if (Tools.isNull(strProId)){
           	  strProNum=dtlcache.getOdrdtl_gdscount().toString();
           	  strProId=dtlcache.getOdrdtl_gdsid();
           	  strProdCate=dtlcache.getOdrdtl_rackcode();
           	  strProName=Tools.clearHTML(dtlcache.getOdrdtl_gdsname());
           	  strProPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2)+"";
             }
             else{
           	  strProNum="$|$"+dtlcache.getOdrdtl_gdscount().toString();
           	  strProId="$|$"+dtlcache.getOdrdtl_gdsid();
           	  strProdCate="$|$"+dtlcache.getOdrdtl_rackcode();
           	  strProName="$|$"+Tools.clearHTML(dtlcache.getOdrdtl_gdsname());
           	  strProPrice="$|$"+Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
             }
	    	}
	    	
	    	PingAnUser pinAnUser=UserHelper.getPinganLoginUser(order.getOdrmst_mbrid().toString());
	    	if(pinAnUser == null) return;
	    	String strPingAnId=pinAnUser.getMbrmstpingan_memberid();
	    	String strPinganYdmm = "1-O73UW3";
	    	String strAmount =order.getOdrmst_acturepaymoney().toString();
	    	DateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	    	String strTTTime =format.format(order.getOdrmst_orderdate()).toString();
	    	String strSignStr = strPingAnId + strAmount + strPinganYdmm;
	    	String strPaSignature = MD5.to32MD5(strSignStr);
	    	
	    	 StringBuilder strPost=new StringBuilder();
	    	strPost.append("Partner=79_0");
           strPost.append("&MemberID="+strPingAnId);
           strPost.append("&Amount="+strAmount);
           strPost.append("&TTTime="+strTTTime);
           strPost.append("&TTNumber="+orderId);
           try{
           strPost.append("&ProNum="+java.net.URLEncoder.encode(strProNum, "UTF-8"));
           strPost.append("&ProId="+java.net.URLEncoder.encode(strProId, "UTF-8"));
           strPost.append("&ProdName="+java.net.URLEncoder.encode(strProName, "UTF-8"));
           strPost.append("&ProPrice="+java.net.URLEncoder.encode(strProPrice, "UTF-8"));
           strPost.append("&ProdCate="+java.net.URLEncoder.encode(strProdCate, "UTF-8"));
           }
           catch(Exception ex)
           {
           	ex.printStackTrace();
           }
           strPost.append("&Ext1=");
           strPost.append("&Ext2=");
           strPost.append("&Ext3=");
           strPost.append("&MediumSource=");
           strPost.append("&paSignature="+strPaSignature);
           try{
            // URL url = new URL(strPostUrl); 
             
            /*  javax.net.ssl.HostnameVerifier hv45543 = new javax.net.ssl.HostnameVerifier() {
     			public boolean verify(String urlHostName, javax.net.ssl.SSLSession session34234) {
     				return true;
     			}
     		};

     		HttpsURLConnection.setDefaultHostnameVerifier(hv45543);  */
     		
          //  String ret=InterfacePost.Postdata(strPostUrl, strPost.toString());
             sendPOSTRequestForInputStream(strPostUrl, strPost.toString(),"UTF-8");
           }
           catch(Exception ex)
           {
           	ex.printStackTrace();
           }
     	}
}
/**
 * 51返利网
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strFANLI
 */
public static String postFanli(OrderBase order ,String orderId,double fdtltktra,String strFANLI)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,strFANLI);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://data.51fanli.com/union/fanliorder.asp";
     	String strFanli_gdsid ="";
     	String strFanli_rackcode ="";
     	String strFanli_gdscount = "";
     	String strFanli_finalprice = "";
     	//double fltFanli_summoney = 0;
       String strFanli_comm ="";
     	if(odrdtl != null && !odrdtl.isEmpty()){
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               double fltFanLi_fl = 0;
               String strFanLi_c_cd="";
               String strGdsBrand="";
               //fltFanli_summoney+=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*dtlcache.getOdrdtl_gdscount(),2);
               strFanli_gdsid+=dtlcache.getOdrdtl_gdsid()+"|_|";   
               Product product=ProductHelper.getById(dtlcache.getOdrdtl_gdsid());
               strGdsBrand=product.getGdsmst_brand();
               if (strGdsBrand == "001346" || //F&M
               		strGdsBrand == "001561" ||//YouSoo
               		strGdsBrand == "001564")//小栗舍

                   {
                       fltFanLi_fl = 0.15f;
                       strFanLi_c_cd = "C";
                   }
               else if(strRackcode.startsWith("017") ||//服装
               		strRackcode.startsWith("015009"))//饰品
               {
               	fltFanLi_fl = 0.08f;
                   strFanLi_c_cd = "A";
               }
               else{
               	fltFanLi_fl = 0.04f;
                   strFanLi_c_cd = "B";
               }
               strFanli_rackcode+=strFanLi_c_cd+"|_|";
               strFanli_gdscount+=dtlcache.getOdrdtl_gdscount().toString()+"|_|";
               strFanli_finalprice+=flOdrdtlFinalPrice+"|_|";
               double fltFanliSum = flOdrdtlFinalPrice*dtlcache.getOdrdtl_gdscount()*fltFanLi_fl;
               strFanli_comm+=fltFanliSum+"|_|";
	    	}
	    	String arrstrFanli[]=strFANLI.split("\\|");
	    	String strFanliUid="";
      	   if(arrstrFanli.length>1) {
      		strFanliUid=arrstrFanli[1];
     	    }
	    	StringBuilder strPost=new StringBuilder();
	    	DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	strPost.append("otime="+fmt.format(order.getOdrmst_orderdate()));
           strPost.append("&o_cd="+orderId);
           strPost.append("&m_id=d1&k=123456&u_id="+strFanliUid);
           strPost.append("&p_cd="+strFanli_gdsid );
           strPost.append("&c_cd="+strFanli_rackcode);
           strPost.append("&it_cnt="+strFanli_gdscount);
           strPost.append("&price="+strFanli_finalprice);
           strPost.append("&comm="+strFanli_comm);
           System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
         //String ret=  IntfUtil.GetPostData(strPostUrl, strPost.toString());
         return strPostUrl+"?"+strPost.toString();

     	}
     	 return "";
}
/**
* 亿起发亿告
* @param order
* @param orderId
* @param fdtltktra
* @param strYiGao
*/
public static String postYigao(OrderBase order ,String orderId,String strYiGao)
{
		 OrderHelper.updateOdrmstCacheTemp(orderId,"yigao" + strYiGao);

		Double fltYiGao_pp = order.getOdrmst_gdsmoney() -order.getOdrmst_tktvalue();
       String strYiGao_on = orderId;
       DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       String strYiGao_sd =fmt.format(order.getOdrmst_orderdate());
       String[] arrYiGaoWid = strYiGao.split("\\|");
       String strYiGaoWid ="";
       String strYiGaoFbt = "";
       if (arrYiGaoWid.length>0){
       	strYiGaoWid=arrYiGaoWid[0];
       }
       if (arrYiGaoWid.length>1){
       	strYiGaoFbt=arrYiGaoWid[1];
       }                 
     	String strPostUrl="http://o.yiqifa.com/servlet/handleCpsIn";
	    	 StringBuilder strPost=new StringBuilder();
	    	strPost.append("cid=5481");
           strPost.append("&wid="+strYiGaoWid);
           strPost.append("&on="+strYiGao_on);
           strPost.append("&pn=&pna=&ct=&ta=1");
           strPost.append("&pp="+fltYiGao_pp.toString());
           strPost.append("&sd="+strYiGao_sd);
           strPost.append("&fbt="+strYiGaoFbt);
           System.out.println("d1gjllm:"+strPostUrl+strPost.toString());
          //String ret=  IntfUtil.GetPostData(strPostUrl, strPost.toString());
          return strPostUrl+"?"+strPost.toString();
 }
/**
 * 51返利网
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strFANLI
 */
public static String postFanli(OrderBase order ,String orderId,double fdtltktra,String strFANLI,User user,String tracking_code,String username)
{
	String q="";
	String temp="";
	
	if(!Tools.isNull(strFANLI)){
		temp=strFANLI;
	}else{
		temp="51fanlilogin|";
	}
	if(Tools.isNull(username)){
		username="";
	}else{
		if(!username.equals(user.getMbrmst_uid().trim())){
			username=user.getMbrmst_uid().trim();
		}
	}
	temp+="|"+username;
	if(Tools.isNull(tracking_code)){
		tracking_code="";
	}
	temp+="|"+tracking_code;
		 OrderHelper.updateOdrmstCacheTemp(orderId,temp);

		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strPostUrl="http://data2.51fanli.com/index.php/Post/pushOrder";
     	String strFanli_gdsid ="";
     	String strFanli_rackcode ="";
     	String strFanli_gdscount = "";
     	String strFanli_finalprice = "";
     	//double fltFanli_summoney = 0;
     	StringBuffer str=new StringBuffer();
     	int amount=0;
		if(odrdtl != null && !odrdtl.isEmpty()){
			 for(OrderItemCache itembase:odrdtl){
				  amount+=itembase.getOdrdtl_gdscount().intValue();
			  }
		  }
       String strFanli_comm ="";
       String shopkey="667fa3f64e9bc8bd";
       String strFanliUid="";
	if(!Tools.isNull(strFANLI)){
    	   String arrstrFanli[]=strFANLI.split("\\|");
    	     if(arrstrFanli.length>1) {
     		strFanliUid=arrstrFanli[1];
    	    }
       }
       //else{
    	  // strFanliUid=user.getMbrmst_uid().trim();
    	  // strFanliUid=strFanliUid.substring(0,strFanliUid.indexOf("@51fanli"));
      // }
       String strPassCode =orderId+"d1bianli"+strFanliUid+shopkey;
		strPassCode=MD5.to32MD5(strPassCode.toLowerCase());
			
		str.append("%3Cfanli_data version=\"3.0\"%3E");
		  str.append("%3Corder order_time=\"");
		  str.append(Tools.stockFormatDate((order.getOdrmst_orderdate())));
		  str.append("\" order_no=\"");
		  str.append(orderId);
		  str.append("\"  shop_no=\"d1\"");
		  str.append(" total_price=\"");
		  str.append(Tools.getDouble(order.getOdrmst_ordermoney().doubleValue(),2));
		  str.append("\" total_qty=\"");
		  str.append(amount);
		  str.append("\" shop_key=\"");
		  str.append(shopkey);
		  str.append("\" u_id=\"");
		  str.append(strFanliUid);
		  str.append("\" username=\"");
		  str.append(username.trim());
		  str.append("\"  is_pay=\"");
		  str.append(order.getOdrmst_realstatus().intValue());
		  str.append("\"  pay_type=\"");
 		  str.append(getpaymethod(order.getOdrmst_paytype().intValue()));
		  
		  str.append("\"  order_status=\"");
		  str.append(checkOrderStatus(order.getOdrmst_orderstatus().intValue(),order.getOdrmst_printflag().intValue(),order.getOdrmst_refundtype().intValue()));
		  str.append("\"  deli_name=\"");
		 String deliname="";
		 try{
			 deliname= URLEncoder.encode(order.getOdrmst_shipmethod(),"utf-8"); 
		 }catch(Exception e){
			 
		 }
		  str.append( deliname);
		  str.append("\"  deli_no=\"");
		  str.append(order.getOdrmst_fhcode());
		  str.append("\"   tracking_code=\"");
		  str.append(tracking_code);
		  str.append("\"  pass_code=\"");
		  str.append(strPassCode);
		  str.append("\" %3E");
		  String tktid=order.getOdrmst_tktid().toString();
		  double lmtktra=1;
		  lmtktra=getTktRa(order.getOdrmst_tktvalue().doubleValue(),order.getId());
     	if(odrdtl != null && !odrdtl.isEmpty()){
     		  String str1=" %3Ccoupons_all%3E";
			  str.append(" %3Cproducts_all%3E");
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
               if (iOdrdtlSpecialFlag==1 || dtlcache.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(dtlcache.getOdrdtl_temp()))
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
               }
               else
               {
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra, 2);
               }
               double fltFanLi_fl = 0;
               String strFanLi_c_cd="";
               String strGdsBrand="";
               //fltFanli_summoney+=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*dtlcache.getOdrdtl_gdscount(),2);
               strFanli_gdsid+=dtlcache.getOdrdtl_gdsid()+"|_|";   
               Product product=ProductHelper.getById(dtlcache.getOdrdtl_gdsid());
               strGdsBrand=product.getGdsmst_brand();
               if (strGdsBrand == "001346" || //F&M
               		strGdsBrand == "001561" ||//YouSoo
               		strGdsBrand == "001564")//小栗舍

                   {
                       fltFanLi_fl = 0.15f;
                       strFanLi_c_cd = "C";
                   }
               else if(strRackcode.startsWith("017") ||//服装
               		strRackcode.startsWith("015009"))//饰品
               {
               	fltFanLi_fl = 0.08f;
                   strFanLi_c_cd = "A";
               }
               else{
               	fltFanLi_fl = 0.04f;
                   strFanLi_c_cd = "B";
               }
             
               str.append("%3Cproduct%3E");
               str.append("%3Cproduct_id%3E");
               str.append(dtlcache.getOdrdtl_gdsid());
               str.append("%3C/product_id%3E");
               str.append("%3Cproduct_url%3Ehttp://www.d1.com.cn/product/");
               str.append(dtlcache.getOdrdtl_gdsid());
               str.append("%3C/product_url%3E");
               str.append("%3Cproduct_qty%3E");
               str.append(dtlcache.getOdrdtl_gdscount()+"");
               str.append("%3C/product_qty%3E");
               str.append("%3Cproduct_price%3E");
               str.append(Tools.getDouble(flOdrdtlFinalPrice,2));
               str.append("%3C/product_price%3E");
               str.append("%3Cproduct_comm%3E");
               str.append(Tools.getDouble(fltFanLi_fl,2));
               str.append("%3C/product_comm%3E");
            
               str.append("%3Ccomm_no%3E");
               str.append(strFanLi_c_cd);
               str.append("%3C/comm_no%3E");
               str.append("%3C/product%3E");
            
               str1+="%3Ccoupon%3E%3Ccoupon_no%3E"+tktid+"%3C/coupon_no%3E%3Ccoupon_qty%3E1%3C/coupon_qty%3E%3Ccoupon_price%3E"+-Tools.getDouble((dtlcache.getOdrdtl_finalprice().doubleValue()*(1-lmtktra)),2)+"%3C/coupon_price%3E";
			  str1+="%3Ccomm_no%3E"+strFanLi_c_cd+"%3C/comm_no %3E%3C/coupon%3E";
	    	}
	    	  str1+="%3C/coupons_all%3E";
			  str.append("%3C/products_all%3E"); 
			  str.append(str1);
	    	
     	}
     	 str.append("%3C/order%3E"); 
     	str.append("%3C/fanli_data%3E"); 
     	String strpost="content="+str.toString();
     	HttpURLConnection conn2=null;
    	DataOutputStream output=null;
    	BufferedReader br=null;
    	try{
    		
    	URL url = new URL(strPostUrl);
     conn2=(HttpURLConnection)url.openConnection();
    conn2.setDoOutput(true);
    conn2.setDoInput(true);
    conn2.setRequestMethod("POST");
    output=new DataOutputStream(conn2.getOutputStream());

    output.writeBytes(strpost);

    	
    if(output!=null){
    		output.flush();
    	 output.close();  
    	 }
     br=new BufferedReader(new InputStreamReader(conn2.getInputStream(),"utf-8"));
     String s="";
     while((s=br.readLine())!=null){
    	System.out.print(s);
    	q=s;
     }
     br.close();
     if(conn2!=null){
    		 conn2.disconnect();
    	}

    //return HttpUtil.postData(strPostUrl, str.toString(), "utf-8");
    // return strpost;
     //IntfUtil.GetPostData(strPostUrl,strpost);
    // return  strpost;
    //q="222222222222";
    	}catch(Exception e){
    		e.printStackTrace();
    		q="222222222222";
    	}finally{
    		 try {   
    			 if(output!=null){
    				output.flush();
           	 output.close();  
    			 }
    			if(conn2!=null){
    				 conn2.disconnect();
    			}
        } catch (Exception e) {   
            e.printStackTrace();   
            
        }   
    		
    	}
     return q;
}
/**
* 站内联盟
* @param order
* @param strLianmeng
* @param strSubad
*/
public static void UPLianmeng(OrderBase order,String strLianmeng,String strSubad) 
{
	String strPeoPlercm=strLianmeng.substring(9);
	User userrcm=UserHelper.getByUsername(strPeoPlercm);
	// System.out.println("d1gjllm:"+strPeoPlercm+"--"+strSubad);
	if (userrcm!=null)
	{
	 String strMbrid=userrcm.getId();
	 //OrderHelper.updateOdrmstCachePeoplercm(orderId, strMbrid, strSubad);
	    order.setOdrmst_peoplercm(strMbrid);
		order.setOdrmst_subad(strSubad);
		Tools.getManager(order.getClass()).update(order, false);
	}
	
	
}
public static void UPSubAd(OrderBase order,String strSubad) 
{
		order.setOdrmst_subad(strSubad);
		Tools.getManager(order.getClass()).update(order, false);
}


%>