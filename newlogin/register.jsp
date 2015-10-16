<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="/inc/header.jsp"%><%
//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
String act = request.getParameter("act");

if("post".equals(request.getMethod().toLowerCase()) && "regist".equals(act)){//注册
	String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
	String vCode = request.getParameter("code");
	if(vCode == null || vImageCode ==null || !vImageCode.equals(vCode)){
		Tools.outJs(out,"验证码输入错误，请重试！","back");
		return;
	}
	String email = request.getParameter("email");
	if(email != null) email = email.trim();
	if(!Tools.isEmail(email)){
		Tools.outJs(out,"邮箱地址格式有误，请修改","back");
		return;
	}
	User user = UserHelper.getByUsername(email);
	if(user != null){
		Tools.outJs(out,"邮箱已被注册，请更换一个","back");
		return;
	}
	String sex=request.getParameter("sex");
	if(Tools.isNull(sex)){
		Tools.outJs(out,"请选择性别","back");
		return;
	}
	String password = request.getParameter("password");
	if(password == null){
		Tools.outJs(out,"密码不能为空","back");
		return;
	}
	if(password.length()<6 || password.length()>14){
		Tools.outJs(out,"登录密码不能少于6个字符且不能多于14个字符","back");
		return;
	}
	if(password.indexOf(" ")>-1){
		Tools.outJs(out,"密码中不能包含空格","back");
		return;
	}
	//会员来源地址。
	String strMbrmstSrcUrl = Tools.getCookie(request,"d1.com.cn.srcurl");
	if(!Tools.isNull(strMbrmstSrcUrl)){
		strMbrmstSrcUrl = URLDecoder.decode(strMbrmstSrcUrl,"UTF-8");
		strMbrmstSrcUrl = strMbrmstSrcUrl.replace("'","\"");
	}else{
		strMbrmstSrcUrl = "";
	}
	String strMbrmstPeoplercm="",strMbrmstSubad="",strMbrmstTemp="";
	String peoplercm = Tools.getCookie(request,"d1.com.cn.peoplercm");
	if(!Tools.isNull(peoplercm)){
		strMbrmstPeoplercm = URLDecoder.decode(peoplercm.trim(),"UTF-8");
		strMbrmstPeoplercm = strMbrmstPeoplercm.replace("'","\"");
		
		String ckeMbrmstSubad = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");
		if(!Tools.isNull(ckeMbrmstSubad)){
			strMbrmstSubad = URLDecoder.decode(ckeMbrmstSubad.trim(),"UTF-8");
			strMbrmstSubad = strMbrmstSubad.replace("'","\"");
		}
		strMbrmstTemp = "联盟"+strMbrmstPeoplercm;
	}
	
	String ckeWangYi = "";
	String strLtinfo ="";
	
	try{
		 //PLINFO
	    String ckePLtinfo =  Tools.getCookie(request,"PLINFO");
	    if (!Tools.isNull(ckePLtinfo))
	    {
	    	String strPLtinfo = URLDecoder.decode(ckePLtinfo.trim(),"UTF-8");
	        strPLtinfo = strPLtinfo.replace("'","\"");
	        if (!Tools.isNull(strPLtinfo))
	        {
	            strMbrmstTemp = "PLINFO" + strPLtinfo;
	        }
	    }
	    
	    //CHANET
	    String ckeChanet = Tools.getCookie(request,"CHANET");
	    if (!Tools.isNull(ckeChanet))
	    {
	    	String strChanet = URLDecoder.decode(ckeChanet.trim(),"UTF-8");
	        strChanet =strChanet.replace("'","\"");
	        if (!Tools.isNull(strChanet))
	        {
	            strMbrmstTemp = "CHANET" + strChanet;
	        }
	    }
	
	    //EQIFA
	    String ckeEqifa =  Tools.getCookie(request,"EQIFA");
	    if (!Tools.isNull(ckeEqifa))
	    {
	        String strEqifa =URLDecoder.decode(ckeEqifa.trim(),"UTF-8");
	        strEqifa =strEqifa.replace("'","\"");
	        if (!Tools.isNull(strEqifa))
	        {
	            strMbrmstTemp = "EQIFA" + strEqifa;
	        }
	    }
	
	    //YIQIFA
	    String ckeYiqifa = Tools.getCookie(request,"YIQIFA"); 
	    if (!Tools.isNull(ckeYiqifa))
	    {
	    	String strYiqifa = URLDecoder.decode(ckeYiqifa.trim(),"UTF-8");
	        strYiqifa = strYiqifa.replace("'","\"");
	
	        String ckeYiqifaCid =Tools.getCookie(request,"YIQIFA_Cid"); //YIQIFA_Cid
	        String strYiqifaCid = "";
	        if (!Tools.isNull(ckeYiqifaCid))
	        {
	            strYiqifaCid = URLDecoder.decode(strYiqifaCid.trim(),"UTF-8");
	            strYiqifaCid = strYiqifaCid.replace("'","\"");
	        }
	        strMbrmstTemp = strYiqifaCid + "yiqifa" + strYiqifa;
	    }
	
	    //IPVGOU
	    String ckeIpvgou =Tools.getCookie(request,"IPVGOU");
	    if (!Tools.isNull(ckeIpvgou))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeIpvgou.trim(),"UTF-8");
	        strMbrmstTemp = strMbrmstTemp.replace("'","\"");
	    }
	
	    //YOYI
	    String ckeYoyi =Tools.getCookie(request,"YOYI");
	    if (!Tools.isNull(ckeYoyi))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeYoyi.trim(),"UTF-8");
	        strMbrmstTemp = strMbrmstTemp.replace("'","\"");
	    }
	
	    //SOHUVIP
	    String ckeSohuvip =Tools.getCookie(request,"SOHUVIP"); 
	    if (!Tools.isNull(ckeSohuvip))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeSohuvip.trim(),"UTF-8");
	        strMbrmstTemp = strMbrmstTemp.replace("'","\"");
	    }
	
	    //51返利            
	    String cke51Fanli =Tools.getCookie(request,"51FANLI"); 
	    if (!Tools.isNull(cke51Fanli))
	    {
	        strMbrmstTemp =URLDecoder.decode(cke51Fanli.trim(),"UTF-8");
	        strMbrmstTemp = strMbrmstTemp.replace("'","\"");
	    }
	    //网易
	    ckeWangYi =Tools.getCookie(request,"wangyi");
	    if (!Tools.isNull(ckeWangYi))
	    {
	    	System.out.println(ckeWangYi);
	    	String [] str=ckeWangYi.trim().split("\\|");
	    	System.out.println(str[0]);
	        strMbrmstTemp = URLDecoder.decode(str[0],"UTF-8");
	        strMbrmstTemp = "WangYi" + strMbrmstTemp.replace("'","\"");
	    }
	    //lele
	    String ckeLele =Tools.getCookie(request,"lele");
	    if (!Tools.isNull(ckeLele))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeLele.trim(),"UTF-8");
	        strMbrmstTemp = "lele" +  strMbrmstTemp.replace("'","\"");
	    }
	
	    //WEIYI
	    String ckeWeiYi =Tools.getCookie(request,"WEIYI");
	    if (!Tools.isNull(ckeWeiYi))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeWeiYi.trim(),"UTF-8");
	        strMbrmstTemp = "WEIYI" +  strMbrmstTemp.replace("'","\"");
	    }
	
	    //AigoVip
	    String ckeAigoVip =Tools.getCookie(request,"AigoVip");
	    if (!Tools.isNull(ckeAigoVip))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeAigoVip.trim(),"UTF-8");
	        strMbrmstTemp = strMbrmstTemp.replace("'","\"");
	    }
	
	    //RegaddAlipay
	    String ckeRegaddAlipay =Tools.getCookie(request,"RegaddAlipay");
	    if (!Tools.isNull(ckeRegaddAlipay))
	    {
	        strMbrmstTemp = URLDecoder.decode(ckeRegaddAlipay.trim(),"UTF-8");
	        strMbrmstTemp = strMbrmstTemp.replace("'","\"");
	    }
	
	    //LTINFO
	    String ckeLtinfo = Tools.getCookie(request,"LTINFO");
	    
	    if (!Tools.isNull(ckeLtinfo))
	    {
	        strLtinfo = URLDecoder.decode(ckeLtinfo.trim(),"UTF-8");
	        strLtinfo = strLtinfo.replace("'","\"");
	        strMbrmstTemp = "linktech" + strLtinfo;
	    }
	}catch(Exception ex){
		ex.printStackTrace();
	}

	Date currDate = new Date();
	
	user = new User();
	user.setId(SequenceIdGenerator.generate("3"));
	user.setMbrmst_uid(email);
	user.setMbrmst_passwd(MD5.to32MD5(request.getParameter("password")));
	user.setMbrmst_pwd(MD5.to32MD5(request.getParameter("password")));
	user.setMbrmst_question("");
	user.setMbrmst_answer("");
	user.setMbrmst_createdate(currDate);
	user.setMbrmst_modidate(currDate);
	user.setMbrmst_lastdate(currDate);
	//int iAtPos = email.indexOf("@");
	//if(iAtPos >= 0){
	//	user.setMbrmst_name(email.substring(0,iAtPos));
	//}else{
		user.setMbrmst_name("");
	//}
	user.setMbrmst_visittimes(new Long(1));
	user.setMbrmst_sex(new Long(sex));
	user.setMbrmst_email(email);
	user.setMbrmst_hphone("");
	user.setMbrmst_usephone("");
	user.setMbrmst_haddr("");
	user.setMbrmst_countryid(new Long(1));
	user.setMbrmst_provinceid(new Long(0));
	user.setMbrmst_cityid(new Long(0));
	user.setMbrmst_postcode("");
	user.setMbrmst_certifiertype(new Long(0));
	user.setMbrmst_certifierno("");
	user.setMbrmst_myd1type(new Long(0));
	user.setMbrmst_myd1count(new Long(10));
	user.setMbrmst_myd1codes("");
	user.setMbrmst_specialtype(new Long(0));
	user.setMbrmst_srcurl(strMbrmstSrcUrl);
	user.setMbrmst_peoplercm(strMbrmstPeoplercm);
	user.setMbrmst_subad(strMbrmstSubad);
	user.setMbrmst_temp(strMbrmstTemp);
	user.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
	user.setMbrmst_bookletflag(new Long(0));
	user.setMbrmst_buyerrcount(new Long(0));
	user.setMbrmst_buyquestionid("");
	user.setMbrmst_downflag(new Long(0));
	user.setMbrmst_magazineflag(new Long(0));
	user.setMbrmst_validflag(new Long(0));
	user.setMbrmst_rcmcount(new Long(0));
	user.setMbrmst_ip("");
	user.setMbrmst_bktstep(new Long(0));
	user.setMbrmst_aliasname("");
	user.setMbrmst_src(new Long(0));
	user.setMbrmst_sendcount(new Long(0));
	user.setMbrmst_replycount(new Long(0));
	user.setMbrmst_kicktype(new Long(0));
	user.setMbrmst_bbsAlllogintimes(new Long(0));
	user.setMbrmst_bbsDaylogintimes(new Long(0));
	user.setMbrmst_allsrc(new Long(0));
	user.setMbrmst_jcsrc(new Long(0));
	user.setMbrmst_goldsrc(new Long(0));
	user.setMbrmst_goldallsrc(new Long(0));
	user.setMbrmst_birthflag(new Long(0));
	user.setMbrmst_tktmail(new Long(0));
	user.setMbrmst_phoneflag(new Long(0));//手机验证
	user.setMbrmst_mailflag(new Long(0));//邮箱验证
	
	user = (User)UserHelper.manager.create(user);
	if(user != null && user.getId()!=null){
		// 网易注册用户
         if (!Tools.isNull(ckeWangYi)){
             String[] arrWangYiid = ckeWangYi.split("\\|");
             User163 userl63=new User163();
             userl63.setWangyi_mbrid(new Long(user.getId()));
             userl63.setWangyi_regDate(new Date());
             userl63.setWangyi_unionid(arrWangYiid[0]);
             userl63.setWangyi_userid(arrWangYiid[1]);
             userl63 = (User163)Tools.getManager(User163.class).create(userl63);
				if(userl63!=null){
					String url="http://gouwutest.youdao.com/fanxian/cpa";
					StringBuffer str=new StringBuffer();
					str.append("wid=1102&userId=");
					str.append(arrWangYiid[1]);
					str.append("&regId=");
					str.append(email);
					str.append("&regTime=");
					str.append(Tools.stockFormatDate(new Date()));
					str.append("&status=0");
					IntfUtil.GetPostData(url, str.toString());
				}
         }
       /*  if (!Tools.isNull(strLtinfo)){
        	 String url="http://service.linktech.cn/purchase_cpa.php";
				StringBuffer str=new StringBuffer();
				str.append("a_id=");
				str.append(strLtinfo);
				str.append("&m_id=d1bianli");
				str.append("&mbr_id=").append(email);
				str.append("&&o_cd=").append(email);
				str.append("&p_cd=d1_member");
				IntfUtil.GetPostData(url, str.toString());
         }*/
         SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         Date actendDate=null;
         Date tktendDate=null;
         try{
        	 actendDate=fmt2.parse("2012-4-15 23:59:59");
         	 tktendDate=fmt2.parse("2012-4-15 23:59:59");
         	 }
         catch(Exception ex){
         	ex.printStackTrace();
         }
         String cardno="mq1203"+Tools.getFormatDate(new Date().getTime(), "yyyyMMdd")+user.getId();
         if ("mq1203".equals(session.getAttribute("d1lianmengsubad"))&&
        		 Tools.dateValue(actendDate)>System.currentTimeMillis()){
        	 Ticket tktmst=new Ticket();
    		 tktmst.setTktmst_value(new Float(20));
    		 tktmst.setTktmst_type("002001");
    		 tktmst.setTktmst_mbrid(Tools.parseLong(user.getId()));
    		 tktmst.setTktmst_validflag(new Long(0));
    		 tktmst.setTktmst_createdate(new Date());
    		 tktmst.setTktmst_validates(new Date());
    		 tktmst.setTktmst_validatee(tktendDate);
    		 tktmst.setTktmst_rackcode("000");
             tktmst.setTktmst_gdsvalue(new Float(20));
             tktmst.setTktmst_payid(new Long(-1));
             tktmst.setTktmst_cardno(cardno);
             tktmst.setTktmst_ifcrd(new Long(0));
             tktmst.setTktmst_memo("9周年活动市场新客领券！");
             Tools.getManager(Ticket.class).create(tktmst);
         }
        	 
		UserHelper.setLoginUserId(session,user.getId());

		
		if(session.getAttribute("url")!=null && session.getAttribute("url").toString().indexOf("/market/1206/wydh/")>0){
		    session.setAttribute("url", "");
			response.sendRedirect("/market/1206/wydh/index.jsp");
		}
		else if(session.getAttribute("url")!=null && session.getAttribute("url").toString().indexOf("/market/1207/wangyidh/")>=0){
			session.setAttribute("url", "");
			response.sendRedirect("/market/1207/wangyidh/index.jsp");
		}else if(session.getAttribute("backurl")!=null&&session.getAttribute("backurl").equals("/market/1212/dangdang")){
		    session.setAttribute("backurl", "");
			response.sendRedirect("/market/1212/dangdang");
		}else{
			response.sendRedirect("/newlogin/regsuccess.jsp");
		}
		return;
	}else{
		Tools.outJs(out,"注册失败，请重新再试！","/login.jsp");
		return;
	}
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册页面</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("regist.js")%>"></script>
<style type="text/css" >
body{ margin:0px; padding:0px; border:none; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.center{margin:0px auto; }
.reg{margin:0px auto;  width:756px; height:76px; background:url(http://images.d1.com.cn/images2012/login/zc_03-2.jpg) no-repeat; margin-top:40px;}
.btnlogin{padding-left:510px;  height:62px; text-align:right; padding-top:14px;}
.btnlogin a { }
.reg1{margin:0px auto;  width:756px;  background:url(http://images.d1.com.cn/images2012/login/zc_06.jpg) ; padding-top:20px;}
.reg_main{ padding-left:10px; }
.reg_main table{ color:#333; font-size:14px;}
.reg_main table td{ line-height:22px;}
.reg_info{ font-size:16px; color:#d1436b; font-weight:bold; padding-bottom:30px;}
.inputstyle{width:220px; border:solid 1px #ababab; background-color:#f4f4f4; height:22px;}
.reg_main .input_chk{  height:15px; width:20px; background:#fff; border:none; vertical-align:middle;}
.reg_main .td1{ text-align:right;}
.reg_main span{ color:#999999; font-size:12px;}
.reg_main span.red{color:#F00;}
.reg_main span a{ color:#0014a8; text-decoration:underline;}
.reg_main td img{ vertical-align:middle;}
.v2reg_tips02{display:none;  color:#a10000; border:1px #ffd5d5 solid; padding:3px 5px; display:inline-block;}
.reg_bottom{margin:0px auto;  width:756px;}
</style>
</head>

<body>
<%
String backurl = request.getHeader("referer");
//System.out.print(backurl+"qqqqqqqqqqqqqqq");
if(backurl!=null&&backurl.indexOf("/market/1206/wydh/")>0){
	session.setAttribute("url", backurl);
}
if(backurl!=null&&backurl.indexOf("/market/1207/wangyidh/")>0){
	session.setAttribute("url", backurl);
}
%>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<table cellpadding="0" cellspacing="0" border="0">

</table>


     <div class="reg">
			<div class="btnlogin">
			<table>
			<tr><td width="100px" align="center"><a href="/newlogin/login.jsp">
			   <span style="color:#fff;font-size:16px;  font-family:微软雅黑">已有账户</span></a></td>
			   <td align="center">  <a href="/newlogin/login.jsp">
			   <img src="http://images.d1.com.cn/images2012/login/reglogin.png" alt="立即登录"/></a></td>
			   </tr>
			</table>
			
			 
			</div>
       </div>
       <div style="clear:both;"></div>
       <div class="reg1">
		   <div class="reg_main">
		   <form name="form_Regist" id="form_Regist" action="/newlogin/register.jsp?act=regist" method="post" onsubmit="return false;">
		   <table width="740">
			  <tr><td class="reg_info" colspan="3" >填写注册信息</td></tr>
			  <tr><td class="td1"  width="150px">*Email地址：</td><td ><input type="text" name="email" id="email" onfocus="email_focus();" onblur="is_email(this.value);" maxlength="64" class="inputstyle"/>&nbsp;&nbsp;<span id="email_Notice2"></span></td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="email_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			   <tr><td class="td1" >*您的性别：</td><td align="left"><input type="checkbox" name="sex" id="sex1" value="0" style="width:20px;" onclick="checksex1(this)"/>男&nbsp;&nbsp;<input type="checkbox" name="sex" id="sex2"  value="1" style="width:20px;" onclick="checksex2(this)"/>女&nbsp;&nbsp;<span id="sex_Notice2"></span></td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="sex_Notice">选择性别，方便我们推荐适合您的商品。</span><span>&nbsp;</span></td></tr>
			  <tr><td colspan="3" height="10"></td></tr>
			  <tr><td class="td1">*设置密码：</td><td><input type="password" name="password" id="password" onfocus="pass_focus();" onblur="is_pass(this.value);" maxlength="14" class="inputstyle"/>&nbsp;&nbsp;<span id="pass_Notice2"></span>
			  </td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="pass_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			  <tr><td colspan="3" height="10"></td></tr>
			  <tr><td class="td1">*确认密码：</td><td><input type="password" name="password2" id="password2" onfocus="pass2_focus();" onblur="is_pass2(this.value);" maxlength="14" class="inputstyle"/>&nbsp;&nbsp;<span id="pass2_Notice2"></span>
			   </td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="pass2_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			  
			  <tr><td colspan="3" height="10"></td></tr>
			  <tr><td class="td1">*验证码：</td><td><input type="text" name="code" id="code" onfocus="code_focus();" onblur="is_code(this.value);" maxlength="4" onkeyup="key_up(this);" onkeydown="key_down(event);" class="inputstyle" style="width:118px;" />&nbsp;&nbsp;<img id="vPic" style="vertical-align:bottom;cursor:pointer;" width="60" height="24" onclick="this.src='/ImageCode?r='+Math.random();" alt="点击刷新验证码" />&nbsp;&nbsp;
			  <span style="color:#000000;">看不清，&nbsp;<a href="###" onclick="$('#vPic').attr('src','/ImageCode?r='+Math.random());" title="点击刷新验证码">换一张</a></span>&nbsp;&nbsp;<span id="code_Notice2"></span></td></tr>
			   <tr><td  class="td1">&nbsp;</td><td ><span id="code_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			  <tr><td colspan="3" height="50"></td></tr>
			  <tr><td colspan="3" style="text-align:center;"><input id="regist_submit" onclick="user_regist(form_Regist,this);" type="image" style="width:auto;height:auto;border:none;background:none;" src="http://images.d1.com.cn/images2012/New/reg/reg_new.jpg" /></td></tr>
 <tr><td colspan="3" height="20"></td></tr>
		   </table></form>
		   </div>
    </div>
    <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
    
</div>
<script type="text/javascript">
$(function(){
	setTimeout(function(){$('#reg_email').focus();},500);
	$('#vPic').attr('src','/ImageCode?r='+Math.random());
});
</script>
<%@include file="/inc/foot.jsp" %>
</body>
</html>