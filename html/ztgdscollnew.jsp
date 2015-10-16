<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

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
private static String getGdscollInGdsscene20120713(String code)
{
	 ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,6);
	 ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
		if(list!=null){
			
			for(Promotion promotion:list){
				Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(promotion.getSplmst_url());
				if(gdscoll!=null)
				{
					 gdscolllist.add(gdscoll);
				}
			}
			
			}
		else return "";
	StringBuilder sb=new StringBuilder();

	
	//System.out.println(gdscolllist.size()+"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    if(gdscolllist!=null&&gdscolllist.size()>0)
    {
    	String backimg="http://images.d1.com.cn/zt2012/20121108qcdp/xls.jpg";
    	if("3274".equals(code) || "3275".equals(code) || "3276".equals(code)){
    		backimg="http://images.d1.com.cn/zt2012/20121108qcdp/xls.jpg";
    	}else if("3277".equals(code)){
    	 backimg="http://images.d1.com.cn/zt2012/20121108qcdp/fm.jpg";
    	}else if("3278".equals(code)||"3279".equals(code)||"3280".equals(code)){
       	 backimg="http://images.d1.com.cn/zt2012/20121108qcdp/srm.jpg";
       	}
        sb.append("<div class=\"gdscoll20120713\" >");
       sb.append("<table><tr><td><ul>");
       int ss=0;
       for(int i=1;i<=gdscolllist.size();i++)
       {
    	   Gdscoll gdscoll=gdscolllist.get(i-1);
    	   if(gdscoll!=null&&gdscoll.getGdscoll_flag()!=null&&gdscoll.getGdscoll_flag().longValue()==1)
    	   {
    		   ss++;
    		  // System.out.println(gdscoll.getId()+"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
	    	   StringBuilder sb1=new StringBuilder();
	    	   StringBuilder sb2=new StringBuilder();//价格字符串
	    	   sb.append("<li><table><tr><td>");
	    	   sb.append("<div class=\"leftg\">");
	    	   sb.append("<div style=\"width:200px;_width:200px; height:490px; overflow:hidden;\">");
	    	  
	    	   sb.append("<a href=\"http://www.d1.com.cn/gdscoll/index.jsp?id="+gdscoll.getId()+"\" target=\"_blank\" style=\"position:absolute;margin-left:-60px;+position:relative;\">");
	    	  
	    	  
	    	   sb.append("<img src=\"http://images1.d1.com.cn"+gdscoll.getGdscoll_bigimgurl()+"\" /> </a> </div><div class=\"clear\"></div>");
	    	   sb.append("</div>");	
	    	   sb1.append(" <div class=\"rightg\"><div id=\"scoll"+code+i+"\" class=\"newsubgdscoll\">");
	    	   sb1.append("<div id=\"scolllist"+code+i+"\" style=\"position:relative; height:395px;width:110px;overflow:hidden;\">");
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
					    	    sb1.append("<li><a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\"><img src=\""+gdsimg+"\" width=\"100\" height=\"100\" ></a><br/>");
				    	        sb1.append("<input type=\"checkbox\" name=\"chk_"+code+i+"\" "+ str+ " value=\""+gd.getGdscolldetail_gdsid()+"\"  onClick=\"selectInitdp('"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"',this.checked,"+code+i+")\">"+gd.getGdscolldetail_title()+"<font style=\"color:#be0000\">￥"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"</font>");       
					    	    sb1.append(" </li>");
					    	}
					    	
	    	             
					    }
					    
					}
					 sb1.append("</ul>");
					 sb1.append("</div>");
					//是否显示上下按钮
	    			 if(gdcount>3)
		             {
	    				 sb1.append("<input id=\"hidden"+code+i+"\" type=\"hidden\" attr=\""+0+"\"/>");
	    				 sb1.append(" <div class=\"preNext1 pre20121\">");
	    				 sb1.append("<a href=\"javascript:void(0)\" onclick=\"scoll1119zt('"+code+i+"',this);\"><img id=\"tprev"+code+i+"\" src=\"http://images.d1.com.cn/images2012/index2012/JULY/jts.png\" width=\"68\" height=\"23\"></a>");
						 sb1.append("</div>");
						 sb1.append("<div class=\"preNext1 next20121\">");
						 sb1.append("<a href=\"javascript:void(0)\" onclick=\"scoll1119zt('"+code+i+"',this);\"><img id=\"bprev"+code+i+"\" src=\"http://images.d1.com.cn/images2012/index2012/JULY/jtx.png\" width=\"68\" height=\"23\"></a>");
						 sb1.append("</div>");
				         sb1.append("<div class=\"clear\"></div>");
		             }
					//获取价格字符串
					
					sb2.append("<div style=\"color:#333; background:url('http://images.d1.com.cn/images2012/index2012/nov/dp2.png') no-repeat; height:110px; width:323px; overflow:hidden;\">");
		            sb2.append("<table><tr><td height=\"5\" coslpan=\"3\"></td></tr>");
		            if(ss<10)
		            {
		            	sb2.append("<tr><td width=\"60\" height=\"100\" style=\"text-align:center; font-size:40px; font-family:'微软雅黑'; color:#fff;\">0"+ss+"</td>");
		            	
		            }
		            else
		            {
		            	sb2.append("<tr><td width=\"60\" height=\"100\" style=\"text-align:center; font-size:40px; font-family:'微软雅黑'; color:#fff;\">"+ss+"</td>");
		            }
		            
		            sb2.append("<td style=\"padding-left:7px; background:#ccc; text-align:left;\" width=\"110\"><br/>共<em id=\"amount"+code+i+"\">"+ counts+"</em>件<br/><strike>总价：￥<font id=\"memberP"+code+i+"\">"+(int)sum1 +"</font></strike><br/><font style=\"font-size:12px;font-weight:bold;\" face=\"微软雅黑\">组合价：￥</font><font id=\"pktP"+code+i+"\" style=\"font-size:12px;font-weight:bold; color:#bc0000;\" face=\"微软雅黑\">"+ (int)zhprice+"</font><br/>共优惠：￥<font id=\"cheap"+code+i+"\">"+ (int)(sum1-zhprice)+"</font><br/><br/></td>");
		            sb2.append("<td style=\"background:#ccc; width:153px;\"><font style=\"font-size:12px;font-weight:bold; color:#bc0000;\">搭配购买立享95折！</font><br/><a href=\"javascript:void(0)\" code=\""+gdscoll.getId()+"\" onclick=\"check_gdscoll20120710(this,'"+code+i+"')\"><img src=\"http://images.d1.com.cn/Index/images/ljgmzh.png\" /></a></td></tr></table>");
		    		
		            sb2.append("</div>");
    			    
    			    
    			    sb1.append("</div></div>");   			   
    			    
	    	        sb.append(sb1);	    	       
	    	        sb.append(sb2);
	    	        
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
<%
if(request.getAttribute("code")!=null){
	 String code=request.getAttribute("code").toString();
	 out.print(getGdscollInGdsscene20120713(code));
}
%>