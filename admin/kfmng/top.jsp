<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkkfmng.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {
	font-size: 12px;
	color: #FFFFFF;
}
.STYLE2 {font-size: 9px}
.STYLE3 {
	color: #033d61;
	font-size: 12px;
}
-->
</style></head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="70" background="http://images.d1.com.cn/manage/main_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" height="24" background="http://images.d1.com.cn/manage/main_03.gif">&nbsp;</td>
            <td width="505" background="http://images.d1.com.cn/manage/main_04.gif">&nbsp;</td>
            <td>&nbsp;</td>
            <td width="21"><img src="http://images.d1.com.cn/manage/main_07.gif" width="21" height="24"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" height="38"><img src="http://images.d1.com.cn/manage/main_09.jpg" width="17" height="38"></td>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="77%" height="25" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="44" height="19"><div align="center"></div></td>
                    <td width="44"><div align="center"></div></td>
                    <td width="44"><div align="center"></div></td>
                    <td width="44"><div align="center"></div></td>
                    <td width="70"><div align="center"></div></td>
                    <td width="223"><div align="center"></div></td>
                    <td width="229"><div align="center"><span class="STYLE1"><span class="STYLE2">■</span> 管理员：<%=session.getAttribute("dfadmin") %>您好</span></div></td>
                    <td width="94"><a href="Logout.jsp"><img src="http://images.d1.com.cn/manage/main_20.gif" width="48" height="19"></a><img src="http://images.d1.com.cn/manage/main_21.gif" width="26" height="19"></td>
                  </tr>
                </table></td>
                <td width="220" valign="bottom"  nowrap="nowrap"><div align="center"></div><div align="right"><span class="STYLE1"><span class="STYLE2">■</span> 今天是：<%
                		SimpleDateFormat sftop=new SimpleDateFormat("yyyy年MM月dd日");
                out.print(sftop.format(new Date()));
                %></span></div></td>
              </tr>
            </table></td>
            <td width="21"><img src="http://images.d1.com.cn/manage/main_11.gif" width="21" height="38"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="8" style=" line-height:8px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" background="http://images.d1.com.cn/manage/main_29.gif" style=" line-height:8px;">&nbsp;</td>
            <td width="505" background="http://images.d1.com.cn/manage/main_30.gif" style=" line-height:8px;">&nbsp;</td>
            <td style=" line-height:8px;">&nbsp;</td>
            <td width="21" style=" line-height:8px;"><img src="http://images.d1.com.cn/manage/main_31.gif" width="21" height="8"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="28" background="http://images.d1.com.cn/manage/main_36.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="177" height="28" background="http://images.d1.com.cn/manage/main_32.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"  height="22">&nbsp;</td>
            <td width="59%" valign="bottom"><!--<div align="center" class="STYLE1">当前用户：Admin</div>--></td>
            <td width="21%">&nbsp;</td>
          </tr>
        </table></td>
        <td>&nbsp;<!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="65" height="28"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="23" valign="bottom">
                <table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"> <div align="center" class="STYLE3">业务中心</div></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">系统管理</div></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">通讯录</div></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">数据管理</div></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">统计报表</div></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">业务管理</div></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">系统配置</div></td>
              </tr>
            </table></td>
            <td width="3"><img src="http://images.d1.com.cn/manage/main_34.gif" width="3" height="28"></td>
            <td width="63"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(http://images.d1.com.cn/manage/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"><div align="center" class="STYLE3">升级维护</div></td>
              </tr>
            </table></td>
            <td>&nbsp;</td>
          </tr>
        </table>--></td>
        <td width="21"><img src="http://images.d1.com.cn/manage/main_37.gif" width="21" height="28"></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
