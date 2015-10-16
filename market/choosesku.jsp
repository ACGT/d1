<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsinfo.css")%>" type="text/css" rel="stylesheet" />
<style type="text/css">
ul li{float:left;}
</style>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>
<%!
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
%>

<%
String gdsid="03300030";
String code=request.getParameter("code");
Product product = ProductHelper.getById(gdsid);
ArrayList<Tuandh> dhgdsmList = getdhgdsmList(code);
String gdsarrstr="";
String selectgdsid = "";
if(dhgdsmList != null && dhgdsmList.size()>0){
	Tuandh t=dhgdsmList.get(0);
	String memo=t.getTuandh_memo();
	String [] strs=null;
	if(memo.indexOf(",")>0){
		strs=memo.split(",");
	}
	if(strs!=null && strs.length>0){
%>
 <div class="spgg" style="width:450px;">
<%
                            
									  
										    	%><div id="skuname2" class="skuname1" style="margin-bottom:0px;padding-bottom:0px;">
									           	<p>选择商品：<font id="sizecount2"></font></p>
									    		<ul><%
									    		String selectSku2 = "";
									    		
									    		
										    	for(int i=0;i<strs.length;i++){
										    		
										    		String gId = Tools.trim(strs[i].substring(0,8));
										    		Product goods = ProductHelper.getById(gId);
										    		//System.out.println(i+"MMMM"+gId);
										    		if(goods!=null&&(goods.getGdsmst_validflag().longValue()==1 || goods.getGdsmst_validflag().longValue()==4))
										    		{
										    			//System.out.println(i+"<<<"+gId);
										    			GoodsGroupDetail gg=getGroup(goods);
										    			if(gg!=null){
										    			
										    				//System.out.println(i+">>>"+gId);
										    		%><li <%if(i==0){ %> class="select"<%} %>>
										    		<A hideFocus title="<%=gg.getGdsgrpdtl_stdvalue()%>"  onclick=choosegdsid(this)  href="javascript:void(0);" attr="<%=gg.getGdsgrpdtl_gdsid().trim()%>" <%if(i==0){ %> class="current"<%} %>><img  height=80 width=80 src="<%=ProductHelper.getImageTo80(goods) %>" />
										    		</a>
										    		<br/><br/><br/><%=gg.getGdsgrpdtl_stdvalue()%></li><%
										    	
										    		if (i==0){
										    			selectSku2=gg.getGdsgrpdtl_stdvalue();
										    			selectgdsid=gId;
										    			gdsarrstr=gId;
										    		}
										    		else{
										    		gdsarrstr=gdsarrstr+","+gId;
										    		}
										    		
										    	
										    			}}
										    		}
										    	%></ul>
										    	</div>
										    	<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script><%
										        }
}
									    	int showsku=0;
									    	
										    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(selectgdsid,showsku);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname" class="skuname" >
										    	<div style="float:left;clear:both;"><p><span style="color:#FC7C17;">第二步</span>选择尺寸：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font></p>
										   </div>
										  <div style="float:right; padding-right:15px;">
										    		<p>
										    			  </p>
										    			   </div>
										    		
										    		      <div id="ccdzb_img" style="float:left; position:absolute;display:none;clear:both;" onmouseover="ccdzb()" onmouseout="ccdzb1()">
										    		     
										    		       <img src="http://images.d1.com.cn/market/1206/wydh/fm9stx2_27.jpg" border="0"/>
										    		   
										    		     
										    		 </div><div style="clear:both;"></div>
										    		<ul>
										    		<%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
										    				}
										    				else
										    				{
										    					if(sku.getSkumst_vstock().longValue()==0){ %>
										    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a></li>
										    					<%}
										    					else
										    					{%>
										    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li>
										    					<%}
										    				}
										    			}else{
										    	
										    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
										    			  
										    			}
										    		}
										    		%>

										    		</ul>
										    	</div><%
										    }
									    //}
									 
									    %>

<div style="clear:both; ">
<a href="javascript:void(0)" attr="<%=code %>" onclick="ShowAJaxdh(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" border="0" /></a>
 <div class="frgwc_div" id="frgwc" style="display:none;">
							    <span style="position:relative;overflow:hidden;">
							    	<font id="countgdsmst1">1</font>件商品加入购物车
							    	<a href="###" class="ui-dialog-titlebar-close ui-corner-all" onclick="$('#frgwc').hide();"><span class="ui-icon ui-icon-closethick">close</span></a>
							    </span>
								<ul>
								<li>
								    <img src="http://images.d1.com.cn<%=product.getGdsmst_smallimg() %>" id="cardimg" width="80" height="80" />
									<div style="height:80px;"> <font style="_font-size:12px; "><b>
                                        <div id="spname1" style="font-weight:bold;padding-bottom:10px;"></div></b></font>
									<br/><br/>
									    加入数量：<font id="countgdsmst2">1</font><br/>
									    总计金额:￥<font id="countgdsmst3">0</font><br/>
									</div>
								
								</li>
								</ul>
								<div class="gwcbtn"><a href="/flow.jsp" target="_blank" onclick="display_hide('frgwc');"><img src="/res/images/viewcart.gif" alt="查看购物车" /></a><a href="javascript:void(0)" onclick="display_hide('frgwc')"><img src="http://images.d1.com.cn/Index/images/jxgw.jpg" alt="继续购物" /></a>							</div>
							 </div>
</div>
<a id="at" href="/flow.jsp" target="_blank"></a>
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
    var skuid = $("#skuname2");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    var s="";
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("current");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("current");
    	 var skuItem = skuid.find("a");
    	skuItem.each(function(){
    		if($(this).hasClass('current')){
    			s = $(this).attr("attr");
      		}
    	});
    	$('#sizecount2').html($(obj).attr("title"));
    }
    if($('#skuname').length>0){
    	 $.ajax({
    			type: "get",
    			dataType: "json",
    			url: '/market/1209/wydhkz/wydhmoresku.jsp',
    			cache: false,
    			data: {gdsid:s},
    			error: function(XmlHttpRequest){
    				alert("SKU错误！");
    			},success: function(json){
    				if(json.success){
    					$('#skuname').html(json.content);
    				}else{
    					alert("SKU错误！");
    				}
    			},beforeSend: function(){
    			},complete: function(){
    			}
    		});	
    }
    
   
}
//遍历规格
function BLGG2dh(){
	var skuid = $("#skuname2");
    if (skuid.length==0){
    	return '';
    }
    var skuItem = skuid.find("a");
    var s = '';
    if(skuItem.length>0){
    	skuItem.each(function(){
    		if($(this).hasClass('current')){
    			s = $(this).attr("attr");
    			return false;
    		}
    	});
    }
    return s;
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
			url: '/market/1202/cft/cftdhInCard.jsp',
			cache: false,
			data: {gdsid:skuys,cardno:code,skuId:sku2},
			error: function(XmlHttpRequest){
				$.alert("加入购物车出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.code==0){
					$.alert('已成功加入到购物车！','提示',function(){
						//$.close();
					
	            		this.location.href="/flow.jsp";
	        		});
					
				}else{
					$.alert(json.message);
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	
};

</script>
