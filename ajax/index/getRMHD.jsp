<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
    int w=980;
	if(request.getParameter("w")!=null&&request.getParameter("w").toString().length()>0)
	{
	   w=Tools.parseInt(request.getParameter("w").toString());
	}	
%>
<div id="rmhd" style="<%if(w>=1200){out.print("width:966px;");}else{out.print("width:746px;");}%> height:100%; float:right; ">
	 <%
	    ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
	    if(w>=1200){
	    	index_plist=PromotionHelper.getBrandListByCode("3430", 5);
	    }
	    else
	    {
	    	index_plist=PromotionHelper.getBrandListByCode("3430", 4);
	    }
	    if(index_plist!=null&&index_plist.size()>0)
	    { int i=0;%>
	    <ul>
	    <%  for(Promotion p:index_plist)
	    	{
	    	   if(p!=null)
	    	   { 
	    	      if(i==index_plist.size()-1)
	    	      {
	    	   %>
	    		   <li style="<%if(w>=1200){ out.print("margin-right:0px;");}else{out.print("margin-right:0px;");}%>"><a href="<%= p.getSplmst_url()==null?"http://www.d1.com.cn/":p.getSplmst_url() %>" target="_blank"><img src="<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>" border="0" /></a></li>
	          <%  }
	    	      else
	    	      {%>
	    	    	 <li style="<%if(w>=1200){ out.print("margin-right:11px;");}else{out.print("margin-right:3px;");}%>"><a href="<%= p.getSplmst_url()==null?"http://www.d1.com.cn/":p.getSplmst_url() %>" target="_blank"><img src="<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>" border="0" /></a></li>
	      
	    	      <%}
	    	      i++;
	    	   }
	    	}%>
	    </ul>   
	  <% }
	 %>
	</div>
