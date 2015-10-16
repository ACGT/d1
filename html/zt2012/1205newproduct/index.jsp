<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static int getlovelength(String loveno){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("loveno", new Long(loveno)));
	return Tools.getManager(Userlove.class).getLength(listRes);
	
}
static ArrayList<Userlove> getloveByNo(String loveno){
	ArrayList<Userlove> list=new ArrayList<Userlove>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("loveno", new Long(loveno)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("createdate"));
	List<BaseEntity> list2 = Tools.getManager(Userlove.class).getList(listRes, listOrder, 0, 1);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((Userlove)be);
	}
	return list; 
	
}
static ArrayList<Userlove> getlovelist(){
	ArrayList<Userlove> list=new ArrayList<Userlove>();
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("createdate"));
	List<BaseEntity> list2 = Tools.getManager(Userlove.class).getList(null, listOrder, 0, 60);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((Userlove)be);
	}
	return list; 
	
}
static String getcontent(String loveno){
	String t="";
	ArrayList<Userlove> list= getloveByNo(loveno);
	if(list!=null && list.size()>0){
		Userlove love=list.get(0);
		String uid=UserHelper.getById(love.getUserid()).getMbrmst_uid();
		if(StringUtils.getCnLength(uid)>=3){
			uid= "***"+StringUtils.getCnSubstring(uid,3,uid.length());
			if(StringUtils.getCnLength(uid)>=15){
				uid= "***"+StringUtils.getCnSubstring(uid,3,15);
			}
		}else{
			uid="***";
		}
		t=uid+":"+Tools.clearHTML(love.getLovecontent().trim());
		t=StringUtils.getCnSubstring(t, 0, 130);
	}
	return t;
}
static Userlove getById(String loveid){
	return (Userlove)Tools.getManager(Userlove.class).get(loveid);
	}
