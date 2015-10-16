<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/inc/header.jsp"%><%!

//获取tag
private static String getTag(String code,String flag)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	StringBuilder sb1 = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		int size = recommendList.size();
		sb.append("<ul class=\"tabAuto").append(flag).append("\">");
		sb1.append("<div class=\"tgh-box").append(flag).append("\">");
		for(int i=0;i<size;i++){
			Promotion recommend = recommendList.get(i);
   		String title = recommend.getSplmst_name();
   		sb.append("<li>").append(title).append("</li>");
   		sb1.append("<div><a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\"").append(" target=\"_blank\">").append("<img src=\"").append(recommend.getSplmst_picstr()).append("\" width=\"980\" height=\"531\"  />").append("</a></div>");
   		
		}
		sb.append("</ul><div class=\"clear\"></div>");
		sb1.append("</div>");
	}
	return sb.append(sb1.toString()).toString();


}

//获取商品
private String getProduct(String gdsid,int w,String price1,int flags,String tf)
{
	StringBuilder sb=new StringBuilder();
    if(gdsid.length()<=0) return "";
    int width=0;
    float price=0;
    width=w;
    price=Tools.parseFloat(price1);
    int flag=1;
    flag=flags;
    Product product=ProductHelper.getById(gdsid);
    if(product!=null)
    {
 	 //获取背景图片
 		String bg="";
 		String namec="";
 		String mpc="";
 		String sc="";
 		String bgc="";
 		String border="#545454";
 		String tbimg="";
 	
 		if(flag==1||flag==2||flag==3||flag==4||flag==11)
 		{
 			namec=" color:#7f7f7f";
 			mpc=" color:#b80024";
 			sc=" color:#333";
 			bgc="#d8d8d8";
 			border="#545454";
 			if(width<=784){
 			   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/fl1.png";
 			}
 			else
 			{
 				 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/fr1.png";
 			}
 		}

 		if(flag==8||flag==9||flag==10)
 		{
 			namec=" color:#858178";
 			mpc=" color:#b80024";
 			sc=" color:#ca0000";
 			bgc="#dbd5c7";
 			border="#a99c94";
 			if(width<=784){
 				   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/sl1.png";
 				}
 				else
 				{
 					 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/sr1.png";
 				}
 		}
 		if(flag==5||flag==6||flag==7)
 		{
 			namec=" color:#cf85a8";
 			mpc=" color:#fff";
 			sc=" color:#fff";
 			bgc="#b2366c";
 			border="#722245";
 			if(width<=784){
 				   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/al1.png";
 				}
 				else
 				{
 					 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/ar1.png";
 				}
 		}
 	    String imgurl="";
 		 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
 		 if(gcilist!=null&&gcilist.size()>0)
 		 {
 			 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
 			 {
 				 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
 			 }
 			 else
 			 {
 				 imgurl=ProductHelper.getImageTo160(product);
 			 }
 		 }
 		 else
 		 {
 			 imgurl=ProductHelper.getImageTo160(product);
 		 }
 		 String floats="";
 		 if(width>784)
 		 {
 			 floats="left";
 		 }
 		 else
 		 {
 			 floats="right";
 		 }
 		 
 		 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
 		 long currentTime = System.currentTimeMillis();
 		  String tbtop="";
 		  if(tf.equals("1"))
 		  {
 			  tbtop="60px;";
 		  }
 		  else if(tf.equals("2"))
 		  {
 			  tbtop="130px;";
 		  }
 		  else
 		  {
 			  tbtop="210px;";
 		  }
 		
 		  if(width<=784){
           sb.append("<img src=\""+tbimg+"\" style=\"position:absolute; top:"+tbtop+"\"/>");
 		  } 
 		  sb.append("<span style=\"display:block;padding-bottom:5px; width:176px; overflow:hidden;border:solid 2px "+border+"; background:"+bgc+";float:"+ floats+"\">");
 		  sb.append("<table style=\" width:176px; overflow:hidden;\" cellspcing=\"0\" cellpadding=\"0\">");
 	     if(width>784){
 	    	 sb.append("<tr><td width=\"8\"></td><td height=\"8\"></td><td width=\"8\"></td></tr>");
 	    	 sb.append("<tr><td></td><td>");
 			 sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\" ><img src=\""+ imgurl +"\"  style=\"background:#fff;\"/></a></td>");
 			 sb.append("<td></td></tr>");
 			 sb.append("<tr><td coslpan=\"3\" height=\"3\"></td></tr>");
 			 sb.append("<tr><td width=\"8\"></td>");
 			 sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+ product.getId()+"&sp_id=1212236301\" target=\"_blank\" style=\"font-size:13px;"+ namec+"\">");
 			 sb.append(Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)+"</a></td><td></td></tr>");
 			 sb.append("<tr><td coslpan=\"3\" height=\"4\"></td></tr>");
 			 sb.append("<tr><td width=\"8\"></td><td style=\" text-align:center;\">");
 			 if(price==0)
 			 {
 				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+ Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>");
 			 }
 			 else{
 				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+price+"</b></font>");
 			 }
 			 sb.append("</td><td></td></tr>");
 		 
 		}
 	    else
 		{
 			sb.append("<tr><td width=\"8\"></td><td width=\"8\"></td><td height=\"8\"></td></tr>");
	    	 sb.append("<tr><td></td><td>");
			 sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\" ><img src=\""+ imgurl +"\"  style=\"background:#fff;\"/></a></td>");
			 sb.append("<td width=\"8\"></td></tr>");
			 sb.append("<tr><td coslpan=\"3\" height=\"3\"></td></tr>");
			 sb.append("<tr><td width=\"8\"></td>");
			 sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id="+ product.getId()+"&sp_id=1212236301\" target=\"_blank\" style=\"font-size:13px;"+ namec+"\">");
			 sb.append(Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)+"</a></td><td></td></tr>");
			 sb.append("<tr><td coslpan=\"3\" height=\"4\"></td></tr>");
			 sb.append("<tr><td width=\"8\"></td><td style=\" text-align:center;\">");
			 if(price==0)
 			 {
 				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+ Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>");
 			 }
 			 else{
 				sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+ mpc+"\">聚惠价：<b>￥"+price+"</b></font>");
 			 }
			 sb.append("</td><td width=\"8\"></td></tr>");
 			
       }
 	     sb.append("</table>");
         sb.append("</span>");
         if(width>784){
    		  sb.append("<img src=\""+ tbimg +"\"  style=\"position:absolute; right:0px; top:"+ tbtop+"\"/>"); 		  
    	 } 
     }
    else
    {
    	return "";
    }

    return sb.toString();
    
}


   
  
  




