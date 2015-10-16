<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.SimpleExpression,org.hibernate.criterion.Restrictions,org.hibernate.criterion.Order,com.d1.dbcache.core.*" %>
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

//获取搭配图的背景图
private static String getBg(String brandid)
{
  if(Tools.isNull(brandid)) return "";
  if(brandid.equals("987")) return "http://images.d1.com.cn/images2012/index2012/feelmind-bg.jpg";
  else if(brandid.equals("1690")) return "http://images.d1.com.cn/images2012/index2012/aleeishe-bg.jpg";
  else if(brandid.equals("1969")) return "http://images.d1.com.cn/images2012/index2012/sheromo-bg.jpg";
  else return "http://images.d1.com.cn/images2012/index2012/aleeishe-bg.jpg";
}


//获取商品详情的搭配显示
private static String getGdscollInDetail(String outColor,String gdsColor,String overColor,String code)
{
	if(Tools.isNull(code)||code.length()<=0) return "";
	ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode(code,1);
	StringBuilder sb=new StringBuilder();
	//System.out.print(plist.size());
	if(plist!=null&&plist.size()>0)
	{
		Promotion promotion=new Promotion();
		if(plist.get(0)!=null&&plist.get(0).getSplmst_name()!=null&&plist.get(0).getSplmst_name().length()>0)
		{
			promotion=plist.get(0);
		}
		else 
		{
			return "";
		}
		//ArrayList<Gdscoll> gdscolllist=getGdscollByGdsid(pid);
		String str=promotion.getSplmst_name().replace("，", ",");		
		String[] stra=str.split(",");
		//System.out.print(stra.length);
		ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
		if(stra.length>0)
		{
			for(int i=0;i<stra.length;i++)
			{
				Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(stra[i]);
				if(gdscoll!=null)
				{
				    gdscolllist.add(gdscoll);
				}
			}
		}
		
		
		if(gdscolllist!=null&&gdscolllist.size()>0)
		{
			for(int i=0;i<gdscolllist.size();i++)
			{
				Gdscoll gdscoll=gdscolllist.get(i);
				if(gdscoll!=null)
				{
					
					if((i+1)%2==1)
					{
						sb.append("<table class=\"detail_gdscoll\" style=\"background:#").append(outColor).append("\" cellpadding=\"0\" cellspacing=\"0\">");
						ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
						
						
							String brandname="";
							String imgbg="";
							 //获取系列
							Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
							String color="";
							
							 if(gdsser!=null)
							 {
								 
									 if(gdsser.getGdsser_brandid().equals("987"))
									 {
										 brandname="FEEL MIND";
										 color="color:#e4e1e1";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1690"))
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1969"))
									 {
										 brandname="诗若漫";
										 color="color:#665c56";
										
									 }
									 else
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 imgbg=getBg(gdsser.getGdsser_brandid().toString());
								 
							 }
							sb.append("<tr><td><div class=\"gdscollleft\" style=\"background:#").append(gdsColor).append("\">");
							sb.append("<ul>");
							for(Gdscolldetail gd:gdetaillist)
							{
								if(gd!=null)
								{
									Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
									if(p!=null)
									{
										
										String gdsimg="";
										ArrayList<GdsCutImg> gdclist=getByGdsid(p.getId());
										if(gdclist!=null&&gdclist.size()>0&&gdclist.get(0)!=null)
										{
											GdsCutImg gci=gdclist.get(0);
											if(gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
											{
											   gdsimg="http://images.d1.com.cn/"+gci.getGdscutimg_100();
											}
											else
											{
												gdsimg=ProductHelper.getImageTo120(p);
											}
										}
										else
										{
											gdsimg=ProductHelper.getImageTo120(p);
										}
										 sb.append("<li onmouseover=\"gdscollover(this,'"+p.getId()+i+"','"+overColor+"')\" onmouseout=\"gdscollout(this,'"+p.getId()+i+"')\">");
										 sb.append("<span><a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a></span>");
										 sb.append("<div>");
										 if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
										 {
										     sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"><img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\" /></div>");
										 }
										 sb.append("<span class=\"span1_1\">");
										 
										 sb.append("["+brandname+"]<br/>");
										 sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
										 sb.append("</span>");
										 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue())+"</span>");
										 sb.append("<span class=\"span3_1\">");
										 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
										 {
										          sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this)\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
												  sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 }
										 else
										 {
											 sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											 sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									
										 }
										 sb.append("</span>");
										 sb.append("</div><div class=\"clear\"></div>");
										 sb.append("</li>");
									}
								}
							}
							
							sb.append("</ul></div>");
							
							sb.append("<div class=\"gdscollright\"  style=\"background:#"+gdsColor+";\">");
							
							sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
							sb.append("<div class=\"textdiv\" >");
							sb.append("<font style=\" font-size:20px; font-weight:bold; display:block; margin-bottom:10px; font-family:'微软雅黑'; "+color+" \">"+Tools.clearHTML(gdscoll.getGdscoll_title())+"</font>");
							 sb.append("</div>");
						    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
						    sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
							sb.append("</div></div></div>"); 
							sb.append("</td></tr>");
							sb.append("</table>");
					}
					else
					{
						sb.append("<table class=\"detail_gdscoll\" style=\"background:#").append(outColor).append("\" cellpadding=\"0\" cellspacing=\"0\">");
						ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
						
							String brandname="";
							String imgbg="";
							 //获取系列
							Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
							String color="";
							
							 if(gdsser!=null)
							 {
								 
									 if(gdsser.getGdsser_brandid().equals("987"))
									 {
										 brandname="FEEL MIND";
										 color="color:#e4e1e1";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1690"))
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1969"))
									 {
										 brandname="诗若漫";
										 color="color:#665c56";
										
									 }
									 else
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 imgbg=getBg(gdsser.getGdsser_brandid().toString());
								 
							 }
							sb.append("<tr><td><div class=\"gdscollright1\" style=\"background:#").append(gdsColor).append("\">");
							sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
							sb.append("<div class=\"textdiv\" >");
							sb.append("<font style=\" font-size:20px; font-weight:bold; display:block; margin-bottom:10px;font-family:'微软雅黑'; "+color+"\">"+gdscoll.getGdscoll_title()+"</font>");
							sb.append("</div>");
						    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
						    sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
							sb.append("</div></div></div>"); 
							
							sb.append("<div class=\"gdscollleft1\" style=\"background:#"+gdsColor+";\">");
							sb.append("<ul>");
							for(Gdscolldetail gd:gdetaillist)
							{
								if(gd!=null)
								{
									Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
									if(p!=null)
									{
										
										String gdsimg="";
										ArrayList<GdsCutImg> gdclist=getByGdsid(p.getId());
										if(gdclist!=null&&gdclist.size()>0&&gdclist.get(0)!=null)
										{
											GdsCutImg gci=gdclist.get(0);
											if(gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
											{
											   gdsimg="http://images.d1.com.cn/"+gci.getGdscutimg_100();
											}
											else
											{
												gdsimg=ProductHelper.getImageTo120(p);
											}
										}
										else
										{
											gdsimg=ProductHelper.getImageTo120(p);
										}
										 sb.append("<li onmouseover=\"gdscollover(this,'"+p.getId()+i+"','"+overColor+"')\" onmouseout=\"gdscollout(this,'"+p.getId()+i+"')\">");
										 sb.append("<span><a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a></span>");
										 sb.append("<div>");
										 if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
										 {
											 sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"> <img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\"/></div>");
										 }
										 sb.append("<span class=\"span1_1\">");
										 
										 sb.append("["+brandname+"]<br/>");
										 sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
										 sb.append("</span>");
										 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue())+"</span>");
										 sb.append("<span class=\"span3_1\">");
										
										 
										 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
										 {
											 
										          sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this)\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
												  sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 }
										 else
										 {
											 sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											 sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									
										 }
										 sb.append("</span>");
										 sb.append("</div><div class=\"clear\"></div>");
										 sb.append("</li>");
									}
								}
							}
							
							sb.append("</ul></div>");					
							sb.append("</td></tr>");
							sb.append("</table>");
					}
				
				}
						
			}
	        
		}
		
		}
    return sb.toString();	
}


