<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/productpublic.jsp"%><%@page import="org.hibernate.*,java.util.Comparator"%><%!
public static ArrayList<DhGdsM> getdhgdsmList(String card){
	ArrayList<DhGdsM> rlist = new ArrayList<DhGdsM>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("dhgdsm_card",card));
			List<BaseEntity> list = Tools.getManager(DhGdsM.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					DhGdsM pp = (DhGdsM)be;
                     rlist.add(pp);
				}
			}
	return rlist ;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>9色POLO活动-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsinfo.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmstlistCart.js")%>"></script>
<script type="text/javascript">
function CheckForm(obj){
	var checkgds = $('#tblList input[type=checkbox]:checked');
	var iSelectCnt = checkgds.length;
    if (iSelectCnt == 0){
    	$.alert('请选择商品!');
        return;
    }
    var iMaxCount = -1;
    var strMaxCount = $('#hdnMaxCount').val();
    if (strMaxCount != null && strMaxCount.length > 0){
    	iMaxCount = parseInt(strMaxCount, 10);
    }
    if (iMaxCount != -1){
    	if (iSelectCnt != iMaxCount){
    		$.alert('请选择' + iMaxCount + '件商品!');
            return;
        }
    }
    var arr = new Array();
    checkgds.each(function(i){
    	arr[i] = $(this).val();
    });
    $('#btnAddToCart').attr('attr',arr.toString());
    $.inCart1(obj,{ajaxUrl:'/html/zt2012/20120727polo/xsyListInCart.jsp',width:600,align:'center'},{'code':$(obj).attr("code")});
}

</script>
<style type="text/css">
   .newpoloul{ padding:0px; margin:0px;}
   .newpoloul li{ float:left; margin-right:5px; margin-bottom:10px;}

</style>
</head>
<%
String code="7954";
String strcontent="";
String imgtopstr="";
long maxcount=0;
if(code!=null&&code.trim().length()>0)
{
	  ProductXsY pxy=(ProductXsY)Tools.getManager(ProductXsY.class).get(code);
	  //ProductXsYHelper.getById(code.trim());
	  if(pxy!=null)
	  {
		  long iValidFlag=pxy.getGdsmstxsy_validflag();
		  Date startdate=pxy.getGdsmstxsy_startdate();
		  Date enddate=pxy.getGdsmstxsy_enddate();
		  strcontent=pxy.getGdsmstxsy_content();
		  long strSex=pxy.getGdsmstxsy_sex();
		  				  
		  //判断活动状态
		  if(iValidFlag==1)
		  {
			  out.print("<script>alert('活动已经结束！');top.location.href='http://www.d1.com.cn';</script>");
			  return;
		  }
		  //判断活动是否开始
		  Date now=new Date();
		  if (startdate.compareTo(now)>0)
		  {
			  out.print("<script>alert('活动还没开始！');top.location.href='http://www.d1.com.cn';</script>");
			  return;
		  }
		  //记录选择的最大件数
		  maxcount=pxy.getGdsmstxsy_maxcount();
		  
		
	  }
	  else
	  {
		  out.print("<script>alert('该活动不存在！！！');top.location.href='http://www.d1.com.cn';</script>");
		  return;
	  }
}
else{
	  
	  out.print("<script>alert('该活动不存在！！！');top.location.href='http://www.d1.com.cn';</script>");
	  return;
}
 

String id="03000096";
Product product = ProductHelper.getById(id);
if(product == null){
	out.print("商品不存在！");
	return;
}

String brandName = product.getGdsmst_brandname();//品牌
String rackCode = product.getGdsmst_rackcode();//类别
String gdsname = Tools.clearHTML(product.getGdsmst_gdsname());//物品名称
float saleprice = Tools.floatValue(product.getGdsmst_saleprice());//市场价
float memberprice = Tools.floatValue(product.getGdsmst_memberprice());//会员价
long discountendDate = Tools.dateValue(product.getGdsmst_discountenddate());//应该是秒杀结束的时间。
float oldmemberprice = Tools.floatValue(product.getGdsmst_oldmemberprice());//旧的会员价
String skuname1 = product.getGdsmst_skuname1();//sku1
long buylimit = Tools.longValue(product.getGdsmst_buylimit());
long ifhavegds = Tools.longValue(product.getGdsmst_ifhavegds());//缺货标识
long validflag = Tools.longValue(product.getGdsmst_validflag());//是否下架，1未下架

