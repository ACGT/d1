<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<%!
public static  int getAwardUseLogByAwardid(String awardid)
{
	int result=0;
	    if(awardid.length()>0&&Tools.isNumber(awardid))
	    {
	    	ArrayList<AwardUseLog> rlist=new ArrayList<AwardUseLog>();
	    	
	    	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	    	clist.add(Restrictions.eq("scrchgawd_awardid",Tools.parseLong(awardid)));
	    	
	    	List<BaseEntity> list = Tools.getManager(AwardUseLog.class).getList(clist, null, 0, 100000);
	    	if(list!=null&&list.size()>0) result=list.size();
	    	
	    }


	return result;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网 - 积分兑换</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/jifen.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
<!--
function op(obj){
	if (window.confirm("确定要兑换此商品吗?一经兑换,不能恢复.")){
		addCart(obj);
	}
}
function addCart(obj){
	var gdsid=$(obj).attr("attr");
	var flags='';
	if($(obj).attr("flags")!=null&&$(obj).attr("flags").length>0)
		{
		flags=$(obj).attr("flags");
		}
	if(gdsid.indexOf(",")>0){
		var mid=$.trim($("#hmid").val());
		if(mid.length==0){
			Login_Dialog();
		}else{
		$.close(); 
		var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("选择商品颜色和尺码",450,"choosesku.jsp?flags="+flags);
		}
		}else{
	$.inCart(obj,{ajaxUrl:'/ajax/flow/listAwardInCart.jsp'});
	}
}
//-->
</script>
<style type="text/css" rel="stylesheet">
  .ss{font-weight:bold;font-size:27px; color:#ba1347; }
  #Header{z-index:1000;}
</style>
</head>
<body  BGCOLOR=#FFFFFF >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<style type="text/css" rel="stylesheet">
  #Header{z-index:1000;}
</style>
<!-- 头部结束 -->
<center>
<%
String mid="";
if(lUser!=null){
	mid=lUser.getId();
}
%>
<input type="hidden"  id="hmid" value="<%=mid%>"/>

<%if (lUser!=null) {%>
<div style=" margin-left:10px;">您当前的积分是：<span style="color: #EC5658;font-size: 16px;"><%=(int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %></span></div>
<%} %>

<table id="__01" width="920" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_01-1.jpg" width="920" height="79" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_02.jpg" width="920" height="86" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_03.jpg" width="920" height="63" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/yf2.jpg" width="920" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			
      <img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_05.jpg" width="638" height="39" alt=""/></td>
		<td>
			<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0104" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_06.jpg" width="282" height="39" alt=""></a></td>
	</tr>
<!--  
	<tr>
					<td width="312" height="312" style="background:url('http://images.d1.com.cn/images2012/index2012/oct/jifenbg.png')">
	        <table width="100%">
	            <tr><td colspan="3" width="312" height="170"><a href="#"  attr="1045,1046,1047,1048" flags="2012zq"  onclick="addCart(this);" style="display:block; width:312px; height:170px;">&nbsp;&nbsp;</a></td></tr>
	            <tr><td width="127" height="39"></td><td  height="39" width="80" align="center" class="ss">600</td><td width="105"></td></tr>
                <tr><td  height="39"></td><td  height="39" width="80" align="center" class="ss">9</td><td width="105"></td></tr>	        
 	            <tr><td colspan="3" height="57" align="center"> <div style="font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;">
 	           <%=6700+(getAwardUseLogByAwardid("1045")+getAwardUseLogByAwardid("1046")+getAwardUseLogByAwardid("1047")+getAwardUseLogByAwardid("1048"))*27+5 %>
 	            </span>人兑换！</div>
	       </td></tr>
 	        </table>
	       </td>
		
		
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/02103003" target="_blank"><img src="http://images.d1.com.cn/images2012/jifen/02103002-2.jpg" alt="" width="608" height="312" border="0"></a>
			</td>
	</tr>
-->
	<tr>
		
	        <td width="312" height="312" style="background:url('http://images.d1.com.cn/images2012/index2012/oct/jifenbg.png')">
	        <table width="100%">
	            <tr><td colspan="3" width="312" height="170"><a href="#"  attr="1016,1011" flags="mqyl1209ssb" onclick="addCart(this);" style="display:block; width:312px; height:170px;">&nbsp;&nbsp;</a></td></tr>
	            <tr><td width="127" height="39"></td><td  height="39" width="80" align="center" class="ss">300</td><td width="105"></td></tr>
                <tr><td  height="39"></td><td  height="39" width="80" align="center" class="ss"><%= 39 %></td><td width="105"></td></tr>	        
 	            <tr><td colspan="3" height="57" align="center"> <div style="font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;">
 	            <%=6700+(getAwardUseLogByAwardid("1016")+getAwardUseLogByAwardid("1011"))*27+5 %>
 	            </span>人兑换！</div>
	       </td></tr>
 	        </table>
	       </td>
	       	<td colspan="3">
			<a href="http://www.d1.com.cn/product/01720203" target="_blank"><img src="http://images.d1.com.cn/shopadmin/splimg/201210/01720203-2.jpg" alt="" width="608" height="312" border="0"></a>
			</td>
	</tr>

<tr>
		
	        <td width="312" height="312" style="background:url('http://images.d1.com.cn/images2012/index2012/oct/jifenbg.png')">
	        <table width="100%">
	            <tr><td colspan="3" width="312" height="170"><a href="###"  attr="1057,1059" flags="mqwyjf1210pda" onclick="addCart(this);" style="display:block; width:312px; height:170px;">&nbsp;&nbsp;</a></td></tr>
	            <tr><td width="127" height="39"></td><td  height="39" width="80" align="center" class="ss">500</td><td width="105"></td></tr>
                <tr><td  height="39"></td><td  height="39" width="80" align="center" class="ss"><%= 25 %></td><td width="105"></td></tr>	        
 	            <tr><td colspan="3" height="57" align="center"> <div style="font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;">
 	            <%=7100+(getAwardUseLogByAwardid("1057")+getAwardUseLogByAwardid("1011"))*31+6 %>
 	            </span>人兑换！</div>
	       </td></tr>
 	        </table>
	       </td>
	       	<td colspan="3">
			<a href="http://www.d1.com.cn/product/03200048" target="_blank"><img src="http://images.d1.com.cn/shopadmin/splimg/201211/yd1116.jpg" alt="" width="608" height="312" border="0"></a>
			</td>
	</tr>


	<%
	    ArrayList<Award> alist=AwardHelper.getAwardList();
	    ArrayList<Award> alists=new ArrayList<Award>();
	    if(alist!=null&&alist.size()>0)
	    {
	    	for(Award award:alist){
	    		

	    		if(award!=null&&Tools.parseInt(award.getId())!=1045&&Tools.parseInt(award.getId())!=1046&&Tools.parseInt(award.getId())!=1047&&Tools.parseInt(award.getId())!=1048&&Tools.parseInt(award.getId())!=1016&&Tools.parseInt(award.getId())!=1011
	    				&&Tools.parseInt(award.getId())!=36&&Tools.parseInt(award.getId())!=294 &&Tools.parseInt(award.getId())!=1057&&Tools.parseInt(award.getId())!=1059)
	    		{%>
	    			<tr>
	        <td width="312" height="312" style="background:url('http://images.d1.com.cn/images2012/index2012/oct/jifenbg.png')">
	        <table width="100%">
	            <tr><td colspan="3" width="312" height="170"><a href="#"  attr="<%= award.getId() %>" onclick="addCart(this);" style="display:block; width:312px; height:170px;">&nbsp;&nbsp;</a></td></tr>
	            <tr><td width="127" height="39"></td><td  height="39" width="80" align="center" class="ss"><%= award.getAward_value().longValue() %></td><td width="105"></td></tr>
                <tr><td  height="39"></td><td  height="39" width="80" align="center" class="ss"><%= award.getAward_price().floatValue() %></td><td width="105"></td></tr>	        
 	            <tr><td colspan="3" height="57" align="center"> <div style="font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;">
 	            <%
 	                 int r1=15+new Random().nextInt(5);
 	                 int r2=5000+new Random().nextInt(1000);
 	                 int sum=r2+getAwardUseLogByAwardid(award.getId())*r1+new Random().nextInt(10);
 	                 out.print(sum);
 	            %>
 	            </span>人兑换！</div>
	       </td></tr>
 	        </table>
	       </td>
	     <td colspan="3">
	     
	     <%  if(Tools.parseInt(award.getId())!=36&&Tools.parseInt(award.getId())!=294){ %>
	     <a href="http://www.d1.com.cn/product/<%= award.getAward_gdsid() %>" target="_blank">     
	     <img src="<%= award.getAward_bigimg()!=null?award.getAward_bigimg():"" %>" alt="" width="608" height="312" border="0">
	     </a>
	     <%}
	       else{
	    	
	    	 
	    	 
	    	 if(Tools.parseInt(award.getId())==36)
	    	 {%>
	    		 <img src="http://images.d1.com.cn/images2012/index2012/oct/jifenthirty.jpg" width="608" height="312" alt="">
	    	 <%}
	    	 else
	    	 {%>
	    		 <img src="http://images.d1.com.cn/images2012/index2012/oct/jifenfifty.jpg" width="608" height="312" alt="">
	    	<% }
	     
	        }
	     %>
	     </td>
	     </tr>	
	     <%
	        }
	    		
	    		if(Tools.parseInt(award.getId())==36||Tools.parseInt(award.getId())==294){
	    		    alists.add(award);	    		  
	    		}
	    	}
	    }
	    
	    if(alists!=null&&alists.size()>0)
	    {
	    	for(Award award:alists){
	    		if(award!=null)
	    		{%>
	    			<tr>
	        <td width="312" height="312" style="background:url('http://images.d1.com.cn/images2012/index2012/oct/jifenbg.png')">
	        <table width="100%">
	            <tr><td colspan="3" width="312" height="170"><a href="###"  attr="<%= award.getId() %>" onclick="addCart(this);" style="display:block; width:312px; height:170px;">&nbsp;&nbsp;</a></td></tr>
	            <tr><td width="127" height="39"></td><td  height="39" width="80" align="center" class="ss"><%= award.getAward_value().longValue() %></td><td width="105"></td></tr>
                <tr><td  height="39"></td><td  height="39" width="80" align="center" class="ss"><%= (int)award.getAward_price().floatValue() %></td><td width="105"></td></tr>	        
 	            <tr><td colspan="3" height="57" align="center"> <div style="font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;">
 	            <%
 	                 int r1=15+new Random().nextInt(5);
 	                 int r2=5000+new Random().nextInt(1000);
 	                 int sum=r2+getAwardUseLogByAwardid(award.getId())*r1+new Random().nextInt(10);
 	                 out.print(sum);
 	            %>
 	            </span>人兑换！</div>
	       </td></tr>
 	        </table>
	       </td>
	     <td colspan="3">
	     <%
	     if(Tools.parseInt(award.getId())==36)
    	 {%>
    		 <img src="http://images.d1.com.cn/images2012/index2012/oct/jifenthirty.jpg" width="608" height="312" alt="">
    	 <%}
    	 else
    	 {%>
    		 <img src="http://images.d1.com.cn/images2012/index2012/oct/jifenfifty.jpg" width="608" height="312" alt="">
    	<% }
     
	     %>
	     </td>
	     </tr>
	    		<%}
	    	}
	    }
	  
	%>	

	
	
	<tr>
		<td>
			<img src="images/分隔符.gif" width="312" height="1" alt=""></td>
		<td>
			<img src="images/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="images/分隔符.gif" width="325" height="1" alt=""></td>
		<td>
			<img src="images/分隔符.gif" width="282" height="1" alt=""></td>
	</tr>
</table>
<map name="Map"><area shape="rect" coords="754,119,911,146" href="http://www.d1.com.cn/help/helpnew.jsp?code=0104" target="_blank">
</map>
<!-- End ImageReady Slices -->
</center>
<%@include file="../inc/foot.jsp" %>
</body>
</html>