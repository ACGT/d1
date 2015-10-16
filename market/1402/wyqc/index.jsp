<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	//clist.add(Restrictions.le("spgdsrcm_seq",new Long(100)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num+10);
	if(list==null||list.size()==0)return null;	
	
	int total = 0 ;
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null ) continue;
			rlist.add(pp);
			total++;
			if(total==num)break;
		}
	}
		
	//for(BaseEntity be:list){
		//PromotionProduct pp = (PromotionProduct)be;
		//rlist.add(pp);
	//}
	return rlist ;
}

private static String getrec(String code,int len){
	ArrayList<PromotionProduct> list=getPProductByCode(code,len);
	
	StringBuilder sb=new StringBuilder();
	if(list!=null&&list.size()>0){
	for(int i=0;i<list.size();i++){
		PromotionProduct pp=list.get(i);
		Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
		if (p==null)continue;
		String gdsid=p.getId();
		String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
		
		String theimgurl=p.getGdsmst_imgurl();
		int hg=310;
		int hgimg=200;
		int wdimg=200;
		if(!p.getGdsmst_rackcode().startsWith("014")){
			theimgurl=p.getGdsmst_img240300();
			hg=410;
			hgimg=300;
			wdimg=240;
		}
		 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
			 theimgurl = "http://images1.d1.com.cn"+theimgurl;
				}else{
					theimgurl = "http://images.d1.com.cn"+theimgurl;
				}
		 String memtxt="特卖价";
		 String memtxt2="市场价";
		 int oldmemprice=p.getGdsmst_saleprice().intValue();
		 int memprice=p.getGdsmst_memberprice().intValue();
			if(CartHelper.getmsflag(p)){
				memprice=p.getGdsmst_msprice().intValue();
				oldmemprice=p.getGdsmst_memberprice().intValue();
				//memtxt="清仓价";
				memtxt2="原售价";
		 }
		String gdsimglfag="http://images.d1.com.cn/zt2014/0121qc/qc001-2.png";
		if(p.getGdsmst_validflag().longValue()!=1){
			gdsimglfag="http://images.d1.com.cn/zt2014/0121qc/endflag.png";
		}
			
	sb.append("<li style=\"height:"+hg+"px;\">");
	sb.append("<table width=\"240\" height=\""+hg+"\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	sb.append("    <tr>");
	sb.append("      <td height=\""+hgimg+"\" colspan=\"5\" align=\"center\" class=\"gdslistimg\"> ");
	sb.append("<a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
	sb.append("      <img src=\"").append(theimgurl).append("\"  alt=\"").append(imgalt).append("\" width=\""+wdimg+"\" height=\""+hgimg+"\" border=\"0\" /></a>");
	sb.append("      <span class=\"gdslistimgl\"><img src=\""+gdsimglfag+"\" width=\"69\" height=\"83\" /></span>");
	sb.append("      </td>");
	sb.append("      </tr>");
	sb.append("<tr>");
	sb.append(" <td height=\"50\">&nbsp;</td>");
	sb.append("<td colspan=\"3\" class=\"gdstitle\">");
	sb.append("<a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
	sb.append(imgalt.length()>34?imgalt.substring(0,34):imgalt);
	sb.append("</a></td>");
	sb.append("<td>&nbsp;</td>");
	sb.append("</tr>");
	sb.append("    <tr>");
	sb.append("      <td width=\"5\" bgcolor=\"#cf070a\"></td>");
	sb.append("      <td width=\"94\" bgcolor=\"#cf070a\"><span  class=\"qcgdst\">").append(memtxt).append("￥</span><br />");
	sb.append("      <span class=\"qcgdsp2\">").append(memtxt2).append("：").append(oldmemprice).append("</span>");
	sb.append("      </td>");
	sb.append("      <td width=\"76\" align=\"center\" bgcolor=\"#cf070a\" class=\"qcgdsp\">").append(memprice).append("</td>");
	sb.append("      <td width=\"60\" align=\"center\" bgcolor=\"#cf070a\">");
	sb.append("<a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
	sb.append("<img src=\"http://images.d1.com.cn/zt2014/0121qc/qc005.jpg\" width=\"60\" height=\"60\" /></a></td>");
	sb.append("      <td width=\"5\" bgcolor=\"#cf070a\"></td>");
	sb.append("    </tr>");
	sb.append("  </table>");
	sb.append("</li>");
	}
	}
   return sb.toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<title>网易特卖 全场一折起--D1优尚</title>
<style type="text/css">
.mgl20{ margin-left:22px;}
.qclisttitle {
	height:75px;
	width:980px;
	background-image: url(http://images.d1.com.cn/zt2014/0121qc/qc004-2.jpg);
	background-repeat: no-repeat;
}
.qclisttitle ul li{
	width:196px;
	height:75px;
	color:#fff;
	float:left;
}
.qclisttitle .cur{
	background-image: url(http://images.d1.com.cn/zt2014/0121qc/qc004-2_2.jpg);
	background-repeat: no-repeat;
	width:196px;
}
.qclisttitle ul li a {
cursor: pointer;
display: block;
float: left;
width:196px;
	height:75px;
text-indent: -999em;
outline: 0;
}
.qcgdslist{ width:980px; background-color:#b90a19;}
.qcgdslist ul li{
	width:240px;
	float:left;
	margin:8px 0px 8px 4px;
	background-color: #fff;
}
.gdstitle{ font-size:12px; color:#333;font-family:微软雅黑; line-height:21px}
.qcgdst{ font-size:18px; color:#fbe472; font-family:微软雅黑;}
.qcgdsp{ font-size:35px; color:#fbe472; font-family:微软雅黑; font-weight:800;}
.qcgdsp2{ font-size:14px; color:#fff; font-family:微软雅黑;}
.gdslistimg{ position:relative;}
.gdslistimgl{ position:absolute; top:0px; left:0px; z-index:999}
.qcbanner{
	margin:10px auto;
	background-image: url(http://images.d1.com.cn/zt2014/0121qc/qc002_1.jpg);
	height:450px;
	background-position: center;
}
.qcbanner2{
	margin:10px auto;
	background-image: url(http://images.d1.com.cn/zt2014/0121qc/sale3-2.jpg);
	height:600px;
	background-position: center;
}
.tktcardno{}
.topbannerdiv{	position:relative; width:980px; height:150px; margin: 0px auto;padding-top:300px;}
.link1{
	position:absolute;
	width:90px;
	height:40px;
	left:600px;
	top: 218px;
}
.tktcardno{
	position:absolute;
	width:215px;
	height:40px;
	left:370px;
	top: 216px;
}
.qccontent{width:980px;margin: 0px auto;}


.qcgdslist ul li a {
color: #333;
font-size: 12px;
}
.qcgdslist ul li a:hover {
text-decoration: underline;
}
.qcgdslist h3 {
	height:45px;
	padding-top:12px;
	text-align:center;
	background-color:#f1e9d2;
	background-image: url(http://images.d1.com.cn/zt2014/0121qc/qc006.jpg);
	background-repeat: no-repeat;
	background-position: center top;
	font-size:20px; color:#fff; font-family:微软雅黑;
}

.allhd2{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 142px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}

</style>
<script>
/*$(function(){
 $("#listtab>div:not(:first)").hide();
 $("#clstab li").click(function(){
	 var px=0;
    var index = $("#clstab li").index(this);
   $(this).addClass("cur").siblings().removeClass("cur");
	if(index>0){
		px=-196*index;
		}
	$(this).css( {backgroundPosition: ""+px+"px 0px"} )
    $("#listtab>div").eq(index).show().siblings().hide();
 });

});*/
</script>

<script type="text/javascript">
function ActivateTicket(){
	var payid = -1; //选中的支付方式
	var strCardNo = $('#tktcardno').val();
   // var btnActivate = $('#activetickets');
    if (strCardNo == null || strCardNo.length == 0){
        alert('请输入优惠券号码!');
        return;
    }
    $.ajax({
        type: "post",
        dataType: "json",
        url: "/ajax/flow/activateTicket.jsp",
        cache: false,
        data:{CardNo: strCardNo,payId:payid},
        error: function(XmlHttpRequest){
            alert("激活优惠券错误！");
           // btnActivate.removeAttr('disabled');
            //btnActivate.attr('value', '激活优惠券');
        },
        success: function(json){
            if(json.success){
                alert('激活优惠券成功!');
                
            }else{
                alert(json.message);
            }
        }
    });
}

</script>
</head>

<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div class="allhd2">
<img src="http://images.d1.com.cn/zt2014/0121qc/right-2.png" width="142" height="227" border="0" usemap="#qcMap" />
<map name="qcMap" id="qcMap">
  <area shape="rect" coords="20,45,129,78" href="#01" />
  <area shape="rect" coords="20,77,131,115" href="#02" />
  <area shape="rect" coords="17,117,140,145" href="#03" />
  <area shape="rect" coords="12,144,135,176" href="#04" />
  <area shape="rect" coords="11,176,140,207" href="#05" />
</map>
</div>

<div class="qcbanner2">
  <div class="topbannerdiv" > <input name="tktcardno" id="tktcardno" type="text" class="tktcardno"  />
<a href="javascript:ActivateTicket();" ><span class="link1"> 
</span></a>
</div>
</div>
<div class="qccontent">
<a name="01"></a>
<div class="qclisttitle" id="clstab">
<ul>
<li  class="cur" style="background-position: 0px 0px;">
<a href="#01">时尚女装</a>
</li>
<li>
  <a href="#02">精品男装</a>
</li>
<li>
  <a href="#03">护肤彩妆</a>
</li>
<li>
  <a href="#04"> 内衣家居</a>
</li>
<li>
 <a href="#05"> 鞋包配件</a>
</li>
</ul>
</div>
<div id="listtab">



<div class="qcgdslist">
<h3>时尚女装</h3>
<ul>
<%=getrec("9147",80) %>
<div class="clear"></div>
</ul>
</div>
<a name="02"></a>
<div class="qclisttitle" id="clstab">
<ul>
<li>
<a href="#01">时尚女装</a>
</li>
<li   class="cur" style="background-position: -196px 0px;">
  <a href="#02">精品男装</a>
</li>
<li>
  <a href="#03">护肤彩妆</a>
</li>
<li>
  <a href="#04"> 内衣家居</a>
</li>
<li>
 <a href="#05"> 鞋包配件</a>
</li>
</ul>
</div>

<div class="qcgdslist">
<h3>精品男装</h3>
<ul>
<%=getrec("9148",80) %>
<div class="clear"></div>
</ul>
</div>
<a name="03"></a>
<div class="qclisttitle" id="clstab">
<ul>
<li>
<a href="#01">时尚女装</a>
</li>
<li>
  <a href="#02">精品男装</a>
</li>
<li   class="cur" style="background-position: -392px 0px;">
  <a href="#03">护肤彩妆</a>
</li>
<li>
  <a href="#04"> 内衣家居</a>
</li>
<li>
 <a href="#05"> 鞋包配件</a>
</li>
</ul>
</div>

<div class="qcgdslist">
<h3>护肤彩妆</h3>
<ul>
<%=getrec("9146",80)%>
<div class="clear"></div>
</ul>
</div>
<a name="04"></a>
<div class="qclisttitle" id="clstab">
<ul>
<li>
<a href="#01">时尚女装</a>
</li>
<li>
  <a href="#02">精品男装</a>
</li>
<li>
  <a href="#03">护肤彩妆</a>
</li>
<li  class="cur" style="background-position: -588px 0px;">
  <a href="#04"> 内衣家居</a>
</li>
<li>
 <a  href="#05"> 鞋包配件</a>
</li>
</ul>
</div>

<div class="qcgdslist">
<h3>内衣家居</h3>
<ul>
<%=getrec("9149",80) %>
<div class="clear"></div>
</ul>
</div>

<a name="05"></a>
<div class="qclisttitle" id="clstab">
<ul>
<li>
<a href="#01">时尚女装</a>
</li>
<li>
  <a href="#02">精品男装</a>
</li>
<li>
  <a href="#03">护肤彩妆</a>
</li>
<li>
  <a href="#04"> 内衣家居</a>
</li>
<li class="cur" style="background-position: -784px 0px;">
 <a href="#05"> 鞋包配件</a>
</li>
</ul>
</div>
<div class="qcgdslist">
<h3>鞋包配件</h3>
<ul>
<%=getrec("9150",80) %>
<div class="clear"></div>
</ul>
</div>

</div>
<div class="clear"></div>
</div>


<%@include file="/inc/foot.jsp"%>
</body>
</html>