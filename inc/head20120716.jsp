<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head20120717.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
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
%>
<%
String chePingAn = Tools.getCookie(request,"PINGAN");

%>
<div id="Header">
<div  style="background:url('http://images.d1.com.cn/images2012/index2012/hbg.jpg'); height:35px; line-height:35px; ">
<table width="980" class="title2012">
<tr><td align="left" width="263"><span class="ShowWelcome" id="ShowWelcome">&nbsp;</span></td><td width="17"></td>
<td width="290" ><a href="http://www.d1.com.cn/user/" target="_blank" onmouseover="displayfzh()" onmouseout="outfzh()">我的帐户&nbsp;<img src="http://images.d1.com.cn/images2012/index2012/dsj.jpg"/></a>&nbsp;&nbsp;&nbsp;&nbsp;<div class="floatzh" id="floatzh" onmouseover="displayfzh()" onmouseout="outfzh()"><ul><li><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank">我的订单</li><li><a href="http://www.d1.com.cn/user/ticket.jsp" target="_blank">我的优惠券</li><li><a href="http://www.d1.com.cn/user/points.jsp" target="_blank">我的积分</li><li><a href="http://www.d1.com.cn/user/favorite.jsp" target="_blank">我的收藏</li><li><a href="http://www.d1.com.cn/user/consult.jsp" target="_blank">我的咨询</li><li><a href="http://www.d1.com.cn/user/comment.jsp" target="_blank">我的评论</li></ul></div><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank">订单查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
 <%if (Tools.isNull(chePingAn)) {%><a href="http://www.d1.com.cn/jifen/index.jsp" target="_blank">积分换购</a>&nbsp;&nbsp;&nbsp;&nbsp; <%} %><a href="http://help.d1.com.cn" target="_blank">帮助中心</a>&nbsp;&nbsp;</td>
<td><span class="buy_list" id="headerbuy_list"><img src="http://images.d1.com.cn/images2012/index2012/cartnew.png" style="vertical-align:text-bottom;"/>&nbsp;&nbsp;<a href="http://www.d1.com.cn/flow.jsp" target="_blank">购物车<em id="headcardnum">0</em>件商品</a>&nbsp;<img src="http://images.d1.com.cn/images2012/index2012/dsj.jpg" style="vertical-align:middle;"/>
</span><div class="cart" id="Headcart">正在加载购物车...<img src="/res/images/Loading.gif" alt="Loading" /></div></td>
<td width="300" style="text-align:right;"><img src="http://images.d1.com.cn/images2012/index2012/tele2.jpg" style="vertical-align:middle; margin-top:-2px;"/><font style="font-family:'微软雅黑'; font-size:14px; font-weight:bold;">400-680-8666</font>&nbsp;&nbsp;（9:00-21:00免长途费）</td>
</tr></table></div> 
<div class="head"><table height="100" width="100%" style="over-flow:hidden;">
<tr><td width="240"><h1><a href="http://www.d1.com.cn" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/headlogo.jpg"/></a></h1></td>
<td> <span class="search_layout"><div id="ffb9">
<table ><tr><td><input id="ffb9_input"  type="text" value="请输入您要搜索的商品名称或编码"/></td><td><a href="###" onclick="searchbut()"><img src="http://images.d1.com.cn/images2012/index2012/hsearchbtn.gif" width="52" height="26" class="searchtxt"/></a></td></tr>
<tr><td height="25" colspan="2"><span class="hot_search">热门搜索：|&nbsp;<%=getHeadPromotionMemu("2715",4,true,"&nbsp;|&nbsp;") %></span></td></tr>
</table>  </span></td>
<td style="text-align:right;"><table style="float:right"> <tr><td height="15"></td></tr>
 <tr><td  height="45" style="text-align:bottom;" ><a href="http://feelmind.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/ffeelmind.gif" width="129" height="45"/></a>
