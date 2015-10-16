<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
public static ArrayList<DhGdsM> getdhgdsmList2(String card){
	ArrayList<DhGdsM> rlist = new ArrayList<DhGdsM>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("dhgdsm_card",card));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("id"));
			List<BaseEntity> list = Tools.getManager(DhGdsM.class).getList(clist, olist, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					DhGdsM pp = (DhGdsM)be;
                     rlist.add(pp);
				}
			}
	return rlist ;
}

public static ArrayList<Tuandh> getdhgdsmList(String card){
	ArrayList<Tuandh> rlist=new ArrayList<Tuandh>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tuandh_cardno", card));
		List<BaseEntity> list = Tools.getManager(Tuandh.class).getList(clist, null, 0, 1);
			
			if(list!=null){
				for(BaseEntity be:list){
					Tuandh pp = (Tuandh)be;
                     rlist.add(pp);
				}
			}
	return rlist ;
}
public static GoodsGroupDetail getGroup(Product product){
	if(product == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_gdsid", product.getId()));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 1);
	
	if(list == null || list.isEmpty()) return null;
	
	GoodsGroupDetail gd = (GoodsGroupDetail)list.get(0);
	return gd;
}
%><%


String gdsid="";
String code=request.getParameter("code");
if(!Tools.isNull(request.getParameter("gdsid"))){
	gdsid=request.getParameter("gdsid");
}
String gdsarrstr="";
String selectgdsid = "";
Product product = ProductHelper.getById(gdsid);
%><div class="ui-dialog" ><%
ArrayList<DhGdsM> dhgdsmList2= getdhgdsmList2(code.substring(0,code.length()-10));
if(dhgdsmList2!=null && dhgdsmList2.size()>0){
	%>
  <div class="title">选择商品<span onclick="javascript:skuclose();">X</span></div>
                       		<div class="content">
                       			<div class="sku1" id="sku1">
                       				<div class="skutxt">选择商品：<span id="sizecount2">绿色</span></div> 
                       				<ul>
                       				<%
									    		String selectSku2 = "";
									    		
									    		int i=1;
										    	for(DhGdsM dhgds : dhgdsmList2){
										    		String gId = Tools.trim(dhgds.getDhgdsm_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		//if(goods!=null&&goods.getGdsmst_validflag().longValue()==1)
										    		//{
										    		%>
                       					<li  <%if(i==1){ %> class="select"<%} %>>
                       					  <a <%if(i==1){ %> class="cur"<%} %>   title="<%=dhgds.getDhgdsm_title()%>"  onclick=choosegdsid(this)  href="javascript:void(0);" attr="<%=dhgds.getDhgdsm_gdsid()%>" ><img height="60" width="60" src="<%=ProductHelper.getImageTo80(goods) %>" >
                       					  </a><%=dhgds.getDhgdsm_title()%>
                       					</li>
                       					<%if (i==1){
										    			selectSku2=dhgds.getDhgdsm_title();
										    			selectgdsid=dhgds.getDhgdsm_gdsid();
										    			gdsarrstr=gId;
										    		}
										    		else{
										    		gdsarrstr=gdsarrstr+","+gId;
										    		}
										    		i++;
										    	}
										    	%>
										    	</ul>
                       				<div style="clear:both;"></div>
                       			</div>
                       			<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script>
										    	<%}else{

ArrayList<Tuandh> dhgdsmList = getdhgdsmList(code);

if(dhgdsmList != null && dhgdsmList.size()>0){
	


	Tuandh t=dhgdsmList.get(0);
	String memo=t.getTuandh_memo();
	String [] strs=null;
	if(memo.indexOf(",")>0){
		strs=memo.split(",");
	}
	if(strs!=null && strs.length>0){
		
	%>
	 <div class="title">选择商品</div>
                       		<div class="content">
                       			<div class="sku1" id="sku1">
                       				<div class="skutxt">选择商品：<span id="sizecount2">绿色</span></div> 
                       				<ul>
	<%

									    		String selectSku2 = "";
									    		
									    		
										    	for(int i=0;i<strs.length;i++){
										    		
										    		String gId = Tools.trim(strs[i].substring(0,8));
										    		Product goods = ProductHelper.getById(gId);
										    		//System.out.println(i+"MMMM"+gId);
										    		if(goods!=null&&goods.getGdsmst_validflag()!=null&& (goods.getGdsmst_validflag().longValue()==1 || goods.getGdsmst_validflag().longValue()==4))
										    		{
										    			//System.out.println(i+"<<<"+gId);
										    			GoodsGroupDetail gg=getGroup(goods);
										    			if(gg!=null){
										    				%>
                                   <li  <%if(i==1){ %> class="select"<%} %>>
                       					  <a <%if(i==1){ %> class="cur"<%} %>   title="<%=gg.getGdsgrpdtl_stdvalue()%>"  onclick=choosegdsid(this)  href="javascript:void(0);" attr="<%=gg.getGdsgrpdtl_gdsid().trim()%>" ><img height="60" width="60" src="<%=ProductHelper.getImageTo80(goods) %>" >
                       					  </a><%=gg.getGdsgrpdtl_stdvalue()%>
                       					</li>

<%								        
if (i==0){
	selectSku2=gg.getGdsgrpdtl_stdvalue();
	selectgdsid=gId;
	gdsarrstr=gId;
}
else{
gdsarrstr=gdsarrstr+","+gId;
}
if(Tools.isNull(selectgdsid)){
	selectgdsid=gId;
}
										    			}
}
} 

%>
</ul>
	<div style="clear:both;"></div>
</div>
	<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script>
<%}	}
}
%><%
	
int showsku=0;

List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(selectgdsid,showsku);
if(skuList != null && !skuList.isEmpty()){
	product = ProductHelper.getById(selectgdsid);
	int size = skuList.size(); %>
                       			<div class="sku2" id="sku2">
                       			<div class="skutxt">第二步选择规格：<span id="sizecount">s(170)</span></div>
                       			  <ul>
                       			  <%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><li  <%if(i==1){ %> class="select"<%} %>><a href="javascript:void(0);" <%if(size==1){ %> class="cur"<%} %> title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><%=skuname %></a></li><%
										    				}
										    				else
										    				{		

										    					if(sku.getSkumst_vstock().longValue()==0){ %>
										    						<li ><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><%=skuname %></a></li>
										    					<%}
										    					else
										    					{%>
										    						<li  <%if(i==1){ %> class="select"<%} %>><a href="javascript:void(0);" <%if(size==1){ %> class="cur"<%} %> title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><%=skuname %></a></li>
										    					<%}

										    				}
										    			}else{

										    			%><li  <%if(i==1){ %> class="select"<%} %>><a href="javascript:void(0);" <%if(size==1){ %> class="cur"<%} %> title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><%=skuname %></a></li><%
										    			  
										    			}

										    		}
										    		%>
                       			   </ul>
                       			   <div style="clear:both;"></div>
                       			  	</div>
                       		<%} %>
                       			</div>
                       			<div class="but"><a href="javascript:void(0)" attr="<%=code %>" onclick="ShowAJaxdh(this);" class="butincart">加入购物车</a></div>
                       		</div>
                       </div>
                       <script>
