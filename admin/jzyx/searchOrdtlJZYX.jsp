<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%!
//一个月内购买过系列服装的用户
static ArrayList<Odrdtl_User> getOrdtlUser(String brandname,String gdsscoll){ 
	ArrayList<Odrdtl_User> list=new ArrayList<Odrdtl_User>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			if(!Tools.isNull(brandname)){
				clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			}
			if(!Tools.isNull(gdsscoll)){
				clist.add(Restrictions.eq("gdsmst_gdscoll", gdsscoll));
			}
			
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("odrmst_mbrid"));
			List<BaseEntity> b_list = Tools.getManager(Odrdtl_User.class).getList(clist, olist, 0, 1);
			
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Odrdtl_User)be);
				}
			}	
	return list;
}
//购买的分类
static ArrayList<OdrdtlRck> getOrdtlRck(String brandname,String gdsscoll,Long mbrid){ 
	ArrayList<OdrdtlRck> list=new ArrayList<OdrdtlRck>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			if(mbrid!=null){
				clist.add(Restrictions.eq("odrmst_mbrid", mbrid));
			}
			if(!Tools.isNull(brandname)){
				clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			}
			if(!Tools.isNull(gdsscoll)){
				clist.add(Restrictions.eq("gdsmst_gdscoll", gdsscoll));
			}
			
			
			List<BaseEntity> b_list = Tools.getManager(OdrdtlRck.class).getList(clist, null, 0, 20);
			
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((OdrdtlRck)be);
				}
			}	
	return list;
}


static ArrayList<OdrdtlJZYX> getOrdtl(String brandname,String gdsscoll,Long mbrid,String rackcode,int num){ 
	ArrayList<OdrdtlJZYX> list=new ArrayList<OdrdtlJZYX>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			if(!Tools.isNull(brandname)){
				clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			}
			if(!Tools.isNull(gdsscoll)){
				clist.add(Restrictions.eq("gdsmst_gdscoll", gdsscoll));
			}
			if(mbrid!=null){
				clist.add(Restrictions.eq("odrmst_mbrid", mbrid));
			}
			if(!Tools.isNull(rackcode)){
				clist.add(Restrictions.eq("gdsmst_rackcode", rackcode));
			}
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("odrmst_mbrid"));
			List<BaseEntity> b_list = Tools.getManager(OdrdtlJZYX.class).getList(clist, olist, 0, num);
			
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((OdrdtlJZYX)be);
				}
			}	
	return list;
}
static ArrayList<Product> getProduct(Date s,Date e,String brandname,String gdsser,String rackcode){ 
	ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			if(!Tools.isNull(brandname)){
				clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			}
			if(s!=null){
				clist.add(Restrictions.ge("gdsmst_autoupdatedate", s));
			}
			if(e!=null){
				clist.add(Restrictions.le("gdsmst_autoupdatedate", e));
			}
			if(!Tools.isNull(rackcode)){
				clist.add(Restrictions.eq("gdsmst_gdscoll", gdsser));
			}
			if(!Tools.isNull(gdsser)){
				clist.add(Restrictions.eq("gdsmst_rackcode", rackcode));
			}
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("gdsmst_autoupdatedate"));
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 4);
			
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}	
	return list;
}
String getProductInfo(Date s,Date e,String brandname,String gdsscoll,ArrayList<OdrdtlRck> rcklist){
	StringBuilder sb=new StringBuilder();
	//ArrayList<OdrdtlRck> rcklist=getOrdtlRck( brandname, gdsscoll, mbrid);
	if(rcklist!=null && rcklist.size()>0){
		//sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >");
		sb.append("<tr><td >以下商品您可能感兴趣：</td></tr>");
		sb.append("<tr><td>同系列商品：</td></tr>");
		for(OdrdtlRck r:rcklist){
			ArrayList<Product> list=getProduct( s, e, brandname, gdsscoll,r.getGdsmst_rackcode());
			if(list!=null && list.size()>0){
				sb.append("<tr><td style=\"background-color:#f1f1f1;line-height:20px;\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" ><tr>");
				sb.append("<td width=14>&nbsp;</td>");
				for(Product p:list){
					String imgurl="http://www.d1.com.cn/product/"+p.getId();
					String strmprice=ProductGroupHelper.getRoundPrice(p.getGdsmst_memberprice());
					String sprice=ProductGroupHelper.getRoundPrice(p.getGdsmst_saleprice());
					String img=p.getGdsmst_fzimg();//160*200
					if(Tools.isNull(img)){
						img=p.getGdsmst_recimg();//160*160
					}
					if(Tools.isNull(img)){
						img=p.getGdsmst_midimg();
					}
					img="http://images.d1.com.cn"+img;
					
					sb.append("<td align=\"center\" valign=top>");	
					sb.append("<center>");
					sb.append("<table width=\"170\" height=\"250\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\" background-color:#FFFFFF; margin-top:10px;margin-bottom:10px;\" class=\"sp_outer\">");
					sb.append("<tr><td width=\"170\"  valign=\"top\"  style=\"padding-top:2px;padding-left:5px;\">");	
					sb.append("<a href=\"").append(imgurl).append("\" target=\"_blank\">").append("<img src=\"").append(img).append("\" border=0/></a>");
					sb.append("</td></tr>");	
					sb.append("<tr><td align=\"center\" valign=\"middle\" style=\"padding-top:5px;\">");	
					sb.append("<a href=\"").append(imgurl).append("\" target=\"_blank\" style=\"text-decoration:none\">");
					sb.append("<font style=\"font-size:10pt\">").append(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname().trim()),60)).append("</font>");	
					sb.append("</a><br/>");	
					sb.append("<span style=\"font-size:12px;color:#666666;\"><strike>市场价:￥").append(sprice).append("</strike></span><br/>");	
					sb.append("<span style=\"font-size:15px;font-weight:bold;color:#ff0000;\">会员价:￥").append(strmprice).append("</span><br/>");	
					sb.append("</td></tr></table>");	
					sb.append("</center>");	
					sb.append("</td>");	
					sb.append("<td width=14>&nbsp;</td>");	
					
				}
				sb.append("</tr></table></td></tr>");
				
			}
		}
		sb.append("</tr>");
		//sb.append("</table>");
	}
	return sb.toString();
}
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

