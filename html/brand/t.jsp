<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
static List getCommentList(String productId , int start , int length){
	if(Tools.isNull(productId)) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_gdsid", productId));
	listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
	listRes.add(Restrictions.ge("gdscom_level", new Long(4)));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("gdscom_createdate"));
	
	return Tools.getManager(Comment.class).getList(listRes, listOrder, start, length);
}
static String getUid(String str){
	if(str==null)str="";
	String x = "***"+StringUtils.getCnSubstring(str,0,10);
	return x;
}
%>
<%
String id="";
if(Tools.isNull(request.getParameter("id"))){
	out.print("<script>alert('非法操作')</script>");
	return;
}else{
	id=request.getParameter("id");
}
if(!Tools.isMath(id)){
	out.print("<script>alert('非法操作,id错误')</script>");
	return;
}
String counter_pic="";
String counter_pictong="";
String counter_info="";
String counter_title="";
String counter_brandname="";
String counter_brandpic="";
String counter_titlepic="";
String counter_rackcode="";
String counter_description="";
String counter_keyword="";
String header_sex_type="";
String counter_flagpg="";
String counter_story="";

Counter counter=(Counter)Tools.getManager(Counter.class).get(id);
		if(counter!=null){
			counter_pic=counter.getCounter_pic();
			counter_pictong=counter.getCounter_pictong();
			counter_info=counter.getCounter_info();
			counter_title=counter.getCounter_title();
			counter_brandname=counter.getCounter_brandname();
			counter_brandpic=counter.getCounter_brandpic();
			counter_titlepic=counter.getCounter_titlepic();
			counter_rackcode=counter.getCounter_rackcode();
			counter_description=counter.getCounter_description();
			counter_keyword=counter.getCounter_keyword();
			header_sex_type=counter.getCounter_sex()!=null?counter.getCounter_sex().toString():"";
			counter_flagpg=counter.getCounter_flagpg().toString();
			counter_story=counter.getCounter_story();
		}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【专柜正品】<%=counter_title%></title>
