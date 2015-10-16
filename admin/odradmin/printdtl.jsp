<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkshop.jsp"%><%!

public static List<OrderItemBase> getOdrdtlOrderId(String orderId,String shopCode){
	if(Tools.isNull(orderId)) return null;
	List<OrderItemBase> itemList = new ArrayList<OrderItemBase>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrdtl_odrid", orderId));
	listRes.add(Restrictions.eq("odrdtl_shopcode", shopCode));
	//listRes.add(Restrictions.eq("odrdtl_shipstatus", new Long(0)));
	//listRes.add(Restrictions.eq("odrdtl_purtype", new Long(0)));
	
	List<BaseEntity> list =  Tools.getManager(OrderItemCache.class).getList(listRes, null, 0, 500);

	if(list != null && list.size()>0){
	for(BaseEntity be:list){
		itemList.add((OrderItemBase)be);
	}
	}


	List<BaseEntity> list2 =  Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 500);
	if(list2 == null || list2.size()==0) return null;
	for(BaseEntity be:list2){
		itemList.add((OrderItemBase)be);
	}
	return itemList;
}

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>发货单打印</title>
<style>
body{color:black;font-size:9pt}
table{font-size:9pt}
input{font-size:9pt}
A{color:blue;text-decoration:none}
A:Hover{color:red;text-decoration:underline}
</style>
<style type="text/css">
<!--
img{ border:0;}
tr,td{ line-height:21px;}
.STYLE1 {
	font-size: 14;
	font-weight: bold;
}
.STYLE2 {font-size: 14}
.STYLE3 {font-size: 16px}
-->
</style>
</head>
<body OnLoad="javascript:window.print();" bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
String odrid=request.getParameter("odrid");
String shopCode=session.getAttribute("shopcodelog").toString();

OrderBase odrbase=(OrderCache)Tools.getManager(OrderCache.class).get(odrid);

