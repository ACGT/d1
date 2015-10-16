<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkshop.jsp"%><%!
public static  ArrayList<OrderItemBase> getOrderDetail(String odrid){
	ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrdtl_odrid", odrid));

	List<BaseEntity> list2 = Tools.getManager(OrderItemCache.class).getList(listRes, null, 0, 20);
	if(list2==null || list2.size()==0){
	 list2 = Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 20);
	 if(list2==null || list2.size()==0){
			list2 = Tools.getManager(OrderItemRecent.class).getList(listRes, null, 0, 20);
		}
	}
	
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderItemBase)be);
	}
	return list;
}

public static  ArrayList<OrderBase> getShopOrder(String odrid,String shopCode){
	ArrayList<OrderBase> list=new ArrayList<OrderBase>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_sndshopcode", shopCode));
	listRes.add(Restrictions.eq("id", odrid));
	List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 20);
	if(list2==null || list2.size()==0){
	 list2 = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 20);
	 if(list2==null || list2.size()==0){
			list2 = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 20);
		}
	}
	
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderBase)be);
	}
	return list;
}
%>
<%
String odrid=request.getParameter("odrid");
String shopCode=session.getAttribute("shopcodelog").toString();
ArrayList<OrderBase> odrbaselist=getShopOrder(odrid,shopCode);
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
if(odrbaselist!=null&&odrbaselist.size()>=0 ){
		  OrderBase odr=odrbaselist.get(0);
		  ShpMst  shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(odr.getOdrmst_sndshopcode());
	ArrayList<OrderItemBase> odritemlist=getOrderDetail(odrid);
if(odritemlist!=null&&odritemlist.size()>0){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="images/odrlist.css" rel="stylesheet" type="text/css"  />
<title>无标题文档</title>

<style type="text/css">
<!--
.lin {	border: 1px solid #449ae7;
}
.odrt {font-size:14px; font-weight:800; color:#454547;background:#deefff; height:40px; line-height:35px;}
.odrlistt{ background:#f7f7f7; padding-left:12px; color:#333333; line-height:23px;}
.linon {	border-top-width: 1px;
	border-top-style: solid;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: #449ae7;
}
.odrlistt1 {background:#f7f7f7;}
.odrt1 {font-size:14px; font-weight:800; color:#454547; text-align:center; background:#deefff}
.pdl8 {padding-left:8px;}
.spantxt {color:#1566b8}
.text {height:26px; line-height:26px; background-color:#f8f8f8; border:1px solid #d4d4d4;}
.odrdtlm {font-size:14px; font-weight:800; color:#454547;  background:#deefff}
-->
</style>
</head>

<body>
<table width="805" border="0" cellpadding="0" cellspacing="0">
<tr><td colspan="2">
<table width="805" border="0" cellpadding="0" cellspacing="0" class="lin">
  <tr>
    <td width="226" align="center" class="odrt">订单号：<%=odrid %> </td>
    <td width="792" class="odrt">状态：<%String paystatus="未到款";
   long odrstatus=odr.getOdrmst_orderstatus().longValue();
        if(odr.getOdrmst_payid()!=null&&odr.getOdrmst_payid().longValue()>0&&odr.getOdrmst_payid().longValue()!=44){
        	if(odrstatus==0){
        		paystatus="未到款";
        	}else if(odrstatus==1||odrstatus==2){
        		paystatus="已收款待发货";
        	}
        }else{
        	if(odrstatus==0){
        		paystatus="未确认";
        	}else if(odrstatus==1){
        		paystatus="已确认待发货";
        	}
        }
        if(odrstatus<0&&odrstatus!=-2){
        	paystatus="用户取消";
        }else if(odrstatus==-2){
        	paystatus="缺货取消";
        }else if(odrstatus==3){
        	paystatus="订单全发";
        }else if(odrstatus==31){
        	paystatus="部分发货";
        }else if(odrstatus==5 || odrstatus==51 || odrstatus==6 || odrstatus==61){
        	paystatus="交易完成";
        }
   out.print(paystatus);  %></td>
  </tr>
</table>
</td></tr>
  <tr>
      <td height="20" colspan="2" ></td>
      </tr>
<tr><td colspan="2" align="center">
<table id="__01" width="766" height="60" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="144"  >
		<img src="images/nofh_01.jpg" width="144" height="44" alt="" border="0"></td>
		<td width="148"><%if(odr.getOdrmst_validdate()!=null){ %>
		<img src="images/fh_02.jpg" width="148" height="44" alt=""  border="0">
			<%}else{ %>
			<img src="images/nofh_02.jpg" width="148" height="44" alt=""  border="0">
			<%} %>
			</td>
		<td width="158">
		<%if(odr.getOdrmst_shipdate()!=null){ %>
		<img src="images/fh_03.jpg" width="158" height="44" alt=""  border="0">
		<%}else{ %>
		<img src="images/nofh_03.jpg" width="158" height="44" alt=""  border="0">
		<%} %>
		</td>
		<td width="179">
		<%if(odr.getOdrmst_finishdate()!=null){ %>
		<img src="images/fh_04.jpg" width="179" height="44" alt=""  border="0">
			<%}else{ %>
			<img src="images/nofh_04.jpg" width="179" height="44" alt=""  border="0">
			<%} %>
			</td>
		<td width="137">
		<%if(odr.getOdrmst_finishdate()!=null){ %>
		<img src="images/fh_05.jpg" width="137" height="44" alt=""  border="0">
		<%}else{ %>
		<img src="images/nofh_05.jpg" width="137" height="44" alt=""  border="0">
		<%} %>
		</td>
	</tr>
	<tr>
		<td><%=format.format(odr.getOdrmst_orderdate())%></td>
		<td><%if(odr.getOdrmst_validdate()!=null){ 
			out.print(format.format(odr.getOdrmst_validdate()));
			}%></td>
		<td><%if(odr.getOdrmst_shipdate()!=null){ 
			out.print(format.format(odr.getOdrmst_shipdate()));
			}%></td>
		<td><%if(odr.getOdrmst_finishdate()!=null){ 
			out.print(format.format(odr.getOdrmst_finishdate()));
			}%></td>
		<td><%if(odr.getOdrmst_finishdate()!=null){ 
			out.print(format.format(odr.getOdrmst_finishdate()));
			}%></td>
	</tr>
</table>
</td></tr>
  <tr>
      <td height="10" colspan="2" ></td>
      </tr>
 <tr>
      <td height="26" colspan="2"><img src="images/odrgzbg3.jpg" alt=""></td>
      </tr>
   <tr>
      <td height="10" colspan="2" ></td>
      </tr>
<tr>
  <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="lin"  align="center">
    <tr>
      <td width="20%" height="35" align="center" bgcolor="#efefef"><strong>处理时间</strong></td>
      <td width="47%" align="center" bgcolor="#efefef"><strong>处理信息</strong></td>
      <td width="33%" bgcolor="#efefef">&nbsp;</td>
    </tr>
    <tr>
      <td height="30" ><%=format.format(odr.getOdrmst_orderdate()) %></td>
      <td>提交了订单</td>
      <td><%=shpmst.getShpmst_shopname() %></td>
    </tr>
    <%if(odr.getOdrmst_validdate()!=null){ 
			%>
    <tr>
      <td  height="30" ><%=format.format(odr.getOdrmst_validdate())%></td>
      <td><%
      if(odr.getOdrmst_payid().longValue()==0||odr.getOdrmst_payid().longValue()==44){
    	  out.println("订单已经确认");
      }else{
    	  out.println("订单已经收款");
      }
      %></td>
      <td><%=shpmst.getShpmst_shopname() %></td>
    </tr>
    <%
	}%>
   <%if(odr.getOdrmst_shipdate()!=null){ 
			%>
    <tr>
      <td  height="30" ><%=format.format(odr.getOdrmst_shipdate())%></td>
      <td>订单已经发货快递公司：<%=odr.getOdrmst_d1shipmethod()+",快递单号："+odr.getOdrmst_goodsodrid()%></td>
      <td><%=shpmst.getShpmst_shopname() %></td>
    </tr>
    <%
	}%>
	<%if(odr.getOdrmst_finishdate()!=null){ 
			%>
    <tr>
      <td  height="30" ><%=format.format(odr.getOdrmst_finishdate())%></td>
      <td>订单已经确认</td>
      <td><%=shpmst.getShpmst_shopname() %></td>
    </tr>
    <%
	}%>
	<%if(odr.getOdrmst_canceldate()!=null){ 
			%>
    <tr>
      <td  height="30" ><%=format.format(odr.getOdrmst_canceldate())%></td>
      <td>订单已经取消</td>
      <td><%=shpmst.getShpmst_shopname() %></td>
    </tr>
    <%
	}%>
	
	
  </table></td>
</tr>
<tr>
  <td colspan="2" align="center">&nbsp;</td>
</tr>
<tr>
  <td colspan="2"><img src="images/odrd01.jpg" width="776" height="18" /></td>
</tr>
<tr>
  <td colspan="2"  style="line-height:21px; "></br>
  收&nbsp;货&nbsp;人：<%=odr.getOdrmst_rname() %></br>
  地&nbsp;&nbsp;址：<%=odr.getOdrmst_rprovince()+odr.getOdrmst_rcity()+odr.getOdrmst_raddress() %></br>
  电&nbsp;&nbsp;话：<%=odr.getOdrmst_rphone() %></br>
 E_mail：<%=odr.getOdrmst_remail() %></br>
 </br>支付及配送方式</br>
 支付方式：<%=odr.getOdrmst_paymethod() %></br>
 运&nbsp;&nbsp;&nbsp;&nbsp;费：￥<%=Tools.getDouble(odr.getOdrmst_shipfee(), 2) %></br>
 <%
 String customerword=odr.getOdrmst_customerword();
 if(customerword.startsWith("送货时间:") ) {%>
 送货时间：<%=customerword.substring(customerword.indexOf("送货时间:")+5,customerword.indexOf("） ")+1) %>
 <%} %>
  </td>
</tr>
<tr>
  <td colspan="2" align="center">&nbsp;</td>
</tr>
<tr>
  <td height="45" colspan="2" style="font-size:18px;"><strong>商品清单</strong></td>
</tr>
<tr>
  <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="lin">
    <tr class="odrt1">
      <td width="96" height="40">商品编号</td>
      <td width="304">商品名称</td>
      <td width="100">单价(元)</td>
      <td width="100">数量</td>
      <td width="100">交易状态</td>
      <td width="103">应收款</td>
    </tr>
    <tr>
      <td colspan="6"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="linon">
         
          <%double odrmoney=0f;
          for(OrderItemBase itembase:odritemlist){
        	  if(itembase.getOdrdtl_shipstatus().longValue()>=0 &&itembase.getOdrdtl_purtype().longValue() >=0){
        		  odrmoney=odrmoney+itembase.getOdrdtl_finalprice().doubleValue()*itembase.getOdrdtl_gdscount();
        	  }
			 long dtlstatus=itembase.getOdrdtl_shipstatus().longValue();
			 %>
         <tr>
         <td height="40"  class="spantxt  pdl8"><%=itembase.getOdrdtl_gdsid() %></td>
           <td height="40" ><%=itembase.getOdrdtl_gdsname() %></td>
           <td align="center"><%=Tools.getDouble(itembase.getOdrdtl_finalprice().doubleValue(), 2)%></td>
           <td align="center"><%=itembase.getOdrdtl_gdscount()%></td>
           <td align="center">
<%String status="";
if(dtlstatus==1){
	status="未发货";
}else if(dtlstatus==-1){
	status="商家取消";
}else if(dtlstatus==-2){
	status="用户取消";
}else if(dtlstatus==-3){
	status="退货";
}else if(dtlstatus==-4){
	status="换货";
}else if(dtlstatus==2||dtlstatus==3){
	status="已发货";
}
out.print(status);
%>
          </td>
           <td align="center"><%=Tools.getDouble(itembase.getOdrdtl_finalprice().doubleValue()*itembase.getOdrdtl_gdscount().longValue(), 2)%></td>
         </tr>
         <%} %>
        </table>          </td>
    </tr>
  </table></td>
</tr>
<tr>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td style="background:#deefff">&nbsp;</td>
  <td height="33" class="odrdtlm">商品金额：￥<%=Tools.getDouble(odrmoney, 2) %> </td>
</tr>
<tr>
  <td style="background:#deefff">&nbsp;</td>
  <td height="33" class="odrdtlm">+运费：￥<%=Tools.getDouble(odr.getOdrmst_shipfee(), 2) %></td>
</tr>
<tr>
  <td style="background:#deefff">&nbsp;</td>
  <td height="33" class="odrdtlm">-优惠券：￥<%=Tools.getDouble(odr.getOdrmst_tktvalue(), 2) %></td>
</tr>
<tr>
  <td style="background:#deefff">&nbsp;</td>
  <td height="33" class="odrdtlm">订单金额：￥<%=Tools.getDouble(odrmoney+odr.getOdrmst_shipfee().doubleValue()-odr.getOdrmst_tktvalue().doubleValue(), 2) %></td>
</tr>
<tr>
  <td width="553">&nbsp;</td>
  <td width="252">&nbsp;</td>
</tr>
</table>
<%}	

}
%>
</body>
</html>