<%@ page contentType="text/html; charset=UTF-8" import="com.d1.helper.JsHelper"%>
<%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<%String userid="";
if(session.getAttribute("admin_mng")!=null){
	   userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "pop_order");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<%

%>

<%!
	private Date getjsDate(Date e) {
		int n = 0;
		Date s = new Date();
		while(n++<=7) {
			s = new Date(e.getTime() - n * 24 * 60 * 60 * 1000);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(s);
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			if(dayOfWeek == 6) {
				break;
			}
		}
		
		return s;
	}
public static int getjsmstmaxid(String shopcode,String fmtday){
	//加入查询条件
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	
	clist.add(Restrictions.eq("jsmst_shpcode", shopcode));
	clist.add(Restrictions.like("jsmst_code", fmtday+'%'));
	
	ArrayList<Jsmst> resList = new ArrayList<Jsmst>();
	

	return  Tools.getManager(Jsmst.class).getLength(clist);

}
%>
<%
	SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat fmt1=new SimpleDateFormat("yyyy-MM-dd");
	
	String createdate_s = request.getParameter("createdate_s")==null||request.getParameter("createdate_s").equals("")?fmt1.format(new Date()):request.getParameter("createdate_s");
	String createdate_e = request.getParameter("createdate_e")==null||request.getParameter("createdate_s").equals("")?fmt1.format(getjsDate(new Date())):request.getParameter("createdate_e");
	String jsmst_shpcode = request.getParameter("jsmst_shpcode")==null?"":request.getParameter("jsmst_shpcode");//为空就是计算所有商户
	String jsmst_sumprice = request.getParameter("jsmst_shpcode")==null?"":request.getParameter("jsmst_sumprice");

//生成结算单
	
	Long shpmst_sendtype = new Long(2);//POP商户
	
	if("".equals(createdate_e)||"".equals(createdate_s)) {
		out.print("{\"code\":1,message:\"时间不能为空！\"}");
		return;
	}
	if(Tools.isNull(jsmst_shpcode)) {
		out.print("{\"code\":1,message:\"商户号不能为空！\"}");
		return;
	}
	String fmtday=fmt.format(new Date());
	String shipdate_s=createdate_s;
	 String shipdate_e=createdate_e;
	 String shpmst_shopcode=jsmst_shpcode;
     int maxid=getjsmstmaxid(shpmst_shopcode,fmtday);
     if(maxid>0) maxid=maxid+1;

    JsHelper.createJsOdrShop(fmtday+maxid,createdate_s, createdate_e, jsmst_shpcode, jsmst_sumprice,userid);
	
	response.sendRedirect(request.getParameter("href"));
%>