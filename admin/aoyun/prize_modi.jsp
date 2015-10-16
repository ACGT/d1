<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
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
String id="";
if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
{
	   id=request.getParameter("id");
}
if("post".equals(request.getMethod().toLowerCase()))   
{
	String mbruid=request.getParameter("mbruid");
  	String content=request.getParameter("content");
  	String typeid=request.getParameter("typeid");
  	if(mbruid!=null&&mbruid.length()==0)
  	{
  		Tools.outJs(out, "会员名不能为空！", "back");
  	    return;
  	}
  	if(content!=null&&content.length()==0)
  	{
  		Tools.outJs(out, "中奖信息不能为空！", "back");
  	    return;
  	}
	AYPrize ayp=(AYPrize)Tools.getManager(AYPrize.class).get(id);
	ayp.setPrize_muid(mbruid);
	ayp.setPrize_content(content);
	ayp.setPrize_type(Tools.parseInt(typeid));
	if(Tools.getManager(AYPrize.class).update(ayp,false))
      {
      	Tools.outJs(out, "修改中奖信息成功", "");
      }
      else
      {
      	Tools.outJs(out, "修改中奖信息失败", "");
      }
}
%>
<%
AYPrize aypm=(AYPrize)Tools.getManager(AYPrize.class).get(id);
       if(aypm!=null)
       {%>
       <form  name=form1 method=post action="prize_modi.jsp">
        <input type="hidden" id="id" name="id" value="<%= aypm.getId() %>"/>
<table border="1" width="70%" align=center bordercolorlight="#800000" bordercolordark="#FFFF00" cellspacing="0" bordercolor="#FFFFFF"  cellpadding="1" bgcolor="#000000">
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" height="20" colspan=2><font color="#333333"><b>修改抽奖信息  </b></font></td>    
  </tr>
  <tr bgcolor="#FDEBEB" align="center">
  <td width="18%" bgcolor="#F5F5F5" class="main">会员登陆名：</td>
    <td width="82%" align=left bgcolor="#F5F5F5" class="main">
    <INPUT type="text" size=30 name=mbruid value="<%=aypm.getPrize_muid() %>">    </td>
  </tr>  
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">中奖信息：</td>
    <td class="main" bgcolor="#F5F5F5" align=left>
    <INPUT type="text" size=60 name=content  value="<%=aypm.getPrize_content()%>">  </td>
  </tr>  
  <tr bgcolor="#FDEBEB" align="center">
  <td class="main" bgcolor="#F5F5F5">中奖类型：</td>
    <td class="main" bgcolor="#F5F5F5" align=left><SELECT  name=typeid class=input>
      <option value="1" <%if (aypm.getPrize_type() ==1){ out.print("selected");}%>>T恤</option>
	   <option value="0" <%if (aypm.getPrize_type() ==1){ out.print("selected");}%>>免单</option>

    </select></td>
  </tr>  
 
    
  
  <tr bgcolor="#FDEBEB" align="center">   
    <td class="main" height="20" colspan=2><INPUT type="submit" value=" 提 交 " id=submit2 name=submit2></td>
  </tr>
  </table>
  </form>
  <%}%>