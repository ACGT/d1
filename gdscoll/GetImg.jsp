<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
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


//获取产品列表
private static String getResult(String code,int flag){
	StringBuilder sb=new StringBuilder();
	if(code==null||code.length()<=0||flag>9||flag<1)  return "";
	ArrayList<Product> plist= ProductHelper.getProductListByRCodeSub(code, 100);
	if(plist!=null&&plist.size()>0){
		sb.append("<div id=\"scolllist\" style=\"position:relative; height:327px;width:220px;overflow:hidden;\">");
		sb.append("<ul class=\"gdetaillist\">");
		for(Product p:plist){
			if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
				String imgurl="";
				ArrayList<GdsCutImg> gcilist=new ArrayList<GdsCutImg>();
				gcilist=getGdsImg(p.getId());
				if(gcilist!=null&&gcilist.size()>0){
					if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_100()!=null&&gcilist.get(0).getGdscutimg_100().length()>0){
						imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_100();
					}
					else
					{
						imgurl=ProductHelper.getImageTo120(p);
					}
				}
				else{
					imgurl=ProductHelper.getImageTo120(p);
				}
				sb.append("<li><a href=\"javascript:void(0)\" attr=\""+flag+"\" code=\""+p.getId()+"\"><img src=\""+imgurl+"\" width=\"100\" height=\"100\" ></a></li>");
			}
		}
		sb.append("</ul>");
		sb.append("</div>");
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

%>
<%
     Map<String,Object> map = new HashMap<String,Object>();
     String id="";
     int flag=0;
     if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
     {
    	 id=request.getParameter("id");
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
     }
    
     if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0&&Tools.isNumber(request.getParameter("flag")))
     {
    	 flag=Tools.parseInt(request.getParameter("flag"));
     }
     Product p=ProductHelper.getById(id);
     String result="";
     if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
    	 String imgurl="";
    	 
			ArrayList<GdsCutImg> gcilist=new ArrayList<GdsCutImg>();
			gcilist=getGdsImg(p.getId());
			if(gcilist!=null&&gcilist.size()>0){
				if(flag==5||flag==6||flag==7){
					if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_300()!=null&&gcilist.get(0).getGdscutimg_300().length()>0){
						imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_300();
					}
					else
					{
						imgurl=ProductHelper.getImageTo400(p);
					}
					
				}
				else
				{
					if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0){
						imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
					}
					else
					{
						imgurl=ProductHelper.getImageTo160(p);
					}
				}
			}
			else{
				if(flag==5||flag==6||flag==7){
				   imgurl=ProductHelper.getImageTo400(p);
				}
				else
				{
					imgurl=ProductHelper.getImageTo160(p);
				}
			}
			if(flag==5||flag==6||flag==7){
				result+="<li><a href=\"javascript:void(0)\" onclick=\"addfun1("+flag+")\" class=\"qba\" attr=\""+id+"_"+flag+"\" m=\""+ p.getGdsmst_memberprice().floatValue() +"\" title=\""+Tools.clearHTML(p.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+p.getGdsmst_memberprice().floatValue()+"元\" >";
				result+="<img src=\""+ imgurl+"\" width=\"300\" height=\"300\"></a>";
				result+="<p style=\"right:84px;\"><a href=\"/product/"+id+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/ck.png\"></a></p><p onclick=\"addfun("+flag+");\" style=\"right:45px;\"><img src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/adds.png\"/></p><p onclick=\"deleteimg(this)\" flag=\""+flag+"\"><img src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/deletes.png\"/></p>";
				result+="</li>";
			   //result+="<a href=\"http://www.d1.com.cn/product/"+id+"\" attr=\""+id+"\" m=\""+ p.getGdsmst_memberprice().floatValue() +"\" title=\""+Tools.clearHTML(p.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+p.getGdsmst_memberprice().floatValue()+"元\" target=\"_blank\">";
			   //result+="<img src=\""+ imgurl+"\" width=\"300\" height=\"300\"/>";
			   //result+="</a>";
			   //result+="<p onclick=\"deleteimg(this)\">删除>>&nbsp;&nbsp;</p>";
			}
			else{
				result+="<li><a href=\"javascript:void(0)\" onclick=\"addfun1("+flag+")\" class=\"qba\" attr=\""+id+"_"+flag+"\" m=\""+ p.getGdsmst_memberprice().floatValue() +"\" title=\""+Tools.clearHTML(p.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+p.getGdsmst_memberprice().floatValue()+"元\" >";
				result+="<img src=\""+ imgurl+"\" width=\"150\" height=\"150\"></a>";
				result+="<p style=\"right:84px;\"><a href=\"/product/"+id+"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/ck.png\"></a></p><p onclick=\"addfun("+flag+");\" style=\"right:45px;\"><img src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/adds.png\"/></p><p onclick=\"deleteimg(this)\" flag=\""+flag+"\"><img src=\"http://images.d1.com.cn/images2012/index2012/AUGUST/deletes.png\"/></p>";
				result+="</li>";
				  // result+="<a href=\"http://www.d1.com.cn/product/"+id+"\" attr=\""+id+"\" m=\""+ p.getGdsmst_memberprice().floatValue() +"\" title=\""+Tools.clearHTML(p.getGdsmst_gdsname())+"&nbsp;&nbsp;&nbsp;单价："+p.getGdsmst_memberprice().floatValue()+"元\" target=\"_blank\">";
				  // result+="<img src=\""+ imgurl+"\" style=\"margin-top:20px;\" width=\"100\" height=\"100\"/>";
				  // result+="</a>";
				  // result+="<p onclick=\"deleteimg(this)\">删除>>&nbsp;&nbsp;</p>";
			}
     }
     
     if(result.length()>0)
     {
    	 map.put("succ",new Boolean(true));
    	 map.put("message",result);
    	 map.put("price",p.getGdsmst_memberprice());
    	 out.print(JSONObject.fromObject(map));

     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":该商品库存不足，请选择其他商品！\"\"}");
     }
     

%>
