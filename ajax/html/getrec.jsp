<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)){
		if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			img = "http://images1.d1.com.cn"+img.trim().replace('\\','/');
			}else{
				img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
			}
	}
	
	return img;
}
/**
 * 获得服装图 240*300
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo240300(Product product){
	String img = (product != null ? product.getGdsmst_img240300() : null);
	if(!Tools.isNull(img)) {
		if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			img = "http://images1.d1.com.cn"+img.trim().replace('\\','/');
			}else{
				img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
			}
	}
	
	return img;
}
%>
<%//获取推荐商品
String code=request.getParameter("code");
int count=Tools.parseInt(request.getParameter("count"));
StringBuilder sb=new StringBuilder();

if(code.equals("7987")){
	sb.append("<div class=\"gdslistt mgt10\" ><h3>特别推荐</h3><dl><dt></dt></dl></div>");
}else if(code.equals("8536")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>针织毛衣</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=030004\" target=\"_blank\">更多</a></dt></dl> </div>");
}else if(code.equals("8537")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>棉服/羽绒服</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=030007\" target=\"_blank\">更多</a></dt></dl> </div>");
}else if(code.equals("7768")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>T恤/衬衫</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=030001,030002\" target=\"_blank\">更多</a></dt></dl> </div>");
}else if(code.equals("9180")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>夹克西服</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort==030006\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("8211")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>家居服</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=030004\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("8538")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖长裤</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=030008,030009\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("7770")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖男鞋</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/html/news/index.jsp?productsort=031\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("6584")){//化妆品
	sb.append("<div class=\"gdslistt mgt10\"><h3>前沿新妆</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/html/news/index.jsp?productsort=014\" target=\"_blank\">更多</a></dt></dl> </div>");
}else if(code.equals("6585")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>美容护肤</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=014001003,014001008,014001002,014001005,014001004\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("6586")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>香水彩妆</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=014002,014003\" target=\"_blank\">更多</a></dt></dl> </div>");
	
}else if(code.equals("6587")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>男士护肤</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=014002,014003\" target=\"_blank\">更多</a></dt></dl> </div>");
	
}else if(code.equals("6588")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>个人护理</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=014001022,014005001,014007001,014003006\" target=\"_blank\">更多</a></dt></dl> </div>");

	
}else if(code.equals("7988")){//女装
	sb.append("<div class=\"gdslistt mgt10\"><h3>特别推荐</h3><dl><dt></div>");

}else if(code.equals("7775")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖裙装</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020010\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("7776")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖T恤</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020002\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("7777")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖衬衫</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020001\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("7778")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖裤装</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020008,020009\" target=\"_blank\">更多</a></dt></dl> </div>");
}else if(code.equals("8214")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖毛衫</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020004&order=4\" target=\"_blank\">更多</a></dt></dl> </div>");

}else if(code.equals("8213")){
	sb.append("<div class=\"gdslistt mgt10\"><h3>热卖外套</h3><dl><dt>");
	sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020006\" target=\"_blank\">更多</a></dt></dl> </div>");

}

	ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
	pplist=PromotionProductHelper.getPProductByCode(code, count);
	if(pplist!=null&&pplist.size()>0)
	{
		int counts=0;
		
        
		 sb.append("<div>");
	 sb.append("<ul>");
	 for(PromotionProduct pp:pplist)
	 {
		 if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
			 {
			 counts++;
			Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
				{
	      		   //String title = Tools.clearHTML(p.getGdsmst_gdsname()).trim();
	           	   String id = p.getId();
	           	   long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
	           	   long currentTime = System.currentTimeMillis();
	           	String gname=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,52) ;
	        	String gtitle=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_title()),0,30) ;
	           	   if(code.equals("6584")||code.equals("6585")||code.equals("6586")||code.equals("6587")||code.equals("6588")){
	           	 gname=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,40) ;
	        	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_title()),0,22) ;
	           	 }
	           	   if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   			   {
	   	               sb.append("<li class=\"libox\">");
	   	              // 
	   			   }
	           	   else
	           	   {
	           		sb.append("<li class=\"libox\">");
	           		   //sb.append("<div class=\"lf\" style=\"padding-left:25px;\">");
	           	   }
	           	   sb.append("<div class=\"lf\">");
	           	   //if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
	   	           	  //sb.append("<a href=\""+ProductHelper.getProductUrl(p)+"\" ><img src=\"http://images.d1.com.cn/images2010/tejia2.gif\" class=\"di\" /></a>");
	   	           // } 
	           	 if(code.equals("6584")||code.equals("6585")||code.equals("6586")||code.equals("6587")||code.equals("6588")){
		   	        	sb.append("<p style=\"z-index:999;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
		   	           }else{
	           	    if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   	           { 
	           	    
	           	    	
	           	    	if(Tools.isNull(getImageTo240300(p))){
	 	           	   sb.append("<p style=\"z-index:999;height:260px; padding-top:40px;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
	           	    	}else{
	 		           	   sb.append("<p style=\"z-index:999;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");

	           	    	}
	   	           }
	           	    
	   	           else
	   	           {
		           	   sb.append("<p style=\"z-index:999;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
	   	           }
		   	       }
	           	 if(code.equals("6584")||code.equals("6585")||code.equals("6586")||code.equals("6587")||code.equals("6588")){
	           		sb.append("<img src=\""+ ProductHelper.getImageTo160(p)+"\" width=\"160\" height=\"160\" />");
	           	 }else{
	   	           if(!Tools.isNull(getImageTo200250(p))&&p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   	           {  
	   	           		sb.append("<img src=\""+ getImageTo200250(p)+"\" width=\"200\" height=\"250\" />");
	   	           }
	   	           else
	   	           {
	                      sb.append("<img src=\""+ ProductHelper.getImageTo200(p)+"\" width=\"200\" height=\"200\" />");
	   	           }
	   	           }
	   	           sb.append("</a></p>");
	   	           //每个商品对应的搭配列表
              //ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(p.getId()); 
				     // if(gdscolllist!=null&&gdscolllist.size()>0)
				     // {
				    	//sb.append("<div style=\"position:absolute; margin-top:-46px; +margin-top:-15px; \" onmouseover=\"mdm_over('"+p.getId()+"','"+ counts+"')\" onmouseout=\"mdm_out('"+ p.getId()+"','"+counts+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/da1.png\"/></div>");

				    // }
				   sb.append("</p>");

			    	boolean	msflag= CartHelper.getmsflag(p);

	   	           if(msflag){
		   	    	 sb.append("<p style=\" text-align:center\"><strong>￥"+Tools.getFormatMoney(p.getGdsmst_msprice()) +"</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"priced\">￥"+Tools.getFormatMoney(p.getGdsmst_memberprice())+"</span></p>");
			       
	   	           }
		   	       else
		   	       {
		   	          // sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		   	        sb.append("<p style=\" text-align:center\"><strong>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</strong></p>");       
		   	       }
	   	        sb.append("<p class=\"gdst\"><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(p)+"\" target=\"_blank\">"+gname+"</a></p>");
	   	        sb.append("<p class=\"gdst2\"><span style=\"color:#fff\">.</span>&nbsp;"+gtitle +"</p>");
	           	   sb.append("</div>");
	           	 sb.append("<div class=\"clear\"></div>");
	           	 sb.append("</li>");
		 }
		}
	 }   	 
	 sb.append("</ul>");
	 sb.append("</div><div class=\"clear\"></div>");
	}	
	out.print(sb.toString());
 
 %>