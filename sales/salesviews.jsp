<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@ page  import="com.d1.comp.*" %><%!
public  ArrayList<PromotionProduct> getPProductByCodes(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
	if(list==null||list.size()==0)return null;
	
	int total = 0 ;
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null) continue;
			rlist.add(pp);
			total++;
			if(total==num)break;
		}
	}
		
	return rlist ;
}


public  ArrayList<Product> getProductListById(String salesmst_recid,String orderid){
	ArrayList<PromotionProduct> promotionplist =getPProductByCodes(salesmst_recid , 1000);

	ArrayList<Product> list=new ArrayList<Product>();
	if(promotionplist!=null){
		for(PromotionProduct product:promotionplist){
			Product p=ProductHelper.getById(product.getSpgdsrcm_gdsid());
			if(p!=null){
				p.setSequence(product.getSpgdsrcm_seq().intValue());
				list.add(p);
			}
		}
	}
	//排序
	if(orderid.equals("1")){
		Collections.sort(list,new SalesViewsCreateCom());// order by   gdsmst_createdate desc
	}
	else if(orderid.equals("2")){
		Collections.sort(list,new SalesViewsSalesCom());// order by   gdssale_weeksalecount desc
		//Collections.reverse(list);
	}
	else if(orderid.equals("3")){
		Collections.sort(list,new SalesViewPNameCom());// order by   gdsmst_gdsname 
		Collections.reverse(list);
	}
	else if(orderid.equals("4")){
		Collections.sort(list,new SalesViewsPriceCom());// order by   gdsmst_memberprice desc
		Collections.reverse(list);
	}
	else if(orderid.equals("5")){
		Collections.sort(list,new SalesViewsPriceCom());// order by   gdsmst_memberprice 
		
	}
	else{
		Collections.sort(list,new SalesSequenceComparator());// order by gdsmst_updatedate desc
	}
	
	//System.out.println(list.size());
	return list;
}


