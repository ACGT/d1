<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/funindex.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！">
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买">
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>

<script src="/res/js/jquery-1.3.2.min.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" src="/res/js/d1.js?1406565937411"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js?"+System.currentTimeMillis())%>"></script>

<script src="/res/js/index/SpryTab1.js" type="text/javascript"></script>
<script src="/res/js/index/SpryTab2.js" type="text/javascript"></script>
<script src="/res/js/index/SpryTab3.js" type="text/javascript"></script>
<link href="/res/css/index/layout.css" rel="stylesheet" type="text/css">
<link href="/res/css/index/SpryTab1.css" rel="stylesheet" type="text/css">
<link href="/res/css/index/SpryTab2.css" rel="stylesheet" type="text/css">

<script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>

if(checkMobile()){
	window.location.href="http://m.d1.cn";
}
</script>
<style type="text/css">

.i_price_new {
background-image: url(http://images.d1.com.cn/zt2014/0304/pricebg-big1.gif);
background-repeat: repeat;
height: 70px;

}
.i_price_newbg {
background-image: url(http://images.d1.com.cn/zt2014/0304/bgbigbar-or.gif);
background-repeat: repeat;
height: 70px;
}

.lijiqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/lijiqiang-big.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.jijkqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/getitsoon.jpg);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.shouqing{
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/shouqingbig.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}

.s2_1 {
color: #FFFFFF;
font-size: 43px;
line-height: 43px;
padding-left: 16px;
/*vertical-align: bottom;*/
font-family: 'arial';
display: block;
height: 38px;
padding-top: 5px;
}

.s3{
color: #f7949b;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.s3new{
color: #fcbf9c;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.zhekou_t {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/checknap.png);
background-position: 0px 0px;
width: 39px; height: 18px;
left:12px;
bottom: 165px;
}
.djs_newlist{
font-size: 14pt;
color: #f0424e;
padding:0px 2px;
font-family: 'arial';
}
.productadright{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 160px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}
.page_f{
    left: 0px;bottom: 0px;width: 100px;font-size: 12px;display: block;
	float:left;
	margin-top:10px; 
	margin-left:10px; 
	position:fixed; 
	_position:absolute;
	_bottom:auto; 
	_top:expression(eval(document.documentElement.scrollTop));
	z-index:99999;
}

.topbannerdiv{	position:relative; width:980px; height:450px; margin: 0px auto;}
.topbannerdiv .link1{ position:absolute;  width:980px; height:450px; bottom:0; left:0px; }

.banner328 {
background-image: url(http://images.d1.com.cn/zt2014/0415/0415.jpg);
background-repeat: no-repeat;
background-position: center;
height: 300px;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	$(".nav ul li").hover(function(){
		$(this).addClass("hover_bg");
		$(this).children("div").show();
	},function(){
		$(this).removeClass("hover_bg");
		$(this).children("div").hide();
	})
})
</script>
</head>
<body>

<!-- top  start -->
<!-- 头部开始 -->
<%@include file="/inc/head1203.jsp" %>
<!-- 头部结束 -->
<!-- top over  -->
<!--  banner  start -->
<div class="tkWrap">
<!--首页轮播-->
<div id="imgrollys">
	     <div id="imgslideys" style=" background-color: transparent;">
		    <div id="imgRollOuterys">
		    <%  ArrayList<Promotion> pttlist=new ArrayList<Promotion>();
		       pttlist=PromotionHelper.getBrandListByCode("3685", 15);//轮播3685
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
		    <%if(pttlist.size() != 1){%>
		    	<p style="right:-<%=12*pttlist.size() %>px">
		    	<% out.print(sbtt1219.toString()); %>
				</p>
		    <%}%>
		     <div class="imgrollboxys">
			     <div class="left" ></div>
			     <div class="right" ></div>
		     </div>
	     </div>
</div> 
<!--首页轮播结束-->


</div>

<!--  banner  over -->
<div class="content">
  <div class="allwrapper">
    <div class="main_div1">


    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td rowspan="2" class="c_td1"></td>
          <td class="c_td2"></td>
        </tr>
        <tr>
          <td class="c_td3">
         <%  ArrayList<Promotion> zt_plist=new ArrayList<Promotion>(); 
        zt_plist=PromotionHelper.getBrandListByCode("3805", -1);
        if(zt_plist!=null&&zt_plist.size()>0){
        	int i=1;
			for(Promotion p:zt_plist){
       long endt= p.getSplmst_tjendtime().getTime();
        %>
          <div class="hot_list1">
              <ul>
                <li>
                <a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" width="324" height="190" />
                </li>
                <li class="hot_list1_text1"> 
                    <div class="s_f">
		            <span class="time"><i></i><span id="pmstime<%=i%>"></span>
		              </span>
		           </div>
                  <b><a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank"><%=p.getSplmst_name() !=null?p.getSplmst_name():"" %></a></b> </li>
                <li class="btn_buy1"><a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():""  %>" target="_blank"><img src="http://images.d1.com.cn/Index/2014/btn_buy1.jpg" width="55" height="55" alt="button buy"></a></li>
              </ul>
            </div>
            <script type="text/javascript">
			setInterval("vms_time(<%=endt%>,<%=i%>)",1000);	
            </script>
            <%i++;
            }
			}%>
         </td>
        </tr>
      </table>
    </div>
   
   <div class="main_div1">
      <div id="TabbedPanels1" class="TabbedPanels">
        <ul class="TabbedPanelsTabGroup">
          <li class="TabbedPanelsTab TabbedPanelsTabSelected" tabindex="0">超级闪购<img src="http://images.d1.com.cn/Index/2014/title_01.png" hspace="8" align="absmiddle"></li>
          <li class="TabbedPanelsTab" tabindex="0"><img src="http://images.d1.com.cn/Index/2014/title_02.png" hspace="8" align="absmiddle">新品速递</li>
          <li class="TabbedPanelsTab" tabindex="0"><img src="http://images.d1.com.cn/Index/2014/title_03.png" hspace="8" align="absmiddle">销量排行</li>
        </ul>
        <div class="TabbedPanelsContentGroup">
          <div class="TabbedPanelsContent TabbedPanelsContentVisible" style="display: block;">
            <div class="clear">
            <%ArrayList<SgGdsDtl> sglist=getsghot();
            
            if(sglist!=null&&sglist.size()>0){
            for(SgGdsDtl sgdtl:sglist){
            	String gdsid=sgdtl.getSggdsdtl_gdsid();
            	Product p=ProductHelper.getById(gdsid);
            	String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
            	String ptitle=StringUtils.replaceHtml(p.getGdsmst_title());
            	int mprice=p.getGdsmst_saleprice().intValue();
            	int msprice=p.getGdsmst_msprice().intValue();
                long gdsnum= sgdtl.getSggdsdtl_vallnum().longValue()-sgdtl.getSggdsdtl_vbuynum().longValue()-sgdtl.getSggdsdtl_vusrnum().longValue();
                long gdsnum2=sgdtl.getSggdsdtl_maxnum().longValue()-sgdtl.getSggdsdtl_realbuynum().longValue();
                long buynum= sgdtl.getSggdsdtl_vbuynum().longValue()+sgdtl.getSggdsdtl_vusrnum().longValue();

                if (gdsnum<=0||gdsnum2<=0 ||p.getGdsmst_validflag().longValue()==2){
                	  gdsnum=0;
                	 buynum= sgdtl.getSggdsdtl_vallnum().longValue();
                }
                String img=p.getGdsmst_img310();
                if(!Tools.isNull(img)){
        			if(img.startsWith("/shopimg/")){
        				img = "http://images1.d1.com.cn"+img.trim();
        			}else{
        				img = "http://images.d1.com.cn"+img.trim();
        			}
        			}
            %>
              <div class="hot_buy_list" id="pro_box1">
                <ul>
                  <li id="hot_buy1"><a href="http://www.d1.com.cn/product/<%=gdsid%>" target="_blank"  title="<%=imgalt%>"> 
                  <img src="<%=img %>" alt="<%=imgalt%>" width="200" height="200"></a></li>
                  <li style=" margin-top:5px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tbody><tr>
                        <td colspan="2" class="c_td4">
                        <div class="ctd9hid">
                        <a href="http://www.d1.com.cn/product/<%=gdsid%>" target="_blank"  title="<%=imgalt%>"> <%=imgalt %>
                        </a></div>
                        </td>
                      </tr>
                
                      <tr>
                        <td colspan="2" class="c_td5"><div class="ctd10hid"><%=!Tools.isNull(ptitle)?ptitle:"" %></div></td>
                      </tr>
                  
                      <tr>
                        <td colspan="2" class="c_td6"><label class="c_text1">￥<%=msprice %></label>
                          <span class="c_text2">￥<%=mprice %></span></td>
                      </tr>
                      <tr>
                        <td valign="bottom" class="c_Td7"><%=buynum %>已购买</td>
                        <td align="right" valign="top"><a href="http://www.d1.com.cn/product/<%=gdsid%>" target="_blank"  title="<%=imgalt%>"> <img src="http://images.d1.com.cn/Index/2014/btn_buy2.jpg"></a></td>
                      </tr>
                    </tbody></table>
                  </li>
                </ul>
              </div>
              <%}
            }
            %>
            </div>
          </div>
          <div class="TabbedPanelsContent" style="display: none;">
            <div class="clear">
              <%=getNewSalsP("9459",5) %>
            </div>
          </div>
          <div class="TabbedPanelsContent" style="display: none;">
            <div class="clear">
               <%=getNewSalsP("9460",5) %>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div align="center"><%=getimgstr("3812",1,0) %></div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck("3737","3738","3739","013016001",2) %>
    </div>
   <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck("3740","3741","3742","013016002",3) %>
    </div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck("3752","3753","3754","013016003",4) %>
    </div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck("3749","3750","3751","013016004",5) %>
    </div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck("3743","3744","3745","013016005",6) %>
    </div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck("3746","3747","3748","013016006",7) %>
    </div>
  </div>
  
<!-- 底部开始 -->

<link href="http://www.d1.com.cn/res/css/foot2014.css?1406568034320" rel="stylesheet" type="text/css" media="screen" />
<!--底部信息-->
<div class="foot" align="center">
	<br>
	<div class="top" style="width:1210px;"></div>
    <div class="other_help">
    <div class="wrapper" align="left"><div class="us_virtue"><span class="zp"></span><span class="ps"></span><span class="aq"></span><span class="fw"></span></div><dl><dt>购物帮助</dt><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0103" target="_blank"> 购物的基本问题</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0105" target="_blank"> 如何使用优惠券</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0104" target="_blank"> 如何累计并消费积分</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0101" target="_blank"> 第一次购物体验</a></dd></dl><dl><dt>支付方式</dt><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0201" target="_blank"> 货到付款</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0202" target="_blank"> 银行电汇</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0203" target="_blank"> 网银支付</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0204" target="_blank"> 邮局汇款</a></dd></dl><dl><dt>配送方式及费用</dt><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0404" target="_blank"><span style="color:#ff0000">物流信息查询</span></a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0303" target="_blank">配送范围</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0301" target="_blank"> 配送方式</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0302" target="_blank"> 运费说明</a></dd></dl> <dl><dt>售后服务</dt><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=06" target="_blank"> D1品质保证原则</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=06" target="_blank"> D1退换货总原则</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=06" target="_blank"> D1退换货地址及流程</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=06" target="_blank"> D1退换货特殊说明</a></dd></dl><dl><dt>VIP特享政策</dt><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0502" target="_blank"> VIP会员的优惠及服务</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0502" target="_blank"> 如何获得和保持VIP</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0503" target="_blank"> 如何升级为白金VIP</a></dd><dd><a href="http://help.d1.com.cn/hphelpnew.htm?code=0503" target="_blank"> 白金VIP的优惠及服务</a></dd></dl> 
    <dl>
    <div class="wx">
    </div>
    </dl>
    
     </div><div class="clear"></div>
     <br>
	<div class="bottom"></div>
</div>
<div id="footer">
    <p><a href="http://help.d1.com.cn/hphelpnew.htm?code=0405" target="_blank">联系我们</a>|<a href="http://www.d1.com.cn/enterprise/aboutd1.jsp" target="_blank" rel="nofollow">关于我们</a>|<a href="http://help.d1.com.cn/hphelpnew.htm?code=03" target="_blank" rel="nofollow">配送范围</a>|<a href="http://help.d1.com.cn/hphelpnew.htm?code=02" target="_blank" rel="nofollow">如何付款</a>|<a href="http://www.d1.com.cn/enterprise/zhaopin.jsp" target="_blank" rel="nofollow">诚聘人才</a>|<a href="http://www.d1.com.cn/enterprise/d1zs.jsp" target="_blank" rel="nofollow">商家入驻</a>|<a href="http://www.d1.com.cn/html/friendlink.jsp" target="_blank">友情链接</a>|<a href="http://www.d1.com.cn/html/map.jsp" target="_blank">网站地图</a>
    </p><div style="display:none;">
        <table width="1210" class="nt">
     <tbody><tr><td height="35" style="padding-left:6px;"><a href="http://www.d1.com.cn/channel/list/A" target="_blank">A</a><a href="http://www.d1.com.cn/channel/list/B" target="_blank">B</a><a href="http://www.d1.com.cn/channel/list/C" target="_blank">C</a>
     <a href="http://www.d1.com.cn/channel/list/D" target="_blank">D</a><a href="http://www.d1.com.cn/channel/list/E" target="_blank">E</a><a href="http://www.d1.com.cn/channel/list/F" target="_blank">F</a>
     <a href="http://www.d1.com.cn/channel/list/G" target="_blank">G</a><a href="http://www.d1.com.cn/channel/list/H" target="_blank">H</a><a href="http://www.d1.com.cn/channel/list/I" target="_blank">I</a>
     <a href="http://www.d1.com.cn/channel/list/J" target="_blank">J</a><a href="http://www.d1.com.cn/channel/list/K" target="_blank">K</a><a href="http://www.d1.com.cn/channel/list/L" target="_blank">L</a>
     <a href="http://www.d1.com.cn/channel/list/M" target="_blank">M</a><a href="http://www.d1.com.cn/channel/list/N" target="_blank">N</a><a href="http://www.d1.com.cn/channel/list/O" target="_blank">O</a>
     <a href="http://www.d1.com.cn/channel/list/P" target="_blank">P</a><a href="http://www.d1.com.cn/channel/list/Q" target="_blank">Q</a><a href="http://www.d1.com.cn/channel/list/R" target="_blank">R</a>
     <a href="http://www.d1.com.cn/channel/list/S" target="_blank">S</a><a href="http://www.d1.com.cn/channel/list/T" target="_blank">T</a><a href="http://www.d1.com.cn/channel/list/U" target="_blank">U</a>
     <a href="http://www.d1.com.cn/channel/list/V" target="_blank">V</a><a href="http://www.d1.com.cn/channel/list/W" target="_blank">W</a><a href="http://www.d1.com.cn/channel/list/X" target="_blank">X</a>
     <a href="http://www.d1.com.cn/channel/list/Y" target="_blank">Y</a><a href="http://www.d1.com.cn/channel/list/Z" target="_blank">Z</a></td></tr>
 </tbody></table>
    </div>
    <p></p>
      <p></p><div><a href="http://www.hd315.gov.cn/beian/view.asp?bianhao=010202003031700010" target="_blank" rel="nofollow"><img src="http://images.d1.com.cn/homeimg07/wei_349.gif" width="45" height="50" border="0"></a><a id="___szfw_logo___" href="https://search.szfw.org/cert/l/CX20130321002326002808" target="_blank"><img src="http://images.d1.com.cn/images2013/index/cx.png?l=CX20130321002326002808"></a>
      <script type="text/javascript">(function(){document.getElementById('___szfw_logo___').oncontextmenu = function(){return false;}})();</script><a href="http://images.d1.com.cn/images2010/2010ec100.jpg" target="_blank" rel="nofollow"><img src="http://images.d1.com.cn/images2010/ceca.gif" width="117" height="42" border="0"></a><a href="http://images.d1.com.cn/images2010/dzxh91602_mwang.jpg" target="_blank" rel="nofollow"><img src="http://images.d1.com.cn/images2010/beca.gif" width="79" height="42"></a><a href="http://images.d1.com.cn/images2012/foot/2007_top100.jpg" target="_blank" rel="nofollow"><img src="http://images.d1.com.cn/homeimg07/top100_logo.gif" border="0"></a><a href="http://www.ectrustprc.org.cn/seal/splash/1000016.htm" target="_blank" rel="nofollow"><img src="http://images.d1.com.cn/homeimg07/redlogo.gif" border="0"></a><a href="http://trust.baidu.com/vcard/?id=6920f785ea1fceb7d927ff0fe3bb385a262d" target="_blank" rel="nofollow"><img src="http://images.d1.com.cn/images2014/index/baidulogo.jpg" border="0"></a><a  key ="530fef56af60046ff31d11c2"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org" ><script src="http://static.anquan.org/static/outer/js/aq_auth.js"></script></a></div><div style="line-height:30px;"> 京ICP证030072号&nbsp;&nbsp;京公网安备：110108905029 &nbsp;&nbsp;www.D1.com.cn Copyright 2002-2014 D1优尚网 版权所有</div>
<!-- <script type="text/javascript" src="/res/js/product/scrolltopcontrol.js?1.11"></script> -->
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<script type="text/javascript">


var the_s=new Array();
  var lasttime=0;
  function vms_time(endt,id){
		  var now = new Date().getTime();
		  lasttime = (endt - now)/1000;
		  //alert(lasttime+"===");
		  if(lasttime>0){
			  var the_D=Math.floor((lasttime/3600)/24)
		      var the_H=Math.floor((lasttime-the_D*3600*24)/3600);
			  if(the_H<10){
				  the_H='0'+the_H;
			  }
	          var the_M=Math.floor((lasttime-the_D*3600*24-the_H*3600)/60);
	          if(the_M<10){
	        	  the_M='0'+the_M;
			  }
	          var the_S=Math.floor((lasttime-the_H*3600)%60);
	          if(the_S<10){
	        	  the_S='0'+the_S;
			  }
	          $("#pmstime"+id).text(the_D+"天 "+the_H+"时"+the_M+"分"+the_S+"秒" );
	      }else{
	    	  $("#pmstime"+id).text("已结束");
	      }
 }
  
  $(document).ready(function() {
		
	    /*大图轮播*/
	     var roll_images=[<%= sbtt1219img.toString()%>];
		     var imgrollbg=['#fff','#fff','#fff','#fff','#fff','#fff','#fff','#fff'];
		 	 var bg = imgrollbg || null;
		 	<%if(pttlist.size() != 1){%>
		 	 new RollImage(roll_images, $("#imgRollOuterys"), $("#imgslideys>p>a"), null, $("#imgrollys .left"), $("#imgrollys .right"), bg).run(1);
		 	<%}%>
		 	 $("#imgrollys").hover(function (){
		 		<%if(pttlist.size() != 1){%><!-- 只有一张图片时，不执行 -->
					$(this).find(".left,.right").fadeIn();
			    <%}%>
			  },
			  function ()
			  {
				    $(this).find(".left,.right").fadeOut();
			  });       
			 
			 // initborder()
		 	  $(".imglist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
		 	  $(".main_div1").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });

			  
		});

  </script>
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-25292063-1']);
_gaq.push(['_addOrganic', 'soso', 'w']);
_gaq.push(['_addOrganic', 'sogou', 'query']);
_gaq.push(['_addOrganic', 'youdao', 'q']);
_gaq.push(['_addOrganic', 'baidu', 'word']);
_gaq.push(['_addOrganic', 'baidu', 'q1']);
_gaq.push(['_addOrganic', 'ucweb', 'keyword']);
_gaq.push(['_addOrganic', 'ucweb', 'word']);
_gaq.push(['_addOrganic', '114so', 'kw']);
_gaq.push(['_addIgnoredOrganic', 'd1']);
_gaq.push(['_addIgnoredOrganic', '优尚']);
_gaq.push(['_addIgnoredOrganic', '便利']);
_gaq.push(['_addIgnoredOrganic', '第一']);
_gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();


  var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
  document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5dfacc13f7a0db3139bbd6afe7dc3bef' type='text/javascript'%3E%3C/script%3E"));

</script><script src=" http://hm.baidu.com/h.js?5dfacc13f7a0db3139bbd6afe7dc3bef" type="text/javascript"></script>

</div>
    
</div>
<!-- 底部结束 -->

</div>

<script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
var TabbedPanels2 = new Spry.Widget.TabbedPanels2("TabbedPanels2");
var TabbedPanels3 = new Spry.Widget.TabbedPanels3("TabbedPanels3");
var TabbedPanels4 = new Spry.Widget.TabbedPanels3("TabbedPanels4");
var TabbedPanels5 = new Spry.Widget.TabbedPanels3("TabbedPanels5");
var TabbedPanels6 = new Spry.Widget.TabbedPanels3("TabbedPanels6");
var TabbedPanels7 = new Spry.Widget.TabbedPanels3("TabbedPanels7")
//-->
</script>
</body>
</html>