<meta name="description" content="<%=counter_description%><%= counter_brandname %>品牌专区，为提供<%= counter_brandname %>产品的最新报价、<%= counter_brandname %>评论、<%= counter_brandname %>导购、<%= counter_brandname %>图片等相关信息。"/>
<meta name="keywords" content="<%=counter_keyword%>"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style>
.left_bg01{
    float:left;
	width:205px;
	background:url(http://www.d1.com.cn/html/brand/images/left_bg.gif) repeat-y;
}
.left_bg02{
    float:left;
	width:205px;
	height:9px;
	background:url(http://www.d1.com.cn/html/brand/images/left_bg2.gif) no-repeat;
}
.STYLE1 {
	color: #FF0000;
	font-size: 14px;
}
.tlput {
	width: 150px;
	border: 1px solid #C2C2C2;
	height: 26px;
	font-size:14px;
}
.line {
	border: 1px solid #A44153;
}
form{ padding:0px; margin:0px;}
  ul,li{margin:0;padding:0}
.scrollDiv{width:245px;height:250px;line-height:21px;overflow:hidden}
.scrollDiv li{height:80px;padding-left:4px;color:#525252;text-align:left}
ul,li{ list-style:none;}
.scrollDiv .user{ padding-top:10px;left:0;width:80px;text-align:center;color:#999;float:left;}
.scrollDiv .user a{color:#005aa0;}
.scrollDiv .u-icon img{border:2px solid #EAEAEA;}
.scrollDiv .u-txt{padding-top:10px;left:0;width:150px;color:#999; font-size:12px; float:right;}
.scrollDiv .tail{ height:80px;}
#recommend {margin-bottom:0;margin-left:0;color:#0D62BC; text-decoration:none;width:192px;overflow: hidden;_zoom: 1;}
#recommend #rank {background:#f9f9f9; margin:0; padding:0;float:left; width:192px;}
#recommend #rank ul {height:350px;margin:0; padding:0;width:192px;}
#recommend #rank ul {padding-top:21px; position:relative; background:#f9f9f9;}
#recommend #rank h2 {color:#597B00; font-size:12px; padding:6px 0 4px 6px;margin:0; width:192px;}
#recommend #rank ul li {position:absolute; width:192px;}
#recommend #rank ul li h5 { border:1px solid #c0c0c0; font:12px normal; height:20px; position:absolute; top:-21px;  z-index:10;margin:0;}
#recommend #rank ul li h5 a {font:12px normal;background:#f9f9f9; display:block; line-height:19px; margin:1px; margin-bottom:0; text-align:center;color:#000000; text-decoration:none;margin:0;}
#recommend #rank ul li h5#rank1 {left:5px;width:63px}
#recommend #rank ul li h5#rank2 {left:68px;width:63px}
#recommend #rank ul li h5#rank3 {left:131px;width:63px}
#recommend #rank ul li h5#rank1 a{width:60px}
#recommend #rank ul li h5#rank2 a{width:60px}
#recommend #rank ul li h5#rank3 a{width:60px}
#recommend #rank ul li ul {background:#f9f9f9; border:0px solid #dddddd; display:none; overflow:hidden; padding:4px 3px; width:190px;}
#recommend #rank ul li ul li {background:#f9f9f9; position:relative;}
#recommend #rank ul li ul li a {display:block;  margin:0 6px;color:#000000; text-decoration:none;font:12px normal;}
#recommend #rank ul li ul li a span {color:#FF6600; cursor:pointer; display:block; margin:-25px auto 0 80px; width:70px;}
#recommend #rank ul li.c ul {display:block; width:186px;overflow:hidden; padding:4px 3px; }
#recommend #rank ul li.c h5 {background:#f9f9f9; width:186px; border:1px solid #CCCCCC;}
#recommend #rank ul li.c h5 a {background:#f9f9f9; font-weight:bold; height:25px; margin:1px 0 0 0; position:absolute; width:70px;}
#recommend #rank ul li ul {height:315px; width:190px;margin:0;padding:8px; padding-top:10px; border-top:1px solid #dddddd;}
#recommend #rank ul li ul li {height:33px;color:#424242;padding:1px; font:12px Verdana, Arial; border-bottom:1px dashed #CCCCCC; }

.tekuang{margin:2px;margin-top:8px;list-style : disc outside none ; list-style-position : outside;color:#424242;padding:1px; font:12px Verdana, Arial;list-style-type:none;}
.tekuang li{height:22px;line-height:22px;overflow:hidden;word-break:keep-all;white-space:nowrap;text-overflow:ellipsis;}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div style="width:980px;margin:0 auto;overflow:hidden;_zoom:1;">
<table width="980" height="10" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=white>
  <tr><td>
  </td></tr>
</table>
<%
 if("33".equals(id)){
	 response.sendRedirect("/shl/swarovski.jsp");
 }
if(!Tools.isNull(counter_titlepic)){
	%>
	<%=counter_titlepic %>
<%}else if(Tools.isNull(counter_pictong) ){
	%>
	<table width="960" border="0" cellpadding="0" cellspacing="0" align=center>
	<tr>
		<td><%if(!Tools.isNull(counter_pic)) {%>
			<a href="index.jsp?id=<%=id%>"><img src="<%=counter_pic%>" alt="" border=0/></a>
			<%}%>
			
		</td>
		<td valign=top>
			<table width="620" border="0" cellpadding="0" cellspacing="0" style="margin-top:15px;margin-left:25px;margin-right:30px;">
				<tr>
					<td height=50 valign=top style="font-size:40px;line-height:50px;color:#555555;font-family : simhei;">
					<%if(!Tools.isNull(counter_brandpic)) {  %>
						<img src="<%=counter_brandpic%>" border=0/>
					<%}else{%>
						<b><%=counter_brandname%></b>
					<%} %>
					</td>
				</tr>
				<tr>
					<td style="font-size:13px;line-height:18px;color:#555555;">
						<%=counter_info%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%}else{
			int isfrom=0;
			if("13".equals(id) || "110".equals(id)){//佰草集或欧莱雅
				if(session.getAttribute("first_referer_url2")!=null){
					String first_referer_url=session.getAttribute("first_referer_url2").toString();
					
					%>
					<input type="hidden" value="<%=URLDecoder.decode(first_referer_url,"utf-8")%>"/>
					<%
					//first_referer_url="http://www.baidu.com/s?tn=monline_5_dg&bs=%C5%B7%C0%B3%D1%C5&f=8&rsv_bp=1&wd=%C5%B7%C0%B3%D1%C5 d1&inputT=2195";
					if(first_referer_url.indexOf("http://www.baidu.com")>=0){
					
						/*
					first_referer_url=first_referer_url.substring(first_referer_url.indexOf("?"));	
					String[] str1=first_referer_url.split("&");
					for(int i=0;i<str1.length;i++){
						String[] str2=str1[i].split("=");
						for(int j=0;j<str2.length;j++){
							
						}
					}
					*/
					String first_referer_url2=URLDecoder.decode(first_referer_url,"utf-8");
					first_referer_url=URLDecoder.decode(first_referer_url,"gbk");
					
					String imgurl="";
					if("110".equals(id)){
						if(first_referer_url.indexOf("佰草集")>0 || first_referer_url2.indexOf("佰草集")>0){
							imgurl=PromotionHelper.getImgPromotion("3063",1);
							isfrom=1;
						}
					}else{
						if(first_referer_url.indexOf("欧莱雅")>0 || first_referer_url2.indexOf("欧莱雅")>0){
							imgurl=PromotionHelper.getImgPromotion("3062",1);
							isfrom=2;
						}
					}
					if(!Tools.isNull(imgurl)){
						out.print(imgurl);
					}
				}
			}
			String code="";
				if(isfrom==1){
					code="3061";
				}else if(isfrom==2){
					code="3060";
				}
				if(!Tools.isNull(code)){
					Tools.setCookie(response,"rcmdusr_rcmid","160",(int)(Tools.DAY_MILLIS/1000*1));
					ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,20);
					if(list!=null && list.size()>0){
						 int icount=list.size();
			             int num=0;
			             String productid="";
			             String url="";
						for(Promotion promotion:list){
							if(!Tools.isNull(promotion.getSplmst_url()) && !"#".equals(promotion.getSplmst_url())){
								url=promotion.getSplmst_url();
								productid=promotion.getSplmst_url().substring(promotion.getSplmst_url().lastIndexOf("/")+1);	
							}
							if(!Tools.isNull(productid)){
								%>
								
								  <table width="980" height="38" border="0" style="margin-top:10px;" cellpadding="0" cellspacing="0" class="line">
      <tr>
        <td width="720" height="19" rowspan="2" align="right"><a href="<%=url%>" target="_blank"><img src="<%=promotion.getSplmst_picstr()%>" width="714" height="308" border=0/></a></td>
        <td width="260" height="50" align="center"><img src="http://images.d1.com.cn/zt2012/week0214/weekact_3.jpg" width="235" height="51"/></td>
      </tr>
      <tr>
        <td><div id="scrollDiv<%=num%>" class="scrollDiv">
          <ul>
          <%
        	  List commentlist =getCommentList(productid,0,100);
        	  if (commentlist!=null && commentlist.size()>0){
        		  for(int i=0;i<commentlist.size();i++){
        			  Comment comment=(Comment)commentlist.get(i);
        		  
        	  User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
				String hfusername = getUid(comment.getGdscom_uid());
				String level = UserHelper.getLevelText(user);
        	  %>
              <li>
              <div class="tail">
                <div class="user">
                  <div class="u-icon"> <img src="<%=UserHelper.getLevelImage(level) %>" width="63" height="63" /> </div>
                </div>
                <div class="u-txt" align="left" > <span><%=hfusername %></span><br/>
                    <span ><%
                    String comment_content=comment.getGdscom_content();
                            if (comment_content.length()>22){
                            	out.print( comment_content.subSequence(0, 22));
                            } else{
                            	out.print(comment_content);
                            }
                            %></span> </div>
              </div>
            </li>
            <%}
        	 
        	  }
          %>
                     <script>
function AutoScroll(obj){
$(obj).find("ul:first").animate({
marginTop:"-46px"
},200,function(){
$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
});
}
$(document).ready(function(){
	setInterval('AutoScroll("#scrollDiv'+<%=num%>+'")',5000)
});


</script>  
      </ul>
        </div>
        <div align="right"><a href="<%=url%>#cmt2" target="_blank" style=" font-size:14px; color:#A74053">查看更多评论</a>&nbsp;&nbsp;&nbsp;&nbsp;</div></td>

      </tr>
    </table>	
							<%	 num++; }
							
							}
						}
					}
				}

			if(isfrom==0){
				%>
			<img src=<%=counter_pictong %> border=0></img> 	
		<%	}
}
			%>

<table width="960" height="10" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=white style="border-bottom :1px dashed #c0c0c0;">
  <tr><td>
  </td></tr>
</table>
<table width="960" height="10" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=white>
  <tr><td>
  </td></tr>
</table>
<table width="960" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top" width=205>
	 	<table width="205" border="0" align="center" cellpadding="0" cellspacing="0">

		<tr>
		  <td><img src="http://www.d1.com.cn/html/brand/images/fl_top<%if(!"014".equals(counter_rackcode)){ %><%="000" %><%} %>.gif" alt="分类" /></td>
		</tr>
		<tr>
		  <td class="left_bg01" valign="top"  style="padding-left:5px;background-color:#f9f9f9;">

			<table width="194" border="0" cellpadding="0" cellspacing="0">
			<%
			ArrayList<CounterItem> list1=CounterItemHelper.getCounterItem(new Long(id), new Long(0), new Long(1), true)  ;
			if(list1!=null){
				//out.println("<script>alert('"+list1.size()+"')</script>");
				int i=0;
				for(CounterItem item1:list1){
					%>
						<tr>
					<td>
					<%
					//out.print("<script>alert('"+item1.getCounterdtl_title()+"')</script>");
					request.setAttribute("splid",item1.getCounterdtl_code());
					request.setAttribute("pos",item1.getCounterdtl_pos());
					request.setAttribute("title",item1.getCounterdtl_title());
					request.setAttribute("tp",item1.getCounterdtl_type());
					request.setAttribute("topimg",item1.getCounterdtl_imgurl());
					request.setAttribute("imgurl",item1.getCounterdtl_imglink());
					//request.setAttribute("counter_brandname",counter_brandname);
					%>
					<jsp:include page="/html/brand/showspl.jsp" />
							</td>
				</tr>
				<%
				i++;
				if(i<list1.size()){%>
					 <tr><td>
					<table width="100%" height="5" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=#f9f9f9 style="border-bottom :1px dotted #c0c0c0;height:10px;">
					  <tr><td>
					  </td></tr>
					</table>
					<table width="100%" height="5" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=#f9f9f9>
					  <tr><td>
					  </td></tr>
					</table>
				  </td></tr>
					<%}
				}
			}
			ArrayList<CounterItem> list2=CounterItemHelper.getCounterItem(new Long(id), new Long(2), new Long(1), false)  ;
			if(list2!=null){
				int no=1;
				%>
				<tr><td style="font-size:18px;font-family : simhei;"><BR>
	  <font color="#cc0000">销售</font>排行
	  </td></tr>
				<tr>
					<td>
					<div id="recommend">
	
	<div id="rank">
		<ul>
			<%	for(CounterItem item2:list2){
				%>
					<li <%if(no==1) {%>class="c"<%} %> onmousemove="showt(<%=no%>)"  ID="ran<%=no%>"> <h5 id="rank<%=no%>"><a href="javascript:showt(<%=no%>)"><%=item2.getCounterdtl_title()%></a></h5>
			<ul id="rankl<%=no%>">
			<%
			ArrayList<Product> plist=ProductHelper. getProductByCodeAndBName(item2.getCounterdtl_code(),item2.getCounterdtl_imgurl(),8);
			if(plist!=null){
				int i=1;
				for(Product p:plist){
					String lname=Tools.clearHTML(p.getGdsmst_gdsname());
					if(StringUtils.strLength(lname)>40){
						lname=Tools.substring( Tools.clearHTML(p.getGdsmst_gdsname()) ,40)+"...";
					}
					
					%>
					<li><a href="/product/<%=p.getId()%>" target="_blank" title="<%=p.getGdsmst_gdsname()%>"><img src="images/n_<%=i%>.gif">&nbsp;<font style="color:000000;font-size:13px;"><%=lname%></font></a></li>	
				<%
				i++;
				}
			}%>
			</ul>
			</li>
			<%}%>
		</ul>
	</div>
</div>
<script type="text/javascript">
function showt(wh)
{
for(var i=1;i<<%=no%>;i++){
	document.getElementById('rankl'+i).style.display='none';
	document.getElementById('ran'+i).className='';
}
document.getElementById('rankl'+wh).style.display='block';
document.getElementById('ran'+wh).className='c';
}
</script>
			<%}
			%>
			</td>
				</tr>
				<tr>
				  <td>&nbsp;</td>
			    </tr>
			<tr>
				  <td height="28"style="font-size:18px;font-family : simhei;"><BR>
	  <font color="#cc0000">品牌</font>故事</td>
			    </tr>
				<tr>
				  <td style="padding-left:5px; padding-right:5px;">
				  <% if(!Tools.isNull(counter_story)){%>
				   <%=counter_story%>
				  <%}%>
				 </td>
			    </tr>
			</table>
			</td>
		</tr>
		<tr>
		  <td class="left_bg02">&nbsp;</td>
		</tr>
	  </table>			
		</td>
		<td width=750 align=right valign=top>
					<table width="750" height="5" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=white>
					  <tr><td>
					  </td></tr>
					</table>
					<%
					if(counter_flagpg.equals("0")){
						ArrayList<CounterItem> list3=CounterItemHelper.getCounterItem(new Long(id), new Long(1), new Long(1), true)  ;
					 if(list3!=null){
						 for(CounterItem item3:list3){
							 request.setAttribute("splid",item3.getCounterdtl_code());
								request.setAttribute("pos",item3.getCounterdtl_pos());
								request.setAttribute("title",item3.getCounterdtl_title());
								request.setAttribute("tp",item3.getCounterdtl_type());
								request.setAttribute("topimg",item3.getCounterdtl_imgurl());
								request.setAttribute("imgurl",item3.getCounterdtl_imglink()); 
								%>	 
						<jsp:include page="/html/brand/showspl.jsp" /> 
						<% }
					 }
					}else{
						String urlsql="index.jsp?id="+id;
						//out.print("<script>alert('"+counter_brandname+"')</script>");
						String rackcode=counter_rackcode;
						String brandname=counter_brandname;
						String sequence="0";
						if (rackcode.startsWith("017")){
							sequence="1";
						}
						else if(rackcode.startsWith("014") || rackcode.startsWith("015")){
							sequence="2";
						}
						
						String productname="";
						if(!Tools.isNull( request.getParameter("productsort"))){
							urlsql+="&productsort="+request.getParameter("productsort");
							rackcode=request.getParameter("productsort");
						}else{
							urlsql+="&productsort="+counter_rackcode;
						}
						if(!Tools.isNull( request.getParameter("sequence"))){
							sequence=request.getParameter("sequence");
						}
						if(!Tools.isNull( request.getParameter("productname"))){
							productname=request.getParameter("productname");
							urlsql+="&productname="+productname;
						}
						
						urlsql+="&productbrand="+counter_brandname;
						
						//int m_recordCount=ProductHelper.getPageTotal_Brand(brandname, rackcode,productname);
						int pagesize=21;
						int currentPageIndex=1;
						
						if(!Tools.isNull(request.getParameter("pageno")) && Tools.isNumber(request.getParameter("pageno"))){
							currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
						}
						ArrayList<Product> productlist=ProductHelper.getProductList_Brand(brandname,sequence,productname);
						
			        	   List<Product> list=new ArrayList<Product>();
			        	   if(productlist!=null && productlist.size()>0){
			        		   for(Product p:productlist){
			        			   if(rackcode.contains(",")){
										String [] codelist=rackcode.split("\\,");
										for(int i=0;i<codelist.length;i++){
											if(p.getGdsmst_rackcode().trim().startsWith(codelist[i].trim())){
						        				   list.add(p);
						        			   }
										}
									}else{
										 if(p.getGdsmst_rackcode().startsWith(rackcode)){
					        				   list.add(p);
					        			   }
									}
			        			  
			        		   }
			        	   }
			        	   int m_recordCount=list.size();
			        	   PageBean pBean = new PageBean(m_recordCount,pagesize,currentPageIndex); 
			        	   int PageCount=(m_recordCount/pagesize)+1;
							if(m_recordCount%pagesize==0){
								PageCount=m_recordCount/pagesize;
							}
			        	   int end = pBean.getStart()+pagesize;
				        	if(end > m_recordCount) end = m_recordCount;
						//if(!Tools.isNull(productname)){
							list=list.subList(pBean.getStart(),end);
						//}
						%>
						 <form name=formpage method=post action="<%=urlsql%>">
				          <input type=hidden name=pageno />
				        </form>
				 <table width="750" height="31" border="0" align="center" class="lincss"  background="http://images.d1.com.cn/images2010/listtypebg.gif"cellpadding="0" cellspacing="0">
			      <tr>
			        <td width="93" height="31">&nbsp;&nbsp;<img src="http://images.d1.com.cn/images2010/listtype1.gif" width="17" height="17"  />显示方式</td>
			        <td width="88" class="linbg">&nbsp;&nbsp;<a href="<%=urlsql%>&sequence=2"><img src="http://images.d1.com.cn/images2010/listtype2.gif" width="13" height="16" />热销排行</a></td>
			        <td width="83" class="linbg">&nbsp;&nbsp;<a href="<%=urlsql%>&sequence=1"><img src="http://images.d1.com.cn/images2010/listtype3.gif" width="13" height="16" />最新上架</a></td>
			        <td width="59" class="linbg">&nbsp;&nbsp;<a href="<%=urlsql%>&sequence=5"><img src="http://images.d1.com.cn/images2010/listtype4.gif" width="11" height="15" />价格</a></td>
			        <td width="55" class="linbg">&nbsp;&nbsp;<a href="<%=urlsql%>&sequence=4"><img src="http://images.d1.com.cn/images2010/listtype5.gif" width="11" height="15" />价格</a></td>
			        <td width="62" class="linbg">&nbsp;&nbsp;<a href="<%=urlsql%>&sequence=3"><img src="http://images.d1.com.cn/images2010/listtype7.gif" width="19" height="13" />名称</a> </td>
			        <td width="69" class="linbg">&nbsp;&nbsp;<a href="<%=urlsql%>&sequence=6"><img src="http://images.d1.com.cn/images2010/listtype8.gif" width="17" height="18" />分类</a></td>
			        <td width="241" align="center">共有<span style="color:#F85F00;" id=gdssum><%=m_recordCount%></span>件商品</td>
			      </tr>
    			</table>  
				<%		
					
				  
				//out.print("<script>alert('"+sequence+"')</script>");
				
					
					if(list!=null){
						
						int i=0;
						%>
						 <table width=750 border="0" cellspacing="4" cellpadding="0" align="center">
					  
					<%	for(Product product:list){
						  if ("01720373".equals(product.getId())){
			        		   continue;
			        	   }
						String    gdsmst_discountenddate="";
						if(product.getGdsmst_discountenddate()==null){
							gdsmst_discountenddate="2000-1-1";
						}
						if(!Tools.isNull(product.getGdsmst_discountenddate().toString())){
							gdsmst_discountenddate=product.getGdsmst_discountenddate().toString();
						}
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						try{
							sdf.parse(gdsmst_discountenddate);
						}catch(Exception ex){
							gdsmst_discountenddate="2000-1-1";
						}
						
					Date discountenddate= 	sdf.parse(gdsmst_discountenddate);
					 String img="http://www.d1.com.cn/buy/images/nopic120.gif";
					 if(!Tools.isNull(product.getGdsmst_imgurl())){
						 img="http://images.d1.com.cn"+product.getGdsmst_imgurl().trim();
					 }
					  String t="";
						String x="";
						
							t=product.getGdsmst_layertype();
							x=product.getGdsmst_layertitle();
							//PromotionProductHelper.showLayer(product.getGdsmst_layertype(),product.getGdsmst_layertitle());
						
					   request.setAttribute("t", t);
					   request.setAttribute("x", x);
					   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
						 String fl=ProductGroupHelper.getRoundPrice((float)dl);
						 String oldprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
						 String mprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice().floatValue());
						 String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
							if((i+1)%3==1){
								
								%>
								 <tr>
								<%} %>
								  <td align="center" valign="top" style="width:245px;">
								  	<table width="220" border="0" cellpadding="0" cellspacing="0" bordercolor="#DDDDDD">
                  						<tr>
                    						<td height=120 align=center valign=middle>
                    						   <table border="0" cellspacing="0" cellpadding="0" align="center" width=200>
           										 <tr><td style="border:#cccccc 1px solid;">
           													<div style="position:relative;left;width:200px;height:200px;z-index:1;">
							<% 
							if(discountenddate.after(new Date()) && product.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+365*24*3600*1000l))){
								%>	
								 <div style="position:absolute;z-index:999;"><img src="http://images.d1.com.cn/images2010/tejia2.gif" />
		  						 </div>
		  						 <%} %>
		     					<a href="/product/<%=product.getId()%>" class="0" style='text-decoration:none' target="_blank"> 
							      <img src="<%=img%>" border=0/>
							   <jsp:include page="/sales/showLayer.jsp" flush="true" /> 
								</a></div>
				           </td></tr>
				           </table></td>
				                  </tr>
				                  <tr>
				                   <td>
				                   <a href="/product/<%=product.getId()%>" target="_blank"><font color=#333333>
                     <%
                     String code=product.getGdsmst_rackcode();
                      if(!fl.equals("10") && (!code.startsWith("003")) && (!code.startsWith("007"))&& (!code.startsWith("005"))&& (!code.startsWith("006")) ){
                    	  %>  
                     <span class="zi12">【<%=fl%>折】 </span>   
                      <%}%>
                      <%=product.getGdsmst_gdsname()%></font>
                   
                   <% if(product.getGdsmst_addshipfee().intValue()!=0){
                    	 %>  
                    	 <a href="/help/index.jsp?code=0402" target=_blank>本商品属于超重商品，运费另计</a>
                    <% }
                    if(product.getGdsmst_eyuan().floatValue()>0f){
                    	 %>  
                    	   <font color=red>（送<%=product.getGdsmst_eyuan().floatValue()%>元e券）</font>
                     <%}
                    if(product.getGdsmst_buylimit().intValue()>0){
                    	 %>  
                    	   &nbsp;&nbsp;<font color=red>（本商品为限量商品，每个订单限购<%=product.getGdsmst_buylimit()%>件）</font>
                    <% }%>
                    <br/> <div align="center">
                    <%	if(discountenddate.after(new Date()) && product.getGdsmst_discountenddate().before(new Date(System.currentTimeMillis()+365*24*3600*1000l))){
								%>	
								<font color=#4D4D4D  style="font-size:9pt"><strike>原价: <font style="font-size:10.5pt"><b><%=oldprice %></b></font>元</strike></font><br/>
		  						 <%} %>
		  						 <br /><span style="font-size:18px; font-weight:800; color:red">￥<%=mprice%></span><span style="text-decoration: line-through; padding-left:16px; font-size:14px; color:#4D4D4D">￥<%=sprice%></span>
							</div>
                    </a>
                    <%
                    String gdsmst_ifhavegds="";
                    String errmst_intro="";
                    if(product.getGdsmst_ifhavegds()!=null){
                    	gdsmst_ifhavegds=product.getGdsmst_ifhavegds().toString();
                    }
                    if(!Tools.isNull(gdsmst_ifhavegds)){
                    	if(gdsmst_ifhavegds.equals("2") || gdsmst_ifhavegds.equals("3") || gdsmst_ifhavegds.equals("1")){
                    		if(gdsmst_ifhavegds.equals("1")){
                    			if( product.getGdsmst_ifhavedate().after(new Date(System.currentTimeMillis()-24*3600*1000l))){
                    				int   d   =   (int)((product.getGdsmst_ifhavedate().getTime()   -   new Date().getTime())   /   (1000   *   60   *   60   *   24))+1;
                    				errmst_intro="此商品暂时缺货，预计"+d+"天内到货。";
                    			}else{
                    				errmst_intro="此商品暂时缺货，近期将到货。";
                    			}
                    		}
                    	}%>
                    	<%= errmst_intro%>
                   <% }
                    %>
                    </td></tr></table></td>
							<% 
						
							 i++;
							 if(i==list.size() && i%3!=0){
								 for(int m=1;m<=(3-i%3);m++){
									%> 
								 <td align="center" valign="top" style="width:245px;"><table border="0" cellspacing="0" cellpadding="0" align="center" width=120>
				                  <tr>
				                    <td height=120  align=center valign=middle></td>
				                  </tr>
				                  <tr>
				                    <td></td>
				                  </tr>
				                </table>
                			</td>
								 <% }
							 }
							 if(i%3==0){%> 
							  </tr>
						  <% }
						}%>	
					 </table>
					 <% }
           if(pBean.getTotalPages()>1){
        	   String ggURL = Tools.addOrUpdateParameter(request,null,null);
        	   if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
        	   
        	   String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
       		
        	   if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
        	   pageURL = pageURL.replaceAll("&+", "&");
           %>
           <div class="GPager">
           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="<%=pageURL %>pageno=1">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getPreviousPage()%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPageIndex){
           		%><span class="curr"><%=i %></span><%
           		}else{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
           </div>
    <%}} %>
    </td>
    </tr>
    </table>
    </div>
    <%@include file="/inc/foot.jsp"%>
</body>
</html>