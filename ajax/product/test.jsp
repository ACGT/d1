<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%!
//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
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

//获取商品详情搭配图的背景图
private static String getBg(String brandid)
{
  if(Tools.isNull(brandid)) return "";
  if(brandid.equals("987")) return "http://images.d1.com.cn/images2012/index2012/feelmind-bg.jpg";
  else if(brandid.equals("1690")) return "http://images.d1.com.cn/images2012/index2012/aleeishe-bg.jpg";
  else if(brandid.equals("1969")) return "http://images.d1.com.cn/images2012/index2012/sheromo-bg.jpg";
  else return "http://images.d1.com.cn/images2012/index2012/aleeishe-bg.jpg";
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


//获取商品详情的搭配显示
private static String getGdscollInDetail1(String outColor,String gdsColor,String overColor,String pid)
{
	if(Tools.isNull(pid)) return "";
	StringBuilder sb=new StringBuilder();
	ArrayList<Gdscoll> gdscolllist=getGdscollByGdsid(pid);
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
								 imgbg=getBg(gdsser.getGdsser_brandid().toString());
							 
						 }
						sb.append("<tr><td><div class=\"gdscollleft\" style=\"background:#").append(gColor).append("\">");
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
									 sb.append("<li onmouseover=\"gdscollover(this,'"+p.getId()+i+"','"+ovColor+"');\" onmouseout=\"gdscollout(this,'"+p.getId()+i+"');\">");
									 sb.append("<span><a href=\"/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a></span>");
									 sb.append("<div>");
									 if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
									 {
									     sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"><img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\" /></div>");
									 }
									 sb.append("<span class=\"span1_1\">");
									 
									 sb.append("["+brandname+"]<br/>");
									 sb.append("<a href=\"/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
									 sb.append("</span>");
									 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue())+"</span>");
									 sb.append("<span class=\"span3_1\">");
									 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
									 {
									          sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this);\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											  sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									 }
									 else
									 {
										 sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
								
									 }
									 sb.append("</span>");
									 sb.append("</div><div class=\"clear\"></div>");
									 sb.append("</li>");
								}
							}
						}
						
						sb.append("</ul></div>");
						
						sb.append("<div class=\"gdscollright\"  style=\"background:#"+gColor+";\">");
						
						sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
						sb.append("<div class=\"textdiv\" >");
						sb.append("<font style=\" font-size:20px; font-weight:bold; display:block; margin-bottom:10px; "+color+" \">"+Tools.clearHTML(gdscoll.getGdscoll_title())+"</font>");
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
								 imgbg=getBg(gdsser.getGdsser_brandid().toString());
							 
						 }
						sb.append("<tr><td><div class=\"gdscollright1\" style=\"background:#").append(gColor).append("\">");
						sb.append("<div style=\"background:url("+imgbg+"); width:360px; height:540px;\">");
						sb.append("<div class=\"textdiv\" >");
						sb.append("<font style=\" font-size:20px; font-weight:bold; display:block; margin-bottom:10px; "+color+" \">"+gdscoll.getGdscoll_title()+"</font>");
						sb.append("</div>");
					    sb.append("<div style=\" width:100%; margin:0px auto; text-align:center;\">");
					    sb.append("<a href=\"/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\"><img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\"  style=\"border:none;\"/></a>");
						sb.append("</div></div></div>"); 
						
						sb.append("<div class=\"gdscollleft1\" style=\"background:#"+gColor+";\">");
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
									 sb.append("<li onmouseover=\"gdscollover(this,'"+p.getId()+i+"','"+ovColor+"');\" onmouseout=\"gdscollout(this,'"+p.getId()+i+"');\">");
									 sb.append("<span><a href=\"/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\"  style=\" vertical-align:middle; background:#fff;\"/></a></span>");
									 sb.append("<div>");
									 if(p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_validflag().longValue()!=1)
									 {
									     sb.append("<div id=\"sq_"+p.getId()+i+"\" class=\"sq\"><img src=\"http://images.d1.com.cn/images2012/index2012/sq.png\" width=\"54\" height=\"54\" style=\"border:none;\" /></div>");
									 }
									 sb.append("<span class=\"span1_1\">");
									 
									 sb.append("["+brandname+"]<br/>");
									 sb.append("<a href=\"/product/"+p.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60)+"</a>");
									 sb.append("</span>");
									 sb.append("<span class=\"span2_1\">会员价：￥"+Tools.floatValue(p.getGdsmst_memberprice().floatValue())+"</span>");
									 sb.append("<span class=\"span3_1\">");
									
									 
									 if(p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1)
									 {
										 
									          sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+" onclick=\"AddGdscollInCart(this);\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addcartnew.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
											  sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
									 }
									 else
									 {
										 sb.append("<a id=\"gwx_"+p.getId()+i+"\" href=\"javascript:void(0)\" attr="+p.getId()+"  style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/zsqh.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
										 sb.append("<a id=\"fav_"+p.getId()+i+"\" href=\"javascript:void(0)\" onclick=\"addFavorite('"+p.getId()+"');\" style=\"display:none;\"><img src=\"http://images.d1.com.cn/images2012/index2012/addf.png\" width=\"85\" height=\"22\" style=\"border:none\"/></a>");
								
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
	
	
  return sb.toString();	
}
%>
<%
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
     Map<String,Object> map = new HashMap<String,Object>();
     result=getGdscollInDetail1(ocolor,gcolor,overcolor,id);
     //out.print("{\"succ\":false,\"message\":\""+id+"\"}");
     
     if(result.length()>0)
     {
    	 map.put("succ",new Boolean(true));
    	 map.put("message",result);
    	 out.print(JSONObject.fromObject(map));
    	// out.print("{\"succ\":false,\"message\":\""+id+"\"}");
    	// out.print("{\"succ\":true,\"message\":\""+result+"\"}");
    	// return;
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"gjhg\"}");
    	 //return;
     }
    

%>
