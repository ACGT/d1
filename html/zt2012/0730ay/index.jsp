<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<AYPrize> getprizelist(){
	ArrayList<AYPrize> list=new ArrayList<AYPrize>();
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("prize_createdate"));
	List<BaseEntity> list2 = Tools.getManager(AYPrize.class).getList(null, listOrder, 0, 100);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((AYPrize)be);
	}
	return list; 
}
//获取今日参加活动的人数
int getTotalPrize(){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	String s=Tools.getDate(new Date())+" 00:00:00";
	String e=Tools.getDate(new Date())+" 23:59:59";
	 SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
     SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
     try {
    	 Date starttime=df2.parse(s); 
	     Date endtime=df2.parse(e);
	     listRes.add(Restrictions.ge("answer_createdate", starttime));
	     listRes.add(Restrictions.le("answer_createdate", endtime));

     } catch (ParseException ex) {
    	   ex.printStackTrace();
     }
	
	return Tools.getManager(AYAnswer.class).getLength(listRes);
}

//获取今日问题
static ArrayList<AYQuestion> getTodayQuestion(){
	SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String ndate="";
	Date dndate=null;
	try{
	  ndate=fmt.format(new Date());
	  dndate=fmt.parse(ndate);
}
catch(Exception ex){
	ex.printStackTrace();
}
	ArrayList<AYQuestion> list=new ArrayList<AYQuestion>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("questionFlag", new Long(1)));
	listRes.add(Restrictions.eq("qviewTime", dndate));
	List<BaseEntity> list2 = Tools.getManager(AYQuestion.class).getList(listRes, null, 0, 5);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		AYQuestion q=(AYQuestion)be;
		String s=Tools.getDate(new Date());
		String e=Tools.getDate(q.getQviewTime());
		if(s.equals(e)){
			list.add(q);
		}
		
	}
	return list; 
}
//获取今日所有参加竞猜的信息
ArrayList<AYAnswer> getTotalAnswer(){
	ArrayList<AYAnswer> list=new ArrayList<AYAnswer>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	//String s=Tools.getDate(new Date())+" 00:00:00";
	//String e=Tools.getDate(new Date())+" 23:59:59";
	// SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    // SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
    // try {
    	// Date starttime=df2.parse(s); 
	    // Date endtime=df2.parse(e);
	    // listRes.add(Restrictions.ge("answer_createdate", starttime));
	     //listRes.add(Restrictions.le("answer_createdate", endtime));

     //} catch (ParseException ex) {
    //	   ex.printStackTrace();
    // }
     List<Order> listOrder = new ArrayList<Order>();
 	listOrder.add(Order.desc("answer_createdate"));
 	List<BaseEntity> list2 = Tools.getManager(AYAnswer.class).getList(listRes, listOrder, 0, 100);
 	if(list2==null || list2.size()==0){
 		return null;
 	}
 	for(BaseEntity be:list2){
 		list.add((AYAnswer)be);
 	}
	return list;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚奥运活动</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
	function gettkt(){
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "/ajax/flow/getaytkt.jsp",
			success: function(json) {
				$.alert(json.message);
			}
			
			});
	}
	

</script>
<style type="text/css">
<!--
.askay {
	font-size: 18px;
	color: #373737;
	font-weight: 800;
}
.STYLE1 {color: #373737}
.txtlin {
	border: 1px solid #DDDDDD;
}
 ul,li{margin:0;padding:0}
.scrollDiv{width:400px;height:28px;line-height:18px;overflow:hidden;padding-top:4px;}
.scrollDiv li{height:28px;padding-left:4px;color:#525252;text-align:left;}
ul,li{ list-style:none;}
.scrollDiv2{width:900px;height:200px;line-height:18px;overflow:hidden;padding-top:4px; padding-left:30px;}
.scrollDiv2 li{height:28px;padding-left:4px;color:#525252;text-align:left;}

.allhd{ position:fixed; _position: absolute;  right:0px; bottom:150px;  width: 114px;font-size:12px; _top:expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);
             overflow:hidden; z-index:200000; display:block; background: url("http://images.d1.com.cn/zt2012/0730ay/float.png") no-repeat; 
            }

 p {text-align:left; }
 p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
 .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-33px; position:relative; width:310px; padding-top:3px; padding-bottom:2px;
*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:20px;  }
.retime a{text-decoration:none; }
.lf{ over-flow:hidden;}
.lb{background-color:#f7f7f7;  padding:5px;  width:3100px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
 text-align:left; vertical-align:middle; padding-top:8px;}
.lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none;}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@include file="/inc/head.jsp" %>

  <center>

<!-- ImageReady Slices (奥运活动2.tif) -->
<%  ArrayList<AYQuestion> qlist= getTodayQuestion(); %>

