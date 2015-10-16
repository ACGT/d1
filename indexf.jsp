<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/indexpublic.jsp"%>
<%if ("mqwyjf1203q".equals(session.getAttribute("d1lianmengsubad"))){
	session.removeAttribute("d1lianmengsubad");
	response.sendRedirect("http://www.d1.com.cn/zhuanti/20120328WangYi/index.jsp");
	return;
} 

%>
<%
//head
String chePingAn1 = Tools.getCookie(request,"PINGAN");
//????????String flags=session.getAttribute("flaghead")==null?"2":session.getAttribute("flaghead").toString();//????????%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1?????????D1???????????????????????????,????????????????????????????????????99???????????????????????99??????????????????????????????????????????????????????????????????D1????????????" />
<meta name="keywords" content="D1?????D1???-??????,??????,???,???,???,???,??????????????,??????,??????,??????,??????,???" />
<title>D1?????????????????,???????????????????????????????????????</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/index2012711.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2012.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
.allhd2{position: fixed;_position: absolute;right: 0px;bottom: 200px;width: 115px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;background: url("http://images.d1.com.cn/images2012/index2012/des/20130118float.jpg") no-repeat;}
</style>
</head>
<body>
<div>
<%
		if(session.getAttribute("headShow") !=null && session.getAttribute("jifenurl") !=null && !Tools.isNull(session.getAttribute("jifenurl").toString())  && !Tools.isNull(session.getAttribute("headShow").toString())){
			%>	
			<div class="mod_top_banner">
	<div class="main_area">
		<div class='sale_tip'><%=session.getAttribute("headShow").toString() %></div>
		<div class='login_status'><%
		String showmsguid = Tools.getCookie(request,"showmsg");
			if(lUser != null && showmsguid!=null){
				String showuid=URLDecoder.decode(showmsguid,"GBK");
				if (showuid!=null){
				out.print(showuid.trim());
				}
			}%>&nbsp;<a class='my_caibei' href="<%=session.getAttribute("jifenurl").toString()%>">?????????</a></div>
	</div>
</div>
 <div class="clear"></div>
		<%}
		%>  		
<%
		    ArrayList<Promotion> ptoplist=PromotionHelper.getBrandListByCodeAndArea("3341",flags, 1);
		    if(ptoplist!=null&&ptoplist.size()>0)
		    {
		    	if(ptoplist.get(0)!=null)
		    	{%>
		    	<div align="center" style="background:url('<%= ptoplist.get(0).getSplmst_picstr()%>') center center;">
		    		<a href="<%= ptoplist.get(0).getSplmst_url().trim() %>" target="_blank" style="display:block; width:100%; height:60px;">
		          
		            </a>
		        </div>
		    	<%}
		    }
		%>
		  <!-- 
   <div id="d1_small"  style="background:#fff;width:980px; margin:0px auto; display:none;"><a href="http://www.d1.com.cn/zhuanti/20120912zj/zj.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/980X60small-1.jpg"/></a></div>
   
   <div id="d1_big" style="background:#fff; width:980px; margin:0px auto; display:none;"><a href="http://www.d1.com.cn/zhuanti/20120912zj/zj.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/980X400big-1.jpg"/></a></div>
   -->   
   <div class="clear"></div>
   <!-- ??? -->