long tj_buylimit = 0;//秒杀购买上限
long tj_saletoday = 0;//秒杀今日购买数
String rcmdgds_gdsid = null;
String dxtitle = "";
String endprice = "";

boolean ismiaoshao = false;//是否是秒杀

String dxid = Tools.getCookie(request,"rcmdusr_rcmid");
float dxprice = 0f;
if(!Tools.isNull(dxid)){
	ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
	if(expitem != null){
		dxprice = Tools.floatValue(expitem.getRcmdgds_memberprice());
		tj_buylimit = Tools.longValue(expitem.getRcmdgds_buylimit());
		tj_saletoday = Tools.longValue(expitem.getRcmdgds_saletoday());
		rcmdgds_gdsid = expitem.getRcmdgds_gdsid();
		if(!Tools.isNull(expitem.getRcmdgds_title())){
			dxtitle = expitem.getRcmdgds_title();
		}
	}else{
		dxprice = memberprice;
	}
}
//获取团购价格
float tuanprice=0f;
List<PromotionProduct> tuanlist=PromotionProductHelper.getPProductByCode("7523");
if(tuanlist!=null&&tuanlist.size()>0)
{
    for(PromotionProduct pp:tuanlist)
    {
    	if(pp!=null)
    	{
    		if(pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().toString().equals(id)&&pp.getSpgdsrcm_enddate().after(new Date())&&pp.getSpgdsrcm_begindate().before(new Date()))
    		{
    			tuanprice=pp.getSpgdsrcm_tjprice().floatValue();
    			int r=new Random().nextInt(10);
	        	if(r==0)
	        	{
	        		r=1;
	        	}
	        	
		        pp.setSpgdsrcm_tghit(pp.getSpgdsrcm_tghit().longValue()+r);
		        if(!Tools.getManager(PromotionProduct.class).update(pp,false))
		        {
		        	System.out.print("[团购商品]商品id："+id+"更改点击数目出错!");
		        }
    		}
    	}
    }
}




long currentTime = System.currentTimeMillis();
float hyprice = 0;
if(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS && Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0){
	ismiaoshao = true;
	hyprice = oldmemberprice;
}else{
	hyprice = memberprice;
}
endprice = String.valueOf(hyprice);

String style = null;



if(!Tools.isNull(dxid) && Tools.floatCompare(dxprice, memberprice) !=0 ){
	style = "<span>￥" + Tools.getFormatMoney(hyprice) + "</span>";
}else{
	if(tuanprice>0f)
	{
		if(Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0)
		{
		     style = "<span>￥" + Tools.getFormatMoney(oldmemberprice) + "</span>";
		}
		else{
			style = "<span>￥" + Tools.getFormatMoney(memberprice) + "</span>";
		}
	}
	else
	{
	    style = "<span class='mbrprice'>￥" + Tools.getFormatMoney(hyprice) + "</span>";
	}
}




String category = "";//最小的类别，在下面初始化了。

//获取所有参与活动的商品
List<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode(code);
int lcount=0;
int contentcount=0;
if(pplist!=null&&pplist.size()>0){
for(PromotionProduct pp:pplist){
	 String ids=pp.getSpgdsrcm_gdsid();
	 lcount+=CommentHelper.getLevelView(pp.getSpgdsrcm_gdsid());//最后要改变的
	 //contentcount+=CommentHelper.getCommentLength(pp.getSpgdsrcm_gdsid());
	 if(ids.equals("03000125"))
	 {
	 	contentcount+=CommentHelper.getCommentLength(ids)+CommentHelper.getCommentLength("03000088");
	 }
	 else if(ids.equals("03000124")){
	 	contentcount+=CommentHelper.getCommentLength(ids)+CommentHelper.getCommentLength("03000089");	
	 }
	 else if(ids.equals("03000123")){
	 	contentcount+=CommentHelper.getCommentLength(ids)+CommentHelper.getCommentLength("03000090");		
	 }
	 else if(ids.equals("03000122")){
	 	contentcount+=CommentHelper.getCommentLength(ids)+CommentHelper.getCommentLength("03000091");		
	 }
	 else if(ids.equals("03000121")){
	 	contentcount+=CommentHelper.getCommentLength(ids)+CommentHelper.getCommentLength("03000092");	
	 	}
	 else if(ids.equals("03000120")){
	 	contentcount+=CommentHelper.getCommentLength(ids)+CommentHelper.getCommentLength("03000093");		
	 	}
	 else if(ids.equals("03000119")){
	 	contentcount+=CommentHelper.getCommentLength(id)+CommentHelper.getCommentLength("03000094");		
	 	}
	 else if(ids.equals("03000118")){
	 	contentcount+=CommentHelper.getCommentLength(id)+CommentHelper.getCommentLength("03000095");		
	 }
	 else if(ids.equals("03000117")){
	 	contentcount+=CommentHelper.getCommentLength(id)+CommentHelper.getCommentLength("03000096");		
	 }
	 else
	 {
	 	contentcount+=CommentHelper.getCommentLength(id);
	 }
 }
}
//显示星级
lcount=76;
int score = lcount/8;