//获取场景模式2下的搭配
private static String getGdscollInGdsscene(Gdsscene gdsscene)
{
	if(gdsscene==null||gdsscene.getGdsscene_gdscollid()==null||gdsscene.getGdsscene_gdscollid().length()<=0) return "";
	String gdscollid=gdsscene.getGdsscene_gdscollid();
	gdscollid=gdscollid.replace("，", ",");
	String[] stra=gdscollid.split(",");
	StringBuilder sb=new StringBuilder();

	ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
	if(stra.length>0)
	{
		int k=gdsscene.getGdsscene_logo()!=null&&gdsscene.getGdsscene_logo().longValue()==1?1:0;
		for(int i=k;i<stra.length;i++)
		{
			Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(stra[i]);
			if(gdscoll!=null)
			{
				 gdscolllist.add(gdscoll);
			}
		}
	}
	else return "";
		
		
		if(gdscolllist!=null&&gdscolllist.size()>0)
		{
			int sum=0;
			for(int i=0;i<gdscolllist.size();i++)
			{
				Gdscoll gdscoll=gdscolllist.get(i);
				if(gdscoll!=null)
				{
					sum++;
					if(sum>10) break;
					if((i+1)%2==1)
					{
						sb.append("<table class=\"detail_gdscoll\" style=\"background:#").append(gdsscene.getGdsscene_bgcolor()!=null&&gdsscene.getGdsscene_bgcolor().length()>0?gdsscene.getGdsscene_bgcolor():"000").append("\" cellpadding=\"0\" cellspacing=\"0\">");
						ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
						//将搭配显示不显示排列
						if(gdetaillist!=null&&gdetaillist.size()>0)
						{
							ArrayList<Gdscolldetail> gdl1=new ArrayList<Gdscolldetail>();
							ArrayList<Gdscolldetail> gdl2=new ArrayList<Gdscolldetail>();
							for(Gdscolldetail gd:gdetaillist)
							{
								if(gd!=null)
								{
									if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
									{
										gdl1.add(gd);
									}
									else
									{
										gdl2.add(gd);
									}
								}
							}
							gdetaillist.clear();
							if(gdl1!=null&&gdl1.size()>0)
							{
								gdetaillist.addAll(gdl1);
							}
							if(gdl2!=null&&gdl2.size()>0)
							{
								gdetaillist.addAll(gdl2);
							}
						}
						
							String brandname="";
							String imgbg="";
							 //获取系列
							Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
							String color="";
							
							 if(gdsser!=null)
							 {
								 
									 if(gdsser.getGdsser_brandid().equals("987"))
									 {
										 brandname="FEEL MIND";
										 color="color:#e4e1e1";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1690"))
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1969"))
									 {
										 brandname="诗若漫";
										 color="color:#665c56";
										
									 }
									 else
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 
									 if(gdsscene.getGdsscene_dpbgimg()!=null&&gdsscene.getGdsscene_dpbgimg().length()>0)
									 {
										 imgbg="http://images1.d1.com.cn"+gdsscene.getGdsscene_dpbgimg();
									 }
									 else
									 {
										 imgbg="http://images.d1.com.cn/images2012/index2012/feelmind-bg.jpg";
									 }
									
								 
							 }
							sb.append("<tr><td><div class=\"gdscollleft\" style=\"background:#").append(gdsscene.getGdsscene_gdscolor()!=null&&gdsscene.getGdsscene_gdscolor().length()>0?gdsscene.getGdsscene_gdscolor():"f00").append("\">");
							sb.append("<ul>");
							//所需价格
							float sum1=0f;
					        float zhprice=0;
					        int counts=0;
							for(Gdscolldetail gd:gdetaillist)
							{
								if(gd!=null)
								{
									Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
									if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p))
									{
										if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
										{
						    	    		sum1+=p.getGdsmst_memberprice().floatValue();
						    	    		zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*0.95), 2);
										    counts++;
										}	 
										
										String gdsimg="";
										ArrayList<GdsCutImg> gdclist=getByGdsid(p.getId());
										if(gdclist!=null&&gdclist.size()>0&&gdclist.get(0)!=null)
										{
											GdsCutImg gci=gdclist.get(0);
											if(gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
											{
											   gdsimg="http://images.d1.com.cn/"+gci.getGdscutimg_100();
											}
											else
											{
												gdsimg=ProductHelper.getImageTo120(p);
											}
										}
										else
										{
											gdsimg=ProductHelper.getImageTo120(p);
										}
										String ls1="";
										if(gdsscene.getGdsscene_overcolor()!=null&&gdsscene.getGdsscene_overcolor().length()>0)
										{
											ls1=gdsscene.getGdsscene_overcolor();
										}
										else
										{
											ls1="ccc";
										}
										
										 sb.append("<li onmouseover=\"gdscollover1(this,'"+p.getId()+i+"','"+ls1 +"')\" onmouseout=\"gdscollout1(this,'"+p.getId()+i+"')\">");
										 String check="";
										 if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
										 {
											 check="checked=\"checked\"";
										 }
										 sb.append("<span><input type=\"checkbox\" "+check+" name=\"chks_"+i+"\" value=\""+p.getId()+"\" onClick=\"choosedp('"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"',this.checked,"+i+")\" /><a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\">&nbsp;&nbsp;&nbsp;<img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a></span>");
										 sb.append("<div>");
										 //if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
										// {
										     //sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"><img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\" /></div>");
										// }
										 sb.append("<span class=\"span1_1\">");
										 
										 sb.append("["+brandname+"]<br/>");
										 sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
										 sb.append("</span>");
										 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue()));
										// ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(p.getId());
							    		   //if(list!=null&&list.size()>0)
							    		  // {
							    			  // if(list.get(0).getGdsatt_content().length()>0)
							    			  // {
									    		   // sb.append("&nbsp;&nbsp;&nbsp;<font style=\" color:#020399; cursor:hand;\" onmouseover=\"ccdzb('"+p.getId()+"_"+i+"')\" onmouseout=\"ccdzb1('"+p.getId()+"_"+i+"')\">(尺寸对照表)</font>");
									    		   // sb.append("<div id=\"ccdzb_img"+p.getId()+"_"+i+"\" style=\"position:absolute;display:none;\" onmouseover=\"ccdzb('"+p.getId()+"_"+i+"')\" onmouseout=\"ccdzb1('"+p.getId()+"_"+i+"')\">");
									    		  //  sb.append(list.get(0).getGdsatt_content());
									    		  //  sb.append("</div>");
							    		      // }
							    		 //  }
							    		   sb.append("</span>");
										 sb.append("<span class=\"span3_1\">");
										 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
										 {
										          sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this)\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
												  sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 }
										 else
										 {
											 sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											 sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									
										 }
										 sb.append("</span>");
										 sb.append("</div><div class=\"clear\"></div>");
										 sb.append("</li>");
									}
								}
							}
							
							sb.append("</ul>");
							sb.append("<div style=\"width:100%; padding-top:25px; padding-bottom:25px; line-height:20px; font-size:13px; padding-left:30px;\"><table><tr><td width=\"130\">共&nbsp;<font id=\"amounts"+i+"\">"+counts+"</font>&nbsp;件<br/>总价：￥<font id=\"memberPs"+i+"\">"+(int)sum1+"</font><br/><font color='cf0200'><b>组合价：￥<font id=\"pktPs"+i+"\">"+(int)zhprice+"</font></b></font><br/>共优惠：￥<font id=\"cheaps"+i+"\">"+(int)(sum1-zhprice)+"</font></td><td><font style=\"color:#f00; font-size:16px;\">搭配购买立享95折！</font><br/><a href=\"javascript:void(0)\" code=\""+gdscoll.getId()+"\" onclick=\"add_gdscoll1(this,'"+i+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/zhgm_cj.jpg\"/></a></td></tr></table></div>");
							sb.append("</div>");
							String ls2="";
							if(gdsscene.getGdsscene_gdscolor()!=null&&gdsscene.getGdsscene_gdscolor().length()>0)
							{
								ls2=gdsscene.getGdsscene_gdscolor();
							}
							else
							{
								ls2="f00";
							}
							sb.append("<div class=\"gdscollright\"  style=\"background:#"+ls2+";\">");
							
							sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
							//sb.append("<div class=\"textdiv\" >");
							//sb.append("<font style=\" font-size:20px; font-weight:bold; display:block; margin-bottom:10px; font-family:'微软雅黑';"+color+" \">"+Tools.clearHTML(gdscoll.getGdscoll_title())+"</font>");
							//sb.append("</div>");
						    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
						    sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
							sb.append("</div></div></div>"); 
							sb.append("</td></tr>");
							sb.append("</table>");
					}
					else
					{
						String ls3="";
						if(gdsscene.getGdsscene_bgcolor()!=null&&gdsscene.getGdsscene_bgcolor().length()>0)
						{
							ls3=gdsscene.getGdsscene_bgcolor();
						}
						else
						{
							ls3="000";
						}
						sb.append("<table class=\"detail_gdscoll\" style=\"background:#").append(ls3).append("\" cellpadding=\"0\" cellspacing=\"0\">");
						ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
						//将搭配显示不显示排列
						if(gdetaillist!=null&&gdetaillist.size()>0)
						{
							ArrayList<Gdscolldetail> gdl1=new ArrayList<Gdscolldetail>();
							ArrayList<Gdscolldetail> gdl2=new ArrayList<Gdscolldetail>();
							for(Gdscolldetail gd:gdetaillist)
							{
								if(gd!=null)
								{
									if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
									{
										gdl1.add(gd);
									}
									else
									{
										gdl2.add(gd);
									}
								}
							}
							gdetaillist.clear();
							if(gdl1!=null&&gdl1.size()>0)
							{
								gdetaillist.addAll(gdl1);
							}
							if(gdl2!=null&&gdl2.size()>0)
							{
								gdetaillist.addAll(gdl2);
							}
						}
						
						
							String brandname="";
							String imgbg="";
							 //获取系列
							Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
							String color="";
							
							 if(gdsser!=null)
							 {
								 
									 if(gdsser.getGdsser_brandid().equals("987"))
									 {
										 brandname="FEEL MIND";
										 color="color:#e4e1e1";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1690"))
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 else if(gdsser.getGdsser_brandid().equals("1969"))
									 {
										 brandname="诗若漫";
										 color="color:#665c56";
										
									 }
									 else
									 {
										 brandname="小栗舍";
										 color="color:#6d5257";
									 }
									 if(gdsscene.getGdsscene_dpbgimg()!=null&&gdsscene.getGdsscene_dpbgimg().length()>0)
									 {
										 imgbg="http://images1.d1.com.cn"+gdsscene.getGdsscene_dpbgimg();
									 }
									 else
									 {
										 imgbg="http://images.d1.com.cn/images2012/index2012/feelmind-bg.jpg";
									 }
							 }
							 String ls4="";
								if(gdsscene.getGdsscene_gdscolor()!=null&&gdsscene.getGdsscene_gdscolor().length()>0)
								{
									ls4=gdsscene.getGdsscene_gdscolor();
								}
								else
								{
									ls4="f00";
								}
							sb.append("<tr><td><div class=\"gdscollright1\" style=\"background:#").append(ls4).append("\">");
							sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
							//sb.append("<div class=\"textdiv\" >");
							//sb.append("<font style=\" font-size:20px; font-weight:bold; display:block; margin-bottom:10px; font-family:'微软雅黑';"+color+"\">"+gdscoll.getGdscoll_title()+"</font>");
							//sb.append("</div>");
						    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
						    sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
							sb.append("</div></div></div>"); 
							
							 String ls5="";
								if(gdsscene.getGdsscene_gdscolor()!=null&&gdsscene.getGdsscene_gdscolor().length()>0)
								{
									ls5=gdsscene.getGdsscene_gdscolor();
								}
								else
								{
									ls5="f00";
								}
							sb.append("<div class=\"gdscollleft1\" style=\"background:#"+ls5+";\">");
							sb.append("<ul>");
							//所需价格
							float sum1=0f;
					        float zhprice=0;
					        int counts=0;
							for(Gdscolldetail gd:gdetaillist)
							{
								if(gd!=null)
								{
									Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
									if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p))
									{
										if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
										{
						    	    		sum1+=p.getGdsmst_memberprice().floatValue();
						    	    		zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*0.95), 2);
										    counts++;
										}	 
										String gdsimg="";
										ArrayList<GdsCutImg> gdclist=getByGdsid(p.getId());
										if(gdclist!=null&&gdclist.size()>0&&gdclist.get(0)!=null)
										{
											GdsCutImg gci=gdclist.get(0);
											if(gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
											{
											   gdsimg="http://images.d1.com.cn/"+gci.getGdscutimg_100();
											}
											else
											{
												gdsimg=ProductHelper.getImageTo120(p);
											}
										}
										else
										{
											gdsimg=ProductHelper.getImageTo120(p);
										}
										String ls6="";
										if(gdsscene.getGdsscene_overcolor()!=null&&gdsscene.getGdsscene_overcolor().length()>0)
										{
											ls6=gdsscene.getGdsscene_overcolor();
										}
										else
										{
											ls6="ccc";
										}
										 sb.append("<li onmouseover=\"gdscollover1(this,'").append(p.getId()).append(i).append("','"+ls6+"')\" onmouseout=\"gdscollout1(this,'").append(p.getId()).append(i).append("')\">");
										 String check="";
										 if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
										 {
											 check="checked=\"checked\"";
										 }
										 sb.append("<span><input type=\"checkbox\" "+check+" name=\"chks_"+i+"\" value=\""+p.getId()+"\" onClick=\"choosedp('"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"',this.checked,"+i+")\" /><a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\">&nbsp;&nbsp;&nbsp;<img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a></span>");
										 sb.append("<div>");
										 //if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
										 //{
											 //sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"> <img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\"/></div>");
										// }
								
										 sb.append("<span class=\"span1_1\">");
										 
										 sb.append("["+brandname+"]<br/>");
										 sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
										 sb.append("</span>");
										 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue()));
										 //ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(p.getId());
							    		  // if(list!=null&&list.size()>0)
							    		  // {
							    			  // if(list.get(0).getGdsatt_content().length()>0)
							    			  // {
									    		  //  sb.append("&nbsp;&nbsp;&nbsp;<font style=\" color:#020399; cursor:hand;\" onmouseover=\"ccdzb('"+p.getId()+"_"+i+"')\" onmouseout=\"ccdzb1('"+p.getId()+"_"+i+"')\">(尺寸对照表)</font>");
									    		  //  sb.append("<div id=\"ccdzb_img"+p.getId()+"_"+i+"\" style=\"position:absolute;display:none; left:350px;\" onmouseover=\"ccdzb('"+p.getId()+"_"+i+"')\" onmouseout=\"ccdzb1('"+p.getId()+"_"+i+"')\">");
									    		   // sb.append(list.get(0).getGdsatt_content());
									    		   // sb.append("</div>");
							    		     //  }
							    		  // }
							    		   sb.append("</span>");
										 sb.append("<span class=\"span3_1\">");
										 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
										 {
										          sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this)\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
												  sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 }
										 else
										 {
											 sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											 sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"')\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									
										 }
										 sb.append("</span>");
										 sb.append("</div><div class=\"clear\"></div>");
										 sb.append("</li>");
									}
								}
							}
							
							sb.append("</ul>");
							sb.append("<div style=\"width:100%; padding-top:25px; padding-bottom:25px; line-height:20px; font-size:13px; padding-left:30px;\"><table><tr><td width=\"130\">共&nbsp;<font id=\"amounts"+i+"\">"+counts+"</font>&nbsp;件<br/>总价：￥<font id=\"memberPs"+i+"\">"+(int)sum1+"</font><br/><font color='cf0200'><b>组合价：￥<font id=\"pktPs"+i+"\">"+(int)zhprice+"</font></b></font><br/>共优惠：￥<font id=\"cheaps"+i+"\">"+(int)(sum1-zhprice)+"</font></td><td><font style=\"color:#f00; font-size:16px;\">搭配购买立享95折！</font><br/><a href=\"javascript:void(0)\" code=\""+gdscoll.getId()+"\" onclick=\"add_gdscoll1(this,'"+i+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/zhgm_cj.jpg\"/></a></td></tr></table></div>");
							sb.append("</div>");
							
							sb.append("</td></tr>");
							sb.append("</table>");
					}
				
				}
						
			}
	        
		}

    return sb.toString();	
}

