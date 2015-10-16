<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>
<%@include file="../public.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-是卡西欧、瑞士、天梭、swatch、浪琴等手表专卖店,特惠4折起，假一赔二！全国货到付款！</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网世界名表特价专卖店已经营了6年以上，手表4折起，卡西欧手表，西铁城，欧米茄，swatch，天梭等世界名表品牌均为100%正品，免费咨询电话400-680-8666" />
<meta name="keywords" content="D1优尚网,瑞士手表,日本品牌手表,国产,男表,女表,手表品牌排名,网上购物" />

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="Stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/subpage.css")%>" type="text/css" rel="Stylesheet" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<script type="text/javascript" language="javascript">
        function mbss() {
            var mbxh = document.getElementById("mb_mbxh");
            var mbpp = document.getElementById("mb_mbpp");
            var mbjg = document.getElementById("mb_mbjg");
            var po1 = document.getElementById("productother1");
            var po2 = document.getElementById("productother2");
            var po3 = document.getElementById("productother3");
            var po4 = document.getElementById("productother4");
            var po5 = document.getElementById("productother5");
            var po6 = document.getElementById("productother6");
            var po7 = document.getElementById("productother7");

            var condition = "";
            if (mbxh.value != "") {
                condition += "&productname=" + mbxh.value;
            }
            if (mbpp.value != "") {
                condition += "&productsort=" + mbpp.value;
            }
            if (mbjg.value != "") {
                condition += "&productprice=" + mbjg.value;
            }
            if (po1.value != "") {
                condition += "&productother1=" + po1.value;
            }
            if (po2.value != "") {
                condition += "&productother2=" + po2.value;
            }
            if (po3.value != "") {
                condition += "&productother3=" + po3.value;
            }
            if (po4.value != "") {
                condition += "&productother4=" + po4.value;
            }
            if (po5.value != "") {
                condition += "&productother5=" + po5.value;
            }
            if (po6.value != "") {
                condition += "&productother6=" + po6.value;
            }
            if (po7.value != "") {
                condition += "&productother7=" + po7.value;
            }
            condition=condition.substring(1, condition.length);
            location.href = "/result.jsp?" + condition; 

        }

    </script> 

</head>

<body>
    <div id="wrapper">
    <!--头部-->
    	<%@include file="../../inc/head.jsp" %>
    <!--头部结束-->
    <!-- 中间内容 -->
     <div class="center">
     <script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
     <div class="center">
      <%= GetChangeImg("2649")%>
      <!--左侧内容-->
       <div class="left">
            <!--馆长推荐-->
            <div class="gztj">
                <div style=" background-image:url(http://images.d1.com.cn/Index/images/l_watch.jpg); width:201px;  height:37px;"></div>
                <div class="gztjontent">
                    <div class="ltitle">
                        馆长推荐
                    </div>
                    <div class="gztj_content">
                     <%= GetGZTJKeyword("2629") %>
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
                       <span>手表款式</span>
                          <%= GetSubLeftKeyWord("2706") %>
                        
                     </div>
                      <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                      <div class="plqf_content">
                       <span>机芯类型</span>
                          <%= GetSubLeftKeyWord("2635") %>
                     </div>
                     <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
                     <div class="plqf_content">
                       <span>价位排行</span>
                           <%= GetSubLeftKeyWord_other("2638") %>
                        
                     </div>
                             
         </div>
         <!--按品类区分-->
         <!--按品牌区分-->
         <div class="ppqf">
              <div class="ltitle">
                        按品牌区分类
              </div>
              <div class="plqf_content">
                  <span>国产品牌</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                      <%= GetPP_other("2640") %> 
              </div>
             
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
               
                  <span>进口品牌</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                    <%= GetPP_other("2641") %> 
              </div>
              <br />
              <img class="line" src="http://images.d1.com.cn/Index/images/dashedline.jpg" width="198" height="11" />
               <div class="plqf_content">
                  <span>时尚品牌</span><span style=" padding-left:5px;"><img src="http://images.d1.com.cn/Index/images/sj.jpg" /></span>
                 <%= GetPP_other("2645") %> 
                </div>
            
         </div>

         <!--按品牌区分结束-->
        
         <!--热销排行-->
         <div class="rxph">
             <div class="ltitle">
                        热销排行榜

              </div>
              <%= GetHotMale("2648") %>  
         </div>
         <!--热卖排行结束-->
         <!--热门评论-->
         <div class="rmpl">
             <div class="ltitle">
                        热门评论
              </div>
              
               <%= GetHotComment("2714") %>  
              
          </div>
           <!--热门评论结束-->
       </div>
       <!--左侧内容结束-->
       <!--右侧内容-->
       <div class="right">
            <!--滚动图-->
            <div class="scrollimglist">
               <%--<img src="http://images.d1.com.cn/Index/images/scrollimgtest.jpg" />--%>
              <script>ShowCenter(<%= ScrollImg("2650") %>,<%= ScrollText("2650") %>)</script>
            
            </div>
            <!--滚动图结束-->
            <!--热卖精品-->
            <div class="rmjp">
               <img src="http://images.d1.com.cn/Index/images/rmjp.jpg" width="769" height="32" />
               <%= GetRMJP("2652") %>
            </div>
            <!--热卖精品结束-->
            <!--畅销推荐-->
            <div class="qyxz">
                <img src="http://images.d1.com.cn/Index/images/cxtj.jpg" width="769" height="32" />
              <%= GetRecouseImg("2654") %>
                <!--畅销推荐图片列表-->
                <div class="gdmstlist">
                <%= GetSubProductList("6548") %>
                </div>
                <!--畅销推荐图片列表结束-->
            </div>
            <!--畅销推荐结束-->
            
             <!--商务男表-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/swnb.jpg" width="769" height="32" />
             <%= GetRecouseImg("2656") %>
                <!--商务男表图片列表-->
                <div class="gdmstlist">
                <%= GetSubProductList("6549") %>
                </div>
                <!--商务男表图片列表结束-->
            </div>
            <!--商务男表结束-->
            
            <!--功能男表-->
            <div class="mrhf">
                <img src="http://images.d1.com.cn/Index/images/gnnb.jpg" width="769" height="32" />
                <%= GetRecouseImg("2658") %>
                <!--功能男表图片列表-->
                <div class="gdmstlist">
                 <%= GetSubProductList("6550") %>
                </div>
                <!--功能男表图片列表结束-->
            </div>
            <!--功能男表结束-->
            
            
            <!--精美女表-->
            <div class="nshf">
                <img src="http://images.d1.com.cn/Index/images/jmnb.jpg" width="769" height="32" />
               <%= GetRecouseImg("2660") %>
                <!--精美女表图片列表-->
                <div class="gdmstlist">
                <%= GetSubProductList("6551") %>
                </div>
                <!--精美女表图片列表结束-->
            </div>
            <!--精美女表结束-->
            
            
             <!--情侣表-->
            <div class="grhl">
                <img src="http://images.d1.com.cn/Index/images/qlb.jpg" width="769" height="32" />
               <%= GetRecouseImg("2662") %>
                <!--情侣表图片列表-->
                <div class="gdmstlist">
                <%= GetSubProductList("6552") %>
                </div>
                <!--情侣表图片列表结束-->
            </div>
            <!--情侣表结束-->
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