String gname=Tools.clearHTML(gdsname);

if(gname.indexOf("（")>0){
	gname=gname.substring(0,gname.indexOf("（"));

}

if(gname.indexOf("(")>0){
	gname=gname.substring(0,gname.indexOf("("));
}
String fxcontent="我在@D1优尚官网 发现了一个非常不错的商品："+gname+" 优尚价：￥"+memberprice+"。感觉不错，分享一下 ";

%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" align="center">
   <tr><td height="10"></td></tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_01.jpg" width="980" height="132" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_02.jpg" width="980" height="135" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_03.jpg" width="980" height="129" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_04.jpg" width="980" height="95" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_05.jpg" width="980" height="79" alt=""></td>
	</tr>
	<tr>
		<td>
				   <!-- 商品展示-->
			    <div class="goods_new">
					
					
					<!-- 商品展示-->
					
					<table width="980">
					   <tr>
					       <td width="450" style="text-align:center;"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/goods.jpg"  /></td>
					       <td valign="top">
					         <!--商品信息说明-->
				         <div class="gs_right_spContent" style="width:100%;">
				         
					<h1 style="border-bottom:dashed 1px #ccc; font-size:17px; width:95%; ">【FEEL MIND】彩虹舒适纯棉POLO（9色）</h1>
					
                         <table border="0" cellpadding="0" cellspacing="0" width="100%">
                         <tr height="40">
							     <td colspan="3">
							     	<div style="float:left; padding-top:6px;">顾客评分：</div>
							     	<div class="sa<%=score %>" style="float:left;" ></div>
								    <div style="float:left; padding-top:6px;"><a href="#cmt2" onclick="$('#goodsinfotab > a:eq(1)').click();" rel="nofollow">(已有<%=contentcount %>人评价)</a></div>
								 </td>
						     </tr>
						     <tr>
							     <td colspan="3">
								     <div class="spgg" style="width:420px;">
								
                                   <%   String gdsarrstr="";
                                        String selectgdsid = "";
                            
									    if(pplist != null){
									    	
										    	%><div id="skuname2" class="skuname1">
									           	<p><span style="color:#FC7C17;">第一步</span>选择颜色：<font id="sizecount2"></font></p>
									    		<ul><%
									    		String selectSku2 = "";
									    		
									    		int i=1;
										    	for(PromotionProduct pp : pplist){
										    		String gId = Tools.trim(pp.getSpgdsrcm_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		//if(goods!=null&&goods.getGdsmst_validflag().longValue()==1)
										    		//{
										    		%><li <%if(i==1){ %> class="select"<%} %>>
										    		<A title="<%=pp.getSpgdsrcm_gdsname() %>" onclick=choosegdsid(this)  href="javascript:void(0);" attr="<%=pp.getSpgdsrcm_gdsid()%>" <%if(i==1){ %> class="current"<%} %>><img  height=80 width=80 src="<%=ProductHelper.getImageTo80(goods) %>" />
										    		</a>
										    		<br/><br/><br/><%=pp.getSpgdsrcm_gdsname()%></li><%
										    		//}
										    		if (i==1){
										    			selectSku2=pp.getSpgdsrcm_gdsname();
										    			selectgdsid=pp.getSpgdsrcm_gdsid();
										    			gdsarrstr=gId;
										    		}
										    		else{
										    			 if(gId.equals("03000125"))
										    			 {
										    				 gdsarrstr=gdsarrstr+","+gId+",03000088";
										    			  }
										    			 else if(gId.equals("03000124")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000089";
										    			 }
										    			 else if(gId.equals("03000123")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000090";		
										    			 }
										    			 else if(gId.equals("03000122")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000091";
										    			 }
										    			 else if(gId.equals("03000121")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000092";	
										    			 	}
										    			 else if(gId.equals("03000120")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000093";		
										    			 	}
										    			 else if(gId.equals("03000119")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000094";		
										    			 	}
										    			 else if(gId.equals("03000118")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000095";		
										    			 }
										    			 else if(gId.equals("03000117")){
										    				 gdsarrstr=gdsarrstr+","+gId+",03000096";		
										    			 }
										    			 else
										    			 {
										    				 gdsarrstr=gdsarrstr+","+gId;
										    			 }
										    		
										    		}
										    		i++;
										    	}
										    	//gdsarrstr=gdsarrstr+","+id;
										    	%></ul>
										    	</div>
										    	<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script><%
										        }
						                    int showsku=0;									    
										    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(selectgdsid,showsku);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname" class="skuname">
										    	  <div style="float:left;"><p><span style="color:#FC7C17;">第二步</span>选择尺寸：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font></p>
										         </div>
										    		<div style="float:right; padding-right:45px; position:relative;">
										    		<p>
										    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">(尺寸对照表)</font></p>
										    		</div>
										    		      <div id="ccdzb_img" style="display:none; margin-left:-270px;+margin-left:-370px; position:absolute; " onmouseover="ccdzb()" onmouseout="ccdzb1()">
										    		     
										    		       <img src="http://images.d1.com.cn/market/1206/wydh/fm9stx2_27.jpg" border="0"/>
										    		   
										    		     
										    		 </div>

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
									     %>

									 </div>
									 
									 
								 </td>
							 </tr>
							 <tr>
                                <td colspan="3" height="15"></td>
                                </tr>
                             <tr>
                                <td colspan="3">
                                    <img src="http://images.d1.com.cn/zt2012/20120727polo/images/price.jpg"/>
                                </td>
                             </tr>
							 <tr height="45"><td colspan="3" valign="middle"><%
							//if(ifhavegds == 0){
								//if(validflag == 1||validflag == 4){
								//	if(ProductStockHelper.canBuy(product)){
							 %><a href="javascript:void(0)" onclick="ShowAJaxdh()"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_06_2.jpg" /></a>
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
									    总计金额:￥<font id="countgdsmst3">59</font><br/>
									</div>
								
								</li>
								</ul>
								<div class="gwcbtn"><a href="/flow.jsp" target="_blank" onclick="display_hide('frgwc');"><img src="http://images.d1.com.cn/images2012/New/viewcart.gif" alt="查看购物车" /></a><a href="javascript:void(0)" onclick="display_hide('frgwc')"><img src="http://images.d1.com.cn/Index/images/jxgw.jpg" alt="继续购物" /></a>							</div>
							 </div>
							      <%
									//}else{
										%><!--  <img src="http://images.d1.com.cn/images2012/New/product/yxj.gif" align="absmiddle" />--><%
									//}
								//}else{
									%><!-- <img src="http://images.d1.com.cn/images2012/New/product/yxj.gif" align="absmiddle" />--><%
								//}
							// }%></td></tr>
						 </table>		 
					 </div>
					  <!--商品信息说明结束-->
					       </td>
					   </tr>
					</table>
					
					<!-- 商品展示结束-->
				 	
				  </div>
				 <!-- 商品展示结束-->
				<div class="clear"></div>
	   
	
	   </td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_07.jpg" width="980" height="71" alt=""></td>
	</tr>
	<tr>
		<td style="text-align:center;">
			<div style="margin:0px auto; width:980px;overflow:hidden;" id="tblList">
	   <%
	       ArrayList<PromotionProduct> list=PromotionProductHelper.getPromotionProductByCode(code);
	       if(list!=null&&list.size()>0)
	       {
	    	   int num=0;
	    	   out.print("<ul class=\"newpoloul\">");
	    	   for(int i=0;i<list.size();i++)
	    	   {
	    		   PromotionProduct pp=list.get(i);
	    		   Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
	    		   if(ProductHelper.isNormal(p))
	    		   {
	    			   String gdsid=p.getId();
	    			   String imgurl=p.getGdsmst_imgurl(); 
	    			   String width="239px";
	    			   if(i>=4)
	    			   {
	    				   width="191px";
	    			   }
	    			   %>
	    			   <li style="width:<%=width %>">
	    			      <table width="100%">
	    			      <tr><td height="50" style="text-align:center;">
	    			      <input type="checkbox"  name="gdsid" value="<%= gdsid %>"/><font color="#a91120"><b>&nbsp;选择此商品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font><br/>
		 				  <input type="checkbox"  name="gdsid" value="<%= gdsid %>"/><font color="#494949"><b>&nbsp;同色再来一件!</b></font><br/>
		 				  </td></tr>
	    			      </table>
	    			     
		 				  <a href="/product/<%= gdsid %>" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/g_<%=gdsid%>.jpg"/></a>
	    			   </li>
	    			  
	    			   <%
	    			   
	    		   }
	    	   }
	    	   out.print("</ul>");
	    		
	       }
	   %></div>
	   <input type="hidden" id="hdnMaxCount" value="<%=maxcount %>"></input>
	   <br/>
	   
	   <a href="javascript:void(0)" onclick="CheckForm(this);" code="<%=code %>" id="btnAddToCart"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_08_10.jpg"/></a>
	  	 <br/> <br/>
			
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_09.jpg" width="980" height="74" alt=""></td>
	</tr>
	<tr>
		<td><table id="__01" width="980" height="340" border="0" cellpadding="0" cellspacing="0" style="text-align:center;">
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/03000048" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_10_01.jpg" alt="" width="246" height="340" border="0"></a>
		    <a href="javascript:void(0)" attr="03000048" onclick="$.inCart(this)"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif"/></a>	
		</td>
		<td>
			<a href="http://www.d1.com.cn/product/03000045" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_10_02.jpg" alt="" width="243" height="340" border="0"></a>
			<a href="javascript:void(0)" attr="03000045" onclick="$.inCart(this)"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif"/></a>
			</td>
		<td>
			<a href="http://www.d1.com.cn/product/01720201" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_10_03.jpg" alt="" width="244" height="340" border="0"></a>
			<a href="javascript:void(0)" attr="01720201" onclick="$.inCart(this)"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif"/></a>
			</td>
		<td>
			<a href="http://www.d1.com.cn/product/01720200" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_10_04.jpg" alt="" width="247" height="340" border="0"></a>
		   <a href="javascript:void(0)" attr="01720200" onclick="$.inCart(this)"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif"/></a>

			</td>
	</tr>
</table></td>
	</tr>
	<tr><td>
    
				 <!--商品信息描述-->
				 <div style=" text-align:left;" ><a name="cmt"></a>
				 <hr style=" border:5px solid #fff" />
					<div id="goodsinfotab" class="zh_title" style="width:980px;"><a href="javascript:void(0)" class="newa">商品信息</a><a href="javascript:void(0)">顾客评论</a></div>
					<div class="clear"></div>
					<div id="content_list_info">
					<!-- 商品信息-->
					<span style="display:none">
					 <div class="goods_info" style="width:980px; overflow:hidden; padding-left:0px;">
					   
					  
					    <div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/Info.jpg" />商品基本信息</div>
						<div class="goods_content_list">
							<img src="http://images.d1.com.cn/market/1206/wydh/wydhbase.jpg"></img>
						</div>
						
						<div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/spxq.jpg" />商品详情</div>					
						    
						<div class="goods_content goods_info_con">
						
						 <table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
				<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_11.jpg" width="980" height="194" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_12.jpg" width="980" height="139" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_13.jpg" width="980" height="117" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_14.jpg" width="980" height="154" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_15.jpg" width="980" height="145" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_16.jpg" width="980" height="219" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_17.jpg" width="980" height="165" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_18.jpg" width="980" height="99" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_19.jpg" width="980" height="175" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_20.jpg" width="980" height="184" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_21.jpg" width="980" height="175" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_22.jpg" width="980" height="159" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_23.jpg" width="980" height="167" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_24.jpg" width="980" height="136" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_25.jpg" width="980" height="139" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_26_1.jpg" width="980" height="117" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_27_11.jpg" width="980"  alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_28.jpg" width="980" height="195" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_29.jpg" width="980" height="159" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_30.jpg" width="980" height="161" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_31.jpg" width="980" height="134" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_32.jpg" width="980" height="135" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_33.jpg" width="980" height="136" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_34.jpg" width="980" height="144" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_35.jpg" width="980" height="211" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_36.jpg" width="980" height="309" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_37.jpg" width="980" height="189" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_38.jpg" width="980" height="183" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_39.jpg" width="980" height="210" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_40.jpg" width="980" height="238" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_41.jpg" width="980" height="233" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_42.jpg" width="980" height="163" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_43.jpg" width="980" height="174" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_44.jpg" width="980" height="239" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_45.jpg" width="980" height="190" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_46.jpg" width="980" height="178" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_47.jpg" width="980" height="196" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_48.jpg" width="980" height="220" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_49.jpg" width="980" height="156" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_50.jpg" width="980" height="199" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_51.jpg" width="980" height="216" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_52.jpg" width="980" height="210" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_53.jpg" width="980" height="180" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_54.jpg" width="980" height="182" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_55.jpg" width="980" height="322" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_56.jpg" width="980" height="360" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_57.jpg" width="980" height="344" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_58.jpg" width="980" height="350" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_59.jpg" width="980" height="352" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_60.jpg" width="980" height="275" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120727polo/images/fm9s0727_61.jpg" width="980" height="249" alt=""></td>
	</tr>
</table>
						</div>
						
						<%=getBrandName(product) %>
					 </div>
					 </span>
					<!--商品信息结束-->
					
					<span style="display:none;"></span>
					
					<!-- 商品评论开始 -->
					<hr style=" border:5px solid #fff" />
					<div style="line-height:1px;height:1px;baclground:#FFF;"><a name="cmt2"></a></div>
					<div class="zh_title" id="commLink" style="width:980px;"><a href="javascript:void(0)" class="newa">顾客评论</a></div>
					<!--顾客评论-->
					<span>
					    	<div style="padding-top:10px; font-size:14px; font-weight:bold; color:#000;"><a name="cmtCnt"></a>
					    		<img src="http://images.d1.com.cn/Index/images/gkpl_star.jpg" style="vertical-align:text-bottom" />顾客评论
					    	</div>
					    	<%String[] gdsarr=null;
					    	if (!Tools.isNull(gdsarrstr)){
					    		gdsarr=gdsarrstr.split(",");
					    	}
					    	System.out.print(gdsarrstr);
					    	int commentLength =0;
					    	 for(int j=0;j<gdsarr.length;j++){
					    		 commentLength+=CommentHelper.getCommentLength(gdsarr[j]);
					    	  }
					    	
					    	int PAGE_SIZE = 10 ;
					    	PageBean pBean = new PageBean(commentLength,PAGE_SIZE,1);
					    	
					    	List<Comment> commentlist = CommentHelper.getinCommentList(gdsarr,pBean.getStart(),PAGE_SIZE);
					    	if(commentlist != null && !commentlist.isEmpty()){
					    		//int size = commentlist.size();
					    		int avgscore=0;
					    		for(int j=0;j<gdsarr.length;j++){
					    		 avgscore+=CommentHelper.getLevelView(gdsarr[j]);
					    		}
					    		avgscore=avgscore/8;
					    	%>
					    	<div style="background-color:#F4F4F4;">
								<table cellpadding="0" cellspacing="0" style="margin-left:10px; margin-right:20px; margin-top:10px; margin-bottom:10px; width:95%; line-height:28px;">
									<tr>
					                  <td><div style="float:left">
					                        <div style="float:left;font-size:12px">购买过的顾客评分 |</div>
					                         <div class="sa<%=score %>" style="float:left;" ></div>
					                       </div></td>
					                     <td  align="right"></td>
					                 </tr>
								</table>
							</div>
							<div style="padding-top:10px" id="commentContent">
								<table cellpadding="0" cellspacing="0" style="font-size:12px; width:100%">
										    	
						 <%
						 for(Comment comment:commentlist){
							 User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
								//if(user == null) continue;
								String hfusername = getUid(comment.getGdscom_uid());
								String level = UserHelper.getLevelText(user);
								if(comment.getGdscom_mbrid().intValue()==-1){
									level="普通会员";
								}
								else if(comment.getGdscom_mbrid().intValue()==-2){
									level="VIP会员";
								}
								else if(comment.getGdscom_mbrid().intValue()==-3){
									level="白金会员";
								}
							 %>
							 <tr>
								<td>
								<div id="comment" class="m">
					                <div class="mc" >
					                    <div id="divitem" class="item">
					                        <div class="user">
					                            <div class="u-icon">
					                               <img src="<%=UserHelper.getLevelImage(level) %>" width="70" height="70" />                      
					                            </div>
					                            <div class="u-name">
					                             <span><%=hfusername %></span><br></br>
					                             <span><%=level %></span>
					                            </div>
					                       
					                        </div>
					                        <div class="i-item">
					                        <div class="o-topic">
					                          <div style="float:left"><strong class="topic">
					                            <label style="font-weight:bold">评分：</label>
					                            </strong>
					                            <img src="http://images.d1.com.cn/images2012/New/gds_star<%=comment.getGdscom_level() %>.gif" /></div>
					                            
					                            <div style="float:right"><span class="date-comment">
					                           <%=Tools.stockFormatDate(comment.getGdscom_createdate()) %>
					                            </span></div>
					                            
					                        </div>
					                        <div class="o-topic" style="border:none;" >
					                             <div style="line-height:26px;" class="comment-content">
					                                 <dl>
					                                    <dd><%=comment.getGdscom_content() %></dd>
					                                  </dl>
					                             </div>
					                            
					                        </div>
					                       
					                        <div class="comment-content">
					                           <dl>
					                           <dd>
					                           <%
					                            if(!Tools.isNull(comment.getGdscom_replyContent())){
					                            	 %>	
					                            	 <p style="color:#892D3D;line-height:26px;" >D1优尚回复：<%=comment.getGdscom_replyContent() %></p>
					                          <%  }
					                           %>
					                            
					                           </dd>
					                           </dl>    
					                        </div>
					                        </div>
					                        <div class="corner tl"></div>
					                     
					                    </div>
					                </div>
					
					        </div>
								</td>
							</tr><%
						}
						if(pBean.getTotalPages()>1){ %>
						<tr>
							<td><div class="GPager">
					           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
					           	<%if(pBean.getCurrentPage()>1){ %><a href="#cmtCnt" onclick="pro_comment2('<%=gdsarrstr %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#cmtCnt" onclick="pro_comment2('<%=gdsarrstr %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
					           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
					           		if(i==1){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="#cmtCnt" onclick="pro_comment2('<%=gdsarrstr %>',<%=i %>);"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean.hasNextPage()){%><a href="#cmtCnt" onclick="pro_comment2('<%=gdsarrstr %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
					           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#cmtCnt" onclick="pro_comment2('<%=gdsarrstr %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
					           </div></td>
						</tr><%
						} %>
						</table> </div>
					<%
					}else{
					%><div class="commentmore" id="commentmore" > 还没有会员进行评论。</div><%
				} %>
				   </span>
				    <!-- 商品评论结束 -->
					</div>
                  <div class="clear"></div>
				</div>
				 
				 <!--商品信息描述结束-->
   </td></tr>
</table>
<!-- End ImageReady Slices -->
<%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>

<script type="text/javascript">
$(document).ready(function(){
	$('#settings').mouseover(function(){
		$('#opciones').slideToggle();
		$('#settings').hide();
		$(this).toggleClass("cerrar");
    });
	$('#opciones').mouseover(function(){
		$('#opciones').show();
		$('#settings').hide();
	}).mouseout(function(){
		$('#opciones').hide();
		$('#settings').show();
	});
	//$(".goods_info_con").find("img").lazyload({effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
	$('#hyyhsmLink').hover(function(){
		var o = $(this).offset();
		$('#hyyhsm').show().css("left",($(this).offset().left-70)+"px");
	},function(){
		$('#hyyhsm').toggle();
	});
});


function ccdzb()
{
 // var top=$('#skuname').offset().top+$('#skuname p').height()-5;
  //var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
 // $("#ccdzb_img").css("top",top);
 // $("#ccdzb_img").css("left",right+200);
  $("#ccdzb_img").css("display","block");

}
function ccdzb1()
{
	$("#ccdzb_img").css("display","none");
}
//选择不同色商品
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
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/flow/wydhmoresku.jsp',
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

//放入购物车操作
function ShowAJaxdh(){
	var sku2=BLGG2();
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
		url: 'ninecolorpolo.jsp',
		cache: false,
		data: {gdsid:skuys,skuId:sku2},
		error: function(XmlHttpRequest){
			$.alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){			
			if(json.success){
				document.getElementById("cardimg").src=json.cardimg;
				$("#spname1").html(json.pname);
				$('#frgwc').css("top","700px");
				$('#frgwc').show();
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
};
function pro_comment2(id,pg){
	$('#commentContent').html("<div align='center'><img src='/res/images/Loading.gif' /></div>");
	$.post("/ajax/product/commentList2.jsp",{"id":id,"pg":pg,"m":new Date().getTime()},function(data){
		$('#commentContent').html(data);
	});
}

</script>