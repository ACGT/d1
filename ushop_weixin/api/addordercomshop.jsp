<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,
net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "-1");
	out.print(json);
	return;
}
if(!Tools.isNull(request.getParameter("odrid"))){
	String orderid=request.getParameter("odrid").trim();
	if(orderid.length()!=12){
		json.put("status", "0");
		out.print(json);
		return;
	}
	//判断订单是否属于改用户
	OrderBase base=OrderHelper.getById(orderid);
	 if(base==null){
		 json.put("status", "0");
			out.print(json);
			return;
	 }
	 
	  if(!lUser.getId().equals(String.valueOf(base.getOdrmst_mbrid()))){
		  json.put("status", "-2");
			out.print(json);
			return;
	 }
		 int comvalue= base.getOdrmst_comvalue().intValue();
		
		
		 if(base.getOdrmst_orderstatus().longValue()>=5&&base.getOdrmst_orderstatus().longValue()!=31
				 &&comvalue==0){
		 base.setOdrmst_comvalue(new Double(1));
		 Tools.getManager(base.getClass()).clearListCache(base);
		 if(!Tools.getManager(base.getClass()).update(base, true)){
			 json.put("status", "-3");
				out.print(json);
				return;
		 }else{
			 boolean palist=UserHelper.isPingAnUser(request,response);
			 //buygoods:buygoods,speed:speed,service:service,msn:msn
			 String speed= request.getParameter("speed");
			 String buygoods= request.getParameter("buygoods");
			 String service= request.getParameter("service");
			 String msn= request.getParameter("msn");
			 String other= request.getParameter("txtother");
			 String sessionid=Tools.getDBDate();
			 try{
				 D1Comment d1=new D1Comment();
				 d1.setSessionid(sessionid);
				 d1.setCommenttime(new Date());
				 d1.setGdscom_base(buygoods);
				 d1.setGdscom_mbrid(new Long(lUser.getId()));
				 d1.setGdscom_msn(msn);
				 d1.setGdscom_odrid(orderid);
				 d1.setGdscom_other(other);
				 d1.setGdscom_service(service);
				 d1.setGdscom_speed(speed);
				 d1.setGdscom_uid(lUser.getMbrmst_uid());
				 d1=(D1Comment)Tools.getManager(D1Comment.class).create(d1);
				 

			 }catch(Exception e){
				 e.printStackTrace();
			 }
			 if(!palist){
 				//积分操作
 				UsrPoint usrpoint = new UsrPoint();
 		     	usrpoint.setUsrpoint_odrid(base.getId());
 		     	usrpoint.setUsrpoint_mbrid(new Long(lUser.getId()));
 		     	usrpoint.setUsrpoint_score(new Long((base.getOdrmst_acturepaymoney().longValue()+base.getOdrmst_prepayvalue().longValue())));
 		     	usrpoint.setUsrpoint_usescore(new Long(base.getOdrmst_acturepaymoney().longValue()+base.getOdrmst_prepayvalue().longValue()));
 		     	usrpoint.setUsrpoint_type(new Long(1));
 		     	usrpoint.setUsrpoint_shopcode(base.getOdrmst_sndshopcode());
 		     	usrpoint.setUsrpoint_createdate(new Date());
 		     	UsrPointHelper.insertUsrPoint(usrpoint);
				

	 String coms=request.getParameter("coms");
	 JSONObject  jsoncoms = JSONObject.fromObject(coms); 
	 
	 JSONArray jsonitems = jsoncoms.getJSONArray("coms");  
	 int comlen=jsonitems.size();
	 String oitemid="";	
	 String comstar="";	
	 String commemo="";
	 int nocontentcount=0;
	 for(int i=0;i<comlen;i++){
		 JSONObject tempJson = JSONObject.fromObject(jsonitems.get(i));
	  
	  oitemid=tempJson.getString("comoitemid");	
	  comstar=tempJson.getString("comstar");	
	  commemo=tempJson.getString("commemo");
	  
	  OrderItemBase oitem=(OrderItemBase)Tools.getManager(OrderItemMain.class).get(oitemid);
		if(oitem==null){
		   oitem=(OrderItemBase)Tools.getManager(OrderItemRecent.class).get(oitemid);
	   }
    
	    String content="好评！";
		int comstatus=1;
		int checkstatus=0;
		String op="";
		 if(Tools.isNull(commemo)){
			
			 nocontentcount++;
			 checkstatus=1;
			 comstatus=0;
			 op="0";
			 if(comstar.equals("1")){
				 commemo="不喜欢"; 
			 }else if(comstar.equals("2")){
				 commemo="一般"; 
			 }else if(comstar.equals("3")){
				 commemo="喜欢"; 
			 }else if(comstar.equals("4")){
				 commemo="很喜欢"; 
			 }else if(comstar.equals("5")){
				 commemo="非常喜欢"; 
			 }
		 }
	  
	  
		Comment comment=new Comment();
		// comment.setSessionid(sessionid);
		 comment.setGdscom_odrid(orderid);
		 comment.setGdscom_mbrid(new Long(lUser.getId()));
		 comment.setGdscom_uid(lUser.getMbrmst_uid());
		 comment.setGdscom_gdsid(oitem.getOdrdtl_gdsid());
		 comment.setGdscom_gdsname(oitem.getOdrdtl_gdsname());
		 comment.setGdscom_content(commemo);
		 comment.setGdscom_createdate(new Date());
		 comment.setGdscom_status(new Long(comstatus));
		 comment.setGdscom_level(new Long(comstar));
		 comment.setGdscom_operator(op);
		 comment.setGdscom_replydate(null);
		 comment.setGdscom_checkStatue(new Long(checkstatus));
		 comment.setGdscom_replyContent("");
		 comment.setGdscom_replyStatus(new Long(0));
		 comment.setGdscom_pic1("");
		 comment.setGdscom_pic2("");
		 comment.setGdscom_pic3("");
		 comment.setGdscom_sku1(oitem.getOdrdtl_sku1());
		 comment=(Comment)Tools.getManager(Comment.class).create(comment);
		 
	 }
	 if(Tools.isNull(Tools.getCookie(request,"PINGAN"))){
		 int plscore=5*nocontentcount+10*(comlen-nocontentcount);
		  //积分操作
		        UsrPoint comusrpoint = new UsrPoint();
		        comusrpoint.setUsrpoint_odrid(orderid);
		        comusrpoint.setUsrpoint_mbrid(new Long(lUser.getId()));
		        comusrpoint.setUsrpoint_score(new Long(plscore));
		        comusrpoint.setUsrpoint_usescore(new Long(plscore));
		        comusrpoint.setUsrpoint_type(new Long(2));
		        usrpoint.setUsrpoint_shopcode(base.getOdrmst_sndshopcode());
		        comusrpoint.setUsrpoint_createdate(new Date());
		     	UsrPointHelper.insertUsrPoint(comusrpoint);
		  
			 
	    }
	 json.put("status", "1");
	 json.put("message", "确认收货，发表评论成功！");
		out.print(json);
		return;
	 }
  }
}
}
%>