<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/html/productpublic.jsp"%><%
String gdsid = request.getParameter("gdsid");
///sku
Product product = ProductHelper.getById(gdsid);
Map<String,Object> map = new HashMap<String,Object>();
if(product == null){
	map.put("success",new Boolean(false));
}
	StringBuilder sb = new StringBuilder();
if(!Tools.isNull(product.getGdsmst_skuname1())){
	int showsku=1;
	if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
		showsku=0;
	}
    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(gdsid,showsku);
    if(skuList != null && !skuList.isEmpty()){
    	int size = skuList.size();
   
    		sb.append("<p>选择尺寸：<font id=\"sizecount3\">未选择</font>");
    		 ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(gdsid);
    		 if(list!=null&&list.size()>0 || (product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0))
    		   {
    			   String sizeinfo="";
	    		   if(product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0){
	    			   sizeinfo= getsizeinfo(product);
	    		   }
    			   if((list.size()>0&& list.get(0).getGdsatt_content().length()>0) || !Tools.isNull(sizeinfo)){
    		   
    			  sb.append("<font id=\"ccdzb2\" style=\" color:#020399;padding-left:15px; cursor:hand;\" onmouseover=\"ccdzb3()\" onmouseout=\"ccdzb4()\">(尺寸对照表)</font></p>");
    			  sb.append("<div id=\"ccdzb_img2\" style=\"position:absolute;display:none;clear:both; ");
    			  if(!Tools.isNull(sizeinfo)) {
    				  sb.append("  border:1px solid black;background-color:#ffffff" );
    			  }
    			  sb.append(" \"  onmouseover=\"ccdzb3()\" onmouseout=\"ccdzb4()\">");
    		     if(!Tools.isNull(sizeinfo)){
    		    	 sb.append(sizeinfo);
			    	  }else{
    		   sb.append(list.get(0).getGdsatt_content());
    		       }
    		      sb.append(" </div>");
    			    }else{
    			    	sb.append(" </p>");
    			    }
    			   
    		  }
			sb.append("<div style=\"clear:both;\"></div><ul>");
    		for(int i=0;i<size;i++){
    			Sku sku = skuList.get(i);
    			String skuname = sku.getSkumst_sku1();
    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
    					sb.append("<li").append(size==1?" class=\"select\"":"").append("><a href=\"javascript:void(0);\" title=\""+skuname+"\" attr=\""+sku.getId()+"\" onclick=\"chooseskuname3(this)\" hidefocus=\"true\"").append(size==1?" class=\"current\"":"").append("><span>"+skuname+"</span></a></li>");
    				 }
    				else
    				{ 
    					if(sku.getSkumst_vstock().longValue()==0){ 
    						sb.append("<li><a href=\"javascript:void(0);\" title=\"售罄\"   hidefocus=\"true\"  style=\"height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;\"><span>"+skuname+"</span></a></li>");
    					 }
    					else
    					{ 
    						sb.append("<li").append(size==1?" class=\"select\"":"").append("><a href=\"javascript:void(0);\" title=\""+skuname+"\" attr=\""+sku.getId()+"\" onclick=\"chooseskuname3(this)\" hidefocus=\"true\"").append(size==1?" class=\"current\"":"").append("><span>"+skuname+"</span></a></li>");
    					 }
    				}
    			}else{
    				sb.append("<li").append(size==1?" class=\"select\"":"").append("><a href=\"javascript:void(0);\" title=\""+skuname+"\" attr=\""+sku.getId()+"\" onclick=\"chooseskuname3(this)\" hidefocus=\"true\"").append(size==1?" class=\"current\"":"").append("><span>"+skuname+"</span></a></li>");
    			  
    			}
    		}

    		sb.append("</ul>");
    		map.put("success","true");

    }
}

map.put("content",sb.toString());
out.print(JSONObject.fromObject(map));
%>