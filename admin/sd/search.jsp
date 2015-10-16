<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%><%!
static ArrayList<MyShow> getAllShowByGdsid(String gdsid,String rackcode,Date s,Date e,int begin,int end,String issh,String checkuser,Date ctimes,Date ctimee,String adduser,Date addtimes,Date addtimee,String addtype){
	
	ArrayList<MyShow> list=new ArrayList<MyShow>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
	}
	if(!Tools.isNull(addtype) && "1".equals(addtype)){
		listRes.add(Restrictions.eq("myshow_mbrid", new Long(0)));
	}else{
		listRes.add(Restrictions.gt("myshow_mbrid", new Long(0)));
	}
	if(!Tools.isNull(rackcode)){
		listRes.add(Restrictions.like("myshow_img80100", rackcode+"%"));
	}
	if(!Tools.isNull(issh)){
		listRes.add(Restrictions.eq("myshow_status", new Long(issh)));
	}
	if(s!=null){
		listRes.add(Restrictions.ge("myshow_createdate", s));
	}
	if(e!=null){
		listRes.add(Restrictions.le("myshow_createdate", e));
	}
	if(!Tools.isNull(checkuser)){
		listRes.add(Restrictions.like("myshow_checkuser", "%"+checkuser+"%"));
	}
	if(!Tools.isNull(adduser)){
		listRes.add(Restrictions.like("myshow_adduser", "%"+adduser+"%"));
	}
	if(ctimes!=null){
		listRes.add(Restrictions.ge("myshow_checkdate", ctimes));
	}
	if(ctimee!=null){
		listRes.add(Restrictions.le("myshow_checkdate", ctimee));
	}
	if(addtimes!=null){
		listRes.add(Restrictions.ge("myshow_adddate", addtimes));
	}
	if(addtimee!=null){
		listRes.add(Restrictions.le("myshow_adddate", addtimee));
	}
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("myshow_createdate"));
	List<BaseEntity> b_list = Tools.getManager(MyShow.class).getList(listRes, olist, begin, end);
	if(b_list==null || b_list.size()==0) return null;

		for(BaseEntity be:b_list){
			list.add((MyShow)be);
		}
	return list;
}
int  getShowByLen(String gdsid,String rackcode,String issh,Date s,Date e,String checkuser,Date ctimes,Date ctimee,String adduser,Date addtimes,Date addtimee,String addtype){
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
	}
	if(!Tools.isNull(rackcode)){
		listRes.add(Restrictions.like("myshow_img80100", rackcode+"%"));
	}
	if(!Tools.isNull(addtype) && "1".equals(addtype)){
		listRes.add(Restrictions.eq("myshow_mbrid", new Long(0)));
	}else{
		listRes.add(Restrictions.gt("myshow_mbrid", new Long(0)));
	}
	if(!Tools.isNull(issh)){
		listRes.add(Restrictions.eq("myshow_status", new Long(issh)));
	}
	if(s!=null){
		listRes.add(Restrictions.ge("myshow_createdate", s));
	}
	if(e!=null){
		listRes.add(Restrictions.le("myshow_createdate", e));
	}
	if(!Tools.isNull(checkuser)){
		listRes.add(Restrictions.like("myshow_checkuser", "%"+checkuser+"%"));
	}
	if(!Tools.isNull(adduser)){
		listRes.add(Restrictions.like("myshow_adduser", "%"+adduser+"%"));
	}
	if(ctimes!=null){
		listRes.add(Restrictions.ge("myshow_checkdate", ctimes));
	}
	if(ctimee!=null){
		listRes.add(Restrictions.le("myshow_checkdate", ctimee));
	}
	if(addtimes!=null){
		listRes.add(Restrictions.ge("myshow_adddate", addtimes));
	}
	if(addtimee!=null){
		listRes.add(Restrictions.le("myshow_adddate", addtimee));
	}
return Tools.getManager(MyShow.class).getLength(listRes);
	
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script src="/res/js/jquery-1.3.2.min.js"></script> 
<style type="text/css">
td{
border-bottom:solid 1px #999999;
border-right:solid 1px #999999;
}
</style>
</head>
<body>
<center>

<%
String start="";
String end ="";
String rackcode="";
String gdsid="";
//String isshow="";
String issh="";
String adduser="";
String txtcheckuser="";
String txtcheckdates="";
String txtcheckdatee="";

