<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<%!
String getCol1pic(String minimst_col1pic ,String minimst_col1map){
	StringBuffer strbuffer=new StringBuffer();
	if(!Tools.isNull(minimst_col1pic)){
		strbuffer.append("<table width=980 border=0 cellpadding=0 cellspacing=0>");
		strbuffer.append("<tr>");
		strbuffer.append("<td align=center>");
		if(!Tools.isNull(minimst_col1map)){
			if(minimst_col1map.contains("area")){
				strbuffer.append("<map name=\"colmap1\">");
				strbuffer.append(minimst_col1map);
				strbuffer.append("</map>");
				strbuffer.append("<img src="+minimst_col1pic+" usemap=#colmap1 border=0>");
			}else{
				strbuffer.append("<a href=\""+minimst_col1map+"\"><img src=\""+minimst_col1pic+"\" border=0></a>");
			}
		}else{
			strbuffer.append(" <img src=\""+minimst_col1pic+"\">");
		}
		strbuffer.append("</td>");
		strbuffer.append("</tr>");
		strbuffer.append("</table>");
	}
	return strbuffer.toString();
}
%>


<%
 String id="986";
if(Tools.isNull(request.getParameter("id"))){
	out.print("<script>alert('您传的参数不正确！')</script>");
	return;
}else{
	id=request.getParameter("id");
}
Mini mini=(Mini)Tools.getManager(Mini.class).get(id);
if(mini!=null){
int minimst_style=mini.getMinimst_style().intValue();
int imgsize=120;
int evcount=5;
int minimst_colstyle=mini.getMinimst_colstyle().intValue();
if(minimst_colstyle==1){
	imgsize=120;
	evcount=5;
}
else if(minimst_colstyle==2){
	imgsize=200;
	evcount=4;
}
String topbgcolor="000000";
String topfontcolor="ffffff";
String  mainbgcolor="";
String mainfontcolor="";
String mainlinecolor="";
if(minimst_style==0){//绿色
	 mainbgcolor="009600";
	 mainfontcolor="ffffff";
	 mainlinecolor="009600";
}
else if(minimst_style==1){//黑白
	 mainbgcolor="ffffff";
	 mainfontcolor="333333";
	 mainlinecolor="333333";
}
else if(minimst_style==2){//粉红
	  mainbgcolor="ffffff";
	  mainfontcolor="EB236D";
	  mainlinecolor="EB236D";
}
else if(minimst_style==3){//浅绿
	  mainbgcolor="D3F8E9";
	  mainfontcolor="2F7A25";
	  mainlinecolor="2ECF68";
}
else if(minimst_style==4){//黄色
	  mainbgcolor="ffd800";
	  mainfontcolor="333333";
	  mainlinecolor="ffba00";
}
else if(minimst_style==5){//数码
	  mainbgcolor="D7d7d7";
	  mainfontcolor="444444";
	  mainlinecolor="d7d7d7";
}
else if(minimst_style==6){//蓝色
	  mainbgcolor="a1d3f3";
	  mainfontcolor="333333";
	  mainlinecolor="5cade2";
}
else if(minimst_style==7){//红色
	  mainbgcolor="ff3333";
	  mainfontcolor="ffffff";
	  mainlinecolor="ff3333";
}
String minimst_dtl=mini.getMinimst_dtl();
String minimst_tl=	mini.getMinimst_tl();
String minimst_tlmap=mini.getMinimst_tlmap();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=mini.getMinimst_name() %></title>
<meta name="description" content="<%=mini.getMinimst_description()%>">
<meta name="keywords" content="<%=mini.getMinimst_keywords()%>">
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="<%=mini.getMinimst_background()%>">
<!-- 头部开始 -->

<%@include file="/inc/head.jsp"%>
<%
 if(!Tools.isNull(minimst_dtl)){
	 %>
	 <%=minimst_dtl %>
 <%}else{
	 if(!Tools.isNull(minimst_tl)){
	%> 
	<table width=980 border=0 cellpadding=0 cellspacing=0 bgcolor=#ffffff align=center>
	<tr>
		<td align=center>
 <%
 if(!Tools.isNull(minimst_tlmap)){
	 if(minimst_tlmap.contains("area")){
		 %>
		 	<map name="tlmap1">
			<%=minimst_tlmap%>
			</map>
			<img src="<%=minimst_tl%>" usemap=#tlmap1 border=0>
	 <%}else{
		 %>
		 <a href="<%=minimst_tlmap%>"><img src="<%=minimst_tl%>" border=0></a>
	 <%}
 }else{
	 %>
	 <img src="<%=minimst_tl %>">
 <%}%>
 	</td>
	</tr>
</table>
	<% }}
if(!Tools.isNull(mini.getMinimst_detail())){
	%>
	<table width=980 border=0 cellpadding=0 cellspacing=0 bgcolor=#<%=mainbgcolor%>>
	<tr>
		<td align=center>
			<table width=970 border=0 cellpadding=0 cellspacing=0 align=center valign=center>
				<tr><td height=5></td></tr>
				<tr>
					<td style="border:1px #<%=mainfontcolor%> solid" align=center>
						<table border=0 width=920 cellpadding=0 cellspacing=0 align=center style="font-size:10.5pt;color=<%=mainfontcolor%>">
							<tr>
								<td><br><p style="line-height: 150%">
									<%=mini.getMinimst_detail().replace("\n","<br/>")%></p><br><br>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height=5></td>
	</tr>
</table>
<table width=750 height=3 border=0 cellpadding=0 cellspacing=0 bgcolor=#ffffff>
	<tr>
		<td></td>
	</tr>
</table>
<%}
%>
 <!--主推商品 begin-->
 <%
 ArrayList<MiniItem> minilist=MiniItemHelper.getByMstid(id);
 if(minilist!=null){
	 for(MiniItem item:minilist){
		 ArrayList<Product> plist=ProductHelper.getProductById(item.getMinidtl_gdsid());
		 if(plist!=null){
			 for(Product product:plist ){
			 String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
			 String mprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice().floatValue());
			 %>
			 <table width=980 border=0 cellpadding=0 cellspacing=0>
	<tr>
		<td bgcolor=#<%=mainlinecolor%> width=210 align=center valign=top>
			<table border=0 cellpadding=0 cellspacing=0>
				<tr>
					<td width=210 height=5 bgcolor=#<%=mainlinecolor%> colspan=3></td>
				</tr>
				<tr>
					<td width=5></td>
					<td width=200 bgcolor=#ffffff valign=top align=center>
					<a href="http://www.d1.com.cn/html/<%=item.getMinidtl_gdsid()%>.htm">
					<img src="<%=item.getMinidtl_pic1()%>" border=0></a>
					<%if(!Tools.isNull(item.getMinidtl_detail2())){%><table border=0 width=90% align=center><tr><td><p style="line-height: 150%"><font color=black style="font-size:9pt"><%=item.getMinidtl_detail2().replace("\n","<br/>")%></font></p></td></tr></table><%}%></td>
					<td width=5>
				</tr>
				<tr>
					<td width=210 height=5 bgcolor=#<%=mainlinecolor%> colspan=3></td>
				</tr>
			</table>
		</td>
		<td width=7 bgcolor=#ffffff></td>
		<td width=755 bgcolor=#ffffff style="border:1px #<%=mainlinecolor%> solid" align=center valign=top>
			<table border=0 cellpadding=0 cellspacing=0 style="font-size:9pt" width=730>
				<tr>
					<td><p style="line-height: 150%"><br><b><a href="http://www.d1.com.cn/html/<%=item.getMinidtl_gdsid()%>.htm"><font style="font-size:10.5pt" color=black><%=item.getMinidtl_gdsname()%></font></a></b>
					<%if(request.getParameter("np")==null){%>&nbsp;&nbsp;&nbsp;&nbsp;<font color=red style="font-size:10.5pt"><b><strike><font color=#666666>￥<%=sprice%></font></strike>&nbsp;-&gt;&nbsp;￥<font style="font-size:20pt"><%=mprice%></font></b></font><%}%><br><br><%=item.getMinidtl_detail1().replace("\n","<br/>")%></p></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!--3px间隔-->
<table width=980 height=3 border=0 cellpadding=0 cellspacing=0 bgcolor=#ffffff>
	<tr>
		<td></td>
	</tr>
</table>
<!--3px间隔-->
		 <% }
		 }
	 }
 }
 %>
 <!--主推商品 end-->
 <!--3px间隔-->
<table width=980 height=3 border=0 cellpadding=0 cellspacing=0 bgcolor=#ffffff>
	<tr>
		<td></td>
	</tr>
</table>
<!--3px间隔-->
<%
int colortype=mini.getMinimst_col1type().intValue();
int piclinenum=mini.getMinimst_col1linenum().intValue();
String col1rck=mini.getMinimst_col1rck();
String col1name=mini.getMinimst_col1name();
out.print(getCol1pic(mini.getMinimst_col1pic(),mini.getMinimst_col1map()));
out.print(gdsrcm1(col1rck,col1name, colortype, piclinenum, imgsize, evcount, request, id));

out.print(getCol1pic(mini.getMinimst_col2pic(),mini.getMinimst_col2map()));
colortype=mini.getMinimst_col2type().intValue();
piclinenum=mini.getMinimst_col2linenum().intValue();
col1rck=mini.getMinimst_col2rck();
col1name=mini.getMinimst_col2name();
out.print(gdsrcm1(col1rck,col1name, colortype, piclinenum, imgsize, evcount, request, id));

out.print(getCol1pic(mini.getMinimst_col3pic(),mini.getMinimst_col3map()));
colortype=mini.getMinimst_col3type().intValue();
piclinenum=mini.getMinimst_col3linenum().intValue();
col1rck=mini.getMinimst_col3rck();
col1name=mini.getMinimst_col3name();
out.print(gdsrcm1(col1rck,col1name, colortype, piclinenum, imgsize, evcount, request, id));

out.print(getCol1pic(mini.getMinimst_col4pic(),mini.getMinimst_col4map()));
colortype=mini.getMinimst_col4type().intValue();
piclinenum=mini.getMinimst_col4linenum().intValue();
col1rck=mini.getMinimst_col4rck();
col1name=mini.getMinimst_col4name();
out.print(gdsrcm1(col1rck,col1name, colortype, piclinenum, imgsize, evcount, request, id));

out.print(getCol1pic(mini.getMinimst_col5pic(),mini.getMinimst_col5map()));
colortype=mini.getMinimst_col5type().intValue();
piclinenum=mini.getMinimst_col5linenum().intValue();
col1rck=mini.getMinimst_col5rck();
col1name=mini.getMinimst_col5name();
out.print(gdsrcm1(col1rck,col1name, colortype, piclinenum, imgsize, evcount, request, id));

out.print(getCol1pic(mini.getMinimst_col6pic(),mini.getMinimst_col6map()));
colortype=mini.getMinimst_col6type().intValue();
piclinenum=mini.getMinimst_col6linenum().intValue();
col1rck=mini.getMinimst_col6rck();
col1name=mini.getMinimst_col6name();
out.print(gdsrcm1(col1rck,col1name, colortype, piclinenum, imgsize, evcount, request, id));
%>


<%@include file="/inc/foot.jsp"%>


</body>

</html>
<%}%>
<%!
String  gdsrcm1(String col1rck,String col1name,int colortype,int piclinenum,int imgsize,int evcount,HttpServletRequest request,String id){
	String fontcolor="a26800";
	String bgcolor="f7a60b";
	String font1color="";
	String fontcolor1="";
	String bg1color="";
	if(colortype==1){
		fontcolor="a26800";
		bgcolor="f7a60b";
	}
	else if(colortype==2){
	    fontcolor="83a200";
	    bgcolor="25abfe";
	}
	else if(colortype==3){
	    fontcolor="83a200";
	    bgcolor="b10d16";
	}
	else if(colortype==4){
	    fontcolor="fba432";
	    bgcolor="ffeecf";
	    font1color="db8412";
	}
	else if(colortype==5){
	    fontcolor="83a200";
	    bgcolor="e9fd98";
	}
	else if(colortype==6){
	    fontcolor="2eb0cd";
	    bgcolor="e9fdff";
	}
	else if(colortype==7){
	    fontcolor="db3096";
	    bgcolor="e9fdff";
	}
	else if(colortype==8){
	    fontcolor="04c3ff";
	    bgcolor="bde9ff";
	    font1color="0093df";
	}
	else if(colortype==9){
	    fontcolor="ff8305";
	    bgcolor="fcf1c2";
	    font1color="dd7000";
	}
	else if(colortype==10){
	    fontcolor="ff408b";
	    bgcolor="ffbfd8";
	    font1color="aa105b";
	}
	else if(colortype==11){
	    fontcolor="d131ac";
	    bgcolor="ffd4f3";
	    font1color="a1119c";
	}
	else if(colortype==12){
	    fontcolor="2ecf68";
	    bgcolor="d3f8e9";
	}
	else if(colortype==13){
	    fontcolor="666666";
	    bgcolor="eeefed";
	}
	else if(colortype==14){
	    fontcolor="000000";
	    bgcolor="B6A396";
	    fontcolor1="000000";
	}
	else if(colortype==15){
	    fontcolor="333333";
	    bgcolor="D70100";
	    bg1color="F8F8C9";
	    font1color="333333";
	}
	else if(colortype==20){
	    fontcolor="333333";
	    bgcolor="FFCCCC";
	    bg1color="F8F8C9";
	    font1color="333333";
	}
	else if(colortype==21){
	    fontcolor="333333";
	    bgcolor="000000";
	    bg1color="F8F8C9";
	    font1color="333333";
	}
	else{
	    fontcolor="333333";
	    bgcolor="ffffff";
	    bg1color="f0f0f0";
	    font1color="333333";
	}
	if(Tools.isNull(bg1color)){
		bg1color=bgcolor;
	}
	if(Tools.isNull(font1color)){
		font1color=fontcolor;
	}
	ArrayList<Product> list=new ArrayList<Product>();
	boolean bl=false;
	if(col1rck.contains("a") || col1rck.contains("b") || col1rck.contains("c")|| col1rck.contains("d")){
		bl=true;
		list=ProductHelper.getRealProductListForMini(col1rck, col1name);
	}else{
		list=ProductHelper.getProductListBySCode2(col1rck, col1name);
	}
	StringBuffer strbuffer=new StringBuffer();
	if(list!=null && list.size()>0){
		strbuffer.append("<table width=\"980\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" >");
		strbuffer.append("<tr align=\"center\"  height=20> <td width=10></td></tr></table>");
		int i=0;
		for(Product product:list){
			//if(i<piclinenum){
			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPromotionProductBySCodeGdsid(col1rck, col1name, product.getId());
			//String gdsname=Tools.substring(product.getGdsmst_gdsname(), 120);
			String gdsname=ProductHelper.getProductName(product.getGdsmst_gdsname(),100);
			
			String theimgurl="";
			String sprice= ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
			String tempstr1= ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice().floatValue());
			String oldprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
			String gdsmst_eyuan=ProductGroupHelper.getRoundPrice(product.getGdsmst_eyuan().floatValue());
			String url="/product/"+product.getId();
			String t=product.getGdsmst_layertype();
			String x=product.getGdsmst_layertitle();
			 request.setAttribute("t", t);
			 request.setAttribute("x", x);
			if(pproductlist!=null && pproductlist.size()>0){
				if(!Tools.isNull(pproductlist.get(0).getSpgdsrcm_otherimg())){
					//System.out.println("aaaaaaaaa");
					theimgurl=pproductlist.get(0).getSpgdsrcm_otherimg();
				}
				if(!Tools.isNull(pproductlist.get(0).getSpgdsrcm_layertype())){
					t=pproductlist.get(0).getSpgdsrcm_layertype();
					x=pproductlist.get(0).getSpgdsrcm_layertitle();
				}
				if(!Tools.isNull(pproductlist.get(0).getSpgdsrcm_otherlink())){
					url=pproductlist.get(0).getSpgdsrcm_otherlink();
				}
			}
			if(imgsize==200){
				//System.out.println("bbbbbbbbbbb");
				if(Tools.isNull(theimgurl)){
					theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
				}
			}else if(imgsize==120){
				//System.out.println("cccccccccc");
				if(Tools.isNull(theimgurl)){
					theimgurl="http://images.d1.com.cn"+product.getGdsmst_otherimg3();
				}
			}
			//System.out.println(theimgurl);
			String tdwidth=(1/((double)evcount))*100+"%";
			if((i+1)%evcount==1){
				strbuffer.append("<table width=\"980\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" >");
				strbuffer.append("<tr align=\"center\"  height=209> <td width=10></td>");
	
			}
			strbuffer.append("<td width=\""+tdwidth+"\" align=\"center\" valign=top><center>");
			if(imgsize==120){
				strbuffer.append("<table width=\"170\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"background:url('http://www.d1.com.cn/html/mini/images/sp_bg.gif') center top no-repeat;\">");
				strbuffer.append("<tr><td width=\"170\" align=\"center\" style=\"padding-top:5px;\">");
				if(bl){
					strbuffer.append("<center><a href=\""+url+"\"><img src=\""+theimgurl+"\" border=0></a></center>");
				}else{
					strbuffer.append("<center>");
					strbuffer.append("<a href="+url+"> <img src=\""+theimgurl+"\" border=0></a></center>");
				}
				strbuffer.append("</td></tr>");
				strbuffer.append("<tr><td align=\"center\" valign=\"middle\" style=\"padding-top:10px;\">");
				strbuffer.append("<font style=\"font-size:10pt\" color=\""+fontcolor+"\">");
				strbuffer.append(gdsname);
				if(product.getGdsmst_eyuan().floatValue()>0){
					strbuffer.append("<font color=red>");
					strbuffer.append("返"+gdsmst_eyuan+"元e券</font>");
				}
				strbuffer.append("</font><br>");
				strbuffer.append("<img src=\"http://www.d1.com.cn/homeimg07/huzhuang_254.gif\" /> <span class=\"yifu_hui\">");
				strbuffer.append("<strike>￥"+tempstr1+"</strike></span>&nbsp;&nbsp;");
				strbuffer.append("<img src=\"http://www.d1.com.cn/homeimg07/D1-price.gif\" width=\"15\" height=\"15\" />");
				strbuffer.append("<span class=\"yifu_th\">￥"+sprice+"</span>");
				strbuffer.append("</td></tr></table>");
			}
			else if(imgsize==200){
				strbuffer.append("<table width=\"220\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"background:url('http://www.d1.com.cn/html/mini/images/mini_bg2.gif') center top no-repeat;\">");
				strbuffer.append("<tr><td width=\"220\" align=\"left\" style=\"padding-top:2px ;padding-left:8px;\">");
			
				 strbuffer.append("<div style=\"position:relative;left;width:200px;height:200px;\">");
					strbuffer.append("<a href="+url+" target=_blank style='text-decoration:none'> <img src=\""+theimgurl+"\" border=0>");
				    strbuffer.append("<jsp:include page=\"/sales/showLayer.jsp\" flush=\"true\" />");
				    strbuffer.append("</a></div></td></tr>");
				    strbuffer.append("<tr><td align=\"center\" valign=\"middle\" style=\"padding-top:5px;\">");
				   // strbuffer.append("</a></div></td></tr>");
				    strbuffer.append("<font style=\"font-size:10pt;line-height:22px\" color=\""+fontcolor+"\">");
					strbuffer.append(gdsname);
					if(product.getGdsmst_eyuan().floatValue()>0){
						strbuffer.append("<font color=red>");
						strbuffer.append("返"+gdsmst_eyuan+"元e券</font>");
					}
					strbuffer.append("</font><br/><br/>");
					String zhongstr="566,862,841,874,875,885,887,890,914,757,452,917,924,928,931,934,938,952,967,969,983,985";
					if(zhongstr.contains(id)){
						strbuffer.append("<span style=\"font-size:12px;font-weight:bold;color:#666666;\"><strike>市场价:￥"+tempstr1+"</strike>&nbsp;&nbsp;老会员价:￥"+oldprice+"</span><br>");
						strbuffer.append("<img src=\"http://images.d1.com.cn/zt2010/0129cuxiao/zhong.gif\" width=\"36\" height=\"37\">");
						strbuffer.append("<span style=\"font-size:18px;font-weight:bold;color:#ff0000;\">");
						if(!id.equals("566")){
							strbuffer.append("秒杀价");
						}else{
							strbuffer.append("清仓价");
						}
						strbuffer.append(":￥</span><span style=\"font-size:21px;font-weight:bold;color:#ff0000;\">"+tempstr1+"</span>&nbsp;&nbsp;<br>");
						
					}else{
						strbuffer.append("<a href="+url+" target=_blank style='text-decoration:none'>");
						strbuffer.append("<span style=\"font-family:'Century Gothic';font-size:22px;	color:#941063;	letter-spacing:-1px;font-weight:bold;text-decoration:none;\">");
						strbuffer.append("￥</span><span style=\"font-family:'Century Gothic';font-size:22px;	color:#941063;	letter-spacing:-1px;font-weight:bold;text-decoration:none;\">");
						strbuffer.append(tempstr1+"</span>&nbsp;&nbsp;<span style=\"font-size: 12px;font-weight: bold;color: #666666;\"><strike>￥"+sprice+"</strike></span></a><br><br>");
					}
					strbuffer.append("<a href=# target=\"_blank\"><img src=\"http://images.d1.com.cn/images2011/sales/tm004.gif\" border=\"0\"></a>");
					strbuffer.append("</td></tr></table>");
			}
			//strbuffer.append("</td><td width=5>&nbsp;</td>");
			i++;
			 if(i==list.size() && i%evcount!=0){
				 for(int m=1;m<=evcount-(i%evcount);m++){
					 strbuffer.append("<td width=width=\""+tdwidth+"\"><center> <table border=0 width=95><tr><td>&nbsp;</td></tr></table></center></td><td width=5>&nbsp;</td>");
				 }
				 strbuffer.append("</td></tr></table>");
			 }
			 if(i%evcount==0){
				 strbuffer.append("</td></tr> <td width=5>&nbsp;</td></tr></table>");
				 strbuffer.append("<table width=\"980\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\"><tr height=10><td>&nbsp;</td></tr></table>");
			 }
		}
		//}
	
	}
	return strbuffer.toString();
}
%>