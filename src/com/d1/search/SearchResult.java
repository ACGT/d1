package com.d1.search;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import com.d1.bean.Brand;
import com.d1.bean.Product;
import com.d1.comp.CreateTimeComparator;
import com.d1.comp.PriceComparator;
import com.d1.comp.SalesComparator;
import com.d1.helper.BrandHelper;
import com.d1.helper.CartHelper;
import com.d1.util.Tools;

/**
 * 搜索返回结果
 * @author kk
 *
 */
public class SearchResult {
	
	/**
	 * 商品总数
	 */
	private int totalcount = 0 ;
	
	/**
	 * 搜索内容
	 */
	private String keyWords ;
	
	/**
	 * 缓存过期时间
	 */
	private long expireTime = System.currentTimeMillis() ;
	
	/**
	 * 分类对应的长度，key就是分类id，value是对应分类的长度。遍历这个hashmap就知道搜索结果中有哪些分类！<br/>
	 */
	private Map<String,Integer> rackMap = new ConcurrentHashMap<String,Integer>();
	
	/**
	 * 搜索到得所有商品，如果要得到某一页的排序商品，用getProducts方法获取
	 */
	private CopyOnWriteArrayList<Product> resultlist = new CopyOnWriteArrayList<Product>();
	public static class ProductComparator implements Comparator<Product>{

