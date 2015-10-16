<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%@include file="/html/getComment.jsp" %>
<%
String gdsarrstr = request.getParameter("id");
JSONObject json = new JSONObject();
if (Tools.isNull(gdsarrstr)){
	json.put("status", "0");
	out.print(json);
	return;
}

ArrayList<Comment> clist=getCommentList(gdsarrstr);
if(clist==null&&clist.size()<=0){

	json.put("status", "0");
	out.print(json);
	return;
}

JSONArray jsonarr=new JSONArray();

	String pg=request.getParameter("pg"),psize=request.getParameter("psize");
	int sgcount=clist.size();
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
    json.put("gdsid",gdsarrstr);
   
    
    int count=0;
	   
	   SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
	   
	  
	 for(int t=pbegin; t<sgcount&&t<pend;t++ )
     {
		 Comment comment = clist.get(t);
		 String hfusername=comment.getGdscom_uid();
		 if(!Tools.isNull(comment.getGdscom_uid())){
				hfusername="***"+StringUtils.getCnSubstring(hfusername,0,10);
				hfusername=hfusername.trim().replaceAll("调单", "ddan");
			}
		  JSONObject jsonitem = new JSONObject();
		                
		        		jsonitem.put("cid",comment.getId());
		        		jsonitem.put("crname",hfusername);
		        		jsonitem.put("ctxt",comment.getGdscom_content());
		        		jsonitem.put("clevel",comment.getGdscom_level());
		        		jsonitem.put("stime",df.format(comment.getGdscom_createdate()));
		        		jsonarr.add(jsonitem);
     }
	 json.put("coms", jsonarr);

out.print(json);

%>