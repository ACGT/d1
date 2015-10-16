<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %>
<%!
//获取平铺图
private static ArrayList<GdsCutImg> getGdsImg(String id){
	 if(id==null||id.length()==0||!Tools.isNumber(id)) return null;
	 ArrayList<GdsCutImg> gcilist=new ArrayList<GdsCutImg>();
	 List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	 clist.add(Restrictions.eq("gdsmst_gdsid",id));
	 List<BaseEntity> blist=Tools.getManager(GdsCutImg.class).getList(clist, null,0,10);
	 if(blist!=null&&blist.size()>0&&blist.get(0)!=null){
      for(BaseEntity be:blist){
     	 if(be!=null)
     	 {
     		 gcilist.add((GdsCutImg)be);
     	 }
      }
	 }
	 return gcilist;
}
/**
 * 按照相应的排序,获取商品列表
 * @param p
 * @return
 */
public static ArrayList<Product> getProductListByOrder(Product p1,ArrayList<Product> plist){
	if(p1==null||plist==null||plist.size()==0) return null;
	if(p1.getGdsmst_gdscoll()==null||p1.getGdsmst_gdscoll().length()==0) return plist;
	ArrayList<Product> result=new ArrayList<Product>();
	ArrayList<Product> result1=new ArrayList<Product>();
	ArrayList<Product> result2=new ArrayList<Product>();
	ArrayList<Product> result3=new ArrayList<Product>();
	for(Product p:plist){
		if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
			if(p.getGdsmst_gdscoll()!=null&&p.getGdsmst_gdscoll().length()>0&&p1.getGdsmst_gdscoll().equals(p.getGdsmst_gdscoll())){
				result1.add(p);
			}
			else if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().length()>0&&p1.getGdsmst_brandname()!=null&&p1.getGdsmst_brandname().length()>0&&p.getGdsmst_brandname().equals(p1.getGdsmst_brandname()))
			{
				result2.add(p);
			}
			else
			{
				result3.add(p);
			}
		}
	}
	result.addAll(result1);
	result.addAll(result2);
	result.addAll(result3);
	return result;
}

/**
 * 按照销量排序,获取商品列表
 * @param p
 * @return
 */
public static ArrayList<Product> getProductListByOrder1(Product p1,ArrayList<Product> plist){
	if(p1==null||plist==null||plist.size()==0) return null;
	if(p1.getGdsmst_gdscoll()==null||p1.getGdsmst_gdscoll().length()==0) return plist;
	ArrayList<Product> result=new ArrayList<Product>();
	ArrayList<Product> result1=new ArrayList<Product>();
	ArrayList<Product> result2=new ArrayList<Product>();
	for(Product p:plist){
		if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
			if(p.getGdsmst_gdscoll()!=null&&p.getGdsmst_gdscoll().length()>0&&p1.getGdsmst_gdscoll().equals(p.getGdsmst_gdscoll())){
				result1.add(p);
			}
			else
			{
				result2.add(p);
			}
		
		}
	}
	Collections.sort(result1,new WsalesComparator());
	Collections.reverse(result1);	
	Collections.sort(result2,new WsalesComparator());
	Collections.reverse(result2);	
	result.addAll(result1);
	result.addAll(result2);
	return result;
}

