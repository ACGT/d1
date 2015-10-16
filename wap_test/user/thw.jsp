<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%>
<%@include file="../inc/islogin.jsp"%><%!
public static OrderItemBase getOrderItem(String orderId,String subodrid){
	if(Tools.isNull(orderId)) return null;
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);
	//if(order==null||order.getOdrmst_orderstatus().longValue()>=3)return null;
	if(order instanceof OrderMain){
		return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid);
	}else if(order instanceof OrderRecent){
	   	return (OrderItemBase)Tools.getManager(OrderItemRecent.class).get(subodrid);
	}
	return null;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>D1优尚网退换货</title>
<meta name="author" content="m.d1.cn">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="/res/wap/css/base.css"
	charset="utf-8" />
<link rel="stylesheet" type="text/css" href="/res/wap/css/uindex.css"
	charset="utf-8" />
<script type="text/javascript" src="/res/wap/js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/res/wap/js/com.js"></script>
<script type="text/javascript">
function displayOption() { 
	document.getElementById("req_thwhy").options.remove(0);
	document.getElementById("req_thwhy").options[0].selected = 'selected';
}
function showOption() { 
	document.getElementById("req_thwhy").options.add(new Option('发货速度慢', '发货速度慢'),0);
	document.getElementById("req_thwhy").options[0].selected = 'selected';
}
<!---->
function getpaytype(){
	var req_thtype=$('input:radio[name="req_thtype"]:checked').val();
	if(parseInt(req_thtype)==1){	
		 $('#paytype').show();
		 showOption();
	}else{
		$('#paytype').hide();
		 displayOption();
	}
}

 function odrdtlth(){
	var req_odrid= $('#req_odrid').val();
	var req_subodrid= $('#req_subodrid').val();
	var req_thtype=$('input:radio[name="req_thtype"]:checked').val();
	var req_paytype=$('input:radio[name="req_paytype"]:checked').val();
	
	var req_thwhy= $('#req_thwhy').val();
	var req_memo= $('#req_memo').val();
 	
	if(req_thwhy=='') {
		alert("请选择退货原因!");
	}else{
	 	$.post("/ajax/user/odrdtlth.jsp",{"req_odrid":req_odrid,"req_subodrid":req_subodrid,"req_thtype":req_thtype,"req_paytype":req_paytype,"req_thwhy":req_thwhy,"req_memo":req_memo},function(json){
				if(json.success) {
			 		window.location.href="/wap/user/odrstatusdetail.jsp?odrid="+req_odrid+"&subodrid="+req_subodrid+"&thtype="+req_thtype+"&lstatus=0";
				}else {
					alert(json.message)
				}
		},"json");
	}

 }
</script>
<style type="text/css">
td, select, input, textarea {
	font-size: 14px;
}

.service-type-list {
	margin-top: 40px;
	margin-left: 10px;
}

.service-type-list li {
	width: 100px;
	height: 100px;;
}

.service-type-list li a {
	border-radius: 5px;
	border: 1px solid rgb(255, 228, 189);
	transition: background 0.5s, border 0.5s;
	border-image: none;
	width: 100px;
	height: 100px;
	text-align: center;
	color: rgb(176, 77, 31);
	line-height: 100px;
	font-family: "Microsoft YaHei";
	font-size: 20px;
	font-weight: 400;
	display: block;
	background-color: rgb(255, 245, 229);
	-webkit-border-radius: 5px;
	-webkit-transition: background 0.5s, border 0.5s;
	-moz-transition: background 0.5s, border 0.5s;
	-o-transition: background 0.5s, border 0.5s;
}

.service-type-list li a:hover {
	border: 1px solid rgb(255, 83, 22);
	border-image: none;
	color: rgb(255, 255, 255);
	background-color: rgb(255, 133, 90);
}

