<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/header.jsp" %>



<%!

//获取新图
private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
 return list;
}
%>

<%
   String gdsid="";
   if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
   {
	   gdsid=request.getParameter("gdsid");
   }
   else return;
   String count="";
   if(request.getParameter("count")!=null&&request.getParameter("count").length()>0)
   {
	   count=request.getParameter("count");
   }
   Product goods=ProductHelper.getById(gdsid);
   if(goods!=null)
   {
   ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(gdsid);
   if(gdscolllist!=null&&gdscolllist.size()>0)
   {
     int counts=0;
      %>
	             <table border="0" cellspcing="0" cellpadding="0" style="float:right;margin-right:15px; border:solid 8px #808080;  " >
	             <tr>
	             <td>
                    <div id="banner<%=count %>" class="allb">    
                    <%  if(gdscolllist.size()>1){ %>
                      <div class="pre" id="pre2012<%=count%>"><img src="http://images.d1.com.cn/images2012/index2012/left.png"/></div>
                      <div class="next" id="next2012<%=count%>"><img src="http://images.d1.com.cn/images2012/index2012/right.png"/></div>
			          <%} %>
			    <div class="clear"></div>
			    <!-- 背景图片 -->
			    <%
			        String bgimg="http://images.d1.com.cn/images2012/aleeishe/images/0031.jpg";
			        if(goods.getGdsmst_brandname().indexOf("FEEL MIND")>=0)
			        {
			        	bgimg="http://images.d1.com.cn/images2012/feelmind/images/fmbg.jpg";
			        }
			        else if(goods.getGdsmst_brandname().indexOf("诗若漫")>=0)
			        {
			        	bgimg="http://images.d1.com.cn/images2012/sheromo/bj002.jpg";
			        }
			        else
			        {
			        	bgimg="http://images.d1.com.cn/images2012/aleeishe/images/0031.jpg";
			        }
			    %>
			    <div id="banner_list<%=count %>" class="allimglist"  style="background:url('<%= bgimg %>') no-repeat;">
			  <%  for(Gdscoll gdscoll:gdscolllist)
				  {
					  if(gdscoll!=null)
					  { counts++;%>
						<span attr="<%=counts %>" code="<%= gdscoll.getId() %>">
                        <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gdscoll.getId() %>" target="_blank" style="display:block; width:246px; height:350px;">
                        <img src="http://images1.d1.com.cn<% if(gdscoll.getGdscoll_brandimg()!=null&&gdscoll.getGdscoll_brandimg().length()>0) out.print(gdscoll.getGdscoll_brandimg()); else out.print(""); %>"/></a>
                         <% ArrayList<Gdscolldetail> egdlist=new ArrayList<Gdscolldetail>();
			               ArrayList<Gdscolldetail> fgdlist=new ArrayList<Gdscolldetail>();
			               ArrayList<Gdscolldetail> zgdlist=new ArrayList<Gdscolldetail>();
			               ArrayList<Gdscolldetail> mdlist=new ArrayList<Gdscolldetail>();
			               mdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
			               if(mdlist!=null&&mdlist.size()>0)
			               {
			            	   for(Gdscolldetail gdl:mdlist)
			            	   {
			            		   if(gdl!=null&&gdl.getGdscolldetail_flag().longValue()==1)
			            		   {
			            			   fgdlist.add(gdl);
			            		   }
			            		   else
			            		   {
			            			   zgdlist.add(gdl);
			            		   }
			            	   }
			               }
			               if(fgdlist!=null&&fgdlist.size()>0)
			               {
			            	   egdlist.addAll(fgdlist);
			               }
			               if(zgdlist!=null&&zgdlist.size()>0)
			               {
			            	    egdlist.addAll(zgdlist);
			               }
			               if(egdlist!=null&&egdlist.size()>0)
			               {%>
			            	  <div class="pj">
			                  <table width="100%">
			                  <tr><td style=" text-align:center; height:24px; line-height:18px; font-size:15px; color:#333; font-family:'微软雅黑'">搭配推荐</td></tr>
			                  <tr><td>
			            	<% for(Gdscolldetail gd:egdlist)
			            	   {
			            		   if(gd!=null&&gd.getGdscolldetail_flag()!=null&&gd.getGdscolldetail_flag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null){
			            		   Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
			            		   if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1){
			            			   String imgurl="";
			            			   ArrayList<GdsCutImg> gcilist=getByGdsid(p.getId());
			            			  
			            			   if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0)
			            			   {
			            				   imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_100();
			            			   }
			            			   else
			            			   {
			            				   imgurl=ProductHelper.getImageTo80(p);
			            			   }
			            			  
			            			
			            		   
			            		   %>
			            		   
			            		   <div>
			            			   <a href="http://www.d1.com.cn/product/<%= gd.getGdscolldetail_gdsid() %>" target="_blank" style="background:#fff;"><img src="<%= imgurl %>" width="75" height="75"/></a>
			            			   <div>
			            			    <input type="checkbox" name="chk_<%=count %>_<%=counts %>" <% if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1) out.print("checked"); %>  value="<%= gd.getGdscolldetail_gdsid() %>" attr="<%= gd.getGdscolldetail_gdsid().trim() %>"  onClick="selectdp(<%= counts %>,<%=count %>)" m="<%=p.getGdsmst_memberprice()%>">&nbsp;￥<%= p.getGdsmst_memberprice() %></input>
			            		       </div>
			            		  </div>
			            		   <%}
			            		   }
			            	   }
			            	%>
			            	  </td></tr></table></div>
			               <%}%>
			              </span> 
			            <%	}
				  }
			 %>
			 </div>
               </div>
              <script>scrollresult('#banner_list<%= count%>','#banner<%= count%>','<%=count%>');</script>
	             </td>
	             </tr>
             </table>
  
   <%}
   }
%>
