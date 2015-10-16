<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<SgGdsDtl> getsghot(long cls){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_cls", new Long(cls)));
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("sggdsdtl_sort"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 100);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}		


	public static class GdsMsTimeComparator implements Comparator<Product>{
	@Override
	public int compare(Product p0, Product p1) {
		
		if(p0.getGdsmst_promotionstart()!=null&&p1.getGdsmst_promotionstart()!=null){
			if(p0.getGdsmst_promotionstart().getTime()<p1.getGdsmst_promotionstart().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_promotionstart().getTime()==p1.getGdsmst_promotionstart().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}

public static String getmslist(long cls,int show){
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	  List<SgGdsDtl> sglist1=getsghot(cls); 
      if(sglist1!=null&&sglist1.size()>0){
      	int i=0;
      	String gdsid="";
      	 SimpleDateFormat mdfmt = new SimpleDateFormat("MM月dd日");
         SimpleDateFormat hourfmt = new SimpleDateFormat("hh时");
      	for(SgGdsDtl sg:sglist1){
      		gdsid=sg.getSggdsdtl_gdsid();
              Product product=ProductHelper.getById(gdsid);
              boolean ismiaoshao=false;
              if(product==null)continue;
             // if(show!=1){
              //if(i==3)break;
             // }
              Date nowday=new Date();
              int ysflag=0;
              if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
              	Date sdate=product.getGdsmst_promotionstart();
              	Date edate=product.getGdsmst_promotionend();	
              
              	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
              			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
              			&&product.getGdsmst_msprice().floatValue()>=0f){
              		ismiaoshao = true;
              	}
              	if(show==1){
              		if(ismiaoshao)continue;
    
              	if(nowday.getTime()<sdate.getTime()&&edate.getTime()> sdate.getTime()
              			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
              			&&product.getGdsmst_msprice().floatValue()>=0f){
              		ismiaoshao = true;
              	}

              }
              	//System.out.println(Tools.getDateDiff(ft.format(sdate),ft.format(edate)));
              	//System.out.println(sdate+"======="+edate);
              }
              if(!ismiaoshao)continue;
              i+=1;
             long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
            long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum() .longValue();
             String gdstitle=sg.getSggdsdtl_gdsname();
             if (gdstitle!=null&&gdstitle.length()>21){
            	 gdstitle=gdstitle.substring(0,21);
             }
             String gdsmemo=sg.getSggdsdtl_memo();
             if (gdsmemo!=null&&gdsmemo.length()>21){
            	 gdsmemo=gdsmemo.substring(0,21);
             }
             sb.append("<li>");
             sb.append("<table width=\"310\" height=\"450\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
             sb.append("<tr><td height=\"310\" colspan=\"5\"><a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images1.d1.com.cn").append(sg.getSggdsdtl_imgurl()).append("\" border=\"0\"></a></td></tr>");
             sb.append("<tr><td colspan=\"5\"  bgcolor=\"#e2e2e2\"><table><tr><td height=\"30\">&nbsp;</td>");
             sb.append("<td height=\"30\"><a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\" title=\"").append(sg.getSggdsdtl_gdsname()).append("\" class=\"title\">").append(gdstitle).append("</a></td>");
             sb.append("<td height=\"30\">&nbsp;</td> </tr>");
             sb.append("<tr><td height=\"30\">&nbsp;</td>");
             sb.append("<td height=\"30\" class=\"title2\" valign=\"top\">").append(gdsmemo).append("</td>");
             sb.append("<td height=\"30\">&nbsp;</td> </tr></table></td></tr>");
   
             sb.append("<tr><td width=\"82\" rowspan=\"2\" align=\"center\" bgcolor=\"#be1623\"><span  class=\"gdsxl\">限量</span> <br />");
             sb.append("<span  class=\"gdsxl2\">").append(sg.getSggdsdtl_vallnum()).append("件</span></td>");
            sb.append("<td width=\"7\" height=\"30\" bgcolor=\"#c6c6c6\">&nbsp;</td>");
            sb.append("<td colspan=\"2\" bgcolor=\"#c6c6c6\">商城价：￥").append(product.getGdsmst_memberprice()).append("</td>");
             String msbg="http://images.d1.com.cn/images2014/miaosha/sg006.jpg";
                 
            if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
          	  msbg="http://images.d1.com.cn/images2014/miaosha/sg008.jpg";
          	  gdsnum=0;
            }

            sb.append("<td width=\"96\" rowspan=\"2\" background=\"").append(msbg).append("\">");
             if (gdsnum<=0||gdsnum2<=0||product.getGdsmst_validflag().longValue()==2){
            	 
             }else{ 
            sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" height=\"80\">");
             sb.append(" <tr><td width=\"22%\">&nbsp;</td>");
             sb.append("   <td width=\"67%\" align=\"center\"><span class=\"msday\">仅剩<br />").append(gdsnum).append("件</span>");
             sb.append("   </td> <td width=\"11%\">&nbsp;</td> </tr>");
           sb.append(" </table>");
            }  
            sb.append("</td></tr>");
         sb.append(" <tr> <td bgcolor=\"#c6c6c6\">&nbsp;</td>");
          sb.append("  <td width=\"23\" bgcolor=\"#c6c6c6\"><img src=\"http://images.d1.com.cn/images2014/miaosha/sg009.jpg\" width=\"18\" height=\"33\" /></td>");
          sb.append("  <td width=\"102\" bgcolor=\"#c6c6c6\"><span class=\"gdsmsprice\">").append(product.getGdsmst_msprice()).append("</span></td>");
         sb.append(" </tr> </table>");
      sb.append("</li>");
     }
      	}
      return sb.toString();
}
public static String getmslistnew(){
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	StringBuilder sb=new StringBuilder();
	ArrayList<Product> list = new ArrayList<Product>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("sggdsdtl_sort"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 200);

	if(b_list!=null){
		for(BaseEntity be:b_list){
			SgGdsDtl sg=(SgGdsDtl)be ;
			Product p=ProductHelper.getById(sg.getSggdsdtl_gdsid());
		   	Date sdate=p.getGdsmst_promotionstart();
          	Date edate=p.getGdsmst_promotionend();	
			if(p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_promotionstart()!=null
					&&p.getGdsmst_promotionstart().getTime()>(new Date()).getTime()&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31){
				list.add(p);
			}
		}
	}

	Collections.sort(list,new GdsMsTimeComparator());
      if(list!=null&&list.size()>0){
      	int i=0;
      	String gdsid="";
          SimpleDateFormat mdfmt = new SimpleDateFormat("MM月dd日");
          SimpleDateFormat hourfmt = new SimpleDateFormat("hh时");
          for (Product product:list){
        	  gdsid=product.getId();
        		SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);

              boolean ismiaoshao=false;
              if(product==null)continue;
             // if(i==3)break;
 
         
              i+=1;
             long gdsnum=sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
             String gdstitle=sg.getSggdsdtl_gdsname();
             if (gdstitle!=null&&gdstitle.length()>21){
            	 gdstitle=gdstitle.substring(0,21);
             }
             String gdsmemo=sg.getSggdsdtl_memo();
             if (gdsmemo!=null&&gdsmemo.length()>21){
            	 gdsmemo=gdsmemo.substring(0,21);
             }
             sb.append("<li>");
             sb.append("<table width=\"310\" height=\"450\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
             sb.append("<tr><td height=\"310\" colspan=\"5\"><a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images1.d1.com.cn").append(sg.getSggdsdtl_imgurl()).append("\" border=\"0\"></a></td></tr>");
             sb.append("<tr><td colspan=\"5\" bgcolor=\"#e2e2e2\"><table><tr><td height=\"30\">&nbsp;</td>");
             sb.append("<td height=\"30\"><a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\" title=\"").append(sg.getSggdsdtl_gdsname()).append("\" class=\"title\">").append(gdstitle).append("</a></td>");
             sb.append("<td height=\"30\">&nbsp;</td> </tr>");
             sb.append("<tr><td height=\"30\">&nbsp;</td>");
             sb.append("<td height=\"30\" class=\"title2\" valign=\"top\">").append(gdsmemo).append("</td>");
             sb.append("<td height=\"30\">&nbsp;</td> </tr></table></td></tr>");
             sb.append("<tr><td width=\"82\" rowspan=\"2\" align=\"center\" bgcolor=\"#be1623\"><span  class=\"gdsxl\">限量</span> <br />");
             sb.append("<span  class=\"gdsxl2\">").append(sg.getSggdsdtl_vallnum()).append("件</span></td>");
            sb.append("<td width=\"7\" height=\"30\" bgcolor=\"#c6c6c6\">&nbsp;</td>");
            sb.append("<td colspan=\"2\" bgcolor=\"#c6c6c6\">商城价：￥").append(product.getGdsmst_memberprice()).append("</td>");
             String msbg="http://images.d1.com.cn/images2014/miaosha/sg007.jpg";

       
            sb.append("<td width=\"96\" rowspan=\"2\" background=\"").append(msbg).append("\">");
            sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" height=\"80\">");
             sb.append(" <tr><td width=\"22%\">&nbsp;</td>");
             sb.append("   <td width=\"67%\" align=\"center\"><span  class=\"msday\">").append(mdfmt.format(product.getGdsmst_promotionstart())).append(" <br />");
             sb.append(hourfmt.format(product.getGdsmst_promotionstart())).append("<br>即将开抢</span>");
             sb.append("   </td> <td width=\"11%\">&nbsp;</td> </tr>");
           sb.append(" </table></td></tr>");
         sb.append(" <tr> <td bgcolor=\"#c6c6c6\">&nbsp;</td>");
          sb.append("  <td width=\"23\" bgcolor=\"#c6c6c6\"><img src=\"http://images.d1.com.cn/images2014/miaosha/sg009.jpg\" width=\"18\" height=\"33\" /></td>");
          sb.append("  <td width=\"102\" bgcolor=\"#c6c6c6\"><span class=\"gdsmsprice\">").append(product.getGdsmst_msprice()).append("</span></td>");
         sb.append(" </tr> </table>");
      sb.append("</li>");
     }
      	}
      return sb.toString();
}

