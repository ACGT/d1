<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户反馈 - D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/feedback.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#username").focus()
	//页面中的DOM已经装载完成时，执行的代码
	
	$(".hmain").click(function(){
		$("#span1").hide();
		$("#span2").hide();
		$("#span3").hide();
		$("#span4").hide();
		$("#d1").show();
		//$(this).children("ul").slideDown();
	},function(){
		$(this).children("ul").slideUp();
	});
	$(".limain").hover(function(){
		$(this).css("background-color","#E6B9B8");
	},function(){
		$(this).css("background-color","white");
	});
	$(".limain").click(function(){
		var type=$(this).children("span").text();
		$("#stype").text("["+type+"]");
		$("#htype").val($(this).children("input").val());
		$('input[type="radio"][value="4"]').attr("checked","checked");
		//var a=$(this).children("input").val();
		//alert(a);
	});
	$("input[type='radio']").click(function(){
		var type=$(":radio[name='radio']:checked").val(); 
		if(type!=4){
			$("#stype").text("");
			$("#htype").val(type);

		}else{
			if($("#htype").val()<4 || $("#htype").val()>9){
				$("#htype").val(type);
			}
		}
	});
});


function isorder(orderid){
	 if (typeof(orderid) == 'undefined'){
		 orderid = $.trim($('#txtorderid').val());
	    }
	var patrn=/^\d{12}$/;  
	if(orderid.length>0){
		if (!patrn.exec(orderid)) {
			$("#sorder").show();
			$("#sorder").css("color","red");
			$("#sorder").text("*订单号为12位数字");
			$("#imgorderid").hide();
			return false;
		}
		else{
			$("#sorder").hide();
			$("#imgorderid").show();
			return true;
		}
	}else {
		$("#sorder").show();
		$("#sorder").text("订单号12位数；如已生成订单，务必提供");
		$("#sorder").css("color","#4B4B4B");
		$("#imgorderid").hide();
	}return true;
}

function isuid(uid){
	//alert(uid.length);
	if (typeof(uid) == 'undefined' || uid.length==0){
		if(typeof($('#txtusername').val()) == 'undefined'){
			uid = $.trim($('#huid').val());
		}else{
			uid = $.trim($('#txtusername').val());
			$("#huid").val(uid);
		}
	    }
	
	if(uid.length==0){
		$("#suid").css("color","red");
		$("#suid").text("用户名/Email不能为空！");
		$("#imguid").hide();
		$("#hcheck").val(0);
		return false;
	}else{
		
		$.ajax({
			type: "POST",
			url: "isemailused.jsp",
			data:"useremail="+uid, 
			//contentType: "application/json; charset=utf-8",
			success: function(msg) {
				if(msg==0){
					$("#suid").show();
					$("#suid").css("color","red");
					$("#suid").text("此用户名/Email不存在！");
					$("#imguid").hide();
					$("#hcheck").val(2);
					return false;
				}else{
					//alert($("#huid").val());
					$("#suid").hide();
					$("#imguid").show();
					$("#hcheck").val(1);
					return true;
				}
			},
			error: function(xhr,msg,e) {
				return false;
			}
			});
	}
	
}
function istel(tel){
	  if (typeof(tel) == 'undefined'){
		  tel = $.trim($('#txttele').val());
	    }
if(tel.length==0){
	$("#stel").show();
	$("#stel").css("color","red");
	$("#stel").text("*联系电话不能为空！");
	$("#imgtel").hide();
	return false;
	}
	//var patrn=/^(\d{3}\-\d{8})|(\d{4}\-\d{7})|([1]\d{10})$/;  
	var patrn1=/^(\d{3}\-\d{8})$/;  
	var patrn2=/^(\d{4}\-\d{7})$/;  
	var patrn3=/^[1]\d{10}$/;  
	if ((!patrn1.exec(tel)) && (!patrn2.exec(tel)) && (!patrn3.exec(tel))) {
		$("#stel").show();
		$("#stel").css("color","red");
		$("#stel").text("*联系电话输入不正确");
		$("#imgtel").hide();
		return false;
	}
	else{
		$("#stel").hide();
		$("#imgtel").show();
		return true;
	}
}

