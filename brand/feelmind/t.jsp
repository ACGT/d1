<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private static Map<String,String> HEAD_PROMOTION_MAP_1999 = Collections.synchronizedMap(new HashMap<String,String>());
//头部菜单推荐位显示方法
public static String getHeadPromotionMemu(String pcode,int length,boolean isNewWindow){
	return getHeadPromotionMemu(pcode,length,isNewWindow,null);
}
//获得头部推荐位
public static String getHeadPromotionMemu(String pcode,int length,boolean isNewWindow,String split){
	if(HEAD_PROMOTION_MAP_1999.containsKey(pcode)){
		Long pcode_time = new Long(HEAD_PROMOTION_MAP_1999.get(pcode+"_time"));
		if(System.currentTimeMillis()-pcode_time.longValue()<=60*1000l){//缓存时间小于60秒就走缓存
			return HEAD_PROMOTION_MAP_1999.get(pcode);
		}
	}
	java.util.List<com.d1.bean.Promotion> rack_head_1k = com.d1.helper.PromotionHelper.getBrandListByCode(pcode , length);
	StringBuffer sb = new StringBuffer();
	if(rack_head_1k!=null && !rack_head_1k.isEmpty()){
		int i = 0;
		int size = rack_head_1k.size();
		for(com.d1.bean.Promotion p_1384k:rack_head_1k){
			String url_7 = p_1384k.getSplmst_url();
			if(url_7!=null)url_7=url_7.replaceAll(" ", "+");
			sb.append("<a href=\"").append(StringUtils.encodeUrl(url_7))
			.append("\" title=\"").append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append("\""+(isNewWindow?" target=\"_blank\"":"")+">")
			.append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append("</a>");
			if(split != null && i<size-1) sb.append(split);
			i++;
		}
	}
	HEAD_PROMOTION_MAP_1999.put(pcode,sb.toString());
	HEAD_PROMOTION_MAP_1999.put(pcode+"_time",System.currentTimeMillis()+"");
	return sb.toString();
}
public static String getCookie(HttpServletRequest request , String name){
	if(request == null || name == null) return null;
	Cookie [] cookieArr = request.getCookies();
	if(cookieArr == null || cookieArr.length==0) return null;
    String s = null;
    for (int i=0;i<cookieArr.length;i++) {
    	Cookie c = cookieArr[i];
        if (name.equals(c.getName())) {
			s = c.getValue();
            break;
        }
    }
    return s;
}
%>
<%if ("mqwyjf1203q".equals(session.getAttribute("d1lianmengsubad"))){
	session.removeAttribute("d1lianmengsubad");
	response.sendRedirect("http://www.d1.com.cn/zhuanti/20120328WangYi/index.jsp");
	return;
} 

//head
String chePingAn = Tools.getCookie(request,"PINGAN");

