<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!


static ArrayList<BuyLimit> getBuyLimit(){
	ArrayList<BuyLimit> rlist = new ArrayList<BuyLimit>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	
	
	clist.add(Restrictions.ge("id","150"));
    clist.add(Restrictions.le("id","152"));
//	clist.add(Restrictions.eq("gdsbuyonemst_gdsid", gdsid));
	clist.add(Restrictions.le("gdsbuyonemst_starttime", new Date()));
	clist.add(Restrictions.ge("gdsbuyonemst_endtime", new Date()));
	//加入排序条件
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("gdsbuyonemst_createtime"));
	
	List<BaseEntity> list = Tools.getManager(BuyLimit.class).getList(clist, olist, 0, 100);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((BuyLimit)be);
	}
	return rlist ;
}
//04000911  01205480 01205490
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>注册D1优尚网会员即可免费领取精美豪礼-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<style type="text/css">
.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; }
.newlist ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; margin-bottom:20px;  }
.newlist p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding-top:7px; background-color:#f0f0f0; over-flow:hidden; }

</style>
<script type="text/javascript">
function jginCart(obj){
	 <%
	 if(lUser==null){
	 %>
	 $.close(); 	Login_Dialog("index.jsp");
			<%}else{%>
		$.close(); 
$.inCart(obj,{ajaxUrl:'jgincart.jsp',width:450,align:'center'});
		<%}%>
 
}

function $getid(id)
{
    return document.getElementById(id);
}

