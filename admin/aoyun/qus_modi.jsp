<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%><%!
//格式必须为“YYYY-MM-DD”  //你也可以自己定义
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
String id="";
if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
{
	   id=request.getParameter("id");
}
if("post".equals(request.getMethod().toLowerCase()))   
{
	  String content=request.getParameter("content");
	String qviewtime=request.getParameter("qviewtime");
	String questionflag=request.getParameter("questionflag");
	String ans=request.getParameter("ans");
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
	AYQuestion qus=(AYQuestion)Tools.getManager(AYQuestion.class).get(id);
	qus.setQuestionTitle(content);
	qus.setQviewTime(qtime);
	qus.setQuestionFlag(new Long(questionflag));
	qus.setQuestionAn(ans);
	if(Tools.getManager(AYQuestion.class).update(qus,false))
      {
      	Tools.outJs(out, "修改奥运问题成功", "");
      }
      else
      {
      	Tools.outJs(out, "修改奥运问题失败", "");
      }
}
%>
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
<%
 AYQuestion qusm=(AYQuestion)Tools.getManager(AYQuestion.class).get(id);
 SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");

       if(qusm!=null)
       {%>
       <form  name=form1 method=post action="qus_modi.jsp">
        <input type="hidden" id="id" name="id" value="<%= qusm.getId() %>"/>
<table border="1" width="70%" align=center bordercolorlight="#800000" bordercolordark="#FFFF00" cellspacing="0" bordercolor="#FFFFFF"  cellpadding="1" bgcolor="#000000">
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" height="20" colspan=2><font color="#333333"><b>修改奥运问题 </b></font></td>    
  </tr>
  <tr bgcolor="#FDEBEB" align="center">
  <td width="18%" bgcolor="#F5F5F5" class="main">问题：</td>
    <td width="82%" align=left bgcolor="#F5F5F5" class="main">
    <INPUT type="text" size=60 name=content value="<%=qusm.getQuestionTitle() %>">    </td>
  </tr>  
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">显示时间：</td>
    <td class="main" bgcolor="#F5F5F5" align=left>
    <INPUT type="text" size=30 name=qviewtime  value="<%=sf.format(qusm.getQviewTime())%>">   格式必须为“YYYY-MM-DD”  </td>
  </tr>  
   <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">答案：</td>
    <td class="main" bgcolor="#F5F5F5" align=left>
    <INPUT type="text" size=30 name=ans  value="<%=qusm.getQuestionAn()%>"">   </td>
  </tr> 
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">是否有效：</td>
    <td class="main" bgcolor="#F5F5F5" align=left><SELECT  name=questionflag class=input>
      <option value="1" <%if (qusm.getQuestionFlag()==1){ out.print("selected");}%>>有效</option>
	   <option value="0" <%if (qusm.getQuestionFlag()==0) { out.print("selected");}%>>无效</option>

    </select></td>
  </tr>  
    
    
  
  <tr bgcolor="#FDEBEB" align="center">   
    <td class="main" height="20" colspan=2><INPUT type="submit" value=" 提 交 " id=submit2 name=submit2></td>
  </tr>
  </table>
  </form>
  <%}%>