function ccdzb()
{
  var top=$('#skuname').offset().top+$('#skuname p').height()-5;
  var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
  $("#ccdzb_img").css("top",top);
  $("#ccdzb_img").css("left",right+200);
  $("#ccdzb_img").css("display","block");

}
function ccdzb1()
{
	$("#ccdzb_img").css("display","none");
}
function choosegdsid(obj){
    var skuid = $("#sku1");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    var s="";
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("cur");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("cur");
    	 var skuItem = skuid.find("a");
    	skuItem.each(function(){
    		if($(this).hasClass('cur')){
    			s = $(this).attr("attr");
      		}
    	});
    	$('#sizecount2').html($(obj).attr("title"));
    }
    	$.ajax({
    			type: "get",
    			dataType: "json",
    			url: '/ajax/wap/dhmoresku.jsp',
    			cache: false,
    			data: {gdsid:s},
    			error: function(XmlHttpRequest){
    				alert("SKU错误1！");
    			},success: function(json){
  				if(json.success){
    					$('#sku2').html(json.content);
    				}else{
    					alert("SKU错误2！");
    				}
    			},beforeSend: function(){
    			},complete: function(){
    			}
    		});   
   
}
//遍历规格
function BLGG2dh(){
	var skuid = $("#sku1");
    if (skuid.length==0){
    	return '';
    }
    var skuItem = skuid.find("a");
    var s = '';
    if(skuItem.length>0){
    	skuItem.each(function(){
    		if($(this).hasClass('cur')){
    			s = $(this).attr("attr");
    			return false;
    		}
    	});
    }
    return s;
}
function BLGG2(){
	var skuid = $("#sku2");
    if (skuid.length==0){
    	return '';
    }
    var skuItem = skuid.find("a");
    var s = '';
    if(skuItem.length>0){
    	skuItem.each(function(){
    		if($(this).hasClass('cur')){
    			s = $(this).attr("attr");
    			return false;
    		}
    	});
    }
    if(s==''){
    	 alert('请选择商品规格！')
    	 return;
    }
    return s;
}
function chooseskuname1(obj){
    var skuid = $("#sku2");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("cur");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("cur");
    	$('#sizecount').html($(obj).attr("title"));
    }
}
function ShowAJaxdh(obj){
	var sku2=BLGG2();
	var code=$(obj).attr("attr");
	if(typeof sku2 == 'undefined'){
		sku2 = "";
	}
	var skuys=BLGG2dh();
	
	if(typeof skuys == 'undefined'){
		skuys = "";
	}

		$.ajax({
			type: "get",
			dataType: "json",
			url: '/ajax/wap/dhInCart.jsp',
			cache: false,
			data: {gdsid:skuys,id:code,skuId:sku2},
			error: function(XmlHttpRequest){
				alert("加入购物车出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.code==0){
					if(confirm('放入购物车成功是否去购物车?')){
						window.location.href="/wap/flow.html";
            		}
				}else{
					alert(json.message);
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	
};

</script>