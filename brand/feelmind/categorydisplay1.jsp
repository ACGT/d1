<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
     return list;
}
 static ArrayList<Directory> getBycode(String rackcode) {
	ArrayList<Directory> list=new ArrayList<Directory>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("rakmst_rackcode", rackcode));
	clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
	List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(clist, null, 0, 1);
	if(clist==null||clist.size()==0)return null;
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	return list;
}
public static ArrayList<Product> getTProductList(String brandname,String sequence,HashMap<String,String> map,String productname){
	ArrayList<Product> list=new ArrayList<Product>();
	ArrayList<Product> list2=new ArrayList<Product>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_brandname", brandname));
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	if(!Tools.isNull(productname)){
		//System.out.print("qqqqqqqqqqqqqqqqqqqqqqqqqqqq");
		clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
	}
	
	List<Order> olist = new ArrayList<Order>();
	//olist.add(Order.desc("gdsmst_createdate"));
	
	boolean flag = false ;
	
	if(sequence.equals("4")){
		olist.add(Order.desc("gdsmst_createdate"));
	}
	else if(sequence.equals("1")){
		olist.add(Order.desc("gdsmst_memberprice"));
	}
	else if(sequence.equals("2")){
		olist.add(Order.asc("gdsmst_memberprice"));
	}
	else if(sequence.equals("3")){
		//olist.add(Order.desc("gdsmst_salecount"));
	}
	else if(sequence.equals("5")){
		//System.out.print("qqqqqqqqqqqqqqqqqqqqqqqqqqqq");
		olist.add(Order.desc("gdsmst_stdvalue2"));
	}
	else{
		olist.add(Order.desc("gdsmst_createdate"));
		
	}
	
	List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 3000);
	if(b_list==null||b_list.size()==0)return null;
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Product)be);
		}
	}
	
	if(map!=null && !map.isEmpty() && list!=null){
	 	
	 	List<Map.Entry<String, String>> infoIds =
	 					    new ArrayList<Map.Entry<String, String>>(map.entrySet());
	 	
	 	 HashMap<String, String> map2=new HashMap<String, String>();
	 	for(Product p:list){
	 		boolean isyx=false;
	 		for (int i = 0; i < infoIds.size(); i++) {
		 	    String id = infoIds.get(i).getKey().toString().trim();
		 	    if(p.getGdsmst_rackcode().startsWith(id)){
		 	    	 isyx=true;
		 	    }
		 	}
	 		if(isyx){
	 			list2.add(p);
	 		}
	 	}
	 	 
	 	
	}
	if(list==null || list.size()==0) return null;
	
	if(sequence.equals("1")){
		Collections.sort(list2,new PriceComparator());
		Collections.reverse(list2);
	}
	else if(sequence.equals("2")){
		Collections.sort(list2,new PriceComparator());
	}
	else if(sequence.equals("3") || flag){
	Collections.sort(list2,new SalesComparator());
	Collections.reverse(list2);
	}
	else if(sequence.equals("4")){
		Collections.sort(list2,new CreateTimeComparator());
		}
	else if(sequence.equals("5")){
		Collections.sort(list2,new ProductColorCompartor());
		}else{
			Collections.sort(list2,new CreateTimeComparator());
		}
return list2;
}

public static ArrayList<Product> getProductListByRCode(String brandname,String sequence,String productsort,String productname){
	ArrayList<Product> list=new ArrayList<Product>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_brandname", brandname));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
		if(!Tools.isNull(productname)){
			//System.out.print("qqqqqqqqqqqqqqqqqqqqqqqqqqqq");
			clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
		}
		
		List<Order> olist = new ArrayList<Order>();
		//olist.add(Order.desc("gdsmst_createdate"));
		
		boolean flag = false ;
		
		if(sequence.equals("4")){
			olist.add(Order.desc("gdsmst_createdate"));
		}
		else if(sequence.equals("1")){
			olist.add(Order.desc("gdsmst_memberprice"));
		}
		else if(sequence.equals("2")){
			olist.add(Order.asc("gdsmst_memberprice"));
		}
		else if(sequence.equals("3")){
			//olist.add(Order.desc("gdsmst_salecount"));
		}
		else if(sequence.equals("5")){
			//System.out.print("qqqqqqqqqqqqqqqqqqqqqqqqqqqq");
			olist.add(Order.desc("gdsmst_stdvalue2"));
		}
		else{
			if(productsort!=null&& (productsort.startsWith("020")|| productsort.startsWith("030"))){
				flag=true;
			}else{
				olist.add(Order.desc("gdsmst_createdate"));
			}
		}
		
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 3000);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}
		if(sequence.equals("3") || flag){
		Collections.sort(list,new SalesComparator());
		Collections.reverse(list);
		}
	return list;
}

