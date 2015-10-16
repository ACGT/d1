<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
  <html>
  <head>
 <script type="text/javascript" 
 src="http://qzs.qq.com/qzone/openapi/qc.js">
</script>
  </head>
        <body>
            <form id="jumpForm" action="/intf/qqfllogin.jsp" method="post">
                <input type="hidden" name="Acct" value="0000000000000000000000000000B47A" />
                <input type="hidden" name="OpenId" value="0000000000000000000000000000B47A" />
                <input type="hidden" name="LoginFrom" value="caibei" />
                <input type="hidden" name="ClubInfo" value="0" />
                <input type="hidden" name="ViewInfo" value="ShowMsg=QQ%D3%C3%BB%A7%A3%AC%26lt%3Bscript%26gt%3Balert%28%29%26lt%3B%2Fscr&amp;NickName=%26lt%3Bscript%26gt%3Balert%28%29%26lt%3B%2Fscr&amp;CBPoints=100&amp;CBBonus=5%25" />
                <input type="hidden" name="Url" value="http://www.linktech.cn/qq/auto_login/test_moon.php" />
                <input type="hidden" name="Ts" value="20111009094903" />
                <input type="hidden" name="Attach" value="" />
                <input type="hidden" name="Vkey" value="d037ed98fc2a355e176069898b3150af" />
            </form>
            <span id="qqLoginBtn"></span>
        </body>

        <script language="JavaScript">
          //  document.getElementById('jumpForm').submit();
        </script>
        <script type="text/javascript">
QC.Login.insertButton({
	btnId : 'qqLoginBtn',//插入按钮的html标签id
	size : 'A_M',//按钮样式，A、B、C为三种样式， 
		//S、M、L、XL为同一种样式的不同尺寸，支持如下 : 
									//A_S, A_M, A_L, A_XL; 
									//B_S, B_M, B_L; 
									//C_S;

	clientId : '222906',//appId
	scope : '',//授权范围，可选
	redirectURI : '/intf/qqlogin.jsp' // 回调地址，可选
	,'btnMode':'showUserAfterLogin'
});
</script>
        <html>