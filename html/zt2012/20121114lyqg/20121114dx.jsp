<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<div class="newlist" style=" text-align:center;overflow:hidden;  padding-bottom:18px; ">
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
String dxcode=(String)request.getAttribute("dxcode");
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code.trim(),num);
if(list!=null && list.size()>0){
	for(PromotionProduct pProduct:list){
		Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
		
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if( directory!=null){
			 String theimgurl="";
			 if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030"))){
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
			 }
			 else{
				 theimgurl=ProductHelper.getImageTo200(product);
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
				 boolean booldx=false; float dxprice=0;
				 if(!Tools.isNull(dxcode)){
					  ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(dxcode));
					  //System.out.print(rcmdusr.getRcmdusr_startdate().getTime());  
					  if(rcmdusr!=null 
					    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
					    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
					    	){
					    	booldx=true;
					    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(product.getId(), dxcode);
					    	if(rcmdgds!=null){dxprice=rcmdgds.getRcmdgds_memberprice();
					    	}
		                    }
					 }
				 out.print("<li style=\"height:420px;\">");
	%>
	
<div class="lf">
<% 
           				if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")))
           					{
           					%>
           					   <p style="z-index:999;height:300px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           								<img src="<%= theimgurl%>" width="240" height="300"  alt="<%= imgalt %>"/>
           	           
           				<%	}
           				    else
           				    {%>
           				    <p style="z-index:999; padding-top:30px; padding-bottom:30px;background:#fff;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           				    	<img src="<%=theimgurl%>" width="240" height="240"/>
           	           
           				    <%}%>
		
		</a>
		
	</p>	
		<div style="background:#cccaca; width:240px;height:110px;padding:0px;">
		<div  style="font-size:12px;padding-left:5px;padding-right:5px;padding-top:3px; padding-bottom:0px;height:110px;">
		 <table style="height:38px;width:100%;">
			              <tr>
			              <td valign="middle" height="38" colspan="2">
		<%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,66)%>
		</td></tr>
		<tr><td align="center" colspan="2">原价：￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %>&nbsp;&nbsp;</td></tr>
		<tr><td align="center">
		<span style="color:red;font-weight:bold;font-size:24px;">￥<%=ProductGroupHelper.getRoundPrice(dxprice) %></span> </td><td align="center">
		<a   href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);">
			<img src="http://images.d1.com.cn/zt2012/20121114bjdx/bjdx_06.jpg" width="111" height="32" alt="" border="0"></a></td></tr>
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

