<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,com.d1.comp.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,com.d1.util.*,com.d1.dbcache.core.BaseEntity,org.hibernate.criterion.*,org.hibernate.*,java.text.*"%>
<%!
//获取某一分类最新的商品
private ArrayList<Product> getNewProduct(String rackcode,int length)
{
	ArrayList<Product> list=new ArrayList<Product>();	
	if(rackcode.indexOf(",")>-1){
		rackcode.replace("，", ",");
		String[] stra=rackcode.split(",");
		for(int i=0;i<stra.length;i++)
		{
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.like("gdsmst_rackcode", stra[i]+"%"));
			clist.add(Restrictions.eq("gdsmst_ifhavegds",new Long(0)));
			if(stra[i].startsWith("015002"))
			{
				clist.add(Restrictions.ne("gdsmst_rackcode","015002003050"));
			}
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("gdsmst_createdate"));
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,length+10);
			if(b_list==null||b_list.size()==0)return null;
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}	
		}
	}
	else
	{	
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", rackcode+"%"));
		clist.add(Restrictions.eq("gdsmst_ifhavegds",new Long(0)));
		if(rackcode.startsWith("015002"))
		{
			clist.add(Restrictions.ne("gdsmst_rackcode","015002003050"));
		}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,length+10);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
	}
	Collections.sort(list,new CreateTimeComparator());
	Collections.reverse(list);
    return list;	
}


//获取某一分类最新的商品
private ArrayList<Product> getNewProduct1(String rackcode,int length)
{
	ArrayList<Product> list=new ArrayList<Product>();	
	if(rackcode.indexOf(",")>-1){
		rackcode.replace("，", ",");
		String[] stra=rackcode.split(",");
		for(int i=0;i<stra.length;i++)
		{
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.like("gdsmst_rackcode", stra[i]+"%"));
			clist.add(Restrictions.eq("gdsmst_ifhavegds",new Long(0)));
			if(stra[i].startsWith("015002"))
			{
				clist.add(Restrictions.ne("gdsmst_rackcode","015002003050"));
			}
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("gdsmst_salecount"));
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,length+10);
			if(b_list==null||b_list.size()==0)return null;
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}	
		}
	}
	else
	{	
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", rackcode+"%"));
		clist.add(Restrictions.eq("gdsmst_ifhavegds",new Long(0)));
		if(rackcode.startsWith("015002"))
		{
			clist.add(Restrictions.ne("gdsmst_rackcode","015002003050"));
		}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_salecount"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,length+10);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
	}
	//Collections.sort(list,new SalesComparator());
	//Collections.reverse(list);
  return list;	
}



