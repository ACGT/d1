<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script src="/res/js/jquery-1.3.2.min.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	chdhtype($("#sh").val());
});

function chdhtype(v){
	if(v==2){//审核未通过
		$("#backtype").show();
		$("#backtype").val('0');
	}else{
		$("#backtype").hide();
	}
}
function checkreason(v){
	if(v!=0){
		$("#tcontent").val($("#backtype").find("option:selected").text());
	}
}


function shsd(obj){
	var showid=$(obj).attr("attr");
	var yx=$("#yx").val();
	var sh=$("#sh").val();
	var  jf=$("#jf").val();
	var mid=$("#hmbrid").val();
	var backtype=$("#backtype").val();
	var tcontent=$("#tcontent").val();
	var sdcontent="";
	if($("#sdcontent").length>0){
		sdcontent=$("#sdcontent").val();
	}
	$.ajax({
		type: "get",
		dataType: "json",
		url: 'op.jsp',
		cache: false,
		data: {showid:showid,yx:yx,sh:sh,jf:jf,mid:mid,backtype:backtype,tcontent:tcontent,sdcontent:sdcontent},
		error: function(XmlHttpRequest){
		},success: function(json){
			if(json.success){
				alert(json.message);
				
			}else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>

</head>
<body>
<center>

<%
String showid=request.getParameter("showid");
if(!Tools.isNull(showid)){
	MyShow show=(MyShow)Tools.getManager(MyShow.class).get(showid);
			if(show!=null){
				String yx=show.getMyshow_show()+"";
				String sh=show.getMyshow_status()+"";
				String imgurl="http://images1.d1.com.cn";
				if( show.getMyshow_img400500().indexOf("/uploads/sd/")>=0){
					imgurl="http://d1.com.cn";
				}
				String backc="";
				if(!Tools.isNull(show.getMyshow_reason())){
					backc=show.getMyshow_reason();
				}
				%>
				<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;font-size:12px; line-height:26px;">
	<tr>
	<td>订单号：<%=show.getMyshow_odrid() %></td><td>商品编号：<a href="http://www.d1.com.cn/product/<%= show.getMyshow_gdsid()%>" target="_blank"><%=show.getMyshow_gdsid() %></a></td><td>晒单时间：<%=Tools.stockFormatDate(show.getMyshow_createdate())  %></td>
	</tr>
	<tr>
	<td>用户名：<%=show.getMyshow_mbruid() %> <input type="hidden" value="<%=show.getMyshow_mbrid()%>" id="hmbrid"/> </td>
	<td>审核状态：<select id="sh" name="sh" onchange="chdhtype(this.value);">
  <option value="1" <%if("1".equals(sh)) {%> selected="selected"<%} %>>审核通过显示</option>
   <option value="3" <%if("3".equals(sh)) {%> selected="selected"<%} %>>审核通过不显示</option>
  <option value="0" <%if("0".equals(sh)) {%> selected="selected"<%} %>>未审核</option>
   <option value="2" <%if("2".equals(sh)) {%> selected="selected"<%} %>>审核未通过</option>
  </select></td>
  <td>晒单积分:<select id="jf" name="jf">
  <option value="0" >0分</option>
  <option value="30" <%if( show.getMyshow_score()!=null&& show.getMyshow_score()==30) {%> selected="selected"<%} %>>30分</option>
   <option value="50" <%if(show.getMyshow_score()!=null&& show.getMyshow_score()==50) {%> selected="selected"<%} %>>50分</option>
    <option value="100" <%if(show.getMyshow_score()!=null&& show.getMyshow_score()==100) {%> selected="selected"<%} %>>100分</option>
     <option value="200" <%if(show.getMyshow_score()!=null&& show.getMyshow_score()==200) {%> selected="selected"<%} %>>200分</option>
  </select></td>
	</tr>
	<tr>
	<td>晒单图片：<a href="<%=imgurl+ show.getMyshow_img400500()%>" target="_blank"><img width="200" src="<%= imgurl+ show.getMyshow_img240300()%>" border="0"/></a></td>
	<td colspan="2">商品原图<a href="http://www.d1.com.cn/product/<%= show.getMyshow_gdsid()%>" target="_blank"><img width="200" src="http://images.d1.com.cn<%=ProductHelper.getById(show.getMyshow_gdsid()).getGdsmst_midimg()%>" border="0"/></a></td>
	</tr>
	<tr>
	<td colspan="3"  align="left">内容：
	<%
	if(show.getMyshow_mbrid()!=0){
		out.print(show.getMyshow_content());
	}else{
	%>
	<textarea id="sdcontent" cols="90" rows="4" style="color:gray;font-size:12px;"><%=show.getMyshow_content()%></textarea>
	<%} %>
	</td>
	</tr>
	<tr>
	<td>打回类型：<select id="backtype" name="backtype" style="display:none;"  onclick="checkreason(this.value);">
	<option value="0">无</option>
  <option value="1" <%if( show.getMyshow_reasontype()!=null&& show.getMyshow_reasontype()==1) {%> selected="selected"<%} %>>图片和商品不符合</option>
  <option value="2" <%if( show.getMyshow_reasontype()!=null&& show.getMyshow_reasontype()==2) {%> selected="selected"<%} %>>非法晒单</option>
  
  </select></td>
	<td colspan="2"  align="left">审核留言： <textarea id="tcontent" cols="60" rows="4" style="color:gray;font-size:12px;"><%=backc %></textarea></td></tr>
	<tr><td colspan="3" align="center"><a href="javascript:void(0);" onclick="shsd(this);" attr="<%=showid%>" ><img src="http://images.d1.com.cn/images2012/sd/an_20.jpg" border="0"/></a></td></tr>
		<%	}
			
	%>
	
	</table>
<%}
%>

   
</center>
</body>
</html>