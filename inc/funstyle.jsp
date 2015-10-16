<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.dbcache.core.*"%><%!

public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num+10);
	if(list==null||list.size()==0)return null;	
	
	int total = 0 ;
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			rlist.add(pp);
			total++;
			if(total==num)break;
		}
	}
		
	//for(BaseEntity be:list){
		//PromotionProduct pp = (PromotionProduct)be;
		//rlist.add(pp);
	//}
	return rlist ;
}

public static ArrayList<GdsCutImg> getByGdsid(String gdsid){
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
public static String getimgstr(List<Promotion> list,int num){
	StringBuilder sb=new StringBuilder();
if(list!=null&&list.size()>num&&list.get(num)!=null)
{
	Promotion p=list.get(num);		
	if(Tools.isNull(p.getSplmst_url())){
		sb.append("<a href=\""+p.getSplmst_url()+"\" target=\"_blank\" >");
		}
	sb.append("<img src=\""+p.getSplmst_picstr()+"\" border=\"0\" />");
		if(Tools.isNull(p.getSplmst_url())){
			sb.append("</a>");
		}
}
return sb.toString();
}
public static String getgdsstr(ArrayList<PromotionProduct> listgds,int num,int imgwh){
	StringBuilder sb=new StringBuilder();
	if(listgds!=null&&listgds.size()>num&&listgds.get(num)!=null)
	{
		PromotionProduct gdsrec=listgds.get(num);	
		Product p=ProductHelper.getById(gdsrec.getSpgdsrcm_gdsid());
		String cutimg="";
		if(!Tools.isNull(gdsrec.getSpgdsrcm_otherimg())){
			cutimg=gdsrec.getSpgdsrcm_otherimg();
		}else{
			 ArrayList<GdsCutImg> gcilist=getByGdsid(p.getId());
			   if(gcilist!=null&&gcilist.size()>0&&gcilist.get(0)!=null)
			   {
				   if(imgwh==180){
				   cutimg=gcilist.get(0).getGdscutimg_200();
				   }else{
					 cutimg=gcilist.get(0).getGdscutimg_100();  
				   }
				  
			   }else{
				   if(imgwh==180){
					   cutimg=p.getGdsmst_imgurl();
					   }else{
						 cutimg=p.getGdsmst_otherimg3(); 
					   }
			   }
			   if(cutimg!=null&&cutimg.startsWith("/shopimg/gdsimg")){
				   cutimg = "http://images1.d1.com.cn"+cutimg;
					}else{
						cutimg = "http://images.d1.com.cn"+cutimg;
					}
		}
		sb.append("<a href=\"http://www.d1.com.cn/product/"+ p.getId() +"\" target=\"_blank\">");
		sb.append("<img src=\""+cutimg+"\" width=\""+imgwh+"\" height=\""+imgwh+"\" border=\"0\"></a>");
		sb.append("<span class=\"gdsdivprice\">"+p.getGdsmst_memberprice()+"</span>");
	}
	return sb.toString();
}

%>