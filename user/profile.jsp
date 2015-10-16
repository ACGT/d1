<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><%!
ArrayList<Profileinfo> getProfile(String mbrid){
	  ArrayList<Profileinfo> rlist = new ArrayList<Profileinfo>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("profile_mbrid",mbrid));
		
		List<BaseEntity> list = Tools.getManager(Profileinfo.class).getList(clist, null, 0, 1);
		if(list==null||list.size()==0)return null;	
		for(BaseEntity be:list){
			Profileinfo pp = (Profileinfo)be;
				rlist.add(pp);
			}
		return rlist ;
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——个人信息</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck.js")%>"></script>
<script type="text/javascript">
//检查姓名
function CheckUserName(strName){
    if (typeof(strName) == 'undefined'){
        strName = $.trim($('#txtName').val());
    }
    var spanName = $('#s1');
    if (strName == null || strName.length == 0){
        spanName.show();
        $('#img1').hide();
        return false;
    }else{
        spanName.hide();
        $('#img1').show();
    }
    return true;
}
//检查地址
function CheckAddress(strRAddress){
    if (typeof(strRAddress) == 'undefined'){
        strRAddress = $.trim($('#txtRAddress').val());
    }
    var spanRAddress = $('#spanRAddress');
    if (strRAddress == null || strRAddress.length == 0){
        spanRAddress.show();
        $('#imgaddress').hide();
        return false;
    }else{
    	$('#imgaddress').show();
        spanRAddress.hide();
    }
    return true;
}
//检查手机号码
function CheckPhone(strRPhone){
    if (typeof(strRPhone) == 'undefined'){
        strRPhone = $.trim($('#txtRPhone').val());
    }
    var spanRPhone = $('#spanRPhone');
    if (strRPhone == null || strRPhone.length == 0){
    	 spanRPhone.html('*请输入手机号码');
        spanRPhone.show();
        $('#imgphone').hide();
        return false;
    }
    if (!isMobile(strRPhone)){
        spanRPhone.html('*无效手机号码,请重新输入');
        spanRPhone.show();
        $('#imgphone').hide();
        return false;
    }else{
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/newlogin/check_validateuser.jsp",
            cache: false,
            data:{
            	tel: strRPhone,
		        r: new Date().getTime(),
		        f:'userinfo',
		        act:'is_tel'
		       
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
               
            },success: function(result){
            	if(result == 1){
           		 spanRPhone.html('');
           		    spanRPhone.hide();
           		    $('#imgphone').show();
           		 return true;
           		  
           	}else if(result == 2){
           		spanRPhone.html('*该手机号已验证过');
           	    spanRPhone.show();
           	    $('#imgphone').hide();
           	 return false;
           	   
           	}else{
           		 spanRPhone.html('*无效手机号码,请重新输入');
           		    spanRPhone.show();
           		    $('#imgphone').hide();
           		 return false;
           		  
           	}

            }
            });
    	 return true;
    }
    	
   
}

// 检查固定电话
function CheckTel(strTelePhone){
    if (typeof (strTelePhone) == 'undefined'){
        strTelePhone = $.trim($('#txtTelePhone').val());
    }
    var spanTelePhone = $('#spanTelePhone');
    if (strTelePhone != null && strTelePhone.length > 0){
        if (!isPhoneCall(strTelePhone)){
            spanTelePhone.html('*无效电话号码！');
            spanTelePhone.show();
            $('#imgtel').hide();
            return false;
        }
    }
    spanTelePhone.html('');
    spanTelePhone.hide();
    $('#imgtel').show();
    return true;
}

// 检查邮箱地址
function CheckEmail(strREmail){
    if (typeof (strREmail) == 'undefined'){
        strREmail = $.trim($('#txtREmail').val());
    }
    var spanREmail = $('#spanREmail');
    if (strREmail == null || strREmail.length == 0){
    	 spanREmail.html('*请输入您的常用邮箱地址！');
        spanREmail.show();
        $('#imgemail').hide();
        return false;
    }
    if (!isEmail(strREmail)){
        spanREmail.html('*邮箱格式错误，请重新输入！');
        $('#imgemail').hide();
        spanREmail.show();
        return false;
    }else{
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/newlogin/check_validateuser.jsp",
            cache: false,
            data:{
            	email: strREmail,
		        r: new Date().getTime(),
		        act:'is_email'
		       
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
               
            },success: function(result){
            	if(result == 2){
            		 spanREmail.html('');
            		    spanREmail.hide();
            		    $('#imgemail').show();
            		    return true;
       		}else if(result == 1){
       			 spanREmail.html('该邮箱已验证过！');
       		        $('#imgemail').hide();
       		        spanREmail.show();
       		     return false;
       		}else{
       			 spanREmail.html('*邮箱格式错误，请重新输入！');
       		        $('#imgemail').hide();
       		        spanREmail.show();
       		     return false;
       		}

            }
            });
    	 return true;
    }
   
}

