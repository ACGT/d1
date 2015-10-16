<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
	clist.add(Restrictions.ge("spgdsrcm_enddate",new Date()));
	//加入排序条件
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num);
	if(list==null||list.size()==0)return null;	
	for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			rlist.add(pp);
		}
	return rlist ;
}
%>
<%
String str="02000911,02000580,02000822,03000317";
ArrayList<PromotionProduct> list= getPProductByCode("8377",8);
if(list!=null && list.size()>0){
	for(PromotionProduct pp:list){
		Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
		if(p!=null){
			if(str.indexOf(p.getId())>=0){
				float old=p.getGdsmst_memberprice();
				java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
				p.setGdsmst_memberprice(pp.getSpgdsrcm_tjprice());
				p.setGdsmst_oldmemberprice(old);
				p.setGdsmst_discountenddate(df.parse("2999-1-1"));
				Tools.getManager(p.getClass()).update(p, false);
			}
			
		}
	}
}
/**
Product p=ProductHelper.getById("01721264");
if(p!=null){
	float old=p.getGdsmst_memberprice();
	p.setGdsmst_memberprice(75f);
	p.setGdsmst_oldmemberprice(old);
	p.setGdsmst_discountenddate(new Date(new Date().getTime()+3600000));
	Tools.getManager(p.getClass()).update(p, false);
}**/
%>
