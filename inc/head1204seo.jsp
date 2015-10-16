<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head1208.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<%!
private static Map<String,String> HEAD_PROMOTION_MAP_1999 = Collections.synchronizedMap(new HashMap<String,String>());


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
			sb.append("<a href=").append(StringUtils.encodeUrl(url_7))
			.append(" title=").append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append(""+(isNewWindow?" target=_blank":"")+">")
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

//获取头部分类的文字推荐
private static String getHotKey(String code)
{
	if(code==null||code.length()==0||!Tools.isNumber(code))
	{
		return "";
	}
	StringBuilder sb = new StringBuilder();
	  List<Promotion> listh1=PromotionHelper.getBrandListByCode(code,30);
	  for(Promotion p:listh1)
	  {
	    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
	    		{
	    			sb.append("<span style=\"float:left; font-size:13px; color:#efd1d1; padding-left:25px;_padding-left:20px;padding-top:5px; _padding-top:8px;\">");
	    			sb.append("<a style=\"color:#ccc;\" href=\""+p.getSplmst_url()+"\" >"+p.getSplmst_name()+"</a></span>");
	    			
	    		}
    	}

  return sb.toString();
  
}

%>
<%
String chePingAn = Tools.getCookie(request,"PINGAN");
String flaghead="2";
if(session.getAttribute("flaghead")==null)
{

		String headip = request.getHeader("x-forwarded-for");
		if(headip == null || headip.length() == 0 || "unknown".equalsIgnoreCase(headip)) {
			headip = request.getHeader("Proxy-Client-IP");
		}
		if(headip == null || headip.length() == 0 || "unknown".equalsIgnoreCase(headip)) {
			headip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(headip == null || headip.length() == 0 || "unknown".equalsIgnoreCase(headip)) {
			headip = request.getRemoteAddr();
		}
		IPAreaManager ipsearch=IPAreaManager.getInstance();
		String pprovince=ipsearch.findIpArea2(headip);
		//获取区域

		if(!Tools.isNull(pprovince)&&("广东广西海南").indexOf(pprovince)>=0)
		{
			flaghead="1";	
		}
		else
		{
			flaghead="2";	
		}
		
	    session.setAttribute("flaghead", flaghead);
}
else
{
	   flaghead=session.getAttribute("flaghead").toString();
}
%>

<div id="Header">
<div  style="background:url('http://images.d1.com.cn/images2012/index2012/daohang_02.jpg'); height:35px; line-height:35px; ">
<table width="980" class="title2012">
<tr><td align="left" width="263"><span class="ShowWelcome" id="ShowWelcome">&nbsp;</span></td><td width="17"></td>
<td width="290" ><a href="http://www.d1.com.cn/user/" target="_blank" onmouseover="displayfzh()" onmouseout="outfzh()">我的帐户&nbsp;<img src="http://images.d1.com.cn/images2012/index2012/daohang.png"/></a>&nbsp;&nbsp;&nbsp;&nbsp;<div class="floatzh" id="floatzh" onmouseover="displayfzh()" onmouseout="outfzh()"><ul><li><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank">我的订单</li><li><a href="http://www.d1.com.cn/user/ticket.jsp" target="_blank">我的优惠券</li><li><a href="http://www.d1.com.cn/user/points.jsp" target="_blank">我的积分</li><li><a href="http://www.d1.com.cn/user/favorite.jsp" target="_blank">我的收藏</li><li><a href="http://www.d1.com.cn/user/myshoworder.jsp" target="_blank">我的晒单</li><li><a href="http://www.d1.com.cn/user/comment.jsp" target="_blank">我的评论</li></ul></div><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank">订单查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
 <%if (Tools.isNull(chePingAn)) {%><a href="http://www.d1.com.cn/jifen/index.jsp" target="_blank">积分换购</a>&nbsp;&nbsp;&nbsp;&nbsp; <%} %><a href="http://help.d1.com.cn" target="_blank">帮助中心</a>&nbsp;&nbsp;</td>
<td><span class="buy_list" id="headerbuy_list"><img src="http://images.d1.com.cn/images2012/index2012/cartnew.png" style="vertical-align:text-bottom;"/>&nbsp;&nbsp;<a href="http://www.d1.com.cn/flow.jsp" target="_blank">购物车<em id="headcardnum">0</em>件商品</a>&nbsp;<img src="http://images.d1.com.cn/images2012/index2012/daohang.png" style="vertical-align:middle;"/>
</span><div class="cart" id="Headcart">正在加载购物车...<img src="/res/images/Loading.gif" alt="Loading" /></div></td>
<td width="300" style="text-align:right;"><img src="http://images.d1.com.cn/images2012/index2012/dinahua.png" style="vertical-align:middle; margin-top:-2px;"/><font style="font-family:'微软雅黑'; font-size:14px; font-weight:bold;">400-680-8666</font>&nbsp;&nbsp;（9:00-21:00免长途费）</td>
</tr></table></div> 
<div class="head"><table height="99" width="100%" style="over-flow:hidden;">
<tr><td width="240"><h1><a href="http://www.d1.com.cn" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/daohang_13.jpg"/></a></h1></td>
<td> <span class="search_layout"><div id="ffb9">
<table ><tr><td><input id="ffb9_input"  type="text" value="请输入您要搜索的商品名称或编码"/></td><td><a href="###" onclick="searchbut()">
<div style=" width:52px; height:26px;">&nbsp;</div>
</a></td></tr>
<tr><td height="25" colspan="2"><span class="hot_search">热门搜索：|&nbsp;
<%  if(flaghead.equals("1"))
	{%>
	   <%=getHeadPromotionMemu("3271",4,true,"&nbsp;|&nbsp;") %>
	<%}
	else{%>
       <%=getHeadPromotionMemu("2175",4,true,"&nbsp;|&nbsp;") %>
	<%}%>
</span></td></tr>
</table>  </span></td>
<td style="text-align:right;"><table style="float:right"> 
 <tr><td  height="99" style="text-align:bottom;" >
 <%
    List<Promotion> pplist2012=PromotionHelper.getBrandListByCode("3249", 4);
    if(pplist2012!=null&&pplist2012.size()>0){
    	for(Promotion p:pplist2012){
    		if(p!=null&&p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0){
    			%>
    	      <a href="<%= p.getSplmst_url() %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" width="87" height="99"/></a>
    	<%	}
    	}
    }
 %>
 </td></tr></table> </td></tr>
</table></div>

<div id="menu">
<div style="width:980px; margin:0px auto;">
<%
 
    //获取一级菜单
    ArrayList<Promotion> plisthead=new ArrayList<Promotion>();
plisthead=PromotionHelper.getBrandListByCodeAndArea("3257",flaghead,10);
    if(plisthead!=null&&plisthead.size()>0){
      
 
%>
<span id="sindex" class="spanout" ><a href="http://www.d1.com.cn" target="_blank" >首页</a></span>
<span id="sman" class="spanout" >
<%
    if(plisthead.get(0)!=null){
 
%>
<a href="<%= plisthead.get(0).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(0).getSplmst_name()) %></a>
<%} %>
</span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="swoman" class="spanout" ><%
    if(plisthead.get(1)!=null){
%>
<a href="<%= plisthead.get(1).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(1).getSplmst_name()) %></a>
<%} %></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="squnzi" class="spanout" ><%
    if(plisthead.get(2)!=null){
%>
<a href="<%= plisthead.get(2).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(2).getSplmst_name()) %></a>
<%} %></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="skuzi" class="spanout" ><%
    if(plisthead.get(3)!=null){
%>
<a href="<%= plisthead.get(3).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(3).getSplmst_name()) %></a>
<%} %></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="shzp" class="spanout" ><%
    if(plisthead.get(4)!=null){
%>
<a href="<%= plisthead.get(4).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(4).getSplmst_name()) %></a>
<%} %></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="ssp" class="spanout" ><%
    if(plisthead.get(5)!=null){
%>
<a href="<%= plisthead.get(5).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(5).getSplmst_name()) %></a>
<%} %></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="sbag" class="spanout" ><%
    if(plisthead.get(6)!=null){
%>
<a href="<%= plisthead.get(6).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(6).getSplmst_name()) %></a>
<%} %></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="sshoes" class="spanout" >
<%
    if(plisthead.get(7)!=null){
%>
<a href="<%= plisthead.get(7).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(7).getSplmst_name()) %></a>
<%} %></span>

<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="swatch" class="spanout" ><%
    if(plisthead.get(8)!=null){
%>
<a href="<%= plisthead.get(8).getSplmst_url().trim() %>" target="_blank" ><%= Tools.clearHTML(plisthead.get(8).getSplmst_name()) %></a>
<%} %></span>
<%} %>
<div style="float:left; padding-left:48px; _padding-left:26px;">&nbsp;</div>
<span id="sdp" class="spanout" ><a href="http://www.d1.com.cn/gdscene/all.jsp" target="_blank" >搭配</a></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="snewp" class="spanout" ><a href="http://www.d1.com.cn/html/news/" target="_blank" >新品</a></span>
<div style="display:block; float:left; font-size:16px; color:#A63738; font-family:微软雅黑; _padding-top:2px;">|</div>
<span id="shot" class="spanout" ><a href="http://www.d1.com.cn/html/zt2012/0214week/" target="_blank">爆款</a></span>
</div>
</div>

</div>

<div class="clear"></div>


