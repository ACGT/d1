<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div style="width:980px;  text-align:center;">
<div style="width:965px; overflow:hidden;  padding-bottom:10px; ">
<%!
public static ArrayList<Product> getProduct(int type,int num,int sv,String str){
	ArrayList<Product> productlist=new ArrayList<Product>(); 
	List<Criterion> clist = new ArrayList<Criterion>();
	//List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	if(str != null){ 
		if(str.equals("图案")){
			clist.add(Restrictions.ne("gdsmst_stdvalue"+sv,""));//规格 例如袖型
		}else if(str.equals("格纹条纹圆点")){
			//clist.add(Restrictions.or(Restrictions.like("gdsmst_stdvalue"+sv, "%格纹%"),    
			//		Restrictions.or(Restrictions.like("gdsmst_stdvalue"+sv, "%条纹%"),
				//	Restrictions.like("gdsmst_stdvalue"+sv, "%圆点%"))));  
			clist.add(Restrictions.sqlRestriction(" (gdsmst_stdvalue"+sv +" like '%格纹%' or gdsmst_stdvalue"+sv +" like '%条纹%' or gdsmst_stdvalue"+sv +" like '%圆点%')"));
			//listRes.or(Restrictions.like("name", productName,MatchMode.ANYWHERE),Restrictions.like("name", productName,MatchMode.ANYWHERE))
		}else if(str.equals("荷叶边")||str.equals("蕾丝")){
			clist.add(Restrictions.like("gdsmst_stdvalue"+sv, "%"+str+"%"));//规格 例如袖型
		}
	}
	int start = 0;
	if(str!=null){
		if(str.equals("毛呢大衣")){
			clist.add(Restrictions.like("gdsmst_rackcode", "020013%"));//商品大分类
		}else if(str.equals("羽绒服1")){
			clist.add(Restrictions.like("gdsmst_rackcode", "020007%"));//商品大分类
		}else if(str.equals("羽绒服2")){
			start = 4;
			clist.add(Restrictions.like("gdsmst_rackcode", "020007%"));//商品大分类
		}else if(str.equals("裙子")){
			clist.add(Restrictions.like("gdsmst_rackcode", "020010%"));//商品大分类
		}else{
			clist.add(Restrictions.like("gdsmst_rackcode", "020%"));//商品大分类
		}
	}
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));//已上架状态
	String dat = "2013-09-15";
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date date_d = null;
    try{
      date_d = sdf.parse(dat);
	  clist.add(Restrictions.ge("gdsmst_createdate", date_d));
	   
    }catch(Exception e){
	    e.printStackTrace();
	    System.out.println("字符串转换日期失败!");
    }
	List<Order> olist=new ArrayList<Order>();
	if(type == 1){
		olist.add(Order.desc("gdsmst_createdate"));//按新品排序
	}else{
		olist.add(Order.desc("gdsmst_salecount"));//按月销量排序
	}
	//if(type == 5){//荷叶边的销量和新品前四个一样，所以加type=5，第二行从第四个开始取值
	//	start = 4;
	//}
	//clist.add(Restrictions.or(Restrictions.like("gdsmst_stdvalue11", "%春/秋季%"),    
	//				Restrictions.like("gdsmst_stdvalue11", "%冬季%"))); 
	//排除内衣品牌和家居服020011  020012
	clist.add(Restrictions.sqlRestriction(" (gdsmst_rackcode not like '020011%' and gdsmst_rackcode not like '020012%')"));
	//clist.add(Restrictions.sqlRestriction(" (gdsmst_rackcode not like '020011%')"));
	List<BaseEntity> list = Tools.getManager(Product.class).getListCriterion(clist, olist, start, num);
	if(list==null || list.size()==0){
		return null;
    }
	if(list!=null){
		 for(BaseEntity be:list){
			 productlist.add((Product)be);
		 }
	}
	return productlist;
}

