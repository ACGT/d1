<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
    int w=980;
	if(request.getParameter("w")!=null&&request.getParameter("w").toString().length()>0)
	{
	   w=Tools.parseInt(request.getParameter("w").toString());
	}	
	int flag=1;
	if(request.getParameter("f")!=null&&request.getParameter("f").toString().length()>0)
	{
	   flag=Tools.parseInt(request.getParameter("f").toString());
	}	
%>
<%  if(flag==1){ %>
<div style="background:url(http://images.d1.com.cn/images2013/newindex/nzxb.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px;">
<%}
else{%>
<div style="background:url(http://images.d1.com.cn/images2013/newindex/nz.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px;">
<%}
%>
<%  if(flag==1){ %>
<table width="100%"><tr><td width="150"><a href="http://www.d1.com.cn/html/women/" target="_blank" style="width:150px; display:block;height:42px;">&nbsp;</a>		  
<%}
else
{%>
<table width="100%"><tr><td width="150"><a href="http://www.d1.com.cn/html/men/" target="_blank" style="width:150px; display:block;height:42px;">&nbsp;</a>		  
	
<%}%>
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	  <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
	  if(flag==1){
	     index_plist=PromotionHelper.getBrandListByCode("3419",10);
	  }
	  else
	  {
		  index_plist=PromotionHelper.getBrandListByCode("3420",10);
	  }
	     if(index_plist!=null&&index_plist.size()>0)
	     {
	    	 for(Promotion p:index_plist)
	    	 {
	    		 if(p!=null)
	    		 {%>
	    			 <a href="<% out.print(p.getSplmst_url()!=null?p.getSplmst_url():""); %>" target="_blank">&nbsp;&nbsp;<% out.print(p.getSplmst_name()!=null?p.getSplmst_name():""); %>&nbsp;&nbsp;&nbsp;|</a>
	    		 <%}
	    	 }
	    	 
	     }
	  %>	  
	  </font>
	  </td>
		  </tr></table>

	  
	</div>
	<div class="imglist" style="<%if(w>=1200){out.print("_width:850px;");}else{out.print("_width:630px;");}%>" >	  
	  <!--服装类商品列表-->
	  <!--  1200  对应855  980 对应 635-->
	  <div style="<%if(w>=1200){out.print("width:855px;");}else{out.print("width:635px;");}%> float:left; margin-top:5px;">
	  <%  
	  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
	  if(w>=1200){
		      if(flag==1){
			      index_pplist=PromotionProductHelper.getPromotionProductByCode("8803",20);
			  }
			  else
			  {
				  index_pplist=PromotionProductHelper.getPromotionProductByCode("8804",16);
			  }
	      
	  }
	  else
	  {
		      if(flag==1){
			      index_pplist=PromotionProductHelper.getPromotionProductByCode("8803",15);
			  }
			  else
			  {
				  index_pplist=PromotionProductHelper.getPromotionProductByCode("8804",12);
			  }
	  }
	  if(index_pplist!=null&&index_pplist.size()>0)
	  {
		  for(PromotionProduct pp:index_pplist)
		  {
			  if(pp!=null)
			  {
				  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				  if(product!=null){
	
	        			boolean ismiaoshao=CartHelper.getmsflag(product);
	        			
	        			float memberprice= product.getGdsmst_memberprice().floatValue();
	        			if(ismiaoshao){
	        				memberprice=product.getGdsmst_msprice().floatValue();
	        			}
				  %>
			      <dl>
		          <dt><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_img200250())&&product.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_img200250())?"":product.getGdsmst_img200250() %>" width="200" height="250" /></a></dt>
		          <dd>
				     <span style="color:#333;  "><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑';font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></span>
					 <span style="color:#333;display:none;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),48) %></font>
					 <font style="color:#fe0002;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
				  </dd>
		         </dl>
				  
			  <%}
			  }
		  }
	  }
	  %>
	 
	  </div>  
	</div>
	<script>
	$('.imglist div dl:not(.dplist dl)').hover(function(e){
		 $(this).find("dd span:last").css('display','block');					   
		 $(this).find("dd span:first").css('display','none');										   
	},function(e){
		$(this).find("dd span:first").css('display','block');	
		$(this).find("dd span:last").css('display','none');	
		});
	</script>