<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@include file="/inc/header.jsp"%>
<%@page import="java.util.Date,java.util.regex.Matcher,java.util.regex.Pattern"%>
<style type="text/css">
<!--
body,td,th {
	font-size: 13px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->
</style>
<%!
public static boolean isValidDate(String s)
{
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    try
    {
         dateFormat.parse(s);
         return true;
     }
    catch (Exception e)
    {
        // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
        return false;
    }
}

%>
<%
  if("post".equals(request.getMethod().toLowerCase()))   
  {
	  String content=request.getParameter("content");
  	String qviewtime=request.getParameter("qviewtime");
  	String questionflag=request.getParameter("questionflag");
  	if(content!=null&&content.length()==0)
  	{
  		Tools.outJs(out, "问题不能为空！", "back");
  	    return;
  	}
  	if(!isValidDate(qviewtime))
  	{
  		Tools.outJs(out, "时间格式 不正确！", "back");
  	    return;
  	}
  	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
  	Date qtime=null;
  	try{
  		qtime=fmt2.parse(qviewtime);
  		 }
  	catch(Exception ex){
  		ex.printStackTrace();
  	}
  	
  	Random rndcard = new Random();
  	String timestr=16+rndcard.nextInt(5)+"";
  	String minstr="0"+rndcard.nextInt(59);
  	timestr=timestr+":"+minstr.substring(minstr.length()-2)+":00";
AYQuestion qus=new AYQuestion();
try{
	
  	qus.setQuestionTitle(content);
  	qus.setQviewTime(qtime);
  	qus.setQuestionFlag(new Long(questionflag));
  	qus.setQuestionAn("");
  	qus.setQuestiontktend(timestr);
  	qus=(AYQuestion)Tools.getManager(AYQuestion.class).create(qus);

        if(qus!=null)
        {
        	Tools.outJs(out, "添加奥运问题成功", "");
        }
        else
        {
        	Tools.outJs(out, "添加奥运问题失败", "");
        }
}
catch(Exception ex){
	ex.printStackTrace();
}
  }
%>
<form  name=form1 method=post action="">
<INPUT type="hidden" name=stype value="add">
<table border="1" width="70%" align=center bordercolorlight="#800000" bordercolordark="#FFFF00" cellspacing="0" bordercolor="#FFFFFF"  cellpadding="1" bgcolor="#000000">
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" height="20" colspan=2><font color="#333333"><b>增加奥运问题 </b></font></td>    
  </tr>
  <tr bgcolor="#FDEBEB" align="center">
  <td width="18%" bgcolor="#F5F5F5" class="main">问题：</td>
    <td width="82%" align=left bgcolor="#F5F5F5" class="main">
    <INPUT type="text" size=60 name=content>    </td>
  </tr>  
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">显示时间：</td>
    <td class="main" bgcolor="#F5F5F5" align=left>
    <INPUT type="text" size=30 name=qviewtime>   格式必须为“YYYY-MM-DD”  </td>
  </tr>  
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">是否有效：</td>
    <td class="main" bgcolor="#F5F5F5" align=left><SELECT  name=questionflag class=input>
      <option value="1">有效</option>
	   <option value="0" selected="selected">无效</option>

    </select></td>
  </tr>  
    
    
  
  <tr bgcolor="#FDEBEB" align="center">   
    <td class="main" height="20" colspan=2><INPUT type="submit" value=" 提 交 " id=submit2 name=submit2></td>
  </tr>
  </table>
  </form>