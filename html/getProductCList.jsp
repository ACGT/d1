<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.dbcache.core.*"%>
<%@include file="/html/getComment.jsp" %>
<%!
//获取某一分类最新的商品
private ArrayList<Product> getNewProduct(String rackcode,int length)
{
	ArrayList<Product> list=new ArrayList<Product>();	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	clist.add(Restrictions.eq("gdsmst_rackcode", rackcode));
	clist.add(Restrictions.eq("gdsmst_ifhavegds",new Long(0)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("gdsmst_createdate"));
	List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,length+5);
	if(b_list==null||b_list.size()==0)return null;
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Product)be);
		}
	}
return list;	
}
%>
<%
String code="";
if(request.getAttribute("code")!=null ){
   code=request.getAttribute("code").toString();
}
int len=12;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<Product> plist= new ArrayList<Product>(); 
if(Tools.isNumber(code))
{
	 int count=0;
     	plist=getNewProduct(code,len);
     	if(plist!=null&&plist.size()>0)
     	{%>
     	 <div class="listtitle"> 
				          <span class="listtitle_1">D1优尚为您精心挑选的新款<a href="http://www.d1.com.cn/result.jsp?productsort=<%= code %>" target="_blank" style="color:#f26522; text-decoration:none;"><%=DirectoryHelper.getById(code).getRakmst_rackname() %></a></span>
				        </div>
     		<div class="newlist" >
           <table><tr><td>
          <ul><%
	               for(Product goods : plist){
		           count++;
		           if(count>len){ break;}
	        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
	        	   String ids = goods.getId();
	        	   long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
	        	   long currentTimes = System.currentTimeMillis();
	        	   String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,52) ;
	        	
	        	    if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
					{
	        		   out.print("<li style=\"height:470px;\">");
					}
		        	else
		        	{
		        		out.print("<li style=\"height:410px;\">");
		        	}
	        	%>
	         
	    		<div class="lf">
	           				<p style="z-index:999;position:relative;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
	           				<%
	           				 if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
	           				 {
	           					String imgurl240300=goods.getGdsmst_img240300();
	           					if(imgurl240300!=null){
	        	        	    if(imgurl240300.startsWith("/shopimg/gdsimg")){
	        	        	    	imgurl240300 = "http://images1.d1.com.cn"+imgurl240300.trim();
	        	        		}else{
	        	        			imgurl240300 = "http://images.d1.com.cn"+imgurl240300.trim();
	        	        		}
	           					}
	           				 %>
	           					 <img src="<%=imgurl240300 %>" width="240" height="300"  alt="<%= Tools.clearHTML(goods.getGdsmst_gdsname()) %>" />
	           	        
	           				 <%  
	           				 }
	           				else
	           				{
	           				%>
	           					 <img src="<%= ProductHelper.getImageTo400(goods) %>" width="240" height="240"  alt="<%= Tools.clearHTML(goods.getGdsmst_gdsname()) %>" />
	           	        
	           				<%}%>
	           					
					         
	           				
	           				    	</a>  
	           				
	           				<%  //每个商品对应的搭配列表
	           				   
	           				ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(goods.getId()); 
	           				
	           				 %>   
	                    
	                      </p>
	                      
	           			  <p style="height:35px; font-size:13px; color:#999999;">
				               <span class="newspan">
				               <% if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){%>
				                   <font color="#b80024" style=" font-family:'微软雅黑'"><b>特价:￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
				                    <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(goods.getGdsmst_oldmemberprice()) %></font>
				             
				               <%}else
				                {%>
				               <font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
				               <%} %>
				               </span>	
				               <%
				               //评论
				               int contentcounts =0;
				               ArrayList<Comment> commentlistss=getCommentList(ids);
				               contentcounts=commentlistss.size();
				               %>		               
				               <span class="newspan1" id="commensapn<%= count%>"><a href="http://www.d1.com.cn/product/<%= goods.getId() %>?st=com#cmt" target="_blank" rel="nofollow">评论(<%= contentcounts %>)</a></span>
				           </p>
				          
	             </div>
	           
	              <p style="height:30px; background:#fff; line-height:30px; text-align:center;">
	               <a href="javascript:void(0)" attr="<%= goods.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2012/index2012/SEP/ljgm.gif"/></a>&nbsp;&nbsp;&nbsp;
	               <%if(gdscolllist!=null&&gdscolllist.size()>0)
	           				      {%>
	               <a href="javascript:void(0)" onclick="mdm_over('<%= goods.getId() %>','<%= count%>')"><img src="http://images.d1.com.cn/images2012/index2012/SEP/dpgm.gif"/></a>&nbsp;&nbsp;&nbsp;
	              <%}
	               if((goods.getGdsmst_rackcode().startsWith("020")||goods.getGdsmst_rackcode().startsWith("030"))&&!goods.getGdsmst_rackcode().startsWith("020011")&&!goods.getGdsmst_rackcode().startsWith("020012")&&!goods.getGdsmst_rackcode().startsWith("030011")){%>
						    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= goods.getId() %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/diydp.gif"/></a>
	              <%} %>
	                          </p>
	             
	              <p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" ><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" style="font-size:12px; color:#606060; "><%=gnames%></a></p>
	             
	              <div class="clear"></div>
	              <%  
	                Comment com=null;
	                List<Comment> list= CommentHelper.getCommentListByLevel(ids,0,1);
	                if(list!=null&&list.size()>0&&list.get(0)!=null)
	                {
	                	com=list.get(0);
	                }
	              %>
	              <%
	                  if(com!=null)
	                  {%>
	                	  <div class="lb" title="<%= com.getGdscom_content() %>"><b><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><a href="/product/<%=goods.getId() %>?st=com#cmt" target="_blank" rel="nofollow"><%= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></a></div>
	                  <% 
	                  }
	                  else
	                  {%>
	                	<div class="lb" ><b>暂无评论！！！</b></div>  
	                  <%}
	              %>
	              <%
	                  //获取搭配浮层
	                
	                  if(gdscolllist!=null&&gdscolllist.size()>0)
	                  {%>
	
	                	  <div  id="floatdp<%= count %>" onmouseover="mdmover('<%= count %>')" onmouseout="mdm_out('<%= count%>')">

                      </div>
                      <div id="price<%= count%>" class="dpprice" onmouseover="mdmover('<%= count %>')" onmouseout="mdm_out('<%= count%>')">
                          <table width="100%">
                           <tr>
                            <td>   
                            <br/>
			                        <font style="text-align:left; font-size:12px; color:#ca0000;display:block; font-weight:bold; margin:0px auto;">&nbsp;说明：<br/>&nbsp;&nbsp;&nbsp;&nbsp;两件或两件以上95折 <br/>&nbsp;&nbsp;&nbsp;&nbsp;请在左侧选择搭配单品。</font>
			                        <br/><font style="color:#333; font-size:14px; font-weight:bold;">共&nbsp;<em id="count_<%=count %>">1</em>&nbsp;件&nbsp;&nbsp;组合购买</font><br/>
			                 <br>
			                 <strike>总价：￥&nbsp;<em id="totalmoney_<%=count %>">0.0</em>&nbsp;元  </strike>
			                 <br>组合价：<font color="#bc0000" face="微软雅黑">￥&nbsp;<em id="money_<%=count %>">0.0</em>&nbsp;</font>元<br>
			                                                  共优惠：￥&nbsp;<em id="cheap_<%=count %>"><%= 0.0 %></em>&nbsp;元  <br><br>
			                  <a href="javascript:void(0)" onclick="AddInCart(this)" flag="<%= count%>"><img src="http://images.d1.com.cn/Index/images/ljgmzh.png" />  </a> 
			                  <br/>
			                   <%
					         if((goods.getGdsmst_rackcode().startsWith("020")||goods.getGdsmst_rackcode().startsWith("030"))&&(goods.getGdsmst_brandname()!=null&&goods.getGdsmst_brandname().length()>0&&(goods.getGdsmst_brandname().equals("诗若漫")||goods.getGdsmst_brandname().equals("AleeiShe 小栗舍")||goods.getGdsmst_brandname().equals("FEEL MIND")))){%>
					    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= goods.getId() %>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/DIY.png" style="border:none;"/></a><br/>
					    	
					         <%}
					      %>
			                </td>
                           </tr>
                          </table>  
                      </div>
                  <%}
              %>
             <input id="hidden<%=count %>" type="hidden" value="0"/>
              </li>
            <%
           } %>
</ul>
</td></tr></table>
</div>
     	<%}
}


%>