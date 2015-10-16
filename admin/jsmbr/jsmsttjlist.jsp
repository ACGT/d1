<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp"%>
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
<%!
/**
 * 对账单--odrmst_cache
 */
/**
 * 对账单--odrmst
 */
	public static ArrayList<Jsmst> getJsmstList(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Jsmst> list=new ArrayList<Jsmst>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String jsmst_createdate_s = request.getParameter("jsmst_createdate_s")==null?"":request.getParameter("jsmst_createdate_s");
		String jsmst_createdate_e = request.getParameter("jsmst_createdate_e")==null?"":request.getParameter("jsmst_createdate_e");
		String jsmst_auditdate_s = request.getParameter("jsmst_auditdate_s")==null?"":request.getParameter("jsmst_auditdate_s");
		String jsmst_auditdate_e = request.getParameter("jsmst_auditdate_e")==null?"":request.getParameter("jsmst_auditdate_e");
		String jsmst_jsdate_s = request.getParameter("jsmst_jsdate_s")==null?"":request.getParameter("jsmst_jsdate_s");
		String jsmst_jsdate_e = request.getParameter("jsmst_jsdate_e")==null?"":request.getParameter("jsmst_jsdate_e");
		String jsmst_shpcode = request.getParameter("jsmst_shpcode")==null?"":request.getParameter("jsmst_shpcode");
		String jsmst_status = "0";
		String jsmst_sumprice = request.getParameter("jsmst_sumprice")==null?"":request.getParameter("jsmst_sumprice");
		
		try {
			if(jsmst_shpcode!= null && !"".equals(jsmst_shpcode)) {
				listRes.add(Restrictions.eq("jsmst_shpcode", jsmst_shpcode));
			}
		
			if(jsmst_status!= null && !"".equals(jsmst_status)) {
				listRes.add(Restrictions.eq("jsmst_status", new Long(jsmst_status)));
			}
			
			if(jsmst_sumprice!= null && !"".equals(jsmst_sumprice)) {
				listRes.add(Restrictions.ge("jsmst_sumprice", new Double(jsmst_sumprice)));
			}
			
			if(jsmst_createdate_s!= null && !"".equals(jsmst_createdate_s)) {
				listRes.add(Restrictions.ge("jsmst_createdate", format.parse(jsmst_createdate_s+" 00:00:00")));
			}
		
			if(jsmst_createdate_e!= null && !"".equals(jsmst_createdate_e)) {
				listRes.add(Restrictions.le("jsmst_createdate", format.parse(jsmst_createdate_e+" 23:59:59")));
			}
		
			if(jsmst_auditdate_s!= null && !"".equals(jsmst_auditdate_s)) {
				listRes.add(Restrictions.ge("jsmst_auditdate", format.parse(jsmst_auditdate_s+" 00:00:00")));
			}
			
			if(jsmst_auditdate_e!= null && !"".equals(jsmst_auditdate_e)) {
				listRes.add(Restrictions.le("jsmst_auditdate", format.parse(jsmst_auditdate_e+" 23:59:59")));
			}
			
			if(jsmst_jsdate_s!= null && !"".equals(jsmst_jsdate_s)) {
				listRes.add(Restrictions.ge("jsmst_jsdate", format.parse(jsmst_jsdate_s+" 00:00:00")));
			}
			
			if(jsmst_jsdate_e!= null && !"".equals(jsmst_jsdate_e)) {
				listRes.add(Restrictions.le("jsmst_jsdate", format.parse(jsmst_jsdate_e+" 23:59:59")));
			}
		}catch(Exception e) {
			
		}
		
	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.desc("jsmst_auditdate"));
		List<BaseEntity> list2 = Tools.getManager(Jsmst.class).getList(listRes, olist, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((Jsmst)be);
		}
		return list;
	}	
	
	private double round(double number,int index){
	    double result = 0;
	    double temp = Math.pow(10, index);
	    result = Math.round(number*temp)/temp;
	    return result;
	}

	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<link href="res/odrlist.css" rel="stylesheet" type="text/css"  />
<title>结算单</title>
</head>
<script type="text/javascript">

</script>
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

	private String getStatus(long status) {
		String strStatus = "";
		if(status == 1) {
			strStatus = "提交完成";
		}else if(status == 2) {
			strStatus = "审核完成";
		}else if(status == 3) {
			strStatus = "结算完成";
		}else if(status == 0) {
			strStatus = "待处理";
		}
		
		return strStatus;
	}
	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