String txtaddtimes="";
String txtaddtimee="";

String addtype="";//是否手动添加
if(!Tools.isNull(request.getParameter("addtype"))){
	addtype=request.getParameter("addtype");
}

if(!Tools.isNull(request.getParameter("txtStart"))){
	start=request.getParameter("txtStart");
}
if(!Tools.isNull(request.getParameter("txtEnd"))){
	end=request.getParameter("txtEnd");
}
if(!Tools.isNull(request.getParameter("txtrackcode"))){
	rackcode=request.getParameter("txtrackcode");
}
if(!Tools.isNull(request.getParameter("txtgdsid"))){
	gdsid=request.getParameter("txtgdsid");
}
//if(!Tools.isNull(request.getParameter("isshow"))){
//	isshow=request.getParameter("isshow");
//}
if(!Tools.isNull(request.getParameter("issh"))){
	issh=request.getParameter("issh");
}
if(!Tools.isNull(request.getParameter("txtadduser"))){
	adduser=request.getParameter("txtadduser");
}
if(!Tools.isNull(request.getParameter("txtcheckuser"))){
	txtcheckuser=request.getParameter("txtcheckuser");
}
if(!Tools.isNull(request.getParameter("txtcheckdates"))){
	txtcheckdates=request.getParameter("txtcheckdates");
}
if(!Tools.isNull(request.getParameter("txtcheckdatee"))){
	txtcheckdatee=request.getParameter("txtcheckdatee");
}

if(!Tools.isNull(request.getParameter("txtaddtimes"))){
	txtaddtimes=request.getParameter("txtaddtimes");
}
if(!Tools.isNull(request.getParameter("txtaddtimee"))){
	txtaddtimee=request.getParameter("txtaddtimee");
}

if(Tools.isNull(start) && Tools.isNull(end) && Tools.isNull(addtype)){
	start= Tools.getDate();
}
if(!Tools.isNull(start)){
	start=start+" 00:00:00";
}
if(!Tools.isNull(end)){
	end=end+" 23:59:59";
}
if(!Tools.isNull(txtcheckdates)){
	txtcheckdates=txtcheckdates+" 00:00:00";
}
if(!Tools.isNull(txtcheckdatee)){
	txtcheckdatee=txtcheckdatee+" 23:59:59";
}
if(!Tools.isNull(txtaddtimes)){
	txtaddtimes=txtaddtimes+" 00:00:00";
}
if(!Tools.isNull(txtaddtimee)){
	txtaddtimee=txtaddtimee+" 23:59:59";
}
String ggURL = Tools.addOrUpdateParameter(request,null,null);
if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");

 if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 pageURL = pageURL.replaceAll("&+", "&");
SimpleDateFormat format=	new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date s=null;
Date e=null;
Date ctimes=null;
Date ctimee=null;
Date addtimes=null;
Date addtimee=null;
if(!Tools.isNull(start)){
	s=format.parse(start);
}
if(!Tools.isNull(end)){
	e=format.parse(end);
}
if(!Tools.isNull(txtcheckdates)){
	ctimes=format.parse(txtcheckdates);
}
if(!Tools.isNull(txtcheckdatee)){
	ctimee=format.parse(txtcheckdatee);
}
if(!Tools.isNull(txtaddtimes)){
	addtimes=format.parse(txtaddtimes);
}
if(!Tools.isNull(txtaddtimee)){
	addtimee=format.parse(txtaddtimee);
}

int total=getShowByLen(gdsid, rackcode, issh, s, e,txtcheckuser,ctimes,ctimee,adduser,addtimes,addtimee,addtype);
int currentPage = 1 ;
String pg = request.getParameter("pageno");
if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);

int PAGE_SIZE = 20 ;
PageBean pBean = new PageBean(total,PAGE_SIZE,currentPage);

 ArrayList<MyShow> list= getAllShowByGdsid(gdsid, rackcode, s, e,pBean.getStart(),PAGE_SIZE,issh,txtcheckuser,ctimes,ctimee,adduser,addtimes,addtimee,addtype);