//获取产品列表
private static String getResult(String id,String code,int flag){
	if(id==null||id.length()<=0||!Tools.isNumber(id)) return "";
	Product product=ProductHelper.getById(id);
	if(product==null) return"";
	StringBuilder sb=new StringBuilder();
	if(code==null||code.length()<=0||flag>9||flag<1) return "";
	
	
	Gdscoll_rackcode gr=Gdscoll_rackcodeHelper.getGdsAttByGdsids(code,flag);
	if(gr==null) return "";
	ArrayList<Product> plist=new ArrayList<Product>();	
	
	if(gr!=null&&gr.getGr_gdsmstorder()!=null&&gr.getGr_gdsmstorder()==2){
		ArrayList<Product> plist1= ProductHelper.getProductListByRCodeSubByWsale(code,100);
		plist=getProductListByOrder1(product,plist1);
		//plist=plist1;
	}
	else{
		ArrayList<Product> plist1= ProductHelper.getProductListByRCodeSub(code, 100);
		plist=getProductListByOrder(product,plist1);
	}	
	if(plist!=null&&plist.size()>0){
		sb.append("<div id=\"scolllist\" style=\"position:relative; height:387px; width:220px;overflow:hidden;\">");
		sb.append("<ul class=\"gdetaillist\">");
		int count=0;
		for(Product p:plist){
			if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
				count++;
				String imgurl="";
				//System.out.print(p.getId()+"_");
				//ArrayList<GdsCutImg> gcilist=new ArrayList<GdsCutImg>();
				//gcilist=getGdsImg(p.getId());
				//if(gcilist!=null&&gcilist.size()>0){
					//if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0){
						//imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_100();
					//}
					//else
					//{
						//imgurl=ProductHelper.getImageTo120(p);
					//}
				//}
				//else{
					//imgurl=ProductHelper.getImageTo120(p);
				//}
				imgurl=ProductHelper.getImageTo120(p);
				String brandname="";
				int pp=1;
				//获取品牌
				if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().length()>0){
					brandname=p.getGdsmst_brandname().trim();
					if(brandname.equals("FEEL MIND")){
						pp=1;
					}
					else if(brandname.equals("AleeiShe 小栗舍")){
					    pp=2;	
					}
					else if(brandname.equals("诗若漫")){
						pp=3;
					}
				}
				
				
				sb.append("<li><a href=\"javascript:void(0)\" attr=\""+flag+"\" code=\""+p.getId()+"\" onclick=\"AddImg(this)\"><img src=\""+imgurl+"\" width=\"100\" height=\"100\" pp=\""+pp+"\" flag=\""+count+"\" onmouseover=\"mdmover(this);\" onmouseout=\"mdmout();\" ></a><br/>");
				sb.append("<font style=\"color:#aa2e44;\">￥"+p.getGdsmst_memberprice().floatValue()+"</font>");
				
				float saleprice = Tools.floatValue(p.getGdsmst_saleprice());//市场价
				float memberprice = Tools.floatValue(p.getGdsmst_memberprice());//会员价
				long discountendDate = Tools.dateValue(p.getGdsmst_discountenddate());//应该是秒杀结束的时间。
				float oldmemberprice = Tools.floatValue(p.getGdsmst_oldmemberprice());//旧的会员价
				long currentTime = System.currentTimeMillis();
				if(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS && Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0){
                     sb.append("&nbsp;&nbsp;<strike>"+oldmemberprice+"</strike>");
				}				
				sb.append("</li>");
			}
		}
		sb.append("</ul>");		
		sb.append("</div>");
		sb.append("<div id=\"div_float\" onmouseover=\"mdmover1();\" onmouseout=\"mdmout();\"></div>");
		sb.append("<input id=\"hidden\" type=\"hidden\" attr=\"0\"/>");
		sb.append(" <div class=\"preNext pre\">");
		sb.append("<a href=\"javascript:void(0)\" ><img id=\"toplb\" src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/top.png\" width=\"41\" height=\"18\" onclick=\"PrePage()\"></a>");
		sb.append("</div>");
		sb.append("<div class=\"preNext next\"><a href=\"javascript:void(0)\" >");
		sb.append("<img id=\"bottomlb\" src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/bottom.png\" width=\"41\" height=\"18\" onclick=\"NextPage()\"></a>");
		sb.append("</div><div class=\"clear\"></div>");
	}
	return sb.toString();
}

//获取同系列的商品
private static ArrayList<Product> getProduct(String gdscoll){
	if(gdscoll==null||gdscoll.length()<=0) return null;
	ArrayList<Product> list=new ArrayList<Product>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	if(gdscoll.length()>0)
	{
		clist.add(Restrictions.eq("gdsmst_gdscoll", gdscoll));
	}
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("gdsmst_createdate"));
	List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,100);
			
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Product)be);
		}
	}	
	else
	{
		return null;
	}
     return list;
}




%>
<%
     Map<String,Object> map = new HashMap<String,Object>();
     String code="";
     String id="";
     int flag=0;
     if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
     {
    	 id=request.getParameter("id");
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"商品编号参数错误！\"}");
     }
     if(request.getParameter("rcode")!=null&&request.getParameter("rcode").length()>0)
     {
    	 code=request.getParameter("rcode");
     }
    
     if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0&&Tools.isNumber(request.getParameter("flag")))
     {
    	 flag=Tools.parseInt(request.getParameter("flag"));
     }
     
     String result="";
     result=getResult(id,code,flag);
     if(result.length()>0)
     {
    	 map.put("succ",new Boolean(true));
    	 map.put("message",result);
    	 out.print(JSONObject.fromObject(map));

     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"\"}");
     }
     

%>
