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
 * ���ﳵ����������
 * @author kk
 */
public class CartShopCodeHelper {
	
	public static BaseManager manager = Tools.getManager(Cart.class);
	

	
	/**
	 * �õ����ﳵ��֧���ۣ��������˷ѣ�
	 * @param request
	 * @param response
	 * @return ������λС��
	 */
	public static float getTotalPayMoney(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//��֧���ۼ�������ֻ������֧������Ʒ
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0��ʾʵ����Ʒ��type<0���ײ����������⹺��ȯ���������ܼ�
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
	 * �õ����ﳵ��֧���ۣ��������˷ѣ�
	 * @param request
	 * @param response
	 * @return ������λС��
	 */
	public static float getTotalPayMoneys(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//��֧���ۼ�������ֻ������֧������Ʒ
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0��ʾʵ����Ʒ��type<0���ײ����������⹺��ȯ���������ܼ�
				if((cart.getShopcode().equals(shopCode)||shopCode.equals("11111111"))&&cart.getType().longValue()>=0&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=18&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14)total+=cart.getMoney();
			}
			
			return Tools.getFloat(total,2);
		}
	}
		
	/**
	 * �������п��Դ�����Ʒ���ܼۣ������ж��Ƿ�����Eȯ�ʹ���������������ȯ����Ʒ����<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getNormalProductMoney(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response,shopCode) ;
		
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//����ȯ
						total+=cart.getMoney();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	/**
	 * �õ����ﳵ����Ʒ������������Ʒ���������Ŀ���ǿⷿҪ�������ܼ�����
	 * @param request
	 * @param response
	 * @return
	 */
	public static int getTotalProductCount(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//������������
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
	 * �õ����ﳵ����Ʒ��������������Ʒ��
	 * @param request
	 * @param response
	 * @return
	 */
	public static int getCartAllpCount(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//������������
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
	 * �õ����ﳵ�������̻����Ѿ�ȥ�أ�
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<ShpMst> getCartShopCode(HttpServletRequest request,HttpServletResponse response){
		//������Ʒ�б�
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
	 * �����̻�����Ʒ��2����Ʒ�������һ��list��
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
	 * ��ȡ���ﳵ�����м�¼��ֻ��cookie
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
	 * ����cookie��ֵ��ȡ���ﳵ��������Ϣ
	 * @param cookieValue
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaCookie(String cookieValue,String shopCode){
		return getCartItems("cookie",cookieValue,true,shopCode);
	}
	/**
	 * �����ֶ������ֶ�ֵ��ȡcart�б����ݲ㼶��ϵ��ȡ��
	 * @param fieldName
	 * @param fieldValue
	 * @param getChild true��ʾ��childһ��ӽ�����false��ʾ����child
	 * @return
	 */
	private static ArrayList<Cart> getCartItems(String fieldName,String fieldValue,boolean getChild,String shopCode){
		//�����ѯ����
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq(fieldName, fieldValue));
		
		//��ȡ�����ģ�Ȼ��ȡ�Ӽ�cart
		if(getChild)clist.add(Restrictions.eq("hasFather", new Long(0)));
		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("createDate"));
		
		//��ȡ�б�
		List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, olist, 0, 1000);
		
		//ǿ��ת��
		ArrayList<Cart> resList = new ArrayList<Cart>();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Cart cart = (Cart)list.get(i);
				if(!shopCode.equals(cart.getShopcode()))continue;
				resList.add(cart);
				if(getChild){
					if(cart.getHasChild().longValue()==1){//�������cart��Ҳ���뵽�б���
						ArrayList<Cart> childList = CartHelper.getCartItemsViaParentId(cart.getId());
						if(childList!=null&&childList.size()>0){
							//ȫ�����뵽�����
							for(int j=0;j<childList.size();j++)resList.add(childList.get(j));
						}
					}
				}//end if(getChild)
			}
		}
		
		return resList ;
	}
	/**
	 * ������ﳵ��ɾ�����ﳵ������ж���
	 * @param request
	 * @param response
	 */
	public static void clearAllCarts(HttpServletRequest request,HttpServletResponse response,String shopCode){
		clearAllCookieCarts(request,response,shopCode);
		
		clearAllLoginUserCarts(request,response,shopCode);
	}
	
	/**
	 * ���cookie�µĹ��ﳵ������Ŀ
	 */
	public static void clearAllCookieCarts(HttpServletRequest request,HttpServletResponse response,String shopCode){
		//��ȡ���ﳵ�����м�¼
		String cookie = CartHelper.getCartCookieValue(request, response);
		
		
		if(!Tools.isNull(cookie)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("cookie", cookie));
			
			//��ȡ�б�
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//���ɾ��
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//ɾ��cart
					if(shopCode.equals(c.getShopcode()))Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
	
	/**
	 * �����¼id�µĹ��ﳵ������Ŀ
	 * @param request
	 * @param response
	 */
	public static void clearAllLoginUserCarts(HttpServletRequest request,HttpServletResponse response,String shopCode){
		String userId = CartHelper.getCartUserId(request, response);
		
		if(!Tools.isNull(userId)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("userId", userId));
			
			//��ȡ�б�
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//���ɾ��
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//ɾ��cart
					if(shopCode.equals(c.getShopcode()))Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
		
}