public  ArrayList<Product> getProductListById_new(String salesmst_recid,String orderid){
	ArrayList<PromotionProduct> promotionplist =getPProductByCodes(salesmst_recid , 1000);

	ArrayList<Product> zlist=new ArrayList<Product>();
	ArrayList<Product> qlist=new ArrayList<Product>();
	
	ArrayList<Product> list=new ArrayList<Product>();
	if(promotionplist!=null){
		for(PromotionProduct product:promotionplist){
			Product p=ProductHelper.getById(product.getSpgdsrcm_gdsid());
			if(p!=null){
				p.setSequence(product.getSpgdsrcm_seq().intValue());
				if(p.getGdsmst_validflag().longValue()!=1 || p.getGdsmst_ifhavegds().longValue()!=0)
				{
					qlist.add(p);
				}
				else
				{
					zlist.add(p);
				}
				//list.add(p);
			}
		}
	}
	//排序
	if(orderid.equals("1")){
		Collections.sort(zlist,new SalesViewsCreateCom());// order by   gdsmst_createdate desc
		Collections.sort(qlist,new SalesViewsCreateCom());
	}
	else if(orderid.equals("2")){
		Collections.sort(zlist,new SalesViewsSalesCom());// order by   gdssale_weeksalecount desc
		Collections.sort(qlist,new SalesViewsSalesCom());
		//Collections.reverse(list);
	}
	else if(orderid.equals("3")){
		Collections.sort(zlist,new SalesViewPNameCom());// order by   gdsmst_gdsname 
		Collections.reverse(zlist);
		Collections.sort(qlist,new SalesViewPNameCom());// order by   gdsmst_gdsname 
		Collections.reverse(qlist);
	}
	else if(orderid.equals("4")){
		Collections.sort(zlist,new SalesViewsPriceCom());// order by   gdsmst_memberprice desc
		Collections.reverse(zlist);
		Collections.sort(qlist,new SalesViewsPriceCom());// order by   gdsmst_memberprice desc
		Collections.reverse(qlist);
	}
	else if(orderid.equals("5")){
		Collections.sort(zlist,new SalesViewsPriceCom());// order by   gdsmst_memberprice 
		Collections.sort(qlist,new SalesViewsPriceCom());
	}
	else{
		Collections.sort(zlist,new SalesSequenceComparator());// order by gdsmst_updatedate desc
		Collections.sort(qlist,new SalesSequenceComparator());
	}
	
	//System.out.println(list.size());
	list.addAll(zlist);
	list.addAll(qlist);
	return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/sales.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" >
var the_s=new Array();

function $getid(id)
{
    return document.getElementById(id);
}

function view_time(the_s_index,objid){

    if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        html = "倒计时: ";
        if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) html += '<span class="hour">'+(the_H)+"</span>小时";
        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<span class="minute">'+the_M+"</span>分";
        html += '<span class="second">'+the_S+"</span>秒";
        $getid(objid).innerHTML = html;
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";

    }
}
</script>
<%
String id="";
String title="";
if(request.getParameter("id")!=null){
	  id=request.getParameter("id");
	  int tjjs=1;
	  SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		 String	nowtime= DateFormat.format(new Date());
		 if(id.trim().length()!=0){	 
			  ArrayList<ProductSale> list=ProductSaleHelper.getProductInfoById(id);
			  if(list!=null){
				for(ProductSale productSale:list){
					title=productSale.getSalesmst_title();
				}
			  }
		 %>
<title><%= title %></title>

</head>
<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
		 <% 
		  if(list!=null){
			for(ProductSale productSale:list){
				String	endtime= DateFormat.format(productSale.getSalesmst_endtime());
				String imglink=productSale.getSalesmst_zylink().trim();
				String imgurl=productSale.getSalesmst_zyimg().trim();
				String tourl="salesviews.jsp?id="+id;
				String salesmst_recid=productSale.getSalesmst_recid().toString();
			   
				%>
<!-- 中部开始 -->
<div class="viewsbg" align="center">
<div class="viewstitle mgt8"><%if(imglink.length()!=0){%>
<a href="<%=imglink%>" target="_blank"><%}%><img src="<%=imgurl%>" border="0" /><%if(imglink.length()!=0){%></a><%}%></div>
<div class="viewsmenu mgt8">

<table width="937" height="41" border="0" align="center" class="lincss" cellpadding="0" cellspacing="0">
      <tr>
        <td width="547" height="41" align="left"><span class=time id=tjjs_1></span>
   <SCRIPT language=javascript>
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=endtime%>");the_s[<%=tjjs%>]=(endDate.getTime()-startDate.getTime())/1000;setInterval("view_time(<%=tjjs%>,'tjjs_<%=tjjs%>')",1000);</SCRIPT></td>
        <td width="26" valign="middle"><a href="<%=tourl%>&amp;sequence=2"><img src="http://images.d1.com.cn/images2010/listtype2.gif" width="13" height="16" /></a></td>
        <td width="55"><a href="<%=tourl%>&amp;sequence=2">热销排行</a></td>
        <td width="17" valign="middle"><a href="<%=tourl%>&sequence=1"><img src="http://images.d1.com.cn/images2010/listtype3.gif" width="13" height="16" /></a></td>
        <td width="65"><a href="<%=tourl%>&sequence=1">最新上架</a></td>
        <td width="20"><a href="<%=tourl%>&sequence=5"><img src="http://images.d1.com.cn/images2010/listtype4.gif" width="11" height="15" /></a></td>
        <td width="44"><a href="<%=tourl%>&sequence=5">价格</a></td>
        <td width="20"><a href="<%=tourl%>&sequence=4"><img src="http://images.d1.com.cn/images2010/listtype5.gif" width="11" height="15" /></a></td>
        <td width="59"><a href="<%=tourl%>&sequence=4">价格</a></td>
        <td width="22" ><a href="<%=tourl%>&sequence=3"><img src="http://images.d1.com.cn/images2010/listtype7.gif" width="19" height="13" /></a> </td>
        <td width="62" ><a href="<%=tourl%>&sequence=3">名称</a></td>
      </tr>
    </table>
</div>


<div class="gdslist mgt8">
<div style="width:965px;overflow:hidden; padding-bottom:18px; margin:auto 0px;">
<%
String orderid="0";
if(request.getParameter("sequence")!=null){
	orderid=request.getParameter("sequence");
}
ArrayList<PromotionProduct> promotionplist =getPProductByCodes(salesmst_recid , 1000);
ArrayList<Product> productlist=getProductListById_new(salesmst_recid,orderid);

//System.out.println("商品数量"+gdslist.size());
if(productlist!=null){
	int i=0;
	for(Product product:productlist){
		PromotionProduct promotionProduct=null;
		if(promotionplist!=null){
			for(PromotionProduct pproduct:promotionplist){
				if(product.getId().equals(pproduct.getSpgdsrcm_gdsid())){
					promotionProduct=pproduct;
				}	
			}
		}
		String theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
		String spgdsrcm_layertype="";
		if(promotionProduct!=null){
			
			//out.println("otherimg"+promotionProduct.getSpgdsrcm_otherimg());
			//out.println("memberprice"+product.getGdsmst_memberprice().floatValue());
			if(!Tools.isNull(promotionProduct.getSpgdsrcm_otherimg())){
				theimgurl=promotionProduct.getSpgdsrcm_otherimg();
			}
			spgdsrcm_layertype=promotionProduct.getSpgdsrcm_layertype();
		
		float memberprice=product.getGdsmst_memberprice().floatValue();
		String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
		String imgalt=product.getGdsmst_gdsname().trim();
		imgalt=imgalt.replace("<", "").replace(">", "").replace(".", "").replace("+", "").replace("?", "");
		if(imgalt.length()>25){
			imgalt=imgalt.substring(0,25);
		}
		float gdsmst_validflag=product.getGdsmst_validflag().floatValue();
		float gdsmst_ifhavegds=product.getGdsmst_ifhavegds().floatValue();
		 String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
		 String oldmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice());
		double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
		 String fl=ProductGroupHelper.getRoundPrice((float)dl);
		%>
		<div style="width:225px;_width:220px; float:left; height:320px; /*FF*/ *height:320px;/*IE7*/ _height:320px;/*IE6*/  
		<%if (i!=0 && (i/4+1)!=((i/4)+1) ){ %>		  margin-left:15px; _margin-left:0px; <%}else{%> margin-left:13px; _margin-left:12px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF;" >
	<dl style="text-align:left;">
<dt style="width:205px; text-align:center;padding-left:10px; float:left">
		<div style="position:relative; float:left;width:200px;height:200px;">
			<%if (gdsmst_validflag!=1 || gdsmst_ifhavegds!=0) {%>
			<div style="position:absolute;width:200px;height:200px;z-index:999; text-align:left"><img src="http://images.d1.com.cn/images2011/sales/tm005.gif" /></div>
			<%}%>
		<a href="<%if (promotionProduct.getSpgdsrcm_otherlink().trim().length()==0){%>
		/product/<%=product.getId()%><%}else{%><%=promotionProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none'>
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0">
			<%
			String t="";
			String x="";
			if(spgdsrcm_layertype.trim().length()!=0){ 
				t=spgdsrcm_layertype;
				x=promotionProduct.getSpgdsrcm_layertitle();
				//PromotionProductHelper.showLayer(spgdsrcm_layertype, promotionProduct.getSpgdsrcm_layertitle());
			}else{
				t=product.getGdsmst_layertype();
				x=product.getGdsmst_layertitle();
				//PromotionProductHelper.showLayer(product.getGdsmst_layertype(),product.getGdsmst_layertitle());
			} %>
			  <% 
		   request.setAttribute("t", t);
		   request.setAttribute("x", x);
	%>
			<jsp:include page="showLayer.jsp" flush="true" /> 
			</a></div>

</dt>
<dd style="width:205px; text-align:left; padding-left:10px; float:left">
<div style="height:42px;width:205px;"><a href="<%if (promotionProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{promotionProduct.getSpgdsrcm_otherlink().trim();}%>">
		<font style="font-size:10pt" color="#3c3c3c"><%=imgalt%></font></a></div>

		<strike>市场价：￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_saleprice())) %></strike>&nbsp;&nbsp;<strike>原会员价：￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_oldmemberprice())) %></strike><br/>
		 <span style="font-size:14px;font-weight:bold;color:#ff0000;">秒杀价:￥<%=strmprice%></span> 
			<span  style="font-size:14px;font-weight:bold;color:#ff0000;">&nbsp;&nbsp;折扣：<%=fl%></span><br>
			<div align="right" style="height:40px"><%
			if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0 && ProductStockHelper.canBuy(product)){
			%>
				<a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" border="0" /></a><%
			}else{ %>
				<a href="###"><img src="http://images.d1.com.cn/images2012/New/product/qh.jpg" /></a><%
			}%>
			</div>
</dd>
</dl>
	
</div>	

	<%
	i++;
	}
	      }
	}else{
		out.print("活动已结束") ;
	}

	%>

