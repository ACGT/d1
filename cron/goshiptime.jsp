<%@ page contentType="text/html; charset=UTF-8"  import="net.sf.json.*" %><%@include file="/html/header.jsp"%><%!
public static ArrayList<OrderRecent> getorderRecentlist(){
ArrayList<OrderRecent> rlist = new ArrayList<OrderRecent>();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
Date ndate=new Date();
try{
String edate= sdf.format(Tools.addDate(ndate, -2));

List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
listRes.add(Restrictions.ge("odrmst_orderdate",sdf.parse("2014-07-01")));
listRes.add(Restrictions.le("odrmst_orderdate", sdf.parse(edate)));
listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(3)));
listRes.add(Restrictions.ne("odrmst_shipflag",new Long(2)));
//listRes.add(Restrictions.eq("id","191602028431"));

//加入排序条件
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("odrmst_orderdate"));
//加入缓存订单
List<BaseEntity> list_cache = Tools.getManager(OrderRecent.class).getList(listRes, olist, 0, 3000);

if(list_cache!=null&&list_cache.size()>0){
	for(BaseEntity be:list_cache){
		OrderRecent ob = (OrderRecent)be;
		rlist.add(ob);
	}
}

}catch(Exception e){
	e.printStackTrace();
}
return rlist;
}

private static String getcom(String comname){
	String com="";
	 if(comname.indexOf("中通")>=0){
		   com="zhongtong";
	   }else if(comname.indexOf("宅急送")>=0){
		   com="zhaijisong";
	   }else if(comname.indexOf("优速")>=0){
		   com="yousu";
	   }else if(comname.indexOf("天天")>=0){
		   com="tiantian";
	   }else if(comname.indexOf("顺丰")>=0){
		   com="shunfeng";
	   }else if(comname.indexOf("圆通")>=0){
		   com="yuantong";
	   }else if(comname.indexOf("申通")>=0){
		   com="shentong";
	   }else if(comname.indexOf("全峰")>=0){
		   com="quanfeng";
	   }else if(comname.indexOf("汇通")>=0){
		   com="huitong";
	   }else if(comname.indexOf("EMS")>=0){
		   com="ems";
	   }else if(comname.indexOf("韵达")>=0){
		   com="yunda";	
	   }else if(comname.indexOf("龙邦")>=0){
		   com="longbang";	
		   
	   }
	
	return com;
}



private static String  getbackship(String shipmethod,String shipcode){
	String backstr="";
	shipmethod=shipmethod.trim();
	shipcode=shipcode.trim();
String com=getcom(shipmethod);
if(!Tools.isNull(com)){
	 
String gourl="http://api.ickd.cn/?id=103771&secret=eae96b9aac0097cd94eda25af53f6b6e&com="+com+"&nu="+shipcode+"&type=json&encode=utf8";

//"http://api.kuaidi100.com/api?id=b1a8923eac35cde8";
// gourl=gourl+"&com="+com+"&nu="+ob.getOdrmst_goodsodrid()+"&show=0&muti=1&order=desc";

try{
backstr= HttpUtil.getUrlContentByGet(gourl,"utf-8");
}catch(Exception ex){
				
			}	  
}
//System.out.println(shipmethod+"------------"+shipcode+"--------"+com);
return backstr;
}

%>
<%
FileWriter fw3 = new FileWriter(new File("/var/shiptimeerror.txt"),true);
	fw3.write("更新订单发货时间开始。。。。。。"+System.getProperty("line.separator"));
	fw3.flush();
	fw3.close();
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){

List<OrderRecent> orderlist=getorderRecentlist();

SimpleDateFormat sdfup = new SimpleDateFormat("yyyy-MM-dd HH:mm");
if(orderlist!=null&&orderlist.size()>0){
	for(OrderRecent ob:orderlist){
		FileWriter fw5 = new FileWriter(new File("/var/shiptimeerror.txt"),true);
		fw5.write(ob.getId()+System.getProperty("line.separator"));
		fw5.flush();
		fw5.close();
		try{
		String shipmethod=ob.getOdrmst_d1shipmethod();
		String shipcode=ob.getOdrmst_goodsodrid();
		 if(!Tools.isNull(shipmethod)&&!Tools.isNull(shipcode)){
              String backstr=getbackship(shipmethod,shipcode);
           // System.out.println(ob.getId()+"------------"+backstr);
            if(!Tools.isNull(backstr)){ 

                JSONObject  jsonob = JSONObject.fromObject(backstr); 
                String k100status = jsonob.getString("status");
             
                if(Tools.parseInt(k100status)>0){
                    JSONArray jsons = jsonob.getJSONArray("data");  
                    
                    int jsonLength = jsons.size();  
                   // for (int i = 0; i < jsonLength; i++) { 

                        JSONObject tempJson = JSONObject.fromObject(jsons.get(0));
                        String  scontext=  tempJson.getString("context");
                        String  stime=  tempJson.getString("time");
                        JSONObject etempJson = JSONObject.fromObject(jsons.get(jsonLength-1));
                        String  econtext=  etempJson.getString("context");
                        String  etime=  etempJson.getString("time");
                       
                        FileWriter fw = new FileWriter(new File("/var/shiptimeerror.txt"),true);
            			fw.write("更新订单="+ob.getId()+System.getProperty("line.separator"));
            			fw.flush();
            			fw.close();
            			boolean upt=false;
            			
                        if(!Tools.isNull(stime)&&ob.getOdrmst_sshipdate()==null){
                        	ob.setOdrmst_sshipdate(sdfup.parse(stime));
                        	ob.setOdrmst_shipflag(new Long(1));
                        	upt=true;
                        }
                        //System.out.println(ob.getId()+etime+"--------"+upt+"--------------"+stime+"===="+ob.getOdrmst_sshipdate());
                        if(Tools.parseInt(k100status)==3){
                        	ob.setOdrmst_eshipdate(sdfup.parse(etime));
                        	ob.setOdrmst_shipflag(new Long(2));
                        	upt=true;
                        }
                       
                        if(upt){
                        	Tools.getManager(OrderRecent.class).update(ob, false);
                        	//System.out.println(ob.getId()+"更新订单成功!!!");
                        	FileWriter fw2 = new FileWriter(new File("/var/shiptimeerror.txt"),true);
                			fw2.write("更新订单成功="+ob.getId()+System.getProperty("line.separator"));
                			fw2.flush();
                			fw2.close();
                        }
                      // }
                      
                 }else{
                	 if(Tools.isNull(ob.getOdrmst_shipflag().toString())){
                		 ob.setOdrmst_shipflag(new Long(15));
                		 Tools.getManager(OrderRecent.class).update(ob, true);
                	 }else{
                		 long shipflag=ob.getOdrmst_shipflag().longValue();
                		 ob.setOdrmst_shipflag(new Long(shipflag-1));
                		 Tools.getManager(OrderRecent.class).update(ob, true);
                	 }
                 }
            }
        }
		}catch(Exception ex){
			 FileWriter fw = new FileWriter(new File("/var/shiptimeerror.txt"),true);
 			fw.write("更新失败订单="+ob.getId()+ ex+System.getProperty("line.separator"));
 			fw.flush();
 			fw.close();
		}
   }
}
}
%>