.main-wrap {
	padding: 0px 10px;
}
</style>
</head>
<body>
	<header class="p_header">
		<a name="top"></a>
		<div class="h_txt">
			<div class="pageback">
				<a href="javascript:window.history.back(-1);">返回</a>
			</div>
			<div class="h_h2">
				<h2>
					<i></i>退换货申请
				</h2>
			</div>
			<div class="home">
				<a href="/wap/index.html"></a>
			</div>
			<div class="myuser">
				<a href="/wap/user/index.html"></a>
			</div>
			<div class="carth">
				<a href="/wap/flow.html"></a>
			</div>
		</div>
	</header>
	<div class="main">
		<% 
				String thtype = request.getParameter("thtype");
				String subodrid=request.getParameter("subodrid");
    		String odrid=request.getParameter("odrid");
    		if(!Tools.isNull(subodrid)&&odrid!=null){
    			OrderItemBase odritem =getOrderItem(odrid,subodrid);
    			
    	
    		%>
		<input type="hidden" id="req_odrid" name="req_odrid"
			value="<%=odrid %>" /> <input type="hidden" id="req_subodrid"
			name="req_subodrid" value="<%=subodrid %>" />
		<table border="0" style="padding: 10px">
			<tr style="display: none">
				<td align="right" height="30">退货换货类型：&nbsp;&nbsp;</td>
				<td><input type="radio" id="req_thtype"
					<%if(thtype.equals("1")){out.print("checked='checked'");} %>
					onclick="getpaytype();" name="req_thtype" value="1" />
					退货&nbsp;&nbsp; <input type="radio" id="req_thtype"
					name="req_thtype"
					<%if(thtype.equals("2")){out.print("checked='checked'");} %>
					onclick="getpaytype();" value="2" /> 换货</td>
			</tr>
			<tr id="paytype"
				style="display:<%if(thtype.equals("2")) {out.print("none");} else {out.print("''");}%>">
				<td align="right" height="30">退款方式：&nbsp;&nbsp;</td>
				<td><input type="radio" id="req_paytype1" name="req_paytype"
					value="1" /> 退到预存款 &nbsp;&nbsp; <input type="radio"
					id="req_paytype2" name="req_paytype" value="2" checked="checked" />
					原路退回</td>
			</tr>
			<!--  <tr>
    <td>上传图片</td>
    <td><input type="text" name="textfield2" /></td>
  </tr> -->
			<!--odrdtl OdrDtl_rackcode商品分类 -->
			<%
String rackcode = odritem.getOdrdtl_rackcode();//商品分类
String rackcode_new = "";
%>
			<tr>
				<td align="right" height="30">退货换货原因：&nbsp;&nbsp;</td>
				<td><select name="req_thwhy" id="req_thwhy">
						<option value="">请选择退货原因</option>
						<%
   	   if(rackcode != null){
	   rackcode_new = rackcode.substring(0, 3);
	   if(rackcode_new.equals("020")||rackcode_new.equals("030")){//服装 
	   %>
						<option value="尺码不合适">尺码不合适</option>
						<option value="尺码表不标准">尺码表不标准</option>
						<option value="面料问题">面料问题</option>
						<option value="颜色有色差">颜色有色差</option>
						<option value="做工不好">做工不好</option>
						<option value="面料问题">面料问题</option>
						<option value="明显质量问题">明显质量问题</option>
						<option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
						<% 
	  }else if(rackcode_new.equals("014")){//化妆品
		  %>
						<option value="商品过期">商品过期</option>
						<option value="包装磨损严重">包装磨损严重</option>
						<option value="商品破损">商品破损</option>
						<%  
	  }else if(rackcode_new.equals("050")){//包
		  %>
						<option value="商品破损">商品破损</option>
						<option value="颜色有色差">颜色有色差</option>
						<option value="尺码不标准">尺码不标准</option>
						<option value="材质与介绍不符合">材质与介绍不符合</option>
						<option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
						<option value="做工不好">做工不好</option>
						<option value="质量问题">质量问题</option>
						<%  
	  }else if(rackcode_new.equals("031")||rackcode_new.equals("021")){//鞋子
		  %>
						<option value="颜色有色差">颜色有色差</option>
						<option value="尺码不标准">尺码不标准</option>
						<option value="材质与介绍不符合">材质与介绍不符合</option>
						<option value="明显质量问题(污渍、破损等)">明显质量问题(污渍、破损等)</option>
						<option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
						<option value="做工不好">做工不好</option>
						<%  
	  }else if(rackcode_new.equals("012")){//创意家居
		  %>
						<option value="颜色有色差">颜色有色差</option>
						<option value="做工不好">做工不好</option>
						<option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
						<option value="明显质量问题(污渍、破损等)">明显质量问题(污渍、破损等)</option>
						<%  
	  }else if(rackcode_new.equals("015")||rackcode_new.equals("040")||rackcode_new.equals("060")){
		  %>
						<option value="发错货">发错货</option>
						<option value="包装残损">包装残损</option>
						<option value="质量问题">质量问题</option>
						<%  
	  }else if(rackcode_new.equals("070")){
		  %>
						<option value="商品变质">商品变质</option>
						<option value="包装残损">包装残损</option>
						<option value="过保质期">过保质期</option>
						<%  
	  }   }
  %>
						<option value="其它">其它</option>
				</select></td>
			</tr>
			<tr>
				<td align="right" height="30">退货换货备注：&nbsp;&nbsp;</td>
				<td><textarea name="req_memo" id="req_memo" style="width: 100%"
						cols="60" rows="4"></textarea></td>
			</tr>
			<tr>
				<td height="30">&nbsp;</td>
				<td><input type="submit" name="Submit" onclick="odrdtlth()"
					value="提交" /></td>
			</tr>

			<tr>
				<td height="30">&nbsp;</td>
				<td>
					<%   // }
    			ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(odritem.getOdrdtl_shopcode());
    			if(shpmst!=null){
    				out.print("<div> 提交退换货申请后请按以下地址寄回：<br>");
    				out.print("<span style=\"color:red\">"+shpmst.getShpmst_postaddr()+"</span>");
    				out.print("</div>");
    			}
    			
    			} %>
				</td>
			</tr>
		</table>
	</div>
	<div id="footer" class="footer">
		<script language="javascript">
					getwapFoot();
				</script>
	</div>
	<script language="javascript">
$("#thbut").click(function(){	
	
  var url=document.URL;
  var para="";
  var odrid="";
   if(url.lastIndexOf("?")>0)
   {
        para=url.substring(url.lastIndexOf("?")+1,url.length);
		var arr=para.split("&");
		para="";
		for(var i=0;i<arr.length;i++)
		{
		   if(arr[i].split("=")[0]=="odrid"){
			   odrid=arr[i].split("=")[1];
		   }
		}
   }
   var gourl="thw.html?odrid="+odrid+"";
	window.location.href=gourl;
 
	});
$("#hhbut").click(function(){	
	
	  var url=document.URL;
	  var para="";
	  var odrid="";
	   if(url.lastIndexOf("?")>0)
	   {
	        para=url.substring(url.lastIndexOf("?")+1,url.length);
			var arr=para.split("&");
			para="";
			for(var i=0;i<arr.length;i++)
			{
			   if(arr[i].split("=")[0]=="odrid"){
				   odrid=arr[i].split("=")[1];
			   }
			}
	   }
	   var gourl="hhw.html?odrid="+odrid+"";
		window.location.href=gourl;
	 
		});

		</script>
</body>
</html>