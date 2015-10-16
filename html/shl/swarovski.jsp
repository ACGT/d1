<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%!
String getimglinkfl(String[] code){
	 ArrayList<Promotion> list2=PromotionHelper.getBrandList(code);
		StringBuffer str=new StringBuffer();
		if(list2!=null){
			for(int i=0;i<list2.size();i++){
				str.append(" <tr>");
				  str.append(" <td>");
				  str.append("<img src=\"http://images.d1.com.cn/images2010/shl/shlsqn_04.jpg\" width=\"206\" height=\"8\" >");
				  str.append(" </td>");
				  str.append(" </tr>");
				  str.append(" <tr>");
				  str.append(" <td background=\"http://www.d1.com.cn/html/shl/images/shlsqn_04.jpg\" width=\"206\" height=\"8\" align=\"center\">");
				  Promotion promotion=list2.get(i);
				  if(!Tools.isNull(StringUtils.encodeUrl(promotion.getSplmst_url()))){
						str.append("<a href=\""+StringUtils.encodeUrl(promotion.getSplmst_url())+"\" target=\"_blank\" title=\""+promotion.getSplmst_name()+"\">");
					}
					str.append("<img src=\""+promotion.getSplmst_picstr()+"\" >");
					if(!Tools.isNull(promotion.getSplmst_url())){
						str.append("</a>");
					}
					str.append(" </tr>");
			}
		}
		return str.toString();
}

String getimglinkcx(String[] code){
	 ArrayList<Promotion> list2=PromotionHelper.getBrandList(code);
		StringBuffer str=new StringBuffer();
		if(list2!=null){
			for(int i=0;i<list2.size();i++){
				str.append(" <tr>");
				  str.append(" <td>");
				  str.append("<img src=\"http://images.d1.com.cn/images2010/shl/shlsqn_14.jpg\" width=\"206\" height=\"8\" >");
				  str.append(" </td>");
				  str.append(" </tr>");
				  str.append(" <tr>");
				  str.append(" <td background=\"http://www.d1.com.cn/html/shl/images/shlsqn_14.jpg\" width=\"206\" height=\"8\" align=\"center\">");
				  Promotion promotion=list2.get(i);
				  if(!promotion.getSplmst_url().equals("#") ){
						str.append("<a href=\""+StringUtils.encodeUrl(promotion.getSplmst_url())+"\" target=\"_blank\" title=\""+promotion.getSplmst_name()+"\">");
					}
					str.append("<img src=\""+promotion.getSplmst_picstr()+"\"> ");
					if(!promotion.getSplmst_url().equals("#") ){
						str.append("</a>");
					}
					str.append(" </tr>");
			}
		}
		return str.toString();
}

String getimglinkjp(String[] code){
	 ArrayList<Promotion> list2=PromotionHelper.getBrandList(code);
		StringBuffer str=new StringBuffer();
		if(list2!=null){
			for(int i=0;i<list2.size();i++){
				
				  str.append(" <td width=\"380\">");
				  Promotion promotion=list2.get(i);
				  if(!promotion.getSplmst_url().equals("#") ){
						str.append("<a href=\""+StringUtils.encodeUrl(promotion.getSplmst_url())+"\" target=\"_blank\" title=\""+promotion.getSplmst_name()+"\">");
					}
					str.append("<img src=\""+promotion.getSplmst_picstr()+"\" style='margin-left:5px; margin-top:5px;'> ");
					if(!promotion.getSplmst_url().equals("#") ){
						str.append("</a>");
					}
					str.append(" </td>");
			}
		}
		return str.toString();
}

