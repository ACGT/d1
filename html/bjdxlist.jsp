<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%!
//获取商品别表
private  String getProductlist(String code,int length)
{ 
if(!Tools.isMath(code)) return "";
ArrayList<PromotionProduct> plist = PromotionProductHelper.getPromotionProductByCode(code , length);

StringBuilder sb = new StringBuilder();
if(plist!=null&&plist.size()>0)
{
	int count=0;
	sb.append("<ul class=\"bjlist\">");
	for(PromotionProduct pp:plist){
		if(pp.getSpgdsrcm_gdsid()!=null)
		{
			Product goods=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			if(goods!=null&&goods.getGdsmst_validflag()!=null&&goods.getGdsmst_validflag().longValue()==1&&goods.getGdsmst_ifhavegds()!=null&&goods.getGdsmst_ifhavegds().longValue()==0)
			{
		  		count++;
		  		if(count>length){ break;}
		  		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		  		String ids = goods.getId();
		  		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
		  		long currentTimes = System.currentTimeMillis();
		  		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
		  		if(count%4==0)
		  		{
		  			sb.append("<li style=\"margin-right:0px;\">");
		  		}
		  		else
		  		{
		  		   sb.append("<li>");
		  		}
		  		sb.append("<div class=\"lf\">");
		  		sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
		  		sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
		  		sb.append("</a> ");
		  		sb.append("</p>");
		  		
		  		sb.append("<div style=\"background:#e1ddd6; width:240px;height:75px;padding:0px;\">");
		  		sb.append("<div style=\"font-size:12px;padding-left:5px;padding-right:5px;padding-top:3px; padding-bottom:0px;height:38px;\">");
		  		sb.append("<table style=\"height:38px;\">");
		  		sb.append("<tr><td valign=\"middle\">");
		  		sb.append(gnames);
		  		sb.append("</td></tr></table></div>");
		  		sb.append("<div style=\"font-size:12px;padding-left:5px;padding-right:5px;\"> ");
		  		sb.append("<table><tr><td valign=\"middle\"><span>会员价：￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice())+"&nbsp;&nbsp;</span></td>");
		  		sb.append("<td><span style=\"color:#d70200; font-weight:bold; font-size:18px;\">&nbsp;&nbsp;独享价：￥"+Tools.getFormatMoney(pp.getSpgdsrcm_tjprice())+"</span></td></tr>");
		  		sb.append("</table></div></div>");
		  		sb.append("</div>");
		  		sb.append("<div class=\"clear\"></div> "); 
		  		sb.append("</li>");
		  	 }
		}
	}
	
	sb.append("</ul>");    	
	
}
return sb.toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-白金独享商品</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<style type="text/css">
.center{ width:980px; margin:0px auto;}
.bjlist{ padding:5px;margin:0px; }
.bjlist li{ float:left;width:240px; overflow:hidden; margin-right:3px;height:380px;}
</style>
<script type="text/javascript">
function gettl(obj){
		 $.inCart(obj,{ajaxUrl:'/zhuanti/20130108bj750/gettl.jsp',width:450,align:'center'});
}
</script>
</head>
<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
<div class="center">
     <table width="980">
     <tr>
            <td>
                <img src="http://images.d1.com.cn/images2012/index2012/des/bjdxlogo.jpg"/>
            </td>
        </tr>
       
        <tr>
           <td style="background:#ccc">
           
           <%=getProductlist("8322",100)%>
           
           </td>
        </tr>
     </table>
	 <map name="Map" id="Map"><area shape="rect" coords="379,6,979,202" href="http://www.d1.com.cn/product/01205279" target="_blank" />
<area shape="rect" coords="14,4,372,199" href="###" attr="01205279" onclick="gettl(this)" /></map>
</div>

<div class="clear"></div>
<!--尾部-->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束-->

</body>
</html>