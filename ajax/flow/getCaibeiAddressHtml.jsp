<%@ page contentType="text/html; charset=UTF-8" import="javax.xml.parsers.*,org.w3c.dom.*,java.net.*,java.security.*,java.util.*" %><%@include file="/inc/header.jsp" %><%@include file="../islogin.jsp" %><%!
	 static ArrayList<UserAddress> getUserCaibeiAddressList(String userId){
		
		if(userId==null||!StringUtils.isDigits(userId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
		clist.add(Restrictions.eq("mbrcst_countryid", new Long(100)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("mbrcst_memo"));
		
		List<BaseEntity> list = Tools.getManager(UserAddress.class).getList(clist, olist, 0, 100);
		if(list==null||list.size()==0)return null ;
		
		ArrayList<UserAddress> rlist = new ArrayList<UserAddress>();
		for(BaseEntity be:list){
			rlist.add((UserAddress)be);
		}
		return rlist ;
	}%>
<%
String m_iLastMbrcstID = "0";//上一次使用的地址
		StringBuilder sb = new StringBuilder();
		    	if(lUser.getMbrmst_uid().contains("caibei") && lUser.getMbrmst_name().trim().equals("QQ彩贝")){
		    		ArrayList<UserAddress> addresslist= getUserCaibeiAddressList(lUser.getId());
		    		if(addresslist!=null && addresslist.size()>0){
		    			sb.append("<div id=\"tblTop5Mbrcst2\" class=\"mod_cb_addr\"><dl><dt>您是QQ用户，以下是您在QQ彩贝中保存的收货地址：</dt>");
		    			for(UserAddress address:addresslist){
		    				sb.append("<dd><input type=\"radio\" name=\"rdoMbrcstList\" value=\"");
	    		    		sb.append(address.getId());
	    		    		sb.append("\"");
	    		    		if(address.getMbrcst_rtelephoneext().trim().equals("1")){
	    		    			m_iLastMbrcstID=address.getId();
	    		    			sb.append(" checked");
	    		    		} 
	    		    		sb.append("><b>收货人：</b><span class=\"name\">");
	    		    		sb.append(address.getMbrcst_name());
	    		    		sb.append("</span>&nbsp;&nbsp;&nbsp;&nbsp;<b>地址：</b><span class=\"address\">");
	    		    		sb.append(address.getMbrcst_raddress());
	    		    		sb.append("</span>&nbsp;&nbsp;&nbsp;&nbsp;<b>手机：</b><span class=\"mobile\">");
	    		    		sb.append(address.getMbrcst_rphone() );
	    		    		sb.append("</span>&nbsp;&nbsp;&nbsp;&nbsp;<b>电话：</b><span class=\"caibeitel\">");
	    		    		sb.append(address.getMbrcst_rtelephone());
	    		    		sb.append(" </span></dd>");
		    			}
		    			if(m_iLastMbrcstID.equals("0")){
		    				m_iLastMbrcstID=addresslist.get(0).getId();
		    			}
		    			sb.append(" </dl></div>");
		    		}
			    			
		    		  }
		    	Map<String,Object> map = new HashMap<String,Object>();
		    	map.put("success",new Boolean(true));
		    	map.put("message",sb.toString());
		    	map.put("LastAddressID",m_iLastMbrcstID);

		    	out.print(JSONObject.fromObject(map));
		    	return;

	//}



%>