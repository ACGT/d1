<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include file="../inc/islogin.jsp"%><%  
	String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
	backurl=backurl.replace("#", "");
	String addressid="";
	String provid="";
	String cityid="";
	String name="";
	String addr="";
	String code="";
	String phone="";
	String tel="";
	String email="";
	boolean bl=false;
	boolean check=true;
	UserAddress address=null;
	if(!Tools.isNull(request.getParameter("hideProvId"))){
		provid=request.getParameter("hideProvId");
	}
	if(!Tools.isNull(request.getParameter("hideCityId"))){
		cityid=request.getParameter("hideCityId");
	}
	if(!Tools.isNull(request.getParameter("hideAddressId")))
	{
		addressid=request.getParameter("hideAddressId");
		 address=UserAddressHelper.getById(addressid);
			if(address!=null){
				if(address.getMbrcst_mbrid().toString().trim().equals(lUser.getId())){
					bl=true;
				}
				System.out.print(">>>>>>>>>>>>>>");
				  name=address.getMbrcst_name();
					addr=address.getMbrcst_raddress();
					code=address.getMbrcst_rzipcode();
					phone=address.getMbrcst_rphone();
					tel=address.getMbrcst_rtelephone();
					email=address.getMbrcst_remail();
			}
	}
	if(!Tools.isNull(request.getParameter("addressid")))
	{
		addressid=request.getParameter("addressid").trim();
	}
	   String ticketid = request.getParameter("ticketid");//优惠券ID
	    String prepay=request.getParameter("prepay");//预付款
	    String liuyan=request.getParameter("liuyan");//订单留言
	    String from=request.getParameter("from");
	    String url="addressid="+addressid;
	    if(!Tools.isNull(ticketid) && ! "null".equals(ticketid)){
	    	url+="&ticketid="+ticketid;
	    }
	    if(!Tools.isNull(prepay) && ! "null".equals(prepay)){
	    	url+="&prepay="+prepay;
	    }
	    if(!Tools.isNull(liuyan) && ! "null".equals(liuyan)){
	    	url+="&liuyan="+liuyan;
	    }
	    if(!Tools.isNull(from) && ! "null".equals(from)){
	    	url+="&from="+from;
	    }
	String msg="";
	 String title="修改收货地址";
	 String btntext="修&nbsp;改";
	    boolean isadd=false;
	    String op="";
	    if(!Tools.isNull(request.getParameter("op"))){
	    	op="add";
	    	title="新增收货地址";
	    	isadd=true;
	    	 btntext="添&nbsp;加";
	    }
	  
	    
	    
	    
	if("post".equals(request.getMethod().toLowerCase()) ){
		if(!Tools.isNull(request.getParameter("txtRAddress"))){
			addr=Tools.simpleCharReplace(request.getParameter("txtRAddress"));
		}
		if(!Tools.isNull(request.getParameter("txtRZipcode")) && check){
			code=request.getParameter("txtRZipcode");
		}
		if(!Tools.isNull(request.getParameter("txtRPhone")) && check){
			phone=request.getParameter("txtRPhone");
		}
		if(!Tools.isNull(request.getParameter("txtREmail")) && check){
			email=request.getParameter("txtREmail");
		}
		if(!Tools.isNull(request.getParameter("txtTelePhone")) && check){
			tel=request.getParameter("txtTelePhone");
		}
		if(!Tools.isNull(request.getParameter("txtName"))){
			name=request.getParameter("txtName");
		}else{
			msg="请填写收货人姓名！";
			check=false;
		}
		if(check){
			if(!Tools.isNull(request.getParameter("txtRAddress"))){
				addr=Tools.simpleCharReplace(request.getParameter("txtRAddress"));
				int iByteLength = StringUtils.strLength(addr);
				if(iByteLength >200){
					msg="详细地址字数超过200！";
					check=false;
				}
				if(UserAddressHelper.isSameAddress(lUser.getId(),addressid,name,addr)){
					msg="改地址已经存在！";
					check=false;
				}
			}else{
				msg="请填写详细地址！";
				check=false;
			}
		}
		if(check){
			if(!Tools.isNull(request.getParameter("txtRZipcode")) && check){
				code=request.getParameter("txtRZipcode");
				if(!Tools.isMath(code) || code.length()!=6){
					msg="邮编格式不正确！";
					check=false;
				}
			}else{
				msg="请填写邮政编码！";
				check=false;
			}
		}
		if(check){
			if(!Tools.isNull(request.getParameter("txtRPhone")) && check){
				phone=request.getParameter("txtRPhone");
				if(!Tools.isMobile(phone)){
					msg="手机号码格式错误！";
					check=false;
				}
			}else{
				msg="请填写手机号码！";
				check=false;
			}
		}
		if(check){
			if(!Tools.isNull(request.getParameter("txtREmail")) && check){
				email=request.getParameter("txtREmail");
				if(!Tools.isEmail(email)){
					msg="邮箱格式错误！";
					check=false;
				}
			}else{
				msg="请填写邮箱地址！";
				check=false;
			}
		}
		if(check){
			if(!Tools.isNull(request.getParameter("txtTelePhone")) && check){
				tel=request.getParameter("txtTelePhone");
				check=false;
			}
		}
		if(check){
			if(isadd){
				address = new UserAddress();
				//查找当前用户有几个地址。
				long maxId = UserAddressHelper.getUserMaxId(lUser.getId());
				
				address.setMbrcst_id(new Long(maxId));
				address.setMbrcst_mbrid(Long.parseLong(lUser.getId()));
				address.setCreatedate(new Date());
			}
			address.setMbrcst_name(name);
			address.setMbrcst_rsex(new Long(1));
			address.setMbrcst_relation("");
			address.setMbrcst_countryid(new Long(1));
			address.setMbrcst_provinceid(new Long(provid));
			address.setMbrcst_cityid(new Long(cityid));
			address.setMbrcst_raddress(addr);
			address.setMbrcst_rzipcode(code);
			address.setMbrcst_remail(email);
			address.setMbrcst_rphone(phone);
			address.setMbrcst_rtelephonecode("");
			address.setMbrcst_rtelephone(tel);
			address.setMbrcst_rtelephoneext("");
			address.setMbrcst_memo("");
			address.setMbrcst_rthird(new Long(0));
			address.setUpdatedate(new Date());
			if(isadd){
				address = (UserAddress)UserAddressHelper.manager.create(address);
				msg="添加成功！";
				if(!Tools.isNull(from) && ! "null".equals(from)){
					response.sendRedirect("/wap/flowCheck1.jsp?"+url+"&addressid="+address.getId());
				}else{
					response.sendRedirect("/wap/user/address.jsp");
				}
			}else{
				if(UserAddressHelper.manager.update(address,true)){
					msg="修改成功！";
					if(!Tools.isNull(from) && ! "null".equals(from)){
						response.sendRedirect("/wap/flowCheck1.jsp?"+url+"&addressid="+address.getId());
					}else{
						response.sendRedirect("/wap/user/address.jsp");
					}
				}else{
					msg="修改失败，请稍后进行操作！";
				}
			}
		}
	}
	
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—修改收货人地址</title>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px; padding-left:4px; }
ol,ul{list-style:none;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
img{ border:none;}
.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
.newli{ padding-left:8px;}
</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
 
      <% if(addressid.equals("") && !isadd) {
    	 out.print("您没有权限修改本地址，请返回<a href=\"/wap/user/address.jsp\">我的地址簿</a>");
     }
     else
     {
     %>

  <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>><a href="address.jsp">收货地址簿</a>><%=title %>
    <br/>
    </div>
    <form action="addressupdate.jsp" method="post">
    <input id="hidefrom" name="hidefrom" type="hidden" value="<%=provid %>" />
          <input id="hideurl" name="hideurl" type="hidden" value="<%=url %>" />
    <input id="hideProvId" name="hideProvId" type="hidden" value="<%=provid %>" />
    <input id="hideCityId" name="hideCityId" type="hidden" value="<%=cityid %>" />
     <input id="hideAddressId" name="hideAddressId" type="hidden" value="<%=addressid %>" />
     <input id="op" name="op" type="hidden" value="<%=op %>" />
      <input id="from" name="from" type="hidden" value="<%=from %>" />
      <input id="addressid" name="addressid" type="hidden" value="<%=addressid %>" />
      <input id="ticketid" name="ticketid" type="hidden" value="<%=ticketid %>" />
      <input id="prepay" name="prepay" type="hidden" value="<%=prepay %>" />
      <input id="liuyan" name="liuyan" type="hidden" value="<%=liuyan %>" />
    <div id="third" style=" margin-top:2px; line-height:18px; "> 
    <span style="color:red;"><%=msg %></span><br/>
      
	       第3步/共3步<br/>
	       <table>
	       <tr><td>&nbsp;<font color='red'>*</font>&nbsp;收货人：</td><td><input type="text" id="txtName" name="txtName" value="<%=name%>"/>
	                   <br/><span id="spanName"  style="color:#e53333;display:none"></span>
	       </td></tr>
	        <tr><td>&nbsp;<font color='red'>*</font>&nbsp;详细地址：</td><td><input type="text" id="txtRAddress" name="txtRAddress" value="<%=addr%>"/>
	             <br/>
	        </td></tr>
	         <tr><td> &nbsp;<font color='red'>*</font>&nbsp;邮政编码：</td><td><input type="text" id="txtRZipcode" maxlength="6" name="txtRZipcode"  value="<%=code%>"/>
	                  <br/><span id="spanRZipcode"  style="color:#e53333;display:none"></span>
	         </td></tr>
	          <tr><td>&nbsp;<font color='red'>*</font>&nbsp;手机号码：</td><td><input type="text" id="txtRPhone" name="txtRPhone" value="<%=phone%>"/>
	                    <br/><span id="spanRPhone"  style="color:#e53333;display:none"></span>
	          </td></tr>
	           <tr><td>&nbsp;<font color='red'>*</font>&nbsp;邮箱</td><td><input type="text" id="txtREmail" maxlength="40"  name="txtREmail" value="<%=email%>"/>
	                     <br/><span id="spanREmail"  style="color:#e53333;display:none"></span>
	            </td></tr>
	           <tr><td>&nbsp;固定电话：</td><td><input type="text" id="txtTelePhone" name="txtTelePhone" value="<%=tel%>"/>
	                     <br/> <span id="spanTelePhone"  style="display:none"></span>
	           </td></tr>
	           
	                </table>
	      <span id="erroinfo"></span>
        <input type="submit" value="<%=btntext %>"  id="btnSaveMbrcst"  style="width:65px; padding:4px;"/>&nbsp;&nbsp;<a href="addresscity.jsp?hideProvId=<%=provid %>&hideAddressId=<%=addressid %><%=url %>"  style=" text-decoration:underline">返回上一步</a>
       
        </div>
		
     </form>   
                       
	  <%}%>
 
    <div id="info" style=" margin-top:2px; line-height:18px; display:none;"> </div>        
	  
</div>

 

<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->
</body>
</html>