		@Override
		public int compare(Product p0, Product p1) {	
			float p0s=0f;
			float p0sv=0f;
			float p1s=0f;
			float p1sv=0f;
			if(p0.getGdsmst_sortxs()!=null)p0s=p0.getGdsmst_sortxs().floatValue();
			if(p0.getGdsmst_sortxsv()!=null)p0sv=p0.getGdsmst_sortxsv().floatValue();
			if(p1.getGdsmst_sortxs()!=null)p1s=p1.getGdsmst_sortxs().floatValue();
			if(p1.getGdsmst_sortxsv()!=null)p1sv=p1.getGdsmst_sortxsv().floatValue();
			if(p0s+p0sv>p1s+p1sv){
				return 1 ;
			}else if(p0s+p0sv==p1s+p1sv){
				return 0 ;
			}else{
				return -1 ;
			}
		}
	}
	/**
	 * 得到搜索商品列表
	 * @param rackcode 分类号，3-15位 。null取全部
	 * @param sort 排序字段。createtime=上架时间，默认;sales=销量;price=会员价;
	 * @param asc true=升序;false=降序
	 * @praam start 开始位置
	 * @param length 获取多少个，一般就是page_size个
	 * @return
	 */
	public List<Product> getProducts(String rackcode,String sort,boolean asc,int start,int length){
		List<Product> resultlist123 = new ArrayList<Product>() ;
		
		if(!Tools.isNull(rackcode)){
			for(Product p:resultlist){
	
				if(p.getGdsmst_rackcode()!=null&&p.getGdsmst_rackcode().startsWith(rackcode)){
					resultlist123.add(p);
				}
			}
		}else{
			for(Product p:resultlist){
				resultlist123.add(p);
			}
		}
		
		
		
		
		
		if("createtime".equals(sort)){
			Collections.sort(resultlist123, new CreateTimeComparator());
		}else if("sales".equals(sort)){
			Collections.sort(resultlist123, new SalesComparator());
		}else if("price".equals(sort)){
			Collections.sort(resultlist123, new PriceComparator());
		}else{
			Collections.sort(resultlist123, new ProductComparator());
		}

		if(!asc){//翻转一下List，相当于倒序
			Collections.reverse(resultlist123);
		}
		
		ArrayList<Product> newlist = new ArrayList<Product>();
		
		for(int i=start;i<start+length&&i<resultlist123.size();i++){
			newlist.add(resultlist123.get(i));
		}
		
		return newlist ;
	}
	/**
	 * 得到搜索商品列表
	 * @param rackcode 分类号，3-15位 。null取全部
	 * @param sort 排序字段。createtime=上架时间，默认;sales=销量;price=会员价;
	 * @param msflag  秒杀闪购商品
	 * @param shopd1     自营商品
	 * @param asc true=升序;false=降序
	 * @praam start 开始位置
	 * @param length 获取多少个，一般就是page_size个
	 * @return
	 */
	public List<Product> getProducts(String rackcode,String productprice,String brand,String sort,String msflag,String shopd1,String stdv1,String stdv2,String stdv3,String stdv6,boolean asc,int start,int length){
		List<Product> resultlist123 = new ArrayList<Product>() ;
		if(!Tools.isNull(productprice))productprice=productprice.replace("以上","-50000");
		 
			for(Product p:resultlist){
				if(!Tools.isNull(rackcode)&&(p.getGdsmst_rackcode()==null||!p.getGdsmst_rackcode().startsWith(rackcode)))continue;
			       if(!Tools.isNull(shopd1)){
			    	   if(!p.getGdsmst_shopcode().equals("00000000"))continue;
					}
			       boolean isms=CartHelper.getmsflag(p);
					float pprice=p.getGdsmst_memberprice().floatValue();
					if(isms)pprice=p.getGdsmst_msprice().floatValue();
					if(!Tools.isNull(msflag)){
						if(!isms)continue;
					}
					
					if(!Tools.isNull(productprice)){
					if(!Tools.isNull(productprice)&&productprice.indexOf("-")>-1){
						String sprice = productprice.substring(0,productprice.indexOf("-"));
						String eprice = productprice.substring(productprice.indexOf("-")+1);
						
						if(!Tools.isNull(sprice)&&pprice<Tools.parseFloat(sprice))continue;
						
						if(!Tools.isNull(eprice)&&pprice>Tools.parseFloat(eprice))continue;
					}
					}
					String stdvalue1 = p.getGdsmst_stdvalue1();
					
					if(!Tools.isNull(stdv1) && (stdvalue1 == null || stdvalue1.indexOf(stdv1) == -1)) continue;
					String stdvalue2 = p.getGdsmst_stdvalue2();
					if(!Tools.isNull(stdv2) && (stdvalue2 == null || stdvalue2.indexOf(stdv2) == -1)) continue;
					String stdvalue3 = p.getGdsmst_stdvalue3();
					if(!Tools.isNull(stdv3) && (stdvalue3 == null || stdvalue3.indexOf(stdv3) == -1)) continue;
	                 String stdvalue6 = p.getGdsmst_stdvalue6();
					if(!Tools.isNull(stdv6) && (stdvalue6 == null || stdvalue6.indexOf(stdv6) == -1)) continue;
					String brand_code = p.getGdsmst_brand();
					if(!Tools.isNull(brand)&&!brand.equals(brand_code))continue;
					
					resultlist123.add(p);	 
			}
		if("createtime".equals(sort)){
			Collections.sort(resultlist123, new CreateTimeComparator());
		}else if("sales".equals(sort)){
			Collections.sort(resultlist123, new SalesComparator());
		}else if("price".equals(sort)){
			Collections.sort(resultlist123, new PriceComparator());
		}else{
			Collections.sort(resultlist123, new SalesComparator());
		}

		if(!asc){//翻转一下List，相当于倒序
			Collections.reverse(resultlist123);
		}
		
		ArrayList<Product> newlist = new ArrayList<Product>();
		
		for(int i=start;i<start+length&&i<resultlist123.size();i++){
			newlist.add(resultlist123.get(i));
		}
		
		return newlist ;
	}
	public Object[] getProducts2014(String rackcode,String productprice,String brand,String msflag,String shopd1,String stdv1,String stdv2,String stdv3,String stdv6){
		List<Product> resultlist123 = new ArrayList<Product>() ;
		if(!Tools.isNull(productprice))productprice=productprice.replace("以上","-50000");
		HashMap<String,String> stdsMap = new HashMap<String,String>();
		HashMap<String,String>  priceMap =new HashMap<String,String>();
		HashMap<String,String>  brandMap =new HashMap<String,String>();
		HashMap<String,Integer>  rckMap =new HashMap<String,Integer>();
		Object[] obj = new Object[]{null,null,null,null,null};
		//0-49   99  199  299 399 499  599  799   999  1999 2999 3999  4999-	
				for(int i=1;i<=14;i++){
					priceMap.put("price"+i,"0");
				}
				String stdhaves="00000089,00000094";
	        int totalcount=0;
			for(Product p:resultlist){
				if(!Tools.isNull(rackcode)&&(p.getGdsmst_rackcode()==null||!p.getGdsmst_rackcode().startsWith(rackcode)))continue;
		       if(!Tools.isNull(shopd1)){
		    	   if(!p.getGdsmst_shopcode().equals("00000000"))continue;
				}
		       boolean isms=CartHelper.getmsflag(p);
				float pprice=p.getGdsmst_memberprice().floatValue();
				if(isms)pprice=p.getGdsmst_msprice().floatValue();
				if(!Tools.isNull(msflag)){
					if(!isms)continue;
				}
				
				if(!Tools.isNull(productprice)){
				if(!Tools.isNull(productprice)&&productprice.indexOf("-")>-1){
					String sprice = productprice.substring(0,productprice.indexOf("-"));
					String eprice = productprice.substring(productprice.indexOf("-")+1);
					
					if(!Tools.isNull(sprice)&&pprice<Tools.parseFloat(sprice))continue;
					
					if(!Tools.isNull(eprice)&&pprice>Tools.parseFloat(eprice))continue;
				}
				}
				String stdvalue1 = p.getGdsmst_stdvalue1();
				
				if(!Tools.isNull(stdv1) && (stdvalue1 == null || stdvalue1.indexOf(stdv1) == -1)) continue;
				String stdvalue2 = p.getGdsmst_stdvalue2();
				if(!Tools.isNull(stdv2) && (stdvalue2 == null || stdvalue2.indexOf(stdv2) == -1)) continue;
				String stdvalue3 = p.getGdsmst_stdvalue3();
				if(!Tools.isNull(stdv3) && (stdvalue3 == null || stdvalue3.indexOf(stdv3) == -1)) continue;
                 String stdvalue6 = p.getGdsmst_stdvalue6();
				if(!Tools.isNull(stdv6) && (stdvalue6 == null || stdvalue6.indexOf(stdv6) == -1)) continue;
				String brand_code = p.getGdsmst_brand();
				if(!Tools.isNull(brand)&&!brand.equals(brand_code))continue;
				if(!Tools.isNull(brand_code)&&!brandMap.containsKey(brand_code)){
					String brandname=p.getGdsmst_brandname();
					if(!Tools.isNull(brandname))brandname=brandname.trim();
					brandMap.put(brand_code, brandname);
					}
				String gdsrck=p.getGdsmst_rackcode();
				if(!Tools.isNull(gdsrck)){
					for(int l=3;l<=gdsrck.length();l=l+3){
						 
						if(rckMap.containsKey(gdsrck.substring(0,l))){
							rckMap.put(gdsrck.substring(0,l), rckMap.get(gdsrck.substring(0,l))+1);
						}else{
							rckMap.put(gdsrck.substring(0,l), 1);
						}
					}
				}
 
				if(pprice<=49){
	  	         priceMap.put("price1",(Tools.parseInt(priceMap.get("price1"))+1)+"");
	            }else if(pprice<=99){
	     	         priceMap.put("price2",(Tools.parseInt(priceMap.get("price2"))+1)+"");
	            }else if(pprice<=199){
	    	         priceMap.put("price3",(Tools.parseInt(priceMap.get("price3"))+1)+"");
	            }else if(pprice<=299){
	    	         priceMap.put("price4",(Tools.parseInt(priceMap.get("price4"))+1)+"");
	            }else if(pprice<=399){
	    	         priceMap.put("price5",(Tools.parseInt(priceMap.get("price5"))+1)+"");
	            }else if(pprice<=499){
	    	         priceMap.put("price6",(Tools.parseInt(priceMap.get("price6"))+1)+"");
	            }else if(pprice<=599){
	    	         priceMap.put("price7",(Tools.parseInt(priceMap.get("price7"))+1)+"");
	            }else if(pprice<=799){
	    	         priceMap.put("price8",(Tools.parseInt(priceMap.get("price8"))+1)+"");
	            }else if(pprice<=999){
	    	         priceMap.put("price9",(Tools.parseInt(priceMap.get("price9"))+1)+"");
	            }else if(pprice<=1999){
	    	         priceMap.put("price10",(Tools.parseInt(priceMap.get("price10"))+1)+"");
	            }else if(pprice<=2999){
	    	         priceMap.put("price11",(Tools.parseInt(priceMap.get("price11"))+1)+"");
	            }else if(pprice<=3999){
	    	         priceMap.put("price12",(Tools.parseInt(priceMap.get("price12"))+1)+"");
	            }else if(pprice<=4999){
	   	             priceMap.put("price13",(Tools.parseInt(priceMap.get("price13"))+1)+"");  
	            }else if(pprice>4999){
	  	             priceMap.put("price14",(Tools.parseInt(priceMap.get("price14"))+1)+""); 
	            }
	            String stdid = p.getGdsmst_stdid();
	            if(!Tools.isNull(stdid)&&stdhaves.indexOf(stdid)>=0){
	            if(!Tools.isNull(stdvalue1)){
	    			stdvalue1=stdvalue1.replace("，", ",");
	    				String[] arrstd1= stdvalue1.split(",");
	    				for(int i=0;i<arrstd1.length;i++){
	    					String stdv=arrstd1[i];
	    					if(!Tools.isNull(stdv)){
	    						stdv=stdv.trim();
	    					String stdidkey=stdid+"stdv1";
	    			       if(!Tools.isNull(stdsMap.get(stdidkey))){
	    			    	   if(stdsMap.get(stdidkey).indexOf(stdv)==-1){
	    			    	   stdsMap.put(stdidkey,stdsMap.get(stdidkey)+","+ stdv);
	    			    	   }
	                        }else{
	                        	stdsMap.put(stdidkey,stdv);
	                        }
	    					}
	    			}
	    		}
	            if(!Tools.isNull(stdvalue2)){
	    			stdvalue2=stdvalue2.replace("，", ",");
	    				String[] arrstd2= stdvalue2.split(",");
	    				for(int i=0;i<arrstd2.length;i++){
	    					String stdv=arrstd2[i];
	    					if(!Tools.isNull(stdv)){
	    						stdv=stdv.trim();
	    					String stdidkey=stdid+"stdv2";
	    			       if(!Tools.isNull(stdsMap.get(stdidkey))){
	    			    	   if(stdsMap.get(stdidkey).indexOf(stdv)==-1){
	    			    	   stdsMap.put(stdidkey,stdsMap.get(stdidkey)+","+ stdv);
	    			    	   }
	                        }else{
	                        	stdsMap.put(stdidkey,stdv);
	                        }
	    					}
	    			}
	    		}
	            if(!Tools.isNull(stdvalue3)){
	    			stdvalue3=stdvalue3.replace("，", ",");
	    				String[] arrstd3= stdvalue3.split(",");
	    				for(int i=0;i<arrstd3.length;i++){
	    					String stdv=arrstd3[i];
	    					if(!Tools.isNull(stdv)){
	    						stdv=stdv.trim();
	    					String stdidkey=stdid+"stdv3";
	    			       if(!Tools.isNull(stdsMap.get(stdidkey))){
	    			    	   if(stdsMap.get(stdidkey).indexOf(stdv)==-1){
	    			    	   stdsMap.put(stdidkey,stdsMap.get(stdidkey)+","+ stdv);
	    			    	   }
	                        }else{
	                        	stdsMap.put(stdidkey,stdv);
	                        }
	    					}
	    			}
	    		}
	            if(!Tools.isNull(stdvalue6)){
	    			stdvalue6=stdvalue6.replace("，", ",");
	    				String[] arrstd6= stdvalue6.split(",");
	    				for(int i=0;i<arrstd6.length;i++){
	    					String stdv=arrstd6[i];
	    					if(!Tools.isNull(stdv)){
	    						stdv=stdv.trim();
	    					String stdidkey=stdid+"stdv6";
	    			       if(!Tools.isNull(stdsMap.get(stdidkey))){
	    			    	   if(stdsMap.get(stdidkey).indexOf(stdv)==-1){
	    			    	   stdsMap.put(stdidkey,stdsMap.get(stdidkey)+","+ stdv);
	    			    	   }
	                        }else{
	                        	stdsMap.put(stdidkey,stdv);
	                        }
	    					}
	    			}
	    		}
	            }
	    		totalcount++;
				 
				
			}
		obj[0] = totalcount;
		obj[1] = priceMap;
		obj[2] = stdsMap;
		obj[3] = brandMap;
		obj[4] = rckMap;
		return obj;
	}