//获取场景模式2下的搭配
private static String getGdscollInGdsscene20120713(Gdsscene gdsscene)
{
	if(gdsscene==null||gdsscene.getGdsscene_gdscollid()==null||gdsscene.getGdsscene_gdscollid().length()<=0) return "";
	String gdscollid=gdsscene.getGdsscene_gdscollid();
	gdscollid=gdscollid.replace("，", ",");
	String[] stra=gdscollid.split(",");
	StringBuilder sb=new StringBuilder();

	ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
	if(stra.length>0)
	{
		int k=gdsscene.getGdsscene_logo()!=null&&gdsscene.getGdsscene_logo().longValue()==1?1:0;
		for(int i=k;i<stra.length;i++)
		{
			Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(stra[i]);
			if(gdscoll!=null)
			{
				 gdscolllist.add(gdscoll);
			}
		}
	}
	else return "";
    if(gdscolllist!=null&&gdscolllist.size()>0)
    {
       if(gdsscene.getGdsscene_bgcolor()!=null&&gdsscene.getGdsscene_bgcolor().length()>0)
       {
    	   sb.append("<div class=\"gdscoll20120713\"  style=\"background:#"+gdsscene.getGdsscene_bgcolor()+"\">");
       }
       else
       {
    	   sb.append("<div class=\"gdscoll20120713\" >");
       }
       sb.append("<table><tr><td><ul>");
       for(int i=1;i<gdscolllist.size();i++)
       {
    	   Gdscoll gdscoll=gdscolllist.get(i);
    	   if(gdscoll!=null&&gdscoll.getGdscoll_flag()!=null&&gdscoll.getGdscoll_flag().longValue()==1)
    	   {
	    	   StringBuilder sb1=new StringBuilder();
	    	   StringBuilder sb2=new StringBuilder();//价格字符串
	    	   if(gdsscene.getGdsscene_gdscolor()!=null&&gdsscene.getGdsscene_gdscolor().length()>0)
	    	   {
	    		   sb.append("<li style=\"background:#"+gdsscene.getGdsscene_gdscolor()+";\"><table><tr><td>");
	    	   }
	    	   else
	    	   {
	    		   sb.append("<li><table><tr><td>");
	    	   }
	    	   sb.append("<div class=\"leftg\">");
	    	   if(gdsscene.getGdsscene_dpbgimg()!=null&&gdsscene.getGdsscene_dpbgimg().length()>0)
	    	   {
	    		   sb.append("<div  style=\"background:url(http://images1.d1.com.cn"+gdsscene.getGdsscene_dpbgimg()+"); width:320px;\">");
	           }
	    	   else
	    	   {
	    		   sb.append("<div style=\"width:320px;\">");
	    	   }
	    	   sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id="+gdscoll.getId()+"&sf="+gdsscene.getId()+"\" target=\"_blank\">");
	    	  
	    	  
	    	   sb.append("<img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"/> </a> </div>");
	    	  
	    	   sb1.append(" <div class=\"rightg\"><div id=\"scoll"+i+"\" class=\"newsubgdscoll\">");
	    	   sb1.append("<div id=\"scolllist"+i+"\" style=\"position:relative; height:522px;width:140px;overflow:hidden;\">");
	           sb1.append("<ul class=\"gdetaillist\">");
	           ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
				//将搭配显示不显示排列
				if(gdetaillist!=null&&gdetaillist.size()>0)
				{
					ArrayList<Gdscolldetail> gdl1=new ArrayList<Gdscolldetail>();
					ArrayList<Gdscolldetail> gdl2=new ArrayList<Gdscolldetail>();
					for(Gdscolldetail gd:gdetaillist)
					{
						if(gd!=null)
						{
							if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
							{
								gdl1.add(gd);
							}
							else
							{
								gdl2.add(gd);
							}
						}
					}
					gdetaillist.clear();
					if(gdl1!=null&&gdl1.size()>0)
					{
						gdetaillist.addAll(gdl1);
					}
					if(gdl2!=null&&gdl2.size()>0)
					{
						gdetaillist.addAll(gdl2);
					}
				}
				//所需价格
				float sum1=0f;
		        float zhprice=0;
		        int counts=0;
		        float zk=0.95f;
				if(gdetaillist!=null&&gdetaillist.size()>0)
				{
					int gdcount=0;
					for(Gdscolldetail gd:gdetaillist)
					{
					    if(gd!=null&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
					    {
					    	Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
					    	if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p))
					    	{
					    		gdcount++;
					    		String gdsimg="";
								ArrayList<GdsCutImg> gdclist=getByGdsid(p.getId());
								if(gdclist!=null&&gdclist.size()>0&&gdclist.get(0)!=null)
								{
									GdsCutImg gci=gdclist.get(0);
									if(gci.getGdscutimg_100()!=null&&gci.getGdscutimg_100().length()>0)
									{
									   gdsimg="http://images.d1.com.cn/"+gci.getGdscutimg_100();
									}
									else
									{
										gdsimg=ProductHelper.getImageTo120(p);
									}
								}
								else
								{
									gdsimg=ProductHelper.getImageTo120(p);
								}
								
								String str="";
					    	    if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1){
					    	    	str="checked";
					    	    	sum1+=p.getGdsmst_memberprice().floatValue();
				    	    		zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*zk), 2);
								    counts++;
					    	    }
					    	    sb1.append("<li style=\"position:relative;\"><a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\" style=\"border:solid 1px #000;background:#fff;\"></a><br/>");
				    	        sb1.append("<input type=\"checkbox\" name=\"chk_"+i+"\" "+ str+ " value=\""+gd.getGdscolldetail_gdsid()+"\"  onClick=\"selectInitdp1211('"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"',this.checked,"+i+",'"+gd.getGdscolldetail_gdsid()+"')\">&nbsp;"+gd.getGdscolldetail_title()+"&nbsp;<font style=\"color:#be0000\">￥"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"</font>");       
					    	    sb1.append("<span id=\"span"+p.getId()+i+"\" style=\"position: absolute;top:1px;left:25px;_left:10px;width: 100px;height: 100px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4; ");
					    	    if(str.length()>0)
					    	    {
					    	    	sb1.append("display:none;");
					    	    }
					    	    else
					    	    {
					    	    	sb1.append("display:block;");
					    	    }
					    	    sb1.append("\"></span>");
				    	        sb1.append(" </li>");
					    	}
					    	
	    	             
					    }
					    
					}
					 sb1.append("</ul>");
					 sb1.append("</div>");
					//是否显示上下按钮
	    			 if(gdcount>4)
		             {
	    				 sb1.append("<input id=\"hidden"+i+"\" type=\"hidden\" attr=\""+0+"\"/>");
	    				 sb1.append(" <div class=\"preNext1 pre20121\">");
	    				 sb1.append("<a href=\"javascript:void(0)\" onclick=\"scoll0718t('"+i+"',this);\"><img id=\"tprev"+i+"\" src=\"http://images.d1.com.cn/images2012/index2012/JULY/jts.png\" width=\"68\" height=\"23\"></a>");
						 sb1.append("</div>");
						 sb1.append("<div class=\"preNext1 next20121\">");
						 sb1.append("<a href=\"javascript:void(0)\" onclick=\"scoll0718b('"+i+"',this);\"><img id=\"bprev"+i+"\" src=\"http://images.d1.com.cn/images2012/index2012/JULY/jtx.png\" width=\"68\" height=\"23\"></a>");
						 sb1.append("</div>");
				         sb1.append("<div class=\"clear\"></div>");
		             }
					//获取价格字符串
					
					sb2.append("<div style=\"color:#000;\">");
		            sb2.append("<table><tr><td width=\"20\"></td>");
		            sb2.append("<td><br/>共<em id=\"amount"+i+"\">"+ counts+"</em>件<br/><strike>总价：￥<font id=\"memberP"+i+"\">"+(int)sum1 +"</font></strike><br/>组合价：<font color=\"#bc0000\" face=\"微软雅黑\">￥</font><font id=\"pktP"+i+"\" color=\"#bc0000\" face=\"微软雅黑\">"+ (int)zhprice+"</font><br/>共优惠：￥<font id=\"cheap"+i+"\">"+ (int)(sum1-zhprice)+"</font><br/></td>");
		            sb2.append("<td width=\"30\"></td><td><font style=\"font-size:16px; color:#f00;\">搭配购买立享95折！</font><br/><a href=\"javascript:void(0)\" code=\""+gdscoll.getId()+"\" onclick=\"check_gdscoll20120710(this,'"+i+"')\"><img src=\"http://images.d1.com.cn/Index/images/ljgmzh.png\"/></a></td></tr></table>");
    			    sb2.append("</div>");
    			    
	    	        sb.append(sb2);
	    	        sb.append("</div>");
	    	        sb.append(sb1);
	                
	       }
				sb.append("</td></tr></table>");
                sb.append("</li>");
         }
       
       }
       sb.append("</ul></td></tr></table></div>");
    }
	
	
	
	return sb.toString();
}

%>