%>
<%response.sendRedirect("http://www.d1.com.cn#sgtop"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>闪购频道隆重登场-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="/res/js/jquery-1.3.2.min.js"></script>

<style type="text/css">
/*global*/
* {
	margin: 0;
	padding: 0;
}
body {
	color: #333;
	text-align:left;
	background:#fff;
	font-family: tahoma, arial, verdana, geneva, sans-serif;
	font-size: 14px;
}
img {
	border: 0;
}
ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}
a:link, a:visited {
	color: #333;
	text-decoration: none;
}
a:hover, a:active {
	color: #CC0000;
	text-decoration: none;
}
.allhd{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 125px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}
.mscj_box {
	width:845px;
	height:342px;
	top:0;
	left:0px;
	/*left:50%;
	margin:0 0 0 -422px;*/
	position:relative;
	background:#fff;
	z-index:0;
	overflow:hidden;
}
.mscj_box div.img {
	position:absolute;
	width:845px;
	height:310px;
	left:0;
	top:0;
	z-index:10;
	display:none;
}
.mscj_box div.loding {
	position:absolute;
	width:845px;
	height:310px;
	z-index:40;
	/*background:#fafafa url(loding.gif) no-repeat center 155px;*/
	left:0;
	top:0;
}
.mscj_box ul.panel {
	position:absolute;
	width:845px;
	height:32px;
	top:310px;
	z-index:20;
	left:0px;
}
.mscj_box ul.panel li {
	width:210px;
	/*width:180px;*/
	height:34px;
	float:left;
	margin-left:1px;
	display:inline;
	background:#000;
	filter:alpha(Opacity=50);
	Opacity:.5;
}
.mscj_box ul.panel li.last {
	width:210px;
	/*width:180px;*/
}
.mscj_box ul.panel li.on {
	filter:alpha(Opacity=80);
	Opacity:.8;
}
.mscj_box ul.title {
	position:absolute;
	width:845px;
	height:32px;
	top:310px;
	z-index:30;
	left:0px;
}
.mscj_box ul.title li {
	width:210px;
	/*width:180px;*/
	height:32px;
	float:left;
	margin-left:1px;
	display:inline;
}
.mscj_box ul.title li a {
	display:block;
	text-align:center;
	color:#FFFDFE;
	height:32px;
	line-height:30px;
}
.mscj_box ul.title li a:hover, .mscj_box ul.title li.on a {
	background:url(arrow_focus.gif) no-repeat center 26px;
}
.mscj_sidebar {
	width:220px;
}