<%@include file="/inc/head.jsp" %>
<div class="clear"></div>
   <!-- ?????? -->
   <!-- page??? -->
   	<% if (!Tools.isNull(chePingAn1)){%>
   	<!--  
	<div align="center" style="background-image:url(http://images.d1.com.cn/images2012/pingan/pinganbannerbg.jpg)"><a href="http://www.wanlitong.com/campaign/5/index.jsp?WT.mc_id=000009990080025H">
	<img src="http://images.d1.com.cn/images2012/pingan/pinganbanner.jpg" width="980" height="60" border="0"></a></div>
	-->
	<%} %>
	<div id="page" class="allindex">
	
	<!-- ?????????  -->
  <div class="allhd2" id="allhd">
	<table width="180">
	<tr><td height="97"><a href="http://www.d1.com.cn/html/zt2013/20130116hd/index.jsp" target="_blank">
	<div style="height:125px;width:115px;">&nbsp;</div></a></td></tr>   
    </table>
        <a href="javascript:void(0)" onclick="closeallhd();" style="position:absolute;top:0px;right:10px; ">
        <img src="http://images.d1.com.cn/images2012/index2012/X.png" width="10" height="10" style="position:absolute;margin-left:0px; margin-top:2px; "/>
		</a>  
	 
	  </div>
    <!-- ???????????? -->
    <!-- ?????? -->
    <div id="imgrollys">
	    <div id="imgslideys" style=" background-color: transparent;">
		    <div id="imgRollOuterys">
		    <% ArrayList<Promotion> pttlist=new ArrayList<Promotion>();
		       pttlist=PromotionHelper.getBrandListByCode("3339", 15);
		       StringBuilder sbtt1219=new StringBuilder();
		       StringBuilder sbtt1219img=new StringBuilder();
		       if(pttlist!=null&&pttlist.size()>0)
		       {
		    	   for(int i=0;i<pttlist.size();i++)
		    	   {
		    		   Promotion ptt=pttlist.get(i);
		    		   if(ptt!=null)
		    		   {
		    			   out.print("<div  img_index=\""+i+"\" style=\"background:url('"+ptt.getSplmst_picstr()+"') no-repeat center center;\"><a href=\""+ptt.getSplmst_url()+"\" title=\""+Tools.clearHTML(ptt.getSplmst_name())+"\" target=\"_blank\"></a></div>");
		    		       sbtt1219.append("<a href=\""+ptt.getSplmst_url()+"\"  target=\"_blank\" img_index=\""+i+"\" >"+(i+1)+"</a>");
			    		   if(i==pttlist.size()-1)
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\"");
			    		   }
			    		   else
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\",");
			    		   }
		    		   }
		    	   }
		       }
		    %>
		    </div>
		    <p style="right:-<%=12*pttlist.size() %>px">
		    <% out.print(sbtt1219.toString()); %>
			</p>
		     <div class="imgrollboxys">
			     <div class="left" ></div>
			     <div class="right" ></div>
		     </div>
	     </div>
     </div>


	
    <!-- ??? -->
	<div id="center">
	<div style="display:block;width:980px; height:30px;background:#f4f4f4;color:#9fa0a0; line-height:30px;">
	  <marquee behavior="alternate" onmouseover="this.stop()"  onmouseout="this.start()" scrolldelay="300">??????????????????????????????????????????????????????????????1?????????????????????????????/marquee>
	</div>
    <script type="text/javascript" src="/inc/getxpqx130110.jsp"></script>	
    <!-- ?????? -->
	   <div class="hotclass1">
	        <img src="http://images.d1.com.cn/images2012/index2012/des/rmfl.png"/>
     
       <table width="980" style="float:left;">
          <tr >
             <td style="background:#f9f9f9;height:250px;border-top:solid 3px #9c0001;">
               <table width="100%"  valign="center">
                  <tr>
                      <td width="140" style="padding-left:20px;">
                          <span class="rmflspantitle" style="color:#9c0000">??????</span>
                         
                          <span style="font-size:13px; font-weight:bold;color:#3f3939; height:29px;line-height:29px;width:110px;background:url('http://images.d1.com.cn/images2012/index2012/des/newmew.png') no-repeat center right;">??????</span>
                         <%=getHotKeys1("3304",3) %>
                          <span style="display:block;height:8px;"></span>
                           <span style="font-size:13px; font-weight:bold;color:#3f3939; height:29px; line-height:29px;width:110px;background:url('http://images.d1.com.cn/images2012/index2012/des/hotnew.png') no-repeat center right;">??????</span>
                          <%=getHotKeys1("3305",3) %>
                           <span style="display:block;height:20px;"></span>
                      </td>
                      <td width="89">
                      <%=getindexHotKey("3306",9) %>
                      </td>
                      <td width="89">
                        <%=getindexHotKey("3307",9) %>
                      </td>
                      <td width="89">
                          <%=getindexHotKey("3308",9) %>
                      </td>
                      <td width="89">
                         <%=getindexHotKey("3309",9) %>
                      </td>
                      <td style="background:none;" >
                      <%=getindexHotKey("3330",9) %>
                       </td>
                       <td style="background:none;padding-top:1px;"> <div class="rmflimg">
			      <%
			         StringBuilder sbnvzy=new StringBuilder();	
			         StringBuilder sbnanvzy=new StringBuilder();	
			         ArrayList<Promotion> plist1219=new  ArrayList<Promotion>();
			         plist1219=PromotionHelper.getBrandListByCode("3338", 4);
			         if(plist1219!=null&&plist1219.size()>0)
			         {
			        	 sbnvzy.append("<ul>");
			        	 sbnanvzy.append("<ul>");
			            for(int i=0;i<plist1219.size();i++)
			            {
			            	 Promotion p1219=plist1219.get(i);
			            	 if(i<2)
			            	 {
			            		 if(i%2==1)
			            		 {
			            	 		 sbnvzy.append("<li style=\"margin-bottom:0px;\"><a href=\""+p1219.getSplmst_url()+"\" target=\"_blank\"><img src=\""+p1219.getSplmst_picstr()+"\" width=\"280\" height=\"125\"/></a></li>");
						         }
			            		 else
			            		 {
			            	 		 sbnvzy.append("<li><a href=\""+p1219.getSplmst_url()+"\" target=\"_blank\"><img src=\""+p1219.getSplmst_picstr()+"\" width=\"280\" height=\"125\"/></a></li>");
						         }
			                 }
			            	 else
			            	 {
			            		 if(i%2==1)
			            		 {
			            			 sbnanvzy.append("<li style=\"margin-bottom:0px;\"><a href=\""+p1219.getSplmst_url()+"\" target=\"_blank\"><img src=\""+p1219.getSplmst_picstr()+"\" width=\"280\" height=\"125\"/></a></li>");
						         }
			            		 else
			            		 {
			            			 sbnanvzy.append("<li><a href=\""+p1219.getSplmst_url()+"\" target=\"_blank\"><img src=\""+p1219.getSplmst_picstr()+"\" width=\"280\" height=\"125\"/></a></li>");
						         }
			            	  }
			              }
			            sbnvzy.append("<ul>");
			        	sbnanvzy.append("<ul>");
			         }
			         out.print(sbnvzy.toString());
			      %>
      
	   </div></td>
                  </tr>
               </table>
             </td>
          </tr>
          <tr><td height="3" style="background:url('http://images.d1.com.cn/images2012/index2012/des/flht.jpg') center center;"></td></tr>
          <tr>
             <td style="background:#f9f9f9;height:250px;">
               <table width="100%"  valign="center">
                  <tr>
                      <td width="140" style="padding-left:20px;">
                          <span class="rmflspantitle" style="color:#000856">??????</span>
                         
                          <span style="font-size:13px; font-weight:bold;color:#3f3939; height:29px;line-height:29px;width:110px;background:url('http://images.d1.com.cn/images2012/index2012/des/newmew.png') no-repeat center right;">??????</span>
                          <%=getHotKeys1("3311",3) %>
                          <span style="display:block;height:8px;"></span>
                           <span style="font-size:13px; font-weight:bold;color:#3f3939; height:29px; line-height:29px;width:110px;background:url('http://images.d1.com.cn/images2012/index2012/des/hotnew.png') no-repeat center right;">??????</span>
                          <%=getHotKeys1("3312",3) %>
                           <span style="display:block;height:20px;"></span>
                      </td>
                      <td width="89">
                         <%=getindexHotKey("3313",9) %>
                      </td>
                      <td width="89">
                          <%=getindexHotKey("3314",9) %>
                      </td>
                      <td width="89">
                       <%=getindexHotKey("3315",9) %>
                      </td>
                      <td width="89">
                         <%=getindexHotKey("3316",9) %>
                      </td>
                      <td  style="background:none;">
                      <%=getindexHotKey("3337",9) %>
                       </td>
                       <td style="background:none;padding-top:1px;">
                       <div class="rmflimg">
                       <% out.print(sbnanvzy.toString());%>
                       </div>
                       </td>
                  </tr>
               </table>
             </td>
          </tr>
       </table>
     
	   </div>
	   
	  
	   
	    <!-- ?????????-->	   
