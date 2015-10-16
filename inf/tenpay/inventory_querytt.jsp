<%@ page contentType="text/html; charset=GBK"%><%@  include file="validate.jsp" %><%@ page  import="com.d1.bean.*,com.d1.helper.*,com.d1.util.*,org.hibernate.criterion.*,com.d1.dbcache.core.BaseEntity" %><%!
public static int getVirtualStock(String productId,String sku){
	Product product = (Product)Tools.getManager(Product.class).get(productId);
	if(product==null)return 0;
		if(product.getGdsmst_virtualstock()==null)return 0;
		if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==0)return 0;
		return product.getGdsmst_virtualstock().intValue();
}
public static ArrayList<Sku> getSkuListViaProductId(String productId){
	
	if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productId));
	//clist.add(Restrictions.eq("skumst_validflag", new Long(1)));//上架
	//clist.add(Restrictions.gt("skumst_stock", new Long(0)));//有库存
	
	List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 100);
	
	ArrayList<Sku> rlist = new ArrayList<Sku>();
	if(list!=null&&list.size()>0){
		for(BaseEntity sku:list){
			rlist.add((Sku)sku);
		}
	}
	return rlist ;
}
public static class TenpayRequestComparator 

implements Comparator {

public int compare(Object element1, 

Object element2) {

String lower1 = element1.toString();
String lower2 = element2.toString();
lower1=lower1.substring(0,lower1.indexOf("="));
lower2=lower2.substring(0,lower2.indexOf("="));
if (lower1.length()>lower2.length()){
	lower1=lower1.substring(0,lower2.length());
	int ret=lower1.compareTo(lower2);
	//System.out.println("返回结果："+ret);
	if (ret ==0){
		//System.out.println("返回结果："+ret);
		return 1;
	}else{
		return ret;
	}
}else if (lower1.length()<lower2.length()){
	lower2=lower2.substring(0,lower1.length());
	int ret=lower1.compareTo(lower2);
	if (ret ==0){
		return -1;
	}else{
		return ret;
	}
}else{
	int ret=lower1.compareTo(lower2);
	return ret;
}
}

}
%><%
/*获取聚惠系统传递过来的参数*/    
//post过来的数据
   // 批量查询库存参数
     //http://www.url.com/cgi-bin/inventory_query?
     //sign_type=md5&service_version=1.0&
     //input_charset=gbk&sign_key_index=1&
     //req_seq=10000001&method=0&product_id=100000&
     //sign=12345678901234567890123456789012
     
     // 单一商品查询库存参数
     //http://www.url.com/cgi-bin/inventory_query?
     //sign_type=md5&service_version=1.0&
     //input_charset=gbk&sign_key_index=1&
     //req_seq=10000001&method=0&product_id=100000&
     //sign=12345678901234567890123456789012
     //&arg1=红&arg2=38
    
   
      String gdsid = request.getParameter("product_id");
TenpayFee tenpayfee =(TenpayFee)Tools.getManager(TenpayFee.class).findByProperty("tenpayfee_gdsid", gdsid);
if(tenpayfee!=null){
	gdsid="0"+gdsid.substring(1,8);
}

