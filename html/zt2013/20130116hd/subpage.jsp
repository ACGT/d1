<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProduct(String code , int count){
	if(!Tools.isMath(code)) return null;
	if(count <= 0) count = 200;
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long(code)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	//olist.add(Order.desc("spgdsrcm_begindate"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, count);
	if(clist==null||clist.size()==0)return null;
	
	int total = 0 ;
	for(BaseEntity be:list){
		PromotionProduct pp = (PromotionProduct)be;
		Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
		//if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
		if(product!=null){
			rlist.add(pp);
			total++;
			
		}
		
	}
	return rlist ;
}


private ArrayList<Product> getProductlist(String code)
{
	if(Tools.isNull(code)||!Tools.isNumber(code)) return null;
	ArrayList<Product> resultlist=new ArrayList<Product>();
	ArrayList<PromotionProduct> pplist=getPProduct(code,-1);
	if(pplist!=null&&pplist.size()>0)
	{
		for(PromotionProduct pp:pplist)
		{
			if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
			{
				Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
				{
					resultlist.add(p);
				}
			}
		}
	}
	else return null;
	if(resultlist!=null&&resultlist.size()>0)
	{
		return resultlist;
	}
	else
	{
		return null;
	}
}
private ArrayList<Product> getProductlistend(String code)
{
	if(Tools.isNull(code)||!Tools.isNumber(code)) return null;
	ArrayList<Product> resultlist=new ArrayList<Product>();
	ArrayList<PromotionProduct> pplist=getPProduct(code,-1);
	if(pplist!=null&&pplist.size()>0)
	{
		for(PromotionProduct pp:pplist)
		{
			if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
			{
				Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(p!=null&&(p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()!=1||p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()!=0))
				{
					resultlist.add(p);
				}
			}
		}
	}
	else return null;
	if(resultlist!=null&&resultlist.size()>0)
	{
		return resultlist;
	}
	else
	{
		return null;
	}
}

%>
<%
   String code="8404";
   if(request.getParameter("code")!=null&&request.getParameter("code").length()>0&&Tools.isNumber(request.getParameter("code")))
   {
	   code=request.getParameter("code");
   }
   String order ="2";
   if(!Tools.isNull(request.getParameter("order"))&&Tools.isNumber(request.getParameter("order")))
   {
	   order=request.getParameter("order");
   }
   
   //if(!code.equals("8404")&&!code.equals("8396")&&!code.equals("8397")&&!code.equals("8398")&&!code.equals("8399")&&!code.equals("8402")&&!code.equals("8401")&&!code.equals("8403")&&!code.equals("8405"))
   //{
	  
   //}
    ArrayList<Product> productlist=getProductlist(code);
    ArrayList<Product> endproduct=getProductlistend(code);
    if(Tools.isMath(order)){
    	
		int o = Tools.parseInt(order);
		switch(o){
			case 4 ://上架时间			 
				Collections.sort(productlist,new CreateTimeComparator());
				Collections.reverse(productlist);
				break;
			case 3://热销商品
				Collections.sort(productlist,new SalesComparator());
				Collections.reverse(productlist);
				break;
			case 2://价格，升序
				Collections.sort(productlist , new PriceComparator());
				break;
			case 1://价格，倒序
				Collections.sort(productlist , new PriceComparator());
				Collections.reverse(productlist);
				break;
			default:
				Collections.sort(productlist , new PriceComparator());
				break;
		}
	}
   //分页
	int pageno1=1;
	String ggURL = Tools.addOrUpdateParameter(request,null,null);
	if(ggURL != null) 
	{
		ggURL.replaceAll("pageno1=[0-9]*","");
	}
	//翻页
	int totalLength1 = (productlist != null ?productlist.size() : 0);
	int PAGE_SIZE = 40 ;
	int currentPage1 = 1 ;
	String pg1 ="1";
	if(request.getParameter("pageno1")!=null)
	{
		pg1= request.getParameter("pageno1");
		pageno1=Tools.parseInt(request.getParameter("pageno1"));
	}
	if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
	PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
	int end1 = pBean1.getStart()+PAGE_SIZE;
	if(end1 > totalLength1) end1 = totalLength1;
	String pageURL2 = ggURL.replaceAll("pageno1=[^&]*","").replaceAll("order=[^&]*","");
	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
	String title="饰品";
	if(code.equals("8396")) {title="羽绒服/棉服";}
    else if(code.equals("8397"))
    {title="毛衫";}
    else if(code.equals("8398"))
    {title="衬衫";}
    else if(code.equals("8399"))
    { title="T恤/卫衣";}
    else if(code.equals("8401"))
    {title="外套"; }
    else if(code.equals("8402"))
    {title="女裙"; }
    else if(code.equals("8403"))
    {title="服装配件"; }
    else if(code.equals("8404"))
    {title="饰品"; }
    else if(code.equals("8405"))
    {title="反季抢购"; }
	if(endproduct!=null&&endproduct.size()>0)
	{
	   productlist.addAll(endproduct);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<title>服饰满200-100活动-<%= title %>--D1优尚网</title>
<style type="text/css">
.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; }
.newlist ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:10px;}
.newlist li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; margin-bottom:10px;  }
.newlist p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding-top:7px; background-color:#fff; over-flow:hidden; }
</style>
</head>

