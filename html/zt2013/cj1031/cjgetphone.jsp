<%@ page contentType="text/html; charset=GBK"%><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/newlogin/validate.js?"+System.currentTimeMillis())%>"></script>
<table width="450" height="300" border="0" cellpadding="0" cellspacing="0" bgcolor="#D70B52">
  <tr>
    <td height="95" class="cjboxt"><img src="http://images.d1.com.cn/zt2013/cj1311/logo11.jpg" width="135" height="79" />手机验证</td>
  </tr>
  <tr>
    <td height="80"><table width="450" height="80" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="319" rowspan="2" align="center" class="cjboxtxt">请输入手机号
          <input type="text" id="txtRPhone" maxlength="11" onblur="CheckPhone(this.value,0)" onkeyup="this.value=this.value.replace(/[^\d]/g,'');CheckPhone2(this.value);" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "  /><br />
		  请输入验证码
		  <input name="txtcode"  id="txtcode" type="text" size="18" /></td>
        <td width="131" align="center" class="cjboxtxt"><input type="image" name="imageField" onclick="checktime(this)" src="http://images.d1.com.cn/zt2013/cj1311/2.png" />
          </td>
      </tr>
      <tr>
        <td align="center" class="cjboxtxt"><div id="div_Checkcodemsg"></div></td>
      </tr>
      
    </table>    </td>
  </tr>
  <tr>
    <td align="right" valign="bottom">&nbsp;<a href="javascript:getupphone();"><img src="http://images.d1.com.cn/zt2013/cj1311/next.png" width="119" height="45" /></a></td>
  </tr>
</table>

<script type="text/javascript">

function getupphone(){
	var strRPhone = $.trim($('#txtRPhone').val());
	var v=$.trim($("#txtcode").val());
	if(valitele && valis_code()){
		  $.ajax({
				type: "get",
				dataType: "json",
				url: '/newlogin/validatetel.jsp',
				cache: false,
				data: {tel:strRPhone,code:v,rec_act:"valicode"},
				error: function(XmlHttpRequest){
					alert("获取验证码错误！");
				},success: function(json){
					if(json.success){
						$.load("提示",480,"myprize.jsp");
					}else{
						$('#div_Checkcodemsg').html(' <span style="color:#ff0000"> '+json.message+' </span>');
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
	}
}
</script>