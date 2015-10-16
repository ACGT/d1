<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%!
public static void UPSubAd(OrderBase order,String strSubad) 
{
		order.setOdrmst_subad(strSubad);
		Tools.getManager(order.getClass()).update(order, false);
}
public static double getTktRa(double tktvalue,String odrid )
{
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlCacheByOrderId(odrid);
	
	double allmoney=0;
	double retra=1;
	if(list==null)return retra;
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
public static String postLKT(OrderBase order ,String orderId,double fdtltktra,String strLtinfo,String strLt_user_id)
{
	String strOdrmstTemp = "waplinktech" + strLtinfo;
	System.out.println(strOdrmstTemp+"============strOdrmstTemp");
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
	    		String strodrdtl_shopcode=dtlcache.getOdrdtl_shopcode();
	    		if (dtlcache.getOdrdtl_downflag().longValue()==20){
	    			strRackCode="001";
	   	    	}else if ("001346".equals(strgds_brand) || "001561".equals(strgds_brand) || "001564".equals(strgds_brand))
	    		{
	    			strRackCode=strgds_brand;
	    		}
	    		else if(!strodrdtl_shopcode.equals("00000000")&&!dtlcache.getOdrdtl_rackcode().startsWith("014") )
	    		{
	    			strRackCode="shop";
	    		}
	    		else if(strOdrdtl_rackcode.startsWith("02")||strOdrdtl_rackcode.startsWith("03"))
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
	    		if (fdtltktra<1){
	    			fproductfinalprice=Tools.getDouble(dtlcache.getOdrdtl_finalprice()*fdtltktra,2);
	    		}
	    		else{
	    			fproductfinalprice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
	    		}
	    		if (Tools.isNull(strLt_p_cd)){
	    			strLt_p_cd=dtlcache.getOdrdtl_gdsid();
	    			strLt_it_cnt=dtlcache.getOdrdtl_gdscount().toString();
	    			strLt_price=fproductfinalprice+"";
	    			strLt_c_cd=strRackCode;
	    		}
	    		else{
	    			strLt_p_cd+= "||" +dtlcache.getOdrdtl_gdsid();
	    			strLt_it_cnt+= "||" +dtlcache.getOdrdtl_gdscount();
	    			strLt_price+= "||" +fproductfinalprice;
	    			strLt_c_cd+= "||" +strRackCode;
	    			
	    		}
	    		
	    		}
	    	StringBuilder stbUrl = new StringBuilder();
	        String strurl="http://service.linktech.cn/purchase_cps.php";
	        
	        String aid=strLtinfo;
	        
	       
                stbUrl.append("a_id="+aid);
                stbUrl.append("&m_id=d1bianliwap&mbr_id="+strLt_user_id);
                stbUrl.append("("+order.getOdrmst_rname()+")&o_cd="+strLt_o_cd+"");
                stbUrl.append("&p_cd="+strLt_p_cd);
                stbUrl.append("&price="+strLt_price );
                stbUrl.append("&it_cnt="+strLt_it_cnt);
                stbUrl.append("&c_cd="+strLt_c_cd);
	       
     
                System.out.println(strurl+"?"+stbUrl.toString()+"============strOdrmstTemp");
        return strurl+"?"+stbUrl.toString();
        
   }
	 System.out.println("-------------------------------------");
return "";
}
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
private static String cps(String rackcode,String specialflag)
{
    String strRet = "";
    if (rackcode.startsWith("015009"))
    {
        strRet = rackcode.substring(0, 6);
    }
    else if (rackcode.startsWith("02")||rackcode.startsWith("03"))
    {
        strRet = "017";
    }
    else
    {
        strRet = "0";
    }
    return strRet;
}
/**
 * 亿起发eqifa
 * @param order
 * @param orderId
 * @param fdtltktra
 * @param strEqifa//src、channel、cid、wi
 */