	/**
	 * 得到某个分类下的商品数量
	 * @param rackcode 分类，如014000
	 * @return
	 */
	public int getTotalcount(String rackcode) {
		if(Tools.isNull(rackcode)||"000".equals(rackcode)){
			return totalcount;
		}else if(rackMap.containsKey(rackcode)){
			return rackMap.get(rackcode).intValue();
		}else{
			return 0;
		}
	}
	
	/**
	 * 得到下一级搜索结果中的分类列表，null表示没有了
	 * @param rackcode
	 * @return
	 */
	public ArrayList<String> getNextLevelRackcodes(String rackcode){
		
		Iterator<String> it = rackMap.keySet().iterator();
		ArrayList<String> list123 = new ArrayList<String>();
		HashMap<String,String> map = new HashMap<String,String>();
		while(it.hasNext()){
			String k = it.next();
			if(!Tools.isNull(rackcode)){
				if(k.startsWith(rackcode)&&k.length()>rackcode.length()){
					map.put(k.substring(0,rackcode.length()+3), "");
				}
			}else{
				map.put(k.substring(0,3), "");
			}
		}
		Iterator<String> it123 = map.keySet().iterator();
		while(it123.hasNext()){
			list123.add(it123.next());
		}
		
		Collections.sort(list123,new NumComparator());
		return list123;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public Map<String, Integer> getRackMap() {
		return rackMap;
	}

	public void setRackMap(Map<String, Integer> rackMap) {
		this.rackMap = rackMap;
	}

	public List<Product> getResultlist() {
		return resultlist;
	}

	public void setResultlist(CopyOnWriteArrayList<Product> resultlist) {
		this.resultlist = resultlist;
	}

	public long getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(long expireTime) {
		this.expireTime = expireTime;
	}

	public String getKeyWords() {
		return keyWords;
	}

	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	
	class NumComparator implements Comparator<String>{

		@Override
		public int compare(String p0, String p1) {
			
			Integer i0 = rackMap.get(p0);
			Integer i1 = rackMap.get(p1);
			
			if(i0!=null&&i1!=null){
				if(i0.intValue()>i1.intValue())return -1;
				else if(i0.intValue()<i1.intValue())return 1;
				else return 0;
			}
			return 0;
		}
	}

}