<div class="clear"></div>
	    
	   <script type="text/javascript" src="/inc/getTag1.jsp"></script>	
	   <!-- 
	   <script type="text/javascript" src="/inc/getIndexProduct1.jsp"></script>
	    -->
	   
	   <div class="clear"></div>
	   
         <!-- ??????-->
        <div class="content">
         <div class="layout_box menmber">
            <h2><a href="/jifen/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/June/index6_47.jpg"/></a></h2><%
            List<PromotionProduct> recommendProList = null;
            recommendProList = PromotionProductHelper.getPromotionProductByCode("6771" , 8);
            if(recommendProList != null && !recommendProList.isEmpty()){
            	int size = recommendProList.size();
            	int count = 0;
            %>
            <ul class="goods_list"><%
            	for(int i=0;i<size&&count<5;i++){
            		PromotionProduct recommend = recommendProList.get(i);
            		Product product = ProductHelper.getById(recommend.getSpgdsrcm_gdsid());
            		if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
            		String title = Tools.clearHTML(recommend.getSpgdsrcm_gdsname());
            		//Award award = AwardHelper.getByProductId(product.getId());
            		List<Award> awardlist = AwardHelper.getAwardByGdsid(product.getId(),1);
            		if(awardlist == null) continue;
            		for(Award award:awardlist){
            %>
            	<li><dl>
            		<dt><a href="/jifen/index.jsp" title="<%=title %>" target="_blank"><img src="http://images.d1.com.cn/<%=product.getGdsmst_otherimg3() %>" alt="<%=title %>" width="120" height="120"/></a></dt>
            		<dd class="name"><a href='/jifen/index.jsp' title="<%=title %>" target='_blank'><%=title %></a></dd>
            		<dd><strong><%=Tools.longValue(award.getAward_value()) %>???</strong><del>??%=product.getGdsmst_saleprice() %></del></dd>
            	</dl></li><%
            		}
            		count++;
            	} %>
            	
            </ul><%
            } %>
        </div>
        <div class="right_side about_us">
          <div class="layout_box">
            <h2><img src="http://images.d1.com.cn/images2012/index2012/June/index6_49.jpg""/></h2><%
            ArrayList<Promotion> recommendList=new ArrayList<Promotion>();
            recommendList = PromotionHelper.getBrandListByCode("2742" , 7);
            if(recommendList != null && !recommendList.isEmpty()){
            	int size = recommendList.size();
            %>
            <ul class="news_list"><%
            	for(int i=0;i<size;i++){
            		Promotion recommend = recommendList.get(i);
            		String title = Tools.clearHTML(recommend.getSplmst_name());
            %>
            	<li><a rel="nofollow" href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target='_blank' title="<%=title %>"<%if(i==1){ %> style="color:#ad4456"<%} %>><%=title %></a></li><%
            	} %>
            </ul><%
            } %>
          </div>
          
        </div>
        </div>
        <!-- ?????????-->
		<div class="clear"></div>
	
	   
	</div>
	
    <!-- ?????? -->  
  

    </div>
