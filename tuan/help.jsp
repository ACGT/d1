<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>D1-优尚网，优尚团----帮助中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/tuannew.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>
<body>
   <div id="wrapper">
	<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
	<!-- 中间内容 -->
	<div class="center">
       <div  style=" width:698px; border:solid 1px #c2c2c2; float:left;">
         <table style="font-size:13px; color:#300a0a; line-height:28px;" width="680">
             <tr><td colspan="2" height="25"></td></tr>
            <tr>            
            <td width="35"></td>
            <td><span style=" font-size:15px; color:#b54e5f;"><b>常见问题</b></span></td>
            </tr>
            <tr><td colspan="2" height="10"></td></tr>
            <tr><td width="35"></td><td ><b>1、 一个人可以订购几件团购商品？</b></td></tr>
            <tr><td width="35"></td><td> 回复：一个人每次的团购有数量限制，具体请以当日团购说明为准 </td></tr>
            
             <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>2、 已经团商品了，但是还想订购D1优尚网其他商品，可以吗？</b></td></tr>
            <tr><td width="35"></td><td>回复：当然可以！团购商品放入购物车后，购物车页面会有提示，您可以根据页面提示选择进入结算中心或是继续订购D1优尚其他商品  </td></tr>
          
            <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>3、 团购商品怎么算运费呢？</b></td></tr>
            <tr><td width="35"></td><td>回复：团购商品在线支付满59元免运费，否则需要支付10元运费。</td></tr>
          
            
            <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>4、 团购商品可以使用E券吗？</b></td></tr>
            <tr><td width="35"></td><td>回复：团购商品不能使用E券   </td></tr>
          
            <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>5、团购商品什么时候发货？</b></td></tr>
            <tr><td width="35"></td><td>回复：团购商品在支付成功后一个工作日内发出（如果您同时订购了其他商品，发货时间取决于其他商品的发货时间） </td></tr>
          
            <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>6、查看团宝贝儿</b></td></tr>
            <tr><td width="35"></td><td>回复：每隔3天，优尚团会为您准备超值的时尚精品，化妆品、香水、饰品、手表等等，无所不及，而且保证是 100%正品哦！（根据具体情况）  </td></tr>
          
          
            <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>7、如何购买团宝贝儿</b></td></tr>
            <tr><td width="35"></td><td>回复：所有的团购都是限时限量的，过期不候。所以看到喜欢的团购，就赶快出手吧！只要点击购买按钮，按照提示步骤进行就OK！ （温馨提示：团购是有时间限制的，请注意结束时间，不要犹豫太久，错过了可就没有了。有的宝贝是有数量限制的，先抢先得，所以记得要先下手为强啊！） </td></tr>
          
          
            <tr><td colspan="2" height="25"></td></tr>
            <tr><td width="35"></td><td ><b>8、如何支付？</b></td></tr>
            <tr><td width="35"></td><td>回复：您可以选择支付宝、财付通、招行网银、工行网银、农行网银、建行网银、YeePay网上支付等在线支付方式；也可以选择货到付款方式。</td></tr>
          
            <tr><td colspan="2" height="25"></td></tr>
             <tr><td width="35"></td><td>其他问题请咨询客服： 400-680-8666  </td></tr>
          
            <tr><td colspan="2" height="50"></td></tr>
         </table>
           
           
	   </div>
    <div class="right">
	     
	     <% 
	        ArrayList<ProductGroup> lists=null;
	       lists=ProductGroupHelper.getTodayOtherProductGroups();
	        if(lists!=null&&lists.size()>1)
	        {%>
	        <div style="border:solid 1px #c2c2c2; text-align:center; padding-bottom:10px; margin-bottom:10px;">
	           <div style="width:256px; height:30px; background-color:#ebebeb; margin-bottom:10px;line-height:30px; color:#892d46; font-size:15px; font-weight:bold; text-align:left;">
			    &nbsp;&nbsp;其他团购
			  </div>
	        <%
	           for(int i=0;i<lists.size();i++)
	           {
	        	 ProductGroup product=lists.get(i);
	  			 
	  			 String sprice=ProductGroupHelper.getRoundPrice(product.getTgrpmst_sprice().floatValue());
	  			
	        %>
	        <div style="text-align:center; margin:0px auto; width:236px; padding-top:10px; margin-bottom:10px; border:solid 1px #c2c2c2;">
		    <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank" style=" z-index:111"><img src="<%= product.getTgrpmst_oldpic() %>" width="236" height="236"/></a>
			<table width="236">
			   <tr><td height="55">
			    <a href="tuandetail.jsp?ID=<%= product.getId() %>" target="_blank" style="position:absolute; margin-left:-5px; +margin-left:-123px; _margin-left:-123px;margin-top:-35px; z-index:9999 "><img src="http://images.d1.com.cn/Index/look.gif" /><span style="font-size:30px; color:#fff; font-family:'微软雅黑'; position:absolute; margin-left:-230px; margin-top:10px; margin-left:-230px;font-weight:normal;">￥<%= sprice %></span></a>
			
			   </td></tr>
			</table>
			
		   </div>
	        	
	        <%
	           }
	        %>
	        </div>
	        <%
	        }

	       
	     %>
	     
	     
	  
	 
	    <div id="ques" style="border:solid 1px #c2c2c2; margin-bottom:15px; padding-bottom:15px;">
		    <div class="ques_title" style="width:256px; height:30px; background-color:#ebebeb; line-height:30px; color:#892d46; font-size:15px; font-weight:bold;">
			    &nbsp;&nbsp;常见问题解答
			</div>
			<br/>
			<a href="help.jsp" target='_blank'>&nbsp;&nbsp;&nbsp;&nbsp;<b>查看全部</b></a>
           
			 <ul>
			     <li style="border-bottom:dashed 1px #ccc; width:210px; height:18px; padding-top:5px;"><a href="help.jsp" target="_blank" style=" color:#04569f; font-size:12px; cursor:hand;"><font color="#000">&nbsp;&nbsp;1.</font>团购商品什么时候发货？</a></li>
				 <li style="border-bottom:dashed 1px #ccc; width:210px; height:18px; padding-top:5px;"><a href="help.jsp" target="_blank" style=" color:#04569f; font-size:12px; cursor:hand;"><font color="#000">&nbsp;&nbsp;2.</font>团购商品怎么算运费呢？</a></li>
				 <li style="border-bottom:dashed 1px #ccc; width:210px; height:18px; padding-top:5px;"><a href="help.jsp" target="_blank" style=" color:#04569f; font-size:12px; cursor:hand;"><font color="#000">&nbsp;&nbsp;3.</font>团购商品可以使用E券吗？</a></li>
			 </ul>
		</div>
		
		<div id="work" style="border:solid 1px #c2c2c2; padding-bottom:15px;">
		    <div class="ques_title" style="width:256px; height:30px; background-color:#ebebeb; line-height:30px; color:#892d46; font-size:15px; font-weight:bold;">
			    &nbsp;&nbsp;商务合作
			</div>
			<table><tr><td height="5"></td></tr></table>
			&nbsp;&nbsp;希望在优尚团组织团购？
			<br/>
			&nbsp;&nbsp;请提交团购信息（要确保价格优势和库存量）<br/>
			&nbsp;&nbsp;<font style=" text-decoration:underline;">ycli@staff.d1.com.cn</font>
			<br/>
			&nbsp;&nbsp;邮件标题是：团购商品提供
		</div>
	 </div>

  </div>
	
	<!-- 中间内容结束 -->
	<div class="clear"></div>
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
   </div>

</body>
</html>