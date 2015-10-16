<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
    int w=980;
	if(request.getParameter("w")!=null&&request.getParameter("w").toString().length()>0)
	{
	   w=Tools.parseInt(request.getParameter("w").toString());
	}	
%>
<div style="background:url('http://images.d1.com.cn/images2013/newindex/rmhd_logo.jpg') no-repeat;margin-bottom:10px;_margin-bottom:7px; height:47px; width:100%;"></div>
<div class="indexhot">

	<% 
	ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
	int num=5;
	if(w<1200){
		num=4;
	}
	index_plist=PromotionHelper.getBrandListByCode("3640", num);
	StringBuilder sb1=new StringBuilder();
	StringBuilder sb2=new StringBuilder();
	if(index_plist!=null&&index_plist.size()>0)
	{	
		sb1.append("<ul>");


		for(int i=0;i<index_plist.size();i++)
		{
			Promotion p=index_plist.get(i);
			if(i==0)
			{

				sb1.append("<li><a href=\""+(p.getSplmst_url()!=null?p.getSplmst_url():"http://www.d1.com.cn/")+"\" target=\"_blank\"><img src=\""+(p.getSplmst_picstr()!=null?p.getSplmst_picstr():"")+"\" width=\"220\" height=\"330\" /></a></li>");

			}
			else
			{
				if(w==980){
					sb1.append("<li class=\"mgl4\"><a href=\""+(p.getSplmst_url()!=null?p.getSplmst_url():"http://www.d1.com.cn/")+"\" target=\"_blank\"><img src=\""+(p.getSplmst_picstr()!=null?p.getSplmst_picstr():"")+"\" width=\"220\" height=\"330\" /></a></li>");
				}else{
					sb1.append("<li class=\"mgl5\"><a href=\""+(p.getSplmst_url()!=null?p.getSplmst_url():"http://www.d1.com.cn/")+"\" target=\"_blank\"><img src=\""+(p.getSplmst_picstr()!=null?p.getSplmst_picstr():"")+"\" width=\"220\" height=\"330\" /></a></li>");
				}
			}

		}
		sb1.append("</ul>");
	}
	out.print(sb1.toString());
	%>		
	
	</div> 

