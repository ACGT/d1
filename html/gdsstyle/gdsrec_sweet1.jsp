<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
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
	//System.out.println("推荐位下的商品数："+list.size());
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


<table width="980" height="480" border="0" cellpadding="0" cellspacing="0">
<%
String code="9094";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
}
int len=25;
if(request.getAttribute("len")!=null){
	len=Integer.parseInt((request.getAttribute("len")).toString().trim());
}


ArrayList<Product> productlist=getProduct(code,len);
//System.out.println("推荐位下的商品数==："+productlist.size());
if(productlist!=null){
	ArrayList<PromotionProduct> pproductlist = null;
	Directory directory = null;
%>
  <tr>
    <td width="310">
    <table width="310" height="480" border="0" cellpadding="0" cellspacing="0">
    <% 
        pproductlist = getPProductByCodeGdsid(code,productlist.get(0).getId());
  		directory=DirectoryHelper.getById(productlist.get(0).getGdsmst_rackcode());
  		if(pproductlist!=null && directory!=null){
  		 PromotionProduct pProduct=pproductlist.get(0);
  			 String theimgurl="";
 				 theimgurl=productlist.get(0).getGdsmst_midimg(); 
 				 if(Tools.isNull(theimgurl)){
 					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
 						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
 					 }else{
 						 theimgurl=productlist.get(0).getGdsmst_midimg();
 					 } 
 				 }else{
 					 theimgurl= theimgurl;
 				 }
  				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
  					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
  				}else{
  					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
  				}
  			 String imgalt=Tools.clearHTML(productlist.get(0).getGdsmst_gdsname());
  			 String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
  			
  			   float memberprice=productlist.get(0).getGdsmst_memberprice().floatValue();
  			   String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
  			   String sprice=ProductGroupHelper.getRoundPrice(productlist.get(0).getGdsmst_saleprice().floatValue());
  			   double dl= Tools.getDouble(productlist.get(0).getGdsmst_memberprice().doubleValue()*10/productlist.get(0).getGdsmst_saleprice().doubleValue(),1);
  			   String fl=ProductGroupHelper.getRoundPrice((float)dl); 
				%>
      <tr>
        <td width="310" height="400">
        <div style="overflow: hidden; width: 310px;height: 400px;">
			<a href="<%=ProductHelper.getProductUrl(productlist.get(0)) %>" target="_blank">
        		<img src="<%= theimgurl%>" alt="<%= imgalt %>" class="hide_lr"/>
        	</a>
        </div>
		</td>
      </tr>
      
      <tr bgcolor="#ffb4b4">
        <td width="310" height="25" valign="middle" style="font-family: '宋体'; font-size: 12px;"><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,66)%></td>
      </tr>
      <tr bgcolor="#ffb4b4">
        <td width="310" height="25">
        <span style="margin-left: 10px;">市场价：￥<%=Tools.getFormatMoney(productlist.get(0).getGdsmst_saleprice()) %>&nbsp;&nbsp;</span>
        </td>
      </tr>
      <tr bgcolor="#ffb4b4">
        <td width="310">
			<span style=" font-family:'方正大黑简体';color:#876070; font-weight:bold; font-size:20px; line-height: 30px; margin-left: 92px;">&nbsp;&nbsp;秒杀价：￥<span style="font-size:30px; line-height: 20px;"><%=Tools.getFormatMoney(productlist.get(0).getGdsmst_memberprice()) %></span></span>
		</td>
      </tr>
      
      <%}%>
    </table>
    </td>
    <td width="670" align="center">
    <table width="670" height="480" border="0" cellpadding="0" cellspacing="0" class="tb_bgx">
      <tr>
      <td width="20"> </td>
        <td height="250"  style="border: 1px solid #ffd7d2; width: 200px;">
         <%
        pproductlist= getPProductByCodeGdsid(code,productlist.get(1).getId());
		directory=DirectoryHelper.getById(productlist.get(1).getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
				 theimgurl=productlist.get(1).getGdsmst_img200250(); 
				 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl=productlist.get(1).getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl= theimgurl;
				 }
				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
				}else{
					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
				}
			 String imgalt=Tools.clearHTML(productlist.get(1).getGdsmst_gdsname());%>
         		<div style="position: relative; width: 200px;height: 250px;">
			 <a href="<%=ProductHelper.getProductUrl(productlist.get(1)) %>" target="_blank" >
         		<img src="<%= theimgurl%>" alt="<%= imgalt %>"/></a>
         		<span style="position:absolute; background-color:#ffb4b4; width:48px; height:24px; text-align:center; dislay:block; right:0px; bottom:0px; z-index:5000;color: #e4186d; font-family: '宋体'; font-size: 14px;">
         			RMB<%=Tools.getFormatMoney(productlist.get(1).getGdsmst_memberprice()) %>
         		</span>
         		</div>
         	
         	<%}%>
        </td>
        <td width="22">&nbsp;</td>
        <td style="border: 1px solid #ffd7d2; width: 200px;">
         <%
        pproductlist= getPProductByCodeGdsid(code,productlist.get(2).getId());
		directory=DirectoryHelper.getById(productlist.get(2).getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
				 theimgurl=productlist.get(2).getGdsmst_img200250(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl=productlist.get(2).getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl= theimgurl;
				 }
				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
				}else{
					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
				}
			 String imgalt=Tools.clearHTML(productlist.get(2).getGdsmst_gdsname());%>
         			<div style="position: relative; width: 200px;height: 250px;">
			 <a href="<%=ProductHelper.getProductUrl(productlist.get(2)) %>" target="_blank" >
         		<img src="<%= theimgurl%>" alt="<%= imgalt %>"/></a>
         			<span style="position:absolute; background-color:#ffb4b4; width:48px; height:24px; text-align:center; dislay:block; right:0px; bottom:0px; z-index:5000;color: #e4186d; font-family: '宋体'; font-size: 14px;">
         				RMB<%=Tools.getFormatMoney(productlist.get(2).getGdsmst_memberprice()) %>
         			</span>
         			</div>
         	
         	<%}%>
        </td>
         <td width="22">&nbsp;</td>
        <td style="border: 1px solid #ffd7d2;width: 200px;">
         <%
        pproductlist= getPProductByCodeGdsid(code,productlist.get(3).getId());
		directory=DirectoryHelper.getById(productlist.get(3).getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
				 theimgurl=productlist.get(3).getGdsmst_img200250(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl=productlist.get(3).getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl= theimgurl;
				 }
				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
				}else{
					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
				}
			 String imgalt=Tools.clearHTML(productlist.get(3).getGdsmst_gdsname());%>
         			<div style="position: relative; width: 200px;height: 250px;">
			 <a href="<%=ProductHelper.getProductUrl(productlist.get(3)) %>" target="_blank" >
         		<img src="<%= theimgurl%>" alt="<%= imgalt %>"/>
         			<span style="position:absolute; background-color:#ffb4b4; width:48px; height:24px; text-align:center; dislay:block; right:0px; bottom:0px; z-index:5000;color: #e4186d; font-family: '宋体'; font-size: 14px;">
         				RMB<%=Tools.getFormatMoney(productlist.get(3).getGdsmst_memberprice()) %>
         			</span></a>
         			</div>
         	
         	<%}%>
        </td>
      </tr>
      <tr>
        <td height="10">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
      <td width="22"> </td>
        <td style="border: 1px solid #ffd7d2;">
  <%
        pproductlist= getPProductByCodeGdsid(code,productlist.get(4).getId());
		directory=DirectoryHelper.getById(productlist.get(4).getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
				 theimgurl=productlist.get(4).getGdsmst_imgurl(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl=productlist.get(4).getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl= theimgurl;
				 }
				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
				}else{
					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
				}
			 String imgalt=Tools.clearHTML(productlist.get(4).getGdsmst_gdsname());%>
         			<div style="position: relative; width: 200px;height: 200px;">
			 <a href="<%=ProductHelper.getProductUrl(productlist.get(4)) %>" target="_blank" >
         		<img src="<%= theimgurl%>" alt="<%= imgalt %>"/></a>
         			<span style="position:absolute; background-color:#ffb4b4; width:48px; height:24px; text-align:center; dislay:block; right:0px; bottom:0px; z-index:5000;color: #e4186d; font-family: '宋体'; font-size: 14px;">
         				RMB<%=Tools.getFormatMoney(productlist.get(4).getGdsmst_memberprice()) %>
         			</span>
         			</div>
         	
         	<%}%>
		</td>
        <td>&nbsp;</td>
        <td style="border: 1px solid #ffd7d2;">
