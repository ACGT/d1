<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>
<%@include file="/html/public.jsp"%>
<%! 
/**
 * 获取新版女装页面大图锚点
 * @param code 推荐位号
 * @return
 */
private String getnewwomen(String code,int length)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				StringBuilder map=new StringBuilder();
				i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				sb.append("<div class=\"zymap\">");
				sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"  width=\"980\" height=\"400\" usemap=\"#map"+p.getId()+"\"/>");
				
				map.append("<map name=\"map").append(p.getId()).append("\" id=\"").append("map").append(p.getId()).append("\">");
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						left=pip.getPos_x()+10;
						if(left>400)
						{
							left=pip.getPos_x()-25;
						}
						top=pip.getPos_y()-35;
						int divtop=0;
						if(top+40>350)
						{
							divtop=350;
						}
						else
							divtop=top+40;
						
						map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\""); 
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
							map.append("href=\"").append("http://www.d1.com.cn/product/"+product.getId()).append("\" target=\"_blank\"");
						
						map.append(">");
				    }	
			    }
				
			    map.append("</map>");
				sb.append(map.toString());
				sb.append("</div>");
			}
		}
		return sb.toString();
	}
	
	return "";
			
}

//根据场景表里的搭配编号，获取搭配列表
private static ArrayList<Gdscoll> getGdscolllist(String gdscollid)
{
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	if(gdscollid==null||gdscollid.length()<=0)
	{
		return null;
	}
	gdscollid=gdscollid.replace('，', ',');
	String[] newstr=gdscollid.split(",");
	int j=0;
	for(int i=0;i<newstr.length;i++)
	{
		Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(newstr[i]);
		if(gdscoll!=null)
		{
			j++;
			if(j>15)
			{
				break;
			}
			list.add(gdscoll);
			
		}
	}
	
  return list;
	
}