if(list!=null && list.size()>0){
	%>
	<table id="__01"   border="0" cellpadding="0" cellspacing="0" style="width:100%;font-size:12px; line-height:24px;">
	<%
	if("1".equals(addtype)){
		%>
		<tr><td style="border-top:solid 1px #999999;background:#FF9999;">商品编号</td>
			<td style="border-top:solid 1px #999999;background:#FF9999;">晒单时间</td>
		<td style="border-top:solid 1px #999999;background:#FF9999;">添加人</td>
	
		<td style="border-top:solid 1px #999999;background:#FF9999;">添加时间</td>
	<td style="border-top:solid 1px #999999;background:#FF9999;">查看详情</td></tr>
		<%}else{
	%>
	
	<tr><td style="border-top:solid 1px #999999;border-left:solid 1px #999999; background:#FF9999;">订单号</td><td style="border-top:solid 1px #999999;background:#FF9999;">商品编号</td><td style="border-top:solid 1px #999999;background:#FF9999;">用户名</td>
	
		<td style="border-top:solid 1px #999999;background:#FF9999;">审核状态</td>
	<td style="border-top:solid 1px #999999;background:#FF9999;">晒单时间</td>
	<td style="border-top:solid 1px #999999;background:#FF9999;">审核人</td>
	<td style="border-top:solid 1px #999999;background:#FF9999;">审核时间</td>
	<td style="border-top:solid 1px #999999;background:#FF9999;">查看详情</td></tr>
	<%	
		}
	for(MyShow show:list){
		String yx="有效";String sh="已审核";
		if(show.getMyshow_show()==0){
			 yx="无效";
		}if(show.getMyshow_status()==0){
			sh="未审核";
		}
		else if(show.getMyshow_status()==1){
			sh="审核通过显示";
		}else if(show.getMyshow_status()==2){
			sh="审核未通过";
		}
		else if(show.getMyshow_status()==3){
				sh="审核通过不显示";
			}
		String smallimg="";
		if(!Tools.isNull(show.getMyshow_img100())){
			smallimg="http://images1.d1.com.cn"+show.getMyshow_img100();
		}else{
			smallimg="http://images1.d1.com.cn"+show.getMyshow_img240300();
		}
		if("1".equals(addtype)){
		%>
		<tr>
		<td > <a href="up.jsp?showid=<%= show.getId()%>" target="rbottom"><img src="<%=smallimg %>" width="80" alt="" border="0"/> </a>  
		<a href="http://www.d1.com.cn/product/<%= show.getMyshow_gdsid()%>" target="_blank"><%=show.getMyshow_gdsid() %> </a>  </td>
		<td ><%=Tools.stockFormatDate(show.getMyshow_createdate())  %></td>
		<td ><%=show.getMyshow_adduser()==null ? "":  show.getMyshow_adduser()%></td>
		<td ><%=Tools.stockFormatDate(show.getMyshow_adddate())  %></td>
		
		
		<td ><a href="up.jsp?showid=<%=show.getId() %>" target="rbottom">查看</a> </td></tr>
	<%	}else{
		%>
		<tr><td><%=show.getMyshow_odrid() %></td>
		<td > <a href="up.jsp?showid=<%= show.getId()%>" target="rbottom"><img src="<%=smallimg %>" width="80" alt="" border="0"/> </a>  
		<a href="http://www.d1.com.cn/product/<%= show.getMyshow_gdsid()%>" target="_blank"><%=show.getMyshow_gdsid() %> </a>  </td>
		<td><%=show.getMyshow_mbruid() %></td>
		
		<td><%=sh %></td>
		<td ><%=Tools.stockFormatDate(show.getMyshow_createdate())  %></td>
		<td ><%=show.getMyshow_checkuser()==null ? "":  show.getMyshow_checkuser()%></td>
		<td ><%=Tools.stockFormatDate(show.getMyshow_checkdate())  %></td>
		<td ><a href="up.jsp?showid=<%=show.getId() %>" target="rbottom">查看</a> </td></tr>
		<%}
		
	}
	if(pBean.getTotalPages()>1){ %>
	<tr>
		<td colspan="7"> <div class="GPager">
           	<span style="color:#919191">共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           			if(i==1)
           			{%>
           				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
           			<%}
           			else
           			{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		    }
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
           </div></td>
	</tr><%
	} %>
	</table>
<%}else{
	out.print("没有数据");
}
%>

   
</center>
</body>
</html>