private static String getGdscoll(Product product ,ArrayList<Gdscoll> glist1){
	if(product == null) return null;
	ArrayList<Gdscoll> glist=new ArrayList<Gdscoll>();
	
	//判断搭配单品是否能够显示在页面
	
	if(glist1!=null&&glist1.size()>0)
	{
		for(int i=0;i<glist1.size();i++)
		{
			Gdscoll g=glist1.get(i);
			int flag1=0;
			if(g!=null)
			{
				ArrayList<Gdscolldetail> gdetail=GdscollHelper.getGdscollBycollid(g.getId());
				if(gdetail!=null&&gdetail.size()>0)
				{
					for(Gdscolldetail gd:gdetail)
					{
						if(gd!=null&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						{
							Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							if(p!=null&&!p.getId().equals(product.getId()) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							  flag1++;
							}
						}
					}
				}
				if(flag1>0)
				{
					glist.add(g);
				}
			}
		}
	}
	
	StringBuilder sb = new StringBuilder();

		int size = glist!=null?glist.size():0;	
		
		//sb.append("<div style=\" text-align:left;\"  >");
		
		//sb.append("<div id=\"content_list\">");
		int flag = 0;
		//获取商品信息
		
		for(int i=0;i<glist.size()&&i<7;i++)
		{
			Gdscoll gdscoll=(Gdscoll)glist.get(i);
			if(gdscoll!=null)
			{
			flag++;
			ArrayList<Gdscolldetail> gdlist=new ArrayList<Gdscolldetail>();
			ArrayList<Gdscolldetail> gdlist1=GdscollHelper.getGdscollBycollid(gdscoll.getId());
			//获取搭配单品排序
			ArrayList<Gdscolldetail> gdlist_1=new ArrayList<Gdscolldetail>();
			ArrayList<Gdscolldetail> gdlist_2=new ArrayList<Gdscolldetail>();
			if(gdlist1!=null&&gdlist1.size()>0)
			{
				for(Gdscolldetail gdl:gdlist1)
				{
					if(gdl!=null&&gdl.getGdscolldetail_gdsflag()!=null&&gdl.getGdscolldetail_gdsflag().longValue()==1)
					{
						gdlist_1.add(gdl);
					}
					else
					{
						gdlist_2.add(gdl);
					}
				}
			}
			if(gdlist_1!=null&&gdlist1.size()>0)
			{
				gdlist.addAll(gdlist_1);
			}
			if(gdlist_2!=null&&gdlist_2.size()>0)
			{
				gdlist.addAll(gdlist_2);
			}
			if(gdlist!=null&&gdlist.size()>0)
			{
	           int count=0;
	           for(int j=0;j<gdlist.size();j++)
	           {
	        	   Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
	           	   Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
	               if(goods != null&& !goods.getId().equals(product.getId()) && goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
	           	       count++;
	           	   }
	               
	           }
	           count++;
	           int ulWidth = count*124+(count-1)*34+158;
	           
	           
	           
				String title = Tools.clearHTML(product.getGdsmst_gdsname());
				String imgurl1="";
			      ArrayList<GdsCutImg> gcilist1= getByGdsid(product.getId());
				  GdsCutImg gci1=new GdsCutImg();
				  if(gcilist1!=null&&gcilist1.size()>0)
				  {
					  gci1=gcilist1.get(0);
				  }
			
				  if(gci1!=null&&gci1.getGdscutimg_100()!=null&&gci1.getGdscutimg_100().length()>0)
				  {
					  imgurl1="http://images.d1.com.cn"+gci1.getGdscutimg_100();
				  }
				  else
				  {
					  imgurl1=ProductHelper.getImageTo120(product);
				  }
				sb.append("<div class=\"content_sub\" ><div class=\"package\"><ul style=\"width:").append(ulWidth).append("px;\">");
				if(gdscoll.getGdscoll_smallimgurl()!=null&&gdscoll.getGdscoll_smallimgurl().length()>0)
				{
				//获取搭配图
		        sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append("http://images1.d1.com.cn").append(gdscoll.getGdscoll_smallimgurl()).append("\"/>");
				sb.append("</a></li>");
				sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/images2012/index2012/equal.png\" width=\"18\" height=\"18\" style=\"border:none;\" /></li>");
				}
				sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\"><img src='").append(imgurl1).append("' width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(product.getGdsmst_gdsname())).append("\"/></a><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
				sb.append("<span>&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#666666\">原价：￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font></span><input type=\"hidden\" name=\"gdsmp").append(flag).append("\" id=\"gdsmp").append(flag).append("\" value='").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("'></li>");
			
				float memberprice = 0f;
				float memberprice1 = 0f;
	            float zk=0.95f;
	            for(int j=0;j<gdlist.size();j++)
	            {
	            	
	            	Gdscolldetail ppi = (Gdscolldetail)gdlist.get(j);
	            	Product goods = ProductHelper.getById(ppi.getGdscolldetail_gdsid());
	            	if(goods != null && !goods.getId().equals(product.getId())&&goods.getGdsmst_ifhavegds().longValue()==0&&goods.getGdsmst_validflag().longValue()==1&&ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_flag().longValue()==1&&ProductStockHelper.canBuy(goods)){
	            		//获取显示图片
	            		String imgurl="";
	            		      ArrayList<GdsCutImg> gcilist= getByGdsid(goods.getId());
	            			  GdsCutImg gci=new GdsCutImg();
	            			  if(gcilist!=null&&gcilist.size()>0)
	            			  {
	            				  gci=gcilist.get(0);
	            			  }
	            		
	            			  if(gci!=null&&gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
	            			  {
	            				  imgurl="http://images.d1.com.cn"+gci.getGdscutimg_100();
	            			  }
	            			  else
	            			  {
	            				  imgurl=ProductHelper.getImageTo120(goods);
	            			  }
	            		title = Tools.clearHTML(goods.getGdsmst_gdsname());
	            		sb.append("<li class=\"otherli\" style=\"position:relative;+position:static;\"><img src=\"http://images.d1.com.cn/Index/images/zhadd.jpg\" width=\"16\" height=\"16\" style=\"border:none;\" /></li>");
	            		sb.append("<li style=\"position:relative;+position:static;\"><a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\"><img src=\"").append(imgurl).append("\" width=\"100\" height=\"100\" alt=\"").append(Tools.clearHTML(goods.getGdsmst_gdsname())).append("\"/></a>");
	            		sb.append("<a href=\"http://www.d1.com.cn").append(ProductHelper.getProductUrl(goods)).append("\" target=\"_blank\" class=\"title\" title=\"").append(title).append("\">").append(title).append("</a>");
	            		
	            		sb.append("&nbsp;&nbsp;<font color=\"#666666\" >原价：￥").append(Tools.getFormatMoney(goods.getGdsmst_memberprice())).append("</font>");
	            		sb.append("<span id=\"span"+goods.getId()+flag+"\" style=\"position: absolute;+position:static; +margin-top:-157px; +margin-left:1px;top:1px;left:1px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;");
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1)
	            		{
	            			sb.append(" display:none;");
	            		}
	            		else
	            		{
	            			sb.append(" display:block;");
	            		}
	            		sb.append(" \"></span>");
	            		sb.append("</li>");   
	            		if(ppi.getGdscolldetail_gdsflag()!=null&&ppi.getGdscolldetail_gdsflag().longValue()==1){
		            		memberprice += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()*zk),2);
		            		memberprice1 += Tools.getFloat((int)(goods.getGdsmst_memberprice().floatValue()),2);
	            		}
	            		
	            	}
	            	
	            	
	            }
	            memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
        		memberprice1 += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2);
        	
	            sb.append("</ul></div>");
	            sb.append("<table class=\"zh_content\"><tr><td><span>搭配购买</span><br/>");
	            sb.append("<strike>总价：￥<font id=\"memberP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1)).append("</font></strike><br/>");
	            sb.append("组合价：<font color=\"#bc0000\" face=\"微软雅黑\"><b>￥<font id=\"pktP").append(flag).append("\">").append(Tools.getFormatMoney(memberprice)).append("</font></b></font><br/>");
	            sb.append("共优惠：￥<font id=\"cheap").append(flag).append("\">").append(Tools.getFormatMoney(memberprice1-memberprice)).append("</font><br/><br/>");
	            sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\">");
	            sb.append("<img src=\"http://images.d1.com.cn/Index/images/ljgmgzh.jpg\"  border=\"0\"/></a>");
	            sb.append("</td></tr></table>");
	            sb.append("</div>");
			}
			}
		}
		//sb.append("</div></div>");
		return sb.toString();
}
String getOrderInfo(Date s,Date e,String brandname,String gdsscoll,Long mbrid,ArrayList<OdrdtlRck> rcklist){ 
	User u=UserHelper.getById(mbrid.toString());
	StringBuilder sb=new StringBuilder();
	
	StringBuilder sb1=new StringBuilder();
	String uid="";String name="";
	if(u!=null){
		uid=u.getMbrmst_uid();
		name=u.getMbrmst_name();
		int i=0;
		if(rcklist!=null && rcklist.size()>0){
			int num=1;
			if(rcklist.size()==1){num=4;}
			else if(rcklist.size()==1){num=2;}
			//System.out.println("购买的分类：MMMMMMMMMMMM"+rcklist.size());
			boolean isdp=false;
			sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"line-height:26px;\" >");
			sb.append("<tr><td>亲爱的优尚网客户").append(name).append("(").append(uid).append(")</td></tr>");
			sb.append("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;您在优尚网购买过以下商品：</td></tr>");
			sb.append("<tr><td style=\"background-color:#f1f1f1;line-height:20px;\" ><table  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" ><tr>");
			sb.append("<td width=14>&nbsp;</td>");
			if(i<4){
			for(OdrdtlRck r:rcklist){
				//System.out.println("分类：NNNNNNNNNNNNNNN"+r.getGdsmst_rackcode());
				ArrayList<OdrdtlJZYX> list=getOrdtl( brandname, gdsscoll,mbrid,r.getGdsmst_rackcode(),num);
				uid=u.getMbrmst_uid();
				name=u.getMbrmst_name();
				if(list!=null && list.size()>0){
					for(OdrdtlJZYX o:list){
						String imgurl="http://www.d1.com.cn/product/"+o.getOdrdtl_gdsid();
								String strmprice=ProductGroupHelper.getRoundPrice(o.getGdsmst_memberprice());
								String sprice=ProductGroupHelper.getRoundPrice(o.getGdsmst_saleprice());
								String img=o.getGdsmst_fzimg();//160*200
								if(Tools.isNull(img)){
									img=o.getGdsmst_recimg();//160*160
								}
								if(Tools.isNull(img)){
									img=o.getGdsmst_midimg();
								}
								img="http://images.d1.com.cn"+img;
								sb.append("<td align=\"center\"  valign=top>");	
								sb.append("<center>");
								sb.append("<table width=\"170\" height=\"250\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\" background-color:#FFFFFF; margin-top:10px;margin-bottom:10px;\" class=\"sp_outer\">");
								sb.append("<tr><td width=\"170\"  valign=\"top\"  style=\"padding-top:2px;padding-left:5px;\">");	
								sb.append("<a href=\"").append(imgurl).append("\" target=\"_blank\">").append("<img src=\"").append(img).append("\" border=0/></a>");
								sb.append("</td></tr>");	
								sb.append("<tr><td align=\"center\" valign=\"middle\" style=\"padding-top:5px;\">");	
								sb.append("<a href=\"").append(imgurl).append("\" target=\"_blank\" style=\"text-decoration:none\">");
								sb.append("<font style=\"font-size:10pt\">").append(Tools.substring(Tools.clearHTML(o.getGdsmst_gdsname().trim()),60)).append("</font>");	
								sb.append("</a><br/>");	
								//sb.append("<span style=\"font-size:12px;color:#666666;\"><strike>市场价:￥").append(sprice).append("</strike></span><br/>");	
								//sb.append("<span style=\"font-size:15px;font-weight:bold;color:#ff0000;\">会员价:￥").append(strmprice).append("</span><br/>");	
								sb.append("</td></tr></table>");	
								sb.append("</center>");	
								sb.append("</td>");	
								sb.append("<td width=14>&nbsp;</td>");	
						//	sb.append("<td style=\"border:#ccc solid 1px;\"><table  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" ><tr><td>");
						//	sb.append("<a href=\"http://d1.com.cn/product/").append(o.getOdrdtl_gdsid()).append("\" target=\"_blank\"");
						//	sb.append("<img src=\"http://images.d1.com.cn/").append(imgurl).append("\" border=\"0\"/></a>");
						//	sb.append("<tr><td>").append(StringUtils.getCnSubstring(Tools.clearHTML(o.getGdsmst_gdsname()),0,66)).append("</td></tr>");	
						//	sb.append("</table></td>");
						//	i++;
							
								ArrayList<Gdscoll> gdscolllist=GdscollHelper. getGdscollByGdsid(o.getOdrdtl_gdsid());
								//第一次有搭配
								if(gdscolllist!=null && gdscolllist.size()>0){
									if(!isdp){
										sb1.append("<tr><td>搭配商品：</td></tr>");	
										sb1.append("<tr><td>");	
										sb1.append("<div id=\"content_list\" style=\"font-size:12px;\">");
									}
								Product p=ProductHelper.getById(o.getOdrdtl_gdsid());
								sb1.append(getGdscoll(p,gdscolllist));
									
									
									isdp=true;
								}
					
					}
						}
				i++;
				
					}
			
			}
			sb.append("</tr></table></td></tr>");
			if(isdp){
				sb1.append("</div>");	
				sb1.append("</td></tr>");	
			}
			sb.append(getProductInfo( s, e, brandname, gdsscoll,rcklist));
			sb.append(sb1.toString());
			sb.append("</table>");
		}
		}

	//}
	return sb.toString();
}
//获得搭配商品
String getOrderInfo(String brandname,String gdsscoll){ 
	StringBuilder sb=new StringBuilder();
	 ArrayList<Odrdtl_User> userlist= getOrdtlUser( brandname, gdsscoll);
	 if(userlist!=null && userlist.size()>0){
		 
		 for(Odrdtl_User user:userlist){
			// ArrayList<OdrdtlRck> rcklist=getOrdtlRck( brandname, gdsscoll,  user.getOdrmst_mbrid().toString()); 
			/**
			ArrayList<Gdscoll> gdscolllist=GdscollHelper. getGdscollByGdsid(p.getId());
				//第一次有搭配
				if(gdscolllist!=null && gdscolllist.size()>0){
					if(!isdp){
						sb1.append("<tr><td>搭配商品：</td></tr>");	
						sb1.append("<tr><td>");	
					}
					isdp=true;
					sb1.append("<div id=\"content_list\">");
				}
				**/
		 }
	 }
	return sb.toString();
}
%> 
<%
String brandname=request.getParameter("brandname");
String gdsscoll=request.getParameter("gdsscoll");
brandname="AleeiShe 小栗舍";
gdsscoll="精致甜美系列";
Date s=new Date((new Date().getTime()-30*24*3600));
Date e;

