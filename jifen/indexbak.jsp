<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<%!
public static  int getAwardUseLogByAwardid(String awardid)
{
	int result=0;
	
	
	 
	    //System.out.print(str);
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
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
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
	$.inCart(obj,{ajaxUrl:'/ajax/flow/listAwardInCart.jsp'});
}
//-->
</script>
</head>
<body  BGCOLOR=#FFFFFF >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>


<%if (lUser!=null) {%>
<div style=" margin-left:10px;">您当前的积分是：<span style="color: #EC5658;font-size: 16px;"><%=(int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %></span></div>
<%} %>

<table id="__01" width="920" height="2844" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_01.jpg" width="920" height="79" alt=""></td>
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
	
	<tr>
		<td>
			 <a href="#"  attr="1021" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/ys4-1.jpg" width="312" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 6000+getAwardUseLogByAwardid("1021")*28+3 %></span>人兑换！</div>
			 </td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/02000396" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/ys3-1_1.jpg" alt="" width="608"  border="0"></a></td>
	</tr>
	<tr>
		<td>
			 <a href="#"  attr="1012" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_07.jpg" width="312" height="304" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 6000+getAwardUseLogByAwardid("1012")*28+3 %></span>人兑换！</div>
			 </td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/03000046" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_08.jpg" alt="" width="608" height="304" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="1011" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_09_1.jpg" width="312" height="312" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 5000+getAwardUseLogByAwardid("1011")*29+4 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01720202" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_10.jpg" alt="" width="608" height="312" border="0"></a>
				 </td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="1019" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jifen/ys2-2.jpg" width="312" height="310" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 9000+getAwardUseLogByAwardid("1013")*29+8 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01513205" target="_blank"><img src="http://images.d1.com.cn/images2012/jifen/ys1-1.jpg" alt="" width="608" height="310" border="0"></a>
			</td>
	</tr>

		<tr>
		<td>
			<a href="#"  attr="974" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_17.jpg" width="312" height="311" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 7000+getAwardUseLogByAwardid("974")*30+10 %></span>人兑换！</div>
	</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01516824" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_18.jpg" alt="" width="608" height="311" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="1006" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_15_1.jpg" width="312" height="312" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 7000+getAwardUseLogByAwardid("1006")*30+4 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01720843" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_16_1.jpg" alt="" width="608" height="312" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="1020" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jifen/ys4-1.jpg" width="312" height="311" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 7000+getAwardUseLogByAwardid("1017")*30+10 %></span>人兑换！</div>
	</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01717031" target="_blank"><img src="http://images.d1.com.cn/images2012/jifen/ys3-1.jpg" alt="" width="608" height="311" border="0"></a></td>
	</tr>
	
		<tr>
		<td>
			<a href="#"  attr="1023" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jifen/01517338-1.jpg" width="312" height="312" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 9000+getAwardUseLogByAwardid("1013")*29+8 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01517338" target="_blank"><img src="http://images.d1.com.cn/images2012/jifen/01517338-2.jpg" alt="" width="608" height="312" border="0"></a>
			</td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="1022" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jifen/01517339-1.jpg" width="312" height="312" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 9000+getAwardUseLogByAwardid("1013")*29+8 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01517339" target="_blank"><img src="http://images.d1.com.cn/images2012/jifen/01517339-2.jpg" alt="" width="608" height="312" border="0"></a>
			</td>
	</tr>
	
	<tr>
		<td>
			<a href="#"  attr="1024" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jifen/01516381-1.jpg" width="312" height="312" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 9000+getAwardUseLogByAwardid("1013")*29+8 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01516381" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/01516381-2.jpg" alt="" width="608" height="312" border="0"></a>
			</td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="36" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_19.jpg" width="312" height="313" alt=""/></a>
			 <div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-40px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 10000+getAwardUseLogByAwardid("36")*30+10 %></span>人兑换！</div>
		</td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_20a.jpg" width="608" height="313" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="#"  attr="294" onclick="addCart(this);"><img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_21.jpg" width="313" height="326" alt=""/></a>
			<div style="position:absolute; +position:relative; margin-left:50px; +margin-left:0px; margin-top:-55px; font-size:16px; color:#333; font-weight:bold;">已有<span style="color: #EC5658;font-size: 16px;"><%= 70000+getAwardUseLogByAwardid("294")*31+11 %></span>人兑换！</div>
		</td>
		<td colspan="2" rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_22.jpg" width="607" height="327" alt=""></td>
	</tr>

	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20120607JFDH/JFDH_23.jpg" width="313" height="1" alt=""></td>
	</tr>
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