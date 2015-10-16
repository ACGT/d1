<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%
String odrid=request.getParameter("odrid");
String gdsid=request.getParameter("gdsid");
String odtlid=request.getParameter("odtlid");
if(!Tools.isNull(request.getHeader("referer")) && request.getHeader("referer").indexOf("weibo.com")>=0 ){
	response.sendRedirect("http://www.d1.com.cn/product/"+gdsid);
	return;
}
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%><%@include file="myshow.jsp"%><%@include file="/inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-分享晒单</title>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/showorder.css")%>" rel="stylesheet" type="text/css"/>

</head>

<body>
<%@include file="/inc/head.jsp" %>
<div class="center">
<%

if(Tools.isNull(gdsid) || Tools.isNull(odrid) || Tools.isNull(odtlid)){
	 Tools.outJs(out,"参数错误！","back");
		return; 
}
Product p=ProductHelper.getById(gdsid);
if(p==null){
	 Tools.outJs(out,"参数错误！","back");
		return; 
}
ArrayList<MyShow> showlist=ShowOrderHelper.getMyShowDetail(gdsid, odrid,odtlid);
if(showlist!=null && showlist.size()>0){
	String img="";
	MyShow show=showlist.get(0);
	img="http://images1.d1.com.cn"+show.getMyshow_img400500();
	if(show.getMyshow_img400500().indexOf("/uploads/sd/")>=0){
		img="http://d1.com.cn"+show.getMyshow_img400500();
	}
	 String fxcontent="我在@D1优尚官网  买了"+Tools.clearHTML(p.getGdsmst_gdsname())+"。说说我的感受："+show.getMyshow_content()+" 分享一下: ";
	%>
	<table border="0" cellspacing="0" cellpadding="0">
	 <tr> <td colspan="3" style="height:20px;">&nbsp;</td></tr>
  <tr>
    <td colspan="3" align="center" valign="middle" >
    <img src="<%=img %>" alt="" />
    </td>
  </tr>
  <tr> <td colspan="3" style="height:20px;">&nbsp;</td></tr>
   <tr>
    <td  align="center" valign="middle" >
    分享内容：
    </td>
    <td><textarea name="txtCustomerMemo" id="txtCustomerMemo"  rows="3" cols="75" style="font-size:14px;"><%=fxcontent %></textarea></td>
  </tr>
  <tr> <td colspan="3" style="height:20px;">&nbsp;</td></tr>
  <tr>
    <td colspan="3"  align="center" valign="middle"> <a id="asina" href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','<%=img %>',$('#txtCustomerMemo').val(),'http://www.d1.com.cn/ShowOrder/fx.jsp?gdsid=<%=gdsid %>','utf-8'));"><img src="http://images.d1.com.cn/wap/fx_sina.jpg"></img></a><img src="http://images.d1.com.cn/wap/yfx_sina.jpg" style="display:none;" id="sina"></img>&nbsp;&nbsp;&nbsp;&nbsp;
      
   <a id="asohu" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','<%=img %>',$('#txtCustomerMemo').val(),'http://www.d1.com.cn/product/<%=p.getId() %>','utf-8'));"><img src="http://images.d1.com.cn/wap/fx_sohu.jpg"></img></a><img src="http://images.d1.com.cn/wap/yfx_sohu.jpg" style="display:none;" id="sohu"></img>&nbsp;&nbsp;&nbsp;&nbsp;
      
   
      <a id="atx" href="javascript:postToWb();" ><img src="http://images.d1.com.cn/wap/fx_tengxun.jpg"></img></a><img src="http://images.d1.com.cn/wap/yfx_tengxun.jpg" style="display:none;" id="tx"></img>
       
   </td>
  </tr>
  <tr> <td colspan="3" style="height:20px;">&nbsp;</td></tr>
</table>
<script type="text/javascript">
function postToWb(){
	// alert(j);
     var _t = encodeURI(document.title);
     _t=encodeURI($('#txtCustomerMemo').val().replace("@D1优尚官网","@D1优尚网"));
     var _url = encodeURIComponent('http://www.d1.com.cn/product/<%=p.getId()%>');
     var _appkey = encodeURI("7d55b7e157054243b4a6bd7a826cbc40");//你从腾讯获得的appkey
     var _pic = encodeURI('<%=img%>');//（例如：var _pic='图片url1|图片url2|图片url3....）
     var _site = 'http://www.d1.com.cn/product/<%=p.getId()%>';//你的网站地址
     var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
     window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
 }
</script>
<%}
%>

</div>

<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>

</body>
</html>