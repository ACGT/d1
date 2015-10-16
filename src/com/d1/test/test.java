package com.d1.test;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.OrderTenpay;
import com.d1.bean.Product;
import com.d1.bean.Sku;
import com.d1.dbcache.core.BaseEntity;
import com.d1.helper.ProductStandardHelper.Standard;
import com.d1.helper.SkuHelper;
import com.d1.util.Tools;
import com.mysql.jdbc.log.Log;

public class test {
	private static Standard getStandard(long showFlag,String atrname , String atrdtl , int c){
		Standard s = null;
		if(showFlag == 2){
			s = new Standard();
			s.setAtrFlag(c);
			s.setAtrname(atrname);
			s.setAtrdtl(atrdtl);
		}
		return s;
	}
	
	/*public   class Client implements Comparable {   
	    String id;   
	    public Client(String id){   
	        this.id=id;   
	    }   
	    public int compareTo(Object arg0) {   
	        Client c=(Client) arg0;   
	        String s2 = c.id.toLowerCase();        
	        String s1 = this.id.toLowerCase();  
	        System.out.println("compareTo--s1="+s1);
	        System.out.println("compareTo--s2="+s2);
	        if (s1.charAt(0) > s2.charAt(0)||"".equals(s2.charAt(0))) {    
	            return 1;   
	        } else if (s1.charAt(0) < s2.charAt(0)||"".equals(s1.charAt(0))) {        
	            return -1;   
	        } else {        
	            if(s1.length()==s2.length())        
	                return s1.compareTo(s2);        
	            else if(s1.length()>s2.length())        
	                return s1.compareTo(s2);        
	            return 0;   
	        }        
	    }   
	}
	public static class ClientIDComparator implements Comparator{      
		  public int compare(Object computer1, Object computer2) { 
			  
		        String s1 = ((String) computer1).toLowerCase();      
		        String s2 = ((String) computer2).toLowerCase();  
		        
		        s1=s1.substring(0,s1.indexOf("="));
		        s2=s2.substring(0,s2.indexOf("="));
		        if (s1.charAt(0) > s2.charAt(0)||"".equals(s2.charAt(0))) {      
		            return 1;      
		        } else if (s1.charAt(0) < s2.charAt(0)||"".equals(s1.charAt(0))) {      
		            return -1;      
		        } else {      
		            if(s1.length()==s2.length()){      
		            	 //System.out.println( s1+"---"+s2+"----"+s1.compareTo(s2));
		                return s1.compareTo(s2);    
		            }
		            else if(s1.length()>s2.length()){   
		            	return s1.compareTo(s2); 
		            }     
		            return 0;      
		        }      
		              
		 }      
		}     
*/
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
	public static class CaseInsensitiveComparator 