// 检查邮政编码
function CheckCode(strRZipcode){
    if (typeof (strRZipcode) == 'undefined'){
        strRZipcode = $.trim($('#txtRZipcode').val());
    }
    var spanRZipcode = $('#spanRZipcode');
    if (strRZipcode == null || strRZipcode.length == 0){
    	spanRZipcode.html('*请输入邮编');
        spanRZipcode.show();
        $('#imgcode').hide();
        return false;
    }
    if (!isPostalCode(strRZipcode)){
        spanRZipcode.html('*无效邮政编码！');
        spanRZipcode.show();
        $('#imgcode').hide();
        return false;
    }
    spanRZipcode.html('');
    spanRZipcode.hide();
    $('#imgcode').show();
    return true;
}

function checkyear(stryear){
	  if (typeof (stryear) == 'undefined'){
		  stryear = $.trim($('#txtyear').val());
	    }
	    var syear = $('#syear');
	    if (stryear == null || stryear.length == 0){
	    	syear.html('*请填写生日信息！');
	    	syear.show();
	        return false;
	    }
	    var myDate = new Date();
	    if (stryear<1900 || stryear>myDate.getFullYear()){
	    	syear.html('*年份输入错误，请重新输入！');
	    	syear.show();
	        return false;
	    }
	    syear.hide();
	    return true;
}

function getday(){
	var year= $.trim($('#txtyear').val());
	var month=$('#ddlmonth').val();
	var day=31;
	if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12){
		day=31;
	}
	else if(month==2){
		if((year%4==0 && year%100!=0) || (year%400==0)){
			day=29;
		}else{day=28;}
	}
	else{
		day=30;
	}
	$('#ddlday').empty();
	for(var i=1;i<=day;i++){
		$("<option value=" + i + ">" + i + "</option>").appendTo($('#ddlday'));
	}

}

function checkprovince(){
	var pro=$.trim($("#ddlProvince").val());
	if(pro==null || pro.length==0){
		$("#s3").show();
		return false;
	}else{
		//$("#s4").show();
		$("#s3").hide();	
		return true;
	}
	
}

function checkcity2(){
	var city=$.trim($("#ddlcity").val());
	if(city==null || city.length==0){
		$("#s4").show();
		return false;
	}else{
		$("#s4").hide();
		return true;
	}
}


function clears(){
	
	 $('#tblAddEditMbrct input[type=text]').each(function(){
	        $(this).val('');
	    })

	    $('#tblAddEditMbrct span[id^=span]').each(function(){
	        $(this).hide();
	    })
	    
	     $('#tblAddEditMbrct img[id^=img]').each(function(){
	        $(this).hide();
	    })
	    
	    $('#ddlProvince').val('');
	    $('#ddlCity').val('');
	
}

function check(){
	 var blnSuccess = true;
	    if (!CheckUserName()) blnSuccess = false;
	    if (!checkyear()) blnSuccess = false;
	    if (!CheckProvince()) blnSuccess = false;
	    if (!CheckCity()) blnSuccess = false;
	    if (!CheckAddress()) blnSuccess = false;
	    if (!CheckCode()) blnSuccess = false;
	    if (!CheckEmail()) blnSuccess = false;
	    if (!CheckPhone()) blnSuccess = false;
	    if (!CheckTel()) blnSuccess = false;
	    return blnSuccess;
}

