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
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code.trim(),num);
if(list!=null && list.size()>0){
	for(PromotionProduct pProduct:list){
		Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
		
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if( directory!=null){
			 String theimgurl="";
			 
				 theimgurl=product.getGdsmst_imgurl(); 
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
				 out.print("<li style=\"height:330px;\">");
	%>
	
<div class="lf">
  			
           				    <p style="z-index:999;background:#fff;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           				
           				    	<img src="<%=theimgurl%>" width="200" height="200"/></a>
		
	</p>	
		<div style="width:200px;height:100px;padding:0px;">
		<div  style="font-size:12px;padding-left:5px;padding-right:5px;padding-top:3px; padding-bottom:0px;height:100px;">
		 <table style="height:38px;width:100%;">
			              <tr>
			              <td valign="middle" height="18" colspan="2">
		<%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,26)%>
		</td></tr>
		<tr><td align="center" width="90px" height="26px"><span style="color:#C35F48;">惊喜价：</span> 
		<span style="color:#C35F48;font-size:14px;">￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %>&nbsp;&nbsp;</span> 
		
		</td>
		<td><a href="/product/<%=product.getId()%>?st=com#cmt" target="_blank" style="font-size:14px; text-decoration:underline">更多评论 >></a></td>
		</tr>
		<tr>
		<td colspan="2" align="left">
		<%
		 Comment com=null;
        List<Comment> clist= CommentHelper.getCommentList(product.getId(),0,100);
        if(list!=null&&clist.size()>0)
        {
        	for(Comment c:clist)
        	{
        		if(c.getGdscom_level().longValue()==5)
        		{
        			com=c;
        			break;
        		}
        		else
        		{
        			continue;
        		}
        	}
        	if(com==null)
        	{
        		for(Comment c:clist)
            	{
            		if(c.getGdscom_level().longValue()==4)
            		{
            			com=c;
            			break;
            		}
            		else
            		{
            			continue;
            		}
            	}
        		if(com==null)
        		{
        			for(Comment c:clist)
                	{
                		if(c.getGdscom_level().longValue()==3)
                		{
                			com=c;
                			break;
                		}
                		else
                		{
                			continue;
                		}
                	}
        		}
        	}
        }
        if(com!=null){%>
        <span style="color:#751715;"><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></span>
        <%= StringUtils.getCnSubstring(com.getGdscom_content(),0,70) %>
        <%} else{%>
      	<span>暂无评论！！！</span>
        <%}
    %>
		</td>
		</tr>
		
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

