<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator,java.util.Hashtable,com.todaynic.client.mobile.*,com.d1.util.*"%><%@include file="/inc/header.jsp"%><%!
String getcard(String str1) {	
	  DESUtil des = new DESUtil( "hellod1" );  
	  return  des.encryptStr(str1);
	}
%>
<%
//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
	String mail=request.getParameter("mail");
	if(Tools.isNull(mail)){
		out.print("1");
		return;
	}
	if(!Tools.isEmail(mail)){
		out.print("2");
		return;
	}
	//判断是否验证过
	boolean isvalemail=UserHelper. getByUserMail(mail);
	if(isvalemail){
		out.print("3");
		return;
	}
	
   
    String type=request.getParameter("type");   
    if(Tools.isNull(type)){
    	out.print("1");
		return;
    }
    if("get".equals(type)){
    	 //生成激活码
		  
		String str=lUser.getId()+"|"+mail+"|"+new Date().getTime();
		 DESUtil des = new DESUtil( "hd1comcn" );  
    	 str= des.encryptStr(str);
		String vc=URLEncoder.encode(str, "utf-8");
		String url="http://www.d1.com.cn/newlogin/valid_email.jsp?vc="+vc+"&type=set";
		 String mailSubject = "D1优尚邮箱验证";
		 StringBuilder sb=new StringBuilder();
		 sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-size:12px;\">");
		 sb.append("<tr><td style=\"border-bottom:1px dashed #666666; font-size:14px;\">").append(lUser.getMbrmst_uid()).append(",您好!</td></tr><tr><td>&nbsp;</td></tr>");
		 sb.append("<tr><td>感谢您注册D1优尚网，请点击下面的按钮，完成邮箱验证。</td> </tr><tr><td height=\"30px\">&nbsp;</td></tr>");
		 sb.append("<tr><td><a href=\"").append(url).append("\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/login/bt_mail2.gif\" border=\"0\"/></a></td></tr> ");
		 sb.append(" <tr><td height=\"30px\">&nbsp;</td></tr><tr><td>您也可以点击下面的链接，完成邮箱验证：</td></tr><tr><td>&nbsp;</td></tr>");
		 sb.append("<tr><td><a href=\"").append(url).append("\" target=\"_blank\">").append(url).append("</a></td></tr>");
		 sb.append(" <tr> <td height=\"40px\">&nbsp;</td></tr><tr><td>如果您不能点击上面链接，还可以将以下链接复制到浏览器地址栏中访问：</td></tr><tr><td>&nbsp;</td></tr>");
		 sb.append("<tr><td><a href=\"").append(url).append("\" target=\"_blank\"  style=\"text-decoration:none;\">").append(url).append("</a></td></tr>");
		 sb.append("<tr><td height=\"50px\">&nbsp;</td></tr>");
		 sb.append("<tr> <td>D1优尚网全国统一客服电话：400-680-8666（9:00-18:00）。<br /><br />感谢您光临<a href=\"http://www.d1.com.cn/\" target=\"_blank\">D1优尚网</a>，您的支持是我们前进的动力！</td> </tr>");
		 sb.append("<tr> <td height=\"40px\">&nbsp;</td></tr><tr><td>（注：此信为系统通知邮件，请勿直接回复）</td></tr>");
		 sb.append("</table>");
		
		 /**
		 String mailFromemail = "service@d1.com.cn";
			Email pwEmail = new Email();
			pwEmail.setBody(sb.toString());
			pwEmail.setOdrid("");
			pwEmail.setIfsend(new Long(0));
			pwEmail.setCreatetime(new Date());
			pwEmail.setSendname("");
			pwEmail.setFromemail(mailFromemail);
			pwEmail.setSendemail(mail);
			pwEmail.setSubject(mailSubject);

			Tools.getManager(Email.class).create(pwEmail); 
		
		**/
		SendMail.send(mail,mailSubject,sb.toString(),"staff.d1.com.cn","D1优尚网",25,"service@staff.d1.com.cn","gr556ugw4");
		
			out.print("0");
					return;
    }
%>