function keepUserInfo(){
	var username=$.trim($('#txtName').val());
	var sex= $('input[type=radio][name=rdoSex]:checked').val();
	var year= $.trim($('#txtyear').val());
	var month=$('#ddlmonth').val();
	var day=$('#ddlday').val();
	var province=$('#ddlProvince').val();
    var city=$('#ddlCity').val();
    var address= $.trim($('#txtRAddress').val());
    var code=$.trim($('#txtRZipcode').val());
    var email=$.trim($('#txtREmail').val());
    var phone= $.trim($('#txtRPhone').val());
    var tel= $.trim($('#txtTelePhone').val());
    
  
    if(check()){
    	
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/newlogin/updateUserInfo.jsp",
            cache: false,
            data:{
		        Name: username,
		        Sex: sex,
		        year:year,
		        month:month,
		        day:day,
		        ProvinceID: province,
		        CityID: city,
		        RAddress: address,
		        RPhone: phone,
		        TelePhone: tel,
		        REmail: email,
		        RZipcode: code
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
                $.alert('修改信息失败！');
            },success: function(strRet){
            	//alert(strRet);
            	 //var iRet=strRet;
            	 if(strRet=="-201"){$.alert('会员ID参数出错！');}
            	 else if(strRet=="-202"){$.alert('姓名超过20个字符长度(一个汉字占两个字符)！');}
            	 else if(strRet=="-203"){$.alert('请选择省份！');}
            	 else if(strRet=="-204"){$.alert('请选择城市！');}
            	 else if(strRet=="-213"){$.alert('生日年份输入错误！');}
            	 else if(strRet=="-1"){$.alert('保存失败！');}
            	 else if(strRet==1){
            		 $.alert('保存成功！','提示',function(){
     	        		this.location.href="profile.jsp";
     	        		});
            		 //$.alert('保存成功！'); window.location.href="profile.jsp"
            	}

            }
            }
    	)
    }
}