StringBuilder sb=new StringBuilder();
sb.append("<html><head><title>营销-D1优尚网</title><link href=\"http://www.d1.com.cn/res/css/gdsinfo.css\" rel=\"stylesheet\" type=\"text/css\"/>");
sb.append("<link href=\"http://www.d1.com.cn/res/css/module_box.css?1.11\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\" />");
sb.append("<script type=\"text/javascript\" src=\"http://www.d1.com.cn/res/js/d1.js?1.12\"></script>");
sb.append("</head>");
sb.append("<body bgcolor=\"#FFFFFF\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\" >");
sb.append("<center>");
sb.append("<table id=\"__01\" width=\"750\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
sb.append("<tr>");
sb.append("<td><a href=\"http://www.d1.com.cn\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mhead_02.jpg\" alt=\"\" width=\"153\" height=\"69\" border=\"0\"></a></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/mhead_03.jpg\" width=\"249\" height=\"69\" alt=\"\"></td>");
sb.append("<td><a href=\"http://feelmind.d1.com.cn/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mhead_04.jpg\" alt=\"\" width=\"146\" height=\"69\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://aleeishe.d1.com.cn/\"><img src=\"http://images.d1.com.cn/headimg/mail/mhead_05.jpg\" alt=\"\" width=\"87\" height=\"69\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://sheromo.d1.com.cn/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mhead_06.jpg\" alt=\"\" width=\"75\" height=\"69\" border=\"0\"></a></td>");
sb.append("<td colspan=\"2\"><a href=\"http://yousoo.d1.com.cn/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mhead_07.jpg\" alt=\"\" width=\"40\" height=\"69\" border=\"0\"></a></td>");
sb.append("</tr><tr><td colspan=\"7\"><table width=\"700\"   border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr>");
sb.append("<td><a href=\"http://www.d1.com.cn\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_01.jpg\" alt=\"\" width=\"61\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/men\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_02.jpg\" alt=\"\" width=\"53\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/women\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_03.jpg\" alt=\"\" width=\"51\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/cosmetic\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_04.jpg\" alt=\"\" width=\"69\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/ornament\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_05.jpg\" alt=\"\" width=\"56\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/result.jsp?productsort=021,022,031,032&order=3\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_06.jpg\" alt=\"\" width=\"49\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/bag\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_07.jpg\" alt=\"\" width=\"46\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/watch\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_08.jpg\" alt=\"\" width=\"49\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_09.jpg\" width=\"150\" height=\"41\" alt=\"\"></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/watch\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_10.jpg\" alt=\"\" width=\"48\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/news/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_11.jpg\" alt=\"\" width=\"49\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><a href=\"http://www.d1.com.cn/html/zt2012/0214week\" target=\"_blank\"><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_12.jpg\" alt=\"\" width=\"56\" height=\"41\" border=\"0\"></a></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/mailmenu1208_13.jpg\" width=\"13\" height=\"41\" alt=\"\"></td>");
sb.append("</tr></table></td></tr><tr>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"153\" height=\"1\" alt=\"\"></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"199\" height=\"1\" alt=\"\"></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"146\" height=\"1\" alt=\"\"></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"87\" height=\"1\" alt=\"\"></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"75\" height=\"1\" alt=\"\"></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"31\" height=\"1\" alt=\"\"></td>");
sb.append("<td><img src=\"http://images.d1.com.cn/headimg/mail/分隔符.gif\" width=\"9\" height=\"1\" alt=\"\"></td>");
sb.append("</tr></table>");




//获得一个月内购买该系列的用户
 //ArrayList<Odrdtl_User> userlist= getOrdtlUser( brandname, gdsscoll);
// if(userlist!=null && userlist.size()>0){
	 //for(Odrdtl_User user:userlist){
		// ArrayList<OdrdtlRck> rcklist=getOrdtlRck( brandname, gdsscoll,  user.getOdrmst_mbrid()); //用户购买过的商品分类
		// if(rcklist!=null && rcklist.size()>0){
		//	out.print( getOrderInfo( null, null, brandname, gdsscoll,user.getOdrmst_mbrid(),rcklist));
			
		// }
		 
	// }
// }

  ArrayList<OdrdtlRck> rcklist=getOrdtlRck( brandname, gdsscoll,  new Long("394695")); //用户购买过的商品分类
		 if(rcklist!=null && rcklist.size()>0){
			
			sb.append(getOrderInfo( null, null, brandname, gdsscoll,new Long("394695"),rcklist));
		 }
		 sb.append("<table width=\"750\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#f1f1f1\">");
		 sb.append(" <tr > <td height=\"10\" bgcolor=\"#FFFFFF\"></td></tr>");
		 sb.append("<tr ><td height=\"10\" bgcolor=\"#FFFFFF\"><img src=\"http://images.d1.com.cn/headimg/mail/tail1.jpg\" width=\"750\" height=\"89\" border=\"0\" usemap=\"#Map\" /></td></tr>");
		 sb.append(" <tr> <td align=\"center\"><img src=\"http://images.d1.com.cn/headimg/mail/tail2.jpg\" width=\"750\" height=\"74\" /></td></tr>");
		 sb.append("<tr><td align=\"center\"><table width=\"720\" height=\"69\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr>");
		 sb.append("<td><span style=\"font-size:13px;color:#595959;line-height:20px;\">&nbsp;<img src=\"http://images.d1.com.cn/headimg/mailhead_t.gif\" />收到此邮件说明您已是D1优尚(<U> <a href=\"http://www.d1.com.cn\" target=\"_blank\">www.d1.com.cn</a></U>)尊贵的用户，我们保证仅向您发送关于D1优尚的产品、促销优惠以及服务类的电子邮件，D1尊重并保护您的隐私。<br />");
		 sb.append("为确保D1优尚的促销信息不被当做垃圾邮件，请把<U> <a href=\"mailto:service@staff.d1.com.cn\">service@staff.d1.com.cn</a></U>添加为您的联系人。 <br>如果您不愿意继续接收来自D1优尚的促销类邮件，请点击<a href=\"http://www.d1.com.cn/html/bademail.jsp\" style=\"color:#595959;text-decoration:none;font-weight:bold;\">退订促销邮件</a>。<br /> 商品价格及促销内容如有调整，以D1优尚网最终页面为准。");
		 sb.append("</span></td></tr></table></td></tr>");
		 sb.append("<tr><td height=\"60\" align=\"center\"><table width=\"700\" height=\"46\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-bottom-width: 1px;border-bottom-style: solid;border-bottom-color: #E7E7E7;\">");
		 sb.append(" <tr><td align=\"right\" valign=\"bottom\"><img src=\"http://images.d1.com.cn/headimg/mail_tail_1.gif\" width=\"113\" height=\"37\" /></td></tr></table></td>");
		 sb.append("</tr></table>");
		 sb.append("<map name=\"Map\" id=\"Map\">");
		 sb.append("<area shape=\"rect\" coords=\"562,34,605,76\" href=\"http://t.qq.com/d1_com_cn \" target=\"_blank\" /><area shape=\"rect\" coords=\"606,33,649,77\" href=\"http://t.sohu.com/home \" target=\"_blank\" />");
		 sb.append("<area shape=\"rect\" coords=\"519,33,560,75\" href=\"http://weibo.com/d1ys \" target=\"_blank\" />");
		 sb.append("</map>");
		 sb.append("</center></body></html>");
		 out.print( sb.toString());
  
/**

ArrayList<OdrdtlJZYX> list=null;
StringBuilder sb=new StringBuilder();
if(list!=null && list.size()>0){
	int i=0;Long lastuser=0l;
	sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >");
	for(OdrdtlJZYX o:list){
		Long  mbrid=o.getOdrmst_mbrid();
		String uid="";String name="";
		if(i==0){//第一个
			lastuser=mbrid;
		}
		if(!mbrid.equals(lastuser)){//下一个
			lastuser=mbrid;
			i=1;
		}
		if(mbrid.equals(lastuser)){
			if(i<=3){
				User u=UserHelper.getById(mbrid.toString());
				if(u!=null){
					uid=u.getMbrmst_uid();
					name=u.getMbrmst_name();
				
					
					
					i++;
				}
			}
		}
		
		
	}
}
**/
%>
