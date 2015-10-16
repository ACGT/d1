<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/productpublic.jsp"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsinfo.css")%>" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>
<br/>
<%

//String gdsid="02001191";
String id="";
if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
{
    id=	request.getParameter("id");
}
/*if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
{
	gdsid=request.getParameter("gdsid");
}*/


Cart cart=CartHelper.getById(id);
if(cart==null)
{%>
  <div>对不起，记录不存在！</div> 	
<%
    return;
}
if(Tools.isNull(cart.getProductId())){%>
	<div>对不起，商品编号不正确！</div>
<%
    return;
}
String gdsid=cart.getProductId().trim();
Product product = ProductHelper.getById(gdsid);

%>
 <div class="spgg" style="width:500px;">
<%
	if(product != null&&product.getGdsmst_skuname1()!=null){
		String skuname1=product.getGdsmst_skuname1();				    	
		///sku
	     List<Sku> skuList=new ArrayList<Sku>();
	     if(!Tools.isNull(skuname1)){
	    	int showsku=1;
	    	if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
	    		showsku=0;
	    	}
	    	//System.out.println(showsku);
		   	 skuList = SkuHelper.getSkuListViaProductIdO(gdsid,showsku);
		    if(skuList != null && !skuList.isEmpty()){
		    	int size = skuList.size();
		    	%><div id="skuname" class="skuname">
		    		<p>选择<%=skuname1 %>：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font>
		    		<%  ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(id);
		    		
		    		
		    		   if(list!=null&&list.size()>0 || (product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0))
		    		   {
		    			   String sizeinfo="";
			    		   if(product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0){
			    			   sizeinfo= getsizeinfo(product);
			    		   }
		    			   if((list.size()>0&& list.get(0).getGdsatt_content().length()>0) || !Tools.isNull(sizeinfo)){
		    		    %>
		    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">(尺寸对照表)</font></p>
		    		      <div id="ccdzb_img" style="position:absolute;display:none; z-index:2222;<%if(!Tools.isNull(sizeinfo)) {%>border:1px solid black;background-color:#ffffff;<%} %>" onmouseover="ccdzb()" onmouseout="ccdzb1()">
		    		    <%
		    		      if(!Tools.isNull(sizeinfo)){
					    		 out.print(sizeinfo);
					    	  }else{%>
		    		    <%= list.get(0).getGdsatt_content() %>
		    		      <%  }%>
		    		    </div>
		    			  <%   }
		    			   
		    		  }
		    		   else
		    		   {%>
		    			   </p>
		    		   <%
		    		   
		    		   }
		    		%>
		    		
		    		<ul>
		    		<%
		    		for(int i=0;i<size;i++){
		    			Sku sku = skuList.get(i);
		    			String skuname = sku.getSkumst_sku1();
		    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
		    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
			    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li><%
		    				}
		    				else
		    				{
		    					if(sku.getSkumst_vstock().longValue()==0){ %>
		    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
		    					<%}
		    					else
		    					{%>
		    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
		    					<%}
		    				}
		    			}else{
		    	           if(sku.getSkumst_validflag()!=null&&sku.getSkumst_validflag().longValue()==1)
		    	           {
		    	        	   if(sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()<=0&&product.getGdsmst_ifhavedate()!=null&&product.getGdsmst_ifhavedate().after(new Date()))
		    	        	   {
		    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" flag="1" onclick="choosesku20120717(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li><%
		    	               }
		    	        	   else
		    	        	   {%>
		    	        		   <li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" flag="0" onclick="choosesku20120717(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
		    	        	   <%}
		    	           }
		    			}
		    		}
		    		%>
                 </ul>
                 
		    	</div><div class="clear"></div>
		    	<a href="javascript:void(0)" onclick="updatesku('<%= id%>','<%= gdsid%>')"><img src="http://images.d1.com.cn/images2012/New/user/sure.jpg" style="border:none;" /></a>
		    	
		    	<%
		    }
	    }
	}%>
	</div>
<script>

//遍历规格
function BLGG2dh(){
	var skuid = $("#skuname");
    if (skuid.length==0){
    	return '';
    }
    var skuItem = skuid.find("a");
    var s = '';
    if(skuItem.length>0){
    	skuItem.each(function(){
    		if($(this).hasClass('current')){
    			s = $(this).attr("attr");    		}
    	});
    }
    return s;
}
function updatesku(id,gdsid){
	var skuys=BLGG2dh();
	if(typeof skuys == 'undefined'){
		skuys = "";
	}
	if(skuys.length==0){
		alert("请选择颜色和尺码！");
		//return;
	}else{
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/flow/updatesku.jsp',
		cache: false,
		data: {gdsid:gdsid,skuId:skuys,id:id},
		error: function(XmlHttpRequest){
			$.alert("修改规格出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.error=="0"){
				$.alert("修改规格成功！",'提示',function(){
					this.location.href="/flow.jsp";
				});
				
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
	}
};

</script>
