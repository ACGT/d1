<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
	String typeid="1";
    StringBuilder sb=new StringBuilder();
	if(request.getParameter("typeid")!=null&&request.getParameter("typeid").length()>0)
	{
	    if(Tools.isMath(request.getParameter("typeid")))
	    {
	    	typeid=request.getParameter("typeid");
	    	
	    }
	}
	    ArrayList<NoticeDir> mdlist=new ArrayList<NoticeDir>();
    	
    	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
    	clist.add(Restrictions.eq("parentId",typeid));
    	List<BaseEntity> blist=Tools.getManager(NoticeDir.class).getList(clist, null, 0, 100);
    	if(blist!=null)
    	{
    		for(BaseEntity b:blist)
    		{
    			if(b!=null)
    			{
    				mdlist.add((NoticeDir)b);
    			}
    		}
    	}
    	if(mdlist!=null&&mdlist.size()>0)
    	{
    		sb.append("<select id=\"ggsubtype\" name=\"ggsubtype\">");
             for(NoticeDir nd:mdlist)
             {
            	 
            	 if(nd!=null)
            	 {
            		 if(request.getParameter("nid")!=null&&request.getParameter("nid").length()>0)
            		 {
            			 sb.append("<option value=\"").append(nd.getId()).append("\"");
            			 if(nd.getId().equals(request.getParameter("nid")))
            					 {
            				            sb.append(" selected ");
            					 }
            			 sb.append(">"+nd.getTitle()).append("</option>");
                 	    
            		 }
            		 else
            		 {
            		 sb.append("<option value=\"").append(nd.getId()).append("\">").append(nd.getTitle()).append("</option>");
            	     }
            	 }
             }
    		
    		sb.append("</select>");
               
    	}
    	out.print(sb.toString());

%>