//获取首页搭配
private static String getGdscollByPromotion(String code,int flag)
{
    if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
    StringBuilder sb1=new StringBuilder();
    StringBuilder sb2=new StringBuilder();
    ArrayList<Promotion> plist=new ArrayList<Promotion>();
    plist=PromotionHelper.getBrandListByCode(code,10);
    if(plist!=null&&plist.size()>0&&plist.get(0)!=null&&plist.get(0).getSplmst_url()!=null&&plist.get(0).getSplmst_url().length()>0)
    {
    	Promotion p=plist.get(0);
    	String dpstr=plist.get(0).getSplmst_url();
    	dpstr.replace("，", ",");
    	String[] str=dpstr.split(",");
    	if(str.length>0)
    	{
    		int sum=0;
    	    sb1.append("<tr><td><ul>");
    	    sb2.append("<tr><td style=\"padding-top:5px; padding-bottom:5px;\">");
    		for(int i=0;i<str.length;i++)
    		{
    			if(str[i].length()>0&&Tools.isNumber(str[i])){
    			   Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(str[i]);
    			   if(gdscoll!=null)
    			   {
    				   sum++;
    				   if(sum>5) break;
    				   String imgwh="";
    				   if(flag==1)
    				   {
    					   imgwh=" width=\"238\" height=\"343\"";   
    				   }
    				   else
    				   {
    					   imgwh=" width=\"243\" height=\"350\""; 
    				   }
    				   if(sum==1)
    				   {
    					   sb1.append("<li style=\"margin-left:0px;\"><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\" >");
    					   sb1.append("<img src=\"http://images1.d1.com.cn").append(gdscoll.getGdscoll_brandimg()!=null&&gdscoll.getGdscoll_brandimg().length()>0?gdscoll.getGdscoll_brandimg():"").append("\"").append(imgwh).append("/></a></li>");
    				       sb2.append("<div style=\"padding-left:30px; width:175px; display:block; \">");
    				   }
    				   else
    				   {
    					   sb1.append("<li><a href=\"/gdscoll/index.jsp?id=").append(gdscoll.getId()).append("\" target=\"_blank\" >");
    					   sb1.append("<img src=\"http://images1.d1.com.cn").append(gdscoll.getGdscoll_brandimg()!=null&&gdscoll.getGdscoll_brandimg().length()>0?gdscoll.getGdscoll_brandimg():"").append("\"").append(imgwh).append("/></a></li>");
    					   sb2.append("<div  style=\"padding-left:14px; width:175px; display:block; \">");
    				   }
    				   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
    				   if(gdlist!=null&&gdlist.size()>0)
    				   {
    					   int newsum=0;
    					   for(Gdscolldetail gd:gdlist)
    					   {
    						   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
    						   {
    							   newsum++;
    							   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
    							   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
    							   {
    								   sb2.append("<span><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=").append(product.getId()).append("&sp_id=1212236301\" target=\"_blank\">").append(gd.getGdscolldetail_title()).append("</a>&nbsp;<font>").append(Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())).append("</font></span>");
    							   }
    						   }
    						   
    					   }
    					   
    					   
    				   } 
    				   
    				   sb2.append("</div>");
    				   
    			   }
    			}
    		}
    		
    		sb1.append("</ul></td></tr>");
    		sb2.append("</td></tr>");
    	}
    }
    sb1.append(sb2);
    return sb1.toString();
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
private String getimglist(String code,int length,int flag)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		//int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				StringBuilder map=new StringBuilder();
				//i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				sb.append("<li>");
			
				sb.append("<img src=\""+p.getSplmst_picstr()+"\" width=\"980\"   usemap=\"#img_"+flag+"\"/>");
				map.append("<map name=\"img_").append(flag).append("\" id=\"").append("img_").append(flag).append("\">");
				//sb.append("<div>");
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						left=pip.getPos_x()+70;
						if(left>784)
						{
							left=pip.getPos_x()-166;
						}
						top=pip.getPos_y();
						//int divtop=0;
						//if(top+40>350)
						//{
							//divtop=350;
						//}
						//else
							//divtop=top+10;
						
						String endtop="";
						if(top>160)
						{
							endtop=" bottom:0px;";
						}
						else
						{
							endtop=" top:10px;";
						}
						//获取背景图片
						String bg="";
						String namec="";
						String mpc="";
						String sc="";
						if(flag==1||flag==2||flag==3||flag==4)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png);";
							}
							else
							{
							   bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/Fm.png);";
							}
							namec=" color:#7f7f7f";
							mpc=" color:#b80024";
							sc=" color:#333";
						}

						if(flag==8||flag==9||flag==10)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/sheromo1.png);";
							}
							else
							{
							   bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/sheromo.png);";
							}
							namec=" color:#858178";
							mpc=" color:#b80024";
							sc=" color:#ca0000";
						}
						if(flag==5||flag==6||flag==7)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/aleeishe1.png);";
							}
							else
							{
							    bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/aleeishe.png);";
							}
							namec=" color:#cf85a8";
							mpc=" color:#fff";
							sc=" color:#fff";
						}
						
						sb.append("<div id=\"div_"+pip.getId()+"\" style=\"left:"+left+"px;"+ endtop +bg+"\" onmouseover=\"mdmoverf("+ pip.getId()+")\" onmouseout=\"mdmoutf("+pip.getId()+")\" >");
						map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\" onmouseover=\"mdmoverf("+ pip.getId()+")\" onmouseout=\"mdmoutf("+pip.getId()+")\""); 
						
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							 String imgurl="";
							 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
							 if(gcilist!=null&&gcilist.size()>0)
							 {
								 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
								 {
									 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
								 }
								 else
								 {
									 imgurl=ProductHelper.getImageTo160(product);
								 }
							 }
							 else
							 {
								 imgurl=ProductHelper.getImageTo160(product);
							 }
							 
							 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
			     			 long currentTime = System.currentTimeMillis();
			     			 if((pip.getPos_x()+70)>784){
								 sb.append("<table><tr><td width=\"9\"></td><td height=\"8\"></td><td width=\"27\"></td></tr><tr><td width=\"10\"></td><td>");
								 sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=").append(product.getId()).append("&sp_id=1212236301\" target=\"_blank\"><img src=\""+imgurl+"\"/></a></td><td width=\"27\"></td></tr>");
								 sb.append("<tr><td coslpan=\"3\" height=\"3\"></td></tr>");
								 sb.append("<tr><td width=\"8\"></td><td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=").append(product.getId()).append("&sp_id=1212236301\" target=\"_blank\" style=\"font-size:13px;"+ namec+"\">"+Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)+"</a></td><td width=\"27\"></td></tr>");
								 sb.append("<tr><td coslpan=\"3\" height=\"8\"></td></tr>");
								 sb.append("<tr><td width=\"8\"></td><td style=\" text-align:center;\">");
								 if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
								 sb.append("<font style=\" font-family:微软雅黑; font-size:13px;"+ mpc+"\"><b>特价：￥"+Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>&nbsp;&nbsp;&nbsp;&nbsp;");
								 sb.append("<font style=\"text-decoration:line-through;"+sc+"\">￥"+Tools.getFormatMoney(product.getGdsmst_oldmemberprice())+"</font>");
						
								}else
								{
									sb.append("<font style=\" font-family:微软雅黑;font-size:13px;"+mpc+"\"><b>￥"+Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>");
								}
							// sb.append("<font class=\"font1\">￥"+Tools.getRoundPrice(product.getGdsmst_memberprice().floatValue())+"</font>&nbsp;&nbsp;<font class=\"font2\"><strike>￥"+Tools.getRoundPrice(product.getGdsmst_saleprice().floatValue())+"</strike></font><br/>");
							 sb.append("</td><td width=\"20\"></td></tr></table>");
			     			}else
			     			{
			     				 sb.append("<table><tr><td width=\"27\"></td><td height=\"8\"></td><td width=\"8\"></td></tr><tr><td width=\"27\"></td><td>");
								 sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=").append(product.getId()).append("&sp_id=1212236301\" target=\"_blank\"><img src=\""+imgurl+"\"/></a></td></tr>");
								 sb.append("<tr><td coslpan=\"3\" height=\"3\"></td></tr>");
								 sb.append("<tr><td width=\"27\"><td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=").append(product.getId()).append("&sp_id=1212236301\" target=\"_blank\" style=\"font-size:13px;"+namec+"\">"+Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)+"</a></td><td width=\"8\"></td></tr>");
								 sb.append("<tr><td coslpan=\"3\" height=\"8\"></td></tr>");
								 sb.append("<tr><td width=\"20\"></td><td style=\" text-align:center;\">");
								if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
								 sb.append("<font style=\" font-family:微软雅黑; font-size:13px;"+mpc+"\"><b>特价：￥"+Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>&nbsp;&nbsp;&nbsp;&nbsp;");
								 sb.append("<font style=\"text-decoration:line-through;"+sc+"\">￥"+Tools.getFormatMoney(product.getGdsmst_oldmemberprice())+"</font>");
						
								}else
								{
									sb.append("<font  style=\" font-family:微软雅黑;font-size:13px;"+mpc+"\"><b>￥"+Tools.getFormatMoney(product.getGdsmst_memberprice())+"</b></font>");
								}
								// sb.append("<font class=\"font1\">￥"+Tools.getRoundPrice(product.getGdsmst_memberprice().floatValue())+"</font>&nbsp;&nbsp;<font class=\"font2\"><strike>￥"+Tools.getRoundPrice(product.getGdsmst_saleprice().floatValue())+"</strike></font><br/>");
								 sb.append("</td><td width=\"8\"></td></tr></table>");
			     			}
							 
							 map.append("href=\"").append("http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\"");
						}
						map.append("/>");
						sb.append("</div>");
							
					}
				}
				//sb.append("</div>");
				map.append("</map>");
				sb.append(map.toString());
				sb.append("</li>");
				
			}
		}
		sb.append("</ul>");
		return sb.toString();
	}
	
	return "";
	
	
	
			
}
private String getimglist1(String code,int length,int flag)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		//int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				StringBuilder map=new StringBuilder();
				//i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				String ss="";
				if(code.equals("3189")||code.equals("3188")||code.equals("3190")){
					ss=" style=\"height:366px;\" ";
				}
				sb.append("<li onmouseout=\"mdmoutf(\\\'"+flag+"\\\')\" "+ss+">");
			
				sb.append("<img src=\""+p.getSplmst_picstr()+"\" width=\"980\"   usemap=\"#img_"+flag+"\"/>");
				map.append("<map name=\"img_").append(flag).append("\" id=\"").append("img_").append(flag).append("\">");
				//sb.append("<div>");
				sb.append("<div id=\"div_"+flag+"\" style=\"background:none;\" onmouseover=\"mdmoverf(\\\'"+ flag+"\\\')\" onmouseout=\"mdmoutf(\\\'"+flag+"\\\')\" ></div>");
						
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						int top1=0;
						int left1=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						//left=pip.getPos_x()+40;
						//价格坐标
						left1=Tools.parseInt(pip.getExt1());
						left=left1-10;
						top1=(Tools.parseInt(pip.getExt2())-pip.getPos_y())/2+pip.getPos_y()-10;
						if(left>784)
						{
							left=pip.getPos_x()-166;
						}
						top=pip.getPos_y()+60;
						//int divtop=0;
						//if(top+40>350)
						//{
							//divtop=350;
						//}
						//else
							//divtop=top+10;
						
						String endtop="";
						String position="";
						String tf="1";
						if(top<160)
						{
							position="top";
							endtop="25px";
							tf="1";
						}
						else if(top>=160&&top<295)
						{
							position="top";
							endtop="60px";
							tf="2";
						}
						else
						{
							position="bottom";
							endtop="0px";
							tf="3";
						}
						
						//获取价格的背景图片
						String pricebg="";
						String pricecolor="";
						if(flag==1||flag==2||flag==3||flag==4||flag==11)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/fmprice1.png";
						
						}

						if(flag==8||flag==9||flag==10)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/srmprice1.png";
						}
						if(flag==5||flag==6||flag==7)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/aprice1.png";
						}
					    map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\" onmouseover=\"mdmoverf1(\\\'"+ pip.getProductId().toString()+"\\\',"+(pip.getPos_x()+70)+",\\\'"+flag+"\\\',\\\'"+left+"px\\\',\\\'"+position+"\\\',\\\'"+endtop+"\\\',\\\'"+tf+"\\\',\\\'"+Tools.getFloat(pip.getPprice(),1)+"\\\')\" onmouseout=\"mdmoutf(\\\'"+flag+"\\\')\" onblur=\"mdmoutf(\\\'"+flag+"\\\')\""); 
						
						
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							 String imgurl="";
							 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
							 if(gcilist!=null&&gcilist.size()>0)
							 {
								 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
								 {
									 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
								 }
								 else
								 {
									 imgurl=ProductHelper.getImageTo160(product);
								 }
							 }
							 else
							 {
								 imgurl=ProductHelper.getImageTo160(product);
							 }
							 
							 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
			     			 long currentTime = System.currentTimeMillis();
			     			 sb.append("<div style=\"display:block; width:34px; height:18px; line-height:18px;left:"+left1+"px; top:"+top1+"px; color:#fff; font-size:14px; padding-left:5px; background:url("+pricebg+") no-repeat;\">&nbsp;"+Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())+"</div>");
			     			 map.append("href=\"").append("http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\"");
						}
						map.append("/>");
						
					}
				}
				//sb.append("</div>");
				map.append("</map>");
				sb.append(map.toString());
				sb.append("</li>");
				
			}
		}
		sb.append("</ul>");
		return sb.toString();
	}
	System.out.print(sb.toString());
	return "";
	
	
	
			
}