%>
<body style="overflow-x: hidden">
	<div id="jssj">
	<form id="search1" name="search1" method="post" action="jsmbrCreate.jsp" >
		<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td colspan="9" height="40" align="center"><h3><b>生成数据</b></h3></td>
			</tr>
			<tr>
				<td>开始时间:</td>
				<td><input type="text" name="createdate_e" value="" onclick="WdatePicker();"/></td>
				<td>结束时间:</td>
				<td><input type="text" name="createdate_s" value="<%=fmt.format(getjsDate(new Date()))%>" onclick="WdatePicker();"/></td>
				<td>结算商户:</td>
				<td><input type="text" name="jsmst_shpcode" value="" size="4"/></td>
				<td>结算金额:</td>
				<td><input type="text" name="jsmst_sumprice" value="0" size="4"/></td>
				<td>
					<%
						String   url=request.getScheme()+"://";   
						 url+=request.getHeader("host");   
						 url+=request.getRequestURI();   
						 if(request.getQueryString()!=null)   
						     url+="?"+request.getQueryString();   
						   
						 out.println("<input type='hidden' name='href' id='href' value='"+url+"'/>");
					%>
					<input type="submit" name="submit" value="查询"/>
				</td>
			</tr>
	</table>
	</form>
	</div>
<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr>
    <td class="menuodrtd"  colspan="7">订单列表</td>
							
  </tr>
      <tr class="odrt">
        <td height="40">结算单号</td>
        <td >结算周期</td>
        <td >商户编号/商户名称</td>
        <td >结算单金额</td>
        <td >结算提交日期</td>
        <td >商户审核日期</td>
        <td >实际结算日期</td>
        <td >结算状态</td>
        <td >凭证</td>
        <td >操作</td>
      </tr>
<%
	String ggURL = Tools.addOrUpdateParameter(request,null,null);
	ArrayList<Jsmst> list=new ArrayList<Jsmst>();
	list = getJsmstList(request,response);
	
    int pageno1=1;
    
    if(ggURL != null) 
    	   {
    	     ggURL.replaceAll("pageno1=[0-9]*","");
    	   }
    //翻页
      int totalLength1 = (list != null ?list.size() : 0);
      int PAGE_SIZE = 30;
      int currentPage1 = 1 ;
      String pg1 ="1";
      if(request.getParameter("pageno1")!=null)
      {
      	pg1= request.getParameter("pageno1");
      }
    
      if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
      PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
      int end1 = pBean1.getStart()+PAGE_SIZE;
      if(end1 > totalLength1) end1 = totalLength1;
      
    	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
    	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
    if(list!=null&&list.size()>0)
    {
   	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
   	  {
	    	  Jsmst jsmst=list.get(i);
%>
	<tr>
		<td height="40">
			<%
				if(jsmst.getJsmst_status().longValue() != 0) {
					out.print("<a href='jsdtllist.jsp?jsdtl_jsmstcode="+jsmst.getJsmst_code()+"&jsmst_shpcode="+jsmst.getJsmst_shpcode()+"&jsmst_shpname="+jsmst.getJsmst_shpname()+"&jsmst_status="+jsmst.getJsmst_status()+"'>"+jsmst.getJsmst_code()+"</a>");
				}
			%>
			</td>
		<td><%=jsmst.getJsmst_period()==null?"":jsmst.getJsmst_period() %></td>
		<td><%=jsmst.getJsmst_shpcode()+"<br>"+jsmst.getJsmst_shpname() %></td>
		<td><%=round(jsmst.getJsmst_sumprice(),2) %></td>
		<td><%=jsmst.getJsmst_createdate()==null?"没有提交":fmt.format(jsmst.getJsmst_createdate()) %></td>
		<td><%=jsmst.getJsmst_auditdate()==null?"没有审核":fmt.format(jsmst.getJsmst_auditdate()) %></td>
		<td><%=jsmst.getJsmst_jsdate()==null?"没有结算":fmt.format(jsmst.getJsmst_jsdate()) %></td>
		<td><%=getStatus(jsmst.getJsmst_status().longValue())%></td>
		<td>
			<%
				if(jsmst.getJsmst_jspicpath() != null && !jsmst.getJsmst_jspicpath().equals("")) {
			%>
				<a href="<%=jsmst.getJsmst_jspicpath() %>" target="_blank">凭证</a>
			<%
				}
			%>
		</td>
		<td align="center">
			<%
				out.print("<a href='jsdtllist.jsp?jsdtl_jsmstcode="+jsmst.getJsmst_code()+"&jsmst_shpcode="+jsmst.getJsmst_shpcode()+"&jsmst_shpname="+jsmst.getJsmst_shpname()+"&jsmst_status="+jsmst.getJsmst_status()+"&href=jsmsttjlist.jsp?'>详情</a><br/>");
			%>
		</td>
	</tr>
<%
   	  }
	      
	           if(pBean1.getTotalPages()>=1){
	           %>
	           <tr>
	   <td colspan="8" height="45">
	           <span class="GPager" style="margin:0px auto; overflow:hidden;">
	           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
	           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
	           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
	           		if(i==currentPage1){
	           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
	           		}else{
	           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
	           		}
	           	}%>
	           	<%if(pBean1.hasNextPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
	           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
	           </span> </td>
  </tr><%}}%>	
      <tr>
 </tr>
</table>
</body>
</html>


