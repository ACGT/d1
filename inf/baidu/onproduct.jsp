<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="public.jsp"%><%!
public static ArrayList<GdsBaiDu> getGdsBaiDuList(String gdsid,String line){
	
	if(Tools.isNull(gdsid))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsbaidu_gdsid", gdsid));
	String linel="";
	if(line.equals("online")){
		linel="offline";
	}else{
		linel="online";
	}
	clist.add(Restrictions.eq("gdsbaidu_line", linel));
	
	BaseManager manager = Tools.getManager(GdsBaiDu.class);
	List<BaseEntity> list = manager.getList(clist, null, 0, 100);
	
	ArrayList<GdsBaiDu> rlist = new ArrayList<GdsBaiDu>();
	if(list!=null&&list.size()>0){
		for(BaseEntity gdsbd:list){
			rlist.add((GdsBaiDu)gdsbd);
		}
	}
	return rlist ;
}
private synchronized void  GoOnProduct(String strheader,String strgdsid,String line){
	String[] arrgdsid=strgdsid.split(",");
	StringBuilder sb=new StringBuilder();
	int arrnum= arrgdsid.length;
	int j=0;
	for(int i=0;i<arrnum;i++){
	ArrayList<GdsBaiDu> glist=getGdsBaiDuList(arrgdsid[i],line);
	int gnum=glist.size();
	int gi=0;
	if(glist!=null&&gnum>0){
	for(GdsBaiDu gbd:glist){
		sb.append("{");
   		sb.append("\"product_id\":\""+gbd.getId()+"\",");  //SKU ID
   		sb.append("\"listing\":\""+line+"\"");        //上线  online 下线 offline
   		sb.append("},");
   		gbd.setGdsbaidu_line(line);
   		Tools.getManager(GdsBaiDu.class).update(gbd, false);
	if((j+1)%100==0||((i+1)==arrnum&&gi+1==gnum)){
		if(sb!=null&&sb.length()>0){
			StringBuilder sb100=new StringBuilder();
			sb100.append("{"+strheader+",");
			sb100.append("\"body\":{");
			sb100.append("\"products\":[");
			sb100.append(sb.toString().substring(0, sb.length()-1));
			sb100.append("]");
			sb100.append("}");
			sb100.append("}");
			sb.delete(0, sb.length());
			//return sb100.toString();
             String retstr=HttpUtil.postData("https://api.baidu.com/json/wg/v1/ProductService/updateOnlineOrOff", sb100.toString(), "utf-8");

        	JSONObject json = JSONObject.fromObject(retstr);
        	String retheader=json.getString("header");
        	JSONObject  jsonheader = JSONObject.fromObject(retheader); 
        	String status=jsonheader.getString("status");
        	String desc=jsonheader.getString("desc");
          	
        	  if(!status.equals("0")){
        		  String failures=jsonheader.getString("failures");
    			  JSONObject failuresjson = JSONObject.fromObject(failures);
    		  		int jsonLength = failuresjson.size(); 
    		  		for (int l = 0; l < jsonLength; l++) { //创建订单明细
    		  			JSONObject itemJson = JSONObject.fromObject(failuresjson.get(l)); 
    		   			String content=itemJson.getString("content");
    		   			String[] arrcontent=content.split(",");
    		   			String bdsku=arrcontent[0];
    		   			bdsku=bdsku.substring(11);
    		   			GdsBaiDu gdsbdup=(GdsBaiDu)Tools.getManager(GdsBaiDu.class).findByProperty("gdsbaidu_skuid", bdsku);
    		   			if(line.equals("online")){
    		   				gdsbdup.setGdsbaidu_line("offline");
    		   			}else{
    		   				gdsbdup.setGdsbaidu_line("online");
    		   			}
    		   			
    		   			Tools.getManager(GdsBaiDu.class).update(gdsbdup, false);
    		  		}
        	   System.out.println("百度微购上架商品失败："+desc);
        	   try{
        	   FileWriter fw = new FileWriter(new File("/var/baiduerror.txt"),true);
        	   fw.write(new Date()+"百度微购上架商品失败内容："+failures+System.getProperty("line.separator"));
        	   fw.flush();
        	   fw.close();
        	   }catch(Exception ex){
        		   ex.printStackTrace();
        	   }
        	  }else{
        		System.out.println("百度微购上架商品成功："+desc);
        	  }
        	 
        //System.out.println("-----百度同步100个商品库存-------------");
	   }
      }
	gi=gi+1;
	j=j+1;
    }
   }
  }
}
%>
<%
String strgdsid =request.getParameter("gdsid");
String line =request.getParameter("online");
if(!Tools.isNull(strgdsid)){
	String strheader=getHeader();
	GoOnProduct(strheader,strgdsid,line);
	
}else{
	out.println("商品ID不能为空");
}

%>