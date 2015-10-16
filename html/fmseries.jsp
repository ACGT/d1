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

static ArrayList<Gdscoll> getGdscollBySerid(String serid,Long sex){
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
     String[] arrserid=serid.split(",");
     for(int i=0;i<arrserid.length ;i++ ){
	ArrayList<Gdscoll> scolllist=GdscollHelper.getGdscollBySerid(arrserid[i],sex);
	if(scolllist!=null && scolllist.size()>0){
		for(Gdscoll s:scolllist){
			list.add(s);
		}
	}
	Long sex1=3l;
	if(sex.intValue()==1) sex1=3l;
	else if(sex.intValue()==2) sex1=4l;
	ArrayList<Gdscoll> scolllist2=GdscollHelper.getGdscollBySerid(arrserid[i],sex1);
	if(scolllist2!=null && scolllist2.size()>0){
		for(Gdscoll s:scolllist2){
			list.add(s);
		}
	}
    }
     Collections.sort(list,new GdscollTimeComparator());
	return list;
}


%>
<%
   String scontent="率性格调系列";
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Feel Mind/FM<%=scontent %>【图片_价格_评价_怎么样】</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Feel Mind/FM<%= scontent %>系列报价、促销、新闻、评论、导购、图片" />
<meta name="description" content="D1优尚网是国内唯一在线销售Feel Mind/FM<%= scontent %>系列商品，提供Feel Mind/FM<%= scontent %>系列的最新报价、促销、评论、导购、图片等相关信息" />
<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style>
   .fmlist{ width:980px; background:url('http://images.d1.com.cn/images2012/fmdpbg2_1.jpg') repeat-y; margin-top:10px;}
   .fmlist ul{ list-style:bnone; margin:0px;padding:0px;}
   .fmlist ul li {margin-left:-60px; +margin-left:-64px; height:400px; float:left;}
    .fmlist ul li p{ margin-top:11px; margin-left:35px; width:175px;}
   .fmlist ul li p a { color:#919191}
   .fmlist ul li p span{ display:block; width:80px; text-align:left; float:left;} 
   .fmlist ul li p span font{ font-size:12px; color:#919191;}
   .newbanner1120 {position: fixed;z-index: 20000;top: 0px;text-align: left;background:#3c3c3c;}
   </style>

</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->


     <%
     String sex="2";
    	 
    	 %> 
<div class="fbody">
  <div class="autobody">
 
   
        <div class="fmlist">
	  <table><tr><td>
		     <%

	
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=getGdscollBySerid("1,3",new Long(sex));
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
				<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0"/></a>
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
		 </td></tr></table>
	 </div>


	    <div class="clear"></div>

	 
  </div>
</div>
  <div class="clear"></div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
