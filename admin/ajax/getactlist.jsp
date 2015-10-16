<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
	public static ArrayList<D1ActTb> getacttbList(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<D1ActTb> list=new ArrayList<D1ActTb>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		  String req_name= request.getParameter("req_name");
		   String req_stime= request.getParameter("req_stime");
		   String req_etime= request.getParameter("req_etime");
		   String req_type= request.getParameter("req_type");
		   String req_status= request.getParameter("req_status");
		   if(!Tools.isNull(req_name)){
			   listRes.add(Restrictions.like("d1acttb_name", "%"+req_name+"%"));
		   }
		   if(!Tools.isNull(req_type)){
			   listRes.add(Restrictions.eq("d1acttb_acttype", new Long(req_type)));
		   }
	
		   if(!Tools.isNull(req_status)){		
				   listRes.add(Restrictions.le("d1acttb_status", new Long(req_status)));

		   }

		   if((!Tools.isNull(req_stime)||!Tools.isNull(req_etime))){
				   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date s=null;
	         Date e=null;
			   if(req_stime.length()>0&&req_etime.length()<=0){
			   	try{
			   		 s=format.parse(req_stime+" 00:00:00");
			   	  
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(req_stime.length()<=0&&req_etime.length()>0){
			   	try{
			   		
			   	     e=format.parse(req_etime+" 00:00:00");
			   	}catch(Exception ex){
			   		
			   	}
			   }
			   else if(req_stime.length()>0&&req_etime.length()>0){
			   	try{		
			   	     s=format.parse(req_stime+" 00:00:00");
			   	     e=format.parse(req_etime+" 00:00:00");
			   	}catch(Exception ex){
			   		System.out.print(ex);
			   	}
			   }
			   if(!Tools.isNull(req_stime)){
				    listRes.add(Restrictions.ge("d1acttb_starttime", s));
			   }
			   if(!Tools.isNull(req_etime)){
					    listRes.add(Restrictions.le("d1acttb_endtime", e));
				   }
	
		   }

	
			 listRes.add(Restrictions.eq("d1acttb_shopcode", shopCode));

			  			

	    List<Order> olist=new ArrayList<Order>();
	    olist.add(Order.desc("d1acttb_createdate"));
		List<BaseEntity> list2 = Tools.getManager(D1ActTb.class).getList(listRes, olist, 0, 500);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((D1ActTb)be);
		}
		return list;
	}

	%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="lin">
      <tr class="odrt">
        <td width="203" height="40">活动名称</td>
        <td width="158">活动时间区间</td>
        <td width="108">活动阶梯</td>
        <td width="95">活动类型</td>
        <td width="130">审核状态</td>
        <td width="112">处理</td>
      </tr>
      <tr>
        <td colspan="6">
 <%
String shopCode=session.getAttribute("shopcodelog").toString();
   SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   String[] arrstatus = new String[]{"待审核","已审核","审核未通过"};  
   String[] arracttype = new String[]{"满减活动","推荐位满减","品牌满减"};  
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
      ArrayList<D1ActTb> list=new ArrayList<D1ActTb>();
      String act=request.getParameter("act");

      list=getacttbList(request,response,shopCode);

      //分页
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
     	 String	strname ="";
     	long acttype=0;
     	 long actstatus=0;
     	 int j=0;
     	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
     	  {
 	    	 D1ActTb acttb=list.get(i);
 	    	actstatus=acttb.getD1acttb_status().longValue();
 	    	acttype=acttb.getD1acttb_acttype().longValue();	    	
 	        strname=acttb.getD1acttb_name();


 	    	if(j!=0){
 	    	out.print(" </table>");
 	    	}
      %>      
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linon">

         <tr>
   
           <td  class="spantxt" width="203" ><span class="spantxt"><%=strname %></span></td>
           <td width="157" ><%=format.format(acttb.getD1acttb_starttime()) %><br>
			<%=format.format(acttb.getD1acttb_endtime()) %>
		</td>
           <td height="40"  width="107" class="spantxt  pdl8">
         第一阶满：<%=acttb.getD1acttb_snum1() %>减<%=acttb.getD1acttb_enum1() %><br>
    <%if(acttb.getD1acttb_snum2().longValue()>0){ %>
         第二阶满：<%=acttb.getD1acttb_snum2() %>减<%=acttb.getD1acttb_enum2() %>
         <%}
    if(acttb.getD1acttb_snum3().longValue()>0){ %>
         第三阶满：<%=acttb.getD1acttb_snum3() %>减<%=acttb.getD1acttb_enum3() %>
         <%} %>
         </td>
           <td align="center" width="96"><%=arracttype[acttb.getD1acttb_acttype().intValue()] %></td>
           <td align="center" width="129"><%=arrstatus[acttb.getD1acttb_status().intValue()] %></td>
           <td align="center" width="114">
            <a href="/admin/SHManage/shopact/acttbup.jsp?id=<%=acttb.getId()%>" >编辑</a>
         </td>
         </tr>
 

	 <%j=j++;
	   }
      }
%>
  </table>			</td>
        </tr>
           	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="6" height="45">
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
					           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>					           </span> </td>
				     </tr><%}%>	
        
    </table>