%>
<%
   String stitle="";
   String stitles="";
   String scontent="";
   String ps="";
   if(!Tools.isNull(request.getParameter("productsort"))&&request.getParameter("productsort").length()>0)
   {
	  ps=request.getParameter("productsort");
	  Directory dir=DirectoryHelper.getById(ps);
	  if(dir!=null)
	  {
		  String rname=dir.getRakmst_rackname();
		  stitle=rname;
		  if(ps.length()==6)
	      {
	    	  if(ps.startsWith("020"))
	    	  {
	    		  scontent="女装,"+rname;
	    	  }
	    	  if(ps.startsWith("030"))
	    	  {
	    		  scontent="男装,"+rname;
	    	  }
	      }
		  if(ps.length()==9)
		  {
			  if(ps.equals("030007001")||ps.equals("030007002"))
			  {
				  scontent="男装,";
				  Directory dirs=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
				  stitles=dirs.getRakmst_rackname();
				  if(dirs!=null)
				  {
					  scontent+=dirs.getRakmst_rackname()+","+rname+dirs.getRakmst_rackname();
				  }
			  }
			  else
			  {
				  if(ps.startsWith("020"))
				  {
					  scontent="女装,";
					  Directory dirs=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
					  stitles=dirs.getRakmst_rackname();
					  if(dirs!=null)
					  {
						  scontent+=dirs.getRakmst_rackname()+","+rname;
					  }
				  }
				  if(ps.startsWith("030"))
				  {
					  scontent="男装,";
					  Directory dirs=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
					  stitles=dirs.getRakmst_rackname();
					  if(dirs!=null)
					  {
						  scontent+=dirs.getRakmst_rackname()+","+rname;
					  }
				  }
			  }
		  }
	  }
      
   }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<% if(ps.equals("030007001")||ps.equals("030007002")){ %>
   <title>Feel Mind<%= stitle+stitles %>【图片_价格_评价_怎么样】</title>
   <meta name="description" content="D1优尚网是国内唯一在线销售<%= scontent %>,Feel Mind<%=stitle %><%= stitles %>商品，提供<%= scontent %>Feel Mind<%= stitle+stitles %>的最新报价、促销、评论、导购、图片等相关信息" />
   <meta name="keywords" content="<%= scontent %>,Feel Mind<%=stitle+stitles %>报价、促销、新闻、评论、导购、图片" />
   
<%}
else{
%>
<title>Feel Mind<%= stitle %>【图片_价格_评价_怎么样】</title>
<meta name="description" content="D1优尚网是国内唯一在线销售<%= scontent %>,Feel Mind<%=stitle %>商品，提供<%= scontent %>Feel Mind<%= stitle %>的最新报价、促销、评论、导购、图片等相关信息" />
<meta name="keywords" content="<%= scontent %>,Feel Mind<%=stitle %>报价、促销、新闻、评论、导购、图片" />
<%} %>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/feelmind.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
 <script language=javascript>
 function view_time2(){
		var startDate= new Date();
		var endDate= new Date("2012/07/20 15:00:00");
		var lasttime=(endDate.getTime()-startDate.getTime())/1000;
	    if(lasttime>0){
	    	var the_D=Math.floor((lasttime/3600)/24)
	        var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
	        var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
	        var the_S=Math.floor((lasttime-the_H*3600)%60);
	       if(the_D!=0){$("#topd").text(the_D);}
	        if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
	        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
	        $("#tops").text(the_S);
	       // $getid(objid).innerHTML = html+html2+html1;
	        lasttime--;
	    }
	}	
	$(document).ready(function() {
		var startDate= new Date();
		var endDate= new Date("2012/07/20 15:00:00");
		var lasttime=(endDate.getTime()-startDate.getTime())/1000;
	    if(lasttime>0){
	  setInterval(view_time2,1000);
	    }
	});
		</script>