function isemail(email){
	 if (typeof(email) == 'undefined'){
		 email = $.trim($('#txtemail').val());
	    }
	var patrn=/^\S+@\S+\.\S+$/;  
	if(email.length==0){
		$("#smail").show();
		$("#smail").css("color","red");
		$("#smail").text("*邮箱地址不能为空");
		$("#imgemail").hide();
		return false;
	}
	if (!patrn.exec(email)) {
		$("#smail").show();
		$("#smail").css("color","red");
		$("#smail").text("*邮箱格式不正确");
		$("#imgemail").hide();
		return false;
	}
	else{
		$("#smail").hide();
		$("#imgemail").show();
		return true;
	}
}

function contentnum(text1) //textarea输入长度处理
{
    var len; //记录剩余字符串的长度
    if (text1.value.length >=1000)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了
    {
    	$.alert("超过字数限制，请您精简部分文字!");
        text1.value = text1.value.substr(0, 1000);
    }
    //len =  text1.value.length;

    //$("#snum").text(len);
  
}
function iscontent(content){
	if(content.trim().length==0){
		$("#scontent").show();
		return false;
	}else{
		$("#scontent").hide();
		return true;
	}
}
function op(){

	$("#t1").show();
	var text= $.trim($("#f1").val());
	if(text.length==0){
		$("#a1").hide();
	}else{
		$("#a1").show();
		$("#t6").show();

	}
}
function op1(){

	$("#t2").show();
	var text= $.trim($("#f2").val());
	if(text.length==0){
		$("#a2").hide();
	}else{
		$("#a2").show();
		$("#a1").hide();

	}
}
function op2(){

	$("#t3").show();
	var text= $.trim($("#f3").val());
	if(text.length==0){
		$("#a3").hide();
	}else{
		$("#a3").show();
		$("#a2").hide();

	}
}
function op3(){
	$("#t4").show();
	var text= $.trim($("#f4").val());
	if(text.length==0){
		$("#a4").hide();
	}else{
		$("#a4").show();
		$("#a3").hide();

	}
}
function op4(){

	$("#t5").show();
	var text= $.trim($("#f5").val());
	if(text.length==0){
		$("#a5").hide();
	}else{
		$("#a5").show();
		$("#a4").hide();
	}
}
function ok(){
	if(confirm("确定要上传吗？")){
		$("#submit1").click();
	}
	
}
function remark1(){
	$("#span1").show();
	$("#span2").hide();
	$("#span3").hide();
	$("#span4").hide();
	$("#d1").hide();
}
function remark2(){
	$("#span1").hide();
	$("#span2").show();
	$("#span3").hide();
	$("#span4").hide();
	$("#d1").hide();
}
function remark3(){
	$("#span1").hide();
	$("#span2").hide();
	$("#span3").show();
	$("#span4").hide();
	$("#d1").hide();
}
function remark4(){
	$("#span1").hide();
	$("#span2").hide();
	$("#span3").hide();
	$("#span4").show();
	$("#d1").hide();
}

