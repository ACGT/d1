<%@ page contentType="text/html; charset=GBK"%>
<%!
/*public static ArrayList<Promotion> getBrandListByCode(String code , int count){
	if(!Tools.isMath(code)) return null;
	if(count <= 0) count = 100;
	ArrayList<Promotion> list = new ArrayList<Promotion>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("splmst_code", new Long(code)));
	List<BaseEntity> b_list = Tools.getManager(Promotion.class).getList(clist, null, 0, count);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Promotion)be);
		}
	}
	return list ;
}*/
%>
<%
String strad3="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+(request.getParameter("subad")==null?subad:request.getParameter("subad"))+"&url=";
 %>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f1f1f1">
  <tr >
    <td height="10" bgcolor="#FFFFFF"></td>
  </tr>
  <tr >
    <td height="10" bgcolor="#FFFFFF"><img src="http://images.d1.com.cn/images2015/mail/email-bottom.jpg" width="750" height="89" border="0" usemap="#Maptail" /></td>
  </tr>
  <tr>
    <td align="center"><img src="http://images.d1.com.cn/zt2012/mail/tail2.jpg" width="750" height="84" /></td>
  </tr>
  
  <tr>
    <td align="center"><table width="720" height="69" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><span style="font-size:13px;color:#595959;line-height:20px;">&nbsp;<img src="http://images.d1.com.cn/zt2012/mail/mailhead_t.gif" />收到此邮件说明您已是D1优尚尊贵的用户。<br />
如果您不愿意继续接收来自D1优尚的促销类邮件，请点击<a href="<%=strad3 %>http://www.d1.com.cn/html/bademail.jsp" style="color:#595959;text-decoration:none;font-weight:bold;">退订促销邮件</a>。<br />
商品价格及促销内容如有调整，以D1优尚网最终页面为准。
</span></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="60" align="center"><table width="700" height="46" border="0" cellpadding="0" cellspacing="0" style="
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #E7E7E7;">
      <tr>
        <td align="right" valign="bottom"><img src="http://images.d1.com.cn/zt2012/mail/mail_tail_1.gif" width="113" height="37" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</center>