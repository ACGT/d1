<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*"%>
<%!
   //根据推荐位号获取验证码
   public static String GetZtList(String code,int pageindex,int pagesize)
  {
	  StringBuilder sb=new StringBuilder();
	  ArrayList<PromotionProduct> list=new ArrayList<PromotionProduct>();
	  ArrayList<Product> rlist=new ArrayList<Product>();
	  list=PromotionProductHelper.getPromotionProductByCode(code);
	  if(list!=null&&list.size()>0)
	  {
		  for(PromotionProduct promotion:list)
		  {
			  if(promotion!=null)
			  {
				  Product p=ProductHelper.getById(promotion.getSpgdsrcm_gdsid());
				  if(p!=null&&p.getGdsmst_validflag().longValue()!=2&&p.getGdsmst_validflag().longValue()!=4)
				  {
					  rlist.add(p);
				  }
			  }
		  }
	  }
	  if(rlist!=null&&rlist.size()>0)
	  {
		  sb.append("<table>");
		  for(int i=(pageindex-1)*pagesize;i<pageindex*pagesize&&i<rlist.size();i++)
		  {
			Product p=rlist.get(i);
			long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
  			long currentTime = System.currentTimeMillis();
  			int score = CommentHelper.getLevelView(p.getId());
  			int comcount=CommentHelper.getCommentLength(p.getId());
  			double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
  			String theimgurl= p.getGdsmst_recimg();
  			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
  				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
  					}else{
  						theimgurl = "http://images.d1.com.cn"+theimgurl;
  					}
			String fl=ProductGroupHelper.getRoundPrice((float)dl);
			sb.append("<tr><td><a href=\"/wap/goods.jsp?productid=").append(p.getId()).append("\">").append(Tools.clearHTML(p.getGdsmst_gdsname())).append("</a></td></tr>");
  			sb.append("<tr><td><a href=\"/wap/goods.jsp?productid=").append(p.getId()).append("\"><img src=\"").append(theimgurl).append("\" width=\"120\" height=\"120\"/></a></td></tr>");
  			sb.append("<tr><td>");
  			if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
  				sb.append("<font color='#f00'>秒杀价：￥").append(p.getGdsmst_memberprice().longValue()).append("</font>");
  				sb.append("<font color='#f00'>原会员价：￥").append(p.getGdsmst_oldmemberprice().longValue()).append("&nbsp;&nbsp;折扣：").append(fl).append("</font>");
		    }
  			else
  			{
  			    sb.append("<font color='#f00'>会员价：￥").append(p.getGdsmst_memberprice().longValue()).append("&nbsp;&nbsp;折扣：").append(fl).append("</font>");
  			}
				sb.append("</td></tr>");
				sb.append("<tr><td  style=\" border-bottom:solid 1px #ccc;\"><span style=\"float:left;\">顾客评分：</span><span class=\"sa").append(score).append("\" style=\"float:left;\" ></span>(已有<a href=\"/wap/comment/commentlist.jsp?productid=").append(p.getId()).append("\">").append(comcount).append("</a>人评价)</td></tr>");
		  }
		  
		  sb.append("</table>");
	  }
	  return sb.toString();
  }



  //根据推荐位号获取数目
  public static int GetCount(String code)
  {
	  int result=0;
	  ArrayList<PromotionProduct> list=new ArrayList<PromotionProduct>();
	  ArrayList<Product> rlist=new ArrayList<Product>();
	  list=PromotionProductHelper.getPromotionProductByCode(code);
	  if(list!=null&&list.size()>0)
	  {
		  for(PromotionProduct promotion:list)
		  {
			  if(promotion!=null)
			  {
				  Product p=ProductHelper.getById(promotion.getSpgdsrcm_gdsid());
				  if(p!=null&&p.getGdsmst_validflag().longValue()!=2&&p.getGdsmst_validflag().longValue()!=4)
				  {
					  rlist.add(p);
				  }
			  }
		  }
	  }
	  if(rlist!=null&&rlist.size()>0)
	  {
		  result=rlist.size();
	  }
	  return result;
  }
  
%>