function clearprofile(){
	//alert(111);
	$("#Height").val("");
	$("#Weight").val("");
	$("[name='Colors']").removeAttr("checked");
	$("[name='Closes']").removeAttr("checked");
	$("#sbrand").val("");
	$("#smoney").val("");
	
}
function keepProfileInfo(){
	var height=$("#Height").val();
	var weight=$("#Weight").val();
	var xw=$("#xw").val();
	var yw=$("#yw").val();
	var shoessize=$("#shoes").val();
	var color="";
	var category="";
	 $("[name='Colors']").each(function(){
	      if($(this).attr("checked")){
	    color+=$(this).val()+","; 
	   }
	 });
	 $("[name='Closes']").each(function(){
	      if($(this).attr("checked")){
	    	  category+=$(this).val()+","; 
	   }
	 });
	
	var money=$("#smoney").val();
	 $.ajax({
		 dataType: "json",
			url: '/newlogin/updateprofile.jsp',
			cache: false,
         data:{ height: height,weight:weight,color:color,category:category,money:money,xw:xw,yw:yw,shoessize:shoessize },
         error: function(XmlHttpRequest){
           //  $.alert('修改信息失败！');
         },success: function(json){
         	 $.alert(json.message);
         	}
         });
	
}
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="/user/left.jsp" %>
     
  <!--右侧-->

  <!--右侧-->

   <div class="mbr_right">
       <div class="myinfo">
        <table width="768" border="0" cellspacing="0" cellpadding="0" class="t_info" id="tblAddEditMbrct">

			    <tr>

				    <td colspan="2" style="background:#F8EEEE;border-bottom:solid 1px #8A2B3F; height:55px;"> <font color="#8b2d3d" style=" font-size:15px;"><b>&nbsp;&nbsp;完善个人资料</b></font>
				    <br/>
				    <span style="color:#666;">&nbsp;&nbsp;&nbsp;&nbsp;为了给您提供个性化服务，请完善生日/性别/喜好等信息，生日当月能收到生日礼物祝福。</span>
				    </td>

				</tr>
			    <tr>
				    <td colspan="2">
				    <br/>
					<font color="#000000" style=" font-size:15px;"><b>&nbsp;&nbsp;基本资料</b></font>
					</td>

				</tr>

				 <tr>

				    <td width="100" style="text-align:right;">用户名：</td><td><%=lUser.getMbrmst_uid() %></td>

				</tr>

				 <tr>

				    <td  style="text-align:right;"><font color="#c93334">*</font>真实姓名：</td><td>
				    <%
				    String name=lUser.getMbrmst_name();
				    if(!Tools.isNull(name)){
				    	if(lUser.getMbrmst_uid().indexOf(name)>=0){
				    		name="";
				    	}
				    }
				    %>
				    <input type="text" id="txtName" name="txtName" onblur="CheckUserName()" value="<%=name%>" style=" width:80px;" />&nbsp;<span id="s1" style="color:red;display:none;">*请填写您的姓名</span><img  id="img1" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>

				</tr>

				 <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>性别：</td><td><input type="radio" name="rdoSex" value="0" style=" height:auto; border:none; background:none;"<%if(Tools.longValue(lUser.getMbrmst_sex()) == 0){ %> checked="checked"<%} %> />男 &nbsp;&nbsp;<input type="radio" name="rdoSex" value="1" style=" height:auto; border:none; background:none;"<%if(Tools.longValue(lUser.getMbrmst_sex()) == 1){ %> checked="checked"<%} %>  />女</td>

					 </tr>
					<%
					Date birthday = lUser.getMbrmst_birthday();
					String year = null;
					int month = 0;
					int day = 0;
					if(birthday != null){
						String birthdayStr = Tools.getDate(birthday);
						if(Tools.matches("[0-9]{4}-[0-9]{2}-[0-9]{2}",birthdayStr)){
							year = birthdayStr.substring(0,4);
							month = Tools.parseInt(birthdayStr.substring(5,7));
							day = Tools.parseInt(birthdayStr.substring(8,10));
						}
					}
					%>
					  <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>生日：</td><td><input type="text" maxlength="4" id="txtyear" value="<%=Tools.formatString(year) %>" <%if(!Tools.isNull(Tools.formatString(year))){%>readonly= "readonly" disabled="disabled"<%} %> style="width:50px;" onblur="checkyear();getday();" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')"/>年&nbsp;
				     <select width="50" id="ddlmonth" <%if(!Tools.isNull(Tools.formatString(year))){%> disabled="disabled"<%} %> onchange="getday();" onfocus="checkyear()">
				     <%
				      for(int i=1;i<=12;i++){ %>
				    	  <option value='<%=i%>'<%if(i==month){ %> selected<%} %>><%=i %></option>
				     <% }
				     %>
				     </select>月&nbsp;<select id="ddlday" <%if(!Tools.isNull(Tools.formatString(year))){%>disabled="disabled"<%} %>>
				     
 					<%
				      for(int i=1;i<=31;i++){ %>
				    	  <option value='<%=i%>'<%if(i==day){ %> selected<%} %>><%=i %></option>
				     <% }
				     %>
					</select>日
				     <span id="syear" style="color:red;">*生日信息保存后将无法修改，请您认真填写。D1优尚将会为您送上生日祝福！</span>
				      </td>

					 </tr>

					  <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>省/直辖市：</td>
				     <td><select id="ddlProvince"  onchange="ChangeProv(this)">
							<option value="">==请选择==</option>
						</select>
                       	县/市/区 <select id="ddlCity" class="b15" onchange="CheckCity()">
                        	<option value="">==请选择==</option>
                        </select>
                        <span id="spanProvinceCity"  style="color:#e53333;display:none"></span></td>

					 </tr>

					  <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>详细地址：</td><td><input type="text" id="txtRAddress" maxlength="200" style="width:300px" value="<%=Tools.formatString(lUser.getMbrmst_haddr()) %>" onblur="CheckAddress()"  /><span id="spanRAddress" style="color:red;display:none;">*请输入您的详细地址 </span><img  id="imgaddress" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>

					 </tr>

					  <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>邮编：</td><td><input type="text" id="txtRZipcode" maxlength="6" value="<%=Tools.formatString(lUser.getMbrmst_postcode()) %>" onblur="CheckCode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " style="width:100px;" /><span id="spanRZipcode" style="color:red;display:none;">*请输入邮编 </span><img  id="imgcode" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>

					 </tr>

					  <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>邮箱地址：</td><td><input type="text" id="txtREmail" maxlength="40" value="<%=Tools.formatString(lUser.getMbrmst_email()) %>" onblur="CheckEmail()" style="width:150px;" />
				     <%
				     if(lUser.getMbrmst_mailflag()==null || lUser.getMbrmst_mailflag()!=1){
				    	 %> 
				    	 <span style="color:red;">&nbsp;&nbsp;为了您的账户安全，请<a href="/newlogin/valiemail.jsp" target="_blank" style="text-decoration:underline; color:#0149ab; ">验证邮箱</a></span>
				     <%}
				     %>
				     <span id="spanREmail" style="color:red;display:none;">*请输入您的常用邮箱地址 </span><img  id="imgemail" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>

					 </tr>

					  <tr>

				     <td  style="text-align:right;"><font color="#c93334">*</font>手机：</td><td><input type="text" <% if(lUser.getMbrmst_phoneflag()!=null && lUser.getMbrmst_phoneflag().longValue()==1){ %>Readonly <%} %>  id="txtRPhone" maxlength="11" value="<%=Tools.formatString(lUser.getMbrmst_mphone()) %>" onblur="CheckPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " style="width:120px;" />
				      <%
				     if(lUser.getMbrmst_phoneflag()==null || lUser.getMbrmst_phoneflag()!=1){
				    	 %> 
				    	 <span style="color:red;">&nbsp;&nbsp;为了您的账户安全，请<a href="/newlogin/valitel.jsp" target="_blank" style="text-decoration:underline; color:#0149ab; ">验证手机</a></span>
				     <%}else{
				    	 %>  
				    	 <span style="color:red;">&nbsp;&nbsp;您的手机已经通过验证<!--  如需更换绑定手机，请输入新手机号并验证--></span>
				     <%}
				     %>
				     <span id="spanRPhone" style="color:red;display:none;">*请输入手机号码 </span><img  id="imgphone" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>

					 </tr>

					  <tr>

				     <td  style="text-align:right;">固定电话：</td>
				     <td><input type="text" id="txtTelePhone" maxlength="12" value="<%=Tools.formatString(lUser.getMbrmst_hphone()) %>" onblur="CheckTel();" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')"/>
			            <span id="spanTelePhone"  style="color:#e53333;display:none"></span><img id="imgtel" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>

					 </tr>
					<tr>

				    <td colspan="2" style=" height:50px;"></td>

				</tr>
				</table>
				<table width="768">
				<tr height="10">
					<td width="100"></td>
				    <td  style="text-align:left;"><a href="javascript:void(0);" onclick="keepUserInfo()"><img src="http://images.d1.com.cn/images2012/New/user/saveinfo.jpg" /></a>
				    &nbsp;&nbsp;&nbsp;&nbsp;
				    <a href="javascript:void(0);" onclick="clears();"><img src="http://images.d1.com.cn/images2012/New/user/clearcontent.jpg" /></a></td>
				    </tr>