//获取商品别表
private  String getProductlist(String code,int length)
{
    StringBuilder sb=new StringBuilder();
    int l=length;
    ArrayList<Product> plist=getNewProduct(code,length);
    if(plist!=null&&plist.size()>0)
    {
    	int count=0;
    	sb.append("<div class=\"newlist\" ><table><tr><td><ul>");
    	for(Product goods : plist){
    		count++;
    		if(plist.size()%4>0&&plist.size()%4<=2)
    		{
    			if(plist.size()<length){
    			  l=plist.size()-(plist.size()%4);
    			}
    			
    		}
    		
    		if(count>l){ break;}
    		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
    		String ids = goods.getId();
    		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
    		long currentTimes = System.currentTimeMillis();
    		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
    		if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
    		{
    			sb.append("<li style=\"height:384px;\">");
    			sb.append("<div class=\"lf\">");
    			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
    			
    			sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
    		}
    		else
    		{
    			sb.append("<li style=\"height:324px;\">");
    			sb.append("<div class=\"lf\">");
    			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
    			
    			sb.append("<img src=\""+ ProductHelper.getImageTo400(goods)+"\" width=\"240\" height=\"240\"  alt=\""+Tools.clearHTML(goods.getGdsmst_gdsname())+"\"/>");
    		}
    		sb.append("</a> ");
    		sb.append("</p>");
    		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
    		sb.append("<span class=\"newspan\">");
    		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
    			sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
    			sb.append("<font>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</font>");
    		}else{
    			sb.append(" <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
    		}
    		sb.append(" </span>	");
    		sb.append("<span class=\"newspan1\"> <font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(goods.getGdsmst_saleprice().floatValue())+"</font></span>");
    		sb.append(" </p>");          
    		sb.append("</div>");    
    		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
    		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
    		sb.append("<div class=\"clear\"></div> "); 
    		sb.append("</li>");
    	}
    	
    	sb.append("</ul></td></tr></table></div>");    	
    	
    }
    return sb.toString();
}


/**
 * 根据分组对象获得此物品的所在分组的列表
 * @param GoodsGroup - 分组对象
 * @return List<GoodsGroupDetail>
 */
public static List<GoodsGroupDetail> getGroupDetail(GoodsGroup gg){
	if(gg == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(gg.getId())));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
	
	if(list == null || list.isEmpty()) return null;
	
	int size = list.size();
	
	List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
	for(int i=0;i<size;i++){
		GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
		Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		if(goods == null) continue;
		
		ggdList.add(ggd);
	}
	//只有一件物品了，也就没必要显示出来了。
	if(ggdList.size() <= 1) return null;
	
	return ggdList;
}

/**
 * 根据物品对象获得物品所在的组
 * @param product - 物品对象
 * @return GoodsGroup
 */