<%
        pproductlist= getPProductByCodeGdsid(code,productlist.get(5).getId());
		directory=DirectoryHelper.getById(productlist.get(5).getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
				 theimgurl=productlist.get(5).getGdsmst_imgurl(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl=productlist.get(5).getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl= theimgurl;
				 }
				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
				}else{
					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
				}
			 String imgalt=Tools.clearHTML(productlist.get(5).getGdsmst_gdsname());%>
         			<div style="position: relative;width: 200px;height: 200px;">
			 <a href="<%=ProductHelper.getProductUrl(productlist.get(5)) %>" target="_blank" >
         		<img src="<%= theimgurl%>" alt="<%= imgalt %>"/>	</a>
         			<span style="position:absolute; background-color:#ffb4b4; width:48px; height:24px; text-align:center; dislay:block; right:0px; bottom:0px; z-index:5000;color: #e4186d; font-family: '宋体'; font-size: 14px;">
         				RMB<%=Tools.getFormatMoney(productlist.get(5).getGdsmst_memberprice()) %>
         			</span>
         			</div>
         
         	<%}%>
		</td>
		<td>&nbsp;</td>
        <td style="border: 1px solid #ffd7d2;">
<%
        pproductlist= getPProductByCodeGdsid(code,productlist.get(6).getId());
		directory=DirectoryHelper.getById(productlist.get(6).getGdsmst_rackcode());
		if(pproductlist!=null && directory!=null){
		 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
				 theimgurl=productlist.get(6).getGdsmst_imgurl(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl=productlist.get(6).getGdsmst_midimg();
					 } 
				 }else{
					 theimgurl= theimgurl;
				 }
				if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
				}else{
					 theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
				}
			 String imgalt=Tools.clearHTML(productlist.get(6).getGdsmst_gdsname());%>
         			<div style="position: relative; width: 200px;height: 200px;">
			 <a href="<%=ProductHelper.getProductUrl(productlist.get(6)) %>" target="_blank" >
         		<img src="<%= theimgurl%>" alt="<%= imgalt %>"/></a>
         			<span style="position:absolute; background-color:#ffb4b4; width:48px; height:24px; text-align:center; dislay:block; right:0px; bottom:0px; z-index:5000;color: #e4186d; font-family: '宋体'; font-size: 14px;">
         				RMB<%=Tools.getFormatMoney(productlist.get(6).getGdsmst_memberprice()) %>
         			</span>
         			</div>
         	
         	<%}%>
		</td>
      </tr>
    </table></td>
    
  </tr>
  <%}%>
</table>



