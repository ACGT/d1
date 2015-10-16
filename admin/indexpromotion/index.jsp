<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%><%!
static ArrayList<PromotionImagePos> getPromotionImage(String promotionId){
	ArrayList<PromotionImagePos> list=new ArrayList<PromotionImagePos>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("promotionId",promotionId));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("id"));
	List<BaseEntity> mxlist= Tools.getManager(PromotionImagePos.class).getList(listRes, listOrder, 0, 100);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((PromotionImagePos)be);
	}
	 return list;
}
%>
<%
//if(session.getAttribute("admin_mng")!=null){
	  // String userid=session.getAttribute("admin_mng").toString();
	  // ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "indexpromotion");
	   //if(aplist==null||aplist.size()<=0){
		 //  out.print("对不起，您没有操作权限！");
		 //  return;
	  // }
//} 
//else {return;}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script type="text/javascript" src="search.js"></script>
        <script src="/res/js/jquery-1.3.2.min.js"></script> 
        <script src="jquery.jcrop.min.js"></script> 
<style type="text/css"> 
      
        .jcrop-holder { 
            text-align: left; 
        } 
        .jcrop-vline, .jcrop-hline{ 
            font-size: 0; 
            position: absolute; 
           background: white url('http://img.jb51.net/jslib/images/Jcrop.gif') top left repeat; 
        } 
        .jcrop-vline { 
            height: 100%; 
            width: 1px !important; 
        } 
        .jcrop-hline { 
            width: 100%; 
            height: 1px !important; 
        } 
        .jcrop-handle { 
            font-size: 1px; 
            width: 7px !important; 
            height: 7px !important; 
            border: 1px #eee solid; 
            background-color: #333; 
            *width: 9px; 
            *height: 9px; 
        } 
         
        .jcrop-tracker { 
            width: 100%; 
            height: 100%; 
        } 
         
        .custom .jcrop-vline,.custom .jcrop-hline{ 
            background: yellow; 
        } 
        .custom .jcrop-handle{ 
            border-color: black; 
            background-color: #C7BB00; 
            -moz-border-radius: 3px; 
            -webkit-border-radius: 3px; 
        } 
        </style> 
<script type="text/javascript">
function del(id){
	if(!window.confirm('确认要删除吗?')) return;
	var promotionid=$.trim($("#txtpromotionid").val());
	$.ajax({
			type: "POST",
			url: "function.jsp",
			data:"isdel=1&id="+id, 
			//contentType: "application/json; charset=utf-8",
			success: function(msg) {
				if(msg==3){
					return false;
				}else if(msg==2){
					alert("删除成功！");
					window.location.href='index.jsp?txtpromotionid='+promotionid;
				}
			},
			error: function(xhr,msg,e) {
				return false;
			}
			});
}

function up(id,gdsid,x,y,x2,y2,price){
	
	$("#upid").val(id);
	$("#txtgdsid").val(gdsid);
	$("#txtX1").val(x);
	$("#txtY1").val(y);
	$("#txtX2").val(x2);
	$("#txtY2").val(y2);
	$("#txtPrice").val(price);
}
function pupdate(){
	var id=$.trim($("#upid").val());
	var promotionid=$.trim($("#txtpromotionid").val());
	var gdsid=$.trim($("#txtgdsid").val());
	var x=$.trim($("#txtX1").val());
	var y=$.trim($("#txtY1").val());
	var x2=$.trim($("#txtX2").val());
	var y2=$.trim($("#txtY2").val());
	var price=$.trim($("#txtPrice").val());
	//alert(gdsid);
	if(id.length==0){
		alert("请选择要修改的行！");
		return false;
	}
	else if(gdsid.length==0){
		alert("请输入商品编号！");
		return false;
	}
	else if(x.length==0 || y.length==0){
		alert("请选择位置！");
		return false;
	}
	else{
		$.ajax({
			type: "POST",
			url: "function.jsp",
			data:"update=1&id="+id+"&promotionid="+promotionid+"&gdsid="+gdsid+"&x="+x+"&y="+y+"&x2="+x2+"&y2="+y2+"&price="+price, 
			//contentType: "application/json; charset=utf-8",
			success: function(msg) {
				if(msg==5){
					return false;
				}else if(msg==4){
					alert("修改成功！");
					window.location.href='index.jsp?txtpromotionid='+promotionid;
				}
			},
			error: function(xhr,msg,e) {
				return false;
			}
			});
	}
}
$(function(){ 
	//事件处理 
	$("#cropbox").Jcrop({ 
	onChange:showCoords, //当选择区域变化的时候，执行对应的回调函数 
	onSelect:showCoords //当选中区域的时候，执行对应的回调函数 
	}); 
	}); 
	function showCoords(c) { 
	$("#txtX1").val(c.x); //得到选中区域左上角横坐标 
	$("#txtY1").val(c.y); //得到选中区域左上角纵坐标 
	$("#txtX2").val(c.x2); //得到选中区域右下角横坐标 
	$("#txtY2").val(c.y2); //得到选中区域右下角纵坐标 
	}
	function save(){
		var promotionid=$.trim($("#txtpromotionid").val());
		var gdsid=$.trim($("#txtgdsid").val());
		var x=$.trim($("#txtX1").val());
		var y=$.trim($("#txtY1").val());
		var x2=$.trim($("#txtX2").val());
		var y2=$.trim($("#txtY2").val());
		var price=$.trim($("#txtPrice").val());
		if(gdsid.length==0){
			alert("请输入商品编号！");
			return false;
		}
		else if(x.length==0 || y.length==0){
			alert("请选择位置！");
			return false;
		}
		else{
			$.ajax({
				type: "POST",
				url: "function.jsp",
				data:"add=1&promotionid="+promotionid+"&gdsid="+gdsid+"&x="+x+"&y="+y+"&x2="+x2+"&y2="+y2+"&price="+price, 
				//contentType: "application/json; charset=utf-8",
				success: function(msg) {
					if(msg==0){
						return false;
					}else{
						alert("保存成功！");
						window.location.href='index.jsp?txtpromotionid='+promotionid;
					}
				},
				error: function(xhr,msg,e) {
					return false;
				}
				});
		}
		
	}