//建立一个类
var Upload = {


//类方法,清除一个上传控件的内容
clear: function(id) {

        //如果传过来的参数是字符,则取id为该字符的元素,如果无此元素,则返回空
        var up = (typeof id == "string") ? document.getElementById(id) : id;
        if (typeof up != "object") return null;
        
        //创建一个span元素
        var tt = document.createElement("span");
        //添加id,以便后面使用
        tt.id = "__tt__";
        up.parentNode.insertBefore(tt, up);
        
        //创建一个form
        var tf = document.createElement("form");
        //将上传控件追加为form的子元素
        tf.appendChild(up);
        
        //将form加入到body
        document.getElementsByTagName("body")[0].appendChild(tf);
        
        //利用重置来清空上传控件内容
        tf.reset();
        
        //所上传控件放回原来的位置
        tt.parentNode.insertBefore(up, tt);
        
        //除上面创建的这个span
        tt.parentNode.removeChild(tt);
        tt = null;
        
        //移除上面临时创建的form
        tf.parentNode.removeChild(tf);
    },
    
    //类方法,清除多个上传控件的内容
    clearForm: function() {
    var inputs, frm;
        
        //如果没有参数传递过来,则获取所有inpur类型的控件
        if (arguments.length == 0) {
            inputs = document.getElementsByTagName("input");
        } 
        //如果有参数传递过来
        else {
            //如果传一个ID过来,则取得该ID的元素,否则直接使用该元素
            frm = (typeof arguments[0] == "string") ? document.getElementById(arguments[0]) : arguments[0];
            
            //如果不是一个object对象,返回null
            if (typeof frm != "object") return null;
            
            //如果传递的是一个object对象,取得这个对象内所有的input类型的元素
            inputs = frm.getElementsByTagName("input");
        }
        
        //遍历所有获取的元素,如果是上传控件类型,则加入到一个数组的末尾.
        var fs = [];
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type == "file") fs[fs.length] = inputs[i];
        }


        //创建一个form元素
        var tf = document.createElement("form");
        for (var i = 0; i < fs.length; i++) {
        
            //每个上传控件前创建一个span元素,用来标记它的位置,而span不会影响它的样式
            var tt = document.createElement("span");
            //为每个span加一个id,以便后面将上传控件放回原来位置
            tt.id = "__tt__" + i;
            
            //将这个span元素作为组中的每一个上传控件的兄弟元素插入到每一个上传控件之前
            fs[i].parentNode.insertBefore(tt, fs[i]);
            
            //将这个上传控件追加到新创建的form中
            tf.appendChild(fs[i]);
        }
        
        //将新创建的form追加到页面body中
        document.getElementsByTagName("body")[0].appendChild(tf);
        
        //重置form,以便清空各上传控件的值.(利用重置来清空内容)
        tf.reset();
        
        //将各个上传控件重新放回到原来的位置
        for (var i = 0; i < fs.length; i++) {
            var tt = document.getElementById("__tt__" + i);
            tt.parentNode.insertBefore(fs[i], tt);
            tt.parentNode.removeChild(tt);
        }
        tf.parentNode.removeChild(tf);
    }
} 

function check(uid,orderid,tel,email){
	var checkvalue=true;
	//if(!isuid(uid)){checkvalue=false;}
	if(uid.length==0){
		$("#suid").css("color","red");
		$("#suid").text("用户名/Email不能为空！");
		$("#imguid").hide();
		$("#hcheck").val(0);
		checkvalue=false;
	}
	if(!isorder(orderid)){checkvalue=false;}
	if(!istel(tel)){checkvalue=false;}
	if(!isemail(email)){checkvalue=false;}
	return checkvalue;
}
function add(){
	var orderid=$.trim($("#txtorderid").val());
	var tel=$.trim($("#txttele").val());
	var email=$.trim($("#txtemail").val());
	var type= $.trim($("#htype").val());  //类型
	var content=$.trim($("#txtcontent").val());
	var checkvalue=true;
	var uid=$.trim($("#huid").val());
	var hcheck=$.trim($("#hcheck").val());
	if(typeof($('#txtusername').val()) != 'undefined'){
		 uid=$.trim($("#txtusername").val());
		 $("#huid").val(uid);
	}
	var checkok=check(uid,orderid,tel,email);
	if(checkok){
	document.form1.submit();
	}
	
	
}



</script>
</head>