function view_time2(the_s_index,objid){
	 if(the_s1[the_s_index]>=0){
        var the_D=Math.floor((the_s1[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s1[the_s_index]-the_D*24*3600)/3600);
        var the_M=Math.floor((the_s1[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s1[the_s_index]-the_H*3600)%60;
        html = "";
        //if(the_D!=0) html += '<em>'+the_D+"</em>天";
        if(the_D!=0 || the_H!=0) html += '<em>'+((the_D*24)+(the_H))+"</em>";
        else {html += '<em>0</em>';}
        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<em>'+the_M+"</em>";
        else
        	{
        	html += '<em>0</em>';
        	}
        html += '<em>'+the_S+"</em>";
        $getid(objid).innerHTML = html;
        the_s1[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "抢购已开始！";
    }
}
	

	//限时抢购
	var the_s=new Array();
	function view_time(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
	        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = "<img src=\"http://images.d1.com.cn/images2012/timer.jpg\"/> 剩余时间：";
	        if(the_D!=0) html += '<em>'+the_D+"</em>天";
	        if(the_D!=0 || the_H!=0) html += '<em>'+(the_H)+"</em>小时";
	        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<em>'+the_M+"</em>分";
	        html += '<em>'+the_S+"</em>秒";
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }else{
	        $getid(objid).innerHTML = "已结束";
	    }
	}

</script>
<style type="text/css">
body {
	background-color: #ffffff;
	background-image: url(http://images.d1.com.cn/market/1403/xinke/dianqing.jpg);
	background-repeat: no-repeat;
	background-position: center top;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.center{ width:980px; margin:0px auto; background-color:#f5f5f5; padding-top:10px;}
ul{ padding:0px; margin:0px; list-style:none;}
.wul{ overflow:hidden;}
.wul li{ width:326px; border-right:dashed 1px #c4c4c4; float:left; margin-bottom:25px; height:430px; overflow:hidden;}
.wul .oli{ width:324px; border:none;  float:left; padding-bottom:5px;}
.wul li div{ border:solid 1px #c4c4c4; width:278px; margin:0px auto; text-align:center; background-color:#fff; z-index:80;}
img{ border:none;}
.wul .pricedisplay{ background-color:#f5f5f5;border:none;}
.nul{ padding-top:3px;}
.newtable{ width:278px; font-size:12px; color:#000;}
.wul li a { color:#626262; font-size:15px; font-weight:bold; font-family:'微软雅黑'; text-decoration:none; line-height:18px;}
.wul li a:hover{ text-decoration:underline;} 
.newtable td em{ text-decoration:none; color:#ce0000; font-weight:bold;}
.newtable td img{vertical-align:text-bottom; }
.posa{ margin-left:-26px;  margin-left:-23px\0; _position:absolute ; _margin-left:-154px;  +position:absolute ; +margin-left:-152px; }
.posa img{ display: inline-block;}
.td1{text-align:left; line-height:18px; padding-left:3px; }
.td2{ text-align:right; padding-right:2px;}
.newtable td span{ font-size:45px; line-height:55px; color:#fff;  position:absolute;  font-family:'微软雅黑'; margin-left:-270px; _margin-left:-140px; +margin-left:-140px; margin-top:-5px;}
.newtable td span font{  font-size:35px;}
.wul li .tdiv{  width:280px; margin:0px auto; text-align:left; border:none; background-color:#f5f5f5; padding-top:3px; }
table .font{ color:#ce0000; font-weight:bold; font-size:19px; font-family:'微软雅黑'}
</style>

<style type="text/css" >
.ms span em{display:block; float:left; width:61px; height:33px; text-align:left;}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>

<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" id="__01">
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/register.jsp" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_01.jpg" alt="" name="dianqing_01" width="980" height="426" border="0" id="dianqing_01" /></a></td>
  </tr>
	<tr>
		<td colspan="6">
			<img id="dianqing_02" src="http://images.d1.com.cn/market/1403/xinke/dianqing_02.jpg" width="980" height="67" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2">
	    <a href="http://www.d1.com.cn/product/01205490" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_03.jpg" alt="" width="330" height="366" border="0" usemap="#dianqing_03Map" id="dianqing_03" /></a></td>
		<td colspan="2">
	    <a href="http://www.d1.com.cn/product/04000911" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_04.jpg" alt="" width="321" height="366" border="0" usemap="#dianqing_04Map" id="dianqing_04" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01205480" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_05.jpg" alt="" width="329" height="366" border="0" usemap="#dianqing_05Map" id="dianqing_05" /></a></td>
	</tr>
	<tr>
		<td colspan="6">
			<img id="dianqing_06" src="http://images.d1.com.cn/market/1403/xinke/dianqing_06.jpg" width="980" height="74" alt="" /></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01205458?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_07.jpg" alt="" width="247" height="294" border="0" id="dianqing_07" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01205398?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_08.jpg" alt="" width="243" height="294" border="0" id="dianqing_08" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01205396?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_09.jpg" alt="" width="242" height="294" border="0" id="dianqing_09" /></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01205428?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_10.jpg" alt="" width="248" height="294" border="0" id="dianqing_10" /></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01414625?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_11.jpg" alt="" width="247" height="295" border="0" id="dianqing_11" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01409954?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_12.jpg" alt="" width="243" height="295" border="0" id="dianqing_12" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01414673?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_13.jpg" alt="" width="242" height="295" border="0" id="dianqing_13" /></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01417384?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_14.jpg" alt="" width="248" height="295" border="0" id="dianqing_14" /></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01205425?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_15.jpg" alt="" width="247" height="296" border="0" id="dianqing_15" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01205400?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_16.jpg" alt="" width="243" height="296" border="0" id="dianqing_16" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/03000779?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_17.jpg" alt="" width="242" height="296" border="0" id="dianqing_17" /></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/02002019?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_18.jpg" alt="" width="248" height="296" border="0" id="dianqing_18" /></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01713447?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_19.jpg" alt="" width="247" height="294" border="0" id="dianqing_19" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01720190?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_20.jpg" alt="" width="243" height="294" border="0" id="dianqing_20" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/02000773?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_21.jpg" alt="" width="242" height="294" border="0" id="dianqing_21" /></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/03000152?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_22.jpg" alt="" width="248" height="294" border="0" id="dianqing_22" /></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01517877?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_23.jpg" alt="" width="247" height="298" border="0" id="dianqing_23" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01512997?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_24.jpg" alt="" width="243" height="298" border="0" id="dianqing_24" /></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/03300070?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_25.jpg" alt="" width="242" height="298" border="0" id="dianqing_25" /></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/03200077?tj=mqbyzx1312" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_26.jpg" alt="" width="248" height="298" border="0" id="dianqing_26" /></a></td>
	</tr>
	<tr>
		<td colspan="6">
			<img id="dianqing_27" src="http://images.d1.com.cn/market/1403/xinke/dianqing_27.jpg" width="980" height="76" alt="" /></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_28.jpg" alt="" width="490" height="223" border="0" id="dianqing_28" /></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/shop/191/2" target="_blank"><img src="http://images.d1.com.cn/market/1403/xinke/dianqing_29.jpg" alt="" width="490" height="223" border="0" id="dianqing_29" /></a></td>
	</tr>
	<tr>
	  <td>
	  <img src="http://images.d1.com.cn/market/1403/xinke/spacer.gif" width="247" height="1" alt="" /></td>
		<td>
		  <img src="http://images.d1.com.cn/market/1403/xinke/spacer.gif" width="83" height="1" alt="" /></td>
		<td>
		  <img src="http://images.d1.com.cn/market/1403/xinke/spacer.gif" width="160" height="1" alt="" /></td>
		<td>
		  <img src="http://images.d1.com.cn/market/1403/xinke/spacer.gif" width="161" height="1" alt="" /></td>
		<td>
		  <img src="http://images.d1.com.cn/market/1403/xinke/spacer.gif" width="81" height="1" alt="" /></td>
		<td>
		  <img src="http://images.d1.com.cn/market/1403/xinke/spacer.gif" width="248" height="1" alt="" /></td>
	</tr>
</table>


<map name="dianqing_03Map" id="dianqing_03Map">
  <area shape="rect" coords="183,280,318,355" href="#" attr="01205490" onClick="jginCart(this);"  />
</map>

<map name="dianqing_04Map" id="dianqing_04Map">
  <area shape="rect" coords="171,279,310,356" href="#" attr="04000911" onClick="jginCart(this);"  />
</map>

<map name="dianqing_05Map" id="dianqing_05Map">
  <area shape="rect" coords="173,280,312,356" href="#" attr="01205480" onClick="jginCart(this);"  />
</map>
</center>

<%@include file="/inc/foot.jsp"%>


</body>
</html>