<a href="http://aleeishe.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/haleeishe.gif" width="88" height="45"/></a> <a href="http://sheromo.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/hsrm.gif" width="80" height="45"/></a>
<a href="http://yousoo.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/f_yousoo.gif" width="33" height="45"/></a>
</td></tr><tr><td style="text-align:center;color:#d1d1d1">D1优尚网旗下品牌</td></tr> </table> </td></tr>
<tr><td colspan="3" height="10"></td></tr> </table></div>
<script type="text/javascript" src="/inc/head1207.jsp"></script>
<span style="display:block; float:left; font-size:18px; padding-left:5px; _padding-left:5px;"><a href="http://www.d1.com.cn" style="color:#efd1d1; font-family:微软雅黑; font-size:18px;">首页</a></span>
<span style="display:block; float:left; font-size:18px; color:#b77a79; font-family:微软雅黑; padding-left:20px; _padding-left:15px;_padding-top:8px;"><a href="http://www.d1.com.cn/html/women" target="_blank" style="color:#b77a79;" id="women">女人&nbsp;<img src="http://images.d1.com.cn/images2012/index2012/JULY/jt.png" style="vertical-align:middle;"/></a></span>
<%
    List<Promotion> listh1=PromotionHelper.getBrandListByCode("3198", 10);
    if(listh1!=null&&listh1.size()>0)
    {%>
    <ul class="nav" id="head_nav2" >
    <%	for(Promotion p:listh1)
    	{
    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
    		{
    			if(p.getSplmst_name().length()>2&&!p.getSplmst_name().equals("POLO"))
    			{
    				out.print("<li  style=\"width:47px;\">");
    				out.print("<a href=\""+p.getSplmst_url()+"\" style=\"width:45px;\">"+p.getSplmst_name()+"</a>");
    			}
    			else
    			{
    				out.print("<li>");
    				out.print("<a href=\""+p.getSplmst_url()+"\" >"+p.getSplmst_name()+"</a>");
    			}
    			out.print("</li>");
    		}
    	}
    %>
    </ul>
   <% }
%>

<span style="float:left; font-size:15px; color:#b77a79; padding-left:20px;">|</span>
<span style=" float:left; font-size:18px; color:#b77a79; font-family:微软雅黑; padding-left:25px; _padding-left:25px; _padding-top:8px;"><a href="http://www.d1.com.cn/html/men" target="_blank" style="color:#b77a79;" id="men">男人&nbsp;<img src="http://images.d1.com.cn/images2012/index2012/JULY/jt.png" style="vertical-align:middle;"/></a></span>
<%
    List<Promotion> listh2=PromotionHelper.getBrandListByCode("3199", 7);
    if(listh2!=null&&listh2.size()>0)
    {%>
    <ul class="nav" id="head_nav1" >
    <%	for(Promotion p:listh2)
    	{
    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
    		{
    			if(p.getSplmst_name().length()>2&&!p.getSplmst_name().equals("POLO"))
    			{
    				out.print("<li  style=\"width:47px;\">");
    			}
    			else
    			{
    				out.print("<li>");
    			}
    			out.print("<a href=\""+p.getSplmst_url()+"\" >"+p.getSplmst_name()+"</a>");
    			out.print("</li>");
    		}
    	}
    %>
    </ul>
   <% }
%>
<div class="bk"><a href="http://www.d1.com.cn/html/zt2012/0214week/" target="_blank">爆款</a></div>
</div> </div></div><div style="clear:both;"></div>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head2012.js")%>"></script>
<script>
var step=url_file;
$(document).ready(function() {
	 $("#head_nav2").find("li").each(function(i) {
		 var flag = $(this).attr('pg');
			if(step == flag){

				$(this).addClass('current_page_item');

			}         

			$(this).hover(function(){

				$(this).addClass("hover");
			},function(){
				$(this).removeClass("hover");
			});
	 });
	});
   function allover()
   {
	   if($("#white").css('display')=='none'||$("#smenu").css('display')=='none')
   	   {
		   $("#white").css("display","block");
		   $("#smenu").css("display","block");
   	   
   	   }
   	 
   }
   function allout()
   {
   	
	   if($("#white").css('display')=='block'||$("#smenu").css('display')=='block')
   	   {
		   $("#white").css("display","none");
		   $("#smenu").css("display","none");
   	   
   	   } 
   }
  
 
</script>

