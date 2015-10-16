<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品信息查询</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">

</style>
<script type="text/javascript">

</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->

<!-- 头部结束 -->

<table>
<tr><td valign="top">
<%
String shopcode="03050801";
String txtgdsid="";
String txtkey="";
String txtgdsname="";
String txtcreatestime="";
String txtcreateetime="";
String sgdsflag="";
String req_promotion="";
String iftj="";
String req_stock="";
String gdsmst_ifhavegds="";
String gdsmst_giftselecttype="";
Date s=null;
Date e=null;
String shopgdsid="";
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
if(!Tools.isNull(request.getParameter(txtgdsid))){
	txtgdsid=request.getParameter(txtgdsid);
}
if(!Tools.isNull(request.getParameter(txtgdsname))){
	txtgdsname=request.getParameter(txtgdsname);
}
if(!Tools.isNull(request.getParameter(txtcreatestime))){
	txtcreatestime=request.getParameter(txtcreatestime);
	try{
		s=sdf.parse(txtcreatestime);
	}catch(Exception ex){
		ex.printStackTrace();
	}
}
if(!Tools.isNull(request.getParameter(txtcreateetime))){
	txtcreateetime=request.getParameter(txtcreateetime);
	try{
		e=sdf.parse(txtcreateetime);
	}catch(Exception ex){
		ex.printStackTrace();
	}
}
if(!Tools.isNull(request.getParameter(txtkey))){
	txtkey=request.getParameter(txtkey);
}
if(!Tools.isNull(request.getParameter(sgdsflag))){
	sgdsflag=request.getParameter(sgdsflag);
}
if(!Tools.isNull(request.getParameter(req_promotion))){
	req_promotion=request.getParameter(req_promotion);
}
if(!Tools.isNull(request.getParameter(iftj))){
	iftj=request.getParameter(iftj);
}
if(!Tools.isNull(request.getParameter(req_stock))){
	req_stock=request.getParameter(req_stock);
}
if(!Tools.isNull(request.getParameter(gdsmst_ifhavegds))){
	gdsmst_ifhavegds=request.getParameter(gdsmst_ifhavegds);
}
if(!Tools.isNull(request.getParameter(gdsmst_giftselecttype))){
	gdsmst_giftselecttype=request.getParameter(gdsmst_giftselecttype);
}
if(!Tools.isNull(request.getParameter("shopgdsid"))){
	shopgdsid=request.getParameter("shopgdsid");
}
int pagesize=30;
int currentPage=1;
ArrayList<Product> list=ProductHelper.getProductList(shopcode,txtgdsid,txtgdsname,txtkey,s,e,sgdsflag, req_promotion, iftj, req_stock, gdsmst_ifhavegds, gdsmst_giftselecttype,0,3000,shopgdsid);
int totalcount=list.size();
if(!Tools.isNull(request.getParameter("pageno"))){
	currentPage=Integer.parseInt(request.getParameter("pageno"));
}
PageBean pBean = new PageBean(totalcount,pagesize,currentPage);
 
 int end = pBean.getStart()+pagesize;
 if(end > totalcount) end = totalcount;
String pgQueryString = "index.jsp?txtgdsid="+txtgdsid+"&txtgdsname="+txtgdsname+"&txtcreatestime="+txtcreatestime+"&txtcreateetime="+txtcreateetime+"&sgdsflag="+sgdsflag+"&req_promotion="+req_promotion+"&iftj="+iftj+"&req_stock="+req_stock+"&gdsmst_ifhavegds="+gdsmst_ifhavegds+"&gdsmst_giftselecttype="+gdsmst_giftselecttype+"&shopgdsid="+shopgdsid;
String pageURL = pgQueryString.replaceAll("pageno=[0-9]+","&");

 if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 pageURL = pageURL.replaceAll("&+", "&");
%>
<form action="index.jsp" method="post">
<table  width="220"  cellspacing="0" cellpadding="0" style="border: 1px solid #C0C0C0; background:#EBEBEB; line-height:24px;">
<tr><td colspan="2" height="15px">&nbsp;</td></tr>
<tr><td >商品编号：<input type="text" name="txtgdsid" style="width:120px;" value="<%=txtgdsid%>"/></td></tr>
<tr><td >商品名称：<input type="text" name="txtgdsname" style="width:120px;" value="<%=txtgdsname%>"/></td></tr>
<tr><td >关键字：<input type="text" name="txtkey" style="width:120px;" value="<%=txtkey%>"/></td></tr>
<tr><td >商户内部编码：<input type="text" name="shopgdsid" style="width:120px;" value="<%=shopgdsid%>"/></td></tr>
<tr><td >录入时间：<input type="text" name="txtcreatestime" style="width:120px;" value="<%=txtcreatestime%>"/><br/>
至：<input type="text" name="txtcreateetime" style="width:120px;" value="<%=txtcreateetime%>"/></td></tr>
<tr><td >上下架状态：<select name="sgdsflag">
<option value="-1">全部</option>
          <option value="0" <%if(sgdsflag.equals("0")){%>selected="selected"<%} %>>录入待上架</option>
          <option value="1"  <%if(sgdsflag.equals("1")){%>selected="selected"<%} %>>上架</option>
          <option value="2"  <%if(sgdsflag.equals("2")){%>selected="selected"<%} %>>下架</option>
          <option value="4"  <%if(sgdsflag.equals("4")){%>selected="selected"<%} %>>隐藏</option>
