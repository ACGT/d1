<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚品牌馆</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/brand.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>

<body style="font-size:12px">
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<!-- 中部开始 -->
<center>

<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
	    <td height="8"><img src="http://images.d1.com.cn/images2011/brand/brandhead_3[1].jpg" /></td>
	    </tr>
	  <tr>
	    <td height="43" background="http://images.d1.com.cn/images2011/brand/brandhead2.jpg">
		<table width="950" align="center" border="0" cellspacing="0" cellpadding="0"  id="secTable">
      <tr>
        <td class="brandnav brandcurr"  onclick="secBoard(0)">全部品牌</td>
        <td class="brandnav"  onclick="secBoard(1)">欧美化妆品</td>
        <td class="brandnav"  onclick="secBoard(2)">日韩化妆品</td>
        <td class="brandnav"  onclick="secBoard(3)">国货化妆品</td>
        <td class="brandnav"  onclick="secBoard(4)">香水品牌</td>
        <td class="brandnav"  onclick="secBoard(5)">珠宝饰品</td>
        <td class="brandnav"  onclick="secBoard(6)">女装鞋包</td>
        <td class="brandnav"  onclick="secBoard(7)">名表奢品</td>
        <td class="brandnav"  onclick="secBoard(8)">男装皮具</td>
        <td class="brandnav"  onclick="secBoard(9)">创意生活</td>
      </tr>
    </table>
	<script   type="text/javascript">
function  secBoard(n)
{

	  
	  var secTable=document.getElementById("secTable");
  var mainTable=document.getElementById("mainTable");
      //取对象最好用 document.getElementById('secTable');
      for(i=0;i<secTable.rows[0].cells.length;i++) //cells是td，rows是tr
        secTable.rows[0].cells[i].className="brandnav";
      secTable.rows[0].cells[n].className="brandnav brandcurr";
      for(i=0;i<mainTable.tBodies.length;i++) //这里也一样，不过用FF试了试居然可以
        mainTable.tBodies[i].style.display="none";
      mainTable.tBodies[n].style.display="block";  


}
</script>
		</td>
	    </tr>
	 
    </table>
<table  border="0"  cellpadding="0"  id="mainTable">
  <tbody  style="display:block;">
    <tr>
      <td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr>
          <td height="8"></td>
        </tr>
        <tr>
          <td height="38" class="ppbg"><a name = "hzp"></a><h1>化妆品</h1><span>Cosmetics</span></td>
        </tr>
        <tr>
          <td height="8"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/02.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"><ul>
			      <%  request.setAttribute("code", "1746");%>
			<jsp:include   page= "getbrand.jsp"   />   
			  
			    </ul></div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/03.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1">
			       <%  request.setAttribute("code", "2143");%>
			<jsp:include   page= "getbrand.jsp"   />   
			    </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/04.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1">  <%  request.setAttribute("code", "2144");%>
			<jsp:include   page= "getbrand.jsp"   />   </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/05.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1">  <%  request.setAttribute("code", "2169");%>
			<jsp:include   page= "getbrand.jsp"   />   </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
          </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"></td>
        </tr>
        <tr>
          <td height="38" class="ppbg"><a name = "lxfs"></a><h1>流行服饰</h1>
              <span>Clothing</span></td>
        </tr>
        <tr>
          <td height="8"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			     <td colspan="3"><a name = "clsp"></a><img src="http://images.d1.com.cn/images2011/brand/2271_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2271");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2272_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2272");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><a name = "wcloth"></a><img src="http://images.d1.com.cn/images2011/brand/2267_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2267");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2268");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
          </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"></td>
        </tr>
        <tr>
          <td height="38" class="ppbg"><a name = "nsjp"></a><h1>男士精品</h1>
              <span>Skyman</span></td>
        </tr>
        <tr>
          <td height="8"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			     <td colspan="3"><a name = "watch"></a><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[4].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2291");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><a name = "cloth"></a><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[1].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2292");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[2].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2289");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><a name = "cyjj"></a><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[3].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2290");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
          </table></td>
        </tr>
      </table>
	  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/02.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"><ul> <%  request.setAttribute("code", "1746");%>
			<jsp:include   page= "getbrand.jsp"   /> </ul></div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			</table>
			  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/03.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2143");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr> 
		  </table>
			  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>	
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/04.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2144");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr> 
		</table>
		  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/05.gif"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2169");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
		  </table>
			  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		 <tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2271_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2271");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2272_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2272");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr> 
		  </table>
		    </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2267_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2267");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang.gif" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2268");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr> 
		  </table>
			  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[4].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2291");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>  
		  </table>
			  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[1].jpg" width="980" height="77"/></td>
			</tr>
		<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2292");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
			<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[2].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2289");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
		</table>
			  </td>
    </tr>
  </tbody>
		<tbody  style="display:none;">
    <tr>
      <td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			     <td colspan="3"><img src="http://images.d1.com.cn/images2011/brand/2268_mwang[3].jpg" width="980" height="77"/></td>
			</tr>
			<tr>
			     <td width="2%">&nbsp;</td>
              <td width="96%">
			    <div class="listbrand1"> <%  request.setAttribute("code", "2290");%>
			<jsp:include   page= "getbrand.jsp"   /> </div>			 </td>
              <td width="2%">&nbsp;</td>
			</tr>
		  </table>
		  </td>
    </tr>
  </tbody>
	</table>
	  </td>
  </tr>
</table>
</center>
<!-- 中部结束 -->
<%@include file="/inc/foot.jsp"%>
</body>
</html>