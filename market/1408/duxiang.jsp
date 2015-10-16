<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<ProductExpPriceItem> getdxlist( String dxid){
	
	if( !Tools.isMath(dxid)) return null;
	ArrayList<ProductExpPriceItem> rlist = new ArrayList<ProductExpPriceItem>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("rcmdgds_rcmid", new Long(dxid)));
	
	List<BaseEntity> list = Tools.getManager(ProductExpPriceItem.class).getList(listRes, null, 0, 2000);
	
	if(list!=null){
		for(BaseEntity be:list){
			rlist.add((ProductExpPriceItem)be);		
		}
	}
	return rlist;
}

%><%
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if (!Tools.isNull(httpurl)){
	try{
	       httpurl =java.net.URLDecoder.decode(httpurl,"UTF-8");
   }
   catch(Exception ex){
 	  ex.printStackTrace();
   }
}
String productip = request.getHeader("x-forwarded-for");
if(productip == null || productip.length() == 0 || "unknown".equalsIgnoreCase(productip)) {
	productip = request.getHeader("Proxy-Client-IP");
}
if(productip == null || productip.length() == 0 || "unknown".equalsIgnoreCase(productip)) {
	productip = request.getHeader("WL-Proxy-Client-IP");
}
if(productip == null || productip.length() == 0 || "unknown".equalsIgnoreCase(productip)) {
	productip = request.getRemoteAddr();
}
String dxstr=request.getParameter("dx");
ArrayList<Promotion> ppright=PromotionHelper.getBrandListByCode("3721", 10);//轮播3685
String adpic="";
String subtxt="";
if(ppright!=null&&ppright.size()>0)
{
	for(Promotion ptt:ppright){

		   if(ptt.getSplmst_name()!=null&&ptt.getSplmst_name().equals(dxstr)){
			   adpic=ptt.getSplmst_picstr();
			   subtxt=ptt.getSplmst_url();
			   break;
		   }
	}
}

ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(347)); 
if(rcmdusr!=null &&adpic!=""
  	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
  	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
  	){
	String strsubad=rcmdusr.getRcmdusr_uid()+"-"+subtxt;

	 Tools.setCookie(response,"rcmdusr_rcmid","347",(int)(Tools.DAY_MILLIS/1000*3));
	 Tools.setCookie(response,"d1.com.cn.peoplercm.subad",strsubad,(int)(Tools.DAY_MILLIS/1000*3));  
	 Lmclk lk = new Lmclk();
	    lk.setLmclk_createdate(new Date());
	    lk.setLmclk_uid("");
	    lk.setLmclk_linkurl("");
	    lk.setLmclk_from(httpurl);
	    lk.setLmclk_ip(productip);
	    lk.setLmclk_subad(strsubad);
	    Tools.getManager(Lmclk.class).create(lk);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<title>优尚8月大抢节 --D1优尚</title>
<style>
body{background:#f5ce1b}
.banner328{
	
	background-repeat: no-repeat;
	background-position: center;
	height:581px;
}

   .plist{margin:10px 0;}
    .plist li{width:238px;height:330px;margin-top:8px;}
   .plist li.l{float:left;margin-right:9px;}
   .plist li.r{float:right;}
    .plist li .item{background:#ffffff;text-aligin:center;padding:0 8px;}
	 .plist li .item .mprice{font-size:36px;font-family:微软雅黑;color:#BA242F}
	  .plist li .item .mpricet{font-size:18px;font-family:微软雅黑;color:#BA242F}


</style>
</head>
<body style="background:#EEEEEE;">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<%
/*1    女装 020
2.男装 030
3.化妆品 014
4.居家 012 060 070 080
5.箱包、配饰 050 040 015
6.男鞋女鞋  021 031*/

	ArrayList<Product> plist1=new ArrayList<Product>();
	ArrayList<Product> plist2=new ArrayList<Product>();
	ArrayList<Product> plist3=new ArrayList<Product>();
	ArrayList<Product> plist4=new ArrayList<Product>();
	ArrayList<Product> plist5=new ArrayList<Product>();
	ArrayList<Product> plist6=new ArrayList<Product>();
		    List<ProductExpPriceItem>  pdxlist= getdxlist("347");
		    for(ProductExpPriceItem pdx:pdxlist){
		    	Product p=ProductHelper.getById(pdx.getRcmdgds_gdsid());
		    	if(p==null)continue;
		    	if(p.getGdsmst_rackcode().startsWith("020")){
		    		plist1.add(p);
		    	}else if(p.getGdsmst_rackcode().startsWith("030")){
		    		plist2.add(p);
		    	}else if(p.getGdsmst_rackcode().startsWith("014")){
		    		plist3.add(p);
		    	}else if(p.getGdsmst_rackcode().startsWith("012")||p.getGdsmst_rackcode().startsWith("060")
		    			||p.getGdsmst_rackcode().startsWith("070")||p.getGdsmst_rackcode().startsWith("080")){
		    		plist4.add(p);
		    	}else if(p.getGdsmst_rackcode().startsWith("050")||p.getGdsmst_rackcode().startsWith("040")
		    			||p.getGdsmst_rackcode().startsWith("015")){
		    		plist5.add(p);
		    	}else if(p.getGdsmst_rackcode().startsWith("021")||p.getGdsmst_rackcode().startsWith("031")){
		    		plist6.add(p);
		    	}
		    		
		    }
         

%>
<%if(!Tools.isNull(adpic)){%>
<div style="background-image: url(<%=adpic %>);" class="banner328">
</div>
<%} %>

<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_01.jpg" width="980" height="81" alt=""></td>
	</tr>
	<tr>
		<td>
	<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><a href="http://www.d1.com.cn/product/04001220" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/mact0821_01.jpg"></a></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/product/01418361" target="_blank"><img src="http://images.d1.com.cn/zt2014/08/mact0821_02.jpg"></a></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/market/1408/mact0730_02.jpg"></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/market/1408/mact0730_03.jpg"></td>
  </tr>
</table>
			

</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_04.jpg" width="980" height="86" alt=""></td>
	</tr>
	<tr>
		<td>
         <div class="plist">
			<ul>
			<%if(plist1!=null&&plist1.size()>0){
				int i=0;
				for(Product p:plist1){
					String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
			    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "347");
			    	int mprice=p.getGdsmst_memberprice().intValue();
			    	int saleprice=p.getGdsmst_saleprice().intValue();
			    	int dxprice=mprice;
                    if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice().intValue();
				%>
				<li class="<%=(i+1)%4==0?"r":"l" %>">
				 <div class="item">
				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td colspan="3" align="center"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="<%=ProductHelper.getImageTo200(p) %>" width="200" height="200"></a></td>
			         </tr>
				     <tr>
				       <td colspan="3" style="height:50px;overflow:hidden;"><a href="/product/<%=p.getId() %>" target="_blank" ><%=imgalt %></a></td>
			         </tr>
				     <tr>
				       <td width="38%" height="40"><s>市场价:￥<%=saleprice %></br><s>会员价:￥<%=mprice %></s></td>
				       <td width="33%" rowspan="2"><span class="mprice"><%=dxprice %></span></td>
				       <td width="29%" rowspan="2"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn/zt2014/08/but.png" width="61" height="30"></a></td>
			         </tr>
				     <tr>
				       <td height="36"><span class="mpricet">抢劫价:￥</span></td>
			         </tr>
			       </table>
				 </div>
				</li>
				<%i++;
				}
				}%>
			</ul>
		 </div>
		</td>
	</tr>

	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_06.jpg" width="980" height="85" alt=""></td>
	</tr>
	<tr>
		<td>
         <div class="plist">
			<ul>
			<%if(plist2!=null&&plist2.size()>0){
				int i=0;
				for(Product p:plist2){
					String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
			    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "347");
			    	int mprice=p.getGdsmst_memberprice().intValue();
			    	int saleprice=p.getGdsmst_saleprice().intValue();
			    	int dxprice=mprice;
                    if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice().intValue();
				%>
				<li class="<%=(i+1)%4==0?"r":"l" %>">
				 <div class="item">
				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td colspan="3" align="center"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="<%=ProductHelper.getImageTo200(p) %>" width="200" height="200"></a></td>
			         </tr>
				     <tr>
				       <td colspan="3" style="height:50px;overflow:hidden;"><a href="/product/<%=p.getId() %>" target="_blank" ><%=imgalt %></a></td>
			         </tr>
				     <tr>
				       <td width="38%" height="40"><s>市场价:￥<%=saleprice %></br><s>会员价:￥<%=mprice %></s></td>
				       <td width="33%" rowspan="2"><span class="mprice"><%=dxprice %></span></td>
				       <td width="29%" rowspan="2"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn/zt2014/08/but.png" width="61" height="30"></a></td>
			         </tr>
				     <tr>
				       <td height="36"><span class="mpricet">抢劫价:￥</span></td>
			         </tr>
			       </table>
				 </div>
				</li>
				<%i++;
				}
				}%>
			</ul>
		 </div>
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_08.jpg" width="980" height="85" alt=""></td>
	</tr>
	<tr>
		<td>
         <div class="plist">
			<ul>
			<%if(plist3!=null&&plist3.size()>0){
				int i=0;
				for(Product p:plist3){
					String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
			    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "347");
			    	int mprice=p.getGdsmst_memberprice().intValue();
			    	int saleprice=p.getGdsmst_saleprice().intValue();
			    	int dxprice=mprice;
                    if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice().intValue();
				%>
				<li class="<%=(i+1)%4==0?"r":"l" %>">
				 <div class="item">
				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td colspan="3" align="center"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="<%=ProductHelper.getImageTo200(p) %>" width="200" height="200"></a></td>
			         </tr>
				     <tr>
				       <td colspan="3" style="height:50px;overflow:hidden;"><a href="/product/<%=p.getId() %>" target="_blank" ><%=imgalt %></a></td>
			         </tr>
				     <tr>
				       <td width="38%" height="40"><s>市场价:￥<%=saleprice %></br><s>会员价:￥<%=mprice %></s></td>
				       <td width="33%" rowspan="2"><span class="mprice"><%=dxprice %></span></td>
				       <td width="29%" rowspan="2"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn/zt2014/08/but.png" width="61" height="30"></a></td>
			         </tr>
				     <tr>
				       <td height="36"><span class="mpricet">抢劫价:￥</span></td>
			         </tr>
			       </table>
				 </div>
				</li>
				<%i++;
				}
				}%>
			</ul>
		 </div>
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_10.jpg" width="980" height="87" alt=""></td>
	</tr>
	<tr>
		<td>
         <div class="plist">
			<ul>
			<%if(plist4!=null&&plist4.size()>0){
				int i=0;
				for(Product p:plist4){
					String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
			    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "347");
			    	int mprice=p.getGdsmst_memberprice().intValue();
			    	int saleprice=p.getGdsmst_saleprice().intValue();
			    	int dxprice=mprice;
                    if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice().intValue();
				%>
				<li class="<%=(i+1)%4==0?"r":"l" %>">
				 <div class="item">
				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td colspan="3" align="center"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="<%=ProductHelper.getImageTo200(p) %>" width="200" height="200"></a></td>
			         </tr>
				     <tr>
				       <td colspan="3" style="height:50px;overflow:hidden;"><a href="/product/<%=p.getId() %>" target="_blank" ><%=imgalt %></a></td>
			         </tr>
				     <tr>
				       <td width="38%" height="40"><s>市场价:￥<%=saleprice %></br><s>会员价:￥<%=mprice %></s></td>
				       <td width="33%" rowspan="2"><span class="mprice"><%=dxprice %></span></td>
				       <td width="29%" rowspan="2"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn/zt2014/08/but.png" width="61" height="30"></a></td>
			         </tr>
				     <tr>
				       <td height="36"><span class="mpricet">抢劫价:￥</span></td>
			         </tr>
			       </table>
				 </div>
				</li>
				<%i++;
				}
				}%>
			</ul>
		 </div>
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_12.jpg" width="980" height="85" alt=""></td>
	</tr>
	<tr>
		<td>
         <div class="plist">
			<ul>
			<%if(plist5!=null&&plist5.size()>0){
				int i=0;
				for(Product p:plist5){
					String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
			    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "347");
			    	int mprice=p.getGdsmst_memberprice().intValue();
			    	int saleprice=p.getGdsmst_saleprice().intValue();
			    	int dxprice=mprice;
                    if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice().intValue();
				%>
				<li class="<%=(i+1)%4==0?"r":"l" %>">
				 <div class="item">
				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td colspan="3" align="center"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="<%=ProductHelper.getImageTo200(p) %>" width="200" height="200"></a></td>
			         </tr>
				     <tr>
				       <td colspan="3" style="height:50px;overflow:hidden;"><a href="/product/<%=p.getId() %>" target="_blank" ><%=imgalt %></a></td>
			         </tr>
				     <tr>
				       <td width="38%" height="40"><s>市场价:￥<%=saleprice %></br><s>会员价:￥<%=mprice %></s></td>
				       <td width="33%" rowspan="2"><span class="mprice"><%=dxprice %></span></td>
				       <td width="29%" rowspan="2"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn/zt2014/08/but.png" width="61" height="30"></a></td>
			         </tr>
				     <tr>
				       <td height="36"><span class="mpricet">抢劫价:￥</span></td>
			         </tr>
			       </table>
				 </div>
				</li>
				<%i++;
				}
				}%>
			</ul>
		 </div>
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/08/mact0730_14.jpg" width="980" height="86" alt=""></td>
	</tr>
	<tr>
		<td>
         <div class="plist">
			<ul>
			<%if(plist6!=null&&plist6.size()>0){
				int i=0;
				for(Product p:plist6){
					String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
			    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(p.getId(), "347");
			    	int mprice=p.getGdsmst_memberprice().intValue();
			    	int saleprice=p.getGdsmst_saleprice().intValue();
			    	int dxprice=mprice;
                    if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice().intValue();
				%>
				<li class="<%=(i+1)%4==0?"r":"l" %>">
				 <div class="item">
				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td colspan="3" align="center"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="<%=ProductHelper.getImageTo200(p) %>" width="200" height="200"></a></td>
			         </tr>
				     <tr>
				       <td colspan="3" style="height:50px;overflow:hidden;"><a href="/product/<%=p.getId() %>" target="_blank" ><%=imgalt %></a></td>
			         </tr>
				     <tr>
				       <td width="38%" height="40"><s>市场价:￥<%=saleprice %></br><s>会员价:￥<%=mprice %></s></td>
				       <td width="33%" rowspan="2"><span class="mprice"><%=dxprice %></span></td>
				       <td width="29%" rowspan="2"><a href="/product/<%=p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn/zt2014/08/but.png" width="61" height="30"></a></td>
			         </tr>
				     <tr>
				       <td height="36"><span class="mpricet">抢劫价:￥</span></td>
			         </tr>
			       </table>
				 </div>
				</li>
				<%i++;
				}
				}%>
			</ul>
		 </div>
		</td>
	</tr>
</table>
<%@include file="/inc/foot.jsp"%>
</body>
</html>