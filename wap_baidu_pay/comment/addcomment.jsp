<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品评价 - D1优尚</title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>"
	type="text/css" rel="stylesheet" />
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript"
	src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript">
function a ()
{
	var a1= $("input[name='markValue1']").val();
	alert(a1);
	var a2= $("input[name='markValue2']").val();
	alert(a2);
	}
	function add(){
		 var productidlist = $("input[name='productid']");
		 var productnamelist = $("input[name='productname']");
		 var contents=$(".txtcontent");
		
		 if(productnamelist.length==productidlist.length){
			 //document.form1.submit();
			 $("#form1").submit();
		 }
	}
					    
					</script>
</head>
<body>

	<%@ include file="../inc/head.jsp"%>

	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="/wap/user/index.jsp">我的优尚</a>>发表评论
			<br />
		</div>
		<form id="form1" name="form1"
			action="operation.jsp?orderid=<%=request.getParameter("orderid") %>"
			method="post">
			<%
      if(!Tools.isNull(request.getParameter("orderid"))){
    	  OrderBase base=OrderHelper.getById(request.getParameter("orderid"));
    	  if(base!=null){
    		  if(!lUser.getId().equals(String.valueOf(base.getOdrmst_mbrid()))){
    			  Tools.outJs(out,"你没有权限进行操作！","back");
					return;
    		  }
    		 
    			 int status= base.getOdrmst_orderstatus().intValue();
    			
    			 if(status == 3 || status == 31){
    			  if(status==3){
    				  status=5;
    				  //out.print(">>>>>>>>>>>>>>>>>>>>>>>>");
    			  }else if(status==31){
    				  status=51;
    			  }
    			 base.setOdrmst_orderstatus(new Long(status));
    			 base.setOdrmst_finishdate(new Date());
    			 Tools.getManager(base.getClass()).clearListCache(base);
    			 if(!Tools.getManager(base.getClass()).update(base, true)){
    				  Tools.outJs(out,"设置交易完成失败！","back");
    					return;
  					}else{
    			 // out.print(">>>>>>>>>>>>>>>>>>>>>>>>");
  					}
    			 }
    			// ArrayList<OrderItemBase> itemlist=null;
    			// out.print(base.getId());
    			 ArrayList<OrderItemBase> itemlist=OrderItemHelper.getMyOrderDetail(base.getId());
  				
    		 
    	  %>
			<table border="0" width="220px">
				<tr>
					<td height="5">&nbsp;</td>
				</tr>
				<tr>
					<td class="peisong_body" align="left"
						style="padding-left: 5px; padding-bottom: 5px"><span
						style="font-size: 13px; font-weight: bold">交易已经完成，感谢您惠顾D1优尚，欢迎您对本次交易及所购商品进行评价。</span>
					</td>
				</tr>

				<tr>
					<td class="peisong_body" align="left" valign="middle"
						style="padding-left: 4px; padding-right: 4px">
						<div style="background-color: #FEEEF1;">
							<span style="font-size: 12px;">感谢您的参与，成功评价1个商品，您将获得10个积分（</span><span
								style="font-size: 12px; color: red;">平安万里通用户除外</span><span
								style="font-size: 12px;">）。</span>
						</div>

					</td>
				</tr>

			</table>
			<%
    	 if(itemlist!=null && itemlist.size()>0){
    		 %>
			<table width="220px">
				<% int i=1;
    		 for(OrderItemBase item:itemlist){
    			
    		 
    			 Product product= ProductHelper.getById(item.getOdrdtl_gdsid());
				
				 String linkurl="";
				 if(product!=null){
					 linkurl="/wap/goodsdetail.jsp?productid="+product.getId();
				 } %>
				<tr style="border-collapse: collapse;">

					<td align="left" style="padding-left: 4px"><input
						type="hidden" name="productid"
						value="<%=item.getOdrdtl_gdsid() %>" /> <input type="hidden"
						name="productname" value="<%=item.getOdrdtl_gdsname() %>" /> <a
						href='<%=linkurl %>'><%=item.getOdrdtl_gdsname()%></a></td>

				</tr>

				<tr>
					<td>
						<div style="padding-left: 4px; margin-left: 0px; float: left">

							<input name="markValue<%=i%>" type="hidden" value="5" />
							<div id="mark"
								style="padding-left: 0px; margin-left: 0px; float: left">

								<input type="radio" value="5" name="rlevel<%=i%>"
									onclick="check<%=i%>(5)">5星</input> <input type="radio"
									value="4" name="rlevel<%=i%>" onclick="check<%=i%>(4)">4星</input>
								<input type="radio" value="3" name="rlevel<%=i%>"
									onclick="check<%=i%>(3)">3星</input> <input type="radio"
									value="2" name="rlevel<%=i%>" onclick="check<%=i%>(2)">2星</input>
								<input type="radio" value="1" name="rlevel<%=i%>"
									onclick="check<%=i%>(1)">1星</input>

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="padding-left: 4px">请输入评论内容（100字以内）：</td>
				</tr>
				<tr>
					<td style="padding-left: 4px"><textarea class="txtcontent"
							name="tcontent" id="tcomment<%=i %>"
							onkeydown='if (this.value.length>=100){event.returnValue=false}'
							onkeyup="keypress<%=i%>(this.value)"></textarea> <br /> <span
						id="content<%=i%>" style="color: red"></span></td>
				</tr>

				<script type="text/javascript">
              function check<%=i%>(v)
              {
            	  $("input[name='markValue<%=i%>']").val(v);
            	  
              }
            	  function keypress<%=i%>(text1) //textarea输入长度处理
					    {
					        var len; //记录剩余字符串的长度
					        if (text1.length >=100)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了
					        {
					            $.alert("超过字数限制，请您精简部分文字!");
					            text1 = text1.substr(0, 100);
					            len = 0;
					        }
					        else {
					            len = 100 - text1.length;
					        }
					        var show = "你还可以输入" + len + "个字";
					        document.getElementById("content<%=i%>").innerHTML=show;
					    }
		      
		    </script>

				<%  
           i++;
				 }%>
				<tr>
					<td align="center"><input type="button" onclick="add();"
						value="提交"></input></td>
				</tr>
			</table>

			<%}else{
    			  Tools.outJs(out, "该订单不存在", "back");
    	    	  return;
    		  }
    	  
    		 }
      }else{
    	  Tools.outJs(out, "参数错误", "back");
    	  return;
      }
     %>
		</form>
	</div>


	<div class="clear"></div>
	<%@ include file="../inc/userfoot.jsp"%>

</body>
</html>