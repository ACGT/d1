<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/html/getComment.jsp" %>
<%
String gdsarrstr = request.getParameter("id");

if (Tools.isNull(gdsarrstr)){
	out.print("找不到物品信息！");
	return;
}
int commentLength =0;
ArrayList<Comment> clist=getCommentList(gdsarrstr);
commentLength=clist.size();

int currentPage = 1 ;
String pg = request.getParameter("pg");
if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);

int PAGE_SIZE = 10 ;
PageBean pBean = new PageBean(commentLength,PAGE_SIZE,currentPage);
List<Comment> commentlist = getCommentListPage(clist,pBean.getStart(),PAGE_SIZE);
if(commentlist != null && commentlist.size()>0){
	%><table cellpadding="0" cellspacing="0" style="font-size:12px; width:100%">
					    	
	 <%
	 for(Comment comment:commentlist){
		 User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
			//if(user == null) continue;
			String hfusername =comment.getGdscom_uid();
			 String level = UserHelper.getLevelText(user);
			 if(comment.getGdscom_mbrid().intValue()==-1){
					level="普通会员";
				}
				else if(comment.getGdscom_mbrid().intValue()==-2){
					level="VIP会员";
				}
				else if(comment.getGdscom_mbrid().intValue()==-3){
					level="白金会员";
				}
			if(!Tools.isNull(comment.getGdscom_uid())){
				hfusername="***"+StringUtils.getCnSubstring(comment.getGdscom_uid(),0,10);
				hfusername=hfusername.replaceAll("调单", "ddan");
			}
		 %>
		 <tr>
			<td>
			<div id="comment" class="m">
                <div class="mc" >
                    <div id="divitem" class="item">
                        <div class="user">
                            <div class="u-icon">
                               <img src="<%=UserHelper.getLevelImage(level) %>" width="70" height="70" />                      
                            </div>
                            <div class="u-name">
                             <span><%=hfusername %></span><br>
                             <span><%=level %></span>
                            </div>
                       
                        </div>
                        <div class="i-item">
                        <div class="o-topic">
                          <div style="float:left"><strong class="topic">
                            <label style="font-weight:bold">评分：</label>
                            </strong>
                            <img src="http://images.d1.com.cn/images2012/New/gds_star<%=comment.getGdscom_level() %>.gif" />
                            <%if(lUser!=null&&lUser.getMbrmst_uid().trim().equals("gjltest")){ %>
					                           <a href="javascript:void(0)" attr="<%=comment.getId()%>" onclick="comsup(this)">隐藏</a>
					                            <%} %>
                            </div>
                            
                            <div style="float:right"><span class="date-comment">
                           <%=Tools.stockFormatDate(comment.getGdscom_createdate()) %>
                            </span></div>
                            
                        </div>
                        <div class="o-topic" style="border:none;" >
                             <div style="line-height:26px;" class="comment-content">
                                 <dl>
                                    <dd><%=comment.getGdscom_content() %></dd>
                                  </dl>
                             </div>
                                <%
                                Product product = ProductHelper.getById(comment.getGdscom_gdsid());
					                        if((product.getGdsmst_rackcode().startsWith("020")|| product.getGdsmst_rackcode().startsWith("030")) && !Tools.isNull(product.getGdsmst_skuname1()) && !Tools.isNull(comment.getGdscom_sku1())){
					                        	String h="";
					                        	String w="";
					                        	String c="";
					                        	if(!Tools.isNull(comment.getGdscom_height())){
					                        		h=comment.getGdscom_height()+"cm";
					                        	}
					                        	if(!Tools.isNull(comment.getGdscom_weight())){
					                        		w=comment.getGdscom_weight()+"kg";
					                        	}
					                        	//System.out.println(comment.getGdscom_comp()+"zzzzzzzzzzzzzzzz");
					                        	if("1".equals(comment.getGdscom_comp().trim())){
					                        		c="合适";
					                        	}
					                        	else if("2".equals(comment.getGdscom_comp().trim())){
					                        		c="偏大";
					                        	}
					                        	else if("3".equals(comment.getGdscom_comp().trim())){
					                        		c="偏小";
					                        	}
					                        	%>	
					                        	 <p style="color:black;padding-top:5px;">尺码：<%=comment.getGdscom_sku1() %>&nbsp;&nbsp;&nbsp;&nbsp;身高：<%=h %>&nbsp;&nbsp;&nbsp;&nbsp;体重：<%=w %>&nbsp;&nbsp;&nbsp;&nbsp;顾客认为：<%=c %></p>
					                       <% }
					                        %>
                        </div>
                       
                        <div class="comment-content">
                           <dl>
                           <dd>
                           <%
                            if(!Tools.isNull(comment.getGdscom_replyContent())){
                            	 %>	
                            	 <p style="color:#892D3D;line-height:26px;" >D1优尚回复：<%=comment.getGdscom_replyContent() %></p>
                          <%  }
                           %>
                            
                           </dd>
                           </dl>    
                        </div>
                        </div>
                        <div class="corner tl"></div>
                    </div>
                </div>
        </div>
			</td>
		</tr><%
	}
	if(pBean.getTotalPages()>1){ %>
	<tr>
		<td><div class="GPager">
           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="#cmtCnt" onclick="get_comment2('<%=gdsarrstr %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#cmtCnt" onclick="get_comment2('<%=gdsarrstr %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           		%><a href="#cmtCnt" onclick="get_comment2('<%=gdsarrstr %>',<%=i %>);"><%=i %></a><%
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="#cmtCnt" onclick="get_comment2('<%=gdsarrstr %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#cmtCnt" onclick="get_comment2('<%=gdsarrstr %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
           </div></td>
	</tr><%
	} %>
	</table><%
}else{
	%><div class="commentmore" id="commentmore" > 还没有会员进行评论。</div><%
}
%>