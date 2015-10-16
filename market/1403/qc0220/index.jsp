<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static int getPProductByCode(String code,String rackcode,int num){
	//ArrayList<Product> rlist = new ArrayList<Product>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	//clist.add(Restrictions.le("spgdsrcm_seq",new Long(100)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num+10);
	if(list==null||list.size()==0)return 0;	
	int total = 0 ;
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null ) continue;
	
			if(!Tools.isNull(rackcode)&&!rackcode.equals("null")){
				
			if(rackcode.indexOf(",")>=0){				
				if(!Tools.isNull(product.getGdsmst_rackcode())&&rackcode.indexOf(product.getGdsmst_rackcode().substring(0,3))==-1)continue;
			}else{
				//System.out.println(rackcode+"-------------------------");
			if(!Tools.isNull(product.getGdsmst_rackcode())
					&&!product.getGdsmst_rackcode().startsWith(rackcode))continue;
			}
			}
	
			//rlist.add(product);
			total++;
			if(total==num)break;
		}
	}
		
	return total ;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>


<title>春装特卖 第二季震撼来袭 --D1优尚</title>
<style type="text/css">

body{font:12px/1.5 Arial,"宋体";color:#4b4b4b; background:#fff;}
* html,* html body{background-image:url(about:blank);background-attachment:fixed;}
table{border-collapse:collapse;}
fieldset,img{border:none;}
address,caption,cite,code,dfn,th,var,em{font-weight:normal;}
ol,ul{list-style:none;}
ul,li{padding:0px;margin:0px;}
caption,th{text-align:left;}
h1,h2,h3,h4,h5,h6{font-size:100%;}
input,select,button{vertical-align:middle;font-size:12px;}
address,em{font-style:normal;}
img{display:inline-block;}
a {text-decoration:none;color:#4b4b4b}
a:hover {color:#aa2e44}
del {font-family:'微软雅黑'}
.c99 {color:#999;}
.m_r10 {margin-right:10px}
.m_b10 {margin-bottom:10px;}
.f_l {float:left}
.f_r {float:right; line-height:34px;}
.t_r {text-align:right}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}

.allhd{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 150px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}


.qcbanner{
	margin:0px auto;
	background-image: url(http://images.d1.com.cn/zt2014/0220qc/qc_header-2.jpg);
	height:579px;
	background-position: center;
}
.tmbody{ margin:0px auto; width:980px; background:#167e1b;padding-top:10px;}
.tmmenu{ width:970px;margin:0px auto; height:34px; padding:3px 0px 3px 0px; background:#fff;}
.tmmenu li{
	height:34px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #b5b5b5;
	font-family: 微软雅黑;
	color:#197d1a;
	line-height:34px;
	float:left;
	font-weight:800;
}
.tmmenu .top{ font-size:16px;color:#e8020c; }
.tmmenu .end{border-right-color: #fff;}
.tmmenu a {display: block;
		padding-right: 20px;
	padding-left: 20px;
	height:100%;text-decoration:none;color:#197d1a}
.tmmenu a:hover {color:#aa2e44}

.cur{color:#aa2e44}
.qcgdslist{ width:980px;padding-top:8px;}
.qcgdslist ul li{
	width:240px;
	float:left;
	margin:0px 0px 8px 2px;
	background-color: #fff;
	border: 1px solid #bafc12;
}
.gdstitle{ font-size:12px; color:#333;font-family:微软雅黑; line-height:21px}
.qcgdst{
	font-size:21px;
	color:#FFF;
	font-family:"微软雅黑";
	line-height: 25px;
}
.qcgdsp{
	font-size:34px;
	color:#FFF;
	font-family:"微软雅黑";
	font-weight:800;
	line-height: 36px;
}
.qcgdsp2{
	font-size:14px;
	color:#687a6c;
	font-family:"微软雅黑";
	line-height: 18px;
}
.gdslistimg{ position:relative;}
.gdslistimgl{ position:absolute; top:0px; left:0px; z-index:999}
.gdslistimgl2{ position:absolute; top:20px; left:40px; z-index:999}
.gdslistimgl3{ position:absolute; top:70px; left:40px; z-index:999}
.moreadd20{
	height:33px;
	width:970px;
	text-align:center;
	background-color: #fff;
	line-height:30px;
	font-family:"微软雅黑";
	
}
.moreadd20 a:hover {
background: #bdbfbe;
}
.moreadd20 a {
	display: block;
	width:970px;
	height:100%;
	font-size: 16px;
	font-weight: bold;
	font-family:"微软雅黑";
}
.none{ display:none;}


.qcbanner2{
	margin:10px auto;
	background-image: url(http://images.d1.com.cn/zt2014/0220qc/qc_header-2.jpg);
	height:579px;
	background-position: center;
}

.topbannerdiv{	position:relative; width:980px; height:150px; margin: 0px auto;padding-top:300px;}
.link1{
	position:absolute;
	width:90px;
	height:40px;
	left:600px;
	top: 260px;
}
.link2{
	position:absolute;
	width:140px;
	height:40px;
	left:240px;
	top: 250px;
	font-size:18px;color:#178e29;font-weight: bold;font-family:"微软雅黑"
}
.tktcardno{
	position:absolute;
	width:215px;
	height:40px;
	left:370px;
	top: 245px;
}
</style>
<%
int allcount =getPProductByCode("9181","",1000);
int allcount014 =getPProductByCode("9181","014",1000);
int allcount020 =getPProductByCode("9181","020",1000);
int allcount030 =getPProductByCode("9181","030",1000);
int allcount012 =getPProductByCode("9181","012",1000);
int allcount021031 =getPProductByCode("9181","021,031",1000);
int allcount050 =getPProductByCode("9181","050",1000);
int allcount015009 =getPProductByCode("9181","015009",1000);
int allcount015002 =getPProductByCode("9181","015002",1000);
%>
<script type="text/javascript">

var pageno=11;
var rackcode=""
function moreadd20(){
	var pagecount=20;
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "getqclist.jsp",
            data:{pageno: pageno,rackcode:rackcode,pagecount:pagecount},
            success: function(msg) {
            	pageno=pageno+1;
            	 $("#qcgdslistul").append(msg);
            }

            });
    
}
function getrckshow(rackcode1,pagecount){
	var countrck=<%=allcount%>;
	if(rackcode1=="014"){
		countrck=<%=allcount014%>;
	}else if(rackcode1=="020"){
		countrck=<%=allcount020%>;
	}else if(rackcode1=="030"){
		countrck=<%=allcount030%>;
	}else if(rackcode1=="012"){
		countrck=<%=allcount012%>;
	}else if(rackcode1=="021,031"){
		countrck=<%=allcount021031%>;
	}else if(rackcode1=="050"){
		countrck=<%=allcount050%>;
	}else if(rackcode1=="015009"){
		countrck=<%=allcount015009%>;
	}else if(rackcode1=="015002"){
		countrck=<%=allcount015002%>;
	}
	pageno=1;
	rackcode=rackcode1;
	var pagenum=countrck/20;
	if(countrck%20>0) {
		pagenum=pagenum+1;
     }
	
	$(".cur").removeClass("cur"); 
	$(this).addClass("cur"); 
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "getqclist.jsp",
            data:{pageno: pageno,rackcode:rackcode1,pagecount:pagecount},
            success: function(msg) {
            	pageno=11;
            	if(pageno>pagenum){
            		$("#moreadd20").addClass("none"); 
            	}
            	 $("#qcgdslistul").html(msg);
            	 if(rackcode1!=""){
            	 $('body,html').animate({scrollTop:630},1000);
            	 }
            }

            });
    
}


$(document).ready(function() {
	var countrck=<%=allcount%>;
	getrckshow('',200);	
	var pagenum=countrck/20;
	if(countrck%20>0) {
		pagenum=pagenum+1;
     }
	if(pageno>pagenum){
		$("#moreadd20").addClass("none"); 
	}
	});


function gettkt(){
                $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "gettkt.jsp",
                        success: function(json) {
                           if (json.urlflag){
                        	   $.alert(json.message);
                                }else{
                                $.alert(json.message);
                                }
                        }

                        });
        }


</script>
</head>
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
<body>
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="allhd">

<table id="__01" width="150" border="0" cellpadding="0" cellspacing="0">
<tr>
<td align="center">
</td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('014',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_01.png" width="150" height="86" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('020',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_02.png" width="150" height="34" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('030',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_03.png" width="150" height="44" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('012',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_05.png" width="150" height="46" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('021,031',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_06.png" width="150" height="44" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('050',200)"  ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_07.png" width="150" height="43" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('015009',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_08.png" width="150" height="43" alt=""></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getrckshow('015002',200)" ><img src="http://images.d1.com.cn/zt2014/0220qc/xuanfutiao_09.png" width="150" height="51" alt=""></a></td>
	</tr>
</table>
</div>
<div style=" background:#94d203">

<div class="qcbanner2">
  <div class="topbannerdiv" > <span class="link2">请输入兑换码：</span><input name="tktcardno" id="tktcardno" type="text" class="tktcardno"  />
<a href="javascript:ActivateTicket();" ><span class="link1"> 
</span></a>
</div>
</div>


<div class="tmbody">
    <div class="tmmenu">
    <ul>
    <li class="top"><a href="javascript:void(0)" onclick="getrckshow('',200)" class="cur" >全部特卖(<%=getPProductByCode("9181","",1000) %>) </a></li>
    <li><a href="javascript:void(0)" onclick="getrckshow('014',200)" >化妆品(<%=getPProductByCode("9181","014",1000) %>)</a> </li>
    <li><a href="javascript:void(0)" onclick="getrckshow('020',200)" >女装(<%=getPProductByCode("9181","020",1000) %>)</a></li>
    <li><a href="javascript:void(0)" onclick="getrckshow('030',200)" >男装(<%=getPProductByCode("9181","030",1000) %>)</a></li>
    <li><a href="javascript:void(0)" onclick="getrckshow('012',200)" >家居(<%=getPProductByCode("9181","012",1000) %>)</a></li>
    <li><a href="javascript:void(0)" onclick="getrckshow('021,031',200)" >鞋(<%=getPProductByCode("9181","021,031",1000) %>) </a></li>
    <li><a href="javascript:void(0)" onclick="getrckshow('050',200)"  >包(<%=getPProductByCode("9181","050",1000) %>)</a> </li>
    <li><a href="javascript:void(0)" onclick="getrckshow('015009',200)" >饰品(<%=getPProductByCode("9181","015009",1000) %>)</a> </li>
    <li class="end"><a href="javascript:void(0)" onclick="getrckshow('015002',200)" >名品(<%=getPProductByCode("9181","015002",1000) %>)</a></li>
    </ul>
    </div>
    
 <div class="qcgdslist">
       <ul id="qcgdslistul">
  </ul>
    </div>
    <div class="clear"></div>
    <div class="moreadd20" id="moreadd20"><a href="javascript:moreadd20();"> 再显示20条特卖<span><img src="http://images.d1.com.cn/zt2014/0220qc/tm003.jpg" width="14" height="10" /></span></a></div>
</div>

</div>

<%@include file="/inc/foot.jsp"%>
</body>
</html>
