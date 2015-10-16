<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 240*300*4/行春节模板 -->
<dl style="width:240px;height:300px;padding-left:4px;">
 <dd>
  <table width="240" height="300" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="240" height="250" colspan="3">
    <a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank" title="<%= p.getGdsmst_gdsname()%>">
	<div class="imgdp250" style="background-image: url(<%= !Tools.isNull(p.getGdsmst_img200250())&&p.getGdsmst_img200250().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_img200250())?"":p.getGdsmst_img200250()%>);">
	<span class="imgdpt"><% out.print(Tools.substring(Tools.clearHTML(p.getGdsmst_gdsname()),60));  %>
	</span>
	</div>
	</a>
	</td>
  </tr>
  <tr bgcolor="#6d0609">
    <td width="85"><span class="STYLE1">抢购价￥</span></td>
    <% long memprice=p.getGdsmst_memberprice().longValue();
	if(getmsflag(p)){
	memprice=p.getGdsmst_msprice().longValue();
	}%>
    <td width="60" rowspan="2" align="left"><span class="STYLE2"><%= memprice%></span></td>
    <td width="95" rowspan="2" align="left">
    	<a href="http://www.d1.com.cn/Product/<%= p.getId() %>" target="_blank">
    		<img src="http://images.d1.com.cn/zt2013/20140109/dangjiqiangx.jpg"/>
    	</a>
    </td>
  </tr>
  <tr bgcolor="#6d0609">
    <td width="90"><span class="STYLE3"><s>市场价￥<%= p.getGdsmst_saleprice().longValue() %></s></span></td>
  </tr>
</table>
  </dd>
</dl>