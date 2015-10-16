<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "sg_admin");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/res/js/manage/manage.js"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/swfobject.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/uploadify/jquery.uploadify.v2.1.4.js")%>"></script>
<title>闪购添加</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.sctpk{margin-top:5px; margin-left:20px; font-size:12px;}
.STYLE1 {font-size: 12px}
.STYLE3 {font-size: 12px; font-weight: bold; }
.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
-->
</style>
<script type="text/javascript">
function checkgdsid(t){
	var gdsid=$("#req_gdsid").val();
    $.ajax({
            type: "POST",
            dataType: "json",
            url: "/admin/ajax/getgdsinfo.jsp",
            data:{gdsid: gdsid},
            success: function(json) {
            	if(json.success){
            	$("#req_gdsname").val(json.gname);
            	   if(json.gimg!=""){
            	    $('#spzt6').html('');
				     $('#spzt6').append("<img src='"+json.gimg+"' width=\"60\" height=\"60\" style=\"float:left;\"/>");
				     $("#sgflag").val(1);
            	   }else{
            		   $("#gdserr").html("商品里不存在闪购310的图片请从新上传");
            	   }
            	}else{
            	$("#gdserr").html(json.message);
            	}
            }

            });
    
}
</script>

</head>

<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" background="http://images.d1.com.cn/manage/tab_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="30"><img src="http://images.d1.com.cn/manage/tab_03.gif" width="12" height="30" /></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="46%" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%"><div align="center"><img src="http://images.d1.com.cn/manage/tb.gif" width="16" height="16" /></div></td>
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：[闪购管理]-[添加新闪购]</td>
              </tr>
            </table></td>
            <td width="54%">&nbsp;</td>
          </tr>
        </table></td>
        <td width="16"><img src="http://images.d1.com.cn/manage/tab_07.gif" width="16" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="8" background="http://images.d1.com.cn/manage/tab_12.gif">&nbsp;</td>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6">
        <!--  onmouseover="changeto()"  onmouseout="changeback()" -->
          <tr>
            <td height="22" colspan="7" background="http://images.d1.com.cn/manage/bg.gif" bgcolor="#FFFFFF"><div align="center">
                        </td>
            </tr>
          <tr>
            <td width="1%" height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td width="8%" height="28" bgcolor="#FFFFFF">商品ID：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><input type="hidden"  value="" id="id" name="id"  /><input type="hidden" value="0"   id="req_realbuynum" /><input type="text" name="req_gdsid" id="req_gdsid" onblur="checkgdsid(this)" />
            <span id="gdserr" style="color:red;font-size:12px;"></span>
            </td>
            <td width="10%" bgcolor="#FFFFFF">商品名称：</td>
            <td width="54%" height="28" colspan="2" bgcolor="#FFFFFF"><input name="req_gdsname" type="text" id="req_gdsname" size="50" /></td>
            </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" bgcolor="#FFFFFF">闪购分类：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><select name="req_cls" id="req_cls">
              <option value="1" selected>美妆区</option>
              <option value="2">男人区</option>
              <option value="3">女人区</option>
              <option value="4">生活区</option>
               <option value="5">重磅推荐</option>
               <option value="6">整点秒杀</option>
               <option value="7">限购专区</option>
            </select></td>
            <td bgcolor="#FFFFFF">闪购图片：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF">
            <div id="fileQueue6" class="sctpk" style="float:left;">
        	     <input type="file" name="sgupload" id="sgupload" /> 
      		   </div>
 <input type="hidden"  value="0" id="sgflag" />
<div id="spzt6"  ></div>
<input type="hidden"  value="" id="hsgimg" />
</td>
          </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" bgcolor="#FFFFFF">闪购系数：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><input type="text" name="req_xsnum" id="req_xsnum" value="15" /></td>
            <td bgcolor="#FFFFFF">闪购虚拟总数：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><input name="req_vallnum" type="text" id="req_vallnum" value="15" size="15" />
              &nbsp;&nbsp;
              人工设置已卖数：
              <input name="req_vusrnum" type="text" id="req_vusrnum" value="0" size="0" /></td>
          </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td bgcolor="#FFFFFF">是否可邮件：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><select name="req_mailflag" id="req_mailflag">
              <option value="0" selected="selected">否</option>
              <option value="1">是</option>
            </select></td>
            <td bgcolor="#FFFFFF">邮件排序：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><input type="text" name="req_mailsort" id="req_mailsort"  value="0" /></td>
            </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" bgcolor="#FFFFFF">最大购买个数：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><input type="text" name="req_maxnum" id="req_maxnum" value="200"  />
              </td>
            <td bgcolor="#FFFFFF">排序：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><input type="text" name="req_sort" id="req_sort"  value="0" /></td>
          </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" bgcolor="#FFFFFF">是否显示：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><select name="req_status" id="req_status">
              <option value="0" selected>不显示</option>
               <option value="1">显示</option>
            </select></td>
            <td bgcolor="#FFFFFF">备注：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF"><textarea name="req_memo" cols="60" rows="3" id="req_memo"></textarea></td>
          </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" bgcolor="#FFFFFF">所有产品限购：</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF">
	            <select name="req_limitgroup" id="req_limitgroup">
	              <option value="0" selected>不限购</option>
	               <option value="1">限购组1</option>
	               <option value="2">限购组2</option>
	               <option value="3">限购组3</option>
	               <option value="4">限购组4</option>
	               <option value="5">限购组5</option>
	            </select>
            </td>
            <td height="28" colspan="3" bgcolor="#FFFFFF"></td>
          </tr>
          <tr>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" bgcolor="#FFFFFF">&nbsp;</td>
            <td height="28" colspan="2" bgcolor="#FFFFFF">&nbsp;</td>
            <td bgcolor="#FFFFFF">
              <input type="submit" name="button" id="button" value="提交" onclick="sgadminact();"  />
            </td>
            <td height="28" colspan="2" bgcolor="#FFFFFF">&nbsp;</td>
          </tr>
          </table></td>
        <td width="8" background="http://images.d1.com.cn/manage/tab_15.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="35" background="http://images.d1.com.cn/manage/tab_19.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="35"><img src="http://images.d1.com.cn/manage/tab_18.gif" width="12" height="35" /></td>
        <td>&nbsp;</td>
        <td width="16"><img src="http://images.d1.com.cn/manage/tab_20.gif" width="16" height="35" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
<script type="text/javascript">
sgimgact();
</script>