private String getimglist2(String code,int length,int flag)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isNumber(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		//int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				StringBuilder map=new StringBuilder();
				//i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				sb.append("<li>");
			
				sb.append("<img src=\""+p.getSplmst_picstr()+"\" width=\"980\"   usemap=\"#img_"+flag+"\"/>");
				map.append("<map name=\"img_").append(flag).append("\" id=\"").append("img_").append(flag).append("\">");
				//sb.append("<div>");
				StringBuilder sb1=new StringBuilder();
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						int top1=0;
						int left1=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						//left=pip.getPos_x()+40;
						//价格坐标
						left1=Tools.parseInt(pip.getExt1());
						left=left1-10;
						top1=(Tools.parseInt(pip.getExt2())-pip.getPos_y())/2+pip.getPos_y()-10;
						if(left>784)
						{
							left=pip.getPos_x()-166;
						}
						top=pip.getPos_y()+60;
						//int divtop=0;
						//if(top+40>350)
						//{
							//divtop=350;
						//}
						//else
							//divtop=top+10;
						
						String endtop="";
						String position="";
						String tf="1";
						if(top<160)
						{
							position="top";
							endtop="25px";
							tf="1";
						}
						else if(top>=160&&top<295)
						{
							position="top";
							endtop="60px";
							tf="2";
						}
						else
						{
							position="bottom";
							endtop="0px";
							tf="3";
						}			
						
						
						
						
						
						//获取背景图片
						String bg="";
						String namec="";
						String mpc="";
						String sc="";
						if(flag==1||flag==2||flag==3||flag==4||flag==11)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/Fm1.png);";
							}
							else
							{
							   bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/Fm.png);";
							}
							namec=" color:#7f7f7f";
							mpc=" color:#b80024";
							sc=" color:#333";
						}

						if(flag==8||flag==9||flag==10)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/sheromo1.png);";
							}
							else
							{
							   bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/sheromo.png);";
							}
							namec=" color:#858178";
							mpc=" color:#b80024";
							sc=" color:#ca0000";
						}
						if(flag==5||flag==6||flag==7)
						{
							if((pip.getPos_x()+70)>784)
							{
								bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/aleeishe1.png);";
							}
							else
							{
							    bg=" background:url(http://images.d1.com.cn/images2012/index2012/JULY/aleeishe.png);";
							}
							namec=" color:#cf85a8";
							mpc=" color:#fff";
							sc=" color:#fff";
						}
						
						sb1.append("<div id=\"div_"+pip.getId()+"\" class=\"hh\" style=\"left:"+left+"px;"+position+":"+ endtop+";\" onmouseover=\"mdmoverf1105("+ pip.getId()+")\" onmouseout=\"mdmoutf1105("+pip.getId()+")\" >");
						
						//获取价格的背景图片
						String pricebg="";
						String pricecolor="";
						if(flag==1||flag==2||flag==3||flag==4||flag==11)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/fmprice1.png";
						
						}

						if(flag==8||flag==9||flag==10)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/srmprice1.png";
						}
						if(flag==5||flag==6||flag==7)
						{
							pricebg="http://images.d1.com.cn/images2012/index2012/JULY/aprice1.png";
						}
					    map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\" onmouseover=\"mdmoverf11105(\\\'"+ pip.getProductId().toString()+"\\\',"+(pip.getPos_x()+70)+",\\\'"+pip.getId()+"\\\',\\\'"+left+"px\\\',\\\'"+position+"\\\',\\\'"+endtop+"\\\',\\\'"+tf+"\\\',\\\'"+Tools.getFloat(pip.getPprice(),1)+"\\\')\" onmouseout=\"mdmoutf(\\\'"+flag+"\\\')\" onblur=\"mdmoutf(\\\'"+flag+"\\\')\""); 
						
						//map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\" onmouseover=\"mdmoverf11105(\\\'"+ pip.getProductId().toString()+"\\\',"+(pip.getPos_x()+70)+","+flag+",\\\'"+pip.getId()+"\\\')\" onmouseout=\"mdmoutf("+pip.getId()+")\""); 
						
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							 String imgurl="";
							 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
							 if(gcilist!=null&&gcilist.size()>0)
							 {
								 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
								 {
									 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
								 }
								 else
								 {
									 imgurl=ProductHelper.getImageTo160(product);
								 }
							 }
							 else
							 {
								 imgurl=ProductHelper.getImageTo160(product);
							 }
							 sb.append("<div style=\"display:block; width:34px; height:18px; line-height:18px;left:"+left1+"px; top:"+top1+"px; color:#fff; font-size:14px; padding-left:5px; background:url("+pricebg+") no-repeat;\">&nbsp;"+Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())+"</div>");
			     			 
							 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
			     			 long currentTime = System.currentTimeMillis();
			     			 sb1.append(getProduct(product.getId(),pip.getPos_x()+70 ,product.getGdsmst_memberprice().toString(),flag,tf));
			     			 map.append("href=\"").append("http://juhui.tenpay.com/commodity_detail.shtml?product_id="+product.getId()+"&sp_id=1212236301\" target=\"_blank\"");
						}
						map.append("/>");
						sb1.append("</div>");
							
					}
				}
				
				sb.append(sb1);
				map.append("</map>");
				sb.append(map.toString());
				sb.append("</li>");
				
			}
		}
		sb.append("</ul>");
		return sb.toString();
	}
	System.out.print(sb.toString());
	return "";
	
	
	
			
}


