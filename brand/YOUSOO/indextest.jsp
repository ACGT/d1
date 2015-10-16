<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%!
/**
 * 获得服装图 240*300
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo240300(Product product){
	String img = (product != null ? product.getGdsmst_img240300() : null);
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
	
	return img;
}
    private static String  getCZlog(String code,int length)
    {
		StringBuilder sb = new StringBuilder();
		if(!Tools.isMath(code) || length<=0) return "";
		ArrayList<Promotion> list=new ArrayList<Promotion>();
		list=PromotionHelper.getBrandListByCode(code,length);
		if(list!=null&&list.size()>0&&list.get(0)!=null)
		{
			Promotion p=list.get(0);
			StringBuilder map=new StringBuilder();
			ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("promotionId", p.getId()));
			List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					piplist.add((PromotionImagePos)be);
				}
			}
			
			sb.append("<div class=\"gdscsne_logo\"><img src=\""+p.getSplmst_picstr()+"\" width=\"740\" height=\"478\"  usemap=\"#pimg_1\"/><div class=\"clear\"></div>");
			map.append("<map name=\"pimg_1\" id=\"").append("pimg_1\">");
			
			for(PromotionImagePos pip:piplist)
			{
				
				if(pip!=null)
				{
					
					int left=0;
					int top=0;
					//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
					left=pip.getPos_x()+10;
					if(left>400)
					{
						left=pip.getPos_x()-25;
					}
					top=pip.getPos_y()-35;
					int divtop=0;
					if(top+40>350)
					{
						divtop=350;
					}
					else
						divtop=top+40;
					
						
					map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\""); 
					Product product=ProductHelper.getById(pip.getProductId());
					if(product!=null)
					{
						map.append("href=\"").append("http://www.d1.com.cn/product/"+product.getId()).append("\" target=\"_blank\"");
					}
					map.append(">");
					
				}
			}
			sb.append("</div>");
			map.append("</map>");
			
			sb.append(map.toString());
		}
		return sb.toString();
		
}
private static String getResourse(String code,int count,int flag)
{
    StringBuilder sb=new StringBuilder();
    if(code==null||!Tools.isNumber(code)){ return "";}
    ArrayList<Promotion> plist=new ArrayList<Promotion>();
    plist=PromotionHelper.getBrandListByCode(code, count);
    if(plist!=null&&plist.size()>0)
    {
    	sb.append("<ul>");
    	int sum=0;
    	for(Promotion p:plist)
    	{
    		if(p!=null)
    		{
    			sum++;
    			if(flag==1&&sum%3==0){
    			  sb.append("<li style=\"margin-right:0px\">");
    			}
    			else
    			{
    				sb.append("<li>");
    			}
    			sb.append("<a href=\"").append(p.getSplmst_url().replace("http://www.d1.com.cn/brand/YOUSOO/result.jsp", "http://yousoo.d1.com.cn/ysresult.htm").replace("http://www.d1.com.cn/brand/YOUSOO/result_rec.jsp", "http://yousoo.d1.com.cn/ysresult_rec.htm")).append("\" target=\"_blank\">");
    			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/></a></li>");
    		}
    	}
    	sb.append("</ul>");
    }
    return sb.toString();
}
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
//获取推荐商品
private static String getProduct(String code,int count)
{
	if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
	StringBuilder sb=new StringBuilder();

	ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
	pplist=PromotionProductHelper.getPProductByCode(code, count);
	if(pplist!=null&&pplist.size()>0)
	{
		int counts=0;
		 sb.append("<div class=\"newlist\"><table><tr><td>");
	 sb.append("<ul>");
	 for(PromotionProduct pp:pplist)
	 {
		 if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
			 {
			 counts++;
			Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
				{
	      		   String title = Tools.clearHTML(p.getGdsmst_gdsname()).trim();
	           	   String id = p.getId();
	           	   long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
	           	   long currentTime = System.currentTimeMillis();
	           	   if(counts%3==0){
		           	 sb.append("<li style=\" width:240px; height:440px; margin-right:0px;\">");
		           	}
		           	else
		           	{
		           	 sb.append("<li style=\" width:240px; height:440px;\">");
		           	}
	           	   sb.append("<div class=\"lf\">");
	           	   //if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
	   	           	  //sb.append("<a href=\""+ProductHelper.getProductUrl(p)+"\" ><img src=\"http://images.d1.com.cn/images2010/tejia2.gif\" class=\"di\" /></a>");
	   	           // } 
	           	   sb.append("<p style=\"z-index:999;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
	   	           sb.append("<img src=\""+ getImageTo240300(p)+"\" width=\"240\" height=\"300\" />");
	   	           sb.append("</a></p>");
	   	           //每个商品对应的搭配列表
             ArrayList<Gdscoll> gdscolllist=getGdscollByGdsid(p.getId()); 
				      if(gdscolllist!=null&&gdscolllist.size()>0)
				      {
				    	sb.append("<div style=\"position:absolute; margin-top:-46px; +margin-top:-15px; \" onmouseover=\"mdm_over('"+p.getId()+"','"+ counts+"')\" onmouseout=\"mdm_out('"+ p.getId()+"','"+counts+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/da1.png\"/></div>");

				     }
				   sb.append("</p>");
	   	           sb.append("<p style=\"height:35px; font-size:13px; color:#999999; \">");
	   	           sb.append("<span class=\"newspan\">");
	   	           if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
		   	    	 sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		   	    	 sb.append("<font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(p.getGdsmst_oldmemberprice())+"</font>");
				       
	   	           }
		   	       else
		   	       {
		   	           sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		                  }
	   	           sb.append("</span>");
	               sb.append("<span class=\"newspan1\"><a href=\"/product/"+p.getId()+"#cmt2\" target=\"_blank\">评论("+CommentHelper.getCommentLength(p.getId())+")</a></span>");
	               sb.append("</p>");
	           	   sb.append("</div><p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" ><a href=\"").append(ProductHelper.getProductUrl(p)).append("\" target=\"_blank\" style=\"font-size:12px; color:#606060; \">").append(StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,54)).append("</a></p><div class=\"clear\"></div>");	   
	           	   Comment com=null;
	                List<Comment> list= CommentHelper.getCommentList(id,0,1000);
	                if(list!=null&&list.size()>0)
	                {
	                	for(Comment c:list)
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
	                		for(Comment c:list)
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
	                			for(Comment c:list)
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
	                  if(com!=null)
	                  {
	                	  sb.append("<div class=\"lb\" title=\""+ com.getGdscom_content()+"\"><b>"+CommentHelper.GetCommentUid(com.getGdscom_uid())+"：</b>"+ StringUtils.getCnSubstring(com.getGdscom_content(),0,45)+ "</div>");
	                  }
	                  else
	                  {
	                	  sb.append("<div class=\"lb\" ><b>暂无评论！！！</b></div>");  
	                  }
	                  if(gdscolllist!=null&&gdscolllist.size()>0)
	                  {
	                   sb.append("<div  id=\"floatdp"+p.getId()+counts+"\" onmouseover=\"mdmover('"+ p.getId()+"','"+counts+"')\" onmouseout=\"mdm_out('"+ p.getId()+"','"+counts+"')\"></div>");
	                   sb.append("<div id=\"price"+p.getId()+counts+"\" class=\"dpprice\" onmouseover=\"mdmover('"+ p.getId()+"','"+counts+"')\" onmouseout=\"mdm_out('"+ p.getId()+"','"+counts+"')\">");
                 sb.append("<table width=\"100%\"><tr><td> <br/>");
                 sb.append("<font style=\"text-align:left; font-size:12px; color:#ca0000;display:block; width:90%; font-weight:bold; margin:0px auto;\">   说明：<br/>&nbsp;&nbsp;&nbsp;&nbsp;两件或两件以上95折</font>  <br/>");
                 sb.append("<font style=\"color:#333; font-size:14px; font-weight:bold;\">共&nbsp;<em id=\"count_"+p.getId()+"_"+counts+"\">0</em>&nbsp;件&nbsp;&nbsp;组合购买</font><br/>");
                 sb.append("<br><strike>总价：￥&nbsp;<em id=\"totalmoney_"+p.getId()+"_"+counts+"\">0.0</em>&nbsp;元  </strike>");
			           sb.append("<br>组合价：<font color=\"#bc0000\" face=\"微软雅黑\">￥&nbsp;<em id=\"money_"+p.getId()+"_"+counts+"\">0.0</em>&nbsp;</font>元<br>");
			           sb.append("共优惠：￥&nbsp;<em id=\"cheap_"+p.getId()+"_"+counts+"\">0.0</em>&nbsp;元  <br><br>");
			           sb.append("<a href=\"javascript:void(0)\" onclick=\"AddInCart(this)\" flag=\""+counts+"\" id=\""+p.getId()+"\"><img src=\"http://images.d1.com.cn/Index/images/ljgmzh.png\" />  </a><br/> ");
			           sb.append("<br/></td></tr></table></div>");	                  
	                  }
	                  sb.append("</li>");
		 }
		}
	 }   	 
	 sb.append("</ul></td></tr></table>");
	 sb.append("</div>");
	}	
	return sb.toString();
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【yousoo】_yousoo官网_D1优尚网旗下品牌</title>
<meta name="description" content="D1优尚网是国内唯一在线销售YOUSOO商品，提供YOUSOO产品的最新报价、YOUSOO评论、YOUSOO导购、YOUSOO图片等相关信息" />
<meta name="keywords" content=" YOUSOO, YOUSOO网购" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/subpage.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/yousoo.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
</head>

<body >
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->


    <!-- 中间位置 -->
    <div class="middle">
        <div class="middle_top">
           <div style="width:980px; margin:0px auto;">
              <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_03.jpg"/>
              <div class="ysdh">
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/"   style="background:#6e6a78; color:#fff;">商品分类</a></span>
                <span style=" width:125px;"><a href="http://yousoo.d1.com.cn/yscxsp.htm" >畅销商品</a></span>
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/ys/brandstory.htm"  >品牌故事</a></span>
               
                 <div class="clear"></div>
              </div>
           </div>
           </div>
           <div class="middle_center">
              <div class="mleft">
                  <table>
                      <tr>
                          <td  style="padding-left:24px;">
                              <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_08.jpg"/>
                                  <%=getResourse("3090",15,0) %>
                              </div>
                              <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_22.jpg"/>
                                 <%=getResourse("3091",15,0) %>
                              </div>
                               <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_28.jpg"/>
                                  <%=getResourse("3092",15,0) %>
                              </div>
                               <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_35.jpg"/>
                                  <%=getResourse("3093",15,0) %>
                              </div>
                          </td>
                      </tr>
                  </table>
              </div>
              
              
              <div class="mright">
	              <script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/YSImgScoll.js")%>"></script>
	              <div class="scrollimglist">       
	                <script>ShowCenter(<%= ScrollImg("3094") %>,<%= ScrollText("3094") %>)</script>
	              </div>
	              <div style="margin-top:10px;" class="rxtj">
	                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_01_1.jpg"/>
	                  <%= getResourse("3095",6,1) %>
	              </div>
	              <%=getCZlog("3096",1) %>
	               <div style="margin-top:10px;" class="xpss">
	                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_33_1.jpg"/>
	              <div class="newlist">
	               <%=getProduct("7785",12)  %>
	                  </div>
	              </div>
	              
	              
              </div>
              
           </div>
           
           <div class="clear">
                   
           </div>
    </div>
    <!-- 中间位置结束 -->
    <%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">

$(document).ready(function() {
    //$(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
