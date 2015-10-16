<%@ page contentType="text/html; charset=GBK"%><%@ include file="validate.jsp" %><%@ page import="com.d1.bean.*,com.d1.helper.*,com.d1.util.*,java.util.ArrayList,java.util.List,org.hibernate.criterion.*,org.hibernate.*,com.d1.dbcache.core.*;" %><%!
public static List<GoodsGroupDetail> getGroupDetail(long mstid){
	if(mstid<=0) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(mstid)));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
	
	if(list == null || list.isEmpty()) return null;
	
	int size = list.size();
	
	List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
	for(int i=0;i<size;i++){
		GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
		Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		if(goods == null) continue;
		
		ggdList.add(ggd);
	}
	//只有一件物品了，也就没必要显示出来了。
	if(ggdList.size() <= 1) return null;
	
	return ggdList;
}
%><%
    /*获取聚惠系统传递过来的参数*/    
       //post过来的数据
           // http://www.url.com/cgi-bin/product_query?
		   //sign_type=md5&service_version=1.0&		   
		   //input_charset=gbk&sign_key_index=1&
		   //req_seq=10000001&product_id=100000&
		   //sign=12345678901234567890123456789012
		          
        String gdsid = request.getParameter("product_id");
        Product p = (Product)Tools.getManager(Product.class).get(gdsid);
        //输出各参数
         StringBuffer content = new StringBuffer(""); 
         content.append("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
         content.append("<root>");
         content.append("<sign_type>"+sign_type+"</sign_type>");
         content.append("<service_version>"+service_version+"</service_version>");
         content.append("<sign_key_index>"+sign_key_index+"</sign_key_index>");
         content.append("<res_seq>"+req_seq+"</res_seq>");
	    //response.sendRedirect("productzip.jsp?product_id="+gdsid);
	    String resultstr="";
	    ArrayList<String> results=new ArrayList<String>();
	   //if(result)
	   // {
	    	 
			    if(p!=null)
			    {
			    	
			    	content.append("<retcode>0</retcode>");
			    	content.append("<retmsg>查询成功</retmsg>");
			    	results.add("retcode=0");
			    	results.add("retmsg=查询成功");
			    	
			    	 content.append("<packet>http://www.d1.com.cn/inf/tenpay/productzip.jsp?product_id="+p.getId()+"</packet>");	        
				        String argsparam="";
				        if(p.getGdsmst_skuname1()!=null&&p.getGdsmst_skuname1().length()>0)
				        {
				        	
				        	ArrayList<Sku> lists=SkuHelper.getSkuListViaProductId(p.getId());
				        	if(lists!=null&&lists.size()>0)
				        	{
				        	for	(Sku sku:lists)
				        	{
				        		if(sku.getSkumst_sku1()!=null&&sku.getSkumst_sku1().length()>0)
				        		{
				        			argsparam+=sku.getSkumst_sku1()+"$";
				        		}
				        	}
				        	argsparam=argsparam.substring(0,argsparam.length()-1);
				        	content.append("<arg1>"+p.getGdsmst_skuname1()+"</arg1>");
				        	content.append("<value1>"+argsparam+"</value1>");
				        	results.add("arg1="+p.getGdsmst_skuname1());
				        	results.add("value1="+argsparam);
				        	}
				        }
				        
				        List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
						listRes.add(Restrictions.eq("gdsgrpdtl_gdsid", p.getId()));
						
						List listdail = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 1);
						
						if(listdail != null){
						
						GoodsGroupDetail gd = (GoodsGroupDetail)listdail.get(0);
						
						long ggId = Tools.longValue(gd.getGdsgrpdtl_mstid());
						List<GoodsGroupDetail> groupList = getGroupDetail(ggId);
						String relationstr="颜色";
						String relationvaluestr="";
						//1002323|红色$54646466|蓝色
						if(groupList!= null && !groupList.isEmpty()){
	
					    	for(GoodsGroupDetail ggd : groupList)
					    	{
					    		String gId = Tools.trim(ggd.getGdsgrpdtl_gdsid());
					    		Product goods = ProductHelper.getById(gId);
					    		if(goods!=null)
					    		{
					    			if (Tools.isNull(relationvaluestr)){
					    			  relationvaluestr=gId+"|"+ggd.getGdsgrpdtl_stdvalue();
					    			}else{
					    			  relationvaluestr+="$"+gId+"|"+ggd.getGdsgrpdtl_stdvalue();
					    			}
					    		}
					    	}		
					    	content.append("<relation1>"+relationstr+"</relation1>");
				        	content.append("<relationvalue1>"+relationvaluestr+"</relationvalue1>");
				        	results.add("relation1="+relationstr);
				        	results.add("relationvalue1="+relationvaluestr);
						}
						}
						
						
			    }
			    else
			    {
			    	content.append("<retcode>1</retcode>");
			        content.append("<retmsg>查询失败</retmsg>");	        
			        results.add("retcode=1");
			    	results.add("retmsg=查询失败");
			    }
			    results.add("packet=http://www.d1.com.cn/inf/tenpay/productzip.jsp?product_id="+p.getId());
				   
		        results.add("sign_type="+request.getParameter("sign_type"));
			    results.add("service_version="+request.getParameter("service_version"));
			    results.add("sign_key_index="+request.getParameter("sign_key_index"));
			    results.add("res_seq="+request.getParameter("req_seq"));
			    
			    
		        //整理返回字符串编码
			    
			    //ArrayList<String> list_ret = new ArrayList<String>();
			    //HashMap<String,String> map_ret = new HashMap<String,String>();
			
			    //for(String s:results)
			    //{
			    	//list_ret.add(stringToASCII(s));
			    	//map_ret.put(stringToASCII(s),s);
			   // }
			    
			    Collections.sort(results);
			
		        String signtype = "";
		    
			    //if(list_ret!=null){
			    	//for(String x:list_ret){
			    		//String ps = map_ret.get(x);
			    		//signtype+=ps+"&";
			    		//}
			    	//}
			    
		        if(results!=null){
		        	for(String x:results){
		        		
		        		signtype+=x+"&";
		        	
		        	}
		        }
			    signtype+="key=zyshu910320flzhen930622clhuang87";
			   // signtype+="key=123456";
		        //out.print(signtype);
			    if(result)
			    {
			    	content.append("<sign>"+com.d1.util.MD5.to32MD5(signtype)+"</sign>");
			    }
       
	   //}
	   //else
	    //{
	   //	content.append("<retcode>200002</retcode>");
	  //	content.append("<retmsg>签名失败</retmsg>");
	    	
	   //}
	    content.append("</root>");
        response.setContentType("text/xml");
        out.print(content);
%>

       
		
 
 
 