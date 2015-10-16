<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "taobao_order");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}




//淘宝订单查询简易后台...
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date edate = new Date();

Calendar c = Calendar.getInstance();
c.set(Calendar.HOUR_OF_DAY, 0);
c.set(Calendar.MINUTE, 0);
c.set(Calendar.SECOND, 0);
Date sdate = new Date(c.getTimeInMillis());

List<BaseEntity> list = null ;

if("post".equals(request.getMethod().toLowerCase())){
	
	Date sdate123 = sdf.parse(request.getParameter("sdate")); 
	Date edate123 = sdf.parse(request.getParameter("edate"));
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.ge("createdate", sdate123));
	clist.add(Restrictions.le("createdate", edate123));
	
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("createdate"));
	
	int length =  Tools.getManager(OrderTaobao.class).getLength(clist);
	list = Tools.getManager(OrderTaobao.class).getList(clist, olist, 0, length);
}


%><form method=post>
开始日期：<input type=text name="sdate" value="<%=sdf.format(sdate)%>"/><br/>
结束日期：<input type=text name="edate" value="<%=sdf.format(edate)%>"/><br/>
<input type=submit value="查询"/>
</form><br/>
<table border=1 width=80% align=center>
<tr><td>日期</td><td>淘宝订单号</td><td>d1订单号</td><td>订单支付金额</td><td>运费</td></tr>
<%
float totalMoney=0,totalShipFee = 0;
int totalTrades = 0 ;
if(list!=null){
	for(BaseEntity be:list){
		totalTrades++;
		OrderTaobao ot = (OrderTaobao)be;
		OrderBase ob = OrderHelper.getById(ot.getD1OrderId());
		totalMoney+=ob.getOdrmst_acturepaymoney();
		totalShipFee+=ob.getOdrmst_shipfee();
		%>
		<tr><td><%=ot.getCreatedate()%></td><td><%=ot.getTaobaoOrderId()%></td><td><%=ot.getD1OrderId()%></td><td><%=Tools.getDouble(ob.getOdrmst_acturepaymoney(),2)%></td><td><%=ob.getOdrmst_shipfee()%></td></tr>
		<%
	}
}
%>
<tr><td colspan=5 align=right>小计：订单总数=<%=totalTrades %>&nbsp;&nbsp;&nbsp;&nbsp;订单总支付金额=<%=totalMoney%>&nbsp;&nbsp;&nbsp;&nbsp;总运费=<%=totalShipFee%></td></tr>
</table>