if(odrbase==null){
	odrbase=(OrderMain)Tools.getManager(OrderMain.class).get(odrid);
}
ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopCode);
if(odrbase!=null&&(odrbase.getOdrmst_orderstatus()==1||odrbase.getOdrmst_orderstatus()==2)
&&odrbase.getOdrmst_sndshopcode().equals(shopCode)){

List<OrderItemBase> odritemlist=getOdrdtlOrderId(odrid,shopCode);
if (odritemlist!=null){
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String path = request.getContextPath();
%>
<script language="javascript"> 
                function printsetup()  { 
                        web.execwb(8,1); // 打印页面设置 
                } 
                function printpreview()  { 
                        web.execwb(7,1); //打印页面预览
                } 
              /*  function copyToClipBoard()  { 
                        var clipBoardContent=""; 
                        clipBoardContent+=document.title; 
                        clipBoardContent+="\n"; 
                        clipBoardContent+=this.location.href; 
                        window.clipboardData.setData("Text",clipBoardContent); 
                        alert("复制成功，粘贴即可！"); 
                } */
</script>
<!--<div class="msg" id="webprint" align="center">
<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" id="web" name="web" height="0" width="0"></OBJECT> 
<input type="button" value="  打印       " onclick="javascript:window.print();" />
  <input type="button" value="页面设置 [ IE ]" onclick="javascript:printsetup();" /> 
<input type="button" value="打印预览 [ IE ]" onclick="javascript:printpreview();" />
<input type="button" value="复制本文链接和标题到剪贴板 [ IE ]" onclick="copyToClipBoard()" />
</div>-->
<table width="649" height="978"border="0" align="center" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%"   border="0" align="center" cellpadding="0" cellspacing="0">
	 <tr>
    <td width="23%"></td>
    <td width="47%" height="10"></td>
    <td width="30%"></td>
  </tr>
   <tr>
    <td width="23%">
    <%if ("14031201".equals(shopCode)){%>
    <img src="http://images.d1.com.cn/wap/chuhe2.png"  />
    <%}else{%>
    <img src="http://images.d1.com.cn/images2013/d1-logo.png" width="120" height="40" />
    <%} %>
    </td>
    <td width="47%" height="90" valign="middle" align="center" class="STYLE3">
    <%if (!"14031201".equals(shopCode)){%>发货商户<%}%><%=shpmst.getShpmst_shopname() %></td>
    <td width="30%" align="right"  ><span style="font-size:10pt;padding-bottom:16px;"><strong><%=odrid%></strong></span>&nbsp;</tr>
  <tr>
    <td colspan="3"><table width="649" height="112" border="0" cellpadding="0" cellspacing="1" bgcolor="#000000">
      
      <tr>
        <td width="24" rowspan="3" align="center" bgcolor="#FFFFFF">收<br />
货<br />
人<br />
信<br />
息</td>
        <td width="86" height="27" align="center" bgcolor="#FFFFFF">收货人</td>
        <td width="123" align="center" bgcolor="#FFFFFF"><%=odrbase.getOdrmst_rname() %></td>
        <td width="70" align="center" bgcolor="#FFFFFF">收货人电话</td>
        <td width="124" align="center" bgcolor="#FFFFFF"><%=odrbase.getOdrmst_rphone() %></td>
        <td width="215" colspan="2" rowspan="2" align="center" bgcolor="#FFFFFF">
		 <img src="/CreateBarCode?msg=<%=odrid%>&type=CODE39&checkCharacter=n&checkCharacterInText=n" height="50px" width=180px/><!-- 条码 -->
<%//=odrid %></td>
        </tr>
      <tr>
        <td height="27" align="center" bgcolor="#FFFFFF">送货方式</td>
        <td align="center" bgcolor="#FFFFFF"><strong><%=odrbase.getOdrmst_shipmethod()%></strong></td>
        <td align="center" bgcolor="#FFFFFF">到达城市</td>
        <td align="center" bgcolor="#FFFFFF"><%=odrbase.getOdrmst_rprovince()+odrbase.getOdrmst_rcity() %></td>
        </tr>
      <tr>
        <td height="35" align="center" bgcolor="#FFFFFF">收货人地址</td>
        <td colspan="5" bgcolor="#FFFFFF">&nbsp;&nbsp;<%=odrbase.getOdrmst_raddress() %></td>
        </tr>
    </table>
    <table width="100%"   border="0" cellpadding="0" cellspacing="1" bgcolor="#000000">
	
      <tr>
        <td width="24"  align="center" bgcolor="#FFFFFF">订<br />
购<br />
信<br />
息</td>
        <td height="27" align="center" nowrap="nowrap" bgcolor="#FFFFFF">序号</td>
        <td height="58" align="center" nowrap="nowrap" bgcolor="#FFFFFF">编码</td>
        <td width="100" align="center" nowrap="nowrap" bgcolor="#FFFFFF">商品条码</td>
        <td width="55" align="center" nowrap="nowrap" bgcolor="#FFFFFF">发货数量</td>
        <td width="229" align="center" bgcolor="#FFFFFF">商品名称</td>
        <td width="40" align="center" nowrap="nowrap" bgcolor="#FFFFFF">成交价</td>
        <td width="46" align="center" nowrap="nowrap" bgcolor="#FFFFFF">发货金额</td>
        </tr>
<%//int dtlnum= odritemlist.size();
double allgdsmoney=0f;
int allgdscount=0;
int j=1;
for(OrderItemBase itemb:odritemlist){
Product product=(Product)Tools.getManager(Product.class).get(itemb.getOdrdtl_gdsid());
//If rsdtl("gdsmst_glassflag")=1    gdsglasstxt="(玻璃品)"

String gdsname=itemb.getOdrdtl_gdsname();
if(product.getGdsmst_glassflag()!=null&&product.getGdsmst_glassflag().longValue()==1){
	gdsname=gdsname+"(玻璃品)";
}
if(!Tools.isNull(product.getGdsmst_skuname1())){
	gdsname=gdsname+"-"+product.getGdsmst_skuname1()+":"+itemb.getOdrdtl_sku1();
}
System.out.println(gdsname);
Random r = new Random();
String rom ="000"+ r.nextInt(999)+"";//加一个随机数
rom=rom.substring(rom.length()-3,rom.length());
String stocks="0000"+product.getGdsmst_stock();
stocks=stocks.substring(stocks.length()-4,stocks.length());
gdsname=gdsname+"<strong>("+rom+stocks+")</strong>";
allgdsmoney=allgdsmoney+ itemb.getOdrdtl_finalprice().doubleValue()*itemb.getOdrdtl_gdscount().longValue();
allgdscount=allgdscount+itemb.getOdrdtl_gdscount().intValue();
		%>
      <tr>
        <td width="27" height="13%" align="center" nowrap="nowrap" bgcolor="#FFFFFF"></td>
        <td width="27" height="13%" align="center" nowrap="nowrap" bgcolor="#FFFFFF"><%=j %></td>
        <td width="58" align="center" nowrap="nowrap" bgcolor="#FFFFFF"><%=itemb.getOdrdtl_gdsid()%></td>
        <td width="100" align="center" style="word-wrap: break-word;word-break:break-all; " nowrap="nowrap" bgcolor="#FFFFFF"><strong>
          <%=product.getGdsmst_barcode() %></strong></td>
        
        <td width="55" align="center" nowrap="nowrap" bgcolor="#FFFFFF" style="font-size:11pt;"><strong>
          <%=itemb.getOdrdtl_gdscount() %></strong></td>
        <td width="229" align="center" bgcolor="#FFFFFF"><%=gdsname%></td>
        <td width="40" align="center" nowrap="nowrap" bgcolor="#FFFFFF"><%=Tools.getDouble(itemb.getOdrdtl_finalprice().doubleValue(), 1) %></td>
        <td width="46" align="center" nowrap="nowrap" bgcolor="#FFFFFF"><%=("￥"+Tools.getDouble(itemb.getOdrdtl_finalprice().doubleValue()*itemb.getOdrdtl_gdscount().longValue(), 1)+"元") %></td>
        </tr>
		<%}%>
      <tr>
        <td width="24" height="6%" align="center" nowrap="nowrap" bgcolor="#FFFFFF">合计</td>
        <td width="27" align="center" nowrap="nowrap" bgcolor="#FFFFFF"></td>
        <td width="58" align="center" nowrap="nowrap" bgcolor="#FFFFFF"></td>
        <td width="100" align="center" nowrap="nowrap" bgcolor="#FFFFFF"></td>
		
        <td width="55" align="center" nowrap="nowrap" bgcolor="#FFFFFF" style="font-size:11pt;"><strong><%=allgdscount%></strong></td>
        <td width="229" align="center" bgcolor="#FFFFFF"></td>
        <td width="40" align="center" nowrap="nowrap" bgcolor="#FFFFFF"></td>
        <td width="46" align="center" nowrap="nowrap" bgcolor="#FFFFFF">￥<%=Tools.getDouble(allgdsmoney, 1) %>元</td>
        </tr>
      <tr>
        <td height="18%" colspan="8" bgcolor="#FFFFFF"><table width="100%"  height="35" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>&nbsp;&nbsp;配送费：￥<%=odrbase.getOdrmst_shipfee() %>元</td>
            <td>&nbsp;e券使用：￥<%=odrbase.getOdrmst_tktvalue() %>元</td>
            <td>预存款支付：￥<%=odrbase.getOdrmst_prepayvalue()%>元</td>
            <td align="right">&nbsp;应付款：￥<strong><%=Tools.getDouble(allgdsmoney+odrbase.getOdrmst_shipfee().doubleValue(), 1)%></strong>元&nbsp;&nbsp;</td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="4%" colspan="3">&nbsp;</td>
  </tr>
  
  <tr>
    <td height="4%" colspan="3">&nbsp;&nbsp;配货人：</td>
  </tr>
</table></td>
  </tr>
  <tr>
    <td valign="bottom">

	</td>
  </tr>
  <tr><td height="104" align="right" valign="bottom">
</td>
  </tr>
</table>
<%
j=j+1;
}
}
%>

</body>
</html>