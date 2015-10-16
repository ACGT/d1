<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
    int w=980;
	if(request.getParameter("w")!=null&&request.getParameter("w").toString().length()>0)
	{
	   w=Tools.parseInt(request.getParameter("w").toString());
	}	
	
%>
        <div style="<% if(w>=1200) out.print(" width:1200px;"); else out.print(" width:980px;"); %> min-width:980px;margin:0px auto;">
		<span style="<% if(w>=1200) out.print(" width:223px;"); else out.print(" width:223px;"); %>  ">
		<a href="javascript:void(0)" id="head_allfl"  style=" width:223px; text-align:left; padding:2px 0px 2px 0px;_display:block;_padding:10px 0px 10px 0px;_margin:3px; background:#4a4a4a;">
		&nbsp;&nbsp;全部商品分类&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<img src="http://images.d1.com.cn/images2013/newindex/jt.png"  border="0" style=" vertical-align:middle;"/></a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://www.d1.com.cn/" target="_blank" >首页</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://www.d1.com.cn/html/women/" target="_blank" attr="html/women/index">女装</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://www.d1.com.cn/html/men/" attr="html/men/index" target="_blank">男装</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://cosmetic.d1.com.cn/" attr="/html/cosmetic/index" target="_blank">化妆品</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015" attr="ny" target="_blank">内衣</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://www.d1.com.cn/result.jsp?productsort=021,031" attr="xp" target="_blank">鞋</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;"); %>" href="http://www.d1.com.cn/result.jsp?productsort=040,015002,015009" attr="ps" target="_blank">配饰</a></span>
		<span><a style="<% if(w>=1200) out.print("padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;"); else out.print("padding:2px 12px 2px 12px;_padding:8px 13px 10px 1px;"); %>" href="http://www.d1.com.cn/result.jsp?productsort=050" attr="xb" target="_blank">箱包</a></span>
		<span style="<% if(w>=1200) out.print("width:179px;_width:180px;"); else out.print("width:127px;_width:120px;"); %>">&nbsp;</span>
		<span></span>
		<span style="z-index:3;"><a style="<% if(w>=1200) out.print("padding:2px 20px 2px 14px;_padding:8px 17px 10px 16px;"); else out.print("padding:2px 12px 2px 10px;_padding:8px 11px 10px 9px;"); %>" id="head_mlmj" href="javascript:void(0)"  attr="mlmj" style="_display:block;_margin:3px; _width:95px;background:#4a4a4a ">限时闪购&nbsp;
		<img src="http://images.d1.com.cn/images2013/newindex/jt.png"  border="0" style=" vertical-align:middle;"/></a></span>	
 <script>
 $('#head_allfl').parent().hover(function(e){
	 $('#allfl').css('display','block');
	 
 }, function(e){
	 $('#allfl').css('display','none');
 });
 
 $('#head_mlmj').parent().hover(function(e){
	 $(this).addClass('current_page_item');
	 $("#mlmj").parent().css('display','block');
	 
 }, function(e){
	 $(this).removeClass('current_page_item');
	 $("#mlmj").parent().css('display','none');
 });
 $('#mlmj').parent().hover(function(e){
	 $('#head_mlmj').parent().addClass('current_page_item');
	 $("#mlmj").parent().css('display','block');
	 
 }, function(e){
	 $('#head_mlmj').parent().removeClass('current_page_item');
	 $("#mlmj").parent().css('display','none');
 });
 $('#mlmj').hover(function(e){
	 $('#head_mlmj').parent().addClass('current_page_item');
	 $("#mlmj").parent().css('display','block');
	 
 }, function(e){
	 $('#head_mlmj').parent().removeClass('current_page_item');
	 $("#mlmj").parent().css('display','none');
 });
 </script>
	