public static GoodsGroup getGroup(Product product){
	if(product == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_gdsid", product.getId()));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 1);
	
	if(list == null || list.isEmpty()) return null;
	
	GoodsGroupDetail gd = (GoodsGroupDetail)list.get(0);
	
	long ggId = Tools.longValue(gd.getGdsgrpdtl_mstid());
	if(ggId <= 0) return null;
	
	return (GoodsGroup)Tools.getManager(GoodsGroup.class).get(String.valueOf(ggId));
}
private String getprec(String code){
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	sb.append("<div class=\"newlist\" ><table><tr><td><ul>");
	List<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code, 20);
	if(list!=null&&list.size()>0)
	{
		int j=1;
		for(int i=0;i<list.size();i++)
		{
			PromotionProduct p=list.get(i);
			Product goods=ProductHelper.getById(p.getSpgdsrcm_gdsid());
			//if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			if(!ProductHelper.isNormal(goods)) continue;
			if(j>8) continue;
	  		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
	  		String ids = goods.getId();
	  		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
	  		long currentTimes = System.currentTimeMillis();
	  		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
	  		if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
			{
				sb.append("<li style=\"height:384px;\">");
				sb.append("<div class=\"lf\">");
				sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
				
				sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
			}
			else
			{
				sb.append("<li style=\"height:324px;\">");
				sb.append("<div class=\"lf\">");
				sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
				
				sb.append("<img src=\""+ ProductHelper.getImageTo400(goods)+"\" width=\"240\" height=\"240\"  alt=\""+Tools.clearHTML(goods.getGdsmst_gdsname())+"\"/>");
			}
	  		sb.append("</a> ");
	  		sb.append("</p>");
	  		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
	  		sb.append("<span class=\"newspan\">");
	  		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
	  			sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
	  			sb.append("<font>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</font>");
	  		}else{
	  			sb.append(" <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
	  		}
	  		sb.append(" </span>	");
	  		sb.append("<span class=\"newspan1\"> <font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(goods.getGdsmst_saleprice().floatValue())+"</font></span>");
	  		sb.append(" </p>");          
	  		sb.append("</div>");    
	  		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
	  		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
	  		sb.append("<div class=\"clear\"></div> "); 
	  		sb.append("</li>");
	  		 j=j+1;
	  	}
	  	
	  	sb.append("</ul></td></tr></table></div>");    	
	    
	  }
	  return sb.toString();
}

//获取商品别表（排除同颜色的商品）
private  String getProductlist1(String code,int length)
{
  StringBuilder sb=new StringBuilder();
  ArrayList<Product> plist1=getNewProduct(code,100);
  ArrayList<Product> plist2=new ArrayList<Product>();
  ArrayList<GoodsGroup> gglist=new ArrayList<GoodsGroup>();
  if(plist1!=null&&plist1.size()>0)
  {
	  HashMap<String, GoodsGroup> map=new HashMap<String, GoodsGroup>();
	  for(Product p:plist1)
	  {		 
		  GoodsGroup gg=getGroup(p);
		  if(gg!=null)
		  {			
		     map.put(gg.getId(), gg);
		  }
	  }
	  if(map!=null && !map.isEmpty())
	  {
		  List<Map.Entry<String, GoodsGroup>> infoIds =
				    new ArrayList<Map.Entry<String, GoodsGroup>>(map.entrySet()); 
	  for(Product p:plist1)
	  {
		  if(p!=null)
		  {
			   GoodsGroup gg=getGroup(p);
			   if(gg!=null)
			   {
				   if(infoIds!=null&&infoIds.size()>0)
				   {
					  
					   for(int i=0;i<infoIds.size();i++)						   
					   {	
						   if(infoIds.get(i).getKey().toString().trim().equals(gg.getId()))							   
						   {				  
						       boolean flag=false;//是否已经做个这个颜色组的删除
							   if(gglist!=null&&gglist.size()>0)
							   {
								   
								   
								   for(GoodsGroup ggs:gglist)
								   {
									   if(gg.getId().trim().equals(ggs.getId().trim()))
									   {										   
										   flag=true;
										   break;
									   }
								   }
							   }
						       if(!flag){
								   gglist.add(infoIds.get(i).getValue());								   
								   List<GoodsGroupDetail> ggdlist=getGroupDetail(infoIds.get(i).getValue());
								   if(ggdlist!=null&&ggdlist.size()>0)
								   {
									   for(GoodsGroupDetail ggd:ggdlist)
									   {
										   if(!ggd.getGdsgrpdtl_gdsid().trim().equals(p.getId()))
										   {
											   Product pp=ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
											   plist2.add(pp);
										   }
										   
									   }
								   }
						       }
							   
						   }
						   
						   
					   }
				   }				   
			   }
			 
		  }
		  if(plist2.size()>=(100-length))
		   {
			   break;
		   }
	  }
   }
  }

  ArrayList<Product> plist=new ArrayList<Product>();
  if(plist1!=null&&plist1.size()>0)
  {
       for(Product p1:plist1)
       {
    	   boolean ff=false;
    	   if(p1!=null)
    	   {
    		   if(plist2!=null&&plist2.size()>0){
	    		   for(Product p2:plist2)
	    		   {
	    			   if(p1.getId().trim().equals(p2.getId().trim()))
	    			   {
	    				   ff=true;
	    				   break;
	    			   }
	    		   }
	    		   if(!ff)
	    		   {
	    			   plist.add(p1);
	    		   }
    		   }
    		   else
    		   {
    			   plist.add(p1);
    		   }
    	   }
    	   if(plist.size()>length){break;}
       }
      
  }
  
  if(plist!=null&&plist.size()>0)
  {
  	int count=0;
  	int l=length;
  	sb.append("<div class=\"newlist\" ><table><tr><td><ul>");
  	for(Product goods : plist){
  		count++;
  		if(plist.size()%4>0&&plist.size()%4<=2)
		{
  			if(plist.size()<length){
  			  l=plist.size()-(plist.size()%4);
  			}
  			
		}
		if(count>l){ break;}
  		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
  		String ids = goods.getId();
  		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
  		long currentTimes = System.currentTimeMillis();
  		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
  		if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
		{
			sb.append("<li style=\"height:384px;\">");
			sb.append("<div class=\"lf\">");
			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
			
			sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
		}
		else
		{
			sb.append("<li style=\"height:324px;\">");
			sb.append("<div class=\"lf\">");
			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
			
			sb.append("<img src=\""+ ProductHelper.getImageTo400(goods)+"\" width=\"240\" height=\"240\"  alt=\""+Tools.clearHTML(goods.getGdsmst_gdsname())+"\"/>");
		}
  		sb.append("</a> ");
  		sb.append("</p>");
  		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
  		sb.append("<span class=\"newspan\">");
  		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
  			sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
  			sb.append("<font>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</font>");
  		}else{
  			sb.append(" <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
  		}
  		sb.append(" </span>	");
  		sb.append("<span class=\"newspan1\"> <font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(goods.getGdsmst_saleprice().floatValue())+"</font></span>");
  		sb.append(" </p>");          
  		sb.append("</div>");    
  		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
  		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
  		sb.append("<div class=\"clear\"></div> "); 
  		sb.append("</li>");
  	}
  	
  	sb.append("</ul></td></tr></table></div>");    	
  	
  }
  return sb.toString();
}


//获取商品别表 按照销量排序
private  String getProductlist2(String code,int length)
{
  StringBuilder sb=new StringBuilder();
  int l=length;
  ArrayList<Product> plist=getNewProduct1(code,length);
  if(plist!=null&&plist.size()>0)
  {
  	int count=0;
  	sb.append("<div class=\"newlist\" ><table><tr><td><ul>");
  	for(Product goods : plist){
  		count++;
  		if(plist.size()%4>0&&plist.size()%4<=2)
		{
  			if(plist.size()<length){
  			  l=plist.size()-(plist.size()%4);
  			}
  			
		}
		if(count>l){ break;}
  		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
  		String ids = goods.getId();
  		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
  		long currentTimes = System.currentTimeMillis();
  		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
  		if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
		{
			sb.append("<li style=\"height:384px;\">");
			sb.append("<div class=\"lf\">");
			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
			
			sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
		}
		else
		{
			sb.append("<li style=\"height:324px;\">");
			sb.append("<div class=\"lf\">");
			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
			
			sb.append("<img src=\""+ ProductHelper.getImageTo400(goods)+"\" width=\"240\" height=\"240\"  alt=\""+Tools.clearHTML(goods.getGdsmst_gdsname())+"\"/>");
		}
  		sb.append("</a> ");
  		sb.append("</p>");
  		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
  		sb.append("<span class=\"newspan\">");
  		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
  			sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
  			sb.append("<font>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</font>");
  		}else{
  			sb.append(" <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
  		}
  		sb.append(" </span>	");
  		sb.append("<span class=\"newspan1\"> <font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(goods.getGdsmst_saleprice().floatValue())+"</font></span>");
  		sb.append(" </p>");          
  		sb.append("</div>");    
  		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
  		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
  		sb.append("<div class=\"clear\"></div> "); 
  		sb.append("</li>");
  	}
  	
  	sb.append("</ul></td></tr></table></div>");    	
  	
  }
  return sb.toString();
}



//获取商品别表（排除同颜色的商品）按照销量排序
private  String getProductlist3(String code,int length)
{
StringBuilder sb=new StringBuilder();
ArrayList<Product> plist1=getNewProduct1(code,100);
ArrayList<Product> plist2=new ArrayList<Product>();
ArrayList<GoodsGroup> gglist=new ArrayList<GoodsGroup>();
if(plist1!=null&&plist1.size()>0)
{
	  HashMap<String, GoodsGroup> map=new HashMap<String, GoodsGroup>();
	  for(Product p:plist1)
	  {		 
		  GoodsGroup gg=getGroup(p);
		  if(gg!=null)
		  {			
		     map.put(gg.getId(), gg);
		  }
	  }
	  if(map!=null && !map.isEmpty())
	  {
		  List<Map.Entry<String, GoodsGroup>> infoIds =
				    new ArrayList<Map.Entry<String, GoodsGroup>>(map.entrySet()); 
	  for(Product p:plist1)
	  {
		  if(p!=null)
		  {
			   GoodsGroup gg=getGroup(p);
			   if(gg!=null)
			   {
				   if(infoIds!=null&&infoIds.size()>0)
				   {
					  
					   for(int i=0;i<infoIds.size();i++)						   
					   {	
						   if(infoIds.get(i).getKey().toString().trim().equals(gg.getId()))							   
						   {				  
						       boolean flag=false;//是否已经做个这个颜色组的删除
							   if(gglist!=null&&gglist.size()>0)
							   {
								   
								   
								   for(GoodsGroup ggs:gglist)
								   {
									   if(gg.getId().trim().equals(ggs.getId().trim()))
									   {										   
										   flag=true;
										   break;
									   }
								   }
							   }
						       if(!flag){
								   gglist.add(infoIds.get(i).getValue());								   
								   List<GoodsGroupDetail> ggdlist=getGroupDetail(infoIds.get(i).getValue());
								   if(ggdlist!=null&&ggdlist.size()>0)
								   {
									   for(GoodsGroupDetail ggd:ggdlist)
									   {
										   if(!ggd.getGdsgrpdtl_gdsid().trim().equals(p.getId()))
										   {
											   Product pp=ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
											   plist2.add(pp);
										   }
										   
									   }
								   }
						       }
							   
						   }
						   
						   
					   }
				   }				   
			   }
			 
		  }
		  if(plist2.size()>=(100-length))
		   {
			   break;
		   }
	  }
 }
}

ArrayList<Product> plist=new ArrayList<Product>();
if(plist1!=null&&plist1.size()>0)
{
     for(Product p1:plist1)
     {
  	   boolean ff=false;
  	   if(p1!=null)
  	   {
  		   if(plist2!=null&&plist2.size()>0){
	    		   for(Product p2:plist2)
	    		   {
	    			   if(p1.getId().trim().equals(p2.getId().trim()))
	    			   {
	    				   ff=true;
	    				   break;
	    			   }
	    		   }
	    		   if(!ff)
	    		   {
	    			   plist.add(p1);
	    		   }
  		   }
  		   else
  		   {
  			   plist.add(p1);
  		   }
  	   }
  	   if(plist.size()>length){break;}
     }
    
}
int l=length;
if(plist!=null&&plist.size()>0)
{
	int count=0;
	sb.append("<div class=\"newlist\" ><table><tr><td><ul>");
	for(Product goods : plist){
		count++;
		if(plist.size()%4>0&&plist.size()%4<=2)
		{
			if(plist.size()<length){
  			  l=plist.size()-(plist.size()%4);
  			}
  			
		}
		if(count>l){ break;}
		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		String ids = goods.getId();
		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
		long currentTimes = System.currentTimeMillis();
		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
		if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
		{
			sb.append("<li style=\"height:384px;\">");
			sb.append("<div class=\"lf\">");
			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
			
			sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
		}
		else
		{
			sb.append("<li style=\"height:324px;\">");
			sb.append("<div class=\"lf\">");
			sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
			
			sb.append("<img src=\""+ ProductHelper.getImageTo400(goods)+"\" width=\"240\" height=\"240\"  alt=\""+Tools.clearHTML(goods.getGdsmst_gdsname())+"\"/>");
		}
		sb.append("</a> ");
		sb.append("</p>");
		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
		sb.append("<span class=\"newspan\">");
		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
			sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
			sb.append("<font>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</font>");
		}else{
			sb.append(" <font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		}
		sb.append(" </span>	");
		sb.append("<span class=\"newspan1\"> <font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(goods.getGdsmst_saleprice().floatValue())+"</font></span>");
		sb.append(" </p>");          
		sb.append("</div>");    
		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
		sb.append("<div class=\"clear\"></div> "); 
		sb.append("</li>");
	}
	
	sb.append("</ul></td></tr></table></div>");    	
	
}
return sb.toString();
}

%>