</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->


	  	   <%
	 String productbrand="FEEL MIND";
			 String orderContent = request.getParameter("order");
			 String productname="";
			 if(!Tools.isNull(request.getParameter("productname"))){
			 productname=request.getParameter("productname");
			 }
			// out.print("<script>alert('"+productname+"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"+"')</script>");
	  if(!Tools.isNull(orderContent)){
	 	orderContent = Tools.simpleCharReplace(orderContent);
	 	}else{
	 	orderContent = "4";
	 }
	 String ggURL = Tools.addOrUpdateParameter(request,null,null);
	 if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
	 String productsort = request.getParameter("productsort");
		HashMap<String, String> map=new HashMap<String, String>();
	 if(!Tools.isNull(productsort)){
	 	productsort = productsort.trim();
	 	productsort = Tools.simpleCharReplace(productsort);
	 	String ps123 = productsort;
	 	//如果传了多个分类，只取第一个，原来有传多个分类的链接
	 	//if(ps123.indexOf(",")>-1){
	 		//ps123 = ps123.substring(0,ps123.indexOf(","));
	 //	}
	 
	 	String [] strlist=ps123.split(",");
	 	for(int i=0;i<strlist.length;i++){
	 		if(!Tools.isNull(strlist[i]) && Tools.isNumber(strlist[i])){
	 			map.put(strlist[i], strlist[i]);
	 		}
	 	}
	 	
	 	//Directory dir = DirectoryHelper.getById(ps123);
	 	//if(dir == null){
	 	//	response.sendRedirect("/index.jsp");
	 	//	return;
	 	//}
	 }else{
	 	response.sendRedirect("/index.jsp");
	 	return;
	 }
	 List<Product> productList =null;
	 if(map!=null && map.size()>1){
		 productList =getTProductList(productbrand,orderContent,map,productname);
		}else{
			 productList =getProductListByRCode(productbrand,orderContent,productsort,productname);
		}
		
		int totalLength = (productList != null ?productList.size() : 0);
		
		int PAGE_SIZE = 30 ;
 	    int currentPage = 1 ;
 	    String pg = request.getParameter("pageno");
 	    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
 	    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
 	 
 	    int end = pBean.getStart()+PAGE_SIZE;
 	    if(end > totalLength) end = totalLength;
		
		String orderURL = ggURL.replaceAll("order=[^&]*","");
		orderURL = orderURL.replaceAll("pageno=[0-9]+","&");
		orderURL = orderURL.replaceAll("&+", "&");
		if(!orderURL.endsWith("&")) orderURL = orderURL + "&";
		orderURL=orderURL.replace("brand/feelmind/", "fm").replace("jsp", "htm");
		String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
		
 	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 	    pageURL = pageURL.replaceAll("&+", "&");
 	    
		%>
