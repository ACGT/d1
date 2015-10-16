<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%
  String code=request.getParameter("code");
  String hdtitle="";
  String strcontent="";
  String imgtopstr="";
  long maxcount=0;
 
  String strImg = request.getParameter("img");
  if (strImg!=null&&strImg.length()>0)
  {
	  if(strImg.startsWith("http://"))
	  {
		  imgtopstr=strImg;
	  }
	  else
	  {
		  imgtopstr="http://www.d1.com.cn" + strImg;
	  }
  }
  
  
  if(code!=null&&code.trim().length()>0)
  {
	  ProductXsY pxy=(ProductXsY)Tools.getManager(ProductXsY.class).get(code);
	  //ProductXsYHelper.getById(code.trim());
	  if(pxy!=null)
	  {
		  hdtitle=pxy.getGdsmstxsy_title();
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
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta name="description" content="D1优尚 抢购活动" />
<meta name="keywords" content="D1优尚 抢购活动" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/XsylistCart.js")%>"></script>
<style type="text/css">
.center{ margin:0px auto; width:980px;}
.content{ color:#666; font-size:13px; line-height:16px; text-align:left; padding-bottom:5px;}
.content a{ text-align:left; width:200px; font-size:12px; text-decoration:underline; color:#333; line-height:18px; }

</style>
<script type="text/javascript">
//<![CDATA[
function CheckForm(obj){
	var checkgds = $('#tblList input[type=checkbox]:checked');
	var iSelectCnt = checkgds.length;
    if (iSelectCnt == 0){
    	$.alert('请选择商品!');
        return;
    }
   
    var strMaxCount = $('#hdnMaxCount').val();
    var arr = new Array();
    var choosenum=0;
    checkgds.each(function(i){
    	var a="#"+$(this).val()+"_num";
    	choosenum+=parseInt($(a).val());
    	arr[i] = $(this).val()+"|"+$(a).val();
    });
    //alert(choosenum);
    if(choosenum!=strMaxCount){
    	 $.alert('最多能选择'+ strMaxCount + '件商品!');
    	 return;
    }
    $('#btnAddToCart').attr('attr',arr.toString());
    //alert($(obj).attr("code"));
   $.inCart1(obj,{ajaxUrl:'/ajax/flow/listXsyInCarttest.jsp',width:600,align:'center'},{'code':$(obj).attr("code")});
}

function checknum(obj){
	 var strMaxCount = $.trim($('#hdnMaxCount').val());
	 var num=$(obj).val();
	 if(num>strMaxCount){
		 $.alert('最多能选择'+ strMaxCount + '件商品!');
		 $(obj).val(strMaxCount)
	 }
}
//]]
</script>
</head>

<body>
  <div id="wrapper">
	<!--头部-->
	<%@include file="../inc/head.jsp" %>
	<!-- 头部结束-->
	 <div class="center">
	 <% if(imgtopstr.length()>0)
	 {
		 %>
		  <img src="<%= imgtopstr %>" ></img>
		 <%		 
	 }	 
	%>
	   
	   <table width="980" border="0" cellspacing="0" cellpadding="0" align="center" height="1">
	      <tr>
                <td align=center>
		            <br/><font color="red" size="5"><b><span><%=hdtitle %> </span></b></font>
		        </td>
		    </tr>
            <tr> 
                <td bgcolor="#E8E8E8" background="http://images.d1.com.cn/images2012/New/line2.gif"></td>
            </tr>
            <tr><td height="10"></td></tr>
            <tr><td align="center"><span><%= strcontent %></span></td></tr>
            <tr><td height="30"></td></tr>
	   </table>
	   <!-- 商品绑定 -->
	   <div style="margin:0px auto; width:980px;overflow:hidden;" id="tblList">
	   <%
	       ArrayList<PromotionProduct> list=PromotionProductHelper.getPromotionProductByCode(code);
	       if(list!=null&&list.size()>0)
	       {
	    	   int num=0;
	    	   for(int i=0;i<list.size();i++)
	    	   {
	    		   PromotionProduct pp=list.get(i);
	    		   Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
	    		   if(ProductHelper.isNormal(p))
	    		   {
	    			   String gdsid=p.getId();
	    			   String imgurl=p.getGdsmst_imgurl();
	    			  
	    			    num++;
		    			if(num%4==1)
		    			{%>
		    				   <div style="margin:0px auto; width:980px;overflow:hidden;">
		    			<%}
	    			   if(num%4==0)
	    			   {
	    			   %>
	    			     <div style=" width:204px; overflow:hidden; float:left; margin-right:0px;">
	     					<div style="text-align:center; width:202px; border:solid 1px #ccc; overflow:hidden; font-size:13px; ">
	   
	     					<input type="checkbox"  name="gdsid" value="<%= gdsid %>"/><font color="#ff0000"><b>选择此商品</b></font><br/>
		 					<a href="http://www.d1.com.cn/product/<%= gdsid %>" target="_blank">
		 					<img src="http://images.d1.com.cn<%= imgurl %>" width="200" height="200"/></a><br/>
		 					</div>
		                     
							<div class="content">
							<a href="/product/<%= gdsid %>" target="_blank">【<%= Tools.getFloat(p.getGdsmst_memberprice()/p.getGdsmst_saleprice()*10, 1)  %>折】<%= pp.getSpgdsrcm_gdsname() %> </a>
							<br/>
							
							<!-- 是否添加运费 -->
							<% if(p.getGdsmst_addshipfee()>0) 
							{
							%>
							   <a href="http://www.d1.com.cn/help/help.asp?code=0402" target="_blank"><font color="#f00">本商品属于超重商品，运费另计</font></a><br/>
							<% }%>
							<!-- 是否送e券 -->
							<% if(p.getGdsmst_eyuan()>0)
								{
						    %>
						        <font color="red">（送<%=p.getGdsmst_eyuan() %></>元e券）</font><br/>
							<% 	
								}
								
						    %>
						    <!-- 显示限量购买商品 -->
							<% if(p.getGdsmst_buylimit()>0)
								{
						    %>
						        <font color="red">（本商品为限量商品，每个订单限购<%= p.getGdsmst_buylimit() %>件）</font>	<br/>
							<% 	
								}
								
						    %>
						    <!-- 是否显示特价语 -->
						    <%
						    Date d=new Date();
						    if(p.getGdsmst_discountenddate().after(d) && p.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+Tools.DAY_MILLIS*30))&& p.getGdsmst_memberprice()!=p.getGdsmst_oldmemberprice()&&p.getGdsmst_oldmemberprice()!=0)
						    {%>
						    	<font color="#ff0000"  style="font-size:10pt">
	                            <strike>原会员价: <font style="font-size:10.5pt"><b><%=p.getGdsmst_oldmemberprice() %></b></font>元</strike>
	                            <br>限量特价，欲购从速，售空为止
	                        </font><br/>
	                        <%
						    }
						    %>
							
		 					
								市场价：<%= p.getGdsmst_saleprice() %>元<br/>
								会员价：<font color="#0054a6"><%= p.getGdsmst_memberprice() %>元</font><br/>
								购买数量：<input type="text" value="1" style="width:50px;" id="<%=p.getId() %>_num"  onblur="checknum(this)" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
							</div>

   						</div>
   						</div>
   						<hr style=" height:10px; background-color:#fff; width:978px;  border:solid 1px #fff; +border:solid 10px #fff; +height:auto; _border:solid 10px #fff; _height:auto;" />
	    			   
	    			   <%}
	    			   
	    			   else
	    			   {
	    				   %>
	    				   <div style=" width:204px; overflow:hidden; float:left; margin-right:54px;">
	     					<div style="text-align:center; width:202px; border:solid 1px #ccc; overflow:hidden; font-size:13px; ">
	   
	     					<input type="checkbox"  name="gdsid" value="<%= gdsid %>"/><font color="#ff0000"><b>选择此商品</b></font><br/>
		 					<a href="http://www.d1.com.cn/product/<%= gdsid %>" target="_blank">
		 					<img src="http://images.d1.com.cn<%= imgurl %>" width="200" height="200"/></a><br/>
		 					</div>
		                     
							<div class="content">
							<a href="/product/<%= gdsid %>" target="_blank">【<%= Tools.getFloat(p.getGdsmst_memberprice()/p.getGdsmst_saleprice()*10, 1)  %>折】<%= pp.getSpgdsrcm_gdsname() %> </a>
							<br/>
							<!-- 是否添加运费 -->
							<% if(p.getGdsmst_addshipfee()>0) 
							{
							%>
							   <a href="http://www.d1.com.cn/help/help.asp?code=0402" target="_blank"><font color="#f00">本商品属于超重商品，运费另计</font></a><br/>
							<% }%>
							<!-- 是否送e券 -->
							<% if(p.getGdsmst_eyuan()>0)
								{
						    %>
						        <font color="red">（送<%=p.getGdsmst_eyuan() %></>元e券）</font><br/>
							<% 	
								}
								
						    %>
						    <!-- 显示限量购买商品 -->
							<% if(p.getGdsmst_buylimit()>0)
								{
						    %>
						        <font color="red">（本商品为限量商品，每个订单限购<%= p.getGdsmst_buylimit() %>件）</font>	<br/>
							<% 	
								}
								
						    %>
						    <!-- 是否显示特价语 -->
						    <%
						    Date d=new Date();
						    if(p.getGdsmst_discountenddate().after(d) && p.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+Tools.DAY_MILLIS*30))&& p.getGdsmst_memberprice()!=p.getGdsmst_oldmemberprice()&&p.getGdsmst_oldmemberprice()!=0)
						    {%>
						    	<font color="#ff0000"  style="font-size:10pt">
	                            <strike>原会员价: <font style="font-size:10.5pt"><b><%=p.getGdsmst_oldmemberprice() %></b></font>元</strike>
	                            <br>限量特价，欲购从速，售空为止
	                        </font><br/>
	                        <%
						    }
						    %>
							
		 					
								市场价：<%= p.getGdsmst_saleprice() %>元<br/>
								会员价：<font color="#0054a6"><%= Tools.getFormatMoney(p.getGdsmst_memberprice()) %>元</font><br/>
							购买数量：<input type="text" value="1" id="<%=p.getId() %>_num" style="width:50px;" onblur="checknum(this)" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
							</div>

   						</div>
					   <%
	    				   
	    			   }
	    			   
	    		   }
	    	   }
	    		
	       }
	   %></div>
	   <input type="hidden" id="hdnMaxCount" value="<%=maxcount %>"></input>
	   </div>
	   <div style="text-align:center;margin-top:10px;">
            <input type="submit" name="btnAddToCart" value="选好了，放入购物车" onclick="CheckForm(this);" code="<%=code %>" id="btnAddToCart" style="color:#ff0000;font-size:10.5pt;font-weight:bold" />
        </div>
	 </div>
	
	
	<div class="clear"></div>
	<!--尾部-->
	<%@include file="../inc/foot.jsp" %>
	<!-- 尾部结束-->
</body>
</html>