String getimglink(String[] code){
	 ArrayList<Promotion> list2=PromotionHelper.getBrandList(code);
		StringBuffer str=new StringBuffer();
		if(list2!=null){
			for(int i=0;i<list2.size();i++){
				
				  Promotion promotion=list2.get(i);
				  if(!promotion.getSplmst_url().equals("#") ){
						str.append("<a href=\""+StringUtils.encodeUrl(promotion.getSplmst_url())+"\" target=\"_blank\" title=\""+promotion.getSplmst_name()+"\">");
					}
					str.append("<img src=\""+promotion.getSplmst_picstr()+"\"  style='margin-left:3px; '");
					if(!promotion.getSplmst_url().equals("#") ){
						str.append("</a>");
					}
				
			}
		}
		return str.toString();
}
%>
<%response.sendRedirect("http://www.d1.com.cn"); %>
<html >
<head>
<title>施华洛世奇品牌专柜,全场1折起！施华洛世奇吊坠，施华洛世奇项链，施华洛世奇水晶，施华洛世奇奢华，施华洛世奇戒指，施华洛世奇情侣款，情人节特惠，新年礼物，璀灿奢华！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body>
<!-- 头部开始 -->
<center>
<%@include file="../../inc/head.jsp"%>
</center>
<!-- 头部结束 -->
<center>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td  width="208" valign="top" >
		   <!--左侧开始  -->
		  <table  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>      <table  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_02_2.jpg" width="206" height="68" alt=""></td>
        </tr>
		 <!--循环开始  -->
		   <%=getimglinkfl(new String[]{"1666"}) %>
		<!--循环结束  -->
      </table>
      <table  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_12.jpg" width="206" height="18" alt=""></td>
        </tr>
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_13_3.jpg" width="206" height="71" alt=""></td>
        </tr>
        <!--循环开始  -->
		
		<%= getimglinkcx(new String[]{"1667"})%>
		<!--循环结束  -->
		
      </table>
      <table  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_26_2.jpg" width="206" height="83" alt=""></td>
        </tr>
		  <!--循环开始  -->
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_30.jpg" width="206" height="17" alt=""></td>
        </tr>
		
		<TR>
                      <TD width=196 background="http://www.d1.com.cn/html/shl/images/shlsqn_30.jpg"
                      height=105 align="left" style="padding-right:10px;"><FONT style="PADDING-LEFT: 0px; line-height:26px; font-size:18px;" 
                        color=#373737 ><STRONG>施华洛世奇之</STRONG></FONT><FONT 
                        color=#002376 style="font-size:22px;"  ><STRONG>传奇</STRONG></FONT><BR><FONT 
                        style="PADDING-LEFT: 0px; text-align:left;font-size:12px; line-height:22px" 
                        color=#373737>百年历史，施华洛世奇成为水晶界优质、璀璨夺目、高度精确的化身，她的闪耀光茫闻名于世！</FONT></TD></TR>
        <tr>
          <td background="http://www.d1.com.cn/html/shl/images/shlsqn_30.jpg" ><img src="http://images.d1.com.cn/images2010/shl/shlsqn_32.jpg" width="206" height="24" alt=""></td>
        </tr>
		<!--循环结束  -->
		  <!--循环开始  -->
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_30.jpg" width="206" height="17" alt=""></td>
        </tr>
		
		<TR>
                      <TD width=196 background="http://www.d1.com.cn/html/shl/images/shlsqn_30.jpg"
                      height=105 align="left" style="padding-right:10px;"><FONT style="PADDING-LEFT: 0px; line-height:26px; font-size:18px;" 
                        color=#373737><STRONG>施华洛世奇之</STRONG></FONT><FONT 
                        color=#002376 style="font-size:22px;"><STRONG>独特</STRONG></FONT><BR><FONT 
                        style="PADDING-LEFT: 0px; text-align:left; font-size:12px; line-height:22px" 
                        color=#373737>最动人之处是她的纯净、独特切割以及刻面的编排和数目，以及这种璀璨光芒下灌注的精致文化。</FONT></TD></TR>
      
        <tr>
          <td background="http://www.d1.com.cn/html/shl/images/shlsqn_30.jpg" ><img src="http://images.d1.com.cn/images2010/shl/shlsqn_32.jpg" width="206" height="24" alt=""></td>
        </tr>
		<!--循环结束  -->
		<!--循环结束  -->
        <tr>
          <td><img src="http://images.d1.com.cn/images2010/shl/shlsqn_30.jpg" width="206" height="17" alt=""></td>
        </tr>
		
		<TR>
                      <TD width=196 background="http://www.d1.com.cn/html/shl/images/shlsqn_30.jpg"
                      height=105 align="left" style="padding-right:10px;"><FONT style="PADDING-LEFT: 0px; line-height:26px;font-size:18px;" 
                        color=#373737 size=3><STRONG>施华洛世奇之</STRONG></FONT><FONT 
                        color=#002376 style="font-size:22px;"><STRONG>工艺</STRONG></FONT><BR><FONT 
                        style="PADDING-LEFT: 0px; text-align:left;font-size:12px; line-height:22px" 
                        color=#373737>她的制品巧妙的打磨成数十个切面，对光线有极好的折射能力，整个水晶看起来格外耀眼夺目。</FONT></TD></TR>
		<!--循环结束  -->
        <tr>
          <td background="http://www.d1.com.cn/html/shl/images/shlsqn_30.jpg" ><img src="http://images.d1.com.cn/images2010/shl/shlsqn_32.jpg" width="206" height="24" alt=""></td>
        </tr>
      </table></td>
        </tr>
      </table>
      <!--左侧结束  -->
		 	  </td>
          <td width="772" valign="top" >
		   <!--右侧开始  --> 
		   <table border="0" cellpadding="0" cellspacing="0">
             <tr>
               <td><%= getimglink(new String[]{"1669"})%></td>
             </tr>
			  <tr>
               <td width="772" height="41" align="left" background="http://www.d1.com.cn/html/shl/images/shlsqn_09.jpg" style="background-repeat:no-repeat; color:#00247b; padding-top:4px; padding-left:30px; font-size:16px;"><strong>施华洛世奇 · 精品推荐</strong></td>
             </tr>
           </table>
		   
		   
		   
		   <table  border="0" cellspacing="0" cellpadding="0">
             <tr>
			 <%= getimglinkjp(new String[]{"1668"})%>
             </tr>
           </table>
		   
		   <table  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td background="http://www.d1.com.cn/html/shl/images/shlsqn_09.jpg" width="772" height="41" align="left" style="background-repeat:no-repeat; color:#00247b; padding-top:4px; padding-left:30px; font-size:16px;" ><strong>施华洛世奇 · 新品上市</strong></td>
             </tr>
           </table>
		   
		    <table  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td background="http://www.d1.com.cn/html/shl/images/shlsqn_19.jpg" width="774" >
                 <%  request.setAttribute("code", "3847");%>
			<jsp:include   page= "../../sales/showlist3.jsp"   />   
           
               </td>
             </tr>
           </table>
		    <table  border="0" cellpadding="0" cellspacing="0">
             <tr>
               <td><%= getimglink(new String[]{"1670"})%></td>
             </tr>
			  <tr>
               <td  background="http://www.d1.com.cn/html/shl/images/shlsqn_09.jpg"  width="772" height="41" align="left" style="background-repeat:no-repeat; color:#00247b; padding-top:4px; padding-left:30px; font-size:16px;"><strong>施华洛世奇 · 热卖推荐</strong></td>
             </tr>
           </table>
		   <table  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td background="http://www.d1.com.cn/html/shl/images/shlsqn_19.jpg" width="774" >
                   <%  request.setAttribute("code", "3848");%>
			<jsp:include   page= "../../sales/showlist3.jsp"   />   </td>
             </tr>
           </table>
		   
		   	  </td>
        </tr>
      </table></td>
  </tr>
</table>
</center>
<%@include file="../../inc/foot.jsp"%>
</body>
</html>
