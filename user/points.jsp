<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%!
	public String getStatus(long status) {
		if(status == 1)
			return "【获得积分】购物积分";
		else if(status == 2)
			return "【获得积分】评价积分";
		else if(status == 3)
			return "【获得积分】微博分享积分";
		else if(status == 0)
			return "【获得积分】赠送积分";
		else if(status == -1)
			return "【消费积分】积分购物";
		else if(status == -2)
			return "【消费积分】积分换券";
		else if(status == 4)
			return "【获得积分】生日赠送积分";
		else if(status == 5)
			return "【获得积分】祝福积分";
		else if(status == 6)
			return "【获得积分】晒单积分";
		else if(status == 7)
			return "【获得积分】白金积分";
		else
			return "【获得积分】购物积分";
	}

	public String getVip(User lUser)
	{
		if(lUser.getMbrmst_specialtype()==0){
			return "300";
		}
        else
        {
        	UserVip uv=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
        	if(uv!=null)
        	{
        		return "1000";
        	}
        	else {
        		return "500";
        	}
        }
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——积分</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
  <!--右侧-->

   <div class="mbr_right">

		<div class="myjf">

		  &nbsp;&nbsp;<span>我的积分</span>

		  <br/> <br/>

		  &nbsp;&nbsp;你目前有积分<font color="#dd0101"><b><%=(int)(UsrPointHelper.getRealScore(lUser.getId())+0.5) %></b></font>分

		 <a href="http://www.d1.com.cn/jifen/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/des/jfdhhl1.png"  style=" vertical-align:middle;" /></a>

		</div>

		<table border="0" width="769" height="10"><tr><td></td></tr>

		</table>

		<div class="yhqlist">
		<% 
			int pageno1=1;
		    int pageno2=1;
		    //生日赠送积分
		    ArrayList<UsrPoint> lists=new ArrayList<UsrPoint>();
		    //购物积分
		   
		%>

			   <div id="yh_content_list">

			       <div>

			       <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

				   <tr style=" color:#a25663;" height="33"><td class="d1" width="260">生成时间</td><td class="d1" >来源</td><td  class="d1" width="100">积分</td></tr>

				   </table>

					<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
                     <% 
                     lists = UsrPointHelper.getUserScoreInfo(lUser.getId());
                     if(lists!=null&&lists.size()>0)
                     {  
                    		 
                    	 
                 
                    	
                       if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
  					   {
  						   pageno1=Tools.parseInt(request.getParameter("pageno1"));
  					   }
                        for(int i=(pageno1-1)*15;i<lists.size()&&i<pageno1*15;i++)
                        {
                        	SimpleDateFormat fmt = new SimpleDateFormat("yyyy年MM月dd hh:mm:ss");
                        	UsrPoint us=lists.get(i);
                        	String odrid = us.getUsrpoint_odrid()==null?"":us.getUsrpoint_odrid();
                        	String gdsid = us.getUsrpoint_gdsid()==null?"":us.getUsrpoint_gdsid();

                        	out.println("<tr>");
                        	
                        	List<OrderItemBase> odrItem = OrderItemHelper.getMyOrderDetail(odrid);
                        	
                        	if(odrItem !=null && odrItem.size()>0) {
                        		gdsid = odrItem.get(0).getOdrdtl_gdsid();
                        	}
                        	
                           	String  smallimg = ""; 
                        	if(gdsid!=null && !"".equals(gdsid)) {
                        		Product p=ProductHelper.getById(gdsid);
                        		if(p != null) {
                        		smallimg = p.getGdsmst_smallimg();	
          		    		   if(smallimg!=null){
          		    			  if(smallimg.startsWith("/shopimg/gdsimg")){
          		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
 				     						}else{
 				     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
 				     						}
          		    		   }
                        		}
                        	}
                        	out.println("<td width='260' height='60'>"+fmt.format(us.getUsrpoint_createdate())+"</td>");
                        	if(lists.get(i).getUsrpoint_type().longValue()==-2) {
                        %>
                        	<td><table><tr><td><img src='res/gwj10.jpg' width=50 height=50/></td><td>&nbsp;<%=getStatus(us.getUsrpoint_type()==null?0:us.getUsrpoint_type())%></td></tr></table></td>
						<%
                        	}else {
						%>                        	
                        	<td><table><tr><td><%if(!"".equals(gdsid)&&!"".equals(smallimg)) {%><img src='<%=smallimg%>' width=50 height=50/><%} %></td><td align="left">&nbsp;<%=getStatus(us.getUsrpoint_type()==null?0:us.getUsrpoint_type())+(odrid==null||odrid.trim().equals("")?"":"<br>&nbsp;订单:"+odrid).trim()%></td></tr></table></td>
                        <%
							}
                        	if(us.getUsrpoint_score()>0) {
	                    		out.println("<td width='100'><font color='red'>"+us.getUsrpoint_score()+"</font></td>");
                        	}else{
	                    		out.println("<td width='100'><font color='green'>"+us.getUsrpoint_score()+"</font></td>");
                        	}
                        	out.println("</tr>");
                        }
                     }
                     else
                     {%>
                    	  <tr><td height="100" style=" line-height:100px; font-size:15px; color:#a25663;"><b>您目前无获得积分记录。</b></td></tr>
                    	 
                     <%}
                   %>
                     </table>
                    	 
				     <table width="769">
				     <tr><td height="10"></td></tr>
                      <%    if(lists!=null&&lists.size()>0)
                      {%>
                    	      
				      <tr><td heihgt="75" style=" text-align:center;">
				      <% 
				       //分页
					    
						String ggURL = Tools.addOrUpdateParameter(request,null,null);
						if(ggURL != null) 
							   {
							     ggURL.replaceAll("pageno1=[0-9]*","");
							   }
						//翻页
						
						 	
						  int PAGE_SIZE = 15 ;
						  int currentPage1 = 1 ;
						  String pg1 ="1";
						  if(request.getParameter("pageno1")!=null)
						  {
						  	pg1= request.getParameter("pageno1");
						  }
						  if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
						  PageBean pBean1 = new PageBean(lists.size(),PAGE_SIZE,currentPage1);
						  out.println(lists.size());
						  int end1 = pBean1.getStart()+PAGE_SIZE;
						  if(end1 > lists.size()) end1 = lists.size();
						  String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
						  if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
					  %>
					  <span class="Pager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int j=pBean1.getStartPage();j<=pBean1.getEndPage()&&j<=pBean1.getTotalPages();j++){
					           		if(j==currentPage1){
					           		%><span class="curr"><%=j %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=j %>"><%=j %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span>
				      </td></tr>
				   
                     <%  }
                      %>
                     
					  <tr><td height="70" style=" color:#dd0101">
                                                         说明：<br/>
						1.成功交易的订单实付金额部分可获得积分，1元=1积分，将在确认收货后立即生效。<br/>
						2.给商品评分：获得5个积分。 填写使用心得：获得5个积分。在评价后立即生效。<br/>
						<%
							Date birthday = lUser.getMbrmst_birthday();
							if(birthday == null) {
						%>
						3.您还没有设置生日，设置生日后，您在生日当天将获赠<%=getVip(lUser) %>个积分。现在<a href='http://www.d1.com.cn/user/profile.jsp'>设置生日>></a><br/>
						<%
							}else {
								int month = 0;
								int day = 0;
								String birthdayStr = Tools.getDate(birthday);
								if(Tools.matches("[0-9]{4}-[0-9]{2}-[0-9]{2}",birthdayStr)){
									month = Tools.parseInt(birthdayStr.substring(5,7));
									day = Tools.parseInt(birthdayStr.substring(8,10));
								}
						%>
						3.您的生日是<%=month %>月<%=day %>日，您将在生日当天获赠<%=getVip(lUser) %>个积分。
						<%} %>



					  </td></tr>

				   </table>

					 </div>					

			   </div>

		</div>

		

		<table width="769" height="20"><tr><td></td></tr></table>

		

		

  </div>
  
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>
<script language="javascript" type="text/javascript" >
function $aa(id) { return document.getElementById(id) };

function bindtags(tags1,contentlist,bigdiv)
{
   var 	t0=$aa(tags1).getElementByNames("a");
   var c0=$aa(contentlist).getElementByNames("div");
   
}
function switch_tags(tags, contents, cls, index, method, time) {
    this.time = time;
    this.method = method;
    this.tags = tags;
    this.contents = contents;
    this.cls = cls;
    this.c_index = index;
    tags[index].className = cls;
    if(index==1)
    	{
    	 $aa("yh_tags").className="tags4";
    	}
    else
    	{
    	 $aa("yh_tags").className="tags3";
    	}
	
    contents[index].style.display = "";
    this.bind_switch();
};

switch_tags.prototype.bind_switch = function() {
    var nb = this;
    var set_int;
    for (var i = 0; i < this.tags.length; i++) {
        this.tags[i].index = i;
        //onmouseover	
        if (this.method == "click") {
            this.tags[i].onmouseover = function() {
                var o = this;
                set_int = setTimeout(function() { sw(o.index) }, nb.time);
            };
            this.tags[i].onmouseout = function() {clearTimeout(set_int); }
        }
        //onclick
        else if (this.method == "mouseover") {
            this.tags[i].onclick = function() { sw(this.index); }
        }
		
    }
    //延时切换		
    function sw(m) {
           var obj = nb.tags[m];
        nb.tags[nb.c_index].className = "";
        nb.contents[nb.c_index].style.display = "none";
        obj.className = nb.cls;
        nb.contents[obj.index].style.display = "";
        nb.c_index = obj.index;
		switch(m)
		{
			case 0:
					 {
						 $aa("yh_tags").className="tags3";
						 break;
					 };
			case 1:
			{
				$aa("yh_tags").className="tags4";
						 break;
			};
			
			default:
					{
				   $aa("yh_tags").className="tags3";
						 break;
				};
		}
    };
	
};

var t1 = $aa("yh_tags").getElementsByTagName("a");
var c1 = $aa("yh_content_list").getElementsByTagName("div");
var strHref = window.document.location.href;
if(strHref.indexOf("?")>0)
	{
	  if(strHref.lastIndexOf('=')>5)
		  {
		     strHref=strHref.substr((strHref.lastIndexOf('=')-7),7);
		     if(strHref=='pageno1')
		    	 {
		    	 new switch_tags(t1, c1, "active", 0, "mouseover");
		    	 }
		     else
		    	 {
		    	 new switch_tags(t1, c1, "active", 1, "mouseover");
		    	 }
		  }
	  else
		  {
		  new switch_tags(t1, c1, "active", 0, "mouseover");
		  }
	}
else
	{
	  new switch_tags(t1, c1, "active", 0, "mouseover");
	}

</script>


