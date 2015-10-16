<%@ page contentType="text/html; charset=UTF-8" import="java.util.regex.Matcher,java.util.regex.Pattern,net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%><%!
public static int check(HttpServletRequest request,HttpServletResponse response){
	String strcp_key="eV71cHM1393V8882xZ3281u5u16B836u";
	String sign=request.getParameter("sign");
	String shopid=request.getParameter("shopid");
	 String stractive_time=request.getParameter("acttime");
	long acttime=(new Date()).getTime()/1000;
	long mins=acttime-Tools.parseLong(stractive_time);

    String signrnew=shopid+"#"+strcp_key+"#"+stractive_time;
	System.out.println(signrnew);
    String signnew= MD5.to32MD5(signrnew, "Utf-8");
    if(mins/60>=15){
    	return 1;
    }else if(!signnew.equals(sign)){
    	return 2;
    }else{
    	return 0;
    }
}
public static class OrderBaseComparator implements Comparator<OrderBase>{

	@Override
	public int compare(OrderBase p0, OrderBase p1) {	
		
		if(p1.getOdrmst_validdate()!=null&&p0.getOdrmst_validdate()!=null&&p0.getOdrmst_validdate().getTime() <p1.getOdrmst_validdate().getTime()){
			return 1 ;
		}else if(p1.getOdrmst_validdate()!=null&&p0.getOdrmst_validdate()!=null&&p0.getOdrmst_validdate().getTime()==p1.getOdrmst_validdate().getTime()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}
%>
<%/*
JSONObject json = new JSONObject();
int ret=check(request,response);
System.out.println(ret);
if(ret==0){
	
	String shopid=request.getParameter("shopid");
	String pg=request.getParameter("page");
	 String strstime=request.getParameter("stime");
	 String stretime=request.getParameter("etime");
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

if(Tools.isNull(strstime)){
	strstime=format.format(Tools.addDate(new Date(), -10));
}else{
	strstime=format.format(new Date(Tools.parseLong(strstime)*1000));
}
if(Tools.isNull(stretime)){
	stretime=format.format(new Date());
}else{
	stretime=format.format(new Date(Tools.parseLong(stretime)*1000));
}
System.out.println(strstime+"==="+stretime+"---------------0-----------------"+shopid);
ArrayList<OrderBase> orderlist=OrderHelper.getOrderShopList(shopid, format.parse(strstime), format.parse(stretime));
int odrcount= orderlist.size();

if(orderlist!=null&&odrcount>0)
{
	
	json.put("status", "1");
	json.put("pagetotal", odrcount);
	Collections.sort(orderlist,new OrderBaseComparator());

	JSONArray jsonarr=new JSONArray();
	if(Tools.isNull(pg))pg="1";
	int ipg=Tools.parseInt(pg);
	int ipsize=100;
	PageBean pBean1 = new PageBean(odrcount,ipsize,ipg);
	int pbegin = (pBean1.getCurrentPage()-1)*ipsize;
    int pend = pbegin + ipsize;
    DecimalFormat df = new DecimalFormat("0.00");
   
    long orderstatus=0;
    double orderactmoney=0f;
    String statustxt="";
    System.out.println(odrcount+"---------------10-----------------");
	 for(int t=pbegin; t<odrcount&&t<pend;t++ )
     {
		 
		 OrderBase ob = orderlist.get(t);
		 if(ob==null)continue;
		 JSONObject jsonorder=new JSONObject();
		 JSONArray jsonorderarr=new JSONArray();
		 
		 orderstatus=ob.getOdrmst_orderstatus().longValue();
		 if(orderstatus>=3){
			 orderstatus=1;
		  }else if(orderstatus==1||orderstatus==2){
			  orderstatus=0;
		  }
		 /*"orderid": "191654023246",//订单号
          "name": "收货人",//收货人
          "province": "省",//省
          "city": "区或市或县",//区或市或县
          "address": "安徽省淮南市田家庵区龙湖地下商业街",//收货地址
	    "phone": "11111111111",//电话
          "zipcode": "",//邮编
	    "ordermoney": 288.00,//订单金额
          "tktmoney": 30.00,//优惠券金额
          "actmoney": 30.00,//满减金额
          "prepayvalue":100.00,//预存款
	　　"ordertime": "下单时间",//下单时间时间格式yyyy-MM-dd HH:mm:ss
	　　"validtime": "支付时间",//支付时间时间格式yyyy-MM-dd HH:mm:ss
	    "ostatus": 1,//0 收款未发货 、1已发货、 99两种状态都包括
	     "memo": "用户留言",//用户留言
          "details": [
              {
                  "goodsid": "04001066",//D1商品ID
                  "shopgoodsid": "209858"//商户商品ID
		    "goodsname": "商品名称"//商品名称
		    "price": 88.00//商品单价
                  "mprice": 188.00//市场价
		    "goodscount":2//商品数量
              }*/
             /* orderactmoney=ob.getOdrmst_d1actmoney()==null?0:ob.getOdrmst_d1actmoney().doubleValue();
		 jsonorder.put("orderid", ob.getId());
		 jsonorder.put("name", ob.getOdrmst_rname());
		 jsonorder.put("province", ob.getOdrmst_rprovince());
		 jsonorder.put("city", ob.getOdrmst_rcity());
		 jsonorder.put("address", ob.getOdrmst_raddress());
		 jsonorder.put("phone", ob.getOdrmst_rphone());
		 jsonorder.put("zipcode", ob.getOdrmst_rzipcode());
		 jsonorder.put("shipfee", df.format(ob.getOdrmst_shipfee().doubleValue()));
		 jsonorder.put("ordermoney", df.format(ob.getOdrmst_acturepaymoney().doubleValue()));
		 jsonorder.put("tktmoney", df.format(ob.getOdrmst_tktvalue().doubleValue()-orderactmoney));


		 jsonorder.put("actmoney", df.format(orderactmoney));
		 jsonorder.put("prepayvalue", df.format(ob.getOdrmst_prepayvalue().doubleValue()));
		 jsonorder.put("ordertime", format.format(ob.getOdrmst_orderdate()));
		 jsonorder.put("validtime", format.format(ob.getOdrmst_validdate()));
		 jsonorder.put("ostatus",orderstatus);
		String memo=ob.getOdrmst_customerword();
			String 	regEx_html = "<[^>]+>";
			Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);  
		    Matcher m_html = p_html.matcher(memo);  
		    memo = m_html.replaceAll(""); 
		 jsonorder.put("memo", memo);
		 List<OrderItemBase> oitems=OrderItemHelper.getOdrdtlListByOrderId(ob.getId());
		 int itemstatus=0;
		if(oitems!=null){
		 for(OrderItemBase oitem:oitems){
			 JSONObject jsonitem=new JSONObject();
			
			 Product p=ProductHelper.getById(oitem.getOdrdtl_gdsid());
			 if(oitem.getOdrdtl_shipstatus().longValue()==1&&oitem.getOdrdtl_purtype().longValue()>=0){
			     itemstatus=0;
			 }else if(oitem.getOdrdtl_shipstatus().longValue()>=2&&oitem.getOdrdtl_purtype().longValue()>=0){
				 itemstatus=1;
			 }else{
				 itemstatus=-1; 
			 }
			 /*"details": [
			              {
			                  "goodsid": "04001066",//D1商品ID
			                  "shopgoodsid": "209858"//商户商品ID
					    "goodsname": "商品名称"//商品名称
					    "price": 88.00//商品单价
			                  "mprice": 188.00//市场价
					    "goodscount":2//商品数量
			              }*/
			/* jsonitem.put("goodsid", oitem.getOdrdtl_gdsid());
			 jsonitem.put("shopgoodsid", p.getGdsmst_shopgoodscode());
			 jsonitem.put("barcode", p.getGdsmst_barcode());
			 jsonitem.put("goodsname", oitem.getOdrdtl_gdsname());
			 jsonitem.put("price", df.format(oitem.getOdrdtl_finalprice()));
			 jsonitem.put("mprice", df.format(p.getGdsmst_saleprice()));
			 jsonitem.put("goodscount", oitem.getOdrdtl_gdscount());

			 jsonorderarr.add(jsonitem);
		 }
		 

		}
		 jsonorder.put("details", jsonorderarr);
		 
		 jsonarr.add(jsonorder);
     }
	
	 json.put("orders", jsonarr);
}

}
out.print(json);*/
%>