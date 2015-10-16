<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!

public static String getmslist(String code){
	StringBuilder sb=new StringBuilder();
	List<PromotionProduct>  pplist= PromotionProductHelper.getPromotionProductByCode(code);
	
	if(pplist!=null&&pplist.size()>0){
		int i=0;
		for(PromotionProduct pp:pplist){
			 String gdsid=pp.getSpgdsrcm_gdsid();
			    Product p=ProductHelper.getById(gdsid);
			    String theimgurl=ProductHelper.getImageTo400(p);
			
				String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());

				 float oldmemprice=p.getGdsmst_saleprice().floatValue();
				 float memprice=p.getGdsmst_memberprice().floatValue();
					if(CartHelper.getmsflag(p)){
						memprice=p.getGdsmst_msprice().floatValue();
				 }
					String cls="";
					if(i!=0&&(i+1)%3==0){
						cls="r";
					}
					int mcount=pp.getSpgdsrcm_tjprice().intValue();
			sb.append("<li class=\""+cls+"\">");
			sb.append("<div class=\"msitem\">");
			sb.append("    	<div class=\"top\">");
			sb.append("    	  <span class=\"pic\"><a href=\"/product/").append(gdsid).append("\" target=\"_blank\" class=\"title\" alt=\"").append(imgalt).append("\">");
			sb.append("    <img src=\"").append(theimgurl).append("\" width=300 height=300 />");
			sb.append("  </a>  <span class=\"price\">");
			sb.append("             	秒杀价<br />￥<i>").append(memprice).append("</i>");
			sb.append(" </span></span>");
			sb.append("          <span class=\"title\">");
			sb.append(" <a href=\"/product/").append(gdsid).append("\" target=\"_blank\" class=\"title\" alt=\"").append(imgalt).append("\">").append(imgalt).append("</a>");
			sb.append("           </span></div>");
			sb.append("       <div class=\"bottom\">");
			sb.append(" <div class=\"l\">");
			sb.append("<span class=\"market\">");
			sb.append(" <s>市场价:").append(oldmemprice).append("元</s>");
			sb.append(" </span> <span class=\"xl\">");
                           
			sb.append(" 限量:<font color=\"#fce933\">").append(mcount).append("件</font>");
			sb.append("</span> </div> <div class=\"r\">");
			sb.append("<a href=\"/product/").append(gdsid).append("\" target=\"_blank\" class=\"title\" alt=\"").append(imgalt).append("\"><img src=\"http://images.d1.com.cn/zt2014/06/msbut.png\" /></a>");
			sb.append("</div></div> </div></li> ");
i++;
		}
	}
	
return sb.toString();
}
public static String getbrandlist(String code){
	StringBuilder sb=new StringBuilder();
	List<Promotion>  pplist= PromotionHelper.getBrandListByCode(code, 100);
	
	if(pplist!=null&&pplist.size()>0){
		int i=0;
		for(Promotion pp:pplist){
			String cls="";
			if(i!=0&&(i+1)%4==0){
				cls="r";
			}

	       sb.append("<li class=\""+cls+"\">");
			sb.append("<a href=\"").append(pp.getSplmst_url()).append("\" target=\"_blank\" class=\"title\" >");
			sb.append("<img src=\""+pp.getSplmst_picstr()+"\" />");
			sb.append("</a></li>");
			i++;
		}
	}
	return sb.toString();
}
public static String getzxlist(String code){
	StringBuilder sb=new StringBuilder();
	List<PromotionProduct>  pplist= PromotionProductHelper.getPromotionProductByCode(code);
	
	if(pplist!=null&&pplist.size()>0){
		int i=0;
		for(PromotionProduct pp:pplist){
			 String gdsid=pp.getSpgdsrcm_gdsid();
			    Product p=ProductHelper.getById(gdsid);
			    String theimgurl=ProductHelper.getImageTo200(p);
			
				String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());

				float oldmemprice=p.getGdsmst_saleprice().floatValue();
				float memprice=p.getGdsmst_memberprice().floatValue();
					if(CartHelper.getmsflag(p)){
						memprice=p.getGdsmst_msprice().floatValue();
				 }
					String cls="";
					if(i!=0&&(i+1)%4==0){
						cls="r";
					}

			sb.append("<li class=\""+cls+"\">");
			sb.append("<div class=\"zxitem\"><a href=\"/product/").append(gdsid).append("\" target=\"_blank\" class=\"title\" alt=\"").append(imgalt).append("\">");
			sb.append("	<img src=\"").append(theimgurl).append("\" width=200 height=200 />");
			sb.append("</a><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"tb\">");
			sb.append("		<tr>");
			sb.append("		<td colspan=\"2\" height=\"50\" align=\"left\">");
			
			sb.append("	<span class=\"stitle\"><a href=\"/product/").append(gdsid).append("\" target=\"_blank\" class=\"title\" alt=\"").append(imgalt).append("\">").append(imgalt).append("</a></span></td>");
			sb.append("		</tr><tr>");
			sb.append("<td height=\"20\" align=\"left\">市场价:￥<s>").append(oldmemprice).append("</s></td>");
			sb.append("<td rowspan=\"2\" width=\"60\" align=\"center\"><a href=\"/product/").append(gdsid).append("\" target=\"_blank\" class=\"buygo\">立即<br />购买</a></td>");
			sb.append("</tr><tr>");
			sb.append("<td height=\"30\" align=\"left\"><span class=\"cxprice\">促销价:￥").append(memprice).append("</span></td>");
			sb.append("</tr></table></div></li>");

			i++;
		}
	}
	
