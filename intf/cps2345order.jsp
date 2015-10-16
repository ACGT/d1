<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="../inc/header.jsp"%><%!
public static Map getParameterMap(HttpServletRequest request) {
    // 参数Map
    Map properties = request.getParameterMap();
    // 返回值Map
    Map returnMap = new HashMap();
    Iterator entries = properties.entrySet().iterator();
    Map.Entry entry;
    String name = "";
    String value = "";
    while (entries.hasNext()) {
        entry = (Map.Entry) entries.next();
        name = (String) entry.getKey();
        Object valueObj = entry.getValue();
        if(null == valueObj){
            value = "";
        }else if(valueObj instanceof String[]){
            String[] values = (String[])valueObj;
            for(int i=0;i<values.length;i++){
                value = values[i] + ",";
            }
            value = value.substring(0, value.length()-1);
        }else{
            value = valueObj.toString();
           
        }
        returnMap.put(name, value);
    }
    return returnMap;
}
public static int check(HttpServletRequest request,HttpServletResponse response){
	String strcp_key="0de04d25f205eddc9d521ea1f46dde9a";
	Map rmap=getParameterMap(request);
	 String strbid=rmap.get("bid").toString();
	    String stractive_time=rmap.get("active_time").toString();
	    String strsign=rmap.get("sign").toString();

	long acttime=(new Date()).getTime()/1000;
	long mins=acttime-Tools.parseLong(stractive_time);
    String signrnew=strbid+"#"+stractive_time+"#"+strcp_key+"#"+0+"#";
    String signnew= MD5.to32MD5(signrnew, "Utf-8");
    if(mins/60>=15){
    	return 1;
    }else if(!signnew.equals(strsign)){
    	return 2;
    }else{
    	return 0;
    }
}
%><%
StringBuffer str=new StringBuffer();
int ret=check(request,response);
if(ret==0){
	//str.append("验证通过");
	Map rmap=getParameterMap(request);

	String order_ids="";
	String start_time="";
	String end_time="";
	int type=0;
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if(rmap.get("order_ids")!=null){
	 order_ids=rmap.get("order_ids").toString();
	}else{
		
		if(rmap.get("start_time")!=null){
	    start_time=rmap.get("start_time").toString();
	    end_time=rmap.get("end_time").toString();
		}
		if(rmap.get("updstart_time")!=null){
	     start_time=rmap.get("updstart_time").toString();
	     end_time=rmap.get("updend_time").toString();
	     type=1;
		}
	 
	 
	
	
	if(Tools.isNull(start_time)){
		start_time=format.format(Tools.addDate(new Date(), -30));
	}else{
		start_time=format.format(new Date(Tools.parseLong(start_time)*1000));
	}
	if(Tools.isNull(end_time)){
		end_time=format.format(new Date());
	}else{
		end_time=format.format(new Date(Tools.parseLong(end_time)*1000));
	}
	}
	if(Tools.isNull(order_ids)){
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList("C2345", format.parse(start_time), format.parse(end_time),type);
	
	DecimalFormat df = new DecimalFormat("0.00");
	if(orderlist!=null){
		str.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		str.append("<orders>");
	  for(OrderBase base:orderlist){
		  String userid="";
		 
		  String temp=base.getOdrmst_temp();
		  long status=base.getOdrmst_orderstatus().longValue();
		  String[] temps=temp.split("\\|");
		  String temp1="";
		  if(temps.length>1)temp1=temps[1];
		  String temp2="";
		  if(temps.length>2)temp2=temps[2];
		  String temp3="";
		  if(temps.length>3)temp3=temps[3];
		  
		  str.append("<order>");
		  str.append("<bid>"+temps[0].substring(5)+"</bid>");
		  str.append("<passid>"+temp1+"</passid>");
		  str.append("<username><![CDATA["+temp2+"]]></username>");
		  str.append("<company_id>45</company_id>");
		  str.append("<ext><![CDATA["+temp3+"]]></ext>");
		  str.append("<order_id><![CDATA["+base.getId()+"]]></order_id>");
		  str.append("<order_time>"+base.getOdrmst_orderdate().getTime()/1000+"</order_time>");
		  str.append("<order_updtime>"+base.getOdrmst_orderdate().getTime()/1000+"</order_updtime>");
		  if(status<0){
			  str.append("<status>2</status>");  
		  }else if(status==0){
				  str.append("<status>0</status>");  
		  }else if(status==1 || status==2 ){
			  str.append("<status>1</status>"); 
		  }else if(status>=3 ){
			  str.append("<status>3</status>");
		  }
		  
		  str.append("<total_price>"+df.format(base.getOdrmst_acturepaymoney().doubleValue()+base.getOdrmst_prepayvalue().doubleValue())+"</total_price>");
		  str.append("<from_ip>"+base.getOdrmst_ip()+"</from_ip>");
		  str.append("<from_url><![CDATA["+base.getOdrmst_srcurl()+"]]></from_url>");
		  str.append("<products>");
		  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  if(orderitemlist!=null){
		
		  for(OrderItemBase itembase:orderitemlist){
			  Product p=ProductHelper.getById(itembase.getOdrdtl_gdsid());
		  str.append("<product>");
		  str.append("<id><![CDATA["+itembase.getOdrdtl_gdsid()+"]]></id>");
		  str.append("<name><![CDATA["+itembase.getOdrdtl_gdsname()+"]]></name>");
		  str.append("<url><![CDATA[http://www.d1.com.cn/product/"+itembase.getOdrdtl_gdsid()+"]]></url>");
		  str.append("<cateid><![CDATA["+p.getGdsmst_rackcode()+"]]></cateid>");
		  Directory dir= DirectoryHelper.getById(p.getGdsmst_rackcode());
		  if(dir!=null){
		  str.append("<catename><![CDATA["+dir.getRakmst_rackname()+"]]></catename>");
		  }else{
		str.append("<catename><![CDATA[]]></catename>");
		  }
		  str.append("<price>"+df.format(itembase.getOdrdtl_finalprice())+"</price>");
		  str.append("<quantity>"+itembase.getOdrdtl_gdscount()+"</quantity>");
		  str.append("</product>");
			  }
		  }
		  str.append("</products>");
		  str.append("</order>");
	  }
	  str.append("</orders>"); 
	}else{
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		str.append("<orders>");
		str.append("</orders>"); 
	}
	}else{
		order_ids=order_ids.trim();
		if(order_ids.indexOf(",")<0){
			order_ids=order_ids+",";
		}
	 
		String[] orderarr=null;
		DecimalFormat df = new DecimalFormat("0.00");
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		str.append("<orders>");
		if(order_ids.indexOf(",")>=0){
			orderarr=order_ids.split("\\,");
		
		int odrlen= orderarr.length;
		  for(int j=0;j<odrlen;j++){
			  OrderBase base=OrderHelper.getById(orderarr[j]);
		   if(base==null||!base.getOdrmst_temp().startsWith("C2345"))continue;
			  String userid="";
			 
			  String temp=base.getOdrmst_temp();
			  long status=base.getOdrmst_orderstatus().longValue();
			  String[] temps=temp.split("\\|");
			  String temp1="";
			  if(temps.length>1)temp1=temps[1];
			  String temp2="";
			  if(temps.length>2)temp2=temps[2];
			  String temp3="";
			  if(temps.length>3)temp3=temps[3];
			  str.append("<order>");
			  str.append("<bid>"+temps[0].substring(5)+"</bid>");
			  str.append("<passid>"+temp1+"</passid>");
			  str.append("<username><![CDATA["+temp2+"]]></username>");
			  str.append("<company_id>45</company_id>");
			  str.append("<ext><![CDATA["+temp3+"]]></ext>");
			  str.append("<order_id><![CDATA["+base.getId()+"]]></order_id>");
			  str.append("<order_time>"+base.getOdrmst_orderdate().getTime()/1000+"</order_time>");
			  str.append("<order_updtime>"+base.getOdrmst_orderdate().getTime()/1000+"</order_updtime>");
			  if(status<0){
				  str.append("<status>2</status>");  
			  }else if(status==0){
					  str.append("<status>0</status>");  
			  }else if(status==1 || status==2 ){
				  str.append("<status>1</status>"); 
			  }else if(status>=3 ){
				  str.append("<status>3</status>");
			  }
			  
			  str.append("<total_price>"+df.format(base.getOdrmst_acturepaymoney().doubleValue()+base.getOdrmst_prepayvalue().doubleValue())+"</total_price>");
			  str.append("<from_ip>"+base.getOdrmst_ip()+"</from_ip>");
			  str.append("<from_url><![CDATA["+base.getOdrmst_srcurl()+"]]></from_url>");
			  str.append("<products>");
			  ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
			  if(orderitemlist!=null){
			
			  for(OrderItemBase itembase:orderitemlist){
				  Product p=ProductHelper.getById(itembase.getOdrdtl_gdsid());
			  str.append("<product>");
			  str.append("<id><![CDATA["+itembase.getOdrdtl_gdsid()+"]]></id>");
			  str.append("<name><![CDATA["+itembase.getOdrdtl_gdsname()+"]]></name>");
			  str.append("<url><![CDATA[http://www.d1.com.cn/product/"+itembase.getOdrdtl_gdsid()+"]]></url>");
			  str.append("<cateid><![CDATA["+p.getGdsmst_rackcode()+"]]></cateid>");
			  Directory dir= DirectoryHelper.getById(p.getGdsmst_rackcode());
			  str.append("<catename><![CDATA["+dir!=null?dir.getRakmst_rackname():""+"]]></catename>");
			  str.append("<price>"+df.format(itembase.getOdrdtl_finalprice())+"</price>");
			  str.append("<quantity>"+itembase.getOdrdtl_gdscount()+"</quantity>");
			  str.append("</product>");
				  }
			  }
			  str.append("</products>");
			  str.append("</order>");
		  }
		  str.append("</orders>"); 
		}
	}
	
   }else if(ret==1){
	   long acttime=(new Date()).getTime()/1000;
	   str.append("检查超时.active_time="+acttime);	
   }else if(ret==2){
	   str.append("签名验证失败");	 
}
//System.out.println(str.toString());
out.print(str.toString());
%>