%>
document.write('<a name=\"as\" id=\"as\"></a>');
document.write('<div id=\"tabAuto1\" style=\"background:none;height:80px;\">');
document.write('<img src=\"http://images.d1.com.cn/images2012/market/121031/xls.jpg\" border=\"0\"/>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3191",1,5) %>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3192",1,6) %>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3193",1,7) %>');
document.write('</div>');

document.write('<a name=\"srm\" id=\"srm\"></a>');
document.write('<div id=\"tabAuto2\" style=\"background:none; height:60px;\">');
document.write('<img src=\"http://images.d1.com.cn/images2012/market/121031/snm.jpg\" border=\"0\"/>');document.write('</div>');
document.write('<div class=\"newgdscoll\">');

document.write('<%= getimglist2("3189",1,8) %>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3188",1,9) %>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3190",1,10) %>');
document.write('</div>');

document.write('<a name=\"fm\" id=\"fm\"></a>');
document.write('<div id=\"tabAuto\" style=\"margin-top:5px;background:none;height:60px;\">');
document.write('<img src=\"http://images.d1.com.cn/images2012/market/121031/fm.jpg\" border=\"0\"/>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3196",1,1) %>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3195",1,2) %>');
document.write('<%= getimglist2("3253",1,4) %>');
document.write('</div>');
document.write('<div class=\"newgdscoll\">');
document.write('<%= getimglist2("3194",1,3) %>');
document.write('<%= getimglist2("3252",1,11) %>');
document.write('</div>');






