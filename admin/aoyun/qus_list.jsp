<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<style type="text/css">
<!--
body,td,th {
	font-size: 13px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->
</style>
<%!
public static boolean isValidDate(String s)
{
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    try
    {
         dateFormat.parse(s);
         return true;
     }
    catch (Exception e)
    {
        // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
        return false;
    }
}

%>
<%

String ggURL = Tools.addOrUpdateParameter(request,null,null);
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
String title=request.getParameter("title");
String qviewtime=request.getParameter("qtime");
String flag=request.getParameter("flag");
if(title!=null||qviewtime!=null||flag!=null)   
{
	  
	if(isValidDate(qviewtime))
  	{
  		Tools.outJs(out, "时间格式 不正确！", "back");
  	    return;
  	}
  
  	Date qtime=null;
  	if (!Tools.isNull(qviewtime)){
  	try{
  		qtime=fmt2.parse(qviewtime);
  		 }
  	catch(Exception ex){
  		ex.printStackTrace();
  	}
  	}
	ArrayList<AYQuestion> list=new ArrayList<AYQuestion>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	if(title!=null&&title.length()>0)
	{
	  clist.add(Restrictions.like("questionTitle",title));
	}
	if(qviewtime!=null&&qviewtime.length()>0)
	{
	  clist.add(Restrictions.eq("qviewTime",qtime));
	}
	if(flag!=null&&flag.length()>0)
	{
	  clist.add(Restrictions.eq("questionFlag",new Long(flag)));
	}
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> blist=Tools.getManager(AYQuestion.class).getList(clist, olist, 0, 100);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((AYQuestion)b);
			}
		}
	}
		
    //分页
    int pageno1=1;
    
    if(ggURL != null) 
    	   {
    	     ggURL.replaceAll("pageno1=[0-9]*","");
    	   }
    //翻页
      int totalLength1 = (list != null ?list.size() : 0);
      int PAGE_SIZE = 15 ;
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
    {%>
    <table style="margin:0px auto;text-align:center; border:solid 1px #f4f4f4;"  border="0" cellspcing="0" cellpadding="0">
       
       <tr style="background:#f4f4f4; color:#333"><td width="80">编号</td><td width="180">问题</td><td width="80">问题</td><td width="100">显示时间</td><td width="200">是否有效</td><td width="120">显示时间有领券结束时间</td><td width="120">操作</td></tr>
  	 <% 
  	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
  	  {
	    	  AYQuestion fl=list.get(i);
  		  if(fl!=null)
  		  {%>
  			<tr style="border-bottom:#f4f4f4 solid 1px ;"><td><%= fl.getId() %></td>
  			<td><a href="qus_modi.jsp?id=<%= fl.getId()%>" target="rbottom"><%=fl.getQuestionTitle()%></a></td>
  			<td><%=fl.getQuestionAn() %></td>
  			<td><%=fmt2.format(fl.getQviewTime())  %></td>
  			<td><%if(fl.getQuestionFlag()==1){
  				out.print("有效");
  			}else{
  				out.print("无效");
  			}
  			%></td>
  			<td><%=fl.getQuestiontktend() %></td>
  			<td><a href="qus_modi.jsp?id=<%=fl.getId() %>" target="rbottom">修改</a>
  			</td>
  			</tr>  
  		  <%}
  	  }%>
  	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="6" height="45">
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span> </td>
				     </tr><%}%>	
   </table>	

<%	
}
}
%>
 