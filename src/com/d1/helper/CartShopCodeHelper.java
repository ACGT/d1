package com.d1.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.Const;
import com.d1.bean.Brand;
import com.d1.bean.Cart;
import com.d1.bean.Product;
import com.d1.bean.ShpMst;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 购物车辅助工具类
 * @author kk
 */
public class CartShopCodeHelper {
	
	public static BaseManager manager = Tools.getManager(Cart.class);
	

	
	/**
	 * 得到购物车总支付价，不包括运费！
	 * @param request
	 * @param response
	 * @return 保留两位小数
	 */
	public static float getTotalPayMoney(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if(cart.getType().longValue()>=0&&cart.getShopcode().equals(shopCode)){
					long actmoney=0;
					if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
				
					total+=cart.getMoney()-actmoney;
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	/**
	 * 得到购物车总支付价，不包括运费！
	 * @param request
	 * @param response
	 * @return 保留两位小数
	 */
	public static float getTotalPayMoneys(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if((cart.getShopcode().equals(shopCode)||shopCode.equals("11111111"))&&cart.getType().longValue()>=0&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=18&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14)total+=cart.getMoney();
			}
			
			return Tools.getFloat(total,2);
		}
	}
		
	/**
	 * 返回所有可以打折商品的总价，用于判断是否满足E券和打折条件，不让用券的商品不算<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getNormalProductMoney(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response,shopCode) ;
		
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//让用券
						total+=cart.getMoney();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	/**
	 * 得到购物车总商品数量，包括赠品数，这个数目就是库房要发货的总件数！
	 * @param request
	 * @param response
	 * @return
	 */
	public static int getTotalProductCount(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//把总数加起来
		if(cartList==null||cartList.size()==0){
			return 0;
		}else{
			int total = 0;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0&&cart.getShopcode().equals(shopCode))total+=cart.getAmount();
			}
			
			return total;
		}
	}
	/**
	 * 得到购物车总商品数量，不包括赠品数
	 * @param request
	 * @param response
	 * @return
	 */
	public static int getCartAllpCount(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//把总数加起来
		if(cartList==null||cartList.size()==0){
			return 0;
		}else{
			int total = 0;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>0&&cart.getShopcode().equals(shopCode))total+=cart.getAmount();
			}
			
			return total;
		}
	}
	
	/**
	 * 得到购物车里所有商户（已经去重）
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<ShpMst> getCartShopCode(HttpServletRequest request,HttpServletResponse response){
		//正常商品列表
		ArrayList<Cart> carts = CartHelper.getCartItems(request, response);
				//.getCartNormalProducts(request, response) ;
		if(carts==null||carts.size()==0)return null;
		
		HashMap<String,String> bmap = new HashMap<String,String>();
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;

			if(p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().trim().length()>0)bmap.put(p.getGdsmst_shopcode(), "");
		}
		
		ArrayList<ShpMst> resList = new ArrayList<ShpMst>();
		Iterator<String> it = bmap.keySet().iterator();
		while(it.hasNext()){
			ShpMst sm = (ShpMst)Tools.getManager(ShpMst.class).get((String)it.next());
			if(sm!=null&&sm.getShpmst_status().longValue()==1)resList.add(sm);
		}
		return resList ;
	}

	/**
	 * 根据商户把物品和2级物品排序放入一个list中
	 * @param request
	 * @param response
	 * @return ArrayList<Cart>
	 */
	public static ArrayList<Cart> getCartItemsOrder(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<Cart> listCart = null;
		if(shopCode.equals("08102301"))shopCode="00000000";
		
		ArrayList<Cart> list = CartHelper.getTopCartItems(request,response);
		if(list != null && !list.isEmpty()){
			listCart = new ArrayList<Cart>();
			for(Cart cart : list){
				if(!cart.getShopcode().trim().equals(shopCode))continue;
				listCart.add(cart);
				
				if(Tools.longValue(cart.getHasChild())==1){
					ArrayList<Cart> listChild = CartHelper.getCartItemsViaParentId(cart.getId());
					if(listChild != null && !listChild.isEmpty()){
						for(Cart childCart : listChild){
							listCart.add(childCart);
						}
					}
				}
			}
		}
		 
		return listCart;
	}
	/**
	 * 获取购物车里所有记录，只管cookie
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartItems(HttpServletRequest request,HttpServletResponse response,String shopCode){
		ArrayList<Cart> cookieCartList = null;
		Cookie cartCookie = Tools.getClientCookie(request,Const.CART_COOKIE_NAME);
		
		HttpSession session = request.getSession();
		
		if(cartCookie!=null&&cartCookie.getValue()!=null){
			cookieCartList = getCartItemsViaCookie(cartCookie.getValue(),shopCode);
		}else{
			cookieCartList = getCartItemsViaCookie((String)session.getAttribute("CART_COOKIE_ATTRIBUTE_VALUE"),shopCode);
		}
		
		return cookieCartList ;
	}
	
	/**
	 * 根据cookie的值获取购物车里所有信息
	 * @param cookieValue
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaCookie(String cookieValue,String shopCode){
		return getCartItems("cookie",cookieValue,true,shopCode);
	}
	/**
	 * 根据字段名和字段值获取cart列表，根据层级关系获取！
	 * @param fieldName
	 * @param fieldValue
	 * @param getChild true表示连child一起加进来，false表示不加child
	 * @return
	 */
	private static ArrayList<Cart> getCartItems(String fieldName,String fieldValue,boolean getChild,String shopCode){
		//加入查询条件
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq(fieldName, fieldValue));
		
		//先取父级的，然后取子级cart
		if(getChild)clist.add(Restrictions.eq("hasFather", new Long(0)));
		
		//加入排序条件，按加入购物车时间排序
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("createDate"));
		
		//获取列表
		List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, olist, 0, 1000);
		
		//强制转换
		ArrayList<Cart> resList = new ArrayList<Cart>();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Cart cart = (Cart)list.get(i);
				if(!shopCode.equals(cart.getShopcode()))continue;
				resList.add(cart);
				if(getChild){
					if(cart.getHasChild().longValue()==1){//如果有子cart，也加入到列表里
						ArrayList<Cart> childList = CartHelper.getCartItemsViaParentId(cart.getId());
						if(childList!=null&&childList.size()>0){
							//全部加入到结果中
							for(int j=0;j<childList.size();j++)resList.add(childList.get(j));
						}
					}
				}//end if(getChild)
			}
		}
		
		return resList ;
	}
	/**
	 * 清除购物车，删除购物车里的所有东西
	 * @param request
	 * @param response
	 */
	public static void clearAllCarts(HttpServletRequest request,HttpServletResponse response,String shopCode){
		clearAllCookieCarts(request,response,shopCode);
		
		clearAllLoginUserCarts(request,response,shopCode);
	}
	
	/**
	 * 清除cookie下的购物车所有条目
	 */
	public static void clearAllCookieCarts(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//获取购物车里所有记录
		String cookie = CartHelper.getCartCookieValue(request, response);
		
		
		if(!Tools.isNull(cookie)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("cookie", cookie));
			
			//获取列表
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//逐个删除
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//删除cart
					if(shopCode.equals(c.getShopcode()))Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
	
	/**
	 * 清除登录id下的购物车所有项目
	 * @param request
	 * @param response
	 */
	public static void clearAllLoginUserCarts(HttpServletRequest request,HttpServletResponse response,String shopCode){
		String userId = CartHelper.getCartUserId(request, response);
		
		if(!Tools.isNull(userId)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("userId", userId));
			
			//获取列表
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//逐个删除
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//删除cart
					if(shopCode.equals(c.getShopcode()))Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
		
}
