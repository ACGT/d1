<%@ page contentType="text/html; charset=UTF-8"  import="com.d1.dbcache.core.BaseEntity,com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*,org.hibernate.criterion.Order,org.hibernate.criterion.Restrictions,org.hibernate.criterion.SimpleExpression"%>
<%!
private static Map<String,String> HEAD_PROMOTION_MAP_1999 = Collections.synchronizedMap(new HashMap<String,String>());

//获得头部推荐位
public static String getHeadPromotionMemu(String pcode,int length,boolean isNewWindow,long showtype){
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
			if(showtype==1)sb.append("<li>");
			if(showtype==2)sb.append("<span>");
			sb.append("<a href=").append(StringUtils.encodeUrl(url_7))
			.append(" title=").append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append(""+(isNewWindow?" target=_blank":"")+">")
			.append(StringUtils.replaceHtml(p_1384k.getSplmst_name()))
			.append("</a>");
			if(showtype==1)sb.append("</li>");
			if(showtype==2)sb.append("</span>");
			i++;
		}
	}
	HEAD_PROMOTION_MAP_1999.put(pcode,sb.toString());
	HEAD_PROMOTION_MAP_1999.put(pcode+"_time",System.currentTimeMillis()+"");
	return sb.toString();
}

%>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2014new2.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
  <link rel="stylesheet" type="text/css" href="/res/css/jquery.flexbox.css" />
<script type="text/javascript" src="/res/js/jsSource/jquery.flexbox.js"></script>
  <script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head201309.js")%>"></script>
<style>
.ht_wid {width:1200px;}
</style>
<%
String chePingAn = Tools.getCookie(request,"PINGAN");
%>
<%@include file="/inc/notice.jsp" %>
<%
		if(session.getAttribute("headShow") !=null && session.getAttribute("jifenurl") !=null && !Tools.isNull(session.getAttribute("jifenurl").toString())  && !Tools.isNull(session.getAttribute("headShow").toString())){
			%>	
			<div class="mod_top_banner">
	<div class="main_area">
		<div class='sale_tip'><%=session.getAttribute("headShow").toString() %></div>
		<div class='login_status'>
			
			<a class='my_caibei' href="<%=session.getAttribute("jifenurl").toString()%>">我的彩贝积分</a>
		</div>
	</div>
</div>
		<%}
		%>
