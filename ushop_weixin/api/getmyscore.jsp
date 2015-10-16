<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%><%!
	public String getStatus(long status) {
		if(status == 1)
			return "【获得积分】购物积分";
		else if(status == 2)
			return "【获得积分】评价积分";
		else if(status == 3)
			return "【获得积分】微博分享积分";
		else if(status == 0)
			return "【获得积分】赠送积分";
		else if(status == -1)
			return "【消费积分】积分购物";
		else if(status == -2)
			return "【消费积分】积分换券";
		else if(status == 4)
			return "【获得积分】生日赠送积分";
		else if(status == 5)
			return "【获得积分】祝福积分";
		else if(status == 6)
			return "【获得积分】晒单积分";
		else if(status == 7)
			return "【获得积分】白金积分";
		else
			return "【获得积分】购物积分";
	}
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
	out.print(json);
	return;
}
List<UsrPoint>  lists = UsrPointHelper.getUserScoreInfoshop(lUser.getId(),"14031201");
if(lists==null&&lists.size()<=0){

	json.put("status", "0");
	out.print(json);
	return;
}

JSONArray jsonarr=new JSONArray();

	String pg=request.getParameter("pg"),psize=request.getParameter("psize");
	int sgcount=lists.size();
	if(Tools.isNull(pg))pg="1";
	if(Tools.isNull(psize))psize="15";
	int ipg=Tools.parseInt(pg);
	int ipsize=Tools.parseInt(psize);
	PageBean pBean1 = new PageBean(sgcount,ipsize,ipg);
	if(ipg>pBean1.getCurrentPage()){
		json.put("status", "0");
		out.print(json);
		return;
	}
	json.put("status", "1");
	int pbegin = (pBean1.getCurrentPage()-1)*ipsize;
    int pend = pbegin + ipsize;
    json.put("page_total", sgcount);
    
   
    
    int count=0;
	   
	   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
	   
	  
	 for(int t=pbegin; t<sgcount&&t<pend;t++ )
     {
		 UsrPoint score = lists.get(t);
		  
		  JSONObject jsonitem = new JSONObject();
			 
		        		jsonitem.put("sid",score.getId());
		        		jsonitem.put("sstatus",getStatus(score.getUsrpoint_type()));
		        		jsonitem.put("stxt",!Tools.isNull(score.getUsrpoint_odrid())?"订单号:"+score.getUsrpoint_odrid():"");
		        		jsonitem.put("sscore",score.getUsrpoint_score());
		        		jsonitem.put("stime",DateFormat.format(score.getUsrpoint_createdate()));
		        		jsonarr.add(jsonitem);
     }
	 json.put("allscore", (int)(UsrPointHelper.getRealScore(lUser.getId())+0.5));
	 json.put("scores", jsonarr);

out.print(json);

%>
