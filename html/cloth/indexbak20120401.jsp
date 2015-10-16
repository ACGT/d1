<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>
<%@include file="../public.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>	D1优尚网-女性服饰、服装网上购物商城-女式服装，服饰，包包，鞋子全部正品、特价销售，假一罚二</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚女性服饰、服装饰品网上购物商城，确保正品，假一罚二，特价在线销售2000多种女性服装，服饰，免费订购电话400-680-8666" />
<meta name="keywords" content="女性服装 女士 女式服饰 网上购物 网上商城 网上超市 网上购买 服装 服饰 外套 针织衫 衬衫打底 半身裙 卫衣 T恤 连身裙 内衣吊带 休闲裤 女鞋包包 牛仔裤 韩版 围巾 靴子 连衣裙 职业 简约 复古 甜美 休闲 性感 混搭 " />
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
		<!-- 头部结束-->
		<!-- 中间内容 -->
		
		
		<div class="center">
		<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
       <%= GetChangeImg("2610") %>
      <!--左侧内容-->
       <div class="left">
            <!--馆长推荐-->
            <div class="gztj">
                <div style=" background-image:url(http://images.d1.com.cn/Index/images/l_women.jpg); width:201px;  height:37px;"></div>
                <div class="gztjontent">
                    <div class="ltitle">馆长推荐 </div>
                    <div class="gztj_content">
                    <%= GetGZTJKeyword("2588") %>
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
                       <span>女士上装</span>
                             <%= GetSubLeftKeyWord("2598") %>
                     </div>
                      <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                      <div class="plqf_content">
                       <span>女士裤子</span>
                           <%= GetSubLeftKeyWord("2599") %>
                      </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>女士裙子</span>
                           <%= GetSubLeftKeyWord("2600") %>
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>女性内衣</span>
                         <%= GetSubLeftKeyWord("2601") %>      
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>服装配饰</span>
                           <%= GetSubLeftKeyWord("2602") %>   
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>价格排行</span>
                         <%= GetSubLeftKeyWord_other("2603") %>      
                     </div>
                             
         </div>
         <!--按品类区分-->
         <!--按品牌区分-->
         <div class="ppqf">
              <div class="ltitle">
                        按品牌分区
              </div>
              <div class="plqf_content">
                  <span>潮流女装</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                   <%= GetPP("2743") %> 
              </div>
             
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
               
                  <span>家居内衣</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                    <%= GetPP("2605") %> 
               </div>
              <br />
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
                  <span>服装配饰</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                  <%= GetPP("2606") %> 
              </div>
            
         </div>
         <!--按品牌区分结束-->
        
         <!--热销排行-->
         <div class="rxph">
             <div class="ltitle">
                        热销排行榜
              </div>
              <%= GetHotMale("2607") %>  
         </div>
         <!--热卖排行结束-->
         <!--热门评论-->
         <div class="rmpl">
             <div class="ltitle">
                        热门评论
              </div>
             <%= GetHotComment("2711") %>      
          </div>
           <!--热门评论结束-->
       </div>
       <!--左侧内容结束-->
       <!--右侧内容-->
       <div class="right">
            <!--滚动图-->
            <div class="scrollimglist">
               
                <script>ShowCenter(<%= ScrollImg("2612") %>,<%= ScrollText("2612") %>)</script>
            
            </div>
            <!--滚动图结束-->
            <!--热卖精品-->
            <div class="rmjp">
               <img src="http://images.d1.com.cn/Index/images/rmjp.jpg" width="769" height="32" />
               <%= GetRMJP("2631") %>
            </div>
            <!--热卖精品结束-->
            <!--新品速递-->
            <div class="qyxz">
                <img src="http://images.d1.com.cn/Index/images/xpsd.jpg" width="769" height="32" />
               
                <%= GetRecouseImg("2634") %>
               
                <!--新品速递图片列表-->
                <div class="gdmstlist">
                   <%= GetSubProductList("6536") %>
                </div>
                <!--新品速递图片列表结束-->
            </div>
            <!--新品速递结束-->
            
 
             <!--优雅浪漫-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/yylm.jpg" width="769" height="32" />
                <%= GetRecouseImg("2637") %>
                
                   <!--优雅浪漫图片列表-->
                <div class="gdmstlist">
                   <%= GetSubProductList("6537") %>
                </div>
                <!--优雅浪漫图片列表结束-->
            </div>
            <!--优雅浪漫结束-->
            
            <!--个性时尚-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/gxss.jpg" width="769" height="32" />
                 <%= GetRecouseImg("2642") %>
                 
                   <!--个性时尚图片列表-->
                <div class="gdmstlist">
                  <%= GetSubProductList("6538") %>    
                </div>
                <!--个性时尚图片列表结束-->
            </div>
            <!--个性时尚结束-->
            
            
            <!--家居内衣-->
            <div class="nshf">
                <img src="http://images.d1.com.cn/Index/images/jjny.jpg" width="769" height="32" />
                 <%= GetRecouseImg("2644") %>
                 
                 <!--家居内衣图片列表-->
                <div class="gdmstlist">
                  <%= GetSubProductList("6539") %>
                  
                </div>
                <!--家居内衣图片列表结束-->
            </div>
            <!--家居内衣结束-->
            
            
             <!--服装配饰-->
            <div class="grhl">
                <img src="http://images.d1.com.cn/Index/images/fzps.jpg" width="769" height="32" />
                 <%= GetRecouseImg("2647") %> 

                <!--服装配饰图片列表-->
                <div class="gdmstlist">
                    <%= GetSubProductList("6540") %>
                </div>
                <!--服装配饰图片列表结束-->
            </div>
            <!--服装配饰结束-->
       </div>
       <!--右侧内容结束-->
    </div>
	<div class="clear"></div>
		
		
		
		
		<!-- 中间内容结束 -->
		<!-- 尾部 -->
		<%@include file="../../inc/foot.jsp" %>
		<!-- 尾部结束 -->
	</div>
</body>
</html>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script> 
<script type="text/javascript" language="javascript"> 
 $(document).ready(function() {
        $(".gdmstlist_sub").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
    });
</script>