static  ArrayList<Userlove> getlove(String userid){
	ArrayList<Userlove> list=new ArrayList<Userlove>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("userid", userid));
	List<BaseEntity> list2 = Tools.getManager(Userlove.class).getList(listRes, null, 0, 2);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((Userlove)be);
	}
	return list; 
	
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2012.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css">
.retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:225px; padding-top:3px; padding-bottom:2px;
*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); height:36px; display:none; color:#FFFFFF; }
.retime a{text-decoration:none; color:#FFFFFF;}
  ul,li{margin:0;padding:0}
.scrollDiv{width:950px;height:300px;line-height:18px;overflow:hidden}
.scrollDiv li{height:100px;padding-left:4px;color:#525252;text-align:left}
ul,li{ list-style:none;}
.scrollDiv1{width:270px;height:130px;line-height:18px;overflow:hidden;font-size:12px;}
.scrollDiv1 li{height:26px;padding-left:4px;color:#525252;text-align:left}
</style>
<script language="javascript" type="text/javascript">
function check(obj){
	var no=$(obj).attr("attr");
	var pid=$(obj).attr("code");
$.ajax({
    type: "post",
    dataType: "text",
    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
    url: "/ajax/zhuanti/1205newproduct.jsp",
    cache: false,
    data:{
   	 loveno:no,productid:pid
      },error: function(XmlHttpRequest, textStatus, errorThrown){
    },success: function(msg){
    	 if(msg==0){
    		 $.alert('参数错误！');
    	 }else  if(msg==1){
    		 $.alert('每个用户只能喜欢2款！');
    	 }else  if(msg==2){
    		 addlove("",no,pid);
    	 }else  if(msg==5){
    		 $.alert('该活动已结束！');
    	 }
    	
    }
    }
)
}
function addlove(c,loveno,pid){$.close();  var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("写下你的理由吧",500,"/ajax/zhuanti/addlove.jsp"+s+"&loveno="+loveno+"&productid="+pid);}
function AutoScroll(obj){
	$(obj).find("ul:first").animate({
	marginTop:"-100px"
	},200,function(){
	$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	});
	}
	$(document).ready(function(){
		setInterval('AutoScroll("#scrollDiv1")',5000)
		 var myar = setInterval('AutoScroll("#scrollDiv2")', 3000)
         $("#scrollDiv2").hover(function() { clearInterval(myar);
       
         }, function() { myar = setInterval('AutoScroll("#scrollDiv2")', 3000) }); //当鼠标放上去的时候，滚动停止，鼠标离开的时候滚动开始
	});	
</script>
</head>
<body>
  <%@include file="/inc/head.jsp" %>

	<div class="clear"></div>
	<%
ArrayList<Userlove> list1=new ArrayList<Userlove>();
ArrayList<Userlove> list2=new ArrayList<Userlove>();
ArrayList<Userlove> list3=new ArrayList<Userlove>();
String [] str1=new String[]{"6","59","69"};
for(int i=0;i<str1.length;i++){
	Userlove love=getById(str1[i]);
	if(love!=null){
		list1.add(love);
	}
}
String [] str2=new String[]{"26","28","52","131","48"};
for(int j=0;j<str2.length;j++){
	Userlove love=getById(str2[j]);
	if(love!=null){
		list2.add(love);
	}
}
String [] str3=new String[]{"68","125","63","121","30","91","75","123","15","160"};
for(int k=0;k<str3.length;k++){
	Userlove love=getById(str3[k]);
	if(love!=null){
		list3.add(love);
	}
}

if(list1!=null && list1.size()>0){
	%>
	<div id="page" align="center" style="background:#FFFFFF;">
	<div id="sc" class="oldstylenew"  style="height:0px;background:#FFFFFF;">
	
	<table>
	<tr><td align="right" valign="top" height="10px" style="padding-right:20px; padding-top:5px;"><a href="javascript:void(0)" onclick="closeSC();" ><img src="http://images.d1.com.cn/images2012/index2012/X.png" /></a></td></tr>
	<tr style="font-weight:bold;font-size:14px;"><td align="center">中奖名单</td></tr>
	<tr><td style="height:10px;">&nbsp;</td></tr>
	<tr style="font-weight:bold;"><td align="center">恭喜以下幸运的顾客获得奖品</td></tr>
	<tr><td style="height:15px;">&nbsp;</td></tr>
	<tr><td>
	<div id="scrollDiv2" class="scrollDiv1">
      <ul>
      <%
      for(Userlove love:list1){
    	  String uid=UserHelper.getById(love.getUserid()).getMbrmst_uid();
    	  String msg1="光速评论奖："+uid;
    	  %>
    	  <li><%=msg1 %></li>
       <%}
      for(Userlove love:list2){
    	  String uid=UserHelper.getById(love.getUserid()).getMbrmst_uid();
    	  String msg1="精彩评论奖："+uid;
    	  %>
    	   <li><%=msg1 %></li>
     <%} 
      for(Userlove love:list3){
    	  String uid=UserHelper.getById(love.getUserid()).getMbrmst_uid();
    	  String msg1="幸运参与奖："+uid;
    	  %>
    	   <li><%=msg1 %></li>
     <%} %>
      </ul>
	</div>
	</td></tr>
	<tr><td style="height:15px;">&nbsp;</td></tr>
	<tr style="color:red;"><td align="center">请大家注意联系客服领取奖品</td></tr>
	</table>
	
	</div>
	</div>
<%
//out.print("<script>setInterval('AutoScroll(\"#scrollDiv2\")',5000);</script>");
}
%>
	<!-- 中间内容 -->
	<center>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px;">
	<tr>
	<td><img src="http://images.d1.com.cn/images2012/1205newproduct/images/new_01.jpg" border="0"/></td>
	</tr>
	<tr>
	<td><img src="http://images.d1.com.cn/images2012/1205newproduct/images/new_02.jpg" border="0"/></td>
	</tr>
	<tr>
	<td><img src="http://images.d1.com.cn/images2012/1205newproduct/images/new_03.jpg" border="0"/></td>
	</tr>
	<tr>
	<td><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_04.jpg" border="0"/></td>
	</tr>
	<tr>
	<td valign="top" style="background-color:#FEEDD6;">
	<div >
	<div style="float:left; margin-left:15px; width:225px;">
	
	<table style="width:225px;border:none;" cellpadding="0" cellspacing="0">
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000247" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/new_06.jpg" border="0"  onmouseover="mdm_over('02000247')" onmouseout="mdm_out('02000247')"/></a>
	<p class="retime"  id="black_02000247" onmouseover="mdm_over('02000247')" onmouseout="mdm_out('02000247')"> <a href="http://d1.com.cn/product/02000247" target="_blank" style="font-size:12px; color:#fff; "><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000247").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	 <table style="width:100px">
	 <tr><td width="50px" align="left"> <a attr="1" code="02000247" href="###" onclick="check(this);">
	 <div style="width:50px; float:left;">&nbsp;</div></a></td><td align="center"  style="color:#FE5461;"><%=getlovelength("1") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=1" target="_blank" style="color:#FE5461;  text-decoration:underline;"><%= getlovelength("1")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;">
	<%=getcontent("1") %>
	</td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000151" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/new_34.jpg" border="0"  onmouseover="mdm_over('02000151')" onmouseout="mdm_out('02000151')"/></a>
	<p class="retime"  id="black_02000151" onmouseover="mdm_over('02000151')" onmouseout="mdm_out('02000151')"> <a href="http://d1.com.cn/product/02000151" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000151").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	 <table style="width:100px">
	 <tr><td width="50px" align="left"> <a attr="5" code="02000246" href="###" onclick="check(this);">
	 <div style="width:50px; float:left;">&nbsp;</div></a></td><td align="center"  style="color:#FE5461;"><%=getlovelength("5") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=5" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("5")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("5") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000246" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_58.jpg" border="0"  onmouseover="mdm_over('02000246')" onmouseout="mdm_out('02000246')"/></a>
	<p class="retime"  id="black_02000246" onmouseover="mdm_over('02000246')" onmouseout="mdm_out('02000246')"><a href="http://d1.com.cn/product/02000246" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000246").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	 <table style="width:100px">
	 <tr><td width="50px" align="left"> <a attr="9" code="02000246" href="###" onclick="check(this);">
	 <div style="width:50px; float:left;">&nbsp;</div></a></td><td align="center"  style="color:#FE5461;"><%=getlovelength("9") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=9" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("9")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("9") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000185" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/new_82.jpg" border="0"  onmouseover="mdm_over('02000185')" onmouseout="mdm_out('02000185')"/></a>
	<p class="retime"  id="black_02000185" onmouseover="mdm_over('02000185')" onmouseout="mdm_out('02000185')"> <a href="http://d1.com.cn/product/02000185" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000185").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	 <table style="width:100px">
	 <tr><td width="50px" align="left"> <a attr="13" code="02000185" href="###" onclick="check(this);">
	 <div style="width:50px; float:left;">&nbsp;</div></a></td><td align="center"  style="color:#FE5461;"><%=getlovelength("13") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=13" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("13")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("13") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000254" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_106.jpg" border="0"  onmouseover="mdm_over('02000254')" onmouseout="mdm_out('02000254')"/></a>
	<p class="retime"  id="black_02000254" onmouseover="mdm_over('02000254')" onmouseout="mdm_out('02000254')"> <a href="http://d1.com.cn/product/02000254" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000254").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="17" code="02000254" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("17") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=17" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("17")%></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("17") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000205" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_130.jpg" border="0"  onmouseover="mdm_over('02000205')" onmouseout="mdm_out('02000205')"/></a>
	<p class="retime"  id="black_02000205" onmouseover="mdm_over('02000205')" onmouseout="mdm_out('02000205')"><a href="http://d1.com.cn/product/02000205" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000205").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	<td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="21" code="02000205" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("21") %> </td></tr>
	 </table>
	 </td>
	
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=21" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("21") %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("21") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000206" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_154.jpg" border="0"  onmouseover="mdm_over('02000206')" onmouseout="mdm_out('02000206')"/></a>
	<p class="retime"  id="black_02000206" onmouseover="mdm_over('02000206')" onmouseout="mdm_out('02000206')"><a href="http://d1.com.cn/product/02000206" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000206").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	<td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="25" code="02000206" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("25") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=25" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("25")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("25") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>	</td>
	</tr>
	</table>
	</div>
	
	
	
	
	
	
	
	
	<div style="float:left; margin-left:15px; width:225px;">
	
	<table style="width:225px;border:none;" cellpadding="0" cellspacing="0">
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000133" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_08.jpg" border="0"  onmouseover="mdm_over('02000133')" onmouseout="mdm_out('02000133')"/></a>
	<p class="retime"  id="black_02000133" onmouseover="mdm_over('02000133')" onmouseout="mdm_out('02000133')"> <a href="http://d1.com.cn/product/02000133" target="_blank" style="font-size:12px; color:#fff; "><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000133").getGdsmst_gdsname()),0,72) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
		<tr>
	<td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="2" code="02000133" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("2") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=2" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("2")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("2") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
		<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000174" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_36.jpg" border="0"  onmouseover="mdm_over('02000174')" onmouseout="mdm_out('02000174')"/></a>
	<p class="retime"  id="black_02000174" onmouseover="mdm_over('02000174')" onmouseout="mdm_out('02000174')"><a href="http://d1.com.cn/product/02000174" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000174").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	<td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="6" code="02000174" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("6") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=6" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("6") %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("6") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/01721219" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_59.jpg" border="0"  onmouseover="mdm_over('01721219')" onmouseout="mdm_out('01721219')"/></a>
	<p class="retime"  id="black_01721219" onmouseover="mdm_over('01721219')" onmouseout="mdm_out('01721219')"> <a href="http://d1.com.cn/product/01721219" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("01721219").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="10" code="01721219" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("10") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=10" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("10")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("10") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000262" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_84.jpg" border="0"  onmouseover="mdm_over('02000262')" onmouseout="mdm_out('02000262')"/></a>
	<p class="retime"  id="black_02000262" onmouseover="mdm_over('02000262')" onmouseout="mdm_out('02000262')"> <a href="http://d1.com.cn/product/02000262" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000262").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="14" code="02000262" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("14") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=14" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("14") %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("14") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000198" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_107.jpg" border="0"  onmouseover="mdm_over('02000198')" onmouseout="mdm_out('02000198')"/></a>
	<p class="retime"  id="black_02000198" onmouseover="mdm_over('02000198')" onmouseout="mdm_out('02000198')"> <a href="http://d1.com.cn/product/02000198" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000198").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="18" code="02000198" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("18") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=18" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("18") %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("18") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000267" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_132.jpg" border="0"  onmouseover="mdm_over('02000267')" onmouseout="mdm_out('02000267')"/></a>
	<p class="retime"  id="black_02000267" onmouseover="mdm_over('02000267')" onmouseout="mdm_out('02000267')"><a href="http://d1.com.cn/product/02000267" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000267").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="22" code="02000267" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("22") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=22" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("22")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("22") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000180" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_155.jpg" border="0"  onmouseover="mdm_over('02000180')" onmouseout="mdm_out('02000180')"/></a>
	<p class="retime"  id="black_02000180" onmouseover="mdm_over('02000180')" onmouseout="mdm_out('02000180')"> <a href="http://d1.com.cn/product/02000180" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000180").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="26" code="02000180" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("26") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=26" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("26")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("26") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	</table>
	</div>
	
	<div style="float:left; margin-left:15px; width:225px;">
	
	<table style="width:225px;border:none;" cellpadding="0" cellspacing="0">
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000213" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_10.jpg" border="0"  onmouseover="mdm_over('02000213')" onmouseout="mdm_out('02000213')"/></a>
	<p class="retime"  id="black_02000213" onmouseover="mdm_over('02000213')" onmouseout="mdm_out('02000213')"> <a href="http://d1.com.cn/product/02000213" target="_blank" style="font-size:12px; color:#fff; "><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000213").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="3" code="02000213" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("3") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=3" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("3") %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("3") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
		<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000171" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_35.jpg" border="0"  onmouseover="mdm_over('02000171')" onmouseout="mdm_out('02000171')"/></a>
	<p class="retime"  id="black_02000171" onmouseover="mdm_over('02000171')" onmouseout="mdm_out('02000171')"><a href="http://d1.com.cn/product/02000171" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000171").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="7" code="02000171" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("7") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=7" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("7")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("7") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000182" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_60.jpg" border="0"  onmouseover="mdm_over('02000182')" onmouseout="mdm_out('02000182')"/></a>
	<p class="retime"  id="black_02000182" onmouseover="mdm_over('02000182')" onmouseout="mdm_out('02000182')"><a href="http://d1.com.cn/product/02000182" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000182").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="11" code="02000182" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("11") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=11" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("11")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("11") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
			<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000183" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_83.jpg" border="0"  onmouseover="mdm_over('02000183')" onmouseout="mdm_out('02000183')"/></a>
	<p class="retime"  id="black_02000183" onmouseover="mdm_over('02000183')" onmouseout="mdm_out('02000183')"><a href="http://d1.com.cn/product/02000183" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000183").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="15" code="02000183" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("15") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=15" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("15") %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("15") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	
<tr><td height="10px;" >&nbsp;</td></tr>
				<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000201" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_108.jpg" border="0"  onmouseover="mdm_over('02000201')" onmouseout="mdm_out('02000201')"/></a>
	<p class="retime"  id="black_02000201" onmouseover="mdm_over('02000201')" onmouseout="mdm_out('02000201')"> <a href="http://d1.com.cn/product/02000201" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000201").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="19" code="02000201" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("19") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=19" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("19")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("19") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000243" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_131.jpg" border="0"  onmouseover="mdm_over('02000243')" onmouseout="mdm_out('02000243')"/></a>
	<p class="retime"  id="black_02000243" onmouseover="mdm_over('02000243')" onmouseout="mdm_out('02000243')"><a href="http://d1.com.cn/product/02000243" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000243").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="23" code="02000243" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("23") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=23" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("23")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("23") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000170" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_157.jpg" border="0"  onmouseover="mdm_over('02000170')" onmouseout="mdm_out('02000170')"/></a>
	<p class="retime"  id="black_02000170" onmouseover="mdm_over('02000170')" onmouseout="mdm_out('02000170')"><a href="http://d1.com.cn/product/02000170" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000170").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="27" code="02000170" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("27") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=27" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("27")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("27") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	</table>
	</div>
	
	<div style="float:left; margin-left:15px; width:225px;">
	
	<table style="width:225px;border:none;" cellpadding="0" cellspacing="0">
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000178" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_12.jpg" border="0"  onmouseover="mdm_over('02000178')" onmouseout="mdm_out('02000178')"/></a>
	<p class="retime"  id="black_02000178" onmouseover="mdm_over('02000178')" onmouseout="mdm_out('02000178')"><a href="http://d1.com.cn/product/02000178" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000178").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	<td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="4" code="02000178" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("4") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=4" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("4")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("4") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
		<tr><td height="10px;" >&nbsp;</td></tr>
			<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000173" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_37.jpg" border="0"  onmouseover="mdm_over('02000173')" onmouseout="mdm_out('02000173')"/></a>
	<p class="retime"  id="black_02000173" onmouseover="mdm_over('02000173')" onmouseout="mdm_out('02000173')"><a href="http://d1.com.cn/product/02000173" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000173").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	 <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="8" code="02000173" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("8") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=8" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("8")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("8") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
<tr><td height="10px;" >&nbsp;</td></tr>
	<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000253" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_61.jpg" border="0"  onmouseover="mdm_over('02000253')" onmouseout="mdm_out('02000253')"/></a>
	<p class="retime"  id="black_02000253" onmouseover="mdm_over('02000253')" onmouseout="mdm_out('02000253')"><a href="http://d1.com.cn/product/02000253" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000253").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="12" code="02000253" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("12") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=12" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("12")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("12") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
		<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000260" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_85.jpg" border="0"  onmouseover="mdm_over('02000260')" onmouseout="mdm_out('02000260')"/></a>
	<p class="retime"  id="black_02000260" onmouseover="mdm_over('02000260')" onmouseout="mdm_out('02000260')"><a href="http://d1.com.cn/product/02000260" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000260").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="16" code="02000260" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("16") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=18" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("16")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("16") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	
	<tr><td height="10px;" >&nbsp;</td></tr>
			<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000249" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_109.jpg" border="0"  onmouseover="mdm_over('02000249')" onmouseout="mdm_out('02000249')"/></a>
	<p class="retime"  id="black_02000249" onmouseover="mdm_over('02000249')" onmouseout="mdm_out('02000249')"> <a href="http://d1.com.cn/product/02000249" target="_blank"><%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000249").getGdsmst_gdsname()),0,60) %> </a></p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	  <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="20" code="02000249" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("20") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=20" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("20")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("20") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
				<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000179" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_133.jpg" border="0"  onmouseover="mdm_over('02000179')" onmouseout="mdm_out('02000179')"/></a>
	<p class="retime"  id="black_02000179" onmouseover="mdm_over('02000179')" onmouseout="mdm_out('02000179')"><a href="http://d1.com.cn/product/02000179" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000179").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	   <td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="24" code="02000179" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("24") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=24" target="_blank" style="color:#FE5461; text-decoration:underline;"><%=getlovelength("24")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("24") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	
	<tr><td height="10px;" >&nbsp;</td></tr>
				<tr> <td  style="background-color:#FEEDD6;"><a href="http://d1.com.cn/product/02000175" target="_blank"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xptp_156.jpg" border="0"  onmouseover="mdm_over('02000175')" onmouseout="mdm_out('02000175')"/></a>
	<p class="retime"  id="black_02000175" onmouseover="mdm_over('02000175')" onmouseout="mdm_out('02000175')"><a href="http://d1.com.cn/product/02000175" target="_blank"> <%=StringUtils.getCnSubstring(Tools.clearHTML(ProductHelper.getById("02000175").getGdsmst_gdsname()),0,60) %></a> </p>
	
	</td>
	</tr>
	<tr>
	<td style="background-color:#FFFFFF;">
	<div style="margin-left:8px;margin-right:8px;background-color:#FFFFFF;width:209px; ">
	<table style="background-color:#FFFFFF; border:none;" width="209px" cellpadding="0" cellspacing="0">
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr>
	<td width="100px" align="left" style="background:url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_17.jpg)  no-repeat; height:25px; width:97px; ">
	  <table style="width:100px">
	 <tr><td width="50px" align="left"> 
	 <a attr="28" code="02000175" href="###" onclick="check(this);">
	 <div style="width:50px; float:left; padding-top:10px;">&nbsp;</div></a>
	 </td><td align="center"  style="color:#FE5461;"><%=getlovelength("28") %> </td></tr>
	 </table>
	 </td>
	<td width="100" align="center" style="color:#FE5461;">评论（<a href="showloves.jsp?loveno=28" target="_blank" style="color:#FE5461; text-decoration:underline;"><%= getlovelength("28")  %></a>）</td>
	</tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" align="center"><img src="http://images.d1.com.cn/images2012/1205newproduct/images/xian.jpg" border="0"/></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	<tr> <td colspan="2" style="text-align:left; color:#999999; line-height:22px;"><%=getcontent("28") %></td></tr>
	<tr><td height="6px;" colspan="2"></td></tr>
	</table>
	</div>
	</td>
	</tr>
	<tr><td height="25px;" >&nbsp;</td></tr>
	</table>
	</div>
	
	
	
	</div>
	</td>
	</tr>
	
	<tr><td  valign="top">
		<div style="padding-top:10px; padding-left:15px; padding-right:15px;">
	<table style="border:none;" cellpadding="0" cellspacing="0">
	<tr> <td colspan="2" align="left"><span style="font-size:26px; color:#666666; font-weight:bold;">看看大家的热议吧</span></td></tr>
	<tr> <td colspan="2" style="border-bottom:solid 1px #FE8f9C; width:100%;">&nbsp;</td></tr>
	<tr><td height="10px;" >&nbsp;</td></tr>
	
	
	<tr> <td colspan="2">
	<%
	ArrayList<Userlove> list=getlovelist();
	if(list!=null && list.size()>0){
		%>
		<div id="scrollDiv1" class="scrollDiv">
      <ul>
	<%
	int i=1;
	for(Userlove love:list){
		String uid=UserHelper.getById(love.getUserid()).getMbrmst_uid();
		if(StringUtils.getCnLength(uid)>=3){
			uid= "***"+StringUtils.getCnSubstring(uid,3,uid.length());
			if(StringUtils.getCnLength(uid)>=15){
				uid= "***"+StringUtils.getCnSubstring(uid,3,15);
			}
		}else{
			uid="***";
		}
		String pid=love.getProductid();
		String pname="";
		Product p=ProductHelper.getById(pid);
		if(p!=null){
		pname=Tools.clearHTML(p.getGdsmst_gdsname());	
		}
		if(StringUtils.getCnLength(uid)<8){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,50)+"...";
		}
		if(StringUtils.getCnLength(uid)>10){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,42)+"...";
		}if(StringUtils.getCnLength(uid)>14){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,36)+"...";
		}if(StringUtils.getCnLength(uid)>18){
			pname=StringUtils.getCnSubstring(Tools.clearHTML(pname),0,30)+"...";
		}
		
		if(i%2==1){
			%>
			<li>
			<div style="float:left;">
	 <%}else{%>
		<div style="float:right;">
		<%} %>
		 <table style="border:none;" cellpadding="0" cellspacing="0">
	  <tr>	 <td align="left" style="color:#666666;"><%=uid %>喜欢  <span style="color:#FE8F9C;font-weight:bold;font-size:13px;"><%=love.getLoveno() %>号</span>  <a href="/product/<%=pid%>"><%=pname %></a> </td></tr>
	<tr> <td align="left" valign="top" style="background :url(http://images.d1.com.cn/images2012/1205newproduct/images/xptp_179.jpg) no-repeat; height:61px; width:454px;">
	
	<div style="padding-top:20px; padding-left:25px; color:#FFFFFF;"><%=StringUtils.getCnSubstring(Tools.clearHTML(love.getLovecontent()), 0, 140)  %></div>
	</td></tr>
	  </table>	
		</div>
		
	<%
	if(i%2==0){%>
		</li>
	<%}
	i++;
	}%>
	</ul>
	</div>
	<%}
	%>
	
	 
	</td></tr>
	
	</table>
	
	</div>
	</td>
	</tr>
	</table>
</center>
<script type="text/javascript" language="javascript" src="http://d1.com.cn/res/js/lazyload.js"></script>
<script type="text/javascript">

function mdm_over(obj)
{
	$("#black_"+obj).show();
}
function mdm_out(obj)
{
	 $("#black_"+obj).hide();
	
}
function closeSC(){
	$("#sc").animate({width:"265"},1000,function(){});$("#sc").animate({height:"0"},1000,function(){});
	$("#sc").slideUp();
}

function openSc()
{
	$("#sc").animate({height:"290"},1000,function(){});
}
$(document).ready(function() {
    openSc();
});
 </script>
	<div class="clear"></div>

	<!-- 中间内容结束 -->
	
<%@include file="/inc/foot.jsp"%>	
	</body>
</html>