<body style=" background-color:#fff;">
<center>
<%@include file="/inc/head2.jsp" %>

 <form name="form1" action="function.jsp" method="post" enctype="multipart/form-data"  method="post"  >
			 
			 <div class="center">
   <div class="yhfk_main">
   <table class="yhfk_maintab" border="0" cellspacing="0" cellpadding="0">
   <tr>
   <td >&nbsp;</td>
   </tr>
   </table>
    <table class="yhfk_maintab1" border="0" cellspacing="0" cellpadding="0">
   <tr>
   <td valign="top">
      <table width="694" border="0" cellspacing="0" cellpadding="0">
	     
		  <tr>
		  <%
		  if(lUser != null){ %>
		   <input type="hidden" id="hcheck" value="1"  />
		    <input type="hidden" id="huid" name="huid" value="<%=lUser.getMbrmst_uid() %>"/>
			 <td colspan="3" style=" font-size:15px; " height="65px;"><span><b>您好<%=lUser.getMbrmst_uid() %>，请填写以下信息</b></span></td>  
		  <% }else{%>
		    <input type="hidden" id="huid"  name="huid"  />
		    <input type="hidden" id="hcheck"   />
			    <td class="td1" height="65px;" ><span style="color:red">*</span>用户名/Email：</td><td class="td2"><input type="text" id="txtusername" class="input1" onblur="isuid(this.value)" /></td><td><span id="suid">11年7月之后注册用户请输入注册邮箱</span><img id="imguid" src="http://images.d1.com.cn/images2011/feedback/image/suc.jpg" style="display:none"></img></td>
		   <%  }
		  %>
		  
	      </tr>
		  <tr>
			   <td class="td1" >订单号：</td><td class="td2"><input type="text" id="txtorderid" name="txtorderid" class="input1" maxlength="12"  onblur="isorder(this.value)"  onkeyup="this.value=this.value.replace(/[^\d]/g,'')" /></td><td><span id="sorder" >订单号12位数；如已生成订单，务必提供</span><img id="imgorderid" src="http://images.d1.com.cn/images2011/feedback/image/suc.jpg" style="display:none"/></td>
			  
		  </tr>
		  <tr>
			   <td class="td1" height="65px;" ><span style="color:red">*</span>联系电话：</td><td class="td2"><input type="text" id="txttele" name="txttele"  class="input1" onblur="istel(this.value);" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')"/></td><td><span id="stel">准确信息能让我们及时联系你（固话请注明区号）</span><img id="imgtel" src="http://images.d1.com.cn/images2011/feedback/image/suc.jpg" style="display:none"/></td>
			  
		  </tr>
		    <tr>
			   <td class="td1"><span style="color:red">*</span>联系邮箱：</td><td class="td2"><input type="text" id="txtemail" name="txtemail" class="input1" onblur="isemail(this.value)"/></td><td><span id="smail">请填写您确保可以收到邮件的邮箱</span><img id="imgemail" src="http://images.d1.com.cn/images2011/feedback/image/suc.jpg" style="display:none"/></td>
			  
		  </tr>
		   <tr><td height="40px" colspan="3"></td></tr>
		   <tr>
		       <td style="text-align:left;" colspan="3">
			       <font><b>&nbsp;&nbsp;* 类型</b></font><input id="htype" name="htype" type="hidden" value="1"/>
			       <ul>
			<li class="hmain1">
				<input type="radio" name="radio"  value="1" id="" style=" vertical-align:middle; margin-left:20px;" checked="checked" onclick="remark1()"/>商品咨询
			</li>
			<li class="hmain1">
			 <input type="radio" name="radio"  value="2" id="" class="input2" onclick="remark2()"/>物流/配送 
				
			</li>
			<li class="hmain1">
			<input type="radio" name="radio"  value="3" id="" class="input2" onclick="remark3()"/>支付问题
			</li>
			
			<li class="hmain">
			<input type="radio" name="radio" value="9" id="" class="input2"/>退换货问题  <span id="stype" style="color:red"></span>
			</li>
			<li class="hmain1">
			<input type="radio" name="radio" value="10" id="" class="input2" onclick="remark4()"/>其他问题
			</li>
