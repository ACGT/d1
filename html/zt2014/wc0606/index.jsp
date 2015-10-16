<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>世界杯竞猜</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function addcart(obj){
	var cid=$(obj).attr("attr");
	var gdsid=$(obj).attr("code");
	var code=$('#cartno'+gdsid).val();
	  if (code == ""){
			$.alert('请填写兑换码!');
	        return;
	    }

  $.inCart(obj,{ajaxUrl:'dhInCart.jsp?id='+code+'&gdsid='+gdsid+'&cid='+cid+'',width:400,align:'center'});
}
</script>
		</head>
<style type="text/css">
.bannerbody {
background-image: url(http://images.d1.com.cn/zt2014/06/dh/header.jpg);
background-repeat: no-repeat;
background-position: center;
height: 520px;
}
.dhtitle{font-size:28px; font-family:微软雅黑;color:#fff; text-align:center;}
</style>
</style>

<body>
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="bannerbody">
</div>
<%
Map<String,String> map=new HashMap<String,String>();
String gdsid1="";
float gdsp1=0f;
String gdstitle1="";
String gdspic1="";
String gdsid2="";
float gdsp2=0f;
String gdspic2="";
String gdstitle2="";
ArrayList<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode("9358", 5);
if(pplist!=null){
	gdsid1=pplist.get(0).getSpgdsrcm_gdsid();
	gdsp1=pplist.get(0).getSpgdsrcm_tjprice().floatValue();
	Product p=ProductHelper.getById(gdsid1);
	gdstitle1=p.getGdsmst_gdsname();
	gdspic1=p.getGdsmst_img310();
			if(!Tools.isNull(gdspic1)){
		if(gdspic1.startsWith("/shopimg/")){
			gdspic1 = "http://images1.d1.com.cn"+gdspic1.trim();
		}else{
			gdspic1 = "http://images.d1.com.cn"+gdspic1.trim();
		}
		}else{
			gdspic1=ProductHelper.getImageTo400(p);
		}
	if(pplist.size()>1&&pplist.get(1)!=null){
		gdsid2=pplist.get(1).getSpgdsrcm_gdsid();
		gdsp2=pplist.get(1).getSpgdsrcm_tjprice().floatValue();
		p=ProductHelper.getById(gdsid2);
		gdstitle2=p.getGdsmst_gdsname();
		gdspic2=p.getGdsmst_img310();
		if(!Tools.isNull(gdspic2)){
	if(gdspic2.startsWith("/shopimg/")){
		gdspic2 = "http://images1.d1.com.cn"+gdspic2.trim();
	}else{
		gdspic2 = "http://images.d1.com.cn"+gdspic2.trim();
	}
	}else{
		gdspic2=ProductHelper.getImageTo400(p);
	}
	}
}

  
  String gdsid3="";
  float gdsp3=0f;
  String gdstitle3="";
  String gdspic3="";
  String gdsid4="";
  float gdsp4=0f;
  String gdspic4="";
  String gdstitle4="";
  ArrayList<PromotionProduct> pplist2=PromotionProductHelper.getPProductByCode("9359", 5);
  if(pplist!=null){
  	gdsid3=pplist2.get(0).getSpgdsrcm_gdsid();
  	gdsp3=pplist2.get(0).getSpgdsrcm_tjprice().floatValue();
  	Product p=ProductHelper.getById(gdsid3);
  	gdstitle3=p.getGdsmst_gdsname();
  	gdspic3=p.getGdsmst_img310();
  			if(!Tools.isNull(gdspic3)){
  		if(gdspic3.startsWith("/shopimg/")){
  			gdspic3 = "http://images1.d1.com.cn"+gdspic3.trim();
  		}else{
  			gdspic3 = "http://images.d1.com.cn"+gdspic3.trim();
  		}
  		}else{
  			gdspic3=ProductHelper.getImageTo400(p);
  		}
  	if(pplist2.size()>1&&pplist2.get(1)!=null){
  		gdsid4=pplist2.get(1).getSpgdsrcm_gdsid();
  		gdsp4=pplist2.get(0).getSpgdsrcm_tjprice().floatValue();
  		p=ProductHelper.getById(gdsid4);
  		gdstitle4=p.getGdsmst_gdsname();
  		gdspic4=p.getGdsmst_img310();
  		if(!Tools.isNull(gdspic4)){
  	if(gdspic4.startsWith("/shopimg/")){
  		gdspic4 = "http://images1.d1.com.cn"+gdspic4.trim();
  	}else{
  		gdspic4 = "http://images.d1.com.cn"+gdspic4.trim();
  	}
  	}else{
  		gdspic4=ProductHelper.getImageTo400(p);
  	}
  	}
  }
  %>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="http://images.d1.com.cn/zt2014/06/dh/01-2.jpg" width="980" height="58" /></td>
  </tr>
  <tr>
    <td height="520" background="http://images.d1.com.cn/zt2014/06/dh/bg.jpg"><table width="980" border="0" height="203" cellspacing="0" cellpadding="0">
      <tr>
        <td width="116" height="15">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td width="117">&nbsp;</td>
      </tr>
      <tr>
        <td height="480">&nbsp;</td>
        <td width="360">
        <table width="100%" border="0"  height="480" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="50"></td>
            <td colspan="2" class="dhtitle"><%=gdsp1 %>元兑换</td>
            <td width="2%"></td>
          </tr>
          <tr>
            <td height="300">&nbsp;</td>
            <td colspan="2" align="center">
            <a href="http://www.d1.com.cn/product/<%=gdsid1 %>" target="_blank" title="<%=gdstitle1%>">
            <img src="<%=gdspic1 %>" width="310" height="310" border="0" /></a></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td rowspan="2">&nbsp;</td>
            <td height="40" colspan="2"><a href="http://www.d1.com.cn/product/<%=gdsid1 %>" target="_blank" title="<%=gdstitle1%>"><%=gdstitle1%></a></td>
            <td rowspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td width="67%"><input type="text" name="cartno<%=gdsid1 %>" id="cartno<%=gdsid1 %>" style="height:35px;width:240px;" /></td>
            <td width="28%"><a href="javascript:void(0)" attr="1" code="<%=gdsid1 %>" onclick="addcart(this)" ><img src="http://images.d1.com.cn/zt2014/06/dh/button.jpg" width="78" height="78" /></a></td>
          </tr>
        </table></td>
        <td width="29">&nbsp;</td>
        <td width="358"><table width="100%" border="0"  height="480" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="50"></td>
            <td colspan="2" class="dhtitle"><%=gdsp2 %>元兑换</td>
            <td width="2%"></td>
          </tr>
          <tr>
            <td height="300">&nbsp;</td>
            <td colspan="2" align="center">
            <a href="http://www.d1.com.cn/product/<%=gdsid2 %>" target="_blank" title="<%=gdstitle2%>">
            <img src="<%=gdspic2 %>" width="310" height="310" border="0" /></a></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td rowspan="2">&nbsp;</td>
            <td height="40" colspan="2"><a href="http://www.d1.com.cn/product/<%=gdsid2 %>" target="_blank" title="<%=gdstitle2%>"><%=gdstitle2%></a></td>
            <td rowspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td width="67%"><input type="text" name="cartno<%=gdsid2 %>" id="cartno<%=gdsid2 %>" style="height:35px;width:240px;" /></td>
            <td width="28%"><a href="javascript:void(0)" attr="1" code="<%=gdsid2 %>" onclick="addcart(this)" ><img src="http://images.d1.com.cn/zt2014/06/dh/button.jpg" width="78" height="78" /></a></td>
          </tr>
        </table></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="15">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2014/06/dh/02-2.jpg" width="980" height="58" /></td>
  </tr>
  <tr>
    <td height="520" background="http://images.d1.com.cn/zt2014/06/dh/bg.jpg"><table width="980" border="0" height="203" cellspacing="0" cellpadding="0">
      <tr>
        <td width="116" height="15">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td width="117">&nbsp;</td>
      </tr>
      <tr>
        <td height="480">&nbsp;</td>
        <td width="360"><table width="100%" border="0"  height="480" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="50"></td>
            <td colspan="2" class="dhtitle"><%=gdsp3 %>元兑换</td>
            <td width="2%"></td>
          </tr>
          <tr>
            <td height="300">&nbsp;</td>
            <td colspan="2" align="center">
            <a href="http://www.d1.com.cn/product/<%=gdsid3 %>" target="_blank" title="<%=gdstitle3%>">
            <img src="<%=gdspic3 %>" width="310" height="310" border="0" /></a></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td rowspan="2">&nbsp;</td>
            <td height="40" colspan="2"><a href="http://www.d1.com.cn/product/<%=gdsid3 %>" target="_blank" title="<%=gdstitle3%>"><%=gdstitle3%></a></td>
            <td rowspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td width="67%"><input type="text" name="cartno<%=gdsid3 %>" id="cartno<%=gdsid3 %>" style="height:35px;width:240px;" /></td>
            <td width="28%"><a href="javascript:void(0)" attr="2" code="<%=gdsid3 %>" onclick="addcart(this)" ><img src="http://images.d1.com.cn/zt2014/06/dh/button.jpg" width="78" height="78" /></a></td>
          </tr>
        </table></td>
        <td width="29">&nbsp;</td>
        <td width="358"><table width="100%" border="0"  height="480" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="50"></td>
            <td colspan="2" class="dhtitle"><%=gdsp4 %>元兑换</td>
            <td width="2%"></td>
          </tr>
          <tr>
            <td height="300">&nbsp;</td>
            <td colspan="2" align="center">
            <a href="http://www.d1.com.cn/product/<%=gdsid4 %>" target="_blank" title="<%=gdstitle4%>">
            <img src="<%=gdspic4 %>" width="310" height="310" border="0" /></a></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td rowspan="2">&nbsp;</td>
            <td height="40" colspan="2"><a href="http://www.d1.com.cn/product/<%=gdsid4 %>" target="_blank" title="<%=gdstitle4%>"><%=gdstitle4%></a></td>
            <td rowspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td width="67%"><input type="text" name="cartno<%=gdsid4 %>" id="cartno<%=gdsid4 %>" style="height:35px;width:240px;" /></td>
            <td width="28%"><a href="javascript:void(0)" attr="2" code="<%=gdsid4 %>" onclick="addcart(this)" ><img src="http://images.d1.com.cn/zt2014/06/dh/button.jpg" width="78" height="78" /></a></td>
          </tr>
        </table></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="15">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@include file="/inc/foot.jsp" %>
</body>
</html>