<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div style="width:980px; margin:0px auto;">
     <%
       if(code.equals("8396")) {%>
    	 <img src="http://images.d1.com.cn/zt2013/20120116hd/01mf1.jpg" border="0" usemap="#Map"/>
			<map name="Map" id="Map"><area shape="rect" coords="1,0,182,399" href="http://www.d1.com.cn/product/03000297" target="_blank" />
			<area shape="rect" coords="182,2,395,398" href="http://www.d1.com.cn/product/02001045" target="_blank" />
			</map>  
       <%}
       else if(code.equals("8397"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/02my.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="3,2,273,400" href="http://www.d1.com.cn/product/03000214" target="_blank" />
			<area shape="rect" coords="274,3,431,400" href="http://www.d1.com.cn/product/02000858" target="_blank" />
			</map>
       <%}
       else if(code.equals("8398"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/03cs.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="4,1,225,399" href="http://www.d1.com.cn/product/03000192" target="_blank" />
<area shape="rect" coords="225,3,428,411" href="http://www.d1.com.cn/product/02000957" target="_blank" /></map>
       <%}
       else if(code.equals("8399"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/04tw1.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="2,1,257,453" href="http://www.d1.com.cn/product/02000584" target="_blank" />
<area shape="rect" coords="663,2,978,450" href="http://www.d1.com.cn/product/03000202" target="_blank" /></map>
       <%}
       else if(code.equals("8401"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/05wt.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="3,2,286,405" href="http://www.d1.com.cn/product/01710446" target="_blank" />
           <area shape="rect" coords="719,1,980,396" href="http://www.d1.com.cn/product/02000488" target="_blank" />
           </map>
       <%}
       else if(code.equals("8402"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/06qz.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="1,1,208,401" href="http://www.d1.com.cn/product/02000531" target="_blank" />
            <area shape="rect" coords="206,3,387,403" href="http://www.d1.com.cn/product/02000543" target="_blank" />
            </map>
       <%}
       else if(code.equals("8403"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/07ps.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="0,-2,300,465" href="http://www.d1.com.cn/product/03300070" target="_blank" />
            <area shape="rect" coords="299,2,616,481" href="http://www.d1.com.cn/product/02103027" target="_blank" />
            </map>
       <%}
       else if(code.equals("8404"))
       {%>
    	   <a href="http://www.d1.com.cn/product/01516984" target="_blank"><img src="http://images.d1.com.cn/zt2013/20120116hd/08sp.jpg" border="0" /></a>
			
       <%}
       else if(code.equals("8405"))
       {%>
    	   <img src="http://images.d1.com.cn/zt2013/20120116hd/09fjqg1.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map"><area shape="rect" coords="1,-2,226,223" href="http://www.d1.com.cn/product/03000025" target="_blank" />
			<area shape="rect" coords="227,0,467,228" href="http://www.d1.com.cn/product/03000037" target="_blank" />
			<area shape="rect" coords="466,1,702,224" href="http://www.d1.com.cn/product/02000577" target="_blank" />
			<area shape="rect" coords="705,1,981,447" href="http://www.d1.com.cn/product/02000556" target="_blank" />
			<area shape="rect" coords="3,224,226,499" href="http://www.d1.com.cn/product/03000109" target="_blank" />
			</map>
       <%}
   %>
   
   
   
   <div style="background:url('http://images.d1.com.cn/images2012/New/result/spjs_7.gif'); width:980px; height:38px;overflow:hidden;line-height:40px;">
               <span style="float:left">&nbsp;&nbsp;<img src="http://images.d1.com.cn/images2012/New/result/red2.gif" style="_padding-top:4px;padding-top:2px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
               <span style="float:left;color:#555555; font-weight:bold; font-size:14px;">共有<font style=" color:#f00"><%=totalLength1 %></font>个产品&nbsp;&nbsp;&nbsp;&nbsp;</span>
               <span style="float:left;color:#555555; font-size:12px;">排序方式</span>
               <dd>
                   <a href="<%=pageURL2 %>&order=2" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/result/price2.gif" border="0" style="margin:8px; "></a>
                   <a href="<%=pageURL2 %>&order=1" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/result/price1.gif" border="0" style="margin:8px; "></a>
                   <a href="<%=pageURL2 %>&order=4" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/result/newsale2.gif" border="0" style="margin:8px; "></a>
                   <a href="<%=pageURL2 %>&order=3" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/result/saletop1.gif" border="0" style="margin:8px; "></a>
               </dd>
   </div>
   <div class="newlist" style=" text-align:center;overflow:hidden;  padding-bottom:18px; ">
<ul>
<%
    if(productlist!=null&&productlist.size()>0){
    for(int i=(pageno1-1)*40;i<productlist.size()&&i<pageno1*40;i++){
	    Product product=productlist.get(i);		
		Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
		String theimgurl="";
		if(!Tools.isNull(product.getGdsmst_img240300())&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03"))){
			theimgurl="http://images.d1.com.cn"+product.getGdsmst_img240300(); 
		}
		else
		{
		    theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
		}
		String imgalt=Tools.clearHTML(product.getGdsmst_gdsname());
		float memberprice=product.getGdsmst_memberprice().floatValue();
		String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
		String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
		double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
		String fl=ProductGroupHelper.getRoundPrice((float)dl);
		out.print("<li style=\"height:390px;\">");
	%>
	
	<div class="lf">
	<% 
           				
           				if(!Tools.isNull(product.getGdsmst_img240300())&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03"))){
           					%>
           					<p style="z-index:999; position:relative;height:300px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           								<img src="<%= theimgurl%>" width="240" height="300"  alt="<%= imgalt %>"/>
           					
           				<%}else{
           				%> 
           	           <p style="z-index:999; position:relative; padding-top:30px; padding-bottom:30px;"><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank" >
           								<img src="<%= theimgurl%>" width="240" height="240"  alt="<%= imgalt %>"/>
           				<%}%>
		
		</a>
		<%
		if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
			%>
			<span style="position:absolute; width:46px; height:90px; dislay:block; background:url('http://images.d1.com.cn/zt2012/20121113flcx/sx.png'); left:8px; top:-8px; z-index:5000;"></span>
		<%}else{
			%>
		<span style="position:absolute; width:45px; height:56px; dislay:block; background:url('http://images.d1.com.cn/zt2013/20120116hd/200-100.png'); left:8px; top:-8px; z-index:5000;"></span>
			<%}
		%>
		
	</p>	
		<div style="background:#e5e1e0; width:240px;height:80px;padding:0px;">
		<div  style="font-size:12px;padding-left:5px;padding-right:5px;padding-top:3px; padding-bottom:0px;height:38px;">
		 <table style="height:38px;">
			              <tr>
			              <td valign="middle">
		<%=StringUtils.getCnSubstring(Tools.clearHTML(product.getGdsmst_gdsname()),0,66)%>
		</td></tr></table>
		 </div>
			              <div  style="font-size:12px;padding-left:5px;padding-right:5px;"> 
			              <table>
			              <tr>
			              <td valign="middle"><span >市场价：￥<%=Tools.getFormatMoney(product.getGdsmst_saleprice()) %>&nbsp;&nbsp;</span></td>
			              <td> <span style=" font-family:'微软雅黑';color:red; font-weight:bold; font-size:30px;">&nbsp;&nbsp;￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></span></td></tr>
			              </table>
			                 
			           </div>
		</div>
		
		

    </div>  
    <div class="clear"></div>
    </li>
		<%	}
	}



%>
</ul>
</div>
<!--分页 -->
<% if(productlist!=null&&productlist.size()>0&&pBean1.getTotalPages()>1)
					       {%>
					    	    <span class="GPager" style="width:980px;margin:0px auto;display:block; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span>
					    	   
					      <%  }
%>
<!-- 分页结束 -->
</div>



<%@include file="/inc/foot.jsp"%>
</body>
</html>