</script>
</head>
<body>
<center>
<%@include file="head.jsp"%>

<%
	String promotionid = request.getParameter("txtpromotionid");
	if(Tools.isNull(promotionid)){
	%>	
	请输入推荐位号！
	<%}else{
		ArrayList<Promotion> list = new ArrayList<Promotion>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("id", promotionid));
		List<BaseEntity> rlist = Tools.getManager(Promotion.class).getList(clist, null, 0, 1);
		for(BaseEntity be:rlist){
			list.add((Promotion)be);
		}
		
		if(list!=null && list.size()>0){
	    	for(Promotion pProduct:list){
	    		 ArrayList<PromotionImagePos> plist= getPromotionImage(promotionid);
	    		// System.out.println(plist.size()+">>>>>>>>>>>>>>");
	    		 if(plist!=null){
	    			 %>	
	    			 <table width="800"  border="1" cellspacing="0" cellpadding="0" bordercolor="#CCCCCC">
	    			 <tr><td>推荐位ID</td><td>商品编号</td><td>X</td><td>Y</td><td>X2</td><td>Y2</td><td>价格</td><td>修改</td><td>删除</td></tr>
	    			 
	    			<% for(PromotionImagePos pimg:plist){
	    				 %>	 
	    				 <tr><td><%=pimg.getPromotionId() %></td><td><%=pimg.getProductId() %></td><td><%=pimg.getPos_x()%></td><td><%=pimg.getPos_y()%></td><td><%=pimg.getExt1() %></td><td><%=pimg.getExt2() %></td>
	    				 <td><%= pimg.getPprice()==null?0:Tools.getFloat(pimg.getPprice(),1) %></td>
	    				 <td><a href="javascript:void(0);" onclick="up(<%=pimg.getId()%>,'<%=pimg.getProductId().toString().trim()%>',<%=pimg.getPos_x()%>,<%=pimg.getPos_y()%>,<%=pimg.getExt1()%>,<%=pimg.getExt2()%>,<%= pimg.getPprice()==null?0:Tools.getFloat(pimg.getPprice(),1) %>);">修改</a>
	    			 </td><td><a href="javascript:void(0);" onclick="del(<%=pimg.getId()%>);">删除</a></td></tr>
	    			<% } %>	 
	    			</table>
	    		 <%}
	    		%>	
	    		<input type="hidden"  id="upid" />
	    		<div style="float:left"><img id="cropbox"  src="<%=pProduct.getSplmst_picstr() %>" alt="" /></div>
	    		<div style="float:left">
	    		<table>
	    		<tr>
	    		 <td>商品编号：</td><td><input type="text" id="txtgdsid" /></td>
	    		</tr>
	    		<tr>
	    		 <td align="right">左上横坐标x1：</td><td><input type="text" id="txtX1" /> <br/></td>
	    		</tr>
	    		<tr>
	    		 <td align="right">右上纵坐标y1：</td><td><input type="text" id="txtY1" /> <br/></td>
	    		</tr>
	    		<tr>
	    		 <td align="right">左下横坐标x2：</td><td><input type="text" id="txtX2" /> <br/></td>
	    		</tr>
	    		<tr>
	    		 <td align="right">右下纵坐标y2：</td><td><input type="text" id="txtY2" /> <br/></td>
	    		</tr>
	    		
	    		<tr>
	    		<td ></td>
	    		 <td ><input type="button" value="保存" onclick="save();"/> &nbsp;&nbsp;&nbsp;<input type="button" value="修改" onclick="pupdate();"/></td>
	    		</tr>
	    		</table>
	    		</div>
	    	<%}
	    	
	    }
	
	}
%>
</center>
</body>
</html>