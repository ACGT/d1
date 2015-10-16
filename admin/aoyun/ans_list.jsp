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
<%

String ggURL = Tools.addOrUpdateParameter(request,null,null);
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
String qusid=request.getParameter("qusid");
if(qusid!=null&&qusid.length()>0)   
{
	String ans=request.getParameter("ans");
	String mbrid=request.getParameter("mbrid");
	if(qusid!=null&&qusid.length()==0)
  	{
  		Tools.outJs(out, "问题ID不能为空！", "back");
  	    return;
  	}
	ArrayList<AYAnswer> list=new ArrayList<AYAnswer>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	if(qusid!=null&&qusid.length()>0)
	{
	  clist.add(Restrictions.eq("answer_qid",new Long(qusid)));
	}
	if(ans!=null&&ans.length()>0)
	{
		ans=java.net.URLDecoder.decode(ans);
	  clist.add(Restrictions.like("answer_content",ans));
	}
	if(mbrid!=null&&mbrid.length()>0)
	{
	  clist.add(Restrictions.eq("answer_mbrid",mbrid));
	}
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> blist=Tools.getManager(AYAnswer.class).getList(clist, olist, 0, 10000);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((AYAnswer)b);
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
       
       <tr style="background:#f4f4f4; color:#333"><td width="80">编号</td><td width="180">问题</td><td width="80">答案</td><td width="100">会员名</td><td width="200">创建时间</td></tr>
  	 <% 
  	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
  	  {
	    	  AYAnswer fl=list.get(i);
  		  if(fl!=null)
  		  {
  			AYQuestion qus=(AYQuestion)Tools.getManager(AYQuestion.class).get(fl.getAnswer_qid()+"");
  		  %>
  			<tr style="border-bottom:#f4f4f4 solid 1px ;"><td><%= fl.getId() %></td>
  			<td><%=qus.getQuestionTitle()+"("+qus.getQuestionAn() +")" %></td>
  			<td><%=fl.getAnswer_content() %></td>
  			<td><%=fl.getAnswer_uid() %></td>
  			<td><%=fl.getAnswer_createdate() %></td>
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
 