public static ArrayList<GoodsGroupDetail> getGoodsList(String gdsid){
	ArrayList<GoodsGroupDetail> group_list=new ArrayList<GoodsGroupDetail>(); 
	List<Criterion> clist = new ArrayList<Criterion>();
	clist.add(Restrictions.eq("gdsgrpdtl_gdsid", gdsid));//商品id
	List<BaseEntity> list = Tools.getManager(GoodsGroupDetail.class).getListCriterion(clist, null, 0, 100);
	if(list==null || list.size()==0){
		return null;
    }
	if(list!=null){
		 for(BaseEntity be:list){
			 group_list.add((GoodsGroupDetail)be);
		 }
	}
	return group_list;
}
public static int getPromotionsize(String gdsid){
	int num = 0;
	List<Criterion> clist = new ArrayList<Criterion>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long(9114)));//黑名单推荐位号
	clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));//商品id
	List<BaseEntity> Promotion_list = Tools.getManager(PromotionProduct.class).getListCriterion(clist, null, 0, 100);
	if(Promotion_list!=null){
		 num = Promotion_list.size();
	}
	return num;
}
%>
<%

	
	SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
	
	int i=0;
	int type = 1;
	if(request.getAttribute("type") != null){
		type = Integer.parseInt(request.getAttribute("type").toString());
	}
	int length = 4;
	if(request.getAttribute("length") != null){
		length = Integer.parseInt(request.getAttribute("length").toString());
	}
	int sv = 7;
	if(request.getAttribute("sv") != null){
		sv = Integer.parseInt(request.getAttribute("sv").toString());
	}
	String str="";
	if(request.getAttribute("str")!=null ){
		str=request.getAttribute("str").toString();
	}
	
	ArrayList<Product> productlist = getProduct(type,200,sv,str);
	ArrayList<Product> productlist2 = new ArrayList<Product>();//排除黑名单和重复色值的list
	int promotion_size = 0;
	String groupidstr = ",";
	int groupflag=0;
	int four = 1;
	if(productlist!=null&&productlist.size()>0){
		for(int z=0;z<productlist.size();z++){
			System.out.println("z==="+z);
			promotion_size = getPromotionsize(productlist.get(z).getId());
			groupflag=0;
			ArrayList<GoodsGroupDetail> group_list1 = getGoodsList(productlist.get(z).getId());
			if(group_list1 != null){
				for(int p = 0;p<group_list1.size();p++){
					String group_id = group_list1.get(p).getGdsgrpdtl_mstid().toString();
					if(groupidstr.indexOf(","+group_id+",")>=0){
						groupflag=1;
						break;
					}else{
						groupidstr+=group_id+",";
					}
				}
			}
			if(promotion_size == 0 && groupflag==0){
				if(four > 4){
					break;
				}
				productlist2.add(productlist.get(z));
				four++;
			}
		}
	}
	
	//System.out.println("str="+str+"---type="+type+"---num="+length+"---sv="+sv);
	int l=0;
	if(productlist2!=null){
		//System.out.println("11111111111111111111111==="+productlist.size());
		for(Product product:productlist2){
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
		
			 String theimgurl=product.getGdsmst_imgurl();;
			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
			 	theimgurl = "http://images1.d1.com.cn"+theimgurl;
			 }else{
				theimgurl = "http://images.d1.com.cn"+theimgurl;
			 }
			 float memberprice=product.getGdsmst_memberprice().floatValue();
			 String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
			 String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice() );
			 String saleprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			   
				   %>
<div style="  float:left;  width:231px;height:310px; /*FF*/ *height:310px;/*IE7*/ _height:310px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >
				 
<dl style="text-align:left;">
<dt style="width:205px; text-align:center;padding-left:10px; ">

		<div style="position:relative;left;width:200px;height:200px;">
		<a href="/product/<%=product.getId()%>" target=_blank style='text-decoration:none' title="">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		</a></div>
		<dd style="width:205px; text-align:left; padding-left:10px; float:left">
		<div style="height:42px;width:205px;">
		<a href="/product/<%=product.getId()%>" target=_blank style='text-decoration:none' >
		<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),48)%></font></a>
		</div>
		<%
			out.print("<div style=\"height:85px;width:205px;padding-top:5px;\">");
		%>
		<div style="float:left;width:35px;_width:40px;">
			<a href="/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/mh1113/tj.gif" broder="0"></a>
		</div>
		<div style="float:right;width:156px;_width:154px;">
		<%if(product.getGdsmst_discountenddate()==null||Tools.dateValue(fmt.parse("2999-01-01"))==Tools.dateValue(product.getGdsmst_discountenddate())) {%>
		<span style="font-family: '微软雅黑';font-size:36px;font-weight:bold;color:#ff0000;line-height:48px;"> <%=strmprice%></span>
		 <span style="color:#000000;">市场价:￥</span>
		 <span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike><%=saleprice%></strike></span><br>
		<%}else{ %>
		<span style="font-family: '微软雅黑';font-size:36px;font-weight:bold;color:#ff0000;line-height:48px;"> <%=strmprice%></span>
		 会员价:￥<span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike><%=sprice%></strike></span><br>
		<%} %>
		</div>

</dd>
</dl>
</div>
		<%
		l++;
	}
}
%>
</div>
</div>