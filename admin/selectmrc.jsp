<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>

<% 

if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "selectuserinfo");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

   String mbrid="";
   String mbrname="";
   if(request.getParameter("mbrid")!=null&&request.getParameter("mbrid").length()>0)
   {
	   mbrid=request.getParameter("mbrid");
   }
  
   ArrayList<OrderBase> list=new ArrayList<OrderBase>();
   
   
	   if(mbrid!=null&&mbrid.length()>0)
	   {
		   list=OrderHelper.getTotalOrderListIn4Months(mbrid);
	   }
	   else
	   {
		   list=null;
	   }
  
   
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员信息查询</title>
<script language="javascript" type="text/javascript">
  function directurl()
  {
	  var mbrid=document.getElementById("mbrid");
	  var mbrname=document.getElementById("gdsid");
	  if(mbrid.value==""||mbrname.value=="")
		  {
		  alert('条件不正确');
		  }
	  else
		  {
		   this.location.href="/admin/selectmrc.jsp?gdsid="+mbrname.value+"&mbrid="+mbrid.value;
		  }
	  
  }

</script>
</head>
<body>
<center>
  请输入 会员号：<input id="mbrid" type="text" ></input><br/><br/>
   请输入商品编号：<input id="gdsid" type="text" ></input><br/><br/>
   
  <input type="button" value="查询" onclick="directurl()"></input><br/><br/>
   
   <% if(list!=null&&list.size()>0)
     {%>
       <table border="1">
       <tr>
            <th>客户姓名</th><th>联系电话</th><th>客户地址</th>
            <th>订单号</th><th>商品名称</th><th>商品金额</th><th>商品数量</th>
            <th>快递单号</th><th>商品运费 </th><th>商品状态 </th>
       </tr>
      
     <%
	     for(OrderBase ob:list)
	     {
	    	 ArrayList<OrderItemBase> oilist=OrderItemHelper.getOdrdtlListByOrderId(ob.getId());
	    	 String gdsid="";
	    	 if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
	    	 {
	    		 gdsid=request.getParameter("gdsid");
	    	 }
	    	 if(gdsid.length()>0)
	    	 {
	    	 if(oilist!=null&&oilist.size()>0)
	    	 {
	    		 for(OrderItemBase oib:oilist)
	    		 {
	    		     if(oib.getOdrdtl_gdsid().equals("gdsid"))
	    		     {
	    		   %>
	    			<tr>
	    			   <td><%= ob.getOdrmst_rname() %></td>
	    			   <td><%= ob.getOdrmst_rphone() %></td>
	    			   <td><%= ob.getOdrmst_raddress() %></td>
	    			   <td><%= ob.getId() %></td>
	    			   <td><%= oib.getOdrdtl_gdsname() %></td>
	    			   <td><%= oib.getOdrdtl_finalprice() %></td>
	    			   <td><%= oib.getOdrdtl_gdscount() %></td>
	    			   <td><%= ob.getOdrmst_goodsodrid() %></td>
	    			   <td><%= ob.getOdrmst_shipfee() %></td>
	    			   <td>
	    			   
	    			    <%
	    			       if(ob.getOdrmst_orderstatus()==-1||ob.getOdrmst_orderstatus()==-2||ob.getOdrmst_orderstatus()==-3)
	    			       {
	    			    	   out.print("取消");
	    			       }
	    			       else
	    			       {
			    			    switch (Tools.parseInt(oib.getOdrdtl_shipstatus().toString()))
			    			    {
			    			      case 1:
			    			    	  out.print("正在配货");
							          break;
							      case 2:
							      case 3:
							          out.print("已发货");
							          break;
							      case -2:
							      case -1:
							          out.print("取消");
							          break;
					   	}
	    			       }
									          							
									          %>
	    			   </td>
	    			</tr> 
	    		 <%}
	    		 }
	    	 }
	    	 }
	     }
	 %>
	     
     </table>
    <%
    }  
   else {out.print(mbrid);}
   %>
   
   
</center>
</body>
</html>