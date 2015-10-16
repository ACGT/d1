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
	ArrayList<PromotionProduct> list=getPProductByCode(code,num);
	if(list!=null && list.size()>0){
		for(PromotionProduct pProduct:list){
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			if(product!=null){
				if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
				continue;
				}else{
					productlist.add(product);
				}
			}
		}
	}
	if(productlist==null||productlist.size()==0)return null;	
	return productlist;
}
%>
<%
String code="8138";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<Product> productlist=getProduct(code,100);
	
	if(productlist!=null){
		//System.out.println("总数："+productlist.size());
		int i=1;
		%>
		<table >
		<tr><td height="5px">&nbsp;</td></tr>
		<%for(Product product:productlist){
			ArrayList<PromotionProduct> pproductlist= getPProductByCodeGdsid(code,product.getId());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if(pproductlist!=null && directory!=null){
				
			 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
			 String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice/2);
			   String sprice=ProductGroupHelper.getRoundPrice(memberprice);
			   long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
   			 long currentTime = System.currentTimeMillis();
			  if(i%3==1){
				  
	%>
	<tr><td width="17">&nbsp;</td>
	<%} 
	%>
	<td style="background:url('http://images.d1.com.cn/zt2012/20120928sytl/sybj_05-1.jpg') no-repeat;" width="302" height="385" align="center">
	<table height="385">
	<tr><td valign="top" height="302"><a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="302" height="302" />
		</a></td></tr>
		
		<tr><td width="300px" height="26px" align="center"  valign="bottom" style="color:#ccc;font-size:14px;font-weight:bold;"><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,36) %></td></tr>
		<tr><td align="center" valign="top" style="color:#ccc;">
		<table width="302">
		<tr><td width="80" align="center" valign="middle"><span style="font-size:12px;">市场价:￥<%=Tools.getFormatMoney(product.getGdsmst_saleprice()) %></span></td>
		<td><span style="font-size:24px;font-weight:bold;color:white;font-family:'微软雅黑';color:#ED7E2C">会员价:￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></span></td>
		<td width="60">
		<%
		if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
			%>
			<img alt="" src="http://images.d1.com.cn/zt2012/20120928sytl/sx.png"/>
		<%}else{
			%>
			<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
			<img alt="" src="http://images.d1.com.cn/zt2012/20120928sytl/q.png"/>
			</a>
			<%}
		%>
		</td>
		</tr>
		</table>
		</td></tr>
	</table>
	
	</td>
	<%if(i%3!=0){
		%>
		<td width="20">&nbsp;</td>
		<%}if(i%3==0){ %>
		<td width="17">&nbsp;</td></tr><tr><td height="15">&nbsp;</td></tr>
		<%} %>

		<%
		i++;
			}
	}if((i-1)%3!=0){%>
	</tr><tr><td height="15">&nbsp;</td></tr>
	<%} %>
	</table>
		<%}

}
%>