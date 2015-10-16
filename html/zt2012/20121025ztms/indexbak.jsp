<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
/**
 * 根据推荐位号查询推荐商品信息
 * @param code - 推荐号
 * @param count - 取几位，如果<=0则为100
 * @return ArrayList<PromotionProduct>
 */
public static ArrayList<PromotionProduct> getPromotionProductByCode(String code , int count){
	if(!Tools.isMath(code)) return null;
	if(count <= 0) count = 100;
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long(code)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	olist.add(Order.desc("spgdsrcm_begindate"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
	if(clist==null||clist.size()==0)return null;
	
	int total = 0 ;
	for(BaseEntity be:list){
		PromotionProduct pp = (PromotionProduct)be;
		Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
		if(product == null ) continue;
		rlist.add(pp);
		total++;
		if(total==count)break;
	}
	return rlist ;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>72小时秒杀-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script language="javascript" type="text/javascript">

function $getid(id)
{
    return document.getElementById(id);
}
function view_time(the_s_index,objid){
	 if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
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
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";
    }
}
	
</script>
<style type="text/css" >
.ms{width:980px; margin:0px auto; }
.ms span em{display:block; float:left; width:83px; height:89px; text-align:center;}
.ms table ul{ list-style:none; width:980px; overflow:hidden; margin-bottom:20px;}
.ms table  li{ width:300px; height:400px; float:left; margin-left:20px; position:relative;}
.ms table  li div{ position:absolute; top:0px; left:5px; width:70px; height:99px;}
.ms table  li p{ height:100px; background:#fff3b3;}
.ms table  li .span1{ display:block; width:290px; height:35px; line-height:45px; color:#000; font-size:15px; text-align:center; font-family:'微软雅黑';
   padding:5px;}
.ms table  li .span2{ display:block; width:115px; height:85px; _hieght:65px;line-height:55px; _line-height:35px; color:#000; font-size:13px;text-align:center; font-family:'微软雅黑';
float:left;"}

</style>
</head>

<body>
<%@include file="/inc/head.jsp" %>
<div class="ms">
<table id="__01" width="980" height="2300" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_01.gif" width="461" height="421" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_02.jpg" width="519" height="421" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" height="89" style="background:url('http://images.d1.com.cn/zt2012/20121025ztms/xsq_03.jpg') no-repeat;">
		    <span id="xstj_1" style="display:block; width:440px; overflow:hidden;  float:right; height:89px; overflow:hidden; line-height:103px; font-size:30px; color:#fff; font-family:'微软雅黑';font-weight:bold;">
		    <em>00</em><em>00</em><em>00</em>
 <%
    SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    int flag=0;//不是周末
    //获取时间
    String	nowtime= DateFormat.format(new Date());
    String endtime="";
    Date now=new Date();
    int times=now.getHours();//当前小时数
    int level=25;
    long dates=(now.getTime()-DateFormat.parse("2012/10/26 00:00:00").getTime())/(24*60*60*1000);//获取多少天
    long jl=dates+1;
    int jd=1;
   // if(now.after(DateFormat.parse("2012/10/26 23:59:59")))
  //  {
    	//endtime="2012/10/29 11:59:59";
    //	flag=1;
   // } 
  //  else{
    	if(times<=18&&times>=11)
        {
        	now.setHours(18);
        	now.setMinutes(59);
        	now.setSeconds(59);
        	endtime=DateFormat.format(now);
        	jd=2;
        }
        else if(times<11&&times>=3)
        {
        	now.setHours(10);
        	now.setMinutes(59);
        	now.setSeconds(59);
        	endtime=DateFormat.format(now);
        	jd=1;
        }
        else
        {
        	now.setDate(now.getDate()+1);
        	now.setHours(2);
        	now.setMinutes(59);
        	now.setSeconds(59);
        	endtime=DateFormat.format(now);
        	jd=3;
        }
        flag=0;
   // }
    
    
%>
<script type="text/javascript" language="javascript">
       var the_s=new Array();
       var startDate= new Date('<%=nowtime%>');
       var endDate= new Date('<%=endtime%>');
       the_s[0]=(endDate.getTime()-startDate.getTime())/1000;
       //view_time('0','xstj_1')
       setInterval("view_time('0','xstj_1')",1000);
</script>
</span>
			</td>
	</tr>
	<tr>
		<td colspan="2" style="background:#ec74be;">
		<% 
		
		  StringBuilder sb=new StringBuilder(); 
		  ArrayList<PromotionProduct> plist=new ArrayList<PromotionProduct>();
		  if(flag==0){	
		  plist=getPromotionProductByCode("8171", 100);
		  if(plist!=null&&plist.size()>0)
		  {
			  sb.append("<ul>");
			  int count=0;
			  for(int i=0;i<10;i++)
			  {
				  int size=(9*((int)jl-1))+(i+(jd-1)*3);
				  PromotionProduct pp=plist.get(size);
				  if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
				  {					 
					  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					  if(product!=null)
					  {
						  count++;
						  if(count>3){break;}
						  sb.append("<li><a href=\"/product/"+product.getId()+"\" target=\"_blank\"><img src=\""+ProductHelper.getImageTo400(product)+"\" width=\"300\" height=\"300\"/></a>");
						  if(product.getGdsmst_validflag().longValue()==1&&product.getGdsmst_ifhavegds().longValue()==0)
						  {
							  sb.append("<div><img src=\"http://images.d1.com.cn/zt2012/20121025ztms/ms.png\"/></div>");
						  }
						  else{
							  
							  sb.append("<div><img src=\"http://images.d1.com.cn/zt2012/20121025ztms/sq.png\"/></div>");
						  }
						  
						  sb.append("<p><span class=\"span1\"><a href=\"/product/"+product.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(pp.getSpgdsrcm_gdsname()),35)+"</a></span>");
						  sb.append("<span class=\"span2\">原价："+Tools.getFloat(product.getGdsmst_oldmemberprice(), 1)+"</span>");
						  sb.append("<span style=\"display:block; float:left; height:85px; line-height:45px; color:#cc202e; font-size:30px;text-align:center; font-family:'微软雅黑';font-weight:bold;\">秒杀价:"+Tools.getFloat(product.getGdsmst_memberprice(), 1)+"</span>");
						  sb.append("</p>");
						  sb.append("</li>");
					  }
				  }
			  }
			  sb.append("</ul>");
		  }
		  out.print(sb.toString());
		  }
		 // else
		 // {
			//  plist=getPromotionProductByCode("8187", 100);
			//  if(plist!=null&&plist.size()>0)
			//  {
				//  sb.append("<ul>");
				//  int count=0;
				//  for(PromotionProduct pp:plist)
				//  {					 
					//  if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
					//  {					 
					//	  Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
					//	  if(product!=null&&product.getGdsmst_validflag().longValue()==1&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_oldmemberprice().floatValue()!=0&&product.getGdsmst_discountenddate().after(new Date())&&Tools.dateValue(product.getGdsmst_discountenddate())<(System.currentTimeMillis()+Tools.MONTH_MILLIS))
					//	  {
						//	  count++;
						//	  if(count>3){break;}
						//	  sb.append("<li><a href=\"/product/"+product.getId()+"\" target=\"_blank\"><img src=\""+ProductHelper.getImageTo400(product)+"\" width=\"300\" height=\"300\"/></a>");
						//	  sb.append("<div><img src=\"http://images.d1.com.cn/zt2012/20121025ztms/ms.png\"/></div>");
						//	  sb.append("<p><span class=\"span1\"><a href=\"/product/"+product.getId()+"\" target=\"_blank\">"+Tools.substring(Tools.clearHTML(pp.getSpgdsrcm_gdsname()),35)+"</a></span>");
						//	  sb.append("<span class=\"span2\">原价："+Tools.getFloat(product.getGdsmst_oldmemberprice(), 1)+"</span>");
						//	  sb.append("<span style=\"display:block; float:left; height:85px; line-height:45px; color:#cc202e; font-size:30px;text-align:center; font-family:'微软雅黑';font-weight:bold;\">秒杀价:"+Tools.getFloat(product.getGdsmst_memberprice(), 1)+"</span>");
						//	  sb.append("</p>");
						//	  sb.append("</li>");
						//  }
					//  }
				 // }
				//  sb.append("</ul>");
			//  }
			//  out.print(sb.toString());
		//  }
		%>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_05.jpg" width="980" height="14" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/html/zt2012/20121025ztms/mslist.jsp?id=1" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_06.jpg" width="980" height="321" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_07.jpg" width="980" height="12" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/html/zt2012/20121025ztms/mslist.jsp?id=2" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_08.jpg" width="980" height="321" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_09.jpg" width="980" height="13" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/html/zt2012/20121025ztms/mslist.jsp?id=3" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_10.jpg" width="980" height="321" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_11.jpg" width="980" height="15" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/html/zt2012/20121025ztms/mslist.jsp?id=4" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_12.jpg" width="980" height="321" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121025ztms/xsq_13.jpg" width="980" height="17" alt=""></td>
	</tr>
</table>
</div>


<%@include file="/inc/foot.jsp" %>
</body>
</html>
