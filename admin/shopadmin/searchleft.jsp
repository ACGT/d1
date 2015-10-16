<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.Tools,java.util.*"%><%@include file="/admin/chkrgt.jsp"%>
<script type="text/javascript" src="search.js"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<%
String txtgdsid="";
String txtgdsname="";
String txtcreatestime="";
String txtcreateetime="";
String sgdsflag="";
String req_promotion="";
String iftj="";
String req_stock="";
String gdsmst_ifhavegds="";
String gdsmst_giftselecttype="";
if(!Tools.isNull(request.getParameter(txtgdsid))){
	txtgdsid=request.getParameter(txtgdsid);
}
if(!Tools.isNull(request.getParameter(txtgdsname))){
	txtgdsname=request.getParameter(txtgdsname);
}
if(!Tools.isNull(request.getParameter(txtcreatestime))){
	txtcreatestime=request.getParameter(txtcreatestime);
}
if(!Tools.isNull(request.getParameter(txtcreateetime))){
	txtcreateetime=request.getParameter(txtcreateetime);
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
%>
<table  width="220"  cellspacing="0" cellpadding="0" style="border: 1px solid #C0C0C0; background:#EBEBEB; line-height:24px;">
<tr><td colspan="2" height="15px">&nbsp;</td></tr>
<tr><td >商品编号：<input type="text" name="txtgdsid" style="width:120px;" value="<%=txtgdsid%>"/></td></tr>
<tr><td >商品名称：<input type="text" name="txtgdsname" style="width:120px;" value="<%=txtgdsname%>"/></td></tr>
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
<td>是否促销：<input type="checkbox" name="req_promotion" value="on"  <%if(req_promotion.equals("on")){%>checked="checked"<%} %>><br>
是否特价：<input type="checkbox" name="iftj" value="on" <%if(iftj.equals("on")){%>checked="checked"<%} %>><br>
是否库存：<input type="checkbox" name="req_stock" value="on" <%if(req_stock.equals("on")){%>checked="checked"<%} %>><br/>
是否缺货：<SELECT  name=gdsmst_ifhavegds>
		  <OPTION value="">全部</OPTION>
		  <OPTION value="0"  <%if(gdsmst_ifhavegds.equals("0")){%>selected="selected"<%} %>>不缺</OPTION>
		  <OPTION value="1"  <%if(gdsmst_ifhavegds.equals("1")){%>selected="selected"<%} %>>很快就到</OPTION>
		  <OPTION value="2"  <%if(gdsmst_ifhavegds.equals("2")){%>selected="selected"<%} %>>到货时间未定</OPTION>
		  <OPTION value="3" <%if(gdsmst_ifhavegds.equals("3")){%>selected="selected"<%} %> >非卖品</OPTION>
		  </SELECT><BR>
单品赠品：<SELECT  name=gdsmst_giftselecttype>
		  <OPTION value="">全部</OPTION>
		  <OPTION value="0" <%if(gdsmst_giftselecttype.equals("0")){%>selected="selected"<%} %>>无</OPTION>
		  <OPTION value="1" <%if(gdsmst_giftselecttype.equals("1")){%>selected="selected"<%} %>>赠品单选</OPTION>
		  <OPTION value="2" <%if(gdsmst_giftselecttype.equals("2")){%>selected="selected"<%} %>>赠品多选</OPTION>
		  </SELECT>
</td>
</tr>
<tr><td  height="15px">&nbsp;</td></tr>
	<tr><td  align="center"><input type="button" onclick="search()" value="搜 索"/></td></tr>
<tr><td  height="25px">&nbsp;</td></tr>
</table>