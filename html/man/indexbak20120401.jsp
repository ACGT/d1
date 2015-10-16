<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>
<%@include file="../public.jsp"%>

<%if ("mqwyjf1203q".equals(session.getAttribute("d1lianmengsubad"))){
	session.removeAttribute("d1lianmengsubad");
	response.sendRedirect("http://www.d1.com.cn/zhuanti/20120328WangYi/index.jsp");
	return;
} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="卡西欧、TISSOT、浪琴、金利来、七匹狼、圣大保罗、红豆、ZIPPO、瑞士军刀等男仕精品3折起！！批发团购010-51665136-8008" />
<meta name="keywords" content="男人馆-绅士精品专卖,网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>	D1优尚网-男装皮具专卖--全国货到付款！衬衫、大衣、POLO、裤子等2折起，30天无条件退换！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="Stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/subpage.css")%>" type="text/css" rel="Stylesheet" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body>
    <div id="wrapper">
    <!--头部-->
    	<%@include file="../../inc/head.jsp" %>
    <!--头部结束-->
  
     <div class="center">
     <script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
     <%= GetChangeImg("2667") %>
      <!--左侧内容-->
       <div class="left">
            <!--馆长推荐-->
            <div class="gztj">
                <div style=" background-image:url(http://images.d1.com.cn/Index/images/l_man.jpg); width:201px;  height:37px;"></div>
                <div class="gztjontent">
                    <div class="ltitle">
                        馆长推荐
                    </div>
                    <div class="gztj_content">
                   <%= GetGZTJKeyword("2589") %>
                    </div>
                </div>
            </div>
            <!--馆长推荐结束-->
            <!--按品类区分-->
            <div class="plqf">
                    <div class="ltitle">
                        按品类分区

                    </div>
                    <div class="plqf_content">
                       <span>绅士服装</span>
                          <%= GetSubLeftKeyWord("2590") %>
                        
                     </div>
                      <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                      <div class="plqf_content">
                       <span>名牌皮具</span>
                           <%= GetSubLeftKeyWord("2591") %>
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>品质生活</span>
                           <%= GetSubLeftKeyWord("2592") %>
                     </div>
                             
         </div>
         <!--按品类区分-->
         <!--按品牌区分-->
         <div class="ppqf">
              <div class="ltitle">
                        按品牌区分类
              </div>
              <div class="plqf_content">
                  <span>男装品牌</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                    <%= GetPP("2593") %> 
              </div>
             
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
               
                  <span>皮具品牌</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                     <%= GetPP("2594") %> 
              </div>
              <br />
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
                  <span>名表品牌</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                   <%= GetPP("2595") %> 
                </div>
                <br />
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
                  <span>随身小物</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                 <%= GetPP("2596") %> 
                   
                </div>
            
         </div>
         <!--按品牌区分结束-->
        
         <!--热销排行-->
         <div class="rxph">
             <div class="ltitle">
                        热销排行榜

              </div>
            <%= GetHotMale("2597") %>  
         </div>
         <!--热卖排行结束-->
         <!--热门评论-->
         <div class="rmpl">
             <div class="ltitle">
                        热门评论
              </div>
              
              <%= GetHotComment("2712") %>  
        
         </div>
           <!--热门评论结束-->
       </div>
       <!--左侧内容结束-->
       <!--右侧内容-->
       <div class="right">
            <!--滚动图-->
            <div class="scrollimglist">
               <%--<img src="http://images.d1.com.cn/Index/images/scrollimgtest.jpg" />--%>
                <script>ShowCenter(<%= ScrollImg("2615") %>,<%= ScrollText("2615") %>)</script>
            
            </div>
            <!--滚动图结束-->
            <!--热卖精品-->
            <div class="rmjp">
               <img src="http://images.d1.com.cn/Index/images/rmjp.jpg" width="769" height="32" />
              <%= GetRMJP("2617") %>
            
            </div>
            <!--热卖精品结束-->
            <!--新款推荐-->
            <div class="qyxz">
                <img src="http://images.d1.com.cn/Index/images/xktj.jpg" width="769" height="32" />
               <%= GetRecouseImg("2619") %>
                <!--新款推荐图片列表-->
                <div class="gdmstlist">
                 <%= GetSubProductList("6562") %>
                </div>
                <!--新款推荐图片列表结束-->
            </div>
            <!--新款推荐结束-->
            
             <!--绅士服饰-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/ssfs.jpg" width="769" height="32" />
               <%= GetRecouseImg("2621") %>
                <!--绅士服饰图片列表-->
                <div class="gdmstlist">
                 <%= GetSubProductList("6623") %>
                </div>
                <!--绅士服饰图片列表结束-->
            </div>
            <!--绅士服饰结束-->
            
            <!--型款男裤-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/xknk.jpg" width="769" height="32" />
               <%= GetRecouseImg("2623") %>
                <!--型款男裤图片列表-->
                <div class="gdmstlist">
           <%= GetSubProductList("6564") %>
                </div>
                <!--型款男裤图片列表结束-->
            </div>
            <!--型款男裤结束-->
            
            
            <!--名牌皮具-->
            <div class="nshf">
                <img src="http://images.d1.com.cn/Index/images/mppj.jpg" width="769" height="32" />
                <%= GetRecouseImg("2625") %>
                <!--名牌皮具图片列表-->
                <div class="gdmstlist">
                  <%= GetSubProductList("6565") %>
                </div>
                <!--名牌皮具图片列表结束-->
            </div>
            <!--名牌皮具结束-->
            
            
             <!--热销男鞋-->
            <div class="grhl">
                <img src="http://images.d1.com.cn/Index/images/rxnx.jpg" width="769" height="32" />
               <%= GetRecouseImg("2627") %>
                <!--热销男鞋图片列表-->
                <div class="gdmstlist">
                <%= GetSubProductList("6566") %>
                </div>
                <!--热销男鞋图片列表结束-->
            </div>
            <!--热销男鞋结束-->
       </div>
       <!--右侧内容结束-->
    </div>
	<div class="clear"></div>
   <!-- 中间内容结束 -->
    <!-- 尾部内容-->
    <%@include file="../../inc/foot.jsp" %>
    <!--尾部内容结束-->
	</div>

</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script> 
<script type="text/javascript" language="javascript"> 
 $(document).ready(function() {
        $(".gdmstlist_sub").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
    });
</script>