out.println("d1gjl:"+getCookie(request,"bfdad_sessionid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/index2012.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head2012.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2012h.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2012.css")%>" rel="stylesheet" type="text/css" media="screen" />

<title>FEEL MIND搭配</title>
<script type="text/javascript" language="javascript">
var step="index";
$(document).ready(function() {
	 $("#head_nav2").find("li").each(function(i) {
		 var flag = $(this).attr('pg');
			if(step == flag){
			if(i==7 || i==8){
				$(this).addClass('current_page_item2');
				}
				else
				{
				$(this).addClass('current_page_item');
				}
			}         
			   if(i==7 || i==8){
	 $(this).hover(function(){

				$(this).addClass("hover2");
			},function(){
				$(this).removeClass("hover2");
			});
			}
			else{
			$(this).hover(function(){

				$(this).addClass("hover");
			},function(){
				$(this).removeClass("hover");
			});
			}
	 });
	});
<%
 
  
	String keyWords_135 = request.getParameter("key_wds");
	String sk_23847 = request.getParameter("headsearchkey");
	//String chePingAn = Tools.getCookie(request,"PINGAN");
	if(!Tools.isNull(sk_23847)){//重新搜索了
		keyWords_135 = sk_23847 ;
	}else{
		if(keyWords_135!=null)keyWords_135=keyWords_135.replaceAll(" ", "+");
		keyWords_135 = Base64.decode(keyWords_135);//用base64编码传中文，免得出现乱码问题
	}
	if(!Tools.isNull(keyWords_135)){
	   	%>
	   	$(document).ready(function(){
	   		$('#ffb9_input').val("<%=Tools.repstr(keyWords_135)%>");
	   	});
	   	<%  
	}
	%>
</script>
</head>

<body>
   <!-- 头部 -->

      <div id="Header">
      <div  style="background:url('http://images.d1.com.cn/images2012/index2012/hbg.jpg'); height:35px; line-height:35px; ">
         <table width="980" class="title2012">
            <tr><td><span class="ShowWelcome" id="ShowWelcome">&nbsp;</span></td>
            <td width="355" style="text-align:right;"><a href="/user/" target="_blank">我的帐户</a>&nbsp;&nbsp;|&nbsp;&nbsp; <a href="/user/selforder.jsp" target="_blank">订单查询</a>
&nbsp;&nbsp;|&nbsp;&nbsp; <a href="/user/ticket.jsp" target="_blank">我的优惠券</a>&nbsp;&nbsp;|&nbsp;&nbsp; <%if (Tools.isNull(chePingAn)) {%><a href="/jifen/index.jsp" target="_blank">积分换购</a><%} %>
&nbsp;&nbsp;|&nbsp;&nbsp; <a href="/help" target="_blank">帮助中心</a>&nbsp;&nbsp;</td>
<td width="340" style="text-align:right;"><img src="http://images.d1.com.cn/images2012/index2012/tele2.jpg" style="vertical-align:middle; margin-top:-2px;"/><font style="font-family:'微软雅黑'; font-size:14px; font-weight:bold;">400-680-8666</font>&nbsp;&nbsp（9:00-21:00免长途费）</td>
         </tr>
         </table>
            
       </div> 
        <div class="head">
        <table height="100" width="100%" style="over-flow:hidden;"">
        
        <tr><td width="240"><h1><a href="/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/headlogo.jpg"/></a></h1></td>
          <td>	<span class="search_layout">
          <div id="ffb9">
	          <table >
	             <tr><td><input id="ffb9_input" type="text" value="请输入您要搜索的商品名称"/></td><td><a href="###" onclick="searchbut()"><img src="http://images.d1.com.cn/images2012/index2012/hsearchbtn.gif" width="52" height="26" style="margin-left:8px; margin-top:2px; _margin-top:0px; +margin-top:0px; margin-top:1px\0;"/></a></td></tr>
	              <tr><td height="25" colspan="2"><span class="hot_search">热门搜索：|<%=getHeadPromotionMemu("2715",4,true,"&nbsp;|&nbsp;") %></span></td></tr>
	          </table>
          </div>
          </span>
                </td>
                <td style="text-align:right;">
                <table style="float:right">
                <tr><td height="15"></td></tr>
                   <tr><td  height="45" style="text-align:bottom;" ><a href="http://www.d1.com.cn/brand/feelmind/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/ffeelmind.gif" width="129" height="45"/></a>
                   <a href="http://www.d1.com.cn/brand/aleeishe/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/haleeishe.gif" width=88" height="45"/></a> <a href="http://www.d1.com.cn/brand/sheromo/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/hsrm.gif" width="80" height="45"/></a>
                     <a href="http://www.d1.com.cn/html/brand/brand181.htm" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/f_yousoo.gif" width="33" height="45"/></a>
                </td></tr>
                <tr><td style="text-align:center;color:#d1d1d1">D1优尚网旗下品牌</td></tr>
                </table>
                  </td>
        </tr>
        <tr><td colspan="3" height="10"></td></tr>
         </table>
         
        </div>
        <!-- 导航 -->
          <div id="menu">
            <div class="wrapper">
            <div><img src="http://images.d1.com.cn/images2012/index2012/allcatbg.gif" style="position:absolute; margin-left:15px; margin-top:-7px;"/></div>
            <ul class="nav" id="head_nav2">
            <li pg="index"><a href="/">首页</a></li>
            <li pg="html/cloth/index"><a href="/html/cloth/">女装</a></li>
            <li pg="html/man/index"><a href="/html/man/">男装</a></li>
            <li pg="html/cosmetic/index" ><a href="/html/cosmetic/">化妆品</a></li>
            <li pg="html/shoebag/index"><a href="/html/shoebag/">女包</a></li>            
            <li pg="html/ornament/index"><a href="/html/ornament/">饰品</a></li>
            <li pg="html/watch/index" class="linno"><a href="/html/watch/">手表</a></li>
            <li pg="tuan/index" style="margin-left:16px;"><a href="/tuan/" target="_blank" >团购</a></li>
            <li pg="html/zt2012/0214week/index" class="linno"><a href="/html/zt2012/0214week/" target="_blank" >爆款</a></li>
            </ul>

            <span class="buy_list" id="headerbuy_list">
            <a href="/flow.jsp" target="_blank">购物车中有<em id="headcardnum"><%=CartHelper.getTotalProductCount(request,response)%></em>件商品</a>
            </span>
	            <div class="cart" id="Headcart">正在加载购物车...<img src=/res/images/Loading.gif alt="Loading" />
	            </div>
             </div>
          </div>
         <!-- 导航结束 -->
         <div style="clear:both;"></div>
      </div>

    <div style="clear:both;"></div>
   <!-- 头部结束 -->
<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	    <div class="fmenul">
	      <ul>
	        <li  class="lifestyle"><a href="index.jsp">首  页</a></li>
			<li><a href="man.jsp">男  装</a></li>
			<li><a href="woman.jsp">女  装</a></li>
			<li class="bgnone"><a href="lovels.jsp">情 侣 装</a></li>
          </ul>
        </div><div class="fmenur">
		    <ul>
	        <li><a href="scene.jsp">场景展示</a></li>
			<li class="bgnone"><a href="brand.jsp">品牌介绍</a></li>
          </ul>
		 </div>
		</div>
		 <div class="clear"></div>
     </div>
     <div class="fmanc">
     <%
     String sex=request.getParameter("sex");
     if(!Tools.isNull(request.getParameter("serid"))){
    	 String rackcode="";
    	 if(!Tools.isNull(sex)){
    		if("1".equals(sex)){
    			rackcode="03";
    		}else if("2".equals(sex)){
    			rackcode="02";
    		}
    	 }
    	 
    	 %> 
    	 	   <!--左侧开始-->
	   <div class="fmancl">
	       <div class="fclsmenu">
		     <ul class="one">
		     <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("987");
		     Gdsser g=GdsserHelper.getById(request.getParameter("serid"));
		if(g!=null){
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>" target="_blank"><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}
	else{%>
	 <li><a href="#">北美风南加州系列</a></li>
			   <li><a href="#">北美风南加州系列</a></li>
			   <li><a href="#">北美风南加州系列</a></li>
	<%} %>
		      <li>&nbsp;</li>   
	         </ul>
			<%
			request.setAttribute("brandname", "FEEL MIND");
			request.setAttribute("rackcode", "");
			%>
			<jsp:include   page= "category.jsp"   />
		   </div>
	   </div>
	   <!--左侧结束-->
	    <!--右侧开始-->
	   <div class="fmancr">
	     <div class="top" style="height:500px;">
	      <%
	    
	    if(g!=null) {
	    	%>
	    	 <img src="<%=g.getGdsser_timg().trim() %>" width="765" height="500"/>		
	    	<% }else{
	    		%>
	    	<img src="http://images.d1.com.cn/images2012/feelmind/images/003.jpg" width="765" height="500"/>		
	    	<%}
	     %>
         </div>
		<div class="fserlist">
		<%
		if(g!=null){
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=GdscollHelper.getGdscollBySerid(g.getId(),new Long(sex));
			if(scolllist!=null && scolllist.size()>0){
				isscoll=true;
				for(int i=0;i<scolllist.size();i++){
					Gdscoll scoll=scolllist.get(i);
					if((i+1)%3==1){
						%>
						 <div class="flistr">
           <ul>
					<%}%>
				<li style="line-height:30px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>" target="_blank"><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
				<%
				if((i+1)%3==0){
				%>
					</ul>
					</div>
					<%}
				}
			}
			if(!isscoll){
				%>
				<div class="flistr">
           <ul>
              <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
           </ul>
		   </div>
		   <div class="flistr">
           <ul>
              <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
           </ul>
		   </div>
			<%}
		}
		%>
		 </div>
	   </div>
	   <!--右侧结束-->
    <% }
     %>

	    <div class="clear"></div>
	 </div>
	 
  </div>
</div>
  <div class="clear"></div>
  <!--底部信息开始-->
<%@include file="foot.jsp" %>
  <!--底部信息结束-->
</body>
</html>