</select></td></tr>
<tr>
<td>是否促销：<input type="checkbox" name="req_promotion" value="on"  <%if(req_promotion.equals("on")){%>checked="checked"<%} %>/><br>
是否特价：<input type="checkbox" name="iftj" value="on" <%if(iftj.equals("on")){%>checked="checked"<%} %>/><br>
是否库存：<input type="checkbox" name="req_stock" value="on" <%if(req_stock.equals("on")){%>checked="checked"<%} %>/><br/>
是否缺货：<select  name=gdsmst_ifhavegds>
		  <option value="">全部</option>
		  <option value="0"  <%if(gdsmst_ifhavegds.equals("0")){%>selected="selected"<%} %>>不缺</option>
		  <option value="1"  <%if(gdsmst_ifhavegds.equals("1")){%>selected="selected"<%} %>>很快就到</option>
		  <option value="2"  <%if(gdsmst_ifhavegds.equals("2")){%>selected="selected"<%} %>>到货时间未定</option>
		  <option value="3" <%if(gdsmst_ifhavegds.equals("3")){%>selected="selected"<%} %> >非卖品</option>
		  </select><br/>
单品赠品：<select  name=gdsmst_giftselecttype>
		  <option value="">全部</option>
		  <option value="0" <%if(gdsmst_giftselecttype.equals("0")){%>selected="selected"<%} %>>无</option>
		  <option value="1" <%if(gdsmst_giftselecttype.equals("1")){%>selected="selected"<%} %>>赠品单选</option>
		  <option value="2" <%if(gdsmst_giftselecttype.equals("2")){%>selected="selected"<%} %>>赠品多选</option>
		  </select>
</td>
</tr>
<tr><td  height="15px">&nbsp;</td></tr>
	<tr><td  align="center"><input type="submit"  value="搜 索"/></td></tr>
<tr><td  height="25px">&nbsp;</td></tr>
</table>
</form>
</td>
<td valign="top">
<%
	
	if(list!=null && list.size()>0){
		 List<Product> gList = list.subList(pBean.getStart(),end);
		%>
		<table>
		<tr><td>图片</td><td style="width:120px;">商品名称</td><td style="width:90px;">商户内部编码</td><td>价格</td><td style="width:60px;">库存数</td><td>上下架状态</td><td>单品赠品</td><td >其他信息</td></tr>
		<%
		for(Product product:gList){
		String img=product.getGdsmst_smallimg().trim();
		if(product.getGdsmst_smallimg().trim().indexOf("/upload/shopadmin/gdsimg")<=-1){
			img="http://images.d1.com.cn/"+img;
		}
		String flag="";
		if(product.getGdsmst_validflag().intValue()==0){
			flag="录入待上架";
		}else if(product.getGdsmst_validflag().intValue()==1){
			flag="上架";
		}else if(product.getGdsmst_validflag().intValue()==2){
			flag="下架";
		}else if(product.getGdsmst_validflag().intValue()==4){
			flag="隐藏";
		}
		String gift="";
		if(product.getGdsmst_giftselecttype().intValue()==0){
			gift="无";
		}else if(product.getGdsmst_giftselecttype().intValue()==1){
			gift="赠品单选";
		}else if(product.getGdsmst_giftselecttype().intValue()==2){
			gift="赠品多选";
		}
		%>
			<tr>
			<td><a href="gdsinfo.jsp?gdsid=<%=product.getId()%>" target="_blank"> <img src="<%=img %>" border="0"/></a> </td>
			<td><a href="gdsinfo.jsp?gdsid=<%=product.getId()%>" target="_blank"><%=product.getGdsmst_gdsname() %>&nbsp;&nbsp;(<%=product.getId()%>)</a></td>
			<td><%=product.getGdsmst_shopgoodscode() %></td>
			
			<td>市场价：<%=product.getGdsmst_saleprice().floatValue()%><br/>
			原会员价：<%=product.getGdsmst_oldmemberprice().floatValue()%><br/>
			会员价：<%=product.getGdsmst_memberprice().floatValue()%><br/>
			</td>
			<td><%=product.getGdsmst_stock().intValue() %></td>
			<td>
			<%=flag %>
			</td>
			<td>
			<%=gift %>
			</td>
			<td>
			关键词：<%=product.getGdsmst_keyword() %><br/>
			分类：<%=DirectoryHelper.getById(product.getGdsmst_rackcode().trim()).getRakmst_rackname() %><br/>(<%=product.getGdsmst_rackcode() %>)<br/>
			品牌：<%=product.getGdsmst_brandname() %><br/>
			入库时间：<%=Tools.stockFormatDate(product.getGdsmst_createdate()) %><br/>
			修改时间：<%=Tools.stockFormatDate(product.getGdsmst_updatedate()) %><br/>
			</td>
			</tr>
			<%}
		}%>
	</table>

</td>
</tr>
</table>
 <div class="Pager">  
     <%
           if(pBean.getTotalPages()>1){
           %>
           <div class="GPager">
           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
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
           </div><%}%>
          </div>

</body>
</html>