<div class="clear"></div>
<div class="header wrap">
	<div class="h_top">
     <div class="ht_wid wrap">
      <div class="ht_login f_l">
      <span class="ShowWelcome" id="ShowWelcome"> 您好，欢迎来到D1购物,请&nbsp;<a href="http://www.d1.com.cn/login.jsp">登陆</a>&nbsp;或&nbsp;<a href="http://www.d1.com.cn/register.jsp">注册</a></span>
      </div>
      <div class="ht_menu f_r">
         <ul>
            <li class="ht_menulil"><a href="http://www.d1.com.cn/user/" onmouseover="displayfzh()" onmouseout="outfzh()" rel="nofollow">我的帐户<b></b></a>
            <div class="floatzh" id="floatzh" onmouseover="displayfzh()" onmouseout="outfzh()">
              <ul><li><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank" rel="nofollow">我的订单</a></li>
			     <li><a href="http://www.d1.com.cn/user/ticket.jsp" target="_blank" rel="nofollow">我的优惠券</a></li>
				 <li><a href="http://www.d1.com.cn/user/points.jsp" target="_blank" rel="nofollow">我的积分</a></li>
				 <li><a href="http://www.d1.com.cn/user/favorite.jsp" target="_blank" rel="nofollow">我的收藏</a></li>
				 <li><a href="http://www.d1.com.cn/user/myshoworder.jsp" target="_blank" rel="nofollow">我的晒单</a></li>
				 <li><a href="http://www.d1.com.cn/user/comment.jsp" target="_blank" rel="nofollow">我的评论</a></li>
		     </ul></div>
            </li>
            <li class="ht_menulil"><a href="http://www.d1.com.cn/user/selforder.jsp" target="_blank" rel="nofollow">订单查询</a></li>
            <li class="ht_menulil"><%if (Tools.isNull(chePingAn)) {%><a href="http://www.d1.com.cn/jifen/index.jsp" target="_blank">积分换购</a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; <%} %></li>
            <li class="ht_menulil"><a href="http://help.d1.com.cn/" target="_blank">帮助中心</a></li>
            <li class="ht_menulir">
            	<a href="#"  style="CURSOR: pointer" onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&sid=4006808666&eid=218808P8z8p8y8y8q8x8z&o=www.d1.com.cn&q=7&ref='+document.location, '_blank', 'height=544, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');" >在线客服</a>
            </li>
            <li class="ht_menulir"><a href="http://www.d1.com.cn/wap/m/index.jsp" target="_blank">手机优尚</a></li>
            </li>
         </ul>
      </div>
      </div>
	</div>
	 <div class="ht_wid wrap">
      <div class="h_mid">
      <a href="http://www.d1.com.cn">
         <div class="hm_logo" ></div></a>
        
  
      	  <!--
      	          <a href="http://www.d1.com.cn/html/zt2014/jg0421/index.jsp" target="_blank"><div style="height: 80px; width: 208px;" class="bg_style"></div></a> 
      	   <DIV class="sghot">

			   <div id="slide">
						<%/* ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode("9145",100);//3684主题特卖
               			   ArrayList gdsidlist=new ArrayList();
              			    if(list!=null && list.size()>0){
              			 	for(PromotionProduct pProduct:list){
              			 		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
              			 	}
              			 	if(gdsidlist!=null && gdsidlist.size()>0){
	                	    ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	           		 	    if(productlist!=null){
	           		 	    int c = 0;
	           		 		for(Product p:productlist){
	           		 			c++;
		           		 		float memprice=p.getGdsmst_memberprice();//会员价
								if(getmsflag(p)){
									memprice=p.getGdsmst_msprice();//秒杀价
								}*/
	           		 		%>
	           		 		<div id="p<%//c%>">
                               <table width="190" height="60">
 									 <tr>
 									   <td width="63" rowspan="2" align="left">
 									   <img width="60" height="60" src="<% //!Tools.isNull(p.getGdsmst_smallimg())&&p.getGdsmst_smallimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><% //Tools.isNull(p.getGdsmst_smallimg())?"":p.getGdsmst_smallimg().trim()%>"/>
 									   </td>
   									   <td width="127" class="hm_sg_title"  height="30"><%//Tools.isNull(p.getGdsmst_gdsname())?"":p.getGdsmst_gdsname()%></td>
 									 </tr>
 									 <tr>
  									   <td  class="hm_sg_mprice"  height="30" valign="top">限量特价：￥<%//memprice%></td>
 									 </tr>
								</table>
							</div>	
	           		 		
	           		 		<%/*
	           		 		}
	           		 	    }
              			 	}
              			    }*/
	           		 	%>
                  </div>
                <div id="previous"></div>
	            <div id="next"></div>

             </DIV>-->
         
       <div class="hm_search" style="padding-left:90px;">
          <div class="hms_but">
          <div style="float:left;"><div id="ffb9"></div></div><input name="hm_searchbut" style="float:left;"  id="hm_searchbut" onclick="searchbut()" class="hm_searchbut" type="submit" value="搜索"  />         
            <div style="clear:both;"></div>
           </div>
            <div class="hms_key">
                <ul>
                   <li class="linnone">热门搜索：</li>
                    <%=getHeadPromotionMemu("2175",4,true,1) %>
                </ul>
            </div>
         </div>
          <div class="hm_sglist"  style="padding-left:90px;">
               <div style="height: 80px; width: 308px;">
               <img src="http://images.d1.com.cn/Index/2015/help.jpg" />
               </div>
               </div>
        <div class="hm_flow" id="headerbuy_list">
            <div class="hm_flowtxt"> <a href="http://www.d1.com.cn/flow.jsp" target="_blank">购物车<em id="headcardnum">0</em>件<b></b></a></div>
             <div class="cart" id="Headcart">正在加载购物车...<img src="http://images.d1.com.cn/images2013/newindex/Loading.gif" alt="Loading"></div>
        </div>
      </div>
    </div>
    <div class="h_menu">
    <%
    String pro_sort = request.getParameter("productsort");
    String url_idsy = request.getRequestURL().toString();
    /*System.out.println("========="+url_idsy);
    if(url_idsy.equals("http://www.d1.com.cn")){
    	System.out.println("=====这是首页===="+url_idsy);
    }else{
    	System.out.println("=====这不是首页===="+url_idsy);
    }*/
    %>
    <script language="javascript">
    
    var productsort = "<%=pro_sort%>";
    var url_idsy = "<%=url_idsy%>";
    $(document).ready(function() {
    	$('#ffb9').flexbox('/ajax/search/hotkeys.jsp',{
    		  autoCompleteFirstMatch: false,
    		    selectFirstMatch:false,
    		    noResultsText: '',
    		    paging: false,
    		    width:320,
    		    initialValue:'请输入您要搜索的商品名称或编码',
    		    inputClass:'hm_searchtxt',
    		    containerClass:'ffb',
    		    contentPos:{w:-0,t:-5,l:-1}
    		  });
      	$('#ffb9_arrow').hide();
      	$('#ffb9_input').keydown(function(){
      		keydownsearch();
      	}).focus(function(){
             if(this.value=='请输入您要搜索的商品名称或编码'){this.value='';this.style.color='#333'}
      	}).blur(function(){
      		if(this.value==''){this.value='请输入您要搜索的商品名称或编码';this.style.color='#999999'}
      	});
    	$('#head_allfl').parent().hover(function(e){
   		 $('#allfl').css('display','block');
   		 $("#head_allfl").parent().addClass("hover");
   	 }, function(e){
   		 $("#head_allfl").parent().removeClass("hover");
   		 $('#allfl').css('display','none');
   	 });
   	  $('.allfl').hover(function(e){
   			 $('#allfl').css('display','block');
   			  $("#head_allfl").parent().addClass("hover");
   		 }, function(e){
   			 $('#allfl').css('display','none');
   			  $("#head_allfl").parent().removeClass("hover");
   		 });
    	
	    if(productsort != null && productsort != "" && productsort != "null"){
	    	$('.hmenu_txt li a').removeClass("cur0311");
			$('#style'+productsort).addClass("cur0311");
	    
	    }else if(url_idsy != null && url_idsy.indexOf("http://www.d1.com.cn/html/sg") >= 0){
	    	$('.hmenu_txt li a').removeClass("cur0311");
	    	$('#stylesg').addClass("cur0311");
	    }else{
	    	$('.hmenu_txt li a').removeClass("cur0311");
	    }
    });
    </script>
     <div class="hmenu_txt" style="width:1210px;">
          <ul style="font-size:14px;">
            <li class="l" style="width:209px;"><a  id="head_allfl" style="width:209px;" class="cur" >全部商品<b></b></a></li>
            <li class="r"><a id="styleindex" href="http://www.d1.com.cn">首页</a></li>
           <li class="r"><a id="style014" href="http://www.d1.com.cn/result.jsp?productsort=014">美妆城</a></li>
           <li class="r"><a id="style030" href="http://www.d1.com.cn/result.jsp?productsort=030">男人馆</a></li>
           <li class="r"><a id="style020" href="http://www.d1.com.cn/result.jsp?productsort=020">女人街</a></li>
          <li class="r"><a id="style010" href="http://www.d1.com.cn/shop/789/2">岁未清仓</a></li>
          </ul>
       </div>
       <!--浮动层-->
	<div id="head_floatdiv" style="margin:0px auto;max-width:1200px;position:relative;z-index:10000;">
	<!--全部分类-->
	<div id="allfl" class="allfl"  style="display:none;" >
	  <script type="text/javascript" src="/inc/head1503.jsp"></script>
	</div>
	<!--全部分类结束-->
	</div>
	 <!-- 浮动层结束    -->
    </div>
</div>
 
