<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<% 
int showsku2=0;
String pid=request.getParameter("gdsid");
Product p=ProductHelper.getById(pid);
List<Sku> skuList2 = SkuHelper.getSkuListViaProductIdO(pid,showsku2);
							    if(skuList2 != null && !skuList2.isEmpty()){
							    	int size = skuList2.size();
							    	%><div id="skuname3" class="skuname">
							    	<p>选择颜色：<font id="sizecount3"><%=size==1?skuList2.get(0).getSkumst_sku1():"未选择" %></font>
									<div style="clear:both;"></div>
							    		<ul>
							    		<%
							    		for(int i=0;i<size;i++){
							    			Sku sku = skuList2.get(i);
							    			String skuname = sku.getSkumst_sku1();
							    			if(p.getGdsmst_stocklinkty()!=null&&(p.getGdsmst_stocklinkty().longValue()==1||p.getGdsmst_stocklinkty().longValue()==2)){
							    				if(CartItemHelper.getProductOccupyStock(p.getId(), sku.getId())<ProductHelper.getVirtualStock(p.getId(), sku.getId())){
								    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname3(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
							    				}
							    				else
							    				{
							    					if(sku.getSkumst_vstock().longValue()==0){ %>
							    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a></li>
							    					<%}
							    					else
							    					{%>
							    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname3(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li>
							    					<%}
							    				}
							    			}else{
							    	
							    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname3(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
							    			  
							    			}
							    		}
							    		%>

							    		</ul>
							    	</div><%
							    }%>
