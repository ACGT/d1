<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="../inc/header.jsp"%><%@include file="function.jsp"%><%
String bid=request.getParameter("bid");
String rbid=PubConfig.get("cps360_bid");
String cp_key=PubConfig.get("cps360_cpkey");

if(Tools.isNull(bid) || !rbid.equals(bid)){
	out.print("bid错误！");
	return;
}
String order_ids=request.getParameter("order_ids");
String start_time=request.getParameter("start_time");
String end_time=request.getParameter("end_time");
String updstart_time=request.getParameter("updstart_time");
String updend_time=request.getParameter("updend_time");
String last_order_id=request.getParameter("last_order_id");
String active_time=request.getParameter("active_time");
String sign=request.getParameter("sign");

long verifytime=System.currentTimeMillis()/1000;

String strcode=bid+"#"+active_time+"#"+cp_key;
String verifycode=MD5.to32MD5(strcode, "utf-8");

if(verifytime-Tools.parseLong(active_time) >15*60 ){
	out.print("检查超时.active_time="+verifytime);
	return;
}
if(!verifycode.equals(sign)){
	out.print("签名验证失败");
	return;
}
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
ArrayList<OrderBase> list=null;
if(!Tools.isNull(order_ids)){
	list=getByIds(order_ids);
}else if(!Tools.isNull(start_time) && !Tools.isNull(end_time)){
	try{
		format.parse(start_time);
	}catch(Exception e){
		out.print("start_time格式错误");
		return;
	}
	try{
		format.parse(end_time);
	}catch(Exception e){
		out.print("end_time格式错误");
		return;
	}
	list=getOrderList("cps360",format.parse(start_time),format.parse(end_time),last_order_id);
}else if(!Tools.isNull(updstart_time) && !Tools.isNull(updend_time)){
	try{
		format.parse(updstart_time);
	}catch(Exception e){
		out.print("updstart_time格式错误");
		return;
	}
	try{
		format.parse(updend_time);
	}catch(Exception e){
		out.print("updend_time格式错误");
		return;
	}
	list=getOrderList("cps360",format.parse(updstart_time),format.parse(updend_time),last_order_id);
}
if(list!=null && list.size()>0){
	StringBuffer str=new StringBuffer();
	str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
	 str.append("<orders>");
	for(OrderBase base:list){
		 String qid="";String qihoo_id="";String ext="";
		 if(base.getOdrmst_temp().contains("|")){
			  String[] temp=base.getOdrmst_temp().split("\\|");
			  if(temp.length>=4){
				  qid=temp[1];
				  qihoo_id=temp[2];
				  ext=temp[3];
			  }
		  }
		 str.append("<order>");
		 str.append("<bid>");
		 str.append(bid);
		 str.append("</bid>");
		 str.append("<qid>");
		 str.append(qid);
		 str.append("</qid>");
		 str.append("<qihoo_id>");
		 str.append(qihoo_id);
		 str.append("</qihoo_id>");
		 str.append("<ext>");
		 str.append(ext);
		 str.append("</ext>");
		 str.append("<order_id>");
		 str.append(base.getId());
		 str.append("</order_id>");
		 str.append("<order_time>");
		 str.append(format.format(base.getOdrmst_orderdate()));
		 str.append("</order_time>");
		 str.append("<order_updtime>");
		 str.append(format.format(base.getOdrmst_orderdate()));
		 str.append("</order_updtime>");
		 str.append("<server_price>");//服务费用，如运送费等 
		 str.append(Tools.getDouble(base.getOdrmst_shipfee(),2));
		 str.append("</server_price>");
		 str.append("<total_price>");//订单总金额 
		 str.append(Tools.getDouble(base.getOdrmst_ordermoney(),2));
		 str.append("</total_price>");
		 str.append("<coupon>");//优惠券金额 
		 str.append(Tools.getDouble(base.getOdrmst_tktvalue(),2));
		 str.append("</coupon>");
		 str.append("<total_comm>");//订单总佣金
		 str.append(Tools.getDouble(gettotal(base.getId(), Tools.doubleValue(base.getOdrmst_tktvalue())),2));
		 str.append("</total_comm>");
		 str.append("<commission>");//佣金明细
		  String detail="";
		 String pinfo="";
		 boolean type1=false;boolean type2=false;boolean type3=false;
		 ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  if(orderitemlist!=null){
			  int i=0;
			 for(OrderItemBase itembase:orderitemlist){
				  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
				  if(product!=null){
					  String strRackCode="";
					  String strGdsmstBrand=product.getGdsmst_brand();
					  String strOdrdtlRackCode=itembase.getOdrdtl_rackcode();
					  double  iOdrdtlSpecialFlag=itembase.getOdrdtl_specialflag().doubleValue();
					  double price=0d;
					  double fltTktmstTktValue = Tools.doubleValue(base.getOdrmst_tktvalue());
					  double fdtltktra=1;//计算用券比例
					  double dbl=0; //佣金比率
					  String yj="";
						 if (fltTktmstTktValue>0)
						 {
						 	fdtltktra=getTktRa(fltTktmstTktValue,base.getId());
						 }
                     if (strGdsmstBrand.equals("001346" )|| //F&M
                         strGdsmstBrand.equals("001561") ||//YouSoo
                         strGdsmstBrand.equals("001564"))//小栗舍

                     {
                         strRackCode = "1";
                         dbl=0.15;
                         yj="15%";
                         type1=true;
                     }
                     else if (strOdrdtlRackCode.startsWith("020") || strOdrdtlRackCode.startsWith("030") || strOdrdtlRackCode.startsWith("015009"))//服装//饰品
                     {
                         strRackCode = "2";
                         dbl=0.08;
                         yj="8%";
                         type2=true;
                     }else
                     {
                         strRackCode = "3";
                         dbl=0.04;
                         yj="4%";
                         type3=true;
                     }
                   
                    if (iOdrdtlSpecialFlag==1 || itembase.getOdrdtl_gdsname().indexOf("优惠特价")>=0 || "团购商品".equals(itembase.getOdrdtl_temp()))
		               {
		            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
		               }
		               else
		               {
		            	   price=Tools.getDouble(itembase.getOdrdtl_finalprice()*fdtltktra, 2);
		               }
                     double yongjin=itembase.getOdrdtl_gdscount().intValue()*Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
                   
				 if(i>0){
					 detail+="|"; 
					 pinfo+="|";
				 }
				 detail+=strOdrdtlRackCode+","+yj+","+Tools.getDouble(yongjin*dbl,2)+","+Tools.getDouble(itembase.getOdrdtl_finalprice(),2)+","+itembase.getOdrdtl_gdscount();
				String pcode=strOdrdtlRackCode.substring(0,3);
				String pcodename1="";//一级分类名称
				String pcodename2="";//二级分类名称
				Directory d1=DirectoryHelper.getById(pcode);
				if(d1!=null){
					pcodename1=d1.getRakmst_rackname().trim();
				}
				String pcode2="";
				if(strOdrdtlRackCode.length()>=6){
					pcode2=strOdrdtlRackCode.substring(0,6);
				}
				Directory d2=DirectoryHelper.getById(pcode2);
				if(d2!=null){
					pcodename2=d2.getRakmst_rackname().trim();
				}
				String pcodename3="";//当前分类名称
				Directory d3=DirectoryHelper.getById(strOdrdtlRackCode);
				if(d3!=null){
					pcodename3=d3.getRakmst_rackname().trim();
				}
				String url="http://www.d1.com.cn/product/"+product.getId().trim();
				 pinfo+=strOdrdtlRackCode+","+Tools.clearHTML(product.getGdsmst_gdsname().replace(",", "").replace("，", ""))+","+product.getId().trim()+","+Tools.getDouble(itembase.getOdrdtl_finalprice(),2)+","+itembase.getOdrdtl_gdscount()+","+pcodename1+"_"+pcodename2+"_"+pcodename3+","+URLEncoder.encode(url,"utf-8");
				 i++;
				  }
				 
			  }
		  }
		  double d=0;
		  if(type3) d=0.04;
		  else if(type2) d=0.08;
		  else if(type1) d=0.15;
		 str.append(detail).append("|").append(Tools.getDouble(base.getOdrmst_tktvalue()*d,2));
		 str.append("</commission>");
		 str.append("<p_info>");
		 str.append(pinfo);
		 str.append("</p_info>");
		 str.append("<status>");
		 str.append(checkOrderStatus(base.getOdrmst_orderstatus().intValue(),Tools.getDouble(base.getOdrmst_getmoney
().doubleValue(),2),base.getOdrmst_realshipdate(),Tools.getDouble(base.getOdrmst_tktvalue(),2)));
		 str.append("</status>");
		 str.append("</order>");
	}
	 str.append("</orders>");
	 out.print(str.toString());
}else{
	StringBuffer str=new StringBuffer();
	str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
	 str.append("<orders>");
	 str.append("</orders>");
	 out.print(str.toString());
	return;
}
%>
