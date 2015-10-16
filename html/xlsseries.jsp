<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static class GdscollTimeComparator implements Comparator<Gdscoll>{

	@Override
	public int compare(Gdscoll p0, Gdscoll p1) {	
		
		if(p0.getGdscoll_createdate().getTime() >p1.getGdscoll_createdate().getTime()){
			return 0 ;
		}else if(p0.getGdscoll_createdate().getTime()==p1.getGdscoll_createdate().getTime()){
			return 1 ;
		}else{
			return -1 ;
		}
	}
}

static ArrayList<Gdscoll> getGdscollBySerid(String serid){
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
     String[] arrserid=serid.split(",");
     for(int i=0;i<arrserid.length ;i++ ){
	ArrayList<Gdscoll> scolllist=GdscollHelper.getGdscollBysceneid(arrserid[i]);
	if(scolllist!=null && scolllist.size()>0){
		for(Gdscoll s:scolllist){
			list.add(s);
		}
	}
     }
     Collections.sort(list,new GdscollTimeComparator());
	return list;
}
%>
<%
   String scontent="精致甜美系列";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>小栗舍精致甜美系列【图片_价格_评价_怎么样】</title>
<meta name="keywords" content="小栗舍<%= scontent %>系列报价、促销、新闻、评论、导购、图片" />
<meta name="description" content="D1优尚网是国内唯一在线销售小栗舍<%= scontent %>系列商品，提供小栗舍<%= scontent %>系列的最新报价、促销、评论、导购、图片等相关信息" />

<style>
   .fmlist{ width:980px; background:url('http://images.d1.com.cn/images2012/fmdpbg3_1.jpg') repeat-y; margin-top:10px;}
   .fmlist ul{ list-style:bnone; margin:0px;padding:0px;}
   .fmlist ul li { margin-left:-60px; +margin-left:-64px; height:400px; float:left;}
    .fmlist ul li p{ margin-top:11px; margin-left:35px; width:175px;}
   .fmlist ul li p a { color:#9F486A;}
   .fmlist ul li p span{ display:block; width:80px; text-align:left; float:left;} 
   .fmlist ul li p span font{ font-size:12px; color:#9F486A;;}
   .newbanner1120 {position: fixed; width:980px;z-index: 20000;top: 0px;text-align: left;background:#fff;height:35px; line-height:35px;
filter:alpha(opacity=70); /*IE*/
-moz-opacity:0.7; /*MOZ , FF*/
opacity:0.7; /*CSS3, FF1.5*/	
	background-color: #000000;}
	.newbanner1120 li {width: 45px;float: left;position: relative;margin-top: 0px;color: white;font-size: 14px;text-align: center;font-family: "微软雅黑";}
	.newbanner1120 li a {color: white;font-size: 14px;text-decoration: none;text-transform: uppercase;padding: 1px 9px;white-space: nowrap;font-family: "微软雅黑";}
   </style>
   </head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->



<div class="albody">
	<div class="autobody" style=" background:#fbd2e4;">

		
			
	  <div class="fmlist">
	  <table><tr><td>
		     <%
		  
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=getGdscollBySerid("5,6,7");
			if(scolllist!=null && scolllist.size()>0){
				%>
				<ul>
				<%
				isscoll=true;
				int count=0;
				for(int i=0;i<scolllist.size();i++){
					Gdscoll scoll=scolllist.get(i);
					if(scoll!=null&&scoll.getGdscoll_flag()!=null&&scoll.getGdscoll_flag().longValue()==1){
						//查看搭配详细
						int counts=0;
   					    ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(scoll.getId());
						if(gdetaillist!=null)
						{
							for(Gdscolldetail gd:gdetaillist)
							{
								Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
								if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
									counts++;
									
								}
							}
						}
						
						if(counts>1){
						
						count++;
						if(count%5==1)
						{%>
							<li style="margin-left:0px;">
						<%}
						else
						{%>
							<li>
						<%}
				%>
				<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0" /></a>
				<%  
				   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(scoll.getId());
				   if(gdlist!=null&&gdlist.size()>0)
				   {
					   int newsum=0;
					   out.print("<p>");
					   for(Gdscolldetail gd:gdlist)
					   {
						   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						   {
							   newsum++;
							   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
							   {%>
								   <span><a href="http://www.d1.com.cn/product/<%= product.getId()%>" target="_blank"><%= gd.getGdscolldetail_title()%></a>&nbsp;<font><%= Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())%></font></span>
							  <% }
						   }
						   
					   }
					   out.print("</p>");	
				   }  
				   %>
				</li>
				<%
				}					
					}
				}
				%>
				</ul>
				<%
				}

		%>
		</ul>
		</td></tr></table>
	
	
		 </div>
	 	<div class="clear"></div>
 


	</div>
</div>
<div class="clear"></div>
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
</body>
</html>