//System.out.print("财付通库存接口："+gdsid);
      ArrayList<String> results=new ArrayList<String>();
        //输出各参数
       
        %><% //输出相应格式
        boolean stockno=false;
        long stockmsnum=6;
        TenpayNumFee tenpaygds =(TenpayNumFee)Tools.getManager(TenpayNumFee.class).findByProperty("tenpaynumfee_gdsstr", gdsid);
         if(tenpaygds!=null){
        	 stockmsnum=stockmsnum-tenpaygds.getTenpaynumfee_allmoney().longValue();
        	 stockno=true;
         }

        
        
        StringBuffer content = new StringBuffer(""); 
        content.append("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
        content.append("<root>");
        content.append("<sign_type>"+sign_type+"</sign_type>");
        content.append("<service_version>"+service_version+"</service_version>");
        content.append("<sign_key_index>"+sign_key_index+"</sign_key_index>");
        content.append("<res_seq>"+req_seq+"</res_seq>");
        
        
        	Product p=(Product)Tools.getManager(Product.class).get(gdsid);
        	boolean Stockflag=false;
        	if (p!=null){
        		if (p.getGdsmst_stocklinkty().longValue()==1||p.getGdsmst_stocklinkty().longValue()==2){
        			Stockflag=true;
        		}
        	}
       long counts=0;
        
	    if(arg1!=null&&arg1.length()!=0)
	    {
	    	counts=getVirtualStock(gdsid,arg1);
	    }
	    else
	    {
	    	counts=getVirtualStock(gdsid, "");
      
	    }
	    if(!Stockflag){
	    	counts=counts+50;
	    }

	   // if(counts>0)
	   // {
	    	content.append("<retcode>0</retcode><retmsg>查询成功</retmsg>");
	    	results.add("retcode=0");
	    	results.add("retmsg=查询成功");
	   // }
	    //获取某一商品
       if(arg1!=""&&arg1!=null)
        {
        	content.append("<total_num>1</total_num>");
        	ArrayList<Sku> lists = getSkuListViaProductId(gdsid);
    		if(lists!=null&&lists.size()>0)
    		{
    			for(Sku s:lists){
    		    				if (arg1.equals(s.getSkumst_sku1())){
    				 if(s.getSkumst_validflag()==0&&s.getSkumst_vstock().longValue()<=0){
    					 counts=0;
					  }
    				 else{
    					 //02000892  L
    					 if(Stockflag||(gdsid.equals("01517598")
    							 &&s.getSkumst_sku1().endsWith("L"))){
    					 counts=s.getSkumst_vstock().longValue();
    					 }else{
    						 counts=s.getSkumst_vstock().longValue()+50; 
    					 }
    				 }
    				}
    		}
    		}

    		if(stockno&&counts>0){
    			counts=stockmsnum;
    		}
        	content.append("<inventory_0>"+counts+"</inventory_0>");
            content.append("<lock_inventory_0>0</lock_inventory_0>");
            content.append("<arg1_0>"+arg1+"</arg1_0>");
            results.add("arg1_0="+arg1);
            results.add("total_num=1");
            results.add("inventory_0="+counts);
            results.add("lock_inventory_0=0");
            
        }
        else//获取商品库存 
        {
        	System.out.println("----------------------1-------------------");
        	if(ProductHelper.hasSku(p))
        	{	
        		ArrayList<Sku> lists = getSkuListViaProductId(gdsid);
        		if(lists!=null&&lists.size()>0)
        		{
        			System.out.println("----------------------2-------------------"+lists.size());
        			content.append("<total_num>"+lists.size()+"</total_num>");
        			results.add("total_num="+lists.size());
        			int sum=0;
        			long vstock=0;
        			for(Sku s:lists){
        				
    					if(s.getSkumst_stock()!=null){    
    						  //if(sum==10) {
    						   //     break;
    						   //  }
    						  vstock=s.getSkumst_vstock().longValue();
    						  if(s.getSkumst_validflag()==0){
    							  vstock=0;
    						  }
    						  if(stockno){
    							  vstock=stockmsnum;
    				    			Stockflag=true;
    				    		}

    						if(Stockflag){
    						content.append("<inventory_"+sum+">"+vstock+"</inventory_"+sum+">");
    						}else{
    						content.append("<inventory_"+sum+">"+(vstock+50)+"</inventory_"+sum+">");
    						}
    						content.append("<lock_inventory_"+sum+">0</lock_inventory_"+sum+">");
    						content.append("<arg1_"+sum+">"+s.getSkumst_sku1()+"</arg1_"+sum+">");
    						results.add("arg1_"+sum+"="+s.getSkumst_sku1());
    						if(Stockflag){
    							results.add("inventory_"+sum+"="+vstock);
    						}else{
    						results.add("inventory_"+sum+"="+(vstock+50));	
    						}
    						results.add("lock_inventory_"+sum+"=0");
    						
    						sum++;
    					}
    						
    					}
        		}  
        	}
    		else
        	{ 
    			if(stockno&&counts>0){
        			counts=stockmsnum;
        			Stockflag=true;
        		   }
    			content.append("<total_num>1</total_num>");
    			if(Stockflag){
    				content.append("<inventory_0>"+counts+"</inventory_0>");
    			}else{
    		    content.append("<inventory_0>"+(counts+50)+"</inventory_0>");
    			}
                content.append("<lock_inventory_0>0</lock_inventory_0>");
                results.add("total_num=1");
                if(Stockflag){
                	results.add("inventory_0="+counts);
                }else{
                results.add("inventory_0="+(counts+50));
                }
                results.add("lock_inventory_0=0");
                
        	}
    		
}

results.add("sign_type="+request.getParameter("sign_type"));
results.add("service_version="+request.getParameter("service_version"));
results.add("sign_key_index="+request.getParameter("sign_key_index"));
results.add("res_seq="+request.getParameter("req_seq"));

//整理返回字符串编码


Collections.sort(results,new TenpayRequestComparator());

String signtype = "";

if(results!=null){
	for(String x:results){
		
		signtype+=x+"&";
	
	}
}
signtype+="key=qimenghaoyed1234567ymzou51665136";
//signtype+="key=123456";
//out.print(signtype);
//System.out.println("d1gjl:"+signtype);
content.append("<sign>"+com.d1.util.MD5.to32MD5(signtype)+"</sign>");
        
        content.append("</root>");
        response.setContentType("text/xml");
        out.print(content);
        %>
 
