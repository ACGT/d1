<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>


<%
String code="";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
if(code.length()>0){
	int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}

ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
if(list!=null&&list.size()>0)
{
    int count=0;%>
<ul>
   <%  for(PromotionProduct pp:list)
	   {
		   if(pp!=null)
		   {
			   Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			   if(product!=null)
			   {
				     String theimgurl="";
					 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
					 if(pp.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pp.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
					 }
					 String spgdsrcm_layertype=pp.getSpgdsrcm_layertype();
					 
					 float memberprice=product.getGdsmst_memberprice().floatValue();
				     String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
					 String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
					 double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
					 String fl=ProductGroupHelper.getRoundPrice((float)dl);
					 count++;
					 %>
					 <li <%if(count%4==0){ out.print("style='margin-right:0px;'");} %>>
						 <div>
						    <a href="<%if (pp.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pp.getSpgdsrcm_otherlink().trim()%><%}%>" target="_blank">
						    <img src="<%=theimgurl%>" border=0 width="200" height="200" />
						   </a>
						     <!-- 显示特价图标 -->
								 <% Date d=new Date();
								    if(product.getGdsmst_discountenddate().after(d) && product.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+Tools.DAY_MILLIS*30))&& product.getGdsmst_memberprice()!=product.getGdsmst_oldmemberprice()&&product.getGdsmst_oldmemberprice()!=0)
								    { %>
								 <div style="position:absolute;z-index:999;  margin-top:-206px; margin-left:-4px; +margin-top:-2px; +margin-left:-204px; margin-top:-210px\0; margin-left:-2px\0;"><img src="http://images.d1.com.cn/images2010/tejia2.gif" /> </div>	
								 <% } %>
						    <span style="display:block; width:200px; height:43px; line-height:18px;">
						       <a  href="<%if (pp.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%>
								<%}else{%>
								<%=pp.getSpgdsrcm_otherlink().trim()%>
								<%}%>" target=_blank style='text-decoration:none' >
								<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(pp.getSpgdsrcm_gdsname(),len)%></font></a>
						    </span>
						    <span style="display:block; width:200px; height:43px; line-height:18px;">
						            <font style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike></font><br>
									<font style="font-size:15px;font-weight:bold;color:#ff0000;">会员价:￥<%=strmprice%>&nbsp;折扣：<%=fl%></font><br>
						     </span>			
									<div align="right" style="height:40px; width:200px;"><%
									if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(product)){
									%>
										<a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" border="0" /></a><%
									}else{
									%>
										<a href="###"><img src="http://images.d1.com.cn/images2012/New/product/qh.jpg" /></a><%
									} %>
									</div>
					 </li>
					 <%
			   }
		   }
	   }
    }
	   %>
</ul>	
<%}
}%>

		
		
		
		
	

