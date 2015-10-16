<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>测试没有sku加入购物车-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function CheckForm(obj){
	var checkgds = $('#tblList input[type=checkbox]:checked');
	var iSelectCnt = checkgds.length;
    if (iSelectCnt == 0){
    	$.alert('请选择商品!');
        return;
    }
    var iMaxCount = -1;
    var strMaxCount = $('#hdnMaxCount').val();
    if (strMaxCount != null && strMaxCount.length > 0){
    	iMaxCount = parseInt(strMaxCount, 10);
    }
    if (iMaxCount != -1){
    	if (iSelectCnt != iMaxCount){
    		$.alert('请选择' + iMaxCount + '件商品!');
            return;
        }
    }
    var arr = new Array();
    checkgds.each(function(i){
    	arr[i] = $(this).val();
    });
    $('#btnAddToCart').attr('attr',arr.toString());
    $.inCart1(obj,{ajaxUrl:'/html/zt2012/20120727polo/xsyListInCart.jsp',width:600,align:'center'},{'code':$(obj).attr("code")});
}

</script>
<style type="text/css">
   .newpoloul{ padding:0px; margin:0px;}
   .newpoloul li{ float:left; margin-right:5px; margin-bottom:10px;}

</style>
</head>
商品编号是：01721266<br/>
<a href="javascript:void(0)" onclick="addCart('01721266','')" attr="01721266">加入购物车(缺少sku)</a>

<br/>
商品编号是：03000183<br/>
<a href="javascript:void(0)" onclick="addCart('03000183','')" attr="03000183">加入购物车(缺少sku)</a>
<br/>
编号：01721266<br/>
<a href="javascript:void(0)" onclick="addCart('01721266','30149')" attr="01721266" >加入购物车(存在sku)</a>
<br/>
编号：01411693<br/>
<a href="javascript:void(0)" onclick="addCart('01411693','')" attr="01411693">加入购物车(正常商品)</a>

</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>

<script type="text/javascript">


//放入购物车操作
function addCart(param,skuid){	
	var id=$(this).attr("attr");
	alert(skuid);
	$.ajax({
		type: "get",
		dataType: "json",
		url: 'AddCart.jsp',
		cache: false,
		data: {id:param,skuid:skuid},
		error: function(XmlHttpRequest){
			alert("加入购物车出错，请稍后重试或者联系客服处理！");
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