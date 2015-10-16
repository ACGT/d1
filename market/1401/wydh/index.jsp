<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%Tools.setCookie(response,"rcmdusr_rcmid","110",(int)(Tools.DAY_MILLIS/1000*1)); %><%!
public static String Getp2013img(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 20);
	if(list!=null&&list.size()>0)
	{
		for(Promotion p:list)
		{
			if(p!=null)
			{
				
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" />");
				sb.append("</a>");
				
			}
		}
	}
	return sb.toString();
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网易抽奖-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="http://mimg.127.net/xm/all/point_club/110622/css/style.css"		rel="stylesheet" type="text/css"/>
<link href="http://mimg.127.net/xm/all/point_club/progress/medaltalent/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<style>
.cardnotxt {
height: 27px;
_height: 24px;
width: 200px;
border: 2px ridge #CC0000;
vertical-align: middle;
background: #FFE7E7;
font-size: 16px;
}
</style>
<script type="text/javascript">
function chooseg(t,gid){ 
	var i=1; 
	t.disabled=true; 
	CheckForm(t,gid);
	var timer=setInterval(function(){i++;
	if(i>2){t.disabled=false;i=1;t.value="test";clearInterval(timer)}},1000) 
	} 
function CheckForm(obj,gid){
	var code="";
	if(gid==1){
	 code=$('#cardno').val();
	}else{
		code=$('#cardno2').val();
	}
	  if (code == ""){
			$.alert('请填写兑换码!');
	        return;
	    }
    $.inCart(obj,{ajaxUrl:'dhInCard.jsp?id='+code+'&gid='+gid+'',width:400,align:'center'});
}
</script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<center>
<style type="text/css">
.cardno {
	border: 1px solid #cb0516;
	background-color: #ffe7e7;
	height:25px;
}
</style>
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="http://images.d1.com.cn/zt2013/1231/free163_01.jpg" border="0"></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2013/1231/free163_02.jpg" border="0"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="http://www.d1.com.cn/product/01205404" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_03_01.jpg" width="293" height="330" border="0" /></a></td>
        <td width="198" valign="top" background="http://images.d1.com.cn/zt2013/1231/free163_03_02.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="42%">&nbsp;</td>
            <td width="58%">&nbsp;</td>
          </tr>
          <tr>
            <td height="150">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="34" colspan="2">请输入兑换码</td>
            </tr>
          <tr>
            <td height="46" colspan="2"><input name="cardno" type="text" class="cardno" id="cardno" /></td>
            </tr>
          <tr>
            <td height="47">&nbsp;</td>
            <td><input type="image" name="imageField" id="imageField" src="http://images.d1.com.cn/zt2013/1231/dhbut.jpg" onclick="chooseg(this,1);" /></td>
          </tr>
        </table></td>
        <td><a href="http://www.d1.com.cn/product/01205399" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_04_01.jpg" width="285" height="330" border="0" /></a></td>
        <td width="204" valign="top" background="http://images.d1.com.cn/zt2013/1231/free163_04_02.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="42%">&nbsp;</td>
            <td width="58%">&nbsp;</td>
          </tr>
          <tr>
            <td height="150">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="34" colspan="2">请输入兑换码</td>
          </tr>
          <tr>
            <td height="46" colspan="2"><input name="cardno2" type="text" class="cardno" id="cardno2" /></td>
          </tr>
          <tr>
            <td height="47">&nbsp;</td>
            <td><input type="image" name="imageField2" id="imageField2" src="http://images.d1.com.cn/zt2013/1231/dhbut.jpg" onclick="chooseg(this,2);" /></td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2013/1231/free163_05.jpg" border="0"></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/product/01205397" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_06.jpg" border="0"></a><a href="http://www.d1.com.cn/product/01205396" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_07.jpg" border="0"></a><a href="http://www.d1.com.cn/product/03300070" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_08.jpg" border="0"></a></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/product/01205375" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_09.jpg" border="0"></a><a href="http://www.d1.com.cn/product/01517877" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_10.jpg" border="0"></a><a href="http://www.d1.com.cn/product/03001350" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_11.jpg" border="0"></a></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/product/03100504" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_12.jpg" border="0"></a><a href="http://www.d1.com.cn/product/02007522" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_13.jpg" border="0"></a><a href="http://www.d1.com.cn/product/01515468" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_14.jpg" border="0"></a></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2013/1231/free163_15.jpg" border="0"></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/zhuanti/201312/snm1210/" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_16.jpg" border="0"></a><a href="http://www.d1.com.cn/zhuanti/201312/nz1206/" target="_blank"><img src="http://images.d1.com.cn/zt2013/1231/free163_17.jpg" border="0"></a></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2013/1231/free163_18.jpg" border="0"></td>
  </tr>
</table>

</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
