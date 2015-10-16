<%@ page contentType="text/html; charset=UTF-8" import="com.d1.dbcache.core.BaseEntity,com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*,org.hibernate.criterion.Order,org.hibernate.criterion.Restrictions,org.hibernate.criterion.SimpleExpression"%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head201309.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
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

//获取推荐位
public static ArrayList<SplRck> GetSplRckList(String splcode)
{
	ArrayList<SplRck> list=new ArrayList<SplRck>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("splrck_rackcode", splcode));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.asc("splrck_seq"));
	List<BaseEntity> b_list = Tools.getManager(SplRck.class).getList(clist, olist, 0, 100);
	if(b_list!=null){
		for(BaseEntity be:b_list){
					list.add((SplRck)be);
	     }
	}
	return list;
}
//获得头部推荐位
public static String getMemu(String pcode,int length){
	java.util.List<com.d1.bean.Promotion> rack_head_1k = com.d1.helper.PromotionHelper.getBrandListByCode(pcode , length);
	StringBuffer sb = new StringBuffer();
	if(rack_head_1k!=null && !rack_head_1k.isEmpty()){
		int i = 0;
		int size = rack_head_1k.size();
		for(com.d1.bean.Promotion p:rack_head_1k){
			String url_7 = p.getSplmst_url();
			if(url_7!=null)url_7=url_7.replaceAll(" ", "+");
			if(i==0)
			{
				sb.append("<b><a href=\""+url_7+"\" target=\"_blank\">"+p.getSplmst_name()+"</a>&nbsp;&nbsp;></b>");				
			}
			else if(i%4==1)
			{
				sb.append(" <p><a href=\""+url_7+"\" target=\"_blank\">"+p.getSplmst_name()+"</a>");				
			}
			else if(i%4==0)
			{
				sb.append("<a href=\""+url_7+"\" target=\"_blank\">"+p.getSplmst_name()+"</a></p>");
			}
			else
			{
				sb.append("<a href=\""+url_7+"\" target=\"_blank\">"+p.getSplmst_name()+"</a>");
			}			
			i++;
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
	//String headip = request.getHeader("x-forwarded-for");
	//	if(headip == null || headip.length() == 0 || "unknown".equalsIgnoreCase(headip)) {
		//	headip = request.getHeader("Proxy-Client-IP");
	//	}
	//	if(headip == null || headip.length() == 0 || "unknown".equalsIgnoreCase(headip)) {
		//	headip = request.getHeader("WL-Proxy-Client-IP");
		//}
		//if(headip == null || headip.length() == 0 || "unknown".equalsIgnoreCase(headip)) {
		//	headip = request.getRemoteAddr();
		//}
		//IPAreaManager ipsearch=IPAreaManager.getInstance();
	//	String pprovince=ipsearch.findIpArea2(headip);
		//获取区域

		//if(!Tools.isNull(pprovince)&&("广东广西海南").indexOf(pprovince)>=0)
		//{
		//	flaghead="1";	
		//}
		//else
		//{
		//	flaghead="2";	
		//}
		//flaghead="2";	
	    session.setAttribute("flaghead", flaghead);
}
else
{
	   flaghead=session.getAttribute("flaghead").toString();
}
ArrayList<Promotion> head_plist=new ArrayList<Promotion>();
ArrayList<SplRck> head_splrcklist=new ArrayList<SplRck>();
//
%>
<!-- 头部 --> 
<script>
  var head_ws=window.screen.width;    
  if(head_ws>=1210){
  document.getElementsByTagName("body")[0].className="root2";
  }
</script>
<%@include file="/inc/notice.jsp" %>
<style>

.menuspana{padding:2px 23px 2px 17px;_padding:8px 20px 10px 18px;height:37px; line-height:37px}
.menuspana2{padding:2px 12px 2px 12px;_padding:8px 13px 10px 11px;height:37px; line-height:37px}

</style>
<div class="clear"></div>
	<div id="Header" style="height:172px;z-index:10001;margin:0px auto;">
      <div style="background:url('http://images.d1.com.cn/images2012/index2012/daohang_02.jpg'); height:35px; line-height:35px; ">
       <table class="title2012">
        <tr><td align="left" width="263">
		   <span class="ShowWelcome" id="ShowWelcome">你好，欢迎来到D1购物，请&nbsp;<a href="http://www.d1.com.cn/login.jsp" style="color:#8cc341" rel="nofollow"><b>登录</b></a>            &nbsp;或&nbsp;<a href="http://www.d1.com.cn/register.jsp" target="_blank" style="color:#8cc341"><b>注册</b></a>&nbsp;&nbsp;&nbsp;&nbsp;</span>
		     </td>
			 <td id="head_emptytd" ></td>
              <td width="372"><a href="http://www.d1.com.cn/user/" target="_blank" onmouseover="displayfzh()" onmouseout="outfzh()" rel="nofollow">我的帐户&nbsp;<img src="http://images.d1.com.cn/images2013/newindex/daohang.png"></a>&nbsp;&nbsp;&nbsp;&nbsp;
			 <div class="floatzh" id="floatzh" onmouseover="displayfzh()" onmouseout="outfzh()">
              <ul><li><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank" rel="nofollow">我的订单</a></li>
			     <li><a href="http://www.d1.com.cn/user/ticket.jsp" target="_blank" rel="nofollow">我的优惠券</a></li>
				 <li><a href="http://www.d1.com.cn/user/points.jsp" target="_blank" rel="nofollow">我的积分</a></li>
				 <li><a href="http://www.d1.com.cn/user/favorite.jsp" target="_blank" rel="nofollow">我的收藏</a></li>
				 <li><a href="http://www.d1.com.cn/user/myshoworder.jsp" target="_blank" rel="nofollow">我的晒单</a></li>
				 <li><a href="http://www.d1.com.cn/user/comment.jsp" target="_blank" rel="nofollow">我的评论</a></li>
		     </ul></div>
			 <a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank" rel="nofollow">订单查询</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <%if (Tools.isNull(chePingAn)) {%><a href="http://www.d1.com.cn/jifen/index.jsp" target="_blank">积分换购</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; <%} %>
			 <a href="http://help.d1.com.cn/" target="_blank">帮助中心</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 </td>
			 <td width="160">
			 <a href="#"  style="CURSOR: pointer" onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&sid=4006808666&eid=218808P8z8p8y8y8q8x8z&o=www.d1.com.cn&q=7&ref='+document.location, '_blank', 'height=544, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');" ><img src="http://images.d1.com.cn/images2013/index/online.png" style="vertical-align:middle;"/>&nbsp;在线客服</a>
&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.d1.com.cn/wap/m/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2013/index/wap.png" style="vertical-align:middle;"/>&nbsp;手机优尚</a>
			 </td>
         </tr>
         </table>
	  </div> 
      <div class="head" >
	  <table height="99" width="100%" style="over-flow:hidden;">
      <tr><td width="240"><h1><a href="http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2013/newindex/daohang_13.jpg"></a></h1></td>
      <td id="head_emptytd1" ><span class="search_layout">
         <div id="ffb9">
           <table>
                 <tr><td><input id="ffb9_input" type="text" value="请输入您要搜索的商品名称或编码" ></td>
		              <td><a href="javascript:void(0)" onclick="searchbut()">
                             <div style=" width:52px; height:26px;">&nbsp;</div>
                          </a>
					   </td>
				  </tr>
                  <tr><td height="25" colspan="2">
                  <span class="hot_search">热门搜索：|&nbsp;
                  <%  if(flaghead.equals("1"))
						{%>
						   <%=getHeadPromotionMemu("3271",10,true,"&nbsp;|&nbsp;") %>
						<%}
						else{%>
					       <%=getHeadPromotionMemu("2175",10,true,"&nbsp;|&nbsp;") %>
						<%}%>
				  </span>		
				  </td>
				  </tr>
                  </table> 
		 </div></span>
	 </td>
     <td style="text-align:right;">
	 <div style=" position:relative; width:100%;z-index:2001;">
	 <span class="buy_list" id="headerbuy_list">&nbsp;&nbsp;
	 <a href="http://www.d1.com.cn/flow.jsp" target="_blank">购物车<em id="headcardnum">0</em>件商品</a>&nbsp;
	 </span>
	 <div class="cart" id="Headcart">正在加载购物车...<img src="http://images.d1.com.cn/images2013/newindex/Loading.gif" alt="Loading"></div>
	 </div>
	 
	 </td>
	 </tr>
     </table>
    </div>
    
	<div id="menu">

<div class="w wrap"  id="menuw"  >
<div class="menud"><a href="javascript:void(0)" id="head_allfl">&nbsp;&nbsp;全部商品分类</a></div>
<div class="menu_nav">
<ul>
<li><a  href="http://www.d1.com.cn/" target="_blank">首页</a></li>
<li><a  href="http://www.d1.com.cn/html/women/" target="_blank" attr="html/women/index">女装</a></li>
		<li><a  href="http://www.d1.com.cn/html/men/" attr="html/men/index" target="_blank">男装</a></li>
		<li><a  href="http://cosmetic.d1.com.cn/" attr="/html/cosmetic/index" target="_blank">化妆品</a></li>
		<li><a  href="http://www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015" attr="ny" target="_blank">内衣</a></li>
		<li><a  href="http://www.d1.com.cn/result.jsp?productsort=021,031" attr="xp" target="_blank">鞋</a></li>
		<li><a  href="http://www.d1.com.cn/result.jsp?productsort=040,015002,015009" attr="ps" target="_blank">配饰</a></li>
		<li><a  href="http://www.d1.com.cn/result.jsp?productsort=050" attr="xb" target="_blank">箱包</a></li>
</ul>
</div>
<div class="menur" ><a id="head_mlmj" href="http://www.d1.com.cn/html/miaosha/"  attr="mlmj" >限时闪购&nbsp;&nbsp;&nbsp;<img src="http://images.d1.com.cn/images2013/newindex/jt.png" border="0" style=" vertical-align:middle;"></a></div>
</div>
</div>
		
	</div>
	<!--浮动层-->
	<div id="head_floatdiv" style="margin:0px auto;max-width:1200px;position:relative;z-index:10000;">
	<!--全部分类-->
	<div id="allfl" class="allfl"  >
	  <script type="text/javascript" src="/inc/head2014_menul.jsp"></script>
	</div>
	<!--全部分类结束-->
	<!--美丽秘籍-->
	<div style="display:block;background:#fff; width:181px; height:auto;position: absolute; right: 6px;top:-2px;padding:0px; border: solid 1px #CECECE;">
	<div id="mlmj" >
	
			<div id="mlmj_1" class="mlmj_div" style=" height:370px; overflow:hidden; display:block; ">
			<%
			    head_plist=PromotionHelper.getBrandListByCode("3639",-1);
			    if(head_plist!=null&&head_plist.size()>0)
			    {%>
			    	<ul>
			    	<%
			    	   for(Promotion p:head_plist)
			    	   {
			    		   if(p!=null)
			    		   {%>
			    			   <li>
			                  <a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>" target="_blank"><img src="<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  border="0" /></a>
			                   </li>
			    		   <%}
			    	   }
			    	%>
			    	</ul>
			    <%}
			
			%>
			
			</div>
			
					
			<br/>
		    <span id="dpstar" style="display:block; width:100%; height:25px; cursor:hand;" ></span>
		       </div>  
	</div>
	<!--美丽秘籍结束-->
	</div>
     <!-- 浮动层结束-->
	

   </div>
 <div class="clear"></div>
   <%
   String url_file = request.getServletPath();
   if(url_file != null && url_file.length()>0) url_file = url_file.substring(1).replace(".jsp",""); 
   %>
  <script>
    var  url_file='<%= url_file%>';
   </script>   
   <script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head201309.js")%>"></script>
   <script>
		
		var step=url_file;
		//Get_HeadMenu(head_ws);
		if(head_ws>1200){
			 $('#menuw').css('width','1200px');
			 $('#menublank').css('width','217px');
			 $('#menuw span a').attr("class","menuspana");
		    $('.title2012').css('width','1200px');
		    $('.head').css('width','1200px');
		    $('#head_emptytd').css('width','405px');
		    $('#head_emptytd1').css('width','800px');
		    $('#head_floatdiv').css('width','1200px');
		    $('#allfl').css('width','225px');
		    $('#allfl dd').css('left','210px');
		 }
		 else{
			 $('#menuw').css('width','980px');
			 $('#menublank').css('width','146px');
			 $('#menuw span a').attr("class","menuspana2");
			 $('.title2012').css('width','980px');
			 $('.head').css('width','980px');
			 $('#head_emptytd').css('width','185px');
			 $('#head_emptytd1').css('width','580px');
			 $('#head_floatdiv').css('width','980px');
			 $('#allfl').css('width','225px');
			 $('#allfl dd').css('left','210px');
		 }	
		
		function Get_HeadMenu(ws)
		{
			$.ajax({
				type: "get",
				dataType: "text",
				url: '/ajax/index/GetHeadMenu.jsp',
				cache: false,
				data: {w:ws},
				error: function(XmlHttpRequest,textStatus,erroeThrown){	
					
				},success: function(strRet){
					$('#menu').html(strRet);	
					$("#menu").find("div li").each(function(i) {
						 var flag = $(this).attr('attr');	
							if(step == flag){
								$(this).css('background','#4a4a4a');
							}    			
						   
					   });
					 
				},beforeSend: function(){
				},complete: function(){
				}
			});
			
		}

		 $(document).ready(function() {		
			 
			 var PageStyle= function () {
				 var SysWidht = $(window).width(),wrap=$('.wrap');//此处也可以使用jquery的$(window).width()获取页面宽度
				 if(SysWidht<1200) {
				 wrap.removeClass('wrapBig').addClass('wrapSmall');
				 }else {
				 wrap.removeClass('wrapSmall').addClass('wrapBig');
				 }
				 };
				 /*init*/
				 PageStyle();
				 /*event*/
				 $(window).resize(function () {
				 PageStyle();
				 });

			 $(".menu_nav").find("li a").each(function(i) {
				 var flag = $(this).attr('attr');	
					if(step == flag){
						$(this).css('background','#4a4a4a');
					}    			
				   
			   });
			 /*美丽秘籍*/
			    var autoTab;
			   var autoTab1;
			   $('#mlmj').mouseover(function(){
				clearInterval(autoTab);
				clearInterval(autoTab1);
			   }).mouseout(function(){
				clearInterval(autoTab);	
				clearInterval(autoTab1);
				if($('#mlmj_1 li').length>5){	
					autoTab = setInterval(function(){
						$('#mlmj_1 li:first').stop().slideUp(200,function(){starAnim = false;$('#mlmj_1 li:last').after($('#mlmj_1 li:first'));});
						$('#mlmj_1 li').eq(5).slideDown(200);		},5000);
					}
				/*if($('#mlmj_2 li').length>5){		
					autoTab1 = setInterval(function(){
						$('#mlmj_2 li:first').stop().slideUp(200,function(){starAnim = false;$('#mlmj_2 li:last').after($('#mlmj_2 li:first'));});
						$('#mlmj_2 li').eq(5).slideDown(200);			},5000);
					}*/
				
				}).trigger('mouseout');
				$('#dpstar').click(function(){
					if($('#mlmj_1').css('display')=='block'&&$('#mlmj_1 li').length>3)
					{
						$('#mlmj_1 li:first').stop().slideUp(200,function(){$('#mlmj_1 li:last').after($('#mlmj_1 li:first'));});
						$('#mlmj_1 li').eq(3).css('height','').slideDown(200);	
					}
					/*if($('#mlmj_2').css('display')=='block'&&$('#mlmj_2 li').length>5){
						$('#mlmj_2 li:first').stop().slideUp(200,function(){$('#mlmj_2 li:last').after($('#mlmj_2 li:first'));});
						$('#mlmj_2 li').eq(5).css('height','').slideDown(200);	
					}*/
				});
				
			   
		 });
		 
		
   
    </script>
   
   
   
   <!--头部结束-->

