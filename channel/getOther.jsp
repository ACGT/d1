<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn/"+img.trim().replace("\\","/");
	
	return img;
}
//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
private static ArrayList<Gdscoll>  getGdscollByGdsid(String gdsid)
{
	  boolean flag=false;
	  ArrayList<Gdscoll> result=new ArrayList<Gdscoll>();
	  ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.ge("gdscoll_cate",new Long(3)));
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		
		if(list!=null&&list.size()>0)
		{
			if(gdsid.length()==0)
			{
				result=list;
			}
			else
			{
				for(Gdscoll gdscoll:list)
				{
					if(gdscoll!=null)
					{
						ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
						if(gdlist!=null)
						{
							for(Gdscolldetail gd:gdlist)
							{
								if(gd.getGdscolldetail_gdsid().equals(gdsid))
								{
									flag=true;
								}
							}
						}
						if(flag)
						{
							result.add(gdscoll);
						}
						flag=false;
					}
					
				}
				return result;
			}
		}
		return result;
}

%>
<%
    String sk = request.getAttribute("searchkey").toString();
 
    if(!Tools.isNull(sk)){//重新搜索了
	
	if(sk.length()==8&&StringUtils.isDigits(sk)){
		Product searchProduct = (Product)Tools.getManager(Product.class).get(sk);
		if(searchProduct!=null){
			response.sendRedirect("http://www.d1.com.cn/product/"+searchProduct.getId());
			return;
		}
	}
	if(sk.length()==10&&sk.toUpperCase().startsWith("BK")&&"01720270".equals(sk.substring(2))){
			response.sendRedirect("http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=bk01720270&url=http://www.d1.com.cn/product/01720270");
			return;
	}
	if(sk.length()==10&&sk.toUpperCase().startsWith("FA")){
		Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
		if(searchProduct!=null){
			response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dmfa12&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
			return;
		}
	}

	if(sk.length()==10&&sk.toUpperCase().startsWith("WE")){
		Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
		if(searchProduct!=null){
			response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dmwe1110&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
			return;
		}
	}
	if(sk.length()==10&&sk.toUpperCase().startsWith("DM")){
	
		Product searchProduct = (Product)Tools.getManager(Product.class).get(sk.substring(2));
		if(searchProduct!=null){
			if (searchProduct.getGdsmst_validflag()==1){
			if("01416134".equals(sk.substring(2))){
				boolean blngds=true;
				ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
				if(cartList!=null){
					for(Cart c123:cartList){
						if(c123.getType().longValue()==14&&c123.getProductId().equals("01416134")){
							blngds=false;
						}
					}
				}

				if(blngds){
				Cart cart =new Cart();
				cart.setAmount(new Long(1));
				cart.setCookie(CartHelper.getCartCookieValue(request, response));
				cart.setCreateDate(new Date());
				cart.setHasChild(new Long(0));
				cart.setHasFather(new Long(0));
				cart.setIp(request.getRemoteHost());
				cart.setMoney(new Float(0));
				cart.setOldPrice(new Float(0));
				cart.setPoint(new Long(0));
				cart.setPrice(new Float(0));
				cart.setSkuId("");
				cart.setTuanCode("");//注意parentId值
				cart.setProductId("01416134");
				cart.setType(new Long(14));
				cart.setUserId(CartHelper.getCartUserId(request, response));
				cart.setVipPrice(new Float(0));
				cart.setTitle("【网易DM刊赠品】"+searchProduct.getGdsmst_gdsname());
				Tools.getManager(Cart.class).create(cart);
				response.sendRedirect("/flow.jsp");
				return;
				}
				else
				{
					response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dm1215&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
					return;
				}
			}
			else{
			response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=dm1215&md=d1_1111&url=http://www.d1.com.cn/product/"+searchProduct.getId());
			return;
			}
			}
		}
	}
	
	//这里看关键词是否需要跳转，如果需要跳转，直接跳转后不执行搜索
	
	session.removeAttribute(SearchManager.search_result_session_key);//重新搜索的话把原来session的搜索结果清除
}else{
	
}


//搜索结果
SearchResult sr = SearchManager.getInstance().searchProduct(
		request,response,
		null,
		sk,
		60000);//缓存时间，毫秒

//搜索结果
List<Product> list = sr.getProducts(null, "createtime", false, 1,10);
		int count=0;