	implements Comparator {

	public int compare(Object element1, 

	Object element2) {

	String lower1 = element1.toString();
	String lower2 = element2.toString();
	lower1=lower1.substring(0,lower1.indexOf("="));
	lower2=lower2.substring(0,lower2.indexOf("="));
	System.out.println(lower1);
	System.out.println(lower2);
	if (lower1.length()>lower2.length()){
		lower1=lower1.substring(0,lower2.length());
		System.out.println(lower1);
		System.out.println(lower2);
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
			return 1;
		}else{
			return ret;
		}
	}else{
		int ret=lower1.compareTo(lower2);
		return ret;
	}
	}

	}

	public static void main(String[] args)throws Exception{
	
/*
		
		String gdsid = "01721266";
		//System.out.print("财付通库存接口："+gdsid);
		      ArrayList<String> results=new ArrayList<String>();
		        //输出各参数
		       
	
		        
		        
		        
		        StringBuffer content = new StringBuffer(""); 
				        
		        //if(result)
		        //{
		        	Product p=(Product)Tools.getManager(Product.class).get(gdsid);
		        	boolean Stockflag=false;
		        	if (p!=null){
		        		if (p.getGdsmst_stocklinkty().longValue()==1||p.getGdsmst_stocklinkty().longValue()==2){
		        			Stockflag=true;
		        		}
		        	}
		       long counts=0;
		        
			
			    	counts=getVirtualStock(gdsid, "");
		      
		
			    if(!Stockflag){
			    	counts=counts+10;
			    }
			    if(counts>0)
			    {
			    	content.append("<retcode>0</retcode><retmsg>查询成功</retmsg>");
			    	results.add("retcode=0");
			    	results.add("retmsg=查询成功");
			    }

		        
		        	if(ProductHelper.hasSku(p))
		        	{
		        		ArrayList<Sku> lists = getSkuListViaProductId(gdsid);
		        		if(lists!=null&&lists.size()>0)
		        		{
		        			content.append("<total_num>"+lists.size()+"</total_num>");
		        			results.add("total_num="+lists.size());
		        			int sum=0;
		        			long vstock=0;
		        			for(Sku s:lists){
		    					if(s.getSkumst_stock()!=null){    
		    						 // if(sum==10) {
		    						   //     break;
		    						   //  }
		    						  vstock=s.getSkumst_vstock().longValue();
		    						  if(s.getSkumst_validflag()==0){
		    							  vstock=0;
		    						  }
		    						  
		    						if(Stockflag){
		    						content.append("<inventory_"+sum+">"+vstock+"</inventory_"+sum+">");
		    						}else{
		    						content.append("<inventory_"+sum+">"+(vstock+10)+"</inventory_"+sum+">");
		    						}
		    						content.append("<lock_inventory_"+sum+">0</lock_inventory_"+sum+">");
		    						content.append("<arg1_"+sum+">"+s.getSkumst_sku1()+"</arg1_"+sum+">");
		    						results.add("arg1_"+sum+"="+s.getSkumst_sku1());
		    						if(Stockflag){
		    							results.add("inventory_"+sum+"="+vstock);
		    						}else{
		    						results.add("inventory_"+sum+"="+(vstock+10));	
		    						}
		    						results.add("lock_inventory_"+sum+"=0");
		    						
		    						sum++;
		    					}
		    						
		    					}
		        		}  
		      
		    		
		}

		        	System.out.println("d1gjlCollections1:"+results);
		Collections.sort(results,new TenpayRequestComparator());
		System.out.println("d1gjlCollections1:"+results);
		//Collections.sort(results, compar);
		String signtype = "";

		if(results!=null){
			for(String x:results){
				
				signtype+=x+"&";
			
			}
		}
		signtype+="key=qimenghaoyed1234567ymzou51665136";
		//signtype+="key=123456";
		//out.print(signtype);
		System.out.println("d1gjlCollections:"+signtype);
		
	
		 /*ArrayList<String> strs=new ArrayList<String>();
	        //strs.add("retcode=0");
	        //strs.add("total_num=25");
	        strs.add("a1_1=白色L");
	        //strs.add("inventory_0=0");
	        //strs.add("lock_inventory_0=0");
	       
	        strs.add("a1_2=白色L");
	        strs.add("a1_12=白色L");
	        strs.add("a1_13=白色L");
	        strs.add("a1_23=白色L");
	        strs.add("a1_33=白色L");
	        strs.add("a1_5=白色L");
	        strs.add("a1_24=白色L");
	        strs.add("a1_15=白色L");
	        strs.add("a1_7=白色L");
	      //  strs.add("inventory_1=0");
	      /* strs.add("lock_inventory_1=0");
	        strs.add("arg1_2=白色L");
	        strs.add("inventory_2=0");
	        strs.add("lock_inventory_2=0");
	        strs.add("arg1_11=白色L");
	        strs.add("inventory_11=0");
	        strs.add("lock_inventory_11=0");
	        strs.add("arg1_12=白色L");
	        strs.add("inventory_12=0");
	        strs.add("lock_inventory_12=0");  
	        Collections.sort(strs,new ClientIDComparator());
	        System.out.println("strs:"+strs);
	        
	        String signtype = "";

	        if(strs!=null){
	        	for(String x:strs){
	        		
	        		signtype+=x+"&";
	        	
	        	}
	        }
		        System.out.println("d1gjlCollections:"+signtype);*/
	        
		// Comparator<String> cmp = new Comparator<String>() {

	        	 /* public int compare(String str1, String str2) {

               // 字母部分
               String alphabet1 = str1.replaceAll("\\d+$", "");
               String alphabet2 = str2.replaceAll("\\d+$", "");

               // 如果不想区分大小写，否则compareTo
               int cmpAlphabet = alphabet1.compareToIgnoreCase(alphabet2);
               if (cmpAlphabet != 0) {
                 return cmpAlphabet;
               }

               // 数字部分
               String numeric1 = str1.replaceAll("^[a-zA-Z]+", "");
               String numeric2 = str2.replaceAll("^[a-zA-Z]+", "");
               if ("".equals(numeric1)) {
                 // 即使numeric2也是空串也无所谓，当然，如果比较的不是String（或其他immutable对象）则另当别论
                 return -1;
               }
               if ("".equals(numeric2)) {
                 return 1;
               }
               int num1 = Integer.parseInt(numeric1);
               int num2 = Integer.parseInt(numeric1);
               return num1 - num2;
             }
           };
		    Collections.sort(strs,cmp);


			
	        String signtype = "";

	        if(strs!=null){
	        	for(String x:strs){
	        		
	        		signtype+=x+"&";
	        	
	        	}
	        }
		        System.out.println("d1gjlCollections:"+signtype);

 
	     /*  String[] array = new String[] {
		                "D1", "D11", "D12", "D13", "D2", "D3", "H", "F0", "h1", "h0", "f1",
		              "F2", "d9", "1","d91","d92"
		           };
	       
		  ArrayList<String> strs=new ArrayList<String>();
	       strs.add("d1");
	       strs.add("a1");
	       strs.add("a2");
	       strs.add("d2");
	       strs.add("d11");
	       strs.add("d3");
	       strs.add("d13");
	       strs.add("a1_1=白色L");
	        strs.add("a1_13=白色L");
	        strs.add("a1_2=白色L");
	        strs.add("a1_2=白色L");
		            // 假设所有情况都是字母在前，数字在后
		            Comparator<String> cmp = new Comparator<String>() {

		              public int compare(String str1, String str2) {

		                // 字母部分
		                String alphabet1 = str1.replaceAll("\\d+$", "");
		                String alphabet2 = str2.replaceAll("\\d+$", "");

		                // 如果不想区分大小写，否则compareTo
		                int cmpAlphabet = alphabet1.compareToIgnoreCase(alphabet2);
		                if (cmpAlphabet != 0) {
		                  return cmpAlphabet;
		                }

		                // 数字部分
		                String numeric1 = str1.replaceAll("^[a-zA-Z]+", "");
		                String numeric2 = str2.replaceAll("^[a-zA-Z]+", "");
		                if ("".equals(numeric1)) {
		                  // 即使numeric2也是空串也无所谓，当然，如果比较的不是String（或其他immutable对象）则另当别论
		                  return -1;
		                }
		                if ("".equals(numeric2)) {
		                  return 1;
		                }
		                int num1 = Integer.parseInt(numeric1);
		                int num2 = Integer.parseInt(numeric1);
		                return num1 - num2;
		              }
		            };
		            Collections.sort(strs,cmp);

		            //Arrays.sort(strs, cmp);
				      System.out.println("d1gjlCollections:"+strs);
		           // Arrays.sort(array, cmp);

		           //System.out.println(Arrays.toString(array));
		          
  */ 

//http://www.baidu.com/s?word=%D3%C5%C9%D0&tn=sitehao123

//http://www.baidu.com/s?word=d1%E4%BC%98%E5%B0%9A%E7%BD%91&tn=sitehao123
		/*String ssss="http://www.baidu.com/s?word=d1%E4%BC%98%E5%B0%9A%E7%BD%91&tn=sitehao123";
		System.out.println(URLDecoder.decode(ssss,"utf-8"));
		System.out.println(URLDecoder.decode(ssss,"GBK"));*/
		//Standard s = getStandard(2,"材质","丝/绸;灯芯绒;网纱;毛呢;蕾丝;雪纺;开司米;PU;棉;真皮;聚脂纤维;亚麻;牛仔;其它",1);
		
		//System.out.println(s.toString());
		//String sss="create_time=20120913140056&input_charset=gbk&product_count_0=1&product_id_0=01515602&product_money_0=5900&recv_addr=聚惠测试&recv_area=崇文区&recv_city=北京市&recv_mobile=15012550000&recv_name=聚惠测试&recv_province=北京&recv_zipcode=100000&req_seq=201209131000122487&service_version=1.0&sign_key_index=1&sign_type=md5&total_product_type=1&transaction_id_0=2201164501201209130000126217&key=zyshu910320flzhen930622clhuang87";
		/*String sss="input_charset=gbk&method=1&product_id=01515602&req_seq=201209131000122587&service_version=1.0&sign_key_index=1&sign_type=md5&key=zyshu910320flzhen930622clhuang87";
		String sign = com.d1.util.MD5.to32MD5(sss);
		
		
		sign = sign.toUpperCase();
		System.out.print(sign);*/

		/*SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		java.util.Date   nowszf=new   java.util.Date();   
		java.util.Date   dates=df2.parse("2012-7-27 18:30:00");
		//int zfcount=(int)(nowszf.getTime()/3600/60-dates.getTime()/3600/60)*13;
		System.out.println((nowszf.getTime()-dates.getTime())/1000/60);
		
	
System.out.println(Tools.clearHTML("L’oreal 欧莱雅雪颜美白滋润霜SPF15 50ml"));
Random rndcard = new Random();
String timestr=16+rndcard.nextInt(5)+"";

System.out.println(timestr);
String minstr="0"+rndcard.nextInt(59);
timestr=timestr+":"+minstr.substring(minstr.length()-2)+":00";
System.out.println(timestr);

SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String daystr="2012-7-30";
Date actendDate=null;
timestr=daystr+" "+timestr;
System.out.println(timestr);
try{
	   actendDate=fmt2.parse(timestr);
	 }
catch(Exception ex){
	ex.printStackTrace();
}
System.out.println(actendDate);*/
//	String url="http://www.d1.com.cn//sales/salesviews.jsp?id=257";
	//System.out.print(URLEncoder.encode(URLEncoder.encode(url,"utf-8"),"utf-8"));
		
		//判断一下，以防万一
	//	if(res>CartHelper.getNormalProductMoney(request, response)){
		//	res = CartHelper.getNormalProductMoney(request, response) ;
		//}
		
		 //Product p1=ProductHelper.getById("00000002");
          //  p1.setGdsmst_gdsname("泰华尚品-天然红玛瑙手镯");
		  //  Tools.getManager(Product.class).update(p1, false);
		//【BINNIB威尼卡】男士运动风直摆短款羽绒服（深紫）(‘
		//01715913St170y

	 /*String out_sku_id="01719626#zMzi175-92Ao";
	String productid=out_sku_id.substring(0,8);
	String psku=out_sku_id.substring(8);
	 System.out.println(productid);
	System.out.println(repstr(psku));*/
	 //String addressId="dddd";
		//平安前缀：https://www.wanlitong.com/needLogin.do?gURL=https://www.d1.com.cn/pingan/pingan.asp?method=
		//String strcode="http://www.d1.com.cn/result.jsp?productsort=023&productbrand=马汀尼&bf=1";
	   // System.out.print(URLEncoder.encode(URLEncoder.encode(strcode,"utf-8"),"utf-8"));
	
		//System.out.println("D1&WLT@)!@");
		//float price=2.2f;
		//DecimalFormat df = new DecimalFormat("0.00");//
		//System.out.println(df.format(price));
		

      	//Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*1));//3天过期
         //System.out.print(resizeImage("/opt/shopimg/01720599_400.jpg","_200",200,200));




	}
	/*1.+ 表示空格（在 URL 中不能使用空格）          %20 
	2./ 分隔目录和子目录                                              %2F 
	3.? 分隔实际的 URL 和参数                                   %3F 
	4.% 指定特殊字符                                                    %25 
	5.# 表示书签                                                             %23 
	6.& URL 中指定的参数间的分隔符                        %26 
*/
	public static String repbad(String strrep){
		//strrep=strrep.replace("+", "%20");
		//strrep=strrep.replace("/", "%2F");
		//strrep=strrep.replace("?", "%3F");
		strrep=strrep.replace("%", "%25");
		strrep=strrep.replace("#", "%23");
		strrep=strrep.replace("&", "%26");
		return strrep;
	}
	public static boolean tenpaytrue(String orderid){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("d1OrderId", orderid));//d1订单号
		
		List<BaseEntity> list = Tools.getManager(OrderTenpay.class).getList(clist, null, 0, 10000);
		boolean Tenpaystatus=true;
		if(list!=null&&list.size()>0){
			for(BaseEntity b:list){
				
				OrderTenpay ot = (OrderTenpay)b;
				if (ot.getStatus().longValue()==0){
			   Tenpaystatus=false;
			}
			}
			}

	     return Tenpaystatus;
	}
	/**
	 * i    (
o   )
-    /
t    (
Y    )
黑色  #
白色  *
浅灰色u
棕色  v
空格  z
	 * @param str
	 * @return
	 */
	private static String repstr(String str){
		str=str.replace("i", "（");
		str=str.replace("o", "）");
		str=str.replace("-", "/");
		str=str.replace("t", "(");
		str=str.replace("y", ")");
		str=str.replace("#", "黑色");
		str=str.replace("*", "白色");
		str=str.replace("u", "浅灰色");
		str=str.replace("v", "棕色");
		str=str.replace("z", " ");
		return str;
	}
}