<div class="clear"></div>

</div>
</div>
<%}}%>
<!--<center>该活动已结束！</center>-->
<%}} %>


	</div>
<!-- 优惠活动 -->
<table class="otheryhhd" cellspacing="0" cellpadding="0">
  <tr><td style=" border-top:1px solid #ccc; width:332px;"></td><td style="width:300px;"><span>以下优惠活动正在进行中</span></td><td style=" border-top:1px solid #ccc; width:348px;"></td></tr>
  <tr><td colspan="3">
  <%  //获取其他特卖列表
      StringBuilder sb=new StringBuilder();
      ArrayList<Promotion> lists=new ArrayList<Promotion>();
      lists=PromotionHelper.getBrandListByCode("2786",100);
     
      if(lists!=null&&lists.size()>0)
      {
    	  sb.append("<ul>");
    	  for(Promotion p:lists)
    	  {
    		 if(p.getSplmst_tjendtime().after(new Date()))
    		 {
	    		 if(p.getSplmst_url().indexOf("http://www.d1.com.cn/sales/salesviews.jsp?id=")>=0)
	    		 {
	    			 if(p!=null&&!p.getSplmst_url().substring(p.getSplmst_url().indexOf("id=")+3,p.getSplmst_url().length()).equals(id))
	    			 {
	    				  sb.append("<li><a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\" title=\"").append(Tools.clearHTML(p.getSplmst_name())).append("\">");
		       			  sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\"305\" height=\"180\"/>");
		       			  sb.append("</a></li>");
	    			 }
	    		 }
	    		 else
	    		 {
		    		  if(p!=null)
		    		  {
		    			  sb.append("<li><a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\" title=\"").append(Tools.clearHTML(p.getSplmst_name())).append("\">");
		    			  sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\"305\" height=\"180\"/>");
		    			  sb.append("</a></li>");
		    		  }
	    		 }
    		 }
    	  }
    	  sb.append("</ul>");
      }
     
  %>
  <%= sb.toString() %>
  </td></tr>
  
</table>


<div class="clear"></div>
<!-- 优惠活动结束 -->

<!-- 中部结束 -->
<%@include file="/inc/foot.jsp"%>
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<script type="text/javascript" language="javascript">
$(document).ready(function() {
	 $("div").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
	 $("table td ul").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});
</script>