</ul>
			      
			   </td>
		   </tr>
		   <tr><td colspan="3" height="20px"  style="padding-left:20px;line-height:22px">
		   <span id="span1" >产品购买咨询问题请进入商品详情页面询问</span>
		   <ul id="span2" style="display:none;padding-left:80px">
				<li>快递公司电话：</li>
				<li>宅急送：4006789000</li>
				<li>申通：057182122222</li>
				<li>乐运通：01083603381</li>
				<li>EMS：11185</li>
		</ul>
		   <span id="span3" style="display:none;padding-left:160px">支付方式有网上支付、银行电汇、邮局汇款和货到付款。</span>
		  <div id="d1" style="padding-left:230px;display:none;">
		  <ul style="border:solid #CCCCCC 1px; width:160px;" id="u1">
					<li class="limain" >
					<span>商品质量（请附照片）</span><input type="hidden" value="4"/>
					</li>
					<li class="limain">
					<span>发错货（请附照片）</span><input type="hidden" value="5"/>
					</li>
					<li class="limain">
					<span>尺码问题</span><input type="hidden" value="6"/>
					</li>
					<li class="limain">
					<span>个人喜好</span><input type="hidden" value="7"/>
					</li>
					<li class="limain">
					<span>更换其他款式/颜色</span><input type="hidden" value="8"/>
					</li>
					<li class="limain">
					<span>其他原因</span>	<input type="hidden" value="9"/>
					</li>
				</ul>
		  </div>
		  
		   <span id="span4" style="display:none;padding-left:320px">有其他问题或任何建议请告诉我们。</span>
		   </td></tr>
		   <tr><td height="20px" colspan="3"></td></tr>
		   <tr>
		       <td style="text-align:left;" colspan="3">
			       <font><b>&nbsp;&nbsp;*咨询内容</b></font>		       
			   </td>
		   </tr>
		    <tr>
		       <td style="text-align:left; padding-top:10px; padding-left:12px;" colspan="3">
			       <div style="float:left;">
				      <textarea id="txtcontent" name="txtcontent" style=" width:474px; height:88px; border:solid 1px #acacac; background:#f4f4f4;"  onkeyup="contentnum(this)"></textarea>
				   </div>
				   <div style=" float:left; padding-left:5px; padding-top:2px; line-height:16px; color:#333;"><span>请您详细描述。<br/>产品购买咨询问题请进入商品<br/>详情页面询问。<br></br></span></div>
			   </td>
		   </tr>
		    
		   <tr><td colspan="3" style=" padding-left:12px; " height="50px;">
			
			
			 <table width="100%" border="0" cellspacing="0" cellpadding="0">
			   <tr>
			   <td>
			   <a href="javascript:op();" >上传附件↑</a>&nbsp;&nbsp;
				<a id="a1" href="javascript:op1();" style="display:none">再上传一个↑</a>
				<a id="a2" href="javascript:op2();" style="display:none">再上传一个↑</a>
				<a id="a3" href="javascript:op3();" style="display:none">再上传一个↑</a>
				<a id="a4" href="javascript:op4();" style="display:none">再上传一个↑</a>
				
				 <font color="#D34368">&nbsp;(所有附件总容量不能超过10M)</font>
				 <br></br>
				 </td>
			   </tr>
			   <tr id="t1" style="display:none">
			   <td>
			   	<span id="s1" > 附件1：</span>  <input name="upload" type="file" id="f1" onchange="op();"/>&nbsp;&nbsp;&nbsp;<a id="d1"  href="javascript:Upload.clear('f1');">删除</a>
			   </td>
			   </tr>
			    <tr  id="t2" style="display:none">
			   <td>
			    <span id="s2" > 附件2：</span> <input name="upload" type="file" id="f2"  onchange="op1();"/>&nbsp;&nbsp;&nbsp;<a id="d2" href="javascript:Upload.clear('f2');">删除</a>
			   </td>
			   </tr>
			    <tr  id="t3" style="display:none">
			   <td>
			<span id="s3" > 附件3：</span> <input name="upload" type="file" id="f3"  onchange="op2();"/>&nbsp;&nbsp;&nbsp;<a id="d3" href="javascript:Upload.clear('f3');">删除</a>
			   </td>
			   </tr>
			    <tr  id="t4" style="display:none">
			   <td>
			  <span id="s4"> 附件4：</span> <input name="upload" type="file" id="f4"  onchange="op3();"/>&nbsp;&nbsp;&nbsp;<a id="d4"   href="javascript:Upload.clear('f4');">删除</a>
			   </td>
			   </tr>
			    <tr  id="t5" style="display:none">
			   <td>
			  <span id="s5" > 附件5：</span> <input name="upload" type="file" id="f5"  onchange="op4();"/>&nbsp;&nbsp;&nbsp;<a id="d5" href="javascript:Upload.clear('f5');">删除</a>
			   </td>
			   </tr>
			 
			   </table>	 
			
		    
		     </td>
		  </tr>
		    <tr><td colspan="3" style=" text-align:center; " height="50px;">
		
		    <a href="javascript:add();"><img src="http://images.d1.com.cn/images2012/New/feedback/yhfk_tjfk.jpg" /></a></td></tr>
	  
	 
	  </table>
	  
	  </td>
	  </tr>
	  </table>
   <table class="yhfk_maintab2" border="0" cellspacing="0" cellpadding="0">
   <tr>
   <td>&nbsp;</td>
   </tr>
   </table>	  
</div>	

   </div>
		
			  
			   
			
		    
		  </form>

    <%@include file="/inc/foot.jsp" %>
   </center>
</body>
</html>