<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	     	   <table height="90" width="980" class="newtable">
	       <tr><td colspan="2" height="40"></td></tr>
	       <tr><td width="800"></td><td><a href="http://www.d1.com.cn/zhuanti/20120620tyd/tyd.jsp" target="_blank" >实体体验店</a>
	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	       <a href="http://feelmind.d1.com.cn/fmbrand.htm" target="_blank"  >品牌故事</a>
	       </td></tr>
	      
	   </table>
	    <div class="fmenul">
	     <ul>      
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmman.htm" style="font-size:16px; ">FM首页</a></li>
				<li <% if(ps.equals("030")) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" style="font-size:16px; ">男装</a></li>
				<li <% if(ps.equals("020")) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" style="font-size:16px; ">女装</a></li>
                <li><a href="http://feelmind.d1.com.cn/fmlovels.htm" style="font-size:16px; ">情侣装</a></li>
                <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=1">加州男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=2">加州女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=1">西部男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=2">西部女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=4&sex=1">学院男装</a></li>
				</ul>
        </div>
		</div>
		 <div class="clear"></div>
     </div>
     <div class="fmanc">
	   <!--左侧开始-->
	   <div class="fmancl">
	       <div class="fclsmenu">
		     <ul class="one">
		     <%
		     String sex="1";
		     if(productsort.startsWith("03")){
		    	 sex="1"; 
		     }else if(productsort.startsWith("02")){
		    	 sex="2"; 
		     }
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("987");
	if(Gdsserlist!=null && Gdsserlist.size()>20){
		for(Gdsser g:Gdsserlist){
			if("2".equals(sex) && "4".equals(g.getId())){
				continue;
			}else{
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="http://feelmind.d1.com.cn/fmseries.htm?serid=<%=g.getId() %>&sex=2" ><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}}
	} %>
		  
	         </ul>
			<%
			String rackcode="03";
			if(productsort.startsWith("02")){
				rackcode="02";
			}
			request.setAttribute("brandname", "FEEL MIND");
			request.setAttribute("rackcode", rackcode);
			request.setAttribute("productsort", productsort);
			//request.setAttribute("url", "categorydisplay");
			%>
			<jsp:include   page= "category1.jsp"   />
		   </div>
	   </div>
	   <!--左侧结束-->
	    <!--右侧开始-->
	  	   <div class="fclass" style="overflow:hidden;">

	     <div class="top">
		 <h4>排序方式：</h4>	 
	       <ul>
	         <li><a href="<%=orderURL%>order=4" rel="nofollow">最新上架</a></li>
			 <li><a href="<%=orderURL%>order=3" rel="nofollow">热销商品</a></li>
			 <li><a href="<%=orderURL%>order=2" rel="nofollow">价格</a><img src="http://images.d1.com.cn/images2012/feelmind/images/up.gif" width="12" height="13"/></li>
			 <li><a href="<%=orderURL%>order=1" rel="nofollow">价格</a><img src="http://images.d1.com.cn/images2012/feelmind/images/dw.gif" width="12" height="13"/></li>
			  <li><a href="<%=orderURL%>order=5" rel="nofollow">颜色</a></li>
			 
           </ul>
		   <div class="clear"></div>
         </div>
		 <div class="fclasslist">
		 <%
		
		 Directory d=DirectoryHelper.getById(productsort);
		 String rname="";
		 if(d!=null){
			 rname=d.getRakmst_rackname().trim();
		 }
		 %>
		 <h3><%=rname %></h3>
		 <%
           if(productList != null && !productList.isEmpty()){
        	   
        	   List<Product> gList = productList.subList(pBean.getStart(),end);
        	   if(gList != null && !gList.isEmpty()){
        		   %>
        			  <table style="border:none;" cellpadding="0" cellspacing="0">
        				 
        			   <%
        			   int i=1;
        	           for(Product goods : gList){
        	        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
        	        	   String id = goods.getId();
        	        	   ArrayList<GdsCutImg> cutimglist= getByGdsid(id);
        	        	   String img="http://images.d1.com.cn/"+goods.getGdsmst_imgurl().trim();
        	        	   if(cutimglist!=null && cutimglist.size()>0){
        	        		   if(!Tools.isNull(cutimglist.get(0).getGdscutimg_200().trim())){
        	            		   img="http://images.d1.com.cn"+cutimglist.get(0).getGdscutimg_200().trim();
        	            	   } 
        	        	   }
        	        	  if(i%3==1){
        	        	%>	  
        	        	<tr>
        	        	 <% }
        	        	%>
        					<td style="text-align:center; width:245px;" valign="top">
        				<div style="padding-left:15px;">
        					 <table style="border:none;" cellpadding="0" cellspacing="0" style="text-align:center; width:245px;">
        					 <tr><td height="8px"></td> </tr>
        					 <tr><td><a href="http://www.d1.com.cn/product/<%=id %>" target="_blank"><img src="<%=img %>" width="200" height="200" border="0" /></a></td></tr>
        					 <tr><td height="60px"> <div style="width:200px; color:#919191; margin-left:15px;"><%=title%></div></td></tr>
        					 <tr><td style="color:#919191;"> <span><strong><%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></strong></span>&nbsp;&nbsp;<span class="delprice" style="text-decoration: line-through;"><%=Tools.getFormatMoney(goods.getGdsmst_saleprice()) %></span></td></tr>
        					 
        					 </table>
        				</div>	
        					</td>  
        			       
        				   
        				 
        				 <%
        				if(i%3==0){
        					%>
        					</tr>
        				<%}
        				 i++;
        	           } %>
        		      </table>
        		       <%}} %>
        	</div>			   
		 <div class="clear"></div>
<%
           if(pBean.getTotalPages()>1){
        	   //System.out.print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
           %>
           <div class="GPager">
           	<span style="color:#919191">共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           			if(i==1)
           			{%>
           				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
           			<%}
           			else
           			{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		    }
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
           </div><%}%>
           <div class="clear"></div>
	    <div  style="height:15px;"></div>
	   </div> 
	   <!--右侧结束-->
	    <div class="clear"></div>
	 </div>
	 
  </div>
</div>
<%@include file="foot.jsp" %>
</body>
</html>