return sb.toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>年中大促页面效果</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript"  src="/res/js/jquery-1.3.2.min.js"></script>
</head>
<style type="text/css">
.banner328 {
background-image: url(http://images.d1.com.cn/zt2014/06/banner.jpg);
background-repeat: no-repeat;
background-position: center;
height: 420px;
}
	.mslist{margin-bottom:10px}
	.mslist li{ float:left;width:320px;padding-right:10px;margin-top:10px;}
	.mslist li.r{float:right;padding-right:0;}
	.mslist li .msitem{border:1px solid #b73331;text-align:center;}
	.mslist li .msitem .top{padding:0 9px;}
	.mslist li .msitem .bottom{padding:0 9px;background:url(http://images.d1.com.cn/zt2014/06/bottombg.png);height:60px;padding-top:15px;}
	.mslist li .msitem .top .pic{display:block;width:300px;height:300px;position:relative;}
	.mslist li .msitem .top .pic .price{position:absolute;right:0;top:0;background:url(http://images.d1.com.cn/zt2014/06/price.png) no-repeat;width:98px;height:60px;display:block;color:#fff;font-size:16px;font-family:微软雅黑;text-align:center;}
	.mslist li .msitem .top .pic .price i{font: bold 16px Verdana;}
	.mslist li .msitem .top .title{display:block;height:50px;line-height:23px;}
	.mslist li .msitem .top .title a{font-size:12px;color:#505050; text-decoration:none;}
	.mslist li .msitem .bottom .l{width:170px;float:left;text-align:left;color:#fff;}
	.mslist li .msitem .bottom .l span{display:block;}
	.mslist li .msitem .bottom .l .market{font-size:12px;height:22px;}
	.mslist li .msitem .bottom .l .xl{font-size:25px;height:35px;line-height:30px; font-weight:800;}
	.mslist li .msitem .bottom .r{width:120px;float:right;}
	
	.zxtxt{margin-bottom:10px}
	.zxtxt .zxtitle{height:50px;background:#a02786;}
	.zxtxt .zxtitle a{width:245px;float:left;dispaly:block;color:#f2f685;height:50px;font-size:24px;font-family:微软雅黑;line-height:50px;text-align:center;text-decoration:none;}
	.zxtxt .zxtitle a.cur{background:#fff;color:#a02786;}

    .zxlist li{ float:left;width:239px;padding-right:8px;margin-top:10px;}
	.zxlist li.r{float:right;padding-right:0;}
	.zxlist li .zxitem{border:1px solid #d6d6d6;text-align:center;padding-left:10px;}
	.cxprice{color:#ab2d1f;font-size:20px;font-family:微软雅黑;}
	.buygo{width:60px;height:46px;display:block;background:#ab2d1f;color:#fff;font-size:16px;text-align:center;padding:7px 0;line-height:23px;}
	.tb {font-size:12px;color:#868686;}
	.stitle{max-height:50px;overflow:hidden;line-height:24px;width:100%;height:50px;display:block;}
	.tb .title{font-size:12px;color:#505050; text-decoration:none;}
	
	 .brandlist li{ float:left;width:239px;padding-right:8px;margin-top:10px;}
	.brandlist li.r{float:right;padding-right:0;}
	.brandlist li img{border:1px solid #d6d6d6;}
</style>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="banner328">

</div>
<table id="__01" width="980"  align="center" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/06/nzdc_01.jpg" width="980" height="60" alt=""></td>
	</tr>
	<tr>
		<td>
        	<div class="mslist">
            	<ul>
           <%=getmslist("9339")%>
                </ul>
                <div class="clear"></div>
            </div>
			</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/06/nzdc_03.jpg" width="980" height="111" alt=""></td>
	</tr>
	<tr>
		<td>
			<div class="zxtxt">
            	<div class="zxtitle">
                    	<a class="cur" attr="1" href="javascript:void(0)">美妆明星款</a><a attr="2" href="javascript:void(0)">男装劲爆抢购</a><a attr="3" href="javascript:void(0)">女装潮流狂欢价</a><a attr="4" href="javascript:void(0)">时尚家居最给力</a>
                </div>
                <div class="zxlist" id="zxlist1">
            		<ul>
                		  <%=getzxlist("9340")%>
              	  </ul>
                 </div>
                 <div class="zxlist" id="zxlist2" style="display:none;">
            		<ul>
                		  <%=getzxlist("9341") %>
              	  </ul>
                 </div>
                 <div class="zxlist" id="zxlist3" style="display:none;">
            		<ul>
                		  <%=getzxlist("9342") %>
              	  </ul>
                 </div>
                 <div class="zxlist" id="zxlist4" style="display:none;">
            		<ul>
                		  <%=getzxlist("9343") %>
              	  </ul>
                 </div>
            </div>
            
            </td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2014/06/nzdc_05.jpg" width="980" height="60" alt=""></td>
	</tr>
	<tr>
		<td>
        <div class="brandlist">
        	<ul>
                <%=getbrandlist("3698") %>
                </ul>
            </div></td>
	</tr>
</table>
<script language="javascript">
$(".zxtitle>a").mouseover(function() {
	$(".zxtitle>a").removeClass("cur");
	$(this).addClass("cur");
	var corder=$(this).attr('attr');
	$(".zxlist").hide();
	$("#zxlist"+corder).show();
	});

</script>
<!-- End ImageReady Slices -->
</body>
</html>