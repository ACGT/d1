<%@ page contentType="text/html; charset=UTF-8"%><%@page import="
net.sf.json.JSONArray,
net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%><%@include file="public.jsp"%>
<%! static List getAllProduct(){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	clist.add(Restrictions.gt("gdsmst_memberprice",new Float(0)));
	clist.add(Restrictions.eq("id", "01401632"));
	return ProductHelper.manager.getList(clist, null, 0, 50);
}
public static ArrayList<Sku> getSkuList(String productId){
	
	if(Tools.isNull(productId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productId));

	BaseManager manager = Tools.getManager(Sku.class);
	List<BaseEntity> list = manager.getList(clist, null, 0, 100);
	
	ArrayList<Sku> rlist = new ArrayList<Sku>();
	if(list!=null&&list.size()>0){
		for(BaseEntity sku:list){
			rlist.add((Sku)sku);
		}
	}
	return rlist ;
}
public static String getCategoryJson(String strheader,String cid){
		
		StringBuilder sb100=new StringBuilder();
		sb100.append("{"+strheader+",");
		sb100.append("\"body\":{");
		sb100.append("\"cid\": \""+cid+"\"");
		sb100.append("}");
		sb100.append("}");
		//System.out.println("post========================="+sb100);
        // String retstr=HttpUtil.postData("https://api.baidu.com/json/wg/v1/ProductService/queryCategoryAttrs", sb100.toString(), "utf-8");
         String retstr=HttpUtil.postData("https://sfapitest.baidu.com/json/wg/v1/ProductService/queryCategoryAttrs", sb100.toString(), "utf-8");

         return retstr;

}
%><%
   String gdsid=request.getParameter("gdsid");
   /*Product product = ProductHelper.getById(gdsid);
   if(product==null){
	   out.print("商品不存在或已经下架！");
		return;
   }*/
   String cid = "";
   ProductManager manager = (ProductManager)ProductHelper.manager;
   List<Product> list = manager.getTotalProductList();
   String ret="1";
   if(list==null || list.size()==0){
   	list=getAllProduct();
   }

   String strheader=getHeader();
   if(list!=null && list.size()>0){
	   int allnum=list.size();
	   //allnum=50;
	   StringBuilder sbgds=new StringBuilder();
	   int pagesnum=0;
       for(int j=0;j<allnum;j++){
      		Product p=list.get(j);
      		
      		if(p.getGdsmst_validflag()!=1||p.getGdsmst_memberprice().floatValue()==0
      				||p.getGdsmst_ifhavegds().longValue()!=0||p.getGdsmst_rackcode().startsWith("012"))continue;
      	    gdsid=p.getId();
      	  // System.out.println(gdsid);
      		String gdsname=Tools.clearHTML(p.getGdsmst_gdsname());
      		float gdsprice=p.getGdsmst_memberprice().floatValue();
      		float saleprice=p.getGdsmst_saleprice().floatValue();
      		String brandname=p.getGdsmst_brandname();
      		long gdsstock=p.getGdsmst_virtualstock().longValue();
   		    String strBriefIntroduce = Tools.clearHTML(p.getGdsmst_briefintrduce().trim()).replace("&", "");
   		 	String gdsmst_rackcode = p.getGdsmst_rackcode();
   		 	if(strBriefIntroduce.length()>1000){
        		strBriefIntroduce = Tools.substring(strBriefIntroduce, 1000);
        	}
   			String gimgsmall=p.getGdsmst_bigimg();
			if(!Tools.isNull(gimgsmall)){
				if(gimgsmall.startsWith("/shopimg/gdsimg")){
					gimgsmall = "http://images1.d1.com.cn"+gimgsmall.trim();
				}else{
					gimgsmall = "http://images.d1.com.cn"+gimgsmall.trim();
				}
			}
       	   
   	     	String pdetail ="";

 		//p.getGdsmst_detailintruduce();
 /*pdetail=pdetail.replaceAll("<a.*?/a>", "");
 pdetail=pdetail.replaceAll("<A.*?/A>", "");
 pdetail=pdetail.replaceAll("<MAP.*?/MAP>", "");
 pdetail=pdetail.replaceAll("<map.*?/map>", "");
	pdetail=pdetail.replaceAll("<AREA.*?>", "");
	pdetail=pdetail.replaceAll("<area.*?>", "");
	pdetail=pdetail.replaceAll("<SCRIPT.*?/SCRIPT>","");
	pdetail=pdetail.replace("&nbsp;","");
	pdetail=pdetail.replaceAll("\r\n", "");
	pdetail="<![CDATA["+pdetail+"]]> ";*/
   			
      	   List<Sku> skulist=null;
           if(!Tools.isNull(p.getGdsmst_skuname1())){
             skulist=getSkuList(gdsid);
           }
           
           if(skulist!=null && skulist.size()>0){
	           for(Sku sku:skulist){
		       		gdsstock=sku.getSkumst_vstock();
		       		sbgds.append("{");
		    		sbgds.append("\"product_id\":\""+gdsid+sku.getSkumst_sku1()+"\",");          // SKU ID
		    		sbgds.append("\"loc\":\"http://www.d1.com.cn/product/"+gdsid+"\",");           //商品在商家网站的URL
		       		sbgds.append("\"name\": \""+gdsname +"\",");   //商品名称
		    		sbgds.append("\"title\":\""+gdsname+"\",");  //商品标题
		    		sbgds.append("\"price\":\""+gdsprice+"\",");      //价格
		    		sbgds.append("\"value\":\""+gdsprice+"\","); //原价     
		    		sbgds.append("\"brand\":\""+brandname+"\",");            //品牌
		    		sbgds.append("\"stock\":\""+gdsstock+"\",");               //库存
		    		if(gdsmst_rackcode.substring(0, 3).equals("014")){
		    			cid = "7026";//化妆品
		    		}
		    		System.out.println("====="+gdsmst_rackcode.substring(0, 3));
		    		sbgds.append("\"cid\":\""+cid+"\",");
		    		//sbgds.append("\"cid\":\"1442\",");//1442                //对应 微购 的品类ID
		    		/*sbgds.append("\"category\":\"男装\",");           //一级类目 //  1376	服装配饰	1427	男装	1442
		    		sbgds.append("\"sub_category\":\"卫衣\",");        //二级类目
		    		sbgds.append("\"third_category\":\"\",");      //三级类目
		    		sbgds.append("\"fouth_category\":\"\",");*/      //四级类目         
		    		sbgds.append("\"description\":\""+strBriefIntroduce+"\",");  //商品详细描述
		     		sbgds.append("\"image\":\""+gimgsmall+"\",");  //主图
		    		sbgds.append("\"address\":\"全国\","); //送货范围
		    		sbgds.append("\"post_pay\":\"1\","); //是否支持货到付款, 0表示不支持, 1表示支持
		    		sbgds.append("\"seller_name\":\"D1优尚网\",");        //商家名称
		    		sbgds.append("\"pay_online\":\"是\","); //是否支持在线支付, "是" 或者 "否" 
		    		String catejson=getCategoryJson(strheader,cid);
    				sbgds.append("\"props\":[");
    				JSONObject json = JSONObject.fromObject(catejson);
    				String retheader=json.getString("header");
    				//if(retheader!=null&&retheader.equals("")){
    					String odrbody=json.getString("body");
    					JSONObject jsonbody = JSONObject.fromObject(odrbody);
    					String reqdata=jsonbody.getString("data");
    					reqdata=reqdata.substring(1);
    					reqdata=reqdata.substring(0,reqdata.length()-1);
    					
    				 	JSONObject jsondata = JSONObject.fromObject(reqdata); 				
    					String reqresult=jsondata.getString("result");
    					//System.out.println("reqresult===="+reqresult);
    					JSONObject jsonreqresult = JSONObject.fromObject(reqresult);
    					JSONArray jsonSkuArray = (JSONArray) jsonreqresult.get("required");
    					int jsonLength = jsonSkuArray.size(); 
    				  	for (int i = 0; i < jsonSkuArray.size(); ++i) {
	    			   		JSONObject itemJson = JSONObject.fromObject(jsonSkuArray.get(i));  
	    			   		String catename=itemJson.getString("name");
	    			   		String catevalue=itemJson.getString("values");
	    			   		if(!Tools.isNull(catevalue)){
	    			   			catevalue=catevalue.replace("{", "");
	    			   			catevalue=catevalue.replace("}", "");
	    			   		}
	    			   		catevalue="11";
	    			   		//if(gdsmst_rackcode.substring(0, 3).equals("014")){}//化妆品
	    				    sbgds.append("{");
	                        sbgds.append("\"name\":\""+catename+"\",");
	                        sbgds.append("\"value\":\""+catevalue+"\"");  //副图
	                        sbgds.append(" },");
	                        //System.out.println(catename+"===="+catevalue);
    			   	    }
    			   
                                 
                     sbgds.append("]");
                     sbgds.append("},");
                     pagesnum=pagesnum+1;
                     
                     GdsBaiDu gbadd=(GdsBaiDu)Tools.getManager(GdsBaiDu.class).get(gdsid+sku.getSkumst_sku1());
                     if(gbadd==null){
	                     gbadd.setId(gdsid+sku.getSkumst_sku1());
	                     gbadd.setGdsbaidu_barcode("");
	                     gbadd.setGdsbaidu_brand(brandname);
	                     gbadd.setGdsbaidu_cid(new Long(100));
	                     gbadd.setGdsbaidu_description(strBriefIntroduce);
	                     gbadd.setGdsbaidu_gdsid(gdsid);
	                     gbadd.setGdsbaidu_image(gimgsmall);
	                     gbadd.setGdsbaidu_line("online");
	                     gbadd.setGdsbaidu_major(new Long(0));
	                     gbadd.setGdsbaidu_postpay("1");
	                     gbadd.setGdsbaidu_price(new Double(gdsprice));
	                     gbadd.setGdsbaidu_promotion(new Long(0));
	                     gbadd.setGdsbaidu_stock(new Long(gdsstock));
	                     Tools.getManager(GdsBaiDu.class).create(gbadd);
                     }
           
           		}
           }else{
           
	        	sbgds.append("{");
	       		sbgds.append("\"product_id\":\""+gdsid+"\",");          // SKU ID
	       		sbgds.append("\"loc\":\"http://www.d1.com.cn/product/"+gdsid+"\",");           //商品在商家网站的URL
	       		sbgds.append("\"name\": \""+gdsname+"\",");   //商品名称
	       		sbgds.append("\"title\":\""+gdsname+"\",");  //商品标题
	       		sbgds.append("\"price\":\""+gdsprice+"\",");      //价格
	       		sbgds.append("\"value\":\""+saleprice+"\","); //原价     
	       		sbgds.append("\"brand\":\""+brandname+"\",");            //品牌
	       		sbgds.append("\"stock\":\""+gdsstock+"\",");               //库存
	       		if(gdsmst_rackcode.substring(0, 3).equals("014")){
	    			cid = "7026";//化妆品
	    		}
	       		sbgds.append("\"cid\":\""+cid+"\",");           //对应 微购 的品类ID
	       		sbgds.append("\"category\":\"男装\",");         //一级类目
	       		sbgds.append("\"sub_category\":\"卫衣\",");     //二级类目
	       		sbgds.append("\"third_category\":\"\",");      //三级类目
	       		sbgds.append("\"fouth_category\":\"\",");      //四级类目
	   	     	sbgds.append("\"description\":\""+strBriefIntroduce+"\",");     //商品详细描述
	       		sbgds.append("\"image\":\""+gimgsmall+"\",");  //主图
	       		sbgds.append("\"address\":\"全国\","); //送货范围
	       		sbgds.append("\"post_pay\":\"是\","); //是否支持货到付款, "是" 或者 "否"
	       		sbgds.append("\"seller_name\":\"D1优尚网\",");        //商家名称
	    		sbgds.append("\"pay_online\":\"是\","); //是否支持在线支付, "是" 或者 "否" 
	    		String catejson=getCategoryJson(strheader,cid);
	    		//System.out.println("catejson========================="+catejson);
				sbgds.append("\"props\":[");
				JSONObject json = JSONObject.fromObject(catejson);
				String retheader=json.getString("header");
				//if(retheader!=null&&retheader.equals("")){
				String odrbody=json.getString("body");
				//	System.out.println("get========================="+odrbody);
				JSONObject jsonbody = JSONObject.fromObject(odrbody);
				String reqdata=jsonbody.getString("data");
				reqdata=reqdata.substring(1);
				reqdata=reqdata.substring(0,reqdata.length()-1);
				JSONObject jsondata = JSONObject.fromObject(reqdata);
				String reqresult=jsondata.getString("result");
				JSONObject jsonreqresult = JSONObject.fromObject(reqresult);
				//String requiredlist=jsonreqresult.getString("required");
				//requiredlist=requiredlist.substring(1);
				//requiredlist=requiredlist.substring(0,requiredlist.length()-1);
		   		//JSONObject jsoncatelist = JSONObject.fromObject(requiredlist);
		   		
		   		JSONArray jsoncatelist = (JSONArray) jsonreqresult.get("required");
				int jsonLength = jsoncatelist.size(); 
			   	for (int i = 0; i < jsonLength; i++) {
			   		JSONObject itemJson = JSONObject.fromObject(jsoncatelist.get(i));  
			   		String catename=itemJson.getString("name");
			   		String catevalue=itemJson.getString("values");
			   		if(!Tools.isNull(catevalue)){
			   			catevalue=catevalue.replace("{", "");
			   			catevalue=catevalue.replace("}", "");
			   		}
			   		catevalue="11";
	                sbgds.append("{");
                    sbgds.append("\"name\":\""+catename+"\",");
                    sbgds.append("\"value\":\""+catevalue+"\"");  //副图
                    sbgds.append(" }");
                    if(i < jsonLength-1){
                    	sbgds.append(" ,");
                    }
                	//System.out.println(catename+"===="+catevalue);
			   	 }
                     sbgds.append("]");
 
                     sbgds.append("},");
                     System.out.println("=============sbgds=="+sbgds);
                     pagesnum=pagesnum+1;
                     GdsBaiDu gbadd=new GdsBaiDu();
                     gbadd.setId(gdsid);
                     gbadd.setGdsbaidu_barcode("");
                     gbadd.setGdsbaidu_brand(brandname);
                     gbadd.setGdsbaidu_cid(new Long(100));
                     gbadd.setGdsbaidu_description(strBriefIntroduce);
                     gbadd.setGdsbaidu_gdsid(gdsid);
                     gbadd.setGdsbaidu_image(gimgsmall);
                     gbadd.setGdsbaidu_line("online");
                     gbadd.setGdsbaidu_major(new Long(0));
                     gbadd.setGdsbaidu_postpay("1");
                     gbadd.setGdsbaidu_price(new Double(gdsprice));
                     gbadd.setGdsbaidu_promotion(new Long(0));
                     gbadd.setGdsbaidu_stock(new Long(gdsstock));
                     Tools.getManager(GdsBaiDu.class).create(gbadd);
                 	
           }

	if((pagesnum+1)%20==0||(j+1)==allnum){
		if(sbgds!=null&&sbgds.length()>0){
			StringBuilder sb100=new StringBuilder();
			sb100.append("{"+strheader+",");
			sb100.append("\"body\":{");
			sb100.append("\"products\":[");
			//sb100.append(sbgds.toString().substring(0, sbgds.length()-1));
			sb100.append(sbgds.toString().substring(0, sbgds.length()));
			sb100.append("]");
			sb100.append("}");
			sb100.append("}");
			sbgds.delete(0, sbgds.length());
			out.println(sb100.toString());
			FileWriter fw3 = new FileWriter(new File("baiduerror.txt"),true);
			fw3.write(new Date()+"商品ID："+gdsid+",ret="+sb100.toString()+System.getProperty("line.separator"));
			fw3.flush();
			fw3.close();
			//String retstr=HttpUtil.postData("https://api.baidu.com/json/wg/v1/ProductService/addProducts", sb100.toString(), "utf-8");
			String retstr=HttpUtil.postData("https://sfapitest.baidu.com/json/wg/v1/ProductService/addProducts", sb100.toString(), "utf-8");
			System.out.println("=============sbgds2=="+sb100);
			FileWriter fw4 = new FileWriter(new File("baiduerror.txt"),true);
			fw4.write(new Date()+"商品ID："+gdsid+",ret="+retstr+System.getProperty("line.separator"));
			fw4.flush();
			fw4.close();
			JSONObject json = JSONObject.fromObject(retstr);
			String retheader=json.getString("header");
			JSONObject  jsonheader = JSONObject.fromObject(retheader); 
			String status=jsonheader.getString("status");
			String desc=jsonheader.getString("desc");
		  	if(!status.equals("0")){
		  		
			    //String failures=jsonheader.getString("failures");
			    //failures=failures.substring(1);
			    //failures=failures.substring(0,failures.length()-1);
			    //JSONObject failuresjson = JSONObject.fromObject(failures);
			    JSONArray failuresjson = (JSONArray) jsonheader.get("failures");
		   		int jsonLength = failuresjson.size(); 
		   		for (int i = 0; i < jsonLength; i++) { //创建订单明细
		   			//System.out.println("2222222222="+failuresjson.get(i));
		   			JSONObject itemJson = JSONObject.fromObject(failuresjson.get(i)); 
		   			String content=itemJson.getString("content");
		   			if(!Tools.isNull(content)){
			   			String[] arrcontent=content.split(",");
			   			String bdsku=arrcontent[0];
			   			if(content.length()>11){
			   				bdsku=bdsku.substring(11);
			   			}
			   			Tools.getManager(GdsBaiDu.class).delete(bdsku);
		   			}
		   		}
			   System.out.println("百度微购增加商品失败："+desc);
			   FileWriter fw = new FileWriter(new File("/var/baiduerror.txt"),true);
			   fw.write(new Date()+"商品ID："+gdsid+",ret="+retheader+System.getProperty("line.separator"));
			   fw.flush();
			   fw.close();
		   }else{
				System.out.println("百度微购增加商品成功："+desc);
		   }
	  
	 }
	}
  
}
}


%>