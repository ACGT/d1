<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	clist.add(Restrictions.le("spgdsrcm_begindate",new Date()));
	clist.add(Restrictions.ge("spgdsrcm_enddate",new Date()));

	//加入排序条件
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num);
	if(list==null||list.size()==0)return null;	
	for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			rlist.add(pp);
		}
	return rlist ;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网易抽奖-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="http://mimg.127.net/xm/all/point_club/110622/css/style.css"		rel="stylesheet" type="text/css"/>
<link href="http://mimg.127.net/xm/all/point_club/progress/medaltalent/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style>
.list{
	width:944px;
	margin: 0 auto;
	overflow: hidden;
	border: 1px solid #CCCCCC;
}
.lines{
	border-right: 1px dotted #CCC;
}
.listshow {
float: left;
padding: 0 10px;
width: 215px;
height: 297px;
margin: 20px 0;
}
.clear{clear:both;font-size:0;line-height:0;height:0;overflow:hidden}
.listshow_title{ line-height:21px; height:44px;}
.listshow_pic{position: relative;zoom: 1;}
.listshow_but{ text-align:left;height:35px;}
.desc {
/*position: relative;*/
zoom: 1;
display: block;
color:#000;
z-index: 2;
height: 20px;
font-size: 12px;
line-height: 20px;
text-align: center;
/*background-color: RGBA(0,0,0,.2);
margin-top: -20px;*/
}
.dhnum {color: #F60; font-weight:800;}
.rsfont{font-size: 12px;color:#7D7D7D}
</style>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<center><div class="list">
<%ArrayList<PromotionProduct> pproductlist=getPProductByCode("8558",100);

if(pproductlist!=null && pproductlist.size()>0){
	int num=0;
	for(PromotionProduct pproduct:pproductlist){
		SimpleDateFormat sf1 = new SimpleDateFormat("MM.dd");
		SimpleDateFormat sf2 = new SimpleDateFormat("yyyy.MM.dd");
		long hit=0;
		if(pproduct.getSpgdsrcm_tghit()!=null && pproduct.getSpgdsrcm_tghit()>0){
			hit=pproduct.getSpgdsrcm_tghit();	
		}
		long lcount=((new Date().getTime()-pproduct.getSpgdsrcm_begindate().getTime())/1000/60/30)*hit;//每3分钟**个
		String showcss="lines";
		if (num%4==0&&num!=0){
			showcss="";
		}
		%><div class="listshow <%=showcss%>">
	     <div class="listshow_title"><h5><a target="_blank" href="<%=pproduct.getSpgdsrcm_otherlink()%>"><span style="color: #C00;">【兑换】</span><%=pproduct.getSpgdsrcm_gdsname() %></a></h5>
		 </div>
		 <div class="listshow_pic">
		 <a target="_blank" href="<%=pproduct.getSpgdsrcm_otherlink()%>"><img src="<%=pproduct.getSpgdsrcm_otherimg() %>" width="215" height="215" class="picShow" />	</a>
		<p class="desc">时间：<%=sf2.format(pproduct.getSpgdsrcm_begindate()) %>—<%=sf2.format(pproduct.getSpgdsrcm_enddate()) %></p>
		 </div>
		 <div class="listshow_but">
		   <table height="34" >
  <tr>
    <td class="rsfont" width="130">参加人数：(<span class="dhnum"><%=lcount %></span>)</td>
    <td><a target="_blank" href="<%=pproduct.getSpgdsrcm_otherlink()%>"><img src="http://images.d1.com.cn/market/1304/dhbut.png" width="80" height="20"/></a></td>
  </tr>
</table>
		 </div>
	</div>
		 <%
		 num++;	 
	}
}
	%>
	</div>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