%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>	D1优尚网-女性服饰、服装网上购物商城-女式服装，服饰，包包，鞋子全部正品、特价销售，假一罚二</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚女性服饰、服装饰品网上购物商城，确保正品，假一罚二，特价在线销售2000多种女性服装，服饰，免费订购电话400-680-8666" />
<meta name="keywords" content="女性服装 女士 女式服饰 网上购物 网上商城 网上超市 网上购买 服装 服饰 外套 针织衫 衬衫打底 半身裙 卫衣 T恤 连身裙 内衣吊带 休闲裤 女鞋包包 牛仔裤 韩版 围巾 靴子 连衣裙 职业 简约 复古 甜美 休闲 性感 混搭 " />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="Stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
.center{ width:980px; margin:0px auto;}
.nw_top{ width:980px; height:54px; margin:0px auto; margin-bottom:10px;}
.scrollimglist{ width:769px; height:335px; float:left }
.container{ overflow:hidden;  width:769px; height:335px; }
#CenterImg{overflow:hidden;padding:1px;}
#CenterImg img{ border:none;}
#ImgTable{table-layout:auto;}
#ImgTable tr td a img{margin:1px;margin-top:0px;padding:0px;}
#idNum{float:right;position:absolute;top:312px;right:18px;}
#idNum li{float:left;list-style:none;color: #000;text-align: center;line-height: 15px;width: 15px;height: 15px;	font-family:"寰蒋闆呴粦";font-size: 13px; font-weight:bold; cursor: pointer;margin: 2px;background:#f3f3f5;}
#idNum li.on{line-height: 15px;width: 17px;height: 16px;color:#fff;background:#8a2b3f;}
#content{width:350px; height:auto;}
#Category img{ width:160px; height:150px; margin:7px;}
#right{ float:left}
#right_1{ width:400px; float:left}
#right_2{ float:left}
#left{ float:left; margin:0 auto}
#bottom{ margin:0 auto; width:1000px;}
.zyw{ float:left; width:200px; margin-left:11px; _margin-left:8px; _margin-left:8px;height:335px;}
.zymap{ margin-top:10px;}
.cat{ background:#efefef; margin-top:10px; text-align:center; padding-bottom:20px;}
.ntbanner{background:url('http://images.d1.com.cn/images2012/2012dhbgw.gif'); width:980px; height:235px; overflow:hidden; margin-top:10px; }
.ntbanner td a font{ font-weight:bold;}
.ntbanner td ul{ list-style-image:url('http://images.d1.com.cn/images2012/nwtip.jpg'); text-align:left;  height:190px; margin-top:5px; margin-left:25px;}
.ntbanner td ul li{ margin-left:18px;}
.ntbanner td ul li a{ font-size:13px;}
.gdszy{ padding-top:10px; padding-bottom:10px;}
.ntt{  overflow:hidden; line-height:20px; padding-top:12px;
padding-left:10px; }
.ntt a{ color:#fae2ea; font-size:14px;  filter:Alpha(opacity=80); }
.ntt .font1{ color:#fae2ea; font-size:13px; font-family:'微软雅黑'; font-weight:bold}
.ntt .font2{ color:#fae2ea; font-size:13px; font-family:'微软雅黑'; text-decoration:line-through; }
.ngdlist ul{ margin:0px; padding:0px; list-style:none; over-flow:hidden;}
.ngdlist ul li{ margin-right:4px; float:left; width:240px; over-flow:hidden; height:362px; background:url('http://images.d1.com.cn/images2012/gdlistbg1.jpg'); border:solid 1px #ccc;  }
.gdlist{}
.newtab{position:fixed; _position:relative; +position:relative; top:0px; z-index:900000}
#nw_top{ width:980px; background:url('http://images.d1.com.cn/images2012/nwomentop_bg.gif'); width:980px; height:55px; overflow:hidden;}
#nw_top ul{ margin:0px; padding:0px; height:55px; overflow:hidden; margin-left:15px; }
#nw_top li{ float:left; margin-top:15px; margin-right:30px; }
.ntbanner font{ font-weight:bold;}
.newgdsscene{ width:980px; margin-top:10px; overflow:hidden; margin-bottom:10px;}
.newgdsscene ul{ padding:0px; list-style:none;}
.newgdsscene ul li{width:980px; height:531px; overflow:hidden;}
 .pricegd{  background:none;background-color: #fff;width:151px; height:225px;position:absolute; top:140px; left:140px; filter: alpha(opacity=80);-moz-opacity: 0.8;opacity: 0.8;  -moz-border-radius: 10px; -webkit-border-radius: 10px;  border-radius: 10px;
    }
    .pricegd span{margin:0px auto; width:100%; display:block; height:28px;  font-size:13px; line-height:33px;  color:#333;}
    .pricegd span font{font-family:'微软雅黑'; font-weight:bold; }
    .pricegd span .font1{ color:#be0000; }
    .pricegd span .font2{ color:#4e4e4e; }
    .pricegd .newspan{background:#be0000; color:#fff; font-family:'微软雅黑'; font-weight:bold; height:25px; line-height:25px;} 
    .gdscoll{width:980px; margin:0px auto; overflow:hidden; padding-top:10px; background:#e8a9b4; padding-bottom:10px;}
    .gdscoll ul{ margin:0px; padding:0px; list-style:none; padding-left:10px; padding-right:10px;}
    .gdscoll ul li{ position:relative; float:left; width:316px; height:380px; margin-right:6px; overflow:hidden; margin-bottom:10px;}
 
</style>

<script>

function check_gdscoll(obj,flag) {
	var pktsel = $(".a"+flag);
    if(pktsel.length < 1){
    	alert("没有任何组合商品！");
        return;
    }
   
    var arr = new Array();
    pktsel.each(function(i){
		arr[i] = $(this).val();
	});
   
    $(obj).attr('attr',arr.toString());
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gdscollInCart.jsp',width:600,align:'center'},{"code":$(obj).attr("code")});
}

$(document).ready(function(){
	   $(window).scroll(function(){
		   //alert($(window).scrollTop());
		   if($(window).scrollTop()>=155)
			   {
			      $('#nw_top').removeClass("nw_top");
			      $('#nw_top').addClass("newtab");
			   }
		   else
			   { 
			      $('#nw_top').removeClass("newtab");
			      $('#nw_top').addClass("nw_top");
			   }
	   });
   });
</script>
</head>

<body>
	<div id="wrapper">
		<!--头部-->
		<%@include file="../../inc/head.jsp" %>
		<!-- 头部结束-->
		<!-- 中间内容 -->
		
		
		<div class="center">
		<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
         <div class="nw_top" id="nw_top">
	      <img src="http://images.d1.com.cn/images2012/bgbgbg.gif" usemap="#maptc" style="position:absolute;margin-left:860px; width:120px; height:55px;"/>
	          <%=getTopCategory("2823",7) %>
	    
	    </div>
	     <div class="scrollimglist">
               
                <script>ShowCenter(<%= ScrollImg("2612") %>,<%= ScrollText("2612") %>)</script>
            
         </div>
        <%= Getnew2012Img("2824") %>
        
         <div class="clear"></div>
        
         
         <div class="newgdsscene">
         <%
              ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("3026", 2);
             if(list!=null&&list.size()>0)
             {
            	 out.print("<ul>");
            	 for(Promotion p:list)
            	 {
            		 if(p!=null)
            		 {%>
            			<li><a href="<%= StringUtils.encodeUrl(p.getSplmst_url()) %>" target="_blank">
            			<img src="<%= p.getSplmst_picstr() %>" width='980'; height='531'/>
            			</a></li> 
            		 <%}
            	 }
            	 out.print("</ul>");
             }
         
         %>
         </div>
         
          <%
          String codelist="";
          ArrayList<Promotion> lists=PromotionHelper.getBrandListByCode("3028", 1);
          if(lists!=null&&lists.size()>0)
          {         	 
         		 if(lists.get(0)!=null)
         		 {
         		    codelist=lists.get(0).getSplmst_name();
         		 %>
         			
         		 <%}
         }
          if(codelist.length()>0)
          {
           ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
           gdscolllist=getGdscolllist(codelist);  
           //System.out.print(gdscolllist.size());
           if(gdscolllist!=null&&gdscolllist.size()>0)
           { int count=0;%>
             <div class="gdscoll">
         
                <ul>
        	   <% for(Gdscoll gds:gdscolllist)
        	   {
        		   if(gds!=null&&gds.getGdscoll_flag().longValue()==1)
        		   { count++;
        		     if(count%3==0)
        		     {
        		    	 out.print( "<li style=\"margin-right:0px;\">");
        		     }
        		     else
        		     {
        		    	 out.print( "<li>");
        		     }%>
        			
        			 <div style=" width:316px; height:413px; overflow:hidden; background:url('http://images.d1.com.cn/images2012/index2012/womendpbg.jpg') repeat-x;">
        			    <a href="/gdscoll/index.jsp?id=<%= gds.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%= gds.getGdscoll_brandimg() %>" style="left:-60px; position:absolute; margin-top:22px;" /></a>
        			   <div style="float:right;"><font style="font-family:'微软雅黑'; font-size:18px; display:block; color:#929292; width:200px; margin-top:5px; margin-right:5px;"><b><%  out.print(gds.getGdscoll_title()); %></b></font></div>
        			 </div>
        			 
        			 
        			  <%  ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(gds.getId());
        			      if(gdlist!=null&&gdlist.size()>0)
        			      {
        			        float sum=0f;%>
        			    	   <div class="pricegd">
        			    	   <div style="width:95%; height:148px; margin:0px auto; overflow:hidden;">
        			    	   <%
        			    	     
        			    	       for(Gdscolldetail gd:gdlist)
        			    	       {
        			    	    	   Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
        			    	    	   if(p!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag().longValue()==1&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1)
        			    	    	   {
        			    	    		   
        			    	    		   sum+=Tools.getRoundPrice(p.getGdsmst_memberprice().floatValue());
        			    	    		   %>
        			    	    		   <span><a href="/product/<%= p.getId() %>" target="_blank" style="color:#333"><%= gd.getGdscolldetail_title() %></a>:<font class="font1">￥<%= (int)Math.ceil(p.getGdsmst_memberprice().floatValue())%></font>&nbsp;<font class="font2"><strike>￥<%= (int)Math.ceil(p.getGdsmst_saleprice().floatValue())%></strike></font></span>
        			    	    	        <input type='hidden' class="a<%=count %>" value="<%= p.getId() %>"/>
        			    	    	   <%}
        			    	       }
        			    	   %>
        			    	   </div>
        			    	    <div style="width:95%; height:55px; padding-top:0px; border-top:solid 1px #ccc;margin:0px auto;overflow:hidden;">
                                <span style=" color:#333;">&nbsp;&nbsp;<b>组合价：<font style='color:#f00'>￥<%= sum %></font></b></span>
                                 <span class="newspan" style="display:block; width:124px; height:28px; line-height:28px; margin:0px auto; text-align:center; margin-bottom:5px; ">
                <a href="javascript:void(0)" code="<%= gds.getId() %>" onclick="check_gdscoll(this,'<%= count %>')" style="color:#fff; font-size:14px;">立即组合购买>></a></span>
                               </div>
        			    	   </div>
        			      <%}
        			  %>
        			 </li>  
        		   <%}
        	   }
        	  %>
            	  </ul>
        	  </div>
           <%}
          }
       %>
         
  
         
         
         
         
         
         
         <div class="clear"></div>
         
         
         
         
         
         
         
         
         <div class="cat">
         
          <%=getnewdh("2827",3) %>
           <table class="ntbanner">
              <tr height="40"><td width="170"></td><td width="195" ><font style=" font-size:14px; color:#333;">热门</font>&nbsp;<font style=" font-size:12px; color:#7e7475;">HOT</font></td>
              <td width="148"><font style=" font-size:14px; color:#333;">上装</font>&nbsp;<font style=" font-size:12px; color:#7e7475;">TOPS</font></td>
              <td width="150"><font style=" font-size:14px; color:#333;">下装</font>&nbsp;<font style=" font-size:12px; color:#7e7475;">BOTTOMS</font></td>
              <td width="140"><font style=" font-size:14px; color:#333;">配饰</font>&nbsp;<font style=" font-size:12px; color:#7e7475;">ACC</font></td>
              <td><font style=" font-size:14px; color:#fff;">查看所有宝贝</font>&nbsp;<font style=" font-size:12px; color:#fff;">ALL</font></td></tr>
              <tr height="195">
              <td></td>
              <td><%= Getnew2012clist("2828")%></td>
              <td><%= Getnew2012clist("2829")%></td>
              <td><%= Getnew2012clist("2830")%></td>
              <td><%= Getnew2012clist("2832")%></td>
              <td>
              <%= Getnew2012clist("2833")%></td>
              </tr>
           </table>
           
         </div>
         <div class="gdlist">
             <%= Getnew2012ImgBig("2834")%>
            <%= Getnew2012glist("7552",8)%> 
            </div>
         <div class="clear"></div>
            <div class="gdlist">
             <%= Getnew2012ImgBig("2835")%>
             <%= Getnew2012glist("7553",8)%> 
         </div>
         <div class="clear"></div>
            <div class="gdlist">
             <%= Getnew2012ImgBig("2836")%>
             <%= Getnew2012glist("7554",8)%> 
         </div>
         <div class="clear"></div>
            <div class="gdlist">
             <%= Getnew2012ImgBig("2837")%>
             <%= Getnew2012glist("7555",8)%> 
         </div>
    </div>
	<div class="clear"></div>
		
		
		
		
		<!-- 中间内容结束 -->
		<!-- 尾部 -->
		<%@include file="/inc/foot.jsp" %>
		<!-- 尾部结束 -->
	</div>
	 <map name="maptc" id="maptc">
	            <area shape="rect" coords="0,0,120,55" href="http://www.d1.com.cn/result.jsp?productsort=017001&order=3" target="_blank">
	          </map>
</body>
</html>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script> 

