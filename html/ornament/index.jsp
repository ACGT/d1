<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>
<%@include file="../public.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网－饰品，流行饰品，水晶饰品，正品网上购物商城</title>
<meta name="Description" content="D1优尚网是最品质最专业的饰品店，水晶项链、水晶手链、纯银吊坠，全场特价，货到付款，100%正品，假一罚二。免费咨询电话400-680-8666" />
<meta name="keywords" content="D1优尚网,饰品,项链,手链,戒指,吊坠" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
		
		<!--左侧内容-->
       <div class="left">
            <!--馆长推荐-->
            <div class="gztj">
                <div style=" background-image:url(http://images.d1.com.cn/Index/images/l_sp.jpg); width:201px;  height:37px;"></div>
                <div class="gztjontent">
                    <div class="ltitle">
                        馆长推荐
                    </div>
                    <div class="gztj_content">
                         <%= GetGZTJKeyword("2521") %>
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
                       <span>饰品分类</span>
                            <%= GetSubLeftKeyWord("2523") %>
                     </div>
                      <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                      <div class="plqf_content">
                       <span>材质分类</span>
                           <%= GetSubLeftKeyWord("2524") %>
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>价格区分</span>
                          <%= GetSubLeftKeyWord_other("2525") %>
                     </div>
                             
         </div>
         <!--按品类区分-->
         <!--按品牌区分-->
         <div class="ppqf">
              <div class="ltitle">
                        按品牌区分类
              </div>
              <div class="plqf_content">
                  <span>时尚饰品</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                    <%= GetPP("2527") %> 
              </div>
              <br />
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
               
                  <span>钻石珠宝</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                    <%= GetPP("2528") %> 
              </div>
             
             
            
         </div>
         <!--按品牌区分结束-->
        
         <!--热销排行-->
         <div class="rxph">
             <div class="ltitle">
                        热销排行榜

              </div>
               <%= GetHotMale("2529") %>  
         </div>
         <!--热卖排行结束-->
         <!--热门评论-->
         <div class="rmpl">
             <div class="ltitle">
                        热门评论
              </div>
             <%= GetHotComment("2710") %>  
              

              
          </div>
           <!--热门评论结束-->
       </div>
       <!--左侧内容结束-->
       <!--右侧内容-->
       <div class="right">
            <!--滚动图-->
            <div class="scrollimglist">
               <%--<img src="http://images.d1.com.cn/Index/images/scrollimgtest.jpg" />--%>
                <script>ShowCenter(<%= ScrollImg("2530") %>,<%= ScrollText("2530") %>)</script>     </div>
            <!--滚动图结束-->
            <!--热卖精品-->
            <div class="rmjp">
               <img src="http://images.d1.com.cn/Index/images/rmjp.jpg" width="769" height="32" />
                 <%= GetRMJP("2531") %>
            </div>
            <!--热卖精品结束-->
            <!--新品速递-->
            <div class="qyxz">
			<img src="http://images.d1.com.cn/Index/images/xpsd.jpg" width="769" height="32" />
                <%= GetRecouseImg("2544") %>
                <!--新品速递图片列表-->
                <div class="gdmstlist">
                     <%= GetSubProductList("6525") %>
                </div>
                <!--新品速递图片列表结束-->
            </div>
            <!--新品速递结束-->
            
             <!--本周特价-->
            <div class="mrhf">
			<img src="http://images.d1.com.cn/Index/images/bztj.jpg" width="769" height="32" />
                 <%= GetRecouseImg("2543") %>
                <!--本周特价图片列表-->
                <div class="gdmstlist">
                    <%= GetSubProductList("6526") %>
                </div>
                <!--本周特价图片列表结束-->
            </div>
            <!--本周特价结束-->
            
            <!--潮流饰界-->
            <div class="mrhf">
			<img src="http://images.d1.com.cn/Index/images/clsj.jpg" width="769" height="32" />
                  <%= GetRecouseImg("2545") %>
                <!--潮流饰界图片列表-->
                <div class="gdmstlist">
                     <%= GetSubProductList("6527") %>
                </div>
                <!--潮流饰界图片列表结束-->
            </div>
            <!--潮流饰界结束-->
            
            
            <!--吉祥开运-->
            <div class="nshf">
			<img src="http://images.d1.com.cn/Index/images/jxky.jpg" width="769" height="32" />
                <%= GetRecouseImg("2546") %>
                <!--吉祥开运图片列表-->
                <div class="gdmstlist">
                     <%= GetSubProductList("6529") %>
                </div>
                <!--吉祥开运图片列表结束-->
            </div>
            <!--吉祥开运结束-->
            
            
             <!--珠宝钻石-->
            <div class="grhl">
			<img src="http://images.d1.com.cn/Index/images/zbzs.jpg" width="769" height="32" />
                <%= GetRecouseImg("2547") %>
                <!--珠宝钻石图片列表-->
                <div class="gdmstlist">
                    <%= GetSubProductList("6528") %>
                </div>
                <!--珠宝钻石图片列表结束-->
            </div>
            <!--珠宝钻石结束-->
       </div>
       <!--右侧内容结束-->
		
		</div>
		<!-- 中间内容结束 -->
		<div class="clear"></div>
		
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