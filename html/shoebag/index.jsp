<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>
<%@include file="../public.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="description" content="D1优尚时尚扮靓网专营精品鞋包，欧美品牌，日韩品牌，潮包，办公OL系列，活动多多，礼品多多，更有好多惊喜，欢迎选购！" />
<meta name="keywords" content="精品鞋包专场,美包，美鞋,全场超低价！" /><title>
	D1优尚网-美女最爱鞋包专场，OL款，职业包，个性包包，各类精品款，一律热卖中！
</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="Stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/subpage.css")%>" type="text/css" rel="Stylesheet" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body style="background:#fff;">
<div id="wrapper">
		<!--头部-->
		<%@include file="../../inc/head.jsp" %>
		<!-- 头部结束-->
		
		<!-- 中间内容 -->		
		<div class="center">
		<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
		<%= GetChangeImg("2677") %>
	   
		
		 <!--左侧内容-->
      
     
       <div class="left">
            <!--馆长推荐-->
            <div class="gztj">
                <div style=" background-image:url(http://images.d1.com.cn/Index/images/l_bag.jpg); width:201px;  height:37px;"></div>
                <div class="gztjontent">
                    <div class="ltitle">
                        馆长推荐
                    </div>
                    <div class="gztj_content">
                  <%= GetGZTJKeyword("2668") %>
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
                       <span>女包型款</span>
                       <%= GetSubLeftKeyWord("2669") %>
                        
                     </div>
                      <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                      <div class="plqf_content">
                       <span>女包材质</span>
                      <%= GetSubLeftKeyWord("2670") %>
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>女包颜色</span>
                           <%= GetSubLeftKeyWord("2671") %>
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>价格区分</span>
                        <%= GetSubLeftKeyWord_other("2672") %>
                        
                     </div>
                             
         </div>
         <!--按品类区分-->
         <!--按品牌区分-->
         <div class="ppqf">
              <div class="ltitle">
                        按品牌区分类
              </div>
              <div class="plqf_content">
                  <span>OL女包</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                 <%= GetPP("2673") %> 
              </div>
             
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
               
                  <span>时尚女包</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                   <%= GetPP("2674") %> 
              </div>
              <br />
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
                  <span>休闲女包</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                 <%= GetPP("2675") %> 
                </div>
            
         </div>
         <!--按品牌区分结束-->
        
         <!--热销排行-->
         <div class="rxph">
             <div class="ltitle">
                        热销排行榜

              </div>
              
             <%= GetHotMale("2691") %>  
         </div>
         <!--热卖排行结束-->
         <!--热门评论-->
         <div class="rmpl">
             <div class="ltitle">
                        热门评论
              </div>
             <%= GetHotComment("2713") %>  
          </div>
           <!--热门评论结束-->
       </div>
       <!--左侧内容结束-->
       <!--右侧内容-->
       <div class="right">
            <!--滚动图-->
            <div class="scrollimglist">

               <script>ShowCenter(<%= ScrollImg("2693") %>,<%= ScrollText("2693") %>)</script>
            </div>
            <!--滚动图结束-->
            <!--热卖精品-->
            <div class="rmjp">
               <img src="http://images.d1.com.cn/Index/images/rmjp.jpg" width="769" height="32" />
                <%= GetRMJP("2695") %>
               
            
            </div>
            <!--热卖精品结束-->
            <!--畅销推荐-->
            <div class="qyxz">
                <img src="http://images.d1.com.cn/Index/images/cxtj.jpg" width="769" height="32" />
               <%= GetRecouseImg("2697") %>
                <!--畅销推荐图片列表-->
                <div class="gdmstlist">
                    <%= GetSubProductList("6542") %>
                </div>
                <!--畅销推荐图片列表结束-->
            </div>
            <!--畅销推荐结束-->
            
             <!--新品速递-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/xpsd.jpg" width="769" height="32" />
               <%= GetRecouseImg("2699") %>
                <!--新品速递图片列表-->
                <div class="gdmstlist">
                   <%= GetSubProductList("6543") %>
                </div>
                <!--新品速递图片列表结束-->
            </div>
            <!--新品速递结束-->
            
            <!--OL通勤-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/oltq.jpg" width="769" height="32" />
                <%= GetRecouseImg("2701") %>
                <!--OL通勤图片列表-->
                <div class="gdmstlist">
                    <%= GetSubProductList("6545") %>
                </div>
                <!--OL通勤图片列表结束-->
            </div>
            <!--OL通勤结束-->
            
            
            <!--甜美淑女-->
            <div class="nshf">
                <img src="http://images.d1.com.cn/Index/images/tmsn.jpg" width="769" height="32" />
                <%= GetRecouseImg("2703") %>
                 <!--甜美淑女图片列表-->
                <div class="gdmstlist">
                
                   <%= GetSubProductList("6546") %>
                </div>
                <!--甜美淑女图片列表结束-->
            </div>
            <!--甜美淑女结束-->
            
            
             <!--欧美时尚-->
            <div class="grhl">
                <img src="http://images.d1.com.cn/Index/images/omss.jpg" width="769" height="32" />
              <%= GetRecouseImg("2705") %>
                <!--欧美时尚图片列表-->
                <div class="gdmstlist">
                 <%= GetSubProductList("6547") %>
                </div>
                <!--欧美时尚图片列表结束-->
            </div>
            <!--欧美时尚结束-->
       </div>
       <!--右侧内容结束-->
    </div>
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