<tr>
<td colspan="2" style="border-bottom:solid 1px #8A2B3F; width:100%;"> &nbsp;</td>
</tr>
<tr>
<td colspan="2" > <br/> <font color="#000000" style=" font-size:15px;"><b>&nbsp;&nbsp;详细资料</b></font><span>(如下信息有助于我们为您提供个性化服务)</span></td>
</tr>
<tr>
<td colspan="2">
<%
ArrayList<Profileinfo> plist= getProfile(lUser.getId());
String height="";
String weight="";
String color="";
String type="";
String brand="";
String money="";
String xw="";
String yw="";
String shoes="";
if(plist!=null){
	Profileinfo pinfo=plist.get(0);
	height=pinfo.getProfile_height();
	weight=pinfo.getProfile_weight();
	color=pinfo.getProfile_color();
	type=pinfo.getProfile_category();
	brand=pinfo.getProfile_brand();
	money=pinfo.getProfile_money();
	xw=pinfo.getProfile_xw();
	yw=pinfo.getProfile_yw();
	shoes=pinfo.getProfile_shoesize();
	//System.out.println(weight+"wwwwwwwwwwwwwwwwwwwwwww");
}
%>

<table width="768" class="fieldset">
<tr><td width="20"></td><td width="100"  align="right" height="35">身高：</td><td>
<select id="Height" name="Height" >
                                    <option value="" <%if(Tools.isNull(height)){ %>selected="selected" <%}%>>请选择&nbsp; </option>
                                    <option value="150CM 以下" <%if("150CM 以下".equals(height)){ %>selected="selected" <%}%>>150CM 以下</option>
                                    <option value="150～159CM" <%if("150～159CM".equals(height)){ %>selected="selected" <%}%>>150～159CM</option>
                                    <option value="160～164CM" <%if("160～164CM".equals(height)){ %>selected="selected" <%}%>>160～164CM</option>
                                    <option value="165～169CM" <%if("165～169CM".equals(height)){ %>selected="selected" <%}%>>165～169CM</option>
                                    <option value="170～174CM" <%if("170～174CM".equals(height)){ %>selected="selected" <%}%>>170～174CM</option>
                                    <option value="175～179CM" <%if("175～179CM".equals(height)){ %>selected="selected" <%}%>>175～179CM</option>
                                    <option value="180～184CM" <%if("180～184CM".equals(height)){ %>selected="selected" <%}%>>180～184CM</option>
                                    <option value="185～189CM" <%if("185～189CM".equals(height)){ %>selected="selected" <%}%>>185～189CM</option>
                                    <option value="190CM 以上" <%if("190CM 以上".equals(height)){ %>selected="selected" <%}%>>190CM 以上</option>
                                </select>

