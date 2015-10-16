<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%><%!
static List getCommentList(String productId , int start , int length){
	if(Tools.isNull(productId)) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_gdsid", productId));
	listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
	listRes.add(Restrictions.ge("gdscom_level", new Long(4)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("gdscom_createdate"));
	
	return Tools.getManager(Comment.class).getList(listRes, listOrder, start, length);
}
static String getUid(String str){
	if(str==null)str="";
	String x = "***"+StringUtils.getCnSubstring(str,0,10);
	return x;
}
%>
<%
String tcode=request.getParameter("tcode");
String code=request.getParameter("code");
if(Tools.isNull(tcode) || Tools.isNull(code)){//头部图片
	out.print("{\"success\":false}");
	return;
}
String imgurl=PromotionHelper.getImgPromotion(tcode,1);
Map<String,Object> map = new HashMap<String,Object>();
StringBuilder sb = new StringBuilder();
if(!Tools.isNull(imgurl)){
	sb.append(imgurl);
	ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,20);
	if(list!=null && list.size()>0){
		map.put("success",new Boolean(true));
	
		 int icount=list.size();
         int num=0;
         String productid="";
         String url="";
		for(Promotion promotion:list){
			if(!Tools.isNull(promotion.getSplmst_url()) && !"#".equals(promotion.getSplmst_url())){
				url=promotion.getSplmst_url();
				productid=promotion.getSplmst_url().substring(promotion.getSplmst_url().lastIndexOf("/")+1);	
			}
			if(!Tools.isNull(productid)){
				sb.append("<table width='980' border='0' cellpadding='0' cellspacing='0' style='margin-top:10px;' class='line'>");
				sb.append(" <tr><td width='720' height='19' rowspan='2' align='right'>");
				sb.append(" <a href='").append(url).append("' target='_blank'><img src='").append(promotion.getSplmst_picstr()).append("' width='714' height='308' border=0/></a></td> <td width='260' height='50' align='center'><img src='http://images.d1.com.cn/zt2012/week0214/weekact_3.jpg' width='235' height='51'/></td></tr>");
				sb.append(" <tr><td><div id='scrollDiv").append(num).append("' class='scrollDiv'><ul>");
				 List commentlist =getCommentList(productid,0,100);
	        	  if (commentlist!=null && commentlist.size()>0){
	        		  for(int i=0;i<commentlist.size();i++){
	        			  Comment comment=(Comment)commentlist.get(i);
	        		  
	        	  User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
					String hfusername = getUid(comment.getGdscom_uid());
					String level = UserHelper.getLevelText(user);
					 String comment_content=comment.getGdscom_content();
					  if (comment_content.length()>22){
	                    	 comment_content= comment_content.substring(0, 22);
	                     } 
	        		sb.append("<li><div class=\"tail\"><div class='user'><div class='u-icon'><img src='").append(UserHelper.getLevelImage(level)).append("' width='63' height='63' /> </div></div>");  
	        		sb.append("<div class='u-txt' align='left' > <span>").append(hfusername).append("</span><br/><span >").append(comment_content).append("</span> </div></div></li>");
	        		}
	        	  }
	        	  sb.append(" <script>function AutoScroll(obj){$(obj).find(\"ul:first\").animate({marginTop:\"-46px\"},200,function(){$(this).css({marginTop:\"0px\"}).find(\"li:first\").appendTo(this);});}");
				  sb.append("$(document).ready(function(){setInterval('AutoScroll(\"#scrollDiv").append(num).append("\")',5000)});</script> ");
				  sb.append("</ul></div>");
				  sb.append("<div align=\"right\"><a href='").append(url).append("#cmt2' target='_blank' style=' font-size:14px; color:#A74053'>查看更多评论</a>&nbsp;&nbsp;&nbsp;&nbsp;</div></td>");
				  sb.append("</tr></table>");
				  num++;
			}
		}
	}
	map.put("content",sb.toString());
	out.print(JSONObject.fromObject(map));
}else{
	out.print("{\"success\":false}");
	return;
}

%>