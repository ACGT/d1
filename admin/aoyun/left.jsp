<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%>
<html>
<head>
<title>Sell_left</title>
<style>
td {
	font-size:12px;
}
.f_b {font-weight:bold;}
</style>

<base target="rtop">
</head>

<body>

<table width="190" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="25" colspan="2" align="center" bgcolor="#F8D6D8">奥运问题查询 </td>
  </tr>
  <tr>
    <td height="25" colspan="2" align="center" bgcolor="#FFFFFF" >
    <a href="qus_add.jsp" target="rtop" >添加奥运问题</a> </td>
  </tr>
  <form name="form2" method="post" action="qus_list.jsp">
    <tr>
      <td height="24" align="center" bgcolor="#00CCCC">问题：</td>
      <td bgcolor="#FFFFFF"><input name="title" type="text" size="16"></td>
    </tr>
    <tr>
      <td height="24" align="center" bgcolor="#00CCCC">显示时间</td>
      <td bgcolor="#FFFFFF"><input name="qtime" type="text" size="16"></td>
    </tr>
    <tr>
      <td width="68" height="24" align="center" bgcolor="#00CCCC">是否有效：</td>
      <td width="119" bgcolor="#FFFFFF"><SELECT id=flag name=flag class=input>
        <OPTION value="1" selected="selected">是 
          <OPTION VALUE="0">否
      </select></td>
    </tr>
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#F8D6D8"><input type="submit" name="tj2222" value=" 查 询 "></td>
    </tr>
  </form>
</table>

<br>
<br>

<table width="190" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="25" colspan="2" align="center" bgcolor="#F8D6D8">中奖信息</td>
  </tr>
   <tr>
    <td height="25" colspan="2" align="center" bgcolor="#FFFFFF" >
    <a href="prize_add.jsp" target="rtop" >添加中奖信息</a> </td>
  </tr>
  <form name="form2" method="post" action="prize_list.jsp">
    <tr>
      <td height="25" align="center" bgcolor="#00CCCC">会员名</td>
      <td bgcolor="#FFFFFF"><input name="mbruid" type="text" size="16"></td>
    </tr>
    <tr>
      <td height="25" align="center" bgcolor="#00CCCC">信息</td>
      <td bgcolor="#FFFFFF"><input name="content" type="text" size="16"></td>
    </tr>
    <tr>
      <td height="25" align="center" bgcolor="#00CCCC">类型</td>
      <td bgcolor="#FFFFFF"><SELECT id=typeid name=typeid class=input>
        <OPTION value="1" selected="selected">免单 
          <OPTION VALUE="0">T恤
      </select></td>
    </tr>
    
    
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#F8D6D8"><input type="submit" name="tj2223" value=" 查 询 "></td>
    </tr>
  </form>
</table>

<br>

<table width="190" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="25" colspan="2" align="center" bgcolor="#F8D6D8">回答奥运问题查询</td>
  </tr>
  <form name="form2" method="post" action="ans_list.jsp">
     <tr>
      <td width="68" height="24" align="center" bgcolor="#00CCCC">问题ID：</td>
      <td width="119" bgcolor="#FFFFFF"><input name="qusid" type="text" size="16"></td>
    </tr>
    <tr>
      <td height="25" align="center" bgcolor="#00CCCC">答案</td>
      <td bgcolor="#FFFFFF"><input name="ans" type="text" size="16"></td>
    </tr>
    <tr>
      <td height="25" align="center" bgcolor="#00CCCC">会员号</td>
      <td bgcolor="#FFFFFF"><input name="mbrid" type="text" size="16"></td>
    </tr>
    
    
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#F8D6D8"><input type="submit" name="tj222" value=" 查 询 "></td>
    </tr>
  </form>
</table>


</body>
</html>