<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
    String orderid = request.getParameter("orderid");
    int flag=Tools.parseInt(request.getParameter("flag"));
    out.print(orderid+"     "+flag);
    if(orderid!=null&&orderid.length()>0&&flag>0)
    {
    	OrderBase ob;
	    switch(flag)
	    {
		    case 1:
		    case 2:
		    case 3:
		    {
		    	ob=OrderHelper.getById(orderid.trim());
		    	break;
		    }
		    case 4:
		    {
		    	ob=OrderHelper.getHistoryById(orderid.trim());
		    	break;
		    }
		    default:
		    {
		    	ob=OrderHelper.getById(orderid.trim());
		    	break;
		    }
	    
	    }
	    if(ob!=null)
	    {
		    Tools.getManager(ob.getClass()).clearListCache(ob);
		    if(ob.getOdrmst_paytype()==1)
		    {
		    	ob.setOdrmst_orderstatus(new Long(0));
		    }
		    else
		    {
		        ob.setOdrmst_orderstatus(new Long(0));
		    }
		    if(Tools.getManager(ob.getClass()).update(ob,true))
		    {
		    	//out.print("111");
		    }
		    else
		    {
		    	//out.print("222");
		    }
		 }
	    else
	    {
	    	//out.print("不存在");
	    }
	  
    }
    else
    {
    	out.print("参数不正确");
    }
    	
%>