<%@ page contentType="text/html; charset=UTF-8" %><%@include file="/inc/header.jsp"%>
<%!
//热门分类
private static String getHotAssort(String code){
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		sb.append("<ul>");
		for(Promotion recommend : recommendList){
			String title = recommend.getSplmst_name();
			sb.append("<li><a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" target=\"_blank\" title=\"").append(title).append("\">").append(title).append("</a>|</li>");
		}
		sb.append("</ul>");
	}
	return sb.toString();
}
%>
<%
//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
String par = request.getParameter("par");

String act=request.getParameter("act");
if("post".equals(request.getMethod().toLowerCase())&&"sss".equals(act))
{
	String keyword=request.getParameter("s4");
	if(keyword!=null&&keyword.length()>0)
	{
		response.sendRedirect("/search.jsp?headsearchkey="+URLEncoder.encode(keyword,"utf-8"));
	}
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-404</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
.center{ margin:0px auto;width:700px; padding-top:15px;}
   .notice{
           margin:0px auto;
			width: 490px;
			height: 40px;
			margin-bottom: 30px;
			padding-top: 12px;
			background: url(http://images.d1.com.cn/images2012/notice_404.gif) no-repeat left;
			text-align: right;
}
.blayout .hot_fl{ width:700px;  overflow:hidden;}

.flcontet{ height:340px; width:698px; _width:698px;border:solid 1px #dfdfdf; border-top:3px #a63b55 solid; }
.flcontent_sub {    border-bottom:dashed 1px #cfcfcf;  padding:11px; height:41px; _height:40px;}
.flcontent_sub ul{ padding:0px; margin:0px; width:680px; _width:670px;}
.flcontent_sub ul li{ line-height:20px;float:left; color:#9c9c9c} 
.flcontent_sub ul li a{ color:#000; margin-left:10px; margin-right:10px;}
.flcontent_sub ul li a:hover{ color:#aa2e44;  margin-left:10px; margin-right:10px;}
.flcontent_sub span a{ color:#aa2e44; font-weight:bold;}
.flcontent_sub span a:hover{ color:#aa2e44; font-weight:bold; text-decoration:underline;}


.flcontent_sub_1 { border-bottom:none; padding:11px; height:41px; _height:40px;}
.flcontent_sub_1 ul{ padding:0px; margin:0px; width:680px; _width:670px;}
.flcontent_sub_1 ul li{ line-height:20px;float:left; color:#9c9c9c} 
.flcontent_sub_1 ul li a{color:#000;  margin-left:10px; margin-right:10px;} 
.flcontent_sub_1 ul li a:hover{ color:#aa2e44;  margin-left:10px; margin-right:10px;}
.flcontent_sub_1 span a{ color:#aa2e44; font-weight:bold;}
.flcontent_sub_1 span a:hover{ color:#aa2e44; font-weight:bold; text-decoration:underline;}


.flmouseover {  border:solid 1px #a73c50; padding:10px; height:41px; _height:40px;}
.flmouseover ul{ padding:0px; margin:0px; width:680px; _width:670px;}
.flmouseover ul li{ line-height:20px;float:left; color:#9c9c9c;}
.flmouseover ul li a{color:#000;  margin-left:10px; margin-right:10px;} 
.flmouseover ul li a:hover{ color:#aa2e44;  margin-left:10px; margin-right:10px;}
.flmouseover span a{ color:#aa2e44; font-weight:bold;}
.flmouseover span a:hover{ color:#aa2e44; font-weight:bold; text-decoration:underline;}
.searchs {
        margin:0px auto;
		width: 490px;
		padding-top: 8px;
		height: 35px;
		background: url(http://images.d1.com.cn/images2012/404bg.gif) right;
		margin-bottom:30px;
}
.searchs span.text {
	width: 380px;
	height: 20px;
	float: left;
	padding: 6px 3px 0px 3px;
	margin: 0px 10px 0px 8px;
	background: white;
	border: 0px;
}
.searchs input.k {
	border: 0px;
	background: none;
	width: 380px;
}
.searchs input.s {
width: 70px;
height: 26px;
float: left;
background: url(http://images.d1.com.cn/images2012/s404.gif) no-repeat;
border: 0px;
text-indent: -100px;
}
</style>
</head>

<body >
   <!-- 头部 -->
   <%@include file="/inc/head.jsp" %>
   
   <!-- 头部结束 -->
<div class="center">
    <div class="notice">
        <a href="/index.jsp"><img src="http://images.d1.com.cn/images2012/return_index.gif" alt="返回首页"/></a>
    </div>
    
    <div class="searchs">
    <form id="sform" method="post" action="404.jsp?act=sss" onsubmit="return false;">
       <span class="text">
          <input type="text" id="s4" name="s4" value="请输入您要搜索的商品名称" class="k" onfocus="$('#s4').val('');"/>
       </span>
       <span>
       <input type="submit" class="s" value="" onclick="Check();"/>
       </span>
     </form>
    </div>
    
     <!-- 热门分类-->
          <div class="blayout hot_fl">
			   <div class="flcontet" id="flcontet">
			      <div class="flcontent_sub" style="height:60px;">
                     <span><a href="/html/cosmetic/" target="_blank">化妆品</a></span>
                     <div class="clear"></div>
                     <%=getHotAssort("2746") %>
				  </div>
				  <div class="flcontent_sub" id="Div1">
                     <span><a href="/html/cloth/" target="_blank">潮流女装</a></span>
                     <%=getHotAssort("2747") %>
				  </div>
				  <div class="flcontent_sub" id="Div2">
                     <span><a href="/html/man/" target="_blank">品质男装</a></span>
                     <%=getHotAssort("2748") %>
				  </div>
				  <div class="flcontent_sub" id="Div3">
                     <span><a href="/html/ornament/" target="_blank">精美饰品</a></span>
                     <%=getHotAssort("2749") %>
				  </div>
				  <div class="flcontent_sub_1">
                     <span><a href="/html/shoebag/" target="_blank">名品箱包</a></span>
                     <%=getHotAssort("2750") %>
				  </div>
			   </div>
		   </div>
		   <script type="text/javascript">
		   $(function(){
			  $('#flcontet > div').each(function(){
				  var className = $(this).attr('className');
				  $(this).hover(function(){
					  $(this).attr('className','flmouseover');
				  },function(){
					  $(this).attr('className',className);
				  });
			  }); 
		   });
		   </script>
		 

</div>
<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript">
   function Check()
   {
	   if($('#s4').val()=='')
		   {
		   $.alert('搜索内容不能为空！','提示');
		   return;
		   }
	   else
		   {
		   $('#sform').submit();
		   }
   }
</script>
