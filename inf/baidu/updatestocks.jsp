<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="public.jsp"%>
<%!
private  ArrayList<GdsBaiDu> getGdsBaiDuList(String online){
	ArrayList<GdsBaiDu> list=new ArrayList<GdsBaiDu>();
	List<SimpleExpression> rlist=new ArrayList<SimpleExpression>();
	rlist.add(Restrictions.eq("gdsvancl_onsale", online));
	List<BaseEntity> blist=Tools.getManager(GdsVancl.class).getList(null, null, 0, 1000);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity be:blist)
		{
			list.add((GdsBaiDu)be);
		}
	}
	return list;
}
private synchronized void  GoStorageSync(String strheader)
{
	StringBuilder sb=new StringBuilder();
	ArrayList<GdsBaiDu> list =getGdsBaiDuList("online");
	int allnum=list.size();
	int pagesnum=(int)Math.ceil(allnum/100f);
	for(int j=0;j<allnum;j++){
		GdsBaiDu gbd=list.get(j);
		String  gsku=gbd.getId();

	 String productId="";
   	 String psku="";
   	 long stockcount=0;
   	 if(gsku.length()>8){
			 productId=gsku.substring(0, 8);
			 psku=gsku.substring(8);
			}else{
				productId=gsku;
			}
   	Sku sku=null;
   	 if(!Tools.isNull(psku)){
   	  sku=SkuHelper.getSku(productId, psku);
   	   	 }
   	 Product product=ProductHelper.getById(productId);
   	 //System.out.println(productId+"-----"+psku);
   	 if(product!=null){
   	    if(sku!=null){
    		stockcount=sku.getSkumst_vstock().longValue();
    	  }else{
    		  if(Tools.isNull(psku)){
    		    stockcount=product.getGdsmst_virtualstock().longValue();
    		}else{
    			 System.out.println("百度库存更新失败="+gsku);
       		       try {
       		             FileWriter fw = new FileWriter(new File("/var/baiduerror.txt"),true);
    		   	         fw.write("库存更新失败="+gsku+System.getProperty("line.separator"));
    			         fw.flush();
    			         fw.close();
				         } catch (IOException e) {
					      // TODO Auto-generated catch block
					       e.printStackTrace();
				         }
    		   }
    	  }
   		sb.append("{");
   		sb.append("\"product_id\":\""+gsku+"\",");              // SKU ID
   		sb.append("\"items\":["); //更新全国库存,只要region填写"全国"就行
   		sb.append("{");
   		sb.append("\"region\":\"全国\",");  //国标统一名称
   		sb.append("\"stock\":"+stockcount+"");        //库存量
   		sb.append("}");
   		sb.append("]");
   		sb.append("},");

   	 }

		if((j+1)%100==0||(j+1)==allnum){
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
	            String retstr=HttpUtil.postData("https://api.baidu.com/json/wg/v1/ProductService/updateStocks", sb100.toString(), "utf-8");

	        	JSONObject json = JSONObject.fromObject(retstr);
	        	String retheader=json.getString("header");
	        	JSONObject  jsonheader = JSONObject.fromObject(retheader); 
	        	String status=jsonheader.getString("status");
	        	String desc=jsonheader.getString("desc");
	        	String failures=jsonheader.getString("failures");
	        	
	        	  if(!status.equals("0")){
	        	   System.out.println("百度微购更新库存失败："+desc);
	        	   try{
	        	   FileWriter fw = new FileWriter(new File("/var/baiduerror.txt"),true);
	        	   fw.write(new Date()+"百度微购更新库存失败内容："+failures+System.getProperty("line.separator"));
	        	   fw.flush();
	        	   fw.close();
	        	   }catch(Exception ex){
	        		   ex.printStackTrace();
	        	   }
	        	  }else{
	        		System.out.println("百度微购更新商品库存成功："+desc);
	        	  }
	        	 
	       // System.out.println("-----百度同步100个商品库存-------------");
		}
	}
	
}  
	//return "";
}
%>
<%
String strheader=getHeader();
GoStorageSync(strheader);
%>