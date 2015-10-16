<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%><%!
public static int check(String shopid,String stractive_time,String sign){
	String strcp_key="eV71cHM1393V8882xZ3281u5u16B836u";
	long acttime=(new Date()).getTime()/1000;
	long mins=acttime-Tools.parseLong(stractive_time);

	String signrnew=shopid+"#"+strcp_key+"#"+stractive_time;
	//System.out.println(signrnew+"===========================");
    String signnew= MD5.to32MD5(signrnew, "Utf-8");
    if(mins/60>=15){
    	return -3;
    }else if(!signnew.equals(sign)){
    	return -2;
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
public synchronized boolean sndodrok(String odrid,String shipname, String shipcode,String shopCode)throws Exception{
	boolean  sendflag=OrderHelper.sendodr(odrid, shipname, shipcode, "接口自动", shopCode);
	return sendflag;
}
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
%>
<%/*response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("UTF-8");

JSONObject json = new JSONObject();
int currentMinute = java.util.Calendar.getInstance().get(java.util.Calendar.MINUTE) ;
if(currentMinute%15==0){
Map paramMap=getParameterMap(request);*/
//System.out.println(paramMap.toString());
/*StringBuilder errorder=new StringBuilder();
errorder.append(",194947038697,194943043718,94947038697,194947052925,194947014867,194950009156,194956042107,194956036524,194956097363,194957045962,194956026558,194963004958");
errorder.append(",194938075615,194901011118,194965077195,194966061196,194967005288,194967072974,194967027745");
errorder.append(",194970027818,194970096115,194971043955,194971086296,194972022493,194974042597,194975005675");
errorder.append(",194975080736,194976068226,194977097334,194979066021,194982031422,194982034011,194982069382");
errorder.append(",194984052092,195989082266,195989098357,195991025762,196002023895,196004016396,196006017132");
errorder.append(",196009026244,196015066784,196017011451,196018089822,196022007759,196033022538,196043089158");
errorder.append(",196053023075,196068028343,196068056639,196070007594,196071018158,196059077162,196082051936");
errorder.append(",196089033844,196092083912,196103099082,196110012681,196112091794,197114087245,197120073267");
errorder.append(",197121044313,197121057542,197127045527,197135052153,197146061102,197152006380,197168001033");
errorder.append(",197169009209,197170014320");
   
    try{
String shopid=paramMap.get("shopid").toString();
String acttime=paramMap.get("acttime").toString();
String sign=paramMap.get("sign").toString();

String data=paramMap.get("data").toString();

int ret=check(shopid,acttime,sign);
System.out.println(ret);
if(ret==0){
		 JSONObject  jsonob = JSONObject.fromObject(data); 
	 String status = jsonob.getString("status");  
if("1".equals(status)){
	json.put("status", "1");

	String orders=jsonob.getString("orders");  
	JSONArray jsons = jsonob.getJSONArray("orders");  
    int jsonLength = jsons.size();  
    JSONArray jsonarr=new JSONArray();
    for(int i=0;i<jsonLength;i++){
    	JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
    	String orderid = tempJson.getString("orderid");  
    	String shipname = tempJson.getString("shipname");  
    	String shipcode = tempJson.getString("shipcode");  
    	System.out.println(tempJson.toString());
    	boolean sndflag=false;
    	if(errorder.indexOf(orderid)==-1){
    	 sndflag=sndodrok(orderid,shipname,shipcode,shopid);
    	}
    	JSONObject jsonitem = new JSONObject();

    	jsonitem.put("orderid", orderid);
    	jsonitem.put("sndstatus", sndflag);
    	jsonarr.add(jsonitem);
    }
    json.put("orders", jsonarr);
}else{
	json.put("status", "0");
}

}else{
	json.put("status", ret);
}

}catch(Exception ex){
	json.put("status", "-1");
}
}else{
	json.put("status", "-3");
}
    out.print(json);
    System.out.println(json);
    */
%>