</td></tr>
<tr><td width="20"></td><td align="right" height="35">体重：</td><td>
 <select id="Weight" name="Weight" >
                                    <option value="" <%if(Tools.isNull(weight)){ %>selected="selected" <%}%>>请选择&nbsp; </option>
                                    <option value="40KG 以下" <%if("40KG 以下".equals(weight)){ %>selected="selected" <%}%>>40KG 以下</option>
                                    <option value="41KG～50KG" <%if("41KG～50KG".equals(weight)){ %>selected="selected" <%}%>>41KG～50KG</option>
                                    <option value="51KG～55KG" <%if("51KG～55KG".equals(weight)){ %>selected="selected" <%}%>>51KG～55KG</option>
                                    <option value="56KG～60KG" <%if("56KG～60KG".equals(weight)){ %>selected="selected" <%}%>>56KG～60KG</option>
                                    <option value="61KG～70KG" <%if("61KG～70KG".equals(weight)){ %>selected="selected" <%}%>>61KG～70KG</option>
                                    <option value="71KG～80KG" <%if("71KG～80KG".equals(weight)){ %>selected="selected" <%}%>>71KG～80KG</option>
                                    <option value="81KG～100KG" <%if("81KG～100KG".equals(weight)){ %>selected="selected" <%}%>>81KG～100KG</option>
                                    <option value="100KG 以上" <%if("100KG 以上".equals(weight)){ %>selected="selected" <%}%>>100KG 以上</option>
                                </select>

</td></tr>
<tr><td width="20"></td><td align="right" height="35">胸围：</td><td>
 <select id="xw" name="xw" >
                                    <option value="" <%if(Tools.isNull(xw)){ %>selected="selected" <%}%>>请选择&nbsp; </option>
                                    <option value="70" <%if("70".equals(xw)){ %>selected="selected" <%}%>>70</option>
                                    <option value="75" <%if("75".equals(xw)){ %>selected="selected" <%}%>>75</option>
                                    <option value="80" <%if("80".equals(xw)){ %>selected="selected" <%}%>>80</option>
                                    <option value="85" <%if("85".equals(xw)){ %>selected="selected" <%}%>>85</option>
                                    <option value="90" <%if("90".equals(xw)){ %>selected="selected" <%}%>>90</option>
                                    <option value="95" <%if("95".equals(xw)){ %>selected="selected" <%}%>>95</option>
                                    <option value="100" <%if("100".equals(xw)){ %>selected="selected" <%}%>>100</option>
                                    <option value="105" <%if("105".equals(xw)){ %>selected="selected" <%}%>>105</option>
                                    <option value="110" <%if("110".equals(xw)){ %>selected="selected" <%}%>>110</option>
                                    <option value="115" <%if("115".equals(xw)){ %>selected="selected" <%}%>>115</option>
                                    <option value="120以上" <%if("120以上".equals(xw)){ %>selected="selected" <%}%>>120以上</option>
                                  
                                </select>

</td></tr>
<tr><td width="20"></td><td align="right" height="35">腰围：</td><td>
 <select id="yw" name="yw" >
                                    <option value="" <%if(Tools.isNull(yw)){ %>selected="selected" <%}%>>请选择&nbsp; </option>
                                    <option value="1尺8" <%if("1尺8".equals(yw)){ %>selected="selected" <%}%>>1尺8</option>
                                    <option value="1尺9" <%if("1尺9".equals(yw)){ %>selected="selected" <%}%>>1尺9</option>
                                    <option value="2尺" <%if("2尺".equals(yw)){ %>selected="selected" <%}%>>2尺</option>
                                    <option value="2尺1" <%if("2尺1".equals(yw)){ %>selected="selected" <%}%>>2尺1</option>
                                    <option value="2尺2" <%if("2尺2".equals(yw)){ %>selected="selected" <%}%>>2尺2</option>
                                    <option value="2尺3" <%if("2尺3".equals(yw)){ %>selected="selected" <%}%>>2尺3</option>
                                    <option value="2尺4" <%if("2尺4".equals(yw)){ %>selected="selected" <%}%>>2尺4</option>
                                    <option value="2尺5" <%if("2尺5".equals(yw)){ %>selected="selected" <%}%>>2尺5</option>
                                     <option value="2尺6" <%if("2尺6".equals(yw)){ %>selected="selected" <%}%>>2尺6</option>
                                      <option value="2尺7" <%if("2尺7".equals(yw)){ %>selected="selected" <%}%>>2尺7</option>
                                       <option value="2尺8" <%if("2尺8".equals(yw)){ %>selected="selected" <%}%>>2尺8</option>
                                        <option value="2尺9" <%if("2尺9".equals(yw)){ %>selected="selected" <%}%>>2尺9</option>
                                    <option value="3尺以上" <%if("3尺以上".equals(yw)){ %>selected="selected" <%}%>>3尺以上</option>
                                  
                                </select>