#mshead{ width:135px; height:342px; overflow:hidden;} 
	
#mshead ul li{ display:block;width:135px;cursor:pointer;z-index:55; } 
.cur0{
	background-image: url(http://images.d1.com.cn/images2014/miaosha/sg015n.jpg);
	background-repeat: no-repeat;
	width:135px;cursor:pointer; height:177px;
}
.curn0{background-image: url(http://images.d1.com.cn/images2014/miaosha/sg015on.jpg);
	background-repeat: no-repeat;width:135px;cursor:pointer; height:177px;}
.cur1{
	background-image: url(http://images.d1.com.cn/images2014/miaosha/sg016n.jpg);
	background-repeat: no-repeat;width:135px;cursor:pointer; height:164px;
}
.curn1{background-image: url(http://images.d1.com.cn/images2014/miaosha/sg016on.jpg);
	background-repeat: no-repeat;width:135px;cursor:pointer; height:164px;}
.msbody{
	height:342px;
	width:845px;
	display:none;
} 
.msbody-con{ display:block;} 
.gdslist{width:966px; height:470px; background-color:#FFF;}
.gdslist2{width:966px; background-color:#FFF;}
.gdslist ul li{width: 310px;
padding-left: 9px;padding-top:9px;height:470px; float:left;} 
.gdslist2 ul li{width: 310px;
padding-left: 9px;padding-top:9px;height:470px; float:left;} 
.gdsxl{
	font-size:28px;
	font-weight: 800;
	color: #FFF;
	Font-family: "微软雅黑";
}
.gdsxl2{
	font-size:21px;
	font-weight: bold;
	color: #FFF;
	Font-family: 微软雅黑;
}
.gdsmsprice{
	font-size:38px;
	font-weight: 800;
	color: #bf1520;
	Font-family: "微软雅黑";
}
.msday{
	font-size:14px;
	color:#0c0c0c;
	line-height:22px;
}
.gdsmsprice2{
	font-size:38px;
	font-weight: 800;
	color: #fff;
	Font-family: "微软雅黑";
}
.hottxt{
	font-size:18px;
	color: #0c0c0c;
	Font-family: "微软雅黑";}
	.title{
font-size: 14px;
font-weight: normal;
color: #333;
line-height: 22px;
height: 22px;
overflow: hidden;
white-space: nowrap;
text-overflow: ellipsis;Font-family: "微软雅黑";
}
.gdslist a { color:#333; text-decoration:none;font-size: 14px;Font-family: "微软雅黑";}
.gdslist  a:hover{color:#3377ff;text-decoration:none;font-size: 14px;Font-family: "微软雅黑";}
.title2{font-size:14px;height: 18px;
line-height: 18px;
color: #FF6259;Font-family: "微软雅黑";}
.sgbanner{
	margin:10px auto;
	background-image: url(http://images.d1.com.cn/images2014/miaosha/sgbanner002.jpg);
	height:450px;
	background-position: center;
}
</style>
<script language="javascript">
$(document).ready(function(){ 
var intervalID; 
var curLi; 
$("#mshead  li").mouseover(function(){ 
curLi=$(this); 
intervalID=setInterval(onMouseOver,250);//鼠标移入的时候有一定的延时才会切换到所在项，防止用户不经意的操作 
}); 
function onMouseOver(){ 
	var lii=$("#mshead  li").index(curLi);
$(".msbody-con").removeClass("msbody-con"); 
$(".msbody").eq($("#mshead  li").index(curLi)).addClass("msbody-con"); 
if(lii==0){
	$(".cur1").addClass("curn1");
	$(".cur1").removeClass("cur1"); 
	$(".curn0").removeClass("curn0");
	curLi.addClass("cur0");
}else{
	$(".cur0").addClass("curn0");
	$(".cur0").removeClass("cur0"); 
	$(".curn1").removeClass("curn1");
	curLi.addClass("cur1");
}
} 
$("#mshead  li").mouseout(function(){ 
clearInterval(intervalID); 
}); 
}); 
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div class="allhd">
<img src="http://images.d1.com.cn/images2014/miaosha/sgright.jpg" width="125" height="356" border="0" usemap="#sgMap" />
<map name="sgMap" id="sgMap">
  <area shape="rect" coords="2,66,133,124" href="#01" />
  <area shape="rect" coords="1,124,136,182" href="#02" />
  <area shape="rect" coords="2,182,142,240" href="#03" />
  <area shape="rect" coords="3,240,143,299" href="#04" />
  <area shape="rect" coords="1,298,126,357" href="#05" />
</map>
</div>
<center>
<!--  <a href="http://www.d1.com.cn/product/01518255" target="_blank"><div class="sgbanner"></div></a>-->
<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table width="100%" height="342" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="135">
         <div id="mshead">
		  <ul>
		  <li class="cur0">&nbsp;
          </li>
          <li class="curn1">&nbsp;
          </li>
          </ul>
          </div>
        </td>
        <td width="845">
        <div class="msbody msbody-con" id="msbody1">
        <div ads_key="mscj" id="mscj_box" class="mscj_box ftl">
        <%
        String showflag=request.getParameter("show");
        int show=0;
        if(!Tools.isNull(showflag)){
        	show=1;
        }
        List<SgGdsDtl> sglisthot=getsghot(5); 
        String sghost="";
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
        if(sglisthot!=null&&sglisthot.size()>0){
        	int i=0;
        	String gdsid="";
        	
        	for(SgGdsDtl sg:sglisthot){
        		gdsid=sg.getSggdsdtl_gdsid();
                Product product=ProductHelper.getById(gdsid);
                boolean ismiaoshao=false;
                if(product==null)continue;
                if(i==4)break;
                Date nowday=new Date();
               
                if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
                	Date sdate=product.getGdsmst_promotionstart();
                	Date edate=product.getGdsmst_promotionend();	

                	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
                			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
                			&&product.getGdsmst_msprice().floatValue()>=0f){
                		ismiaoshao = true;
                	}
                	if(show==1){
                  		if(ismiaoshao)continue;
        
                  	if(nowday.getTime()<sdate.getTime()&&edate.getTime()> sdate.getTime()
                  			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
                  			&&product.getGdsmst_msprice().floatValue()>=0f){
                  		ismiaoshao = true;
                  	}

                  }
                	//System.out.println(Tools.getDateDiff(ft.format(sdate),ft.format(edate)));
                	//System.out.println(sdate+"======="+edate);
                }
                if(!ismiaoshao)continue;
                i+=1;
                double dl= Tools.getDouble(product.getGdsmst_msprice().doubleValue()*10/product.getGdsmst_memberprice().doubleValue(),1);
                double js= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()-product.getGdsmst_msprice().doubleValue(),1);
               String gdstitle=sg.getSggdsdtl_gdsname();
                if (gdstitle!=null&&gdstitle.length()>13){
               	 gdstitle=gdstitle.substring(0,13);
                }
                String gdsmemo=sg.getSggdsdtl_memo();
                if (gdsmemo!=null&&gdsmemo.length()>108){
                	gdsmemo=gdsmemo.substring(0,108);
                }
                long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
                long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum() .longValue();
                sghost+="<li><a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\" title=\""+sg.getSggdsdtl_gdsname()+"\">"+gdstitle+"</a></li>";  
        %>
  <div class="img dpn">
  <table width="845" height="310" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="310">
<a href="http://www.d1.com.cn/product/<%=gdsid %>" target="_blank"><img src="http://images1.d1.com.cn<%=sg.getSggdsdtl_imgurl() %>" border="0"></a>
</td>
        <td width="10">&nbsp;</td>
        <td><table width="100%" height="310" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="8%" height="38" bgcolor="#f6f6f6"><img src="http://images.d1.com.cn/images2014/miaosha/sg013.jpg" width="21" height="38" /></td>
            <td width="31%" bgcolor="#f6f6f6">
   <%if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
	   out.print("已抢光");
	   }else{%>         

            仅剩最后<span style="color:red"><%=sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue() %></span>件
            <%} %>
            </td>
            <td width="61%" bgcolor="#f6f6f6"><img src="http://images.d1.com.cn/images2014/miaosha/sg014.jpg" width="23" height="23" /></td>
          </tr>
          <tr>
            <td height="145" colspan="3"><span class="hottxt">
            <%=gdsmemo%>
            </span></td>
          </tr>
          <tr>
            <td height="80" colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="72" height="79" rowspan="2" align="center" bgcolor="#be1623"><span  class="gdsxl">限量</span> <br />
              <span  class="gdsxl2"><%=sg.getSggdsdtl_vallnum()%>件</span></td>
                <td width="56" height="26" bgcolor="#f6f6f6"  align="center">商城价</td>
                <td width="46" align="center"  bgcolor="#f6f6f6" >折扣价</td>
                <td width="52" align="center"  bgcolor="#f6f6f6" >节省</td>
                <td width="46" rowspan="2" bgcolor="#D70B52" align="left"><img src="http://images.d1.com.cn/images2014/miaosha/sg017.jpg" width="46" height="79" /></td>
                <td width="42" rowspan="2" align="right" bgcolor="#D70B52"><img src="http://images.d1.com.cn/images2014/miaosha/sg011.jpg" width="15" height="25" /></td>
                <td width="83" rowspan="2" bgcolor="#D70B52"><span class="gdsmsprice2"><%=product.getGdsmst_msprice() %></span></td>
                <td width="107" rowspan="2" bgcolor="#D70B52">
                <%if (gdsnum<=0||gdsnum2<=0 ||product.getGdsmst_validflag().longValue()==2){
	   %><img src="http://images.d1.com.cn/images2014/miaosha/sg010_3.jpg" width="80" height="35" border="0" />
	   <%
	   }else{%> 
                <a href="http://www.d1.com.cn/product/<%=gdsid %>" target="_blank"><img src="http://images.d1.com.cn/images2014/miaosha/sg010.jpg" width="80" height="35" border="0" /></a>
                <%} %></td>
              </tr>
              <tr>
                <td align="center"  bgcolor="#f6f6f6" >￥<%=product.getGdsmst_memberprice() %></td>
                <td align="center"  bgcolor="#f6f6f6" ><%=dl %>折</td>
                <td align="center"  bgcolor="#f6f6f6" >￥<%=js %></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table>
  </div>
<%}
        }%>
		<ul id="mscj_txt_bg" class="panel">
		<li></li>
		<li></li>
		<li></li>
		<li class="last"></li>
	</ul>
	<ul id="mscj_txt" class="title">
				<%=sghost %>
  </ul>
	<div id="mscj_loding" class="loding"></div>
</div>
</div>


  <div class="msbody" id="msbody2">
        <div ads_key="mscj" id="mscj_box2" class="mscj_box ftl">
        <% String strtxt="";
ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("3641",4);
if(list!=null&&list.size()>0)
{
	for(int i=0;i<list.size();i++){
	if(list.get(i)!=null)
	{
	  strtxt+="<li><a href=\""+list.get(i).getSplmst_url()+"\" target=\"_blank\" title=\""+list.get(i).getSplmst_name()+"\">"+list.get(i).getSplmst_name()+"</a></li>";
	%>
  <div class="img dpn"><a href="<%=list.get(i).getSplmst_url() %>" target="_blank" title="<%=list.get(i).getSplmst_name() %>"><img class="img_directly_load" src="<%=list.get(i).getSplmst_picstr() %>" alt="<%=list.get(i).getSplmst_name() %>" /></a></div>
		<%}
	}
	} %>
<ul id="mscj_txt_bg2" class="panel">
		<li></li>
		<li></li>
		<li></li>
		<li class="last"></li>
	</ul>
	<ul id="mscj_txt2" class="title">
	<%=strtxt %>
  </ul>
	<div id="mscj_loding2" class="loding"></div>
</div>
</div>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a name="01"></a><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="3"><img src="http://images.d1.com.cn/images2014/miaosha/sg001.jpg" width="980" height="83" /></td>
      </tr>
       <tr>
        <td height="8" colspan="3" align="center" bgcolor="#08A6A5">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" bgcolor="#08A6A5" width="7">
       
        </td>
        <td align="center" > <div class="gdslist2">
        <ul>
      
         <%=getmslist(1,show) %>
        </ul>
        </div></td>
        <td align="center" bgcolor="#08A6A5" width="7"></td>
      </tr>
       <tr>
        <td colspan="3" align="center" bgcolor="#08A6A5">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a name="02"></a><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="3"><img src="http://images.d1.com.cn/images2014/miaosha/sg002.jpg" width="980" height="83" /></td>
      </tr>
     
      <tr>
        <td height="8" colspan="3" align="center" bgcolor="#E31B71">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" bgcolor="#E31B71" width="7">
       
        </td>
        <td align="center" > <div class="gdslist2">
        <ul>
      
         <%=getmslist(3,show) %>
        </ul>
        </div></td>
        <td align="center" bgcolor="#E31B71" width="7"></td>
      </tr>
       <tr>
        <td colspan="3" align="center" bgcolor="#E31B71">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a name="03"></a><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="3"><img src="http://images.d1.com.cn/images2014/miaosha/sg003.jpg" width="980" height="83" /></td>
      </tr>
  
      
        <tr>
        <td height="8" colspan="3" align="center" bgcolor="#08A6A5">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" bgcolor="#08A6A5" width="7">
       
        </td>
        <td align="center" > <div class="gdslist2">
        <ul>
      
         <%=getmslist(2,show) %>
        </ul>
        </div></td>
        <td align="center" bgcolor="#08A6A5" width="7"></td>
      </tr>
       <tr>
        <td colspan="3" align="center" bgcolor="#08A6A5">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a name="04"></a><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="3" ><img src="http://images.d1.com.cn/images2014/miaosha/sg004.jpg" width="980" height="83" /></td>
      </tr>
        <tr>
        <td height="8" colspan="3" align="center" bgcolor="#E31B71">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" bgcolor="#E31B71" width="7">
       
        </td>
        <td align="center" > <div class="gdslist2">
        <ul>
      
         <%=getmslist(4,show) %>
        </ul>
        </div></td>
        <td align="center" bgcolor="#E31B71" width="7"></td>
      </tr>
       <tr>
        <td colspan="3" align="center" bgcolor="#E31B71">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a name="05"></a><table width="980" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="3" ><img src="http://images.d1.com.cn/images2014/miaosha/sg005.jpg" width="980" height="83" /></td>
      </tr>
         <tr>
        <td height="8" colspan="3" align="center" bgcolor="#E31B71">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" bgcolor="#E31B71" width="7">
       
        </td>
        <td align="center"> <div class="gdslist2">
        <ul>
      
         <%=getmslistnew() %>
        </ul>
        </div></td>
        <td align="center" bgcolor="#E31B71" width="7"></td>
      </tr>
       <tr>
        <td colspan="3" align="center" bgcolor="#E31B71">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</center>
<script type="text/javascript">
//---------- start index focus
function mscj_change()
{
	var self_now = 0;
	var self_speed = 5000;
	var self_auto_change = null;
	var self_max = $('#mscj_box div.img').size();
	function self_change(i)
	{
		$('#mscj_box div.img').hide();
		$('#mscj_txt_bg li').removeClass('on');
		$('#mscj_txt li').removeClass('on');
		$('#mscj_box div.img:eq(' + i + ')').show();
		$('#mscj_txt_bg li:eq(' + i + ')').addClass('on');
		$('#mscj_txt li:eq(' + i + ')').addClass('on');
	}
	function self_interval()
	{
		return setInterval(function(){
			self_now++;
			if (self_now >= self_max)
			{
				self_now = 0;
			}
			self_change(self_now);
		}, self_speed);
	}
	$('#mscj_box div:first').show();
	$('#mscj_txt_bg li:first').addClass('on');
	$('#mscj_txt li:first').addClass('on');
	$('#mscj_txt li').each(function(i)
	{
		$(this).mouseover(function(){
			self_now = i;
			clearInterval(self_auto_change);
			self_change(i);
		}).mouseout(function(){
			self_auto_change = self_interval();
		});
	});
	$(function(){
		$('#mscj_loding').hide();
		self_auto_change = self_interval();
	});
}
function mscj_change2()
{
	var self_now2 = 0;
	var self_speed2 = 5000;
	var self_auto_change2 = null;
	var self_max2 = $('#mscj_box2 div.img').size();
	function self_change2(i)
	{
		$('#mscj_box2 div.img').hide();
		$('#mscj_txt_bg2 li').removeClass('on');
		$('#mscj_txt2 li').removeClass('on');
		$('#mscj_box2 div.img:eq(' + i + ')').show();
		$('#mscj_txt_bg2 li:eq(' + i + ')').addClass('on');
		$('#mscj_txt2 li:eq(' + i + ')').addClass('on');
	}
	function self_interval2()
	{
		return setInterval(function(){
			self_now2++;
			if (self_now2 >= self_max2)
			{
				self_now2 = 0;
			}
			self_change2(self_now2);
		}, self_speed2);
	}
	$('#mscj_box2 div:first').show();
	$('#mscj_txt_bg2 li:first').addClass('on');
	$('#mscj_txt2 li:first').addClass('on');
	$('#mscj_txt2 li').each(function(i)
	{
		$(this).mouseover(function(){
			self_now2 = i;
			clearInterval(self_auto_change2);
			self_change2(i);
		}).mouseout(function(){
			self_auto_change2 = self_interval2();
		});
	});
	$(function(){
		$('#mscj_loding2').hide();
		self_auto_change2 = self_interval2();
	});
}
mscj_change();
mscj_change2();
//---------- end index focus
</script>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