</div>
   <div class="clear"></div>
   <%@include file="/inc/foot.jsp" %>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<script type="text/javascript">
function closeSC(){
	$("#sc").animate({width:"339"},1000,function(){});$("#sc").animate({height:"0"},1000,function(){});
	$("#sc").slideUp();
}

function closeallhd()
{
    $("#allhd").css("display","none");	
}
function openSc()
{
	
	$("#sc").animate({height:"234"},1000,function(){});
	//$("#sc").css("display","block");
	//$("#sc").slideUp();
	}


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
  
  


  $(document).ready(function() {
         var roll_images=[<%= sbtt1219img.toString()%>];
	     var imgrollbg=['#fff','#fff','#fff','#fff','#fff','#fff','#fff','#fff'];
	 	 var bg = imgrollbg || null;
	 	 new RollImage(roll_images, $("#imgRollOuterys"), $("#imgslideys>p>a"), null, $("#imgrollys .left"), $("#imgrollys .right"), bg).run(1);
         $("#imgrollys").hover(function ()
		  {
				$(this).find(".left,.right").fadeIn();
		  },
		  function ()
		  {
			    $(this).find(".left,.right").fadeOut();
		  });
         $("#wmain img").hover(function() {
        		//$(this).closest("div").find("img").css("opacity",0.7);
        		$("#wmain").find("img").not('#womentitle').css("opacity",0.7);
        		$(this).css("opacity",1);
        	},function() {
        		$("#wmain img").css("opacity",1);
        	});	
        	$("#mmain img").hover(function() {
        		//$(this).closest("div").find("img").css("opacity",0.7);
        		$("#mmain").find("img").not('#mentitle').css("opacity",0.7);
        		$(this).css("opacity",1);
        	},function() {
        		$("#mmain img").css("opacity",1);
        	});	
          $("#spmain img").hover(function() {
        		//$(this).closest("div").find("img").css("opacity",0.7);
        		$("#spmain").find("img").not('#sptitle').css("opacity",0.7);
        		$(this).css("opacity",1);
        	},function() {
        		$("#spmain img").css("opacity",1);
        	});	
        /* $.ajax({
         	type: "get",
         	dataType: "json",
         	url: 't.jsp',
         	cache: false,
         	data: {wid:screen.width,hid:screen.height}
         });*/
      
	   // startmarquee(19,30,3000,0);
	   // openSc();
	  //  xpsdscroll("#testarrow");

	   // $("#d1_big").animate({width:"980"},3000,function(){});
	   // $("#d1_big").animate({height:"0"},3000,function(){
	    	//$("#d1_big").css('display','none');
	    	//$("#d1_small").animate({height:"60"},4000,function(){});
	    	//$("#d1_small").animate({width:"980"},4000,function(){});
	  //  });
	     //$(".newgdscoll").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
        
	     $(".pimg").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
	});
 </script>
  
   
</body>
</html>
