<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<style type="text/css">
.newlist {width:965px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; margin-left:5px; }
.newlist ul {width:965px;padding:0 0 0px; padding-left:25px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:25px;overflow:hidden; width:210px; overflow:hidden; margin-bottom:20px;  }
.newlist p {text-align:left; }
.newlist p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
.newlist .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:200px; padding-top:3px; padding-bottom:2px;
*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
.retime a{text-decoration:none; }
.lf{ padding:5px; background-color:#fff; over-flow:hidden; }
.newlist p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
.newlist p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
.lb{background-color:#f7f7f7;  padding:5px;  width:200px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
 text-align:left; vertical-align:middle; padding-top:8px;}
.newlist .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none;}
</style>
<div style="width:980px; background-color:#CCCCCC; text-align:center;">
<div class="newlist" style="width:965px; overflow:hidden;  padding-bottom:18px; ">
<ul>
<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code.trim(),100);
ArrayList gdsidlist=new ArrayList();
if(list!=null && list.size()>0){
	
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		
	int i=0;
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	int l=0;
	if(productlist!=null){
		
		for(Product product:productlist){
			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if(pproductlist!=null && directory!=null){
				
			 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			 if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030"))){
				 theimgurl=product.getGdsmst_img200250(); 
				 if(Tools.isNull(theimgurl)){
					 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
						 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
					 }else{
						 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
					 } 
				 }else{
					 theimgurl="http://images.d1.com.cn"+ theimgurl;
				 }
			 }
			 else{
				 theimgurl=ProductHelper.getImageTo200(product);
				}
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			
			 
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
				 out.print("<li style=\"height:300px;\">");
	%>
	
<div class="lf">
<% 
           				if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")))
           					{
           					%>
           					   <p style="z-index:999;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           							<img src="<%=theimgurl  %>" width="200" height="250" onmouseover="mdm_over('<%= product.getId()%>')" onmouseout="mdm_out('<%= product.getId()%>')"/>
           	           
           				<%	}
           				    else
           				    {%>
           				    <p style="z-index:999; padding-top:25px; padding-bottom:25px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           				    	<img src="<%= ProductHelper.getImageTo200(product) %>" width="200" height="200" onmouseover="mdm_over('<%= product.getId()%>')" onmouseout="mdm_out('<%= product.getId()%>')"/>
           	           
           				    <%}%>
			<jsp:include   page= "/sales/showLayer.jsp"   />   	
		</a>
	</p>	
		
		<p class="retime" id="black_<%= product.getId()%>" onmouseover="mdm_over('<%= product.getId()%>')" onmouseout="mdm_out('<%= product.getId()%>')"> <a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" style="font-size:12px; color:#fff; "><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,60)%></a> </p>
			           <p style="height:35px; font-size:13px; color:#999999; ">
			               <span class="newspan"><font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
			               <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(product.getGdsmst_saleprice()) %></font></span>
			               
			               <span class="newspan1"><a href="/product/<%= product.getId() %>#cmt2" target="_blank">评论(<%= CommentHelper.getCommentLength(product.getId()) %>)</a></span>
			           </p>
		

</div>  <div class="clear"></div>
		
   
    
    </li>
		<%	}
	}
}
	}
}
}
%>
</ul>
</div>
</div>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});
function mdm_over(obj)
{
    document.getElementById("black_"+obj).style.display="block";
}


 function mdm_out(obj)
{
    document.getElementById("black_"+obj).style.display="none";
	
}

</script>