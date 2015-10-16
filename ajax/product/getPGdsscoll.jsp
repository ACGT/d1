<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%!
//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
private static ArrayList<Gdscoll>  getGdscollByGdsid1(String gdsid)
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

//获取商品详情搭配图的背景图
private static String getBg1(String brandid)
{
  if(Tools.isNull(brandid)) return "";
  if(brandid.equals("987")) return "http://images.d1.com.cn/images2012/index2012/FM-gdbg.jpg";
  else if(brandid.equals("1690")) return "http://images.d1.com.cn/images2012/index2012/aleeishe.jpg";
  else if(brandid.equals("1969")) return "http://images.d1.com.cn/images2012/index2012/srm_bg1.jpg";
  else return "http://images.d1.com.cn/images2012/index2012/aleeishe.jpg";
}

//获取新图
private static ArrayList<GdsCutImg> getByGdsid1(String gdsid){
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


//获取商品详情的搭配显示
private static String getGdscollInDetail1(String outColor,String gdsColor,String overColor,String pid)
{
	if(Tools.isNull(pid)) return "";
	StringBuilder sb=new StringBuilder();
	ArrayList<Gdscoll> gdscolllist1=getGdscollByGdsid1(pid);
	ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
	
	if(gdscolllist1!=null&&gdscolllist1.size()>0)
	{
		for(int i=0;i<gdscolllist1.size();i++)
		{
			Gdscoll g=gdscolllist1.get(i);
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
							if(p!=null&&!p.getId().equals(pid) && p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
							  flag1++;
							}
						}
					}
				}
				if(flag1>0)
				{
					gdscolllist.add(g);
				}
			}
		}
	}
	
	
	
	
	int flag=0;
	if(gdscolllist!=null&&gdscolllist.size()>0)
	{
		for(int i=0;i<gdscolllist.size();i++)
		{
			Gdscoll gdscoll=gdscolllist.get(i);
			if(gdscoll!=null)
			{
				flag++;
				if(flag>5)
				{
					break;
				}
				String ocolor=outColor;
				String gColor=gdsColor;
				String ovColor=overColor;
				
				 //获取系列
				Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
              
				
				 if(gdsser!=null)
				 {
					 
						 if(gdsser.getGdsser_brandid().equals("987"))
						 {
							 if(ocolor.length()<=0)
							 {
								 ocolor="e8e7e4";
							 }
							 if(gColor.length()<=0)
							 {
								 gColor="d3d0cb";
							 }
							 if(ovColor.length()<=0)
							 {
								 ovColor="f7f7f6";
							 }
								 	 }
						 else if(gdsser.getGdsser_brandid().equals("1690"))
						 {
							 if(ocolor.length()<=0)
							 {
								 ocolor="ffd1e0";
							 }
							 if(gColor.length()<=0)
							 {
								 gColor="ebbcc7";
							 }
							 if(ovColor.length()<=0)
							 {
								 ovColor="fff1f5";
							 }
							
						 }
						 else if(gdsser.getGdsser_brandid().equals("1969"))
						 {
							 if(ocolor.length()<=0)
							 {
								 ocolor="eed7c0";
							 }
							 if(gColor.length()<=0)
							 {
								 gColor="d8c1aa";
							 }
							 if(ovColor.length()<=0)
							 {
								 ovColor="faf3eb";
							 }
							 
						 }
						 else
						 {
							 if(ocolor.length()<=0)
							 {
								 ocolor="e8e7e4";
							 }
							 if(gColor.length()<=0)
							 {
								 gColor="d3d0cb";
							 }
							 if(ovColor.length()<=0)
							 {
								 ovColor="f7f7f6";
							 }
							
						 }
				 }
				 else
				 {
					 if(ocolor.length()<=0)
					 {
						 ocolor="e8e7e4";
					 }
					 if(gColor.length()<=0)
					 {
						 gColor="d3d0cb";
					 }
					 if(ovColor.length()<=0)
					 {
						 ovColor="f7f7f6";
					 }
				 }
				if((i+1)%2==1)
				{
			
					sb.append("<table class=\"detail_gdscoll\" style=\"background:#").append(ocolor).append("\" cellpadding=\"0\" cellspacing=\"0\">");
					ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
				
						String brandname="";
						String imgbg="";
						 //获取系列
						//Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
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
								 imgbg=getBg1(gdsser.getGdsser_brandid().toString());
							 
						 }
						sb.append("<tr><td><div class=\"gdscollleft\" style=\"background:#").append(gColor).append("; overflow:hidden;\">");
						sb.append("<ul>");
						//所需价格
						float sum1=0f;
				        float zhprice=0;
				        int counts=0;
				        float zk=0.95f;
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
					    	    		zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*zk), 2);
									    counts++;
									}	 
									String gdsimg="";
									ArrayList<GdsCutImg> gdclist=getByGdsid1(p.getId());
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
									 sb.append("<li onmouseover=\"pgdscollover(this,'"+p.getId()+i+"','"+ovColor+"');\" onmouseout=\"pgdscollout(this,'"+p.getId()+i+"');\">");
									 String check="";
									 if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
									 {
										 check="checked=\"checked\"";
									 }
									 sb.append("<span style=\"position:relative;+position:static;width:122px;+width:126px;\"><input type=\"checkbox\" "+check+" name=\"chkstj_"+i+"\" value=\""+p.getId()+"\" onClick=\"choosedptj1('"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"',this.checked,"+i+",'"+p.getId()+"')\" style=\"margin-right:4px;\"/><a href=\"/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a>");
									 sb.append("<span id=\"spandp"+p.getId()+i+"\" style=\"position: absolute;+position:static; float:right;+margin-top:-102px; top:2px;right:1px;width: 99px;height: 99px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;");
									 if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
									 {
										 sb.append(" display:none;");
									 }
									 else
									 {
										 sb.append(" display:block;");
									 }
									 sb.append(" \"></span>");
									 sb.append("</span>");
									 sb.append("<div>");
									 //if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
									// {
									    // sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"><img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\" /></div>");
									// }
									 sb.append("<span class=\"span1_1\">");
									 if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().length()>0)
									 {
									     sb.append("["+p.getGdsmst_brandname()+"]<br/>");
									 }
									 else
									 {
										 sb.append("<br/>");
									 }
									 sb.append("<a href=\"/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
									 sb.append("</span>");
									 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue())+"</span>");
									 sb.append("<span class=\"span3_1\">");
									 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
									 {
									          sb.append("<a id=\"pgwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this);\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											  sb.append("<a id=\"pfav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									 }
									 else
									 {
										 sb.append("<a id=\"pgwx_"+p.getId()+i+"\" href=\"javascript:void(0)\"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 sb.append("<a id=\"pfav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
								
									 }
									 sb.append("</span>");
									 sb.append("</div><div class=\"clear\"></div>");
									 sb.append("</li>");
								}
							}
						}
						
						sb.append("</ul>");
						sb.append("<div style=\"width:100%; padding-top:25px; padding-bottom:25px; line-height:20px; font-size:13px; padding-left:30px;\"><table><tr><td width=\"130\">共&nbsp;<font id=\"amountstj"+i+"\">"+counts+"</font>&nbsp;件<br/>总价：￥<font id=\"memberPstj"+i+"\">"+(int)sum1+"</font><br/><font color='cf0200'><b>组合价：￥<font id=\"pktPstj"+i+"\">"+(int)zhprice+"</font></b></font><br/>共优惠：￥<font id=\"cheapstj"+i+"\">"+(int)(sum1-zhprice)+"</font></td><td><font style=\"font-size:16px; color:#f00;\">搭配购买立享95折！</font><br/></br/><a href=\"javascript:void(0)\" code=\""+gdscoll.getId()+"\" onclick=\"add_gdscolltj(this,'"+i+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/zhgm_cj.jpg\"/></a></td></tr></table></div>");
						sb.append("</div>");
					    sb.append("</div>");
						
						sb.append("<div class=\"gdscollright\"  style=\"background:#"+gColor+";\">");
						
						sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
						sb.append("<div class=\"textdiv\" >");
						sb.append("<font style=\" font-size:18px; font-family:'微软雅黑'; font-weight:bold; display:block; margin-bottom:10px; "+color+" \">"+Tools.clearHTML(gdscoll.getGdscoll_title())+"</font>");
						sb.append("</div>");
					    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
					    sb.append("<a href=\"/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
						sb.append("</div></div></div>"); 
						sb.append("</td></tr>");
						sb.append("</table>");						
				}
				else
				{
			
					sb.append("<table class=\"detail_gdscoll\" style=\"background:#").append(ocolor).append("\" cellpadding=\"0\" cellspacing=\"0\">");
					ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
				
						String brandname="";
						String imgbg="";
						 //获取系列
						//Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gdscoll.getGdscoll_serid().toString());
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
								 imgbg=getBg1(gdsser.getGdsser_brandid().toString());
							 
						 }
						sb.append("<tr><td><div class=\"gdscollright1\" style=\"background:#").append(gColor).append("; overflow:hidden;\">");
						sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
						sb.append("<div class=\"textdiv\" >");
						sb.append("<font style=\" font-size:18px; font-family:'微软雅黑'; font-weight:bold; display:block; margin-bottom:10px; "+color+" \">"+gdscoll.getGdscoll_title()+"</font>");
						sb.append("</div>");
					    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
					    sb.append("<a href=\"/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
						sb.append("</div></div></div>"); 
						
						sb.append("<div class=\"gdscollleft1\" style=\"background:#"+gColor+"; overflow:hidden;\">");
						sb.append("<ul>");
						//所需价格
						float sum1=0f;
				        float zhprice=0;
				        int counts=0;
				        float zk=0.95f;
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
					    	    		zhprice+=Tools.getFloat((int)(p.getGdsmst_memberprice().floatValue()*zk), 2);
									    counts++;
									}	 
									String gdsimg="";
									ArrayList<GdsCutImg> gdclist=getByGdsid1(p.getId());
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
									 sb.append("<li onmouseover=\"pgdscollover(this,'"+p.getId()+i+"','"+ovColor+"');\" onmouseout=\"pgdscollout(this,'"+p.getId()+i+"');\">");
									 String check="";
									 if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
									 {
										 check="checked=\"checked\"";
									 }
									 sb.append("<span style=\"position:relative;+position:static; width:122px; +width:126px;\"><input type=\"checkbox\" "+check+" name=\"chkstj_"+i+"\" value=\""+p.getId()+"\" onClick=\"choosedptj1('"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"',this.checked,"+i+",'"+p.getId()+"')\" style=\"margin-right:4px;\"/><a href=\"/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a>");
									 sb.append("<span id=\"spandp"+p.getId()+i+"\" style=\"position: absolute;+position:static; float:right;+margin-top:-102px; top:2px;right:1px;width: 99px;height: 99px;background-color: #ccc;filter: alpha(opacity=40);-moz-opacity: 0.4;opacity: 0.4;");
									 if(gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
									 {
										 sb.append(" display:none;");
									 }
									 else
									 {
										 sb.append(" display:block;");
									 }
									 sb.append(" \"></span>");
									 sb.append("</span>");
									 sb.append("<div>");
									 //if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
									 //{
									     //sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"><img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\" /></div>");
									// }
									 sb.append("<span class=\"span1_1\">");
									 
									 if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().length()>0)
									 {
									     sb.append("["+p.getGdsmst_brandname()+"]<br/>");
									 }
									 else
									 {
										 sb.append("<br/>");
									 }
									 sb.append("<a href=\"/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
									 sb.append("</span>");
									 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue())+"</span>");
									 sb.append("<span class=\"span3_1\">");
									
									 
									 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
									 {
										 
									          sb.append("<a id=\"pgwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this);\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											  sb.append("<a id=\"pfav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									 }
									 else
									 {
										 sb.append("<a id=\"pgwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 sb.append("<a id=\"pfav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
								
									 }
									 sb.append("</span>");
									 sb.append("</div><div class=\"clear\"></div>");
									 sb.append("</li>");
								}
							}
						}
						
						sb.append("</ul>");
						sb.append("<div style=\"width:100%; padding-top:25px; padding-bottom:25px; line-height:20px; font-size:13px; padding-left:30px;\"><table><tr><td width=\"130\">共&nbsp;<font id=\"amountstj"+i+"\">"+counts+"</font>&nbsp;件<br/>总价：￥<font id=\"memberPstj"+i+"\">"+(int)sum1+"</font><br/><font color='cf0200'><b>组合价：￥<font id=\"pktPstj"+i+"\">"+(int)zhprice+"</font></b></font><br/>共优惠：￥<font id=\"cheapstj"+i+"\">"+(int)(sum1-zhprice)+"</font></td><td><font style=\"font-size:16px; color:#f00;\">搭配购买立享95折！</font><br/></br/><a href=\"javascript:void(0)\" code=\""+gdscoll.getId()+"\" onclick=\"add_gdscolltj(this,'"+i+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/zhgm_cj.jpg\"/></a></td></tr></table></div>");
						sb.append("</div>");
						sb.append("</div>");
						sb.append("</td></tr>");
						sb.append("</table>");
				}
			
			}
					
		}
      
	}
	
	
  return sb.toString();	
}
%>
<%
Map<String,Object> map = new HashMap<String,Object>();
     String id="";
     String ocolor="";
     String gcolor="";
     String overcolor="";
     if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
     {
    	 id=request.getParameter("id");
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
    	 return;
     }
     if(!Tools.isNumber(id))
     {
    	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
    	 return;
     }
     if(request.getParameter("param1")!=null&&request.getParameter("param1").length()>0)
     {
    	 ocolor=request.getParameter("param1");
     }
     if(request.getParameter("param2")!=null&&request.getParameter("param2").length()>0)
     {
    	 gcolor=request.getParameter("param2");
     }
     if(request.getParameter("param3")!=null&&request.getParameter("param3").length()>0)
     {
    	 overcolor=request.getParameter("param3");
     }
     
     String result="";
     result=getGdscollInDetail1(ocolor,gcolor,overcolor,id);
     if(result.length()>0)
     {
    	 map.put("succ",new Boolean(true));
    	 map.put("message",result);
    	 out.print(JSONObject.fromObject(map));

     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"\"}");
    	 return;
     }
     

%>