</td></tr>
<tr><td width="20"></td><td align="right" height="35">鞋码：</td><td>
 <select id="shoes" name="shoes" >
                                    <option value="" <%if(Tools.isNull(shoes)){ %>selected="selected" <%}%>>请选择&nbsp; </option>
                                    <option value="小于35" <%if("小于35".equals(shoes)){ %>selected="selected" <%}%>>小于35</option>
                                    <option value="35" <%if("35".equals(shoes)){ %>selected="selected" <%}%>>35</option>
                                    <option value="36" <%if("36".equals(shoes)){ %>selected="selected" <%}%>>36</option>
                                    <option value="37" <%if("37".equals(shoes)){ %>selected="selected" <%}%>>37</option>
                                    <option value="38" <%if("38".equals(shoes)){ %>selected="selected" <%}%>>38</option>
                                    <option value="39" <%if("35".equals(shoes)){ %>selected="selected" <%}%>>39</option>
                                    <option value="40" <%if("40".equals(shoes)){ %>selected="selected" <%}%>>40</option>
                                     <option value="41" <%if("41".equals(shoes)){ %>selected="selected" <%}%>>41</option>
                                      <option value="42" <%if("42".equals(shoes)){ %>selected="selected" <%}%>>42</option>
                                       <option value="43" <%if("43".equals(shoes)){ %>selected="selected" <%}%>>43</option>
                                    <option value="44以上" <%if("44以上".equals(shoes)){ %>selected="selected" <%}%>>44以上</option>
                                  
                                </select>

