<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.*,com.d1.manager.*,com.d1.helper.*,java.util.*,com.d1.*,com.d1.dbcache.core.*,org.hibernate.criterion.*,com.d1.util.*"%>
<%@include file="/html/getComment.jsp" %>
<%!

private static String getProduct(String code,int count)
{
	StringBuilder sb=new StringBuilder();
    if(code==null||!Tools.isNumber(code)){ return "";}
    ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
    pplist=PromotionProductHelper.getPProductByCode(code, count);
    if(pplist!=null&&pplist.size()>0)
    {
    	sb.append("<ul>");
    	int sum=0;
    	for(PromotionProduct pp:pplist)
    	{
    		if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0)
    		{
    			Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
    			if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0){
    		        sum++;
    		        long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
		           	   long currentTime = System.currentTimeMillis();
    		        if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
		   			   {
    		        	sb.append("<li style=\" width:240px; height:437px;\">");
		   	           }
		           	   else
		           	   {
		           		sb.append("<li style=\"width:240px;height:437px;\">");
		           	  }
    		        String imgurl= p.getGdsmst_img240300()!=null&&p.getGdsmst_img240300().length()>0?"http://images.d1.com.cn"+p.getGdsmst_img240300():ProductHelper.getImageTo200(p);
	                sb.append(" <div class=\"lf\">");
	                sb.append("<p style=\"z-index:999;\"><a href=\"http://www.d1.com.cn/product/").append(p.getId()).append("\" target=\"_blank\">");
    		        sb.append("<img src=\"").append(imgurl).append("\" width=\"240\" height=\"300\"/>  ");
    		        sb.append("</a></p>");
    		        ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(p.getId()); 
				      if(gdscolllist!=null&&gdscolllist.size()>0)
				      {
				    	  sb.append("<div style=\"position:absolute; margin-top:-47px; +margin-top:-49px; \" onmouseover=\"mdm_over('"+p.getId()+"','"+sum+"')\" onmouseout=\"mdm_out('"+p.getId()+"','"+sum+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/da1.png\"/></div>");
                    }
    		       
    		        sb.append(" <p style=\"height:35px; font-size:13px; color:#999999; \">");
    		        sb.append("<span class=\"newspan\">");
    		        if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
		   	    	sb.append("   <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价：￥"+Tools.getFormatMoney(p.getGdsmst_memberprice().floatValue())+"</b></font>&nbsp;&nbsp;");
		   	          sb.append("<font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(p.getGdsmst_saleprice().floatValue())+"</font>");
		   	       }
		   	       else
		   	       {
		   	    	  sb.append(" <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice().floatValue())+"</b></font>&nbsp;&nbsp;");
		   	          
		           }
    		        sb.append("</span><span class=\"newspan1\"><a href=\"http://www.d1.com.cn/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">");
    		        sb.append("评论("+getCommentList(p.getId()).size()+")</a></span></p>");
    		       // sb.append("</div>");
    		        sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" > <a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">").append(StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,54)).append("</a></p>");
    		        sb.append("<div class=\"clear\"></div>");
    		        Comment com=null;
    		        List<Comment> list= CommentHelper.getCommentListByLevel(p.getId(),0,1);
                    if(list!=null&&list.size()>0&&list.get(0)!=null)
                    {
                    	com=list.get(0);
                    }
                      if(com!=null)
                      {
                    	sb.append("<div class=\"lb\" title=\""+ com.getGdscom_content() +"\"><b>"+ CommentHelper.GetCommentUid(com.getGdscom_uid())+"：</b><a href=\"/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">"+ StringUtils.getCnSubstring(com.getGdscom_content(),0,45)+ "</a></div>");
                      }
                      else
                      {
                    	sb.append("<div class=\"lb\" ><b>暂无评论！！！</b></div>");  
                      }
                      if(gdscolllist!=null&&gdscolllist.size()>0)
	                  {

                    	  sb.append("<div  id=\"floatdp"+p.getId()+sum+"\"" );
                    	  sb.append(" onmouseover=\"mdmover('"+p.getId()+"','"+sum+"')\" onmouseout=\"mdm_out('"+p.getId()+"','"+sum+"')\"></div>");
	                  } 
    		        sb.append("</li>");
			       
    			}
    		}
    	}
    	sb.append("</ul>");
    }
    
    return sb.toString();
}
%>