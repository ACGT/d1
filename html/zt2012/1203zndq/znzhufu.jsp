<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
//判断该用户今天是否发表过祝福
static ArrayList<ZhuFu> zhufulist(){
	ArrayList<ZhuFu> list=new ArrayList<ZhuFu>();
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("znzhufu_createdate"));
	List<BaseEntity> b_list=Tools.getManager(ZhuFu.class).getList(null, olist, 0, 100);
	if(b_list==null||b_list.size()==0)return null;
	for(BaseEntity be:b_list){
		list.add((ZhuFu)be);
	}
	return list ;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>优尚网9年成长史，快来送上你的祝福语吧！-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css">
.scrollDiv{padding-left:120px; padding-bottom:10px; padding-right:120px;width:740px;height:160px;line-height:21px;overflow:hidden}
ul li{ list-style-type:none;color:#4A4934; text-align:left;}
</style>
<script type="text/javascript">
function AutoScroll(obj){
	$(obj).find("ul:first").animate({
	marginTop:"-20px"
	},200,function(){
	$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
	});
	}
	$(document).ready(function(){
		setInterval('AutoScroll("#scrollDiv")',3000)
	});
	
	function checklen(text1){
	        if (text1.length > 140)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了
	        {
	            $.alert("超过字数限制，请您精简部分文字!");
	            $("#zfcontent").text(text1.substr(0, 140));
	        }
	}
	function addzf1(){
		$.alert("该活动已结束");
	}
	function addzf(){
		var zfcontent=$.trim($("#zfcontent").val())
		
		if(zfcontent.length==0){
			$.alert("请填写祝福内容!");
			//return false;
		}
		else if(zfcontent.length>140){
			$.alert("超过字数限制，请您精简部分文字!");
			//return false;
		}else{
			 $.ajax({
                 type: "post",
                 dataType: "text",
                 contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                 url: "function.jsp",
                 cache: false,
                 data:{
                	 zf: "1",
                	 zfcontent: zfcontent
     		      },error: function(XmlHttpRequest, textStatus, errorThrown){
                   //  $.alert('修改信息失败！');
                 },success: function(msg){
                 	//alert(msg);
                 	 if(msg==2){
                 		$.alert("您今天已发表过祝福，请明天再来");
                 	 }
                 	 else if(msg==1){
                 		$.alert("发表成功！");
                 		setInterval("settime()",1000);
                 	 }
                 }
                 }
         	)
		}
	}
	 var i=3;
	    function settime()
	    {
	       i--;
	      
	       if(i<=0)
	       {
	    	   window.location.reload(true);
	       }
	    }
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_01.jpg" width="765" height="195" alt=""/></td>
		<td colspan="2">
			<a href="znwin.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/fkdzy/czzf_02.jpg" alt="" width="215" height="195" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_03.jpg" width="980" height="71" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_04.jpg" width="980" height="75" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
		<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_05.jpg" width="980" height="79" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_06.jpg" width="980" height="79" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_07.jpg" width="980" height="102" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_08.jpg" width="980" height="87" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5"><a name="add"></a>
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_09.jpg" width="980" height="80" alt=""/></td>
	</tr>
	<tr>
	<td colspan="5" style=" background: url(http://images.d1.com.cn/images2012/fkdzy/czzf_10.jpg) no-repeat left top;"   width="980" height="192" valign="top">
			<div id="scrollDiv" class="scrollDiv">
			<%
			ArrayList<ZhuFu> list= zhufulist();
			if(list!=null && list.size()>0){
				%>  <ul>
			<%
			for(ZhuFu zf:list){
				String mbruid=zf.getZnzhufu_mbruid();
				if(mbruid.length()>8){
					mbruid=mbruid.substring(0,8)+"***";
				}
				
				String zfcontent=mbruid+":"+zf.getZnzhufu_content();
				if(StringUtils.getCnLength(zfcontent)>120){
					//zfcontent=StringUtils. getCnSubstring(zfcontent,0, 120)+"...";
				}
				%> 	
				<li><%=zfcontent %></li>
			<%}%>
			 </ul>
			<%}
			%>
			</div>
	</td>
	</tr>	
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_11.jpg" width="329" height="154" alt=""/></td>
		<td colspan="2" rowspan="3" style=" background: url(http://images.d1.com.cn/images2012/fkdzy/czzf_12.jpg) no-repeat left top;" width="461" height="209" valign="top">
			<div style="padding-left:15px; padding-bottom:10px; padding-right:10px; padding-top:85px;">
			<textarea id="zfcontent" cols="48" rows="3" style=" width:420px; height:80px;"  onkeydown='if (this.value.length>=140){event.returnValue=false}' onkeyup="checklen(this.value)"></textarea>
			</div>
		</td>
		<td rowspan="3" style=" background: url(http://images.d1.com.cn/images2012/fkdzy/czzf_13.jpg) no-repeat left top;" width="109" height="209" valign="top">
			<div style="padding-left:15px; padding-bottom:10px; padding-right:10px; padding-top:105px;">
			<a href="javascript:addzf1();"><div style="height:50px; width:90px;" onmouseover="this.style.cursor='hand'"></div></a>
			</div>
			</td>
		</tr>
	<tr>
		<td width="131" height="26" valign="top" style="font-size:0px;">
		<a href="znwin.jsp" target="_blank">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_14.jpg" width="131" height="26" alt="" border="0"/>
			</a>
			</td>
		
		<td width="198" height="26" valign="top" style="font-size:0px;">
		<a href="http://www.d1.com.cn/jifen/index.jsp#tj" target="_blank">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_15.jpg" width="198" height="26" alt="" border="0"/>
		</a>
			</td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_16.jpg" width="329" height="29" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_17.jpg" width="980" height="23" alt=""/></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/images2012/fkdzy/czzf_18.jpg" width="980" height="304" alt=""/></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="131" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="198" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="436" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="25" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/fkdzy/分隔符.gif" width="190" height="1" alt=""/></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>