if(list!=null&&list.size()>0)
{%>
<div class="newlist">
       <table><tr><td>
<ul>
	<%for(Product goods:list){
		if(goods!=null&&goods.getGdsmst_validflag()!=null&&goods.getGdsmst_ifhavegds()!=null&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(goods)){
			 
		count++;
		if(count>6){break;}
 	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
 	   String id = goods.getId();
 	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
 	   long currentTime = System.currentTimeMillis();
        	%>
        	<%
        	if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")))
				{
        		   out.print("<li style=\"height:430px;\">");
				}
        	else
        	{
        		out.print("<li style=\"height:430px;\">");
        	}
        	%>
         
    		<div class="lf">
           				<% 
           				if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")))
           					{
           					%>
           					   <p style="z-index:999;"><a href="<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           				
           							<img src="<%= getImageTo200250(goods) %>" width="200" height="250" />
           	           
           				<%	}
           				    else
           				    {%>
           				    <p style="z-index:999; padding-top:25px; padding-bottom:25px;"><a href="<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           				
           				    	<img src="<%= ProductHelper.getImageTo200(goods) %>" width="200" height="200" />
           	           
           				    <%}%>
           				</a>
           						<%  //每个商品对应的搭配列表
                              ArrayList<Gdscoll> gdscolllist=getGdscollByGdsid(goods.getId()); 
           				   %>   
           				      </p>
           				 
                         <p style="height:35px; font-size:13px; color:#999999; ">
			               <span class="newspan">
			               <% if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){%>
			                   <font color="#b80024" style=" font-family:'微软雅黑'"><b>特价:￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			                   <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(goods.getGdsmst_oldmemberprice()) %></font>
			                   
			               <%}else
			                {%>
			                 <font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			                  <%} %>
			                 </span>
			               
			               <span class="newspan1"><a href="/product/<%= goods.getId() %>?st=com#cmt" target="_blank">评论(<%= CommentHelper.getCommentLength(id) %>)</a></span>
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
             <p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" ><a href="<%=ProductHelper.getProductUrl(goods) %>" target="_blank" style="font-size:12px; color:#606060; "><%=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,54)%></a></p>
                     
              <div class="clear"></div>
              <%
                Comment com=null;
                List<Comment> clist= CommentHelper.getCommentList(id,0,1000);
                if(list!=null&&clist.size()>0)
                {
                	for(Comment c:clist)
                	{
                		if(c.getGdscom_level().longValue()==5)
                		{
                			com=c;
                			break;
                		}
                		else
                		{
                			continue;
                		}
                	}
                	if(com==null)
                	{
                		for(Comment c:clist)
                    	{
                    		if(c.getGdscom_level().longValue()==4)
                    		{
                    			com=c;
                    			break;
                    		}
                    		else
                    		{
                    			continue;
                    		}
                    	}
                		if(com==null)
                		{
                			for(Comment c:clist)
                        	{
                        		if(c.getGdscom_level().longValue()==3)
                        		{
                        			com=c;
                        			break;
                        		}
                        		else
                        		{
                        			continue;
                        		}
                        	}
                		}
                	}
                }
              %>
              <%
                  if(com!=null)
                  {%>
                	  <div class="lb" title="<%= com.getGdscom_content() %>"><b><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><%= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></div>
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

             	  <div  id="floatdp<%= goods.getId()%><%= count %>" class="floatdp" onmouseover="mdmover('<%= goods.getId()%>','<%= count %>')" onmouseout="mdm_out('<%= goods.getId()%>','<%= count%>')">

                   </div>
                   <div id="price<%= goods.getId()%><%= count%>" class="dpprice" onmouseover="mdmover('<%= goods.getId()%>','<%= count %>')" onmouseout="mdm_out('<%= goods.getId()%>','<%= count%>')">
                       <table width="100%">
                        <tr>
                         <td>   
                         <br/>
			                        <font style="text-align:left; font-size:12px; color:#ca0000;display:block;font-weight:bold; margin:0px auto;"> &nbsp;说明：<br/>&nbsp;&nbsp;&nbsp;&nbsp;两件或两件以上95折<br/>&nbsp;&nbsp;&nbsp;&nbsp;请在左侧选择搭配单品。</font>  <br/>
			                        <font style="color:#333; font-size:14px; font-weight:bold;">共&nbsp;<em id="count_<%=goods.getId() %>_<%=count %>">1</em>&nbsp;件&nbsp;&nbsp;组合购买</font><br/>
			                 <br>
			                 <strike>总价：￥&nbsp;<em id="totalmoney_<%=goods.getId() %>_<%=count %>">0.0</em>&nbsp;元  </strike>
			                 <br>组合价：<font color="#bc0000" face="微软雅黑">￥&nbsp;<em id="money_<%=goods.getId() %>_<%=count %>">0.0</em>&nbsp;</font>元<br>
			                                                  共优惠：￥&nbsp;<em id="cheap_<%=goods.getId() %>_<%=count %>"><%= 0.0 %></em>&nbsp;元  <br><br>
			                  <a href="javascript:void(0)" onclick="AddInCart(this)" flag="<%= count%>" id="<%=goods.getId() %>"><img src="http://images.d1.com.cn/Index/images/ljgmzh.png" />  </a> 
			                  <br/>
			             
			                   <%
					         if((goods.getGdsmst_rackcode().startsWith("020")||goods.getGdsmst_rackcode().startsWith("030"))&&(goods.getGdsmst_brandname()!=null&&goods.getGdsmst_brandname().length()>0&&(goods.getGdsmst_brandname().equals("诗若漫")||goods.getGdsmst_brandname().equals("AleeiShe 小栗舍")||goods.getGdsmst_brandname().equals("FEEL MIND")))){%>
					    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= id%>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/DIY.png" style="border:none;"/></a><br/>
					    	
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
           } 
	}
	%>
	</ul>
</td></tr></table>
</div>
	
	<%}%>