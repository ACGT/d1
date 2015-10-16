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
	<div style="background:url(http://images.d1.com.cn/images2013/newindex/hzp.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px; margin-bottom:10px;">
		  <table width="100%"><tr><td width="220"><a href="http://Cosmetic.d1.com.cn/" target="_blank" style="width:220px; display:block;height:42px;">&nbsp;</a>		  
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	      <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
		     index_plist=PromotionHelper.getBrandListByCode("3421",10);
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
		  </font></td>
		  </tr></table>
		   
		</div>	
	  <div style=" <%if(w>=1200){ out.print("width:870px;");}else{out.print("width:650px;");} %> float:left;">
	  <% 
	  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
	  if(w>=1200){
	      index_pplist=PromotionProductHelper.getPromotionProductByCode("8805",20);
	  }
	  else
	  {
		  index_pplist=PromotionProductHelper.getPromotionProductByCode("8805",16);
	  }
	  if(index_pplist!=null&&index_pplist.size()>0)
	  {
		  int i=0;
		  for(PromotionProduct pp:index_pplist)
		  {
			  if(pp!=null)
			  {
				  i++;
				  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				  if(product!=null){
					  boolean ismiaoshao=CartHelper.getmsflag(product);

	        			float memberprice= product.getGdsmst_memberprice().floatValue();
	        			if(ismiaoshao){
	        				memberprice=product.getGdsmst_msprice().floatValue();
	        			}
				  %>
			      <dl style="<%if(w>=1200){ out.print("margin-right:14px;");}else{if(i%4!=0)out.print("margin-right:3px;");else out.print("margin-right:0px;");} %>">
			      <dt style="background:#fff;"><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_recimg())&&product.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_recimg())?"":product.getGdsmst_recimg() %>" width="160" height="160" /></a></dt>
		          <dd>
		            <span style="color:#8b8b8b;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40) %></font>
		            <font style="color:#7c7c7c;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
	              </dd>		         
		         </dl>
				  
			  <%}
			  }
		  }
	  }
	  %>	 
	  </div>
	  <%}
	else if(flag==2){%>
	<div style="background:url(http://images.d1.com.cn/images2013/newindex/nyjj.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px; margin-bottom:10px;">
		  <table width="100%"><tr><td width="260"><a href="http://www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015,012" target="_blank" style="width:260px; display:block;height:42px;">&nbsp;</a>		  
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	      <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
		     index_plist=PromotionHelper.getBrandListByCode("3422",10);
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
		  </font></td>
		  </tr></table>
		</div>
		
		  <div style=" <%if(w>=1200){ out.print("width:870px;");}else{out.print("width:650px;");} %> float:left;">
		  <% 
		  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
		  if(w>=1200){
		      index_pplist=PromotionProductHelper.getPromotionProductByCode("8806",10);
		  }
		  else
		  {
			  index_pplist=PromotionProductHelper.getPromotionProductByCode("8806",8);
		  }
		  if(index_pplist!=null&&index_pplist.size()>0)
		  {
			  int i=0;
			  for(PromotionProduct pp:index_pplist)
			  {
				  if(pp!=null)
				  {
					  i++;
					  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					  if(product!=null){
						  boolean ismiaoshao=CartHelper.getmsflag(product);
		        			float memberprice= product.getGdsmst_memberprice().floatValue();
		        			if(ismiaoshao){
		        				memberprice=product.getGdsmst_msprice().floatValue();
		        			}
					  %>
				      <dl style="<%if(w>=1200){ out.print("margin-right:14px;");}else{if(i%4!=0)out.print("margin-right:3px;");else out.print("margin-right:0px;");} %>">
			          <dt style="background:#fff;"><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_recimg())&&product.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_recimg())?"":product.getGdsmst_recimg() %>" width="160" height="160" /></a></dt>
			          <dd>
			            <span style="color:#8b8b8b;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40) %></font>
			            <font style="color:#7c7c7c;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
		              </dd>		         
			         </dl>
					  
				  <%}
				  }
			  }
		  }
		  %>	 
		  </div>
		<%}
	else if(flag==3){%>
	<div style="background:url(http://images.d1.com.cn/images2013/newindex/xp.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px;margin-bottom:10px;">
		  <table width="100%"><tr><td width="150"><a href="http://www.d1.com.cn/result.jsp?productsort=021,031" target="_blank" style="width:150px; display:block;height:42px;">&nbsp;</a>		  
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	      <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
		     index_plist=PromotionHelper.getBrandListByCode("3423",10);
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
		  </font></td>
		  </tr></table>
		</div>
		
		  <div style=" <%if(w>=1200){ out.print("width:870px;");}else{out.print("width:650px;");} %> float:left;">
		  <% 
		  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
		  if(w>=1200){
		      index_pplist=PromotionProductHelper.getPromotionProductByCode("8807",10);
		  }
		  else
		  {
			  index_pplist=PromotionProductHelper.getPromotionProductByCode("8807",8);
		  }
		  if(index_pplist!=null&&index_pplist.size()>0)
		  {
			  int i=0;
			  for(PromotionProduct pp:index_pplist)
			  {
				  if(pp!=null)
				  {
					  i++;
					  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					  if(product!=null){
						  boolean ismiaoshao=CartHelper.getmsflag(product);
		        			float memberprice= product.getGdsmst_memberprice().floatValue();
		        			if(ismiaoshao){
		        				memberprice=product.getGdsmst_msprice().floatValue();
		        			}
					  %>
				      <dl style="<%if(w>=1200){ out.print("margin-right:14px;");}else{if(i%4!=0)out.print("margin-right:3px;");else out.print("margin-right:0px;");} %>">
				      <dt style="background:#fff;"><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_recimg())&&product.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_recimg())?"":product.getGdsmst_recimg() %>" width="160" height="160" /></a></dt>
			          <dd>
			            <span style="color:#8b8b8b;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40) %></font>
			            <font style="color:#7c7c7c;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
		              </dd>		         
			         </dl>
					  
				  <%}
				  }
			  }
		  }
		  %>	 
		  </div>
		<%}
	else if(flag==4){%>
	<div style="background:url(http://images.d1.com.cn/images2013/newindex/xbpj.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px;margin-bottom:10px;">
		   <table width="100%"><tr><td width="345"><a href="http://www.d1.com.cn/result.jsp?productsort=050" target="_blank" style="width:345px; display:block;height:42px;">&nbsp;</a>		  
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	      <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
		     index_plist=PromotionHelper.getBrandListByCode("3424",10);
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
		  </font></td>
		  </tr></table>
		</div>
		
		  <div style=" <%if(w>=1200){ out.print("width:870px;");}else{out.print("width:650px;");} %> float:left;">
		  <% 
		  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
		  if(w>=1200){
		      index_pplist=PromotionProductHelper.getPromotionProductByCode("8808",10);
		  }
		  else
		  {
			  index_pplist=PromotionProductHelper.getPromotionProductByCode("8808",8);
		  }
		  if(index_pplist!=null&&index_pplist.size()>0)
		  {
			  int i=0;
			  for(PromotionProduct pp:index_pplist)
			  {
				  if(pp!=null)
				  {
					  i++;
					  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					  if(product!=null){
						  boolean ismiaoshao=CartHelper.getmsflag(product);
		        			float memberprice= product.getGdsmst_memberprice().floatValue();
		        			if(ismiaoshao){
		        				memberprice=product.getGdsmst_msprice().floatValue();
		        			}
					  %>
				      <dl style="<%if(w>=1200){ out.print("margin-right:14px;");}else{if(i%4!=0)out.print("margin-right:3px;");else out.print("margin-right:0px;");} %>">
				      <dt style="background:#fff;"><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_recimg())&&product.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_recimg())?"":product.getGdsmst_recimg() %>" width="160" height="160" /></a></dt>
			          <dd>
			            <span style="color:#8b8b8b;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40) %></font>
			            <font style="color:#7c7c7c;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
		              </dd>		         
			         </dl>
					  
				  <%}
				  }
			  }
		  }
		  %>	 
		  </div>
		<%}
	else if(flag==5){%>
	<div style="background:url(http://images.d1.com.cn/images2013/newindex/pjsb.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px;margin-bottom:10px;">
		   <table width="100%"><tr><td width="370"><a href="http://www.d1.com.cn/result.jsp?productsort=040,015002" target="_blank" style="width:370px; display:block;height:42px;">&nbsp;</a>		  
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	      <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
		     index_plist=PromotionHelper.getBrandListByCode("3425",10);
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
		  </font></td>
		  </tr></table>
		</div>
		
		  <div style=" <%if(w>=1200){ out.print("width:870px;");}else{out.print("width:650px;");} %> float:left;">
		  <% 
		  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
		  if(w>=1200){
		      index_pplist=PromotionProductHelper.getPromotionProductByCode("8809",10);
		  }
		  else
		  {
			  index_pplist=PromotionProductHelper.getPromotionProductByCode("8809",8);
		  }
		  if(index_pplist!=null&&index_pplist.size()>0)
		  {
			  int i=0;
			  for(PromotionProduct pp:index_pplist)
			  {
				  if(pp!=null)
				  {
					  i++;
					  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					  if(product!=null){
						  boolean ismiaoshao=CartHelper.getmsflag(product);
		        			float memberprice= product.getGdsmst_memberprice().floatValue();
		        			if(ismiaoshao){
		        				memberprice=product.getGdsmst_msprice().floatValue();
		        			}
					  %>
				      <dl style="<%if(w>=1200){ out.print("margin-right:14px;");}else{if(i%4!=0)out.print("margin-right:3px;");else out.print("margin-right:0px;");} %>">
				      <dt style="background:#fff;"><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_recimg())&&product.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_recimg())?"":product.getGdsmst_recimg() %>" width="160" height="160" /></a></dt>
			          <dd>
			            <span style="color:#8b8b8b;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40) %></font>
			            <font style="color:#7c7c7c;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
		              </dd>		         
			         </dl>
					  
				  <%}
				  }
			  }
		  }
		  %>	 
		  </div>
		<%}
	else if(flag==6){%>
	<div style="background:url(http://images.d1.com.cn/images2013/newindex/sp.jpg) no-repeat; height:42px; <%if(w>=1200){out.print("width:1200px;");}else{out.print("width:980px;");}%>line-height:42px;margin-bottom:10px;">
		   <table width="100%"><tr><td width="220"><a href="http://www.d1.com.cn/result.jsp?productsort=015009" target="_blank" style="width:220px; display:block;height:42px;">&nbsp;</a>		  
		  </td>
		  <td style="text-align:left;"><font style="font-size:12px;">
	      <% ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
		     index_plist=PromotionHelper.getBrandListByCode("3426",10);
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
		  </font></td>
		  </tr></table>
		</div>
		
		  <div style=" <%if(w>=1200){ out.print("width:870px;");}else{out.print("width:650px;");} %> float:left;">
		  <% 
		  ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
		  if(w>=1200){
		      index_pplist=PromotionProductHelper.getPromotionProductByCode("8810",10);
		  }
		  else
		  {
			  index_pplist=PromotionProductHelper.getPromotionProductByCode("8810",8);
		  }
		  if(index_pplist!=null&&index_pplist.size()>0)
		  {
			  int i=0;
			  for(PromotionProduct pp:index_pplist)
			  {
				  if(pp!=null)
				  {
					  i++;
					  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					  if(product!=null){
						  boolean ismiaoshao=CartHelper.getmsflag(product);
		        			float memberprice= product.getGdsmst_memberprice().floatValue();
		        			if(ismiaoshao){
		        				memberprice=product.getGdsmst_msprice().floatValue();
		        			}
					  %>
				      <dl style="<%if(w>=1200){ out.print("margin-right:14px;");}else{if(i%4!=0)out.print("margin-right:3px;");else out.print("margin-right:0px;");} %>">
				      <dt style="background:#fff;"><a href="http://www.d1.com.cn/Product/<%= pp.getSpgdsrcm_gdsid() %>" target="_blank"><img src="<%= !Tools.isNull(product.getGdsmst_recimg())&&product.getGdsmst_recimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(product.getGdsmst_recimg())?"":product.getGdsmst_recimg() %>" width="160" height="160" /></a></dt>
			          <dd>
			            <span style="color:#8b8b8b;"><font style="display:block; width:85%; margin:0px auto;"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40) %></font>
			            <font style="color:#7c7c7c;"><%if(ismiaoshao){ out.print("促销价：");}else{ %>会员价：<%} %><font style="font-family:'微软雅黑'; color:#b80024; font-size:14px;"><b>￥<%= Tools.getFloat(memberprice,1) %></b></font></font></span>
		              </dd>		         
			         </dl>
					  
				  <%}
				  }
			  }
		  }
		  %>	 
		  </div>
		<%}
%>
