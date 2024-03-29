<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));

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
ArrayList<PromotionProduct> getPProductByCodeGdsid(String code,String id){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
			clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
			
			List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					PromotionProduct pp = (PromotionProduct)be;
					rlist.add(pp);
				}
			}
		
	
	return rlist ;
}
ArrayList<Product> getProduct(String code,int num){
	ArrayList<Product> productlist=new ArrayList<Product>(); 
	ArrayList<Product> productlist1=new ArrayList<Product>(); 
	ArrayList<Product> productlist2=new ArrayList<Product>(); 
	ArrayList<PromotionProduct> list=getPProductByCode(code,num);
	if(list!=null && list.size()>0){
		for(PromotionProduct pProduct:list){
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			if(product!=null){
				if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
				productlist2.add(product);
				}else{
					productlist1.add(product);
				}
			}
		}
	}
	if(productlist1!=null && productlist1.size()>0){
		//System.out.println("总数1："+productlist1.size());
		productlist.addAll(productlist1);
	}
	if(productlist2!=null && productlist2.size()>0){
		//System.out.println("总数2："+productlist2.size());
		productlist.addAll(productlist2);

	}
	if(productlist==null||productlist.size()==0)return null;	
	return productlist;
}
%>
<div class="newlist" style=" text-align:center;overflow:hidden;">
<ul>
<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
int num=100;
if(request.getAttribute("num")!=null){
	num=Integer.parseInt((request.getAttribute("num")).toString().trim());
}
ArrayList<Product> productlist=getProduct(code,100);

if(productlist!=null){
	for(Product product:productlist){
		ArrayList<PromotionProduct> pproductlist= getPProductByCodeGdsid(code,product.getId());
		Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
			
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			
				 theimgurl=product.getGdsmst_img240300(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl="http://images.d1.com.cn"+ theimgurl;
				 }
			
			 String imgalt=Tools.clearHTML(product.getGdsmst_gdsname());
			
			 
			 String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
			 String t="";
				String x="";
				if(spgdsrcm_layertype.trim().length()!=0){ 
					t=spgdsrcm_layertype;
					x=pProduct.getSpgdsrcm_layertitle();
					//PromotionProductHelper.showLayer(spgdsrcm_layertype, promotionProduct.getSpgdsrcm_layertitle());
				}else{
					t=product.getGdsmst_layertype();
					x=product.getGdsmst_layertitle();
					//PromotionProductHelper.showLayer(product.getGdsmst_layertype(),product.getGdsmst_layertitle());
				}
			 request.setAttribute("t", t);
			   request.setAttribute("x", x);
			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
			   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
				 String fl=ProductGroupHelper.getRoundPrice((float)dl);
				 out.print("<li style=\"height:390px;\">");
	%>
	
<div class="lf">
<% 
           				
           				if(Tools.isNull(product.getGdsmst_img240300())){
           					%>
           					<p style="z-index:999; padding-top:30px; padding-bottom:30px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           								<img src="<%= theimgurl%>" width="240" height="240"  alt="<%= imgalt %>"/>
           				<%}else{
           				%> <p style="z-index:999; height:300px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           								<img src="<%= theimgurl%>" width="240" height="300"  alt="<%= imgalt %>"/>
           	           
           				<%}%>
		
		</a>
		
		
	</p>	
		<div style="background:#e1ddd6; width:240px;height:80px;padding:0px;">
		<div  style="font-size:12px;padding-left:5px;padding-right:5px;padding-top:3px; padding-bottom:0px;height:38px;">
		 <table style="height:38px;">
			              <tr>
			              <td valign="middle">
		<%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,66)%>
		</td></tr></table>
		 </div>
			              <div  style="font-size:14px;padding-left:5px;padding-right:5px;"> 
			              <table>
			              <tr>
			              <td valign="middle"><span style="font-size:12px;font-weight:bold;color:#666666;"><strike>原价：￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %></strike>&nbsp;&nbsp;</span></td>
			              <td> &nbsp;&nbsp;<span style=" font-family:'微软雅黑';font-size:18px;font-weight:bold;color:#ff0000;">特价：￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></span></td></tr>
			              </table>
			                 
			           </div>
		</div>
		
		

</div>  <div class="clear"></div>
	
    </li>
		<%	}
	}
}
	}

%>
</ul>
</div>