</td></tr>
<tr><td width="20"></td><td align="right" valign="top">喜欢的衣服颜色：</td><td>
<ul>
                                    <li>
                                        <input type="checkbox" value="1" name="Colors" id="color_1"  <%if(color.indexOf(",1,")>=0){ %>checked="checked"<% }%>/>
                                        <label>
                                            黑色</label>
                                        <input disabled="disabled" class="color color1" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="2" name="Colors" id="color_2" <%if(color.indexOf(",2,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color2">
                                            白色</label>
                                        <input disabled="disabled" class="color color2" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="3" name="Colors" id="color_3" <%if(color.indexOf(",3,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color3">
                                            灰色</label>
                                        <input disabled="disabled" class="color color3" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="4" name="Colors" id="color_4" <%if(color.indexOf(",4,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color4">
                                            银色</label>
                                        <input disabled="disabled" class="color color4" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="5" name="Colors" id="color_5" <%if(color.indexOf(",5,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color5">
                                            米色</label>
                                        <input disabled="disabled" class="color color5" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="6" name="Colors" id="color_6" <%if(color.indexOf(",6,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color6">
                                            浅蓝</label>
                                        <input disabled="disabled" class="color color6" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="7" name="Colors" id="color_7" <%if(color.indexOf(",7,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color7">
                                            蓝色</label>
                                        <input disabled="disabled" class="color color7" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="8" name="Colors" id="color_8" <%if(color.indexOf(",8,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color8">
                                            深蓝</label>
                                        <input disabled="disabled" class="color color8" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="9" name="Colors" id="color_9" <%if(color.indexOf(",9,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color9">
                                            青蓝</label>
                                        <input disabled="disabled" class="color color9" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="10" name="Colors" id="color_10" <%if(color.indexOf(",10,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color10">
                                            粉红</label>
                                        <input disabled="disabled" class="color color10" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="11" name="Colors" id="color_11" <%if(color.indexOf(",11,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color11">
                                            红色</label>
                                        <input disabled="disabled" class="color color11" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="12" name="Colors" id="color_12" <%if(color.indexOf(",12,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color12">
                                            深红</label>
                                        <input disabled="disabled" class="color color12" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="13" name="Colors" id="color_13" <%if(color.indexOf(",13,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color13">
                                            浅绿</label>
                                        <input disabled="disabled" class="color color13" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="14" name="Colors" id="color_14" <%if(color.indexOf(",14,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color14">
                                            绿色</label>
                                        <input disabled="disabled" class="color color14" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="15" name="Colors" id="color_15" <%if(color.indexOf(",15,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color15">
                                            深绿</label>
                                        <input disabled="disabled" class="color color15" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="16" name="Colors" id="color_16" <%if(color.indexOf(",16,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color16">
                                            黄色</label>
                                        <input disabled="disabled" class="color color16" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="17" name="Colors" id="color_17" <%if(color.indexOf(",17,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color17">
                                            浅黄</label>
                                        <input disabled="disabled" class="color color17" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="18" name="Colors" id="color_18" <%if(color.indexOf(",18,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color18">
                                            橙色</label>
                                        <input disabled="disabled" class="color color18" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="19" name="Colors" id="color_19" <%if(color.indexOf(",19,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color19">
                                            金色</label>
                                        <input disabled="disabled" class="color color19" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="20" name="Colors" id="color_20" <%if(color.indexOf(",20,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color20">
                                            褐色</label>
                                        <input disabled="disabled" class="color color20" />
                                    </li>
                                    <li>
                                        <input type="checkbox" value="21" name="Colors" id="color_21" <%if(color.indexOf(",21,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="color21">
                                            紫色</label>
                                        <input disabled="disabled" class="color color21" />
                                    </li>
                                </ul>

</td></tr>
<tr><td colspan="3" height="10"></td></tr>
<tr><td width="20"></td><td align="right"  valign="top">常穿的服装类型：</td><td>
<ul style="width:290px;">
                                    <li>
                                        <input type="checkbox" value="1" name="Closes" id="close_1" <%if(type.indexOf(",1,")>=0){ %>checked="checked"<% }%> />
                                        <label for="close1">
                                            商务职场</label>
                                    </li>
                                    <li>
                                        <input type="checkbox" value="2" name="Closes" id="close_2" <%if(type.indexOf(",2,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="close2">
                                            商务休闲</label>
                                    </li>
                                    <li>
                                        <input type="checkbox" value="3" name="Closes" id="close_3" <%if(type.indexOf(",3,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="close3">
                                           时尚流行</label>
                                    </li>
                       <li>
                                        <input type="checkbox" value="4" name="Closes" id="close_4" <%if(type.indexOf(",4,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="close4">
                                            生活休闲</label>
                                    </li>                  
                                    <li>
                                        <input type="checkbox" value="5" name="Closes" id="close_5" <%if(type.indexOf(",5,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="close5">
                                           户外服装</label>
                                    </li>
                               
                                    <li>
                                        <input type="checkbox" value="6" name="Closes" id="close_6" <%if(type.indexOf(",6,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="close6">
                                            运动服装</label>
                                    </li>
                                    <li>
                                        <input type="checkbox" value="7" name="Closes" id="close_7" <%if(type.indexOf(",7,")>=0){ %>checked="checked"<% }%>/>
                                        <label for="close7">
                                            其他</label>
                                    </li>
                                </ul>

</td></tr>

<tr><td width="20"></td><td align="right" height="35">月收入：</td><td>
<select id="smoney" ><option value="" <%if(Tools.isNull(money)){ %>selected="selected" <%}%>>请选择&nbsp; </option><option value="0">无收入</option>
<option value="2000元以下" <%if("2000元以下".equals(money)){ %>selected="selected" <%}%>>2000元以下</option>
<option value="2000~3999元" <%if("2000~3999元".equals(money)){ %>selected="selected" <%}%>>2000~3999元</option>
<option value="4000~5999元" <%if("4000~5999元".equals(money)){ %>selected="selected" <%}%>>4000~5999元</option>
<option value="6000~7999元" <%if("6000~7999元".equals(money)){ %>selected="selected" <%}%>>6000~7999元</option>
<option value="8000~9999元" <%if("8000~9999元".equals(money)){ %>selected="selected" <%}%>>8000~9999元</option>
<option value="10000~15000元" <%if("10000~15000元".equals(money)){ %>selected="selected" <%}%>>10000~15000元</option>
<option value="15000元以上" <%if("15000元以上".equals(money)){ %>selected="selected" <%}%>>15000元以上</option>
</select></td></tr>
<tr><td colspan="3" height="30"></td></tr>
<tr><td width="20"></td><td></td><td align="left" ><a href="javascript:void(0);" onclick="keepProfileInfo()"><img src="http://images.d1.com.cn/images2012/New/user/saveinfo.jpg" /></a>
				    &nbsp;&nbsp;&nbsp;&nbsp;
				    <a href="javascript:void(0);" onclick="clearprofile();"><img src="http://images.d1.com.cn/images2012/New/user/clearcontent.jpg" /></a></td></tr>
<tr><td colspan="3" height="20">&nbsp;</td></tr>
</table>
</td>
</tr>


			</table>
			<script type="text/javascript">
				BindProvince('<%=Tools.longValue(lUser.getMbrmst_provinceid()) %>');
				BindProvCity('<%=Tools.longValue(lUser.getMbrmst_provinceid()) %>', '<%=Tools.longValue(lUser.getMbrmst_cityid()) %>');
			</script>
	   </div>

	</div>

 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