<table id="__01" width="980" height="1729" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_01.jpg" width="980" height="196" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_02.jpg" width="980" height="138" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_03.jpg" width="980" height="98" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="3"><a name="12" id="12"></a><a href="http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp" target="_blank">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_04.jpg" width="327"  border="0" height="275" alt=""></a></td>
		<td colspan="7">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_05.jpg" width="388" height="149" alt=""></td>
		<td colspan="2" rowspan="3">
			<a href="http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_06.jpg" width="265" height="275"  border="0" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_07.jpg" width="97" height="126" alt=""></td>
		<td colspan="3"><%if (qlist!=null) {
			AYQuestion qtime=qlist.get(0);
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			String ndate=fmt.format(new Date());
			SimpleDateFormat fmttime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			ndate=ndate+" "+qtime.getQuestiontktend();
			Date endtkttime=fmttime.parse(ndate);
		
		if(Tools.dateValue(endtkttime)<System.currentTimeMillis()){
		%><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_08-1.jpg" width="209" height="58" alt="" border="0"><%}else{ %>
		<a href="javascript:gettkt();">	<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_08.jpg" width="209" height="58" alt="" border="0"></a><%}
		}else{
		%><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_08-1.jpg" width="209" height="58" alt="" border="0"><%} %></td>
		<td colspan="2" rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_09.jpg" width="82" height="126" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_10.jpg" width="209" height="68" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_11.jpg" width="706" height="93" alt=""></td>
		<td colspan="3"><a href="http://www.d1.com.cn/html/zt2012/20120727ay/index.jsp#jc" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_12.jpg" alt="" width="274" height="47" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_13.jpg" width="274" height="46" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/03000112" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_14.jpg" alt="" width="230" height="238" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/03000109" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_15.jpg" alt="" width="180" height="238" border="0"></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/03000108" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_16.jpg" alt="" width="168" height="238" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/03000106" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_17.jpg" alt="" width="174" height="238" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/03000114" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_18.jpg" alt="" width="228" height="238" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_19.jpg" width="980" height="13" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_20.jpg" width="980" height="223" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01205265" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_21.jpg" alt="" width="490" height="387" border="0"></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/01205264" target="_blank"><img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_22.jpg" alt="" width="490" height="387" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2012/0730ay/aoyun_23.jpg" width="980" height="67" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="230" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="97" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="83" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="66" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="88" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="55" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="73" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="9" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="37" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/0730ay/分隔符.gif" width="228" height="1" alt=""></td>
	</tr>
</table>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_06.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="#01"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_07.jpg" alt="" width="245" height="337" border="0"></a></td>
		<td>
			<a href="#02"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_08.jpg" alt="" width="245" height="337" border="0"></a></td>
		<td>
			<a href="#03"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_09.jpg" alt="" width="245" height="337" border="0"></a></td>
		<td>
			<a href="#04"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_10-1.jpg" alt="" width="245" height="337" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#05"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_11.jpg" alt="" width="245" height="343" border="0"></a></td>
		<td>
			<a href="#06"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_12.jpg" alt="" width="245" height="343" border="0"></a></td>
		<td>
			<a href="#07"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_13.jpg" alt="" width="245" height="343" border="0"></a></td>
		<td>
			<a href="#08"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_14.jpg" alt="" width="245" height="343" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="4">
			<a name="01" id="01"></a><a href="http://www.d1.com.cn/result.jsp?productsort=020010" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_15-1.jpg" alt="" width="980" height="63" border="0"></a></td>
	</tr>
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7916");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<a name="02" id="02"></a><a href="http://www.d1.com.cn/result.jsp?productsort=020001,020002,020003,020006" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_17-1.jpg" alt="" width="980" height="45" border="0"></a></td>
	</tr>
	
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7917");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	
	<tr>
		<td colspan="4">
			<a name="03" id="03"></a><a href="http://www.d1.com.cn/result.jsp?productsort=020008,020009" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_19-1.jpg" alt="" width="980" height="45" border="0"></a></td>
	</tr>
	
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7918");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	
	<tr>
		<td colspan="4">
			<a name="04" id="04"></a><a href="http://www.d1.com.cn/html/ornament/" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_21-1.jpg" alt="" width="980" height="44" border="0"></a></td>
	</tr>
	
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7919");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<a name="05" id="05"></a><a href="http://www.d1.com.cn/result.jsp?productsort=030001,030002,030003" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_23-1.jpg" alt="" width="980" height="44" border="0"></a></td>
	</tr>
	
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7920");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<a name="06" id="06"></a><a href="http://www.d1.com.cn/result.jsp?productsort=030008,030009&amp;order=3" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_25-1.jpg" alt="" width="980" height="46" border="0"></a></td>
	</tr>
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7921");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<a name="07" id="07"></a><a href="http://www.d1.com.cn/html/watch/" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_27-1.jpg" alt="" width="980" height="44" border="0"></a></td>
	</tr>
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7922");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<a name="08" id="08"></a><a href="http://www.d1.com.cn/html/cosmetic/" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120718qchd//qchd_29-1.jpg" alt="" width="980" height="45" border="0"></a></td>
	</tr>
	
	<tr>
		<td colspan="4" valign="top">
			<% request.setAttribute("code","7923");%>
        <jsp:include   page= "/html/qchd.jsp"   />
		</td>
	</tr>
</table>
 <div class="allhd" id="allhd" >
 <table width="104">
 <tr><td height="105">&nbsp;</td></tr>
 <tr><td height="30"><a href="#12"><div style="height:30px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="30"><a href="#01"><div style="height:30px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#02"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#03"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#04"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#05"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#06"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#07"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#08"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 <tr><td height="28"><a href="#top"><div style="height:28px;width:114px;">&nbsp;</div></a></td></tr>
 </table>
 </div>

</center>
<div class="clear"></div>
   <%@include file="/inc/foot.jsp" %>
</body>
</html>