public static String postEqifa(OrderBase order ,String orderId,double fdtltktra,String strEqifa)
{//cps
	 
		 OrderHelper.updateOdrmstCacheTemp(orderId,"wapeqifa"+strEqifa);
	 
		List<OrderItemCache> odrdtl=OrderItemHelper.getOrderItemCacheByOrderId(orderId);
     	String strRackcode="";
     	long iOdrdtlSpecialFlag=0;
     	double flOdrdtlFinalPrice=0;
     	String strEqifa0="";
     	String strPostUrl="http://o.yiqifa.com/servlet/handleCpsIn";

     	if(odrdtl != null && !odrdtl.isEmpty()){
     		String strpn ="";   
     		String strpna = ""; 
     		String strct = "";  
     		String strta = "";   
     		String strpp = "";
	    	for(OrderItemCache dtlcache : odrdtl){
	    		strRackcode=dtlcache.getOdrdtl_rackcode();
               iOdrdtlSpecialFlag=dtlcache.getOdrdtl_specialflag();
	    	  if (dtlcache.getOdrdtl_downflag().longValue()==20){
   			 strRackcode="001";
	    	}else if(dtlcache.getOdrdtl_gdsname().indexOf("FEEL MIND")>=0||
	    				dtlcache.getOdrdtl_gdsname().indexOf("小栗舍")>=0 ||
	    				dtlcache.getOdrdtl_gdsname().indexOf("YOUSOO")>=0){
	    			strRackcode="017009";
	    		 }else if (!dtlcache.getOdrdtl_shopcode().equals("00000000")&&!dtlcache.getOdrdtl_rackcode().startsWith("014")){
	    			 strRackcode="shop";
	    		}
	    		else{
	    			strRackcode=cps(dtlcache.getOdrdtl_rackcode(),iOdrdtlSpecialFlag+"");
	    		}
	    		
             
               	flOdrdtlFinalPrice=Tools.getDouble(dtlcache.getOdrdtl_finalprice(),2);
              
               
               strEqifa0 = strEqifa0 + dtlcache.getOdrdtl_gdsid()+ "/" + flOdrdtlFinalPrice + "/" +dtlcache.getOdrdtl_gdscount() + "/" + strRackcode + ",";
               if (Tools.isNull(strpn)){
            	     strpn =dtlcache.getOdrdtl_gdsid();   
            		 strpna =Tools.clearHTML(dtlcache.getOdrdtl_gdsname()); 
            		 strct = strRackcode;  
            		 strta =dtlcache.getOdrdtl_gdscount()+"";   
            		 strpp = flOdrdtlFinalPrice+"";
            
	    		}
	    		else{
	    			strpn +="|"+dtlcache.getOdrdtl_gdsid();   
           		    strpna +="|"+Tools.clearHTML(dtlcache.getOdrdtl_gdsname()); 
           		    strct += "|"+strRackcode;  
           		    strta +="|"+dtlcache.getOdrdtl_gdscount();   
           		    strpp +="|"+ flOdrdtlFinalPrice;
	    			
	    		}
	    	}
	    	//strEqifa//src、channel、cid、wi
	    	DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	String[] eqifaarr=strEqifa.split("\\|");
	    	String strcid="";
	    	String strwi="";
	    	if(eqifaarr.length>2)strcid=eqifaarr[2];
	    	if(eqifaarr.length>3)strwi=eqifaarr[3];
	    	long los=-1;
	    	if(order.getOdrmst_orderstatus().longValue()>=0){
	    		los=order.getOdrmst_orderstatus().longValue();
	           }
	    	 StringBuilder strPost=new StringBuilder();
	    	strPost.append("cid="+strcid);
           strPost.append("&wi="+strwi);
           strPost.append("&on="+orderId);
           strPost.append("&pn="+strpn);
           strPost.append("&pna="+strpna);
           strPost.append("&ct="+strct);
           strPost.append("&ta="+strta);
           strPost.append("&pp="+strpp);
           strPost.append("&sd="+fmt.format(order.getOdrmst_orderdate()));
           strPost.append("&dt=m");
           strPost.append("&os="+los);
           strPost.append("&ps="+order.getOdrmst_orderstatus());
           strPost.append("&pw="+order.getOdrmst_paymethod());
           strPost.append("&far="+Tools.getDouble(order.getOdrmst_shipfee(), 2));
           strPost.append("&fav="+Tools.getDouble(order.getOdrmst_tktvalue(),2));
           strPost.append("&fac="+strEqifa0);
           strPost.append("&encoding=");
           System.out.println("d1gjllmret:"+strPostUrl+"?"+strPost.toString());
          return strPostUrl+"?"+strPost.toString();
           
     	}
     	 return "";
}
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
}else{
	String orderId = (String)session.getAttribute("OrderCacheId");
	if(Tools.isNull(orderId)){
	 json.put("status", "0");
	}else{
		 DecimalFormat df = new DecimalFormat("0.00");
		OrderBase order = OrderHelper.getById(orderId);
		if(order != null){
			json.put("status", "1");
			json.put("odrid",orderId);
			json.put("odrmoney",df.format(order.getOdrmst_acturepaymoney()));
			json.put("odrpaymethod",order.getOdrmst_paymethod());
			
			int p=0;
			switch (order.getOdrmst_payid().intValue()){
			case 4:
			case 6:
			case 25:
			case 26:
			case 27:
			case 34:
			case 35:
			case 36:
			case 37:
			case 38:
			case 39:
			case 40:
			case 41:
			case 42:
			case 43:
				p=2;
				break;
			case 20:
				p=4;
				break;
			case 21:
				p=3;
				break;
			case 14:
			case 31:
				p=5;
				break;
			case 33:
				p=1;
			case 60:
				p=6;
				break;
		}
			System.out.println(p+"============odrpayid");
			json.put("odrpayid",p);
			json.put("odrstatus",order.getOdrmst_orderstatus());
			String retUrl="";
			 String strLt_user_id = lUser.getId();
			 double fltTktmstTktValue=order.getOdrmst_tktvalue();
				 String strMbrmstTemp = lUser.getMbrmst_temp();
				 String strWapLtinfo = Tools.getCookie(request,"WAPLTINFO");
				 String strLianmeng = Tools.getCookie(request,"d1.com.cn.peoplercm");
				 String strSubad = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");
				 String strWapEQIFA = Tools.getCookie(request,"WapEQIFA");

				 
					double fdtltktra=1;//计算用券比例
					 if (fltTktmstTktValue>0)
					 {
					 	fdtltktra=getTktRa(fltTktmstTktValue,orderId);
					 }
					
					 String strCardMemo = order.getOdrmst_cardmemo();
					 	long validflag=1;
					 	boolean existstkt=TicketFlagHelper.existsTicketFlag(strCardMemo,new Long(validflag));
					 	//需要查询数据库
					 	if(existstkt){
					 		strWapLtinfo = "";strLianmeng = "";
					 	}	
					 	String strSrcurl = Tools.getCookie(request,"d1.com.cn.srcurl");
						 if(!Tools.isNull(strSrcurl)){
						 	strSrcurl = URLDecoder.decode(strSrcurl,"UTF-8");
						 	OrderHelper.updateOdrmstCacheSrcurl(orderId,strSrcurl);
						 }
						 if((!Tools.isNull(strLianmeng) && strLianmeng.startsWith("lianmeng")) || !Tools.isNull(strSubad) )//站内联盟
						 { strSubad="phone-"+strSubad;
							 if (!Tools.isNull(strLianmeng)){
							 UPLianmeng(order,strLianmeng,strSubad);
							 }
							 else{
								 UPSubAd(order,strSubad);
							 }
						
							 strWapLtinfo = "";
							 strWapEQIFA="";

						 }else{
								strSubad="phone";
								UPSubAd(order,strSubad);
							}
						 System.out.println(strWapLtinfo+"============WAPLTINFO");
			 if(!Tools.isNull(strWapLtinfo)){
				
			    retUrl=postLKT(order,orderId,fdtltktra,strWapLtinfo,strLt_user_id);
			 }else if(!Tools.isNull(strWapEQIFA)){
				 retUrl=postEqifa(order,orderId,fdtltktra,strWapEQIFA);
			 }
			 json.put("returl",retUrl);

		}else{
		 json.put("status", "0");
		}
	}
	
}
out.print(json);
%>