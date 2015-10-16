package com.d1.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Award;
import com.d1.bean.Cart;
import com.d1.bean.Product;
import com.d1.bean.PromotionProduct;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 会员专区积分兑换的积分记录
 * @author chengang
 * @createTime 2011-10-25 15:50:54
 *
 */
public class AwardHelper {
	
	public static final BaseManager manager = Tools.getManager(Award.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return Award
	 */
	public static Award getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Award)manager.get(id);
	}
	
	/**
	 * 通过物品ID找到对象
	 * @param id - 物品的ID
	 * @return Award
	 */
	public static Award getByProductId(String id){
		if(Tools.isNull(id)) return null;
		return (Award)manager.findByProperty("award_gdsid", id);
	}

	/**
	 * 根据商品编号获取积分换购信息
	 */
	public static ArrayList<Award> getAwardByGdsid(String id,int count){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("award_gdsid", id));
		clist.add(Restrictions.eq("award_validflag", new Long(1)));
		//clist.add(Restrictions.eq("award_vipflag", new Long(0)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("award_seq"));
		List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, olist, 0, count);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Award)be);
		}
		//System.out.print(rlist.size());
		return rlist ;
	}
	
	/**
	 * 获取有效地积分换购信息
	 */
	public static ArrayList<Award> getAwardList(){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("award_validflag", new Long(1)));
		//clist.add(Restrictions.eq("award_vipflag", new Long(0)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("award_seq"));
		List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Award)be);
		}
		//System.out.print(rlist.size());
		return rlist ;
	}
	
	/**
	 * 购物车已选兑换商品总分值
	 * @param id - 物品的ID
	 * @return Award
	 */
	public static float getCartAwardValue(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		float cartAwardValue=0f;
		if(cartList==null||cartList.size()==0){
			
		}else{
			for(Cart cart:cartList){
				if(cart.getPoint()!=null && (!Tools.isNull(cart.getPoint().toString()) )){
					if(cart.getPoint().intValue()>0){
						Award award=getById(cart.getPoint().toString());
						if(award!=null){
							if(award.getAward_value()!=null && (!Tools.isNull(award.getAward_value().toString()) ) && cart.getAmount()!=null && (! Tools.isNull(cart.getAmount().toString()))){
								cartAwardValue+=award.getAward_value().floatValue()*cart.getAmount().floatValue();
							}
						}
					}
				}
			}
		}
		return cartAwardValue;
	}
	
	/**
	 * 查询积分兑换排行榜
	 * @param id - 物品的ID
	 * @return Award
	 *原sql                 StringBuilder stbSql = new StringBuilder();
                stbSql.AppendFormat("SELECT TOP {0} a.award_id,a.award_gdsid,a.award_gdsname,a.award_value,a.award_price,", iTopNum);
                stbSql.Append(" CASE WHEN award_gdsid='00000000' THEN 30");
                stbSql.Append(" ELSE ISNULL(gdsmst_saleprice,0) END price");
                stbSql.Append(" FROM spgdsrcm,award a LEFT JOIN gdsmst");
                stbSql.Append(" ON award_gdsid=gdsmst_gdsid");
                stbSql.Append(" WHERE award_gdsid=spgdsrcm_gdsid");
                stbSql.Append(" AND spgdsrcm_code=3346 AND award_validflag=1");
                stbSql.Append(" AND ISNULL(gdsmst_validflag,1)<>2 ORDER BY award_seq");
	 */
	
	public static ArrayList<Award> getOrderAward(String code,int count){
		ArrayList<PromotionProduct> plist =PromotionProductHelper.getPromotionProductByCode(code,200);
		ArrayList<Award> list=new ArrayList<Award>();
		ArrayList<Award> list2=new ArrayList<Award>();;
		if(plist!=null && plist.size()>0){
		 for(PromotionProduct pp:plist){
			 ArrayList<Award>  alist=getAwardByGdsid(pp.getSpgdsrcm_gdsid(),count);
			 if(getlist(alist)!=null && getlist(alist).size()>0){
				 list.add(getlist(alist).get(0)); 
			 }
			 
		 }
		 
	 }
		if(list==null || list.size()==0){
			return null;
		}
		Collections.sort(list,new Award_seqComparator());
		int i=0;
		for(Award award2:list){
			if(i<count){
				list2.add(award2);
			}
			i++;
		}
		
		// Collections.reverse(alist2);
		return list2;
	}
	
	/**
	 * 排除商品表中gdsmst_validflag为2的情况
	 */
	public static ArrayList<Award> getlist(ArrayList<Award>  alist){
		ArrayList<Award> list=new ArrayList<Award>();
		 if(alist!=null && alist.size()>0){
	
			 for(Award award:alist){
				  Product product=ProductHelper.getById(award.getAward_gdsid());
				 if(product!=null){
				  if(product.getGdsmst_validflag()!=null && !Tools.isNull(product.getGdsmst_validflag().toString())){
					  if(product.getGdsmst_validflag().intValue()!=2){
						list.add(award);  
					  }
				  } 
				 }else{
					 list.add(award);   
				 }

		  }
		 
	  }
		 return list;
	}
	
	/**
	 * 根据Id获取信息
	 */
	public static ArrayList<Award> getAwardById(String id,int count){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("id", id));
		clist.add(Restrictions.eq("award_validflag", new Long(1)));
		clist.add(Restrictions.eq("award_vipflag", new Long(0)));
		
		List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, null, 0, count);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Award)be);
		}
		//System.out.print(rlist.size());
		return rlist ;
	}
	
	public static ArrayList<Award> getAwardInfo(String id,int count1,String code,int count2){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		 ArrayList<Award> alist1=getAwardById(id,count1);
		 if(alist1!=null){
			 rlist.add(alist1.get(0));
		 }
		 ArrayList<Award> alist2=getOrderAward(code,count2);
		 if(alist2!=null){
			 for(Award award:alist2){
				 rlist.add(award); 
			 }
		 }
		
		return rlist ;
	}
	
	
	/**
	 * 按积分分数段获得积分交换商品
	 */
	public static ArrayList<Award> getAwardByScore(int iAwardValue1, int iAwardValue2){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ne("id", "479"));
		clist.add(Restrictions.ne("id", "480"));
		clist.add(Restrictions.eq("award_validflag", new Long(1)));
		clist.add(Restrictions.eq("award_vipflag", new Long(0)));
		clist.add(Restrictions.gt("award_value", new Long(iAwardValue1)));
		if(iAwardValue2!=0){
			clist.add(Restrictions.le("award_value", new Long(iAwardValue2)));
		}
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("award_seq"));
		List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, olist, 0, 1000);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Award)be);
		}
		//System.out.println(rlist.size());
		return rlist ;
	}
	
	/**
	 * 按积分分数段获得积分交换商品
	 */
	public static ArrayList<Award> getAwardByGdsId(String code,int iAwardValue1, int iAwardValue2){
		
		ArrayList<Award> rlist = new ArrayList<Award>();
		ArrayList<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode(code, 100) ;
		if(pplist!=null){
			//System.out.println(pplist.size());
			for(PromotionProduct pp:pplist){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("award_gdsid", pp.getSpgdsrcm_gdsid()));
				clist.add(Restrictions.ne("id", "479"));
				clist.add(Restrictions.ne("id", "480"));
				clist.add(Restrictions.eq("award_validflag", new Long(1)));
				clist.add(Restrictions.eq("award_vipflag", new Long(0)));
				clist.add(Restrictions.gt("award_value", new Long(iAwardValue1)));
				if(iAwardValue2!=0){
					clist.add(Restrictions.le("award_value", new Long(iAwardValue2)));
				}
				
				List<BaseEntity> list = Tools.getManager(Award.class).getList(clist, null, 0, 100);
				if(list!=null && list.size()>0){
				for(BaseEntity be:list){
					
					rlist.add((Award)be);
				}
				}
			}
		}
		ArrayList<Award> alist = getlist(rlist);
		if(alist==null || alist.size()==0){
			return null;
		}
		//System.out.println(rlist.size());
		return alist ;
	}
	
	/**
	 * 结合商品表过滤信息
	 */
	public static ArrayList<Award> getAwardInfoByScore(int iAwardValue1, int iAwardValue2){
		ArrayList<Award> alist =getAwardByScore(iAwardValue1,iAwardValue2);
		ArrayList<Award> list=getlist(alist);
		if(list==null || list.size()==0){
			return null;
		}
		//System.out.print(list.size());
		return list;
	}
}


class Award_seqComparator implements Comparator<Award>{

	@Override
	public int compare(Award a0, Award a1) {
		if(a0.getAward_seq()!=null&&a1.getAward_seq()!=null){
			if(a0.getAward_seq().longValue()>a1.getAward_seq().longValue()){
				return 1 ;
			}else if(a0.getAward_seq().longValue()==a1.getAward_seq().longValue()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}

}