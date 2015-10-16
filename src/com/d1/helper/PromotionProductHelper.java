package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.PromotionProduct;
import com.d1.bean.SpecialProduct;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 商品推荐工具类
 * @author zpp
 *
 */
public class PromotionProductHelper {

	/**
	 * 根据推荐位号查询推荐商品信息
	 * @param code - 推荐号
	 * @param count - 取几位，如果<=0则为100
	 * @return ArrayList<PromotionProduct>
	 */
	public static ArrayList<PromotionProduct> getPromotionProductByCode(String code , int count){
		if(!Tools.isMath(code)) return null;
		if(count <= 0) count = 100;
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_code", new Long(code)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("spgdsrcm_seq"));
		olist.add(Order.desc("spgdsrcm_begindate"));
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		
		int total = 0 ;
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			rlist.add(pp);
			total++;
			if(total==count)break;
		}
		return rlist ;
	}
	
	public static ArrayList<PromotionProduct> getPProduct(String code , int count){
		if(!Tools.isMath(code)) return null;
		if(count <= 0) count = 100;
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_code", new Long(code)));
		clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
		clist.add(Restrictions.ge("spgdsrcm_enddate",new Date()));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("spgdsrcm_seq"));
		//olist.add(Order.desc("spgdsrcm_begindate"));
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		
		int total = 0 ;
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			rlist.add(pp);
			total++;
			if(total==count)break;
		}
		return rlist ;
	}
	
	
	
	/**
	 * 根据推荐位号查询推荐(南北方)商品信息
	 * @param code - 推荐号
	 * @param count - 取几位，如果<=0则为100
	 * @return ArrayList<PromotionProduct>
	 */
	public static ArrayList<PromotionProduct> getPromotionProductByCodeArea(String code ,String area, int count){
		if(!Tools.isNumber(code)) return null;
		if(count <= 0) count = 100;
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_code", new Long(code)));
		if(!Tools.isNull(area)&&Tools.isNumber(area))
		{
			if(Tools.parseInt(area)==2){
			   clist.add(Restrictions.ne("spgdsrcm_areaid", new Long(1)));
			}
			else if(Tools.parseInt(area)==1)
			{
				clist.add(Restrictions.le("spgdsrcm_areaid", new Long(area)));
			}
			else
			{
				
			}
		}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("spgdsrcm_seq"));
		olist.add(Order.desc("spgdsrcm_begindate"));
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		
		int total = 0 ;
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			rlist.add(pp);
			total++;
			if(total==count)break;
		}
		return rlist ;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 获取商品id列表
	 *
	 */
	public static ArrayList<String> getGoodidList(String code , int count){
		ArrayList<PromotionProduct> list =getPromotionProductByCode(code , count);
		ArrayList<String> gdslist=new ArrayList<String>();
		if(list!=null){
			for(PromotionProduct product:list){
				gdslist.add(product.getSpgdsrcm_gdsid());
			}
		}
		return gdslist;
	}
	/**
	 * 根据商品id查询推荐商品信息
	 *
	 */
	public static ArrayList<PromotionProduct> getPromotionProductById(String id){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_gdsid", id));
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
		
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			rlist.add(pp);
		}
		return rlist ;
	}
	/**
	 * 根据特价编号获得推荐商品信息
	 *
	 */
	public static ArrayList<PromotionProduct> getPromotionProductBySCode(String rackcode,String name){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		ArrayList<SpecialProduct> slist=SpecialProductHelper.getSpecialProductList(rackcode, name);
		//System.out.println("slist:"+slist.size());
		if(slist!=null){
			for(SpecialProduct sproduct:slist){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("spgdsrcm_code",new Long(sproduct.getId())));
				List<Order> olist = new ArrayList<Order>();
				olist.add(Order.asc("spgdsrcm_seq"));
				olist.add(Order.desc("spgdsrcm_dtupd"));
				List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
				
				if(list!=null){
					for(BaseEntity be:list){
						PromotionProduct pp = (PromotionProduct)be;
						Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
						if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
						rlist.add(pp);
					}
				}
			}
		}
		//System.out.println("rlist:"+rlist.size());
		return rlist ;
	}
	
	/**
	 * 根据推荐编码获得推荐商品信息列表
	 *
	 */
	public static ArrayList<PromotionProduct> getPromotionProductByCode(String code){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
				List<Order> olist = new ArrayList<Order>();
				olist.add(Order.asc("spgdsrcm_seq"));
				olist.add(Order.desc("spgdsrcm_dtupd"));
				List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 100);
				
				if(list!=null){
					for(BaseEntity be:list){
						PromotionProduct pp = (PromotionProduct)be;
						Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
						if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
						rlist.add(pp);
					}
				}
			
		//System.out.println("rlist:"+rlist.size());
		return rlist ;
	}
	
	public static ArrayList<String> getGdsList(String code){
		ArrayList<PromotionProduct> list=getPromotionProductByCode(code);
		ArrayList<String> list2=new ArrayList<String>();
		if(list!=null){
			for(PromotionProduct pProduct:list){
				list2.add(pProduct.getSpgdsrcm_gdsid());
			}
		}
		return list2;
	}
	/**
	 * 根据特价编号,商品编号获得推荐商品信息
	 *
	 */
	public static ArrayList<PromotionProduct> getPromotionProductBySCodeGdsid(String rackcode,String name,String id){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		ArrayList<SpecialProduct> slist=SpecialProductHelper.getSpecialProductList(rackcode, name);
		if(slist!=null){
			for(SpecialProduct sproduct:slist){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("spgdsrcm_code",new Long(sproduct.getId())));
				clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
				
				List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
				
				if(list!=null){
					for(BaseEntity be:list){
						PromotionProduct pp = (PromotionProduct)be;
						Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
						if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
						rlist.add(pp);
					}
				}
			}
		}
		
		return rlist ;
	}
	
	/**
	 * 根据推荐位号,商品编号获得推荐商品信息
	 *
	 */
	public static ArrayList<PromotionProduct> getPProductByCodeGdsid(String code,String id){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
				clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
				
				List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
				
				if(list!=null){
					for(BaseEntity be:list){
						PromotionProduct pp = (PromotionProduct)be;
						Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
						if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
						rlist.add(pp);
					}
				}
			
		
		return rlist ;
	}
	public static boolean getPProductByCodeGdsidExist(String code,String id){
		boolean ret=false;
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		        if (Tools.isNull(code)) return ret;
		        code=code.trim();
		        String[] arrcode=code.split(",");
	            for(int i=0;i<arrcode.length;i++){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("spgdsrcm_code",new Long(arrcode[i])));
				clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
				
				List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 1);

				if(list!=null&&list.size()>0){
					
					ret=true;
				}
	            }
				

		
		return ret ;
	}
	
	/**
	 * 根据推荐编码获得推荐商品信息列表
	 *
	 */
	public static ArrayList<PromotionProduct> getPProductByCode(String code,int num){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("spgdsrcm_seq"));
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num+10);
		if(list==null||list.size()==0)return null;	
		
		int total = 0 ;
		if(list!=null){
			for(BaseEntity be:list){
				PromotionProduct pp = (PromotionProduct)be;
				Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
				if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
				rlist.add(pp);
				total++;
				if(total==num)break;
			}
		}
			
		//for(BaseEntity be:list){
			//PromotionProduct pp = (PromotionProduct)be;
			//rlist.add(pp);
		//}
		return rlist ;
	}
	
	/**
	 * 根据推荐编码获得推荐商品信息列表--按spgdsrcm_seq和spgdsrcm_gdsid排序
	 *
	 */
	public static ArrayList<PromotionProduct> getPProductByCode(String code){
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
				List<Order> olist = new ArrayList<Order>();
				olist.add(Order.asc("spgdsrcm_seq"));
				olist.add(Order.asc("spgdsrcm_gdsid"));
				List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 500);
				
				if(list!=null){
					for(BaseEntity be:list){
						PromotionProduct pp = (PromotionProduct)be;
						Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
						if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
						rlist.add(pp);
					}
				}
			
		//System.out.println("rlist:"+rlist.size());
		return rlist ;
	}
	
	/**
	 * 获得团购兑换赠品
	 * @param strRcmCode - 推荐码
	 * @return List<Product>
	 */
	public static List<Product> getTuanDHPreSent(String strRcmCode){
		if(!Tools.isMath(strRcmCode)) return null;
		ArrayList<PromotionProduct> list = getPromotionProductByCode(strRcmCode);
		if(list == null || list.isEmpty()) return null;
		
		List<Product> goodsList = new ArrayList<Product>();
		
		for(PromotionProduct pp : list){
			Product product = ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			if(product != null && ProductHelper.isShow(product)){
				goodsList.add(product);
			}
		}
		return goodsList;
	}
	
	/**
	 * 显视商品浮层t="top,left,http://www.****.gif",x="****<BR>****"
	 *
	 
	public static String showLayer(String t,String x){
		StringBuffer result=new StringBuffer();
		if(t.contains(",")){
			String[] strlist=t.split("\\,");
			System.out.println(strlist.length);
	
			if(strlist.length>=3){
				result.append("	<div style=\"width:90px;height:90px;position:absolute;"+strlist[0]+":"+strlist[1]+":0;background-image:url(\'"+strlist[2]+"\');\">");
				result.append(" <div style=\"z-index:20;width:90px;height:90px;position:absolute;padding-top:30px;left:0;color:#ffffff;font-size:16;text-align:center;font-weight:600;text-decoration:none;\">	");
				result.append(x);
				result.append("</div></div>");
	
			}
		}
		return result.toString();
	}*/
}
