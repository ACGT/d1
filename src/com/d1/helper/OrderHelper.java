package com.d1.helper;

import java.sql.CallableStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.Const;
import com.d1.bean.Cart;
import com.d1.bean.Gdscoll_Order;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderHistory;
import com.d1.bean.OrderItemBase;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderRecent;
import com.d1.bean.PayMethod;
import com.d1.bean.PingAnUser;
import com.d1.bean.ProductExpPrice;
import com.d1.bean.ProductExpPriceItem;
import com.d1.bean.Ticket;
import com.d1.bean.Tuandh;
import com.d1.bean.User;
import com.d1.bean.UserAddress;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.service.OrderService;
import com.d1.util.Tools;


/**
 * ����������ط�����������Ҫ�����񷽷�������<br/>
 * @author kk
 *
 */
public class OrderHelper {
	
	/**
	 * ����ID��ö�������cache��Ȼ����main������recent��
	 * @param id - ID
	 * @return OrderCache
	 */
	
	public static boolean saveShipCode(String id, String odrmst_d1shipmethod, String odrmst_goodsodrid) {
		try {
			String ordertbl = "main";
			OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(id);
			
			if(order == null) {
				order = (OrderBase)Tools.getManager(OrderRecent.class).get(id);
				ordertbl = "recent";
			}
			//System.out.println(order);
			order.setOdrmst_goodsodrid(odrmst_goodsodrid);
			order.setOdrmst_d1shipmethod(odrmst_d1shipmethod);
			if(ordertbl.equals("main")) {
				Tools.getManager(OrderMain.class).update(order, true);
			}
			else if (ordertbl.equals("recent")) {
				Tools.getManager(OrderRecent.class).update(order, true);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static OrderBase getById(String id){
		if(Tools.isNull(id)) return null;
		OrderBase order = (OrderBase)Tools.getManager(OrderCache.class).get(id);
		
		if(order==null){
			order = (OrderBase)Tools.getManager(OrderMain.class).get(id);
		}
		
		if(order==null){
			order = (OrderRecent)Tools.getManager(OrderRecent.class).get(id);
		}
		
		if(order==null){
			order = (OrderHistory)Tools.getManager(OrderHistory.class).get(id);
		}
		return order ;
	}
	public static OrderBase getById2(String id){
		if(Tools.isNull(id)) return null;
		OrderBase order = (OrderBase)Tools.getManager(OrderCache.class).get(id);
		
		if(order==null){
			order = (OrderBase)Tools.getManager(OrderMain.class).get(id);
		}
		
		if(order==null){
			order = (OrderRecent)Tools.getManager(OrderRecent.class).get(id);
		}
		return order ;
	}
	public static boolean sendodr(String odrid,String shipname,String shipcode,String mngid,String shopCode){
		Session session = null ;
		Transaction tx = null ;
		CallableStatement cstmt = null;  
		try{
			session = MyHibernateUtil.currentSession(Const.HIBERNATE_CON_FILE) ;
			tx = session.beginTransaction() ;
			cstmt =session.connection().prepareCall("{call sp_sndodrshop(?,?,?,?,?,?) }");       
			/*@odrid	char(20),
			@mngid	varchar(50),
			@shopcode varchar(8),
			@shipname varchar(50),
			@shipcode varchar(50),
			@ret	int output*/
			//System.out.println("odrid=="+odrid+"==mngid=="+mngid+"====shopCode=="+shopCode+"=====shipname=="+shipname+"=====shipcode=="+shipcode+"=======");
			cstmt.setString(1, odrid);       
			cstmt.setString(2, mngid);   
			cstmt.setString(3, shopCode);   
			cstmt.setString(4, shipname);   
			cstmt.setString(5, shipcode);   
			cstmt.registerOutParameter(6, java.sql.Types.INTEGER);                   
			cstmt.executeUpdate(); 
			String ret=cstmt.getString(6);
			tx.commit();     
			
			//System.out.println("==========ret================="+ret);
			if(ret!=null&&Tools.parseInt(ret)==0){
				return true;
			}else{
				return false;
			}
			 
		}catch(Exception ex){	
			if(tx!=null)tx.rollback();
			ex.printStackTrace();
			return false;
		}finally{
			MyHibernateUtil.closeSession(Const.HIBERNATE_CON_FILE) ;
		}
	}
	
	/*public static boolean sendodr(String odrid,String shipname,String shipcode,String mngid,String shopCode){
		Session session = null ;
		Transaction tx = null ;
		String ret="";
		try{
			session = MyHibernateUtil.currentSession(Const.HIBERNATE_CON_FILE) ;
			tx = session.beginTransaction() ;
			ArrayList<ProcedureParam> list=new ArrayList<ProcedureParam>();
			ProcedureParam pp1=new ProcedureParam();
			pp1.setValue(odrid);
			list.add(pp1);		
			ProcedureParam pp2=new ProcedureParam();
			pp2.setValue(mngid);
			list.add(pp2);
			ProcedureParam pp3=new ProcedureParam();
			pp3.setValue(shopCode);
			list.add(pp3);
			ProcedureParam pp4=new ProcedureParam();
			pp4.setValue(shipname);
			list.add(pp4);
			ProcedureParam pp5=new ProcedureParam();
			pp5.setValue(shipcode);
			list.add(pp5);
			ProcedureParam pp6=new ProcedureParam();
			pp6.setOutParameter(true);
			pp6.setValue(ret);
			list.add(pp6);
			
			UserProcedureWork work = new UserProcedureWork("sp_sndodrshop",list);
			session.doWork(work);//ִ��work	        
			tx.commit();
			System.out.println("-----------------ret------"+ret);
	    	return true;
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			ex.printStackTrace();
			return false;
		}finally{
			MyHibernateUtil.closeSession(Const.HIBERNATE_CON_FILE) ;
		}
	}

	*/
	/**
	 * ����ID��ö�����history
	 * @param id - ID
	 * @return OrderCache
	 */
	public static OrderBase getHistoryById(String id){
		if(Tools.isNull(id)) return null;
		OrderBase order = (OrderBase)Tools.getManager(OrderHistory.class).get(id);
		return order ;
	}
	/**
	 * �ӹ��ﳵ��������
	 * @param request
	 * @param response
	 * @param address_id �û�ѡ��ĵ�ַid�����봫�룡
	 * @param payid ֧����ʽ����Ӧpaymst��Pay.java�������봫��
	 * @param deliver �ͻ�ʱ�䣬�硰������ʱ���ͻ��������봫��
	 * @param ticket_id ʹ�õ��Ż�ȯid���û�δѡ�Ż�ȯ������null�����ticket_id����null����ôticket_type������0��1��
	 * @param ticket_type ʹ��ȯ�����ͣ�0��ʾ����ȯ(tktmst)��1��ʾ�ۿ�ȯ(tktcrd)��2��ʾƷ�Ƽ��⣬��ticket_id���ʹ�ã�
	 * @param use_prepay �Ƿ�ʹ��Ԥ��false��ʹ�ã�trueʹ�ã���ʹ�ö���Ԥ�����ͨ��PrepayHelper.getPrepayCutMoney��������ģ�
	 * @param memo ��������
	 * @return OrderCache null�����׳��쳣�򴴽�ʧ��
	 */
	public static OrderCache createOrderFromCart(HttpServletRequest request,HttpServletResponse response,
			String address_id,String payid,String deliver,
			String ticket_id,String ticket_type,boolean use_prepay,String memo)
					throws Exception{
		
		//���ﳵ������ϸ����ʼ׼��������ݣ�������������������
		ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);
		
		User loginUser = UserHelper.getLoginUser(request, response);
		
		if(loginUser==null){
			System.out.println("�û�δ��¼���µ�ʧ�ܣ�");
			return null ;//���δ��¼�������µ�
		}
		
		UserAddress raddress = (UserAddress)Tools.getManager(UserAddress.class).get(address_id);//�ջ�����Ϣ
		UserAddress paddress = UserAddressHelper.getOwnUserAddress(loginUser.getId());//��������Ϣ�����µ���
		
		if(paddress==null)paddress = raddress ;
		
		//���û��ѡ���ջ��˵�ַ�������µ���һ�㲻�����
		if(raddress==null){
			System.out.println("û��ѡ���ջ��˵�ַ���µ�ʧ�ܣ�");
			return null ;
		}
		
		String rprovince,rcity,pprovince,pcity ;//�ջ��˶�����ʡ�ݺͳ���
		rprovince =  ProvinceHelper.getProvinceNameViaId(raddress.getMbrcst_provinceid()+"");
		rcity = CityHelper.getCityNameViaId(raddress.getMbrcst_cityid()+"");
		
		pprovince =  ProvinceHelper.getProvinceNameViaId(paddress.getMbrcst_provinceid()+"");
		pcity = CityHelper.getCityNameViaId(paddress.getMbrcst_cityid()+"");
		
		float gdsmoney = CartHelper.getTotalPayMoney(request, response) ;//��Ʒ�ܽ��������˷�
		float normal_money = CartHelper.getNormalProductMoney(request, response);//���Բμ�Eȯ���������Ҳ�������˷�
		//float getshopactmoney=  CartHelper.getShopActCutMoney(request, response);   //������Żݽ��
		
		
		
		//Ʒ�Ƽ�������ܼ����٣���ticket_type=2ʱ��Ч��������ticket_type!=2�������������ֵ
		float brand_save_money = TicketHelper.getBrandCutMoney(request, response) ;
		
		//ȯ��ʡ�µ�Ǯ����ticket_type=0��1ʱ��Ч������
		float ticket_save_money = TicketHelper.getMaxTicketSaveMoney(request, response, ticket_id, ticket_type, address_id, payid);
		ticket_save_money=Tools.getFloat(ticket_save_money, 0);
		float shipfee = OrderHelper.getExpressFee(request, response, address_id, payid,ticket_save_money);//�˷�
		
		//�����жϣ��Է���һ����
		if(normal_money>gdsmoney)normal_money=gdsmoney;//����һ�㲻����
		if(brand_save_money>normal_money)brand_save_money=normal_money;
		if(ticket_save_money>new Float(gdsmoney+shipfee).longValue())ticket_save_money=new Float(gdsmoney+shipfee).floatValue();
		//System.out.println("d1gjlticket_save_money"+ticket_save_money);
		//֧����ʽ.
		PayMethod paymethod = (PayMethod)Tools.getManager(PayMethod.class).get(payid);
		
		float prepay_money = 0f ;//����Ԥ���֧������
		
		if(use_prepay){//ʹ��Ԥ���
			prepay_money = PrepayHelper.getMaxPrepaySaveMoney(request, response, ticket_id, ticket_type, address_id, payid);
		}
		
		long sumawardvalue = CartHelper.getTotalProductPoint(request, response) ;//��Ʒ�������ܻ���
		
		String brdpidstr="";
		if("2".equals(ticket_type)){
			brdpidstr=CartHelper.getBrandPitemLists(request, response);
		memo=brdpidstr+"@@@@"+memo;
		}
		if("0".equals(ticket_type)){//tktmst����ȯ�����Լ��˷�
			Ticket ticket = (Ticket)Tools.getManager(Ticket.class).get(ticket_id);
			if(!Tools.isNull(ticket.getTktmst_sprckcodeStr())){
				brdpidstr=CartHelper.getCartSprckcodegdslist(request, response,ticket.getTktmst_sprckcodeStr());
				memo=brdpidstr+"@@@@"+memo;
			}
		}
			

		
		
		//���û�����һ����½�û����ܲ����µ������ȯ��Ǯ��������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(loginUser){
			//����Ǯ��������λС��
			gdsmoney = Tools.getFloat(gdsmoney, 2);
			normal_money = Tools.getFloat(normal_money, 2);
			prepay_money = Tools.getFloat(prepay_money, 2);
			shipfee = Tools.getFloat(shipfee, 2);
			
			OrderCache order = null ;
			//��ʼ�������񷽷���������������ϸ����Eȯ��Ԥ���
			try{
				System.out.println("�µ�userId��"+loginUser.getId());
				if(cartList!=null)
				for(Cart c:cartList){
					System.out.println("���ﳵ���� "+c.getProductId()+" "+c.getAmount());
				}
				OrderService os = (OrderService)Tools.getService(OrderService.class);
				order = os.createOrder(request, response, loginUser, cartList, 
						raddress, rprovince, rcity, 
						paddress, pprovince, pcity, 
						paymethod, deliver, gdsmoney, normal_money, 
						ticket_id, ticket_type, ticket_save_money, 
						prepay_money, shipfee,sumawardvalue,memo);
			
			}catch(Exception ex){
				ex.printStackTrace();
				System.out.println("�µ������Զ������µ�..........");
				
				try{
					OrderService os = (OrderService)Tools.getService(OrderService.class);
					order = os.createOrder(request, response, loginUser, cartList, 
							raddress, rprovince, rcity, 
							paddress, pprovince, pcity, 
							paymethod, deliver, gdsmoney, normal_money, 
							ticket_id, ticket_type, ticket_save_money, 
							prepay_money, shipfee,sumawardvalue,memo);
				
				}catch(Exception ex2){
					System.out.println("�����µ������µ�ʧ��..........");
					ex2.printStackTrace();
					return null ;
				}
			}
			//����µ��ɹ����Ҷ��������DIV���乺��
			//��Gdscoll_Order���������
			long dporder=0;
			for(Cart c:cartList){
				if(c.getType().longValue()==-6&&c.getTitle().equals("��DIY���乺���ҵ�ѡ��")&&c.getHasChild().longValue()==1){
					List<Cart> lslist=CartHelper.getCartItemsViaParentId(c.getId());
					if(lslist!=null&&lslist.size()>0){
				        dporder++;
						for(Cart c1:lslist){
							if(c1.getType()==16&&c1.getGiftType()!=null&&c1.getGiftType().length()>0&&Tools.isNumber(c1.getGiftType())){
								Gdscoll_Order go=new Gdscoll_Order();
								go.setGo_box(new Long(c1.getGiftType()));
								go.setGo_createtime(new Date());
								go.setGo_gdsid(c1.getProductId());
								go.setGo_odrid(order.getId());
								go.setGo_order(dporder);
								Tools.getManager(Gdscoll_Order.class).create(go);
							}
						}
					}
				}
			}
			CartHelper.clearAllCarts(request, response);//������������ɹ�����������ﳵ
			
			return order ;
			
		}
	}
	
	
	/**
	 * �ӹ��ﳵ��������
	 * @param request
	 * @param response
	 * @param address_id �û�ѡ��ĵ�ַid�����봫�룡
	 * @param payid ֧����ʽ����Ӧpaymst��Pay.java�������봫��
	 * @param deliver �ͻ�ʱ�䣬�硰������ʱ���ͻ��������봫��
	 * @param ticket_id ʹ�õ��Ż�ȯid���û�δѡ�Ż�ȯ������null�����ticket_id����null����ôticket_type������0��1��
	 * @param ticket_type ʹ��ȯ�����ͣ�0��ʾ����ȯ(tktmst)��1��ʾ�ۿ�ȯ(tktcrd)��2��ʾƷ�Ƽ��⣬��ticket_id���ʹ�ã�
	 * @param use_prepay �Ƿ�ʹ��Ԥ��false��ʹ�ã�trueʹ�ã���ʹ�ö���Ԥ�����ͨ��PrepayHelper.getPrepayCutMoney��������ģ�
	 * @param memo ��������
	 * @return OrderCache null�����׳��쳣�򴴽�ʧ��
	 */
	public static OrderCache createOrderSMFromCart(HttpServletRequest request,HttpServletResponse response,
			String address_id,String payid,String deliver,
			String ticket_id,String ticket_type,boolean use_prepay,String memo,String shopCode)
					throws Exception{
		
		//���ﳵ������ϸ����ʼ׼��������ݣ�������������������
		ArrayList<Cart> cartList = CartShopCodeHelper.getCartItems(request, response,shopCode);
		
		User loginUser = UserHelper.getLoginUser(request, response);
		
		if(loginUser==null){
			System.out.println("�û�δ��¼���µ�ʧ�ܣ�");
			return null ;//���δ��¼�������µ�
		}
		
		UserAddress raddress = (UserAddress)Tools.getManager(UserAddress.class).get(address_id);//�ջ�����Ϣ
		UserAddress paddress = UserAddressHelper.getOwnUserAddress(loginUser.getId());//��������Ϣ�����µ���
		
		if(paddress==null)paddress = raddress ;
		
		//���û��ѡ���ջ��˵�ַ�������µ���һ�㲻�����
		if(raddress==null){
			System.out.println("û��ѡ���ջ��˵�ַ���µ�ʧ�ܣ�");
			return null ;
		}
		
		String rprovince,rcity,pprovince,pcity ;//�ջ��˶�����ʡ�ݺͳ���
		rprovince =  ProvinceHelper.getProvinceNameViaId(raddress.getMbrcst_provinceid()+"");
		rcity = CityHelper.getCityNameViaId(raddress.getMbrcst_cityid()+"");
		
		pprovince =  ProvinceHelper.getProvinceNameViaId(paddress.getMbrcst_provinceid()+"");
		pcity = CityHelper.getCityNameViaId(paddress.getMbrcst_cityid()+"");
		
		float gdsmoney = CartShopCodeHelper.getTotalPayMoney(request, response,shopCode) ;//��Ʒ�ܽ��������˷�
		float normal_money = CartShopCodeHelper.getNormalProductMoney(request, response,shopCode);//���Բμ�Eȯ���������Ҳ�������˷�
		
		//Ʒ�Ƽ�������ܼ����٣���ticket_type=2ʱ��Ч��������ticket_type!=2�������������ֵ
		float brand_save_money =0f;
		float ticket_save_money =0f;
		long sumawardvalue =0;
		if(shopCode.equals("00000000")){
		brand_save_money=TicketHelper.getBrandCutMoney(request, response) ;
		//ȯ��ʡ�µ�Ǯ����ticket_type=0��1ʱ��Ч������
		ticket_save_money=TicketHelper.getMaxTicketSaveMoney(request, response, ticket_id, ticket_type, address_id, payid);
		ticket_save_money=Tools.getFloat(ticket_save_money, 0);
		sumawardvalue = CartHelper.getTotalProductPoint(request, response) ;//��Ʒ�������ܻ���
		}
		

		float shipfee = OrderHelper.getSMExpressFee(request, response, address_id, payid,ticket_save_money,shopCode);//�˷�
		
		//�����жϣ��Է���һ����
		if(normal_money>gdsmoney)normal_money=gdsmoney;//����һ�㲻����
		if(brand_save_money>normal_money)brand_save_money=normal_money;
		if(ticket_save_money>new Float(gdsmoney+shipfee).longValue())ticket_save_money=new Float(gdsmoney+shipfee).floatValue();
		//System.out.println("d1gjlticket_save_money"+ticket_save_money);
		//֧����ʽ.
		PayMethod paymethod = (PayMethod)Tools.getManager(PayMethod.class).get(payid);
		
		float prepay_money = 0f ;//����Ԥ���֧������
		
		if(use_prepay){//ʹ��Ԥ���
			prepay_money = PrepayHelper.getMaxPrepaySaveMoney(request, response, ticket_id, ticket_type, address_id, payid);
		}
		
		
		
		//���û�����һ����½�û����ܲ����µ������ȯ��Ǯ��������memcached�����ݿ⻺�棬���Ҫ�޸ĳɷֲ�ʽ�������ݿ���������
		synchronized(loginUser){
			//����Ǯ��������λС��
			gdsmoney = Tools.getFloat(gdsmoney, 2);
			normal_money = Tools.getFloat(normal_money, 2);
			prepay_money = Tools.getFloat(prepay_money, 2);
			shipfee = Tools.getFloat(shipfee, 2);
			
			OrderCache order = null ;
			//��ʼ�������񷽷���������������ϸ����Eȯ��Ԥ���
			try{
				System.out.println("�µ�userId��"+loginUser.getId());
				if(cartList!=null)
				for(Cart c:cartList){
					System.out.println("���ﳵ���� "+c.getProductId()+" "+c.getAmount());
				}
				OrderService os = (OrderService)Tools.getService(OrderService.class);
				order = os.createOrder(request, response, loginUser, cartList, 
						raddress, rprovince, rcity, 
						paddress, pprovince, pcity, 
						paymethod, deliver, gdsmoney, normal_money, 
						ticket_id, ticket_type, ticket_save_money, 
						prepay_money, shipfee,sumawardvalue,memo);
			
			}catch(Exception ex){
				ex.printStackTrace();
				System.out.println("�µ������Զ������µ�..........");
				
				try{
					OrderService os = (OrderService)Tools.getService(OrderService.class);
					order = os.createOrder(request, response, loginUser, cartList, 
							raddress, rprovince, rcity, 
							paddress, pprovince, pcity, 
							paymethod, deliver, gdsmoney, normal_money, 
							ticket_id, ticket_type, ticket_save_money, 
							prepay_money, shipfee,sumawardvalue,memo);
				
				}catch(Exception ex2){
					System.out.println("�����µ������µ�ʧ��..........");
					ex2.printStackTrace();
					return null ;
				}
			}
			//����µ��ɹ����Ҷ��������DIV���乺��
			//��Gdscoll_Order���������
			long dporder=0;
			for(Cart c:cartList){
				if(c.getType().longValue()==-6&&c.getTitle().equals("��DIY���乺���ҵ�ѡ��")&&c.getHasChild().longValue()==1){
					List<Cart> lslist=CartHelper.getCartItemsViaParentId(c.getId());
					if(lslist!=null&&lslist.size()>0){
				        dporder++;
						for(Cart c1:lslist){
							if(c1.getType()==16&&c1.getGiftType()!=null&&c1.getGiftType().length()>0&&Tools.isNumber(c1.getGiftType())){
								Gdscoll_Order go=new Gdscoll_Order();
								go.setGo_box(new Long(c1.getGiftType()));
								go.setGo_createtime(new Date());
								go.setGo_gdsid(c1.getProductId());
								go.setGo_odrid(order.getId());
								go.setGo_order(dporder);
								Tools.getManager(Gdscoll_Order.class).create(go);
							}
						}
					}
				}
			}
			CartShopCodeHelper.clearAllCarts(request, response,shopCode);//������������ɹ�����������ﳵ
			
			return order ;
			
		}
	}
	
	/**
	 * ��ȡ�ù��ﳵ���е��˷�
	 * @param request
	 * @param response
	 * @param address_id �û�ѡ��ĵ�ַid�����봫
	 * @param payId �û�ѡ���֧����ʽ�����봫
	 * @return
	 */
	public static float getExpressFee(HttpServletRequest request,HttpServletResponse response,String address_id,String payId,Float tktvalue){
		PayMethod pay = (PayMethod)Tools.getManager(PayMethod.class).get(payId);
		UserAddress ua = (UserAddress)Tools.getManager(UserAddress.class).get(address_id);
		
		if(pay==null||ua==null)return 10f;//��Ҫ�����������������
		
		float cartMoney = CartHelper.getTotalPayMoney(request, response);//���ﳵ֧�����
		cartMoney=cartMoney-tktvalue;
		//System.out.println("d1gjl��������1:"+cartMoney);
		//������ﳵ�������׶һ�ȯ��Ʒ�������˷�
		
		long gdstwofee=0;
		float dhfee=0f;
		ArrayList<Cart> list = CartHelper.getCartItems(request, response);
		if(list!=null&&list.size()>0){
			boolean only = false ;
			String dxid = Tools.getCookie(request,"rcmdusr_rcmid");
			boolean dxflag=false;
			if(!Tools.isNull(dxid)){
				ProductExpPrice pep=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(dxid));
				if(pep!=null){
					if(ProductExpPriceHelper.valid(pep)&&pep.getRcmdusr_sendcount().longValue()==1)dxflag=true;
				}
			}
			
			for(Cart c:list){
				if(c.getType().longValue()==13&&!Tools.isNull(c.getTuanCode())){
					Tuandh tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", c.getTuanCode().trim());
					if(tuandh!=null&&tuandh.getTuandh_shipfee()!=null
							&&tuandh.getTuandh_shipfee().longValue()==0&&tuandh.getTuandh_fee().longValue()>0){
						if(tuandh.getTuandh_fee()!=null&&tuandh.getTuandh_fee().floatValue()>dhfee){
						dhfee = tuandh.getTuandh_fee().floatValue() ;
						}
					}
				}
			}
			

			for(Cart c:list){
				
				boolean bl=false;
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				Date endDate=null;
				try{
					endDate =fmt.parse("2015-01-01");
					 }
				catch(Exception ex){
					ex.printStackTrace();
				}
				if(Tools.dateValue(endDate)>System.currentTimeMillis())
				{
				if(!Tools.isNull(dxid) && (dxid.equals("309")|| dxid.equals("337")|| dxid.equals("338"))){
					ProductExpPriceItem expitem=ProductExpPriceHelper.getExpPrice(c.getProductId().trim(), dxid);
					if(expitem!=null){
						only=true;
						break;
					}
				}
				}
				if(!Tools.isNull(dxid)&&dxflag){
					ProductExpPriceItem dxitem=ProductExpPriceHelper.getExpPrice(c.getProductId().trim(), dxid);
					if(dxitem!=null){
						only=true;
						break;
					}
			       }
				if(c.getProductId().equals("01518932")){
					bl=true;
					break;
					} 
				SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date endDate4=null;
				Date ndate=new Date();
				try{
					endDate4 =fmt.parse("2014-09-01 00:00:00");
					 }
				catch(Exception ex){
					ex.printStackTrace();
				}
				if(endDate4.getTime()>ndate.getTime()&&c.getType().longValue()==14&&(c.getProductId().equals("02103359")||c.getProductId().equals("01517871")
						||c.getProductId().equals("01519320")||c.getProductId().equals("01519290")||c.getProductId().equals("01417359")
						||c.getProductId().equals("01516824")||c.getProductId().equals("03300070")||c.getProductId().equals("01517687")
						)){
					only=true;
					break;
					}
				/*if(c.getType().longValue()==20&&c.getTitle().startsWith("��������")&&c.getPrice().floatValue()>10f){
					only=true;
					break;
					}*/
				
	
				Date endDate2=null;

				try{
					endDate2 =fmt.parse("2014-04-29 10:00:00");
					 }
				catch(Exception ex){
					ex.printStackTrace();
				}

				if(endDate2.getTime()>ndate.getTime()){
					if(PromotionProductHelper.getPProductByCodeGdsidExist("9246",c.getProductId()))gdstwofee+=c.getAmount().longValue();
				//System.out.println("------------------"+gdstwofee);
				}
				if(c.getType().longValue()==13&&!Tools.isNull(c.getTuanCode())){
					Tuandh tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", c.getTuanCode().trim());
					if(tuandh!=null&&tuandh.getTuandh_shipfee()!=null
							&&tuandh.getTuandh_shipfee().longValue()==1){
					only = true ;
					break;
					}
				}
				if(bl||(c.getType().longValue()==13&&c.getTuanCode()!=null&&(
                         c.getTuanCode().toLowerCase().startsWith("mq139yj140605")
						||c.getTuanCode().toLowerCase().startsWith("mq139yj140620")
						||c.getTuanCode().toLowerCase().startsWith("mq139yj140626")
						||c.getTuanCode().toLowerCase().startsWith("mq139yj140703")
						||c.getTuanCode().toLowerCase().startsWith("mq1390717")
						))){
					only = true ;
					break;
				}
				//if(c.getType().longValue()==19){
					//only = true ;
					//break;
					
				//}				
				/*if(c.getType().longValue()==14&&(c.getProductId().equals("03001179")
						||c.getProductId().equals("03000977")||c.getProductId().equals("03100083")
						||c.getProductId().equals("01710446")||c.getProductId().equals("04000373")
						||c.getProductId().equals("03200090")||c.getProductId().equals("03001274")
						||c.getProductId().equals("01517610")||c.getProductId().equals("01517610"))){
					only = true ;
					break;
				}*/
			}
			if(only&&dhfee==0f){
				return 0f;
			}
			if(gdstwofee>=2&&dhfee==0f)return 0f;
		}
		
		if(!payId.equals("0")&&!payId.equals("44")){//��㡢�ʾ֡�������֧��
			if(cartMoney>=59f&&dhfee==0f){
				return 0f ;//��99���˷�
			}else{
				if(dhfee<10f){
				return 10f;
				}else{
					return dhfee;
				}
			}
		}else{//��������
			
			/*if(ua.getMbrcst_provinceid()!=null){
//				if(ua.getMbrcst_provinceid().longValue()==1){//����������99���˷�
					//if(cartMoney>=199)return 0f;
					//else return 10f;
				//}else 
				if(ua.getMbrcst_provinceid().longValue()==1||ua.getMbrcst_provinceid().longValue()==2
					||ua.getMbrcst_provinceid().longValue()==20){//�������Ϻ����㶫��99���˷�
					if(cartMoney>=100)return 0f;
					//else return 10f;
				}else{//����������199���˷�
					if(cartMoney>=200)return 0f;
					else return 10f;
				}
			}else{//һ�㲻������������*/
			if(cartMoney>=99f&&dhfee==0f){
				return 0f;
			}else{
				if(dhfee<10f){
					return 10f;
					}else{
						return dhfee;
					}
			}
			//}
		}
		//return 10f;
	}
	/**
	 * ��ȡ�ù��ﳵ���е��˷�
	 * @param request
	 * @param response
	 * @param address_id �û�ѡ��ĵ�ַid�����봫
	 * @param payId �û�ѡ���֧����ʽ�����봫
	 * @return
	 */
	public static float getSMExpressFee(HttpServletRequest request,HttpServletResponse response,String address_id,String payId,Float tktvalue,String shopCode){
		PayMethod pay = (PayMethod)Tools.getManager(PayMethod.class).get(payId);
		UserAddress ua = (UserAddress)Tools.getManager(UserAddress.class).get(address_id);
		
		if(pay==null||ua==null)return 10f;//��Ҫ�����������������
		
		float cartMoney = CartShopCodeHelper.getTotalPayMoney(request, response,shopCode);//���ﳵ֧�����
		cartMoney=cartMoney-tktvalue;
		//System.out.println("d1gjl��������1:"+cartMoney);
		//������ﳵ�������׶һ�ȯ��Ʒ�������˷�
		ArrayList<Cart> list = CartShopCodeHelper.getCartItems(request, response,shopCode);
		if(list!=null&&list.size()>0){
			boolean only = false ;
			for(Cart c:list){
				String dxid = Tools.getCookie(request,"rcmdusr_rcmid");
				boolean bl=false;
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				Date endDate=null;
				try{
					endDate =fmt.parse("2013-03-01");
					 }
				catch(Exception ex){
					ex.printStackTrace();
				}
				if(Tools.dateValue(endDate)>System.currentTimeMillis())
				{
				if(!Tools.isNull(dxid) && dxid.equals("234")){
					ProductExpPriceItem expitem=ProductExpPriceHelper.getExpPrice(c.getProductId().trim(), dxid);
					if(expitem!=null){
							bl=true;
					}
				}
				}
				
				if(bl||(c.getType().longValue()==13&&c.getTuanCode()!=null&&(
						c.getTuanCode().toLowerCase().startsWith("mqwycj1301pd")
						||(c.getTuanCode().toLowerCase().startsWith("mqdd1301myzero") && c.getProductId().equals("02001160"))
						||(c.getTuanCode().toLowerCase().startsWith("mqdd1301pj") && c.getProductId().equals("01719683"))
						||(c.getTuanCode().toLowerCase().startsWith("mqdd1301mgh") && c.getProductId().equals("01517367"))
						||(c.getTuanCode().toLowerCase().startsWith("mqdd1301hf") && c.getProductId().equals("01417366"))
						||(c.getTuanCode().toLowerCase().startsWith("mqdd1301yd") && c.getProductId().equals("01417256"))
						||(c.getTuanCode().toLowerCase().startsWith("mqdd1301ylm") && c.getProductId().equals("01417237"))
						||(c.getTuanCode().toLowerCase().startsWith("mqwydh1301pd") && (c.getProductId().equals("03300077") || c.getProductId().equals("03300076") || c.getProductId().equals("01517367") || c.getProductId().equals("02001030")))
						||(c.getTuanCode().toLowerCase().startsWith("mqwyjfj1302sp") && c.getProductId().equals("01516824"))
						||c.getTuanCode().toLowerCase().startsWith("mqdd13031fzcj")	||c.getTuanCode().toLowerCase().startsWith("mqdd13032fzcj")
						||c.getTuanCode().toLowerCase().startsWith("mqdd13033fzcj")	||c.getTuanCode().toLowerCase().startsWith("mqdd13031mzcj")
						||c.getTuanCode().toLowerCase().startsWith("mqdd13032mzcj")	||c.getTuanCode().toLowerCase().startsWith("mqdd13033mzcj")
						||c.getTuanCode().toLowerCase().startsWith("mqdd13031pscj")	||c.getTuanCode().toLowerCase().startsWith("mqdd13032pscj")
						||c.getTuanCode().toLowerCase().startsWith("mqdd1303cjlp")	||c.getTuanCode().toLowerCase().startsWith("mqwyjf1302jsp")
						||(c.getTuanCode().toLowerCase().startsWith("mqwyjfd1303qb") && (c.getProductId().equals("03300070")||c.getProductId().equals("03300071")))
						||c.getTuanCode().toLowerCase().startsWith("mqwyjf1303qb")
						||(c.getTuanCode().toLowerCase().startsWith("mqwyjfd1304qbpl") && (c.getProductId().equals("03300070")||c.getProductId().equals("03300071")||c.getProductId().equals("03000117")||c.getProductId().equals("03000118")||c.getProductId().equals("03000119")
								||c.getProductId().equals("03000120")||c.getProductId().equals("03000121")||c.getProductId().equals("03000122")||c.getProductId().equals("03000123")||c.getProductId().equals("03000124")||c.getProductId().equals("03000125")
								||c.getProductId().equals("02300233")))
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfc1304qb")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfc1304pl")
						||c.getTuanCode().toLowerCase().startsWith("mqdd1304l")
						||c.getTuanCode().toLowerCase().startsWith("mqdd1304n")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfc1304sp")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfc1304cs")
						||(c.getTuanCode().toLowerCase().startsWith("mqwyjfd1304spcs")&&(c.getProductId().equals("01515468")||c.getProductId().equals("01715919")||c.getProductId().equals("03300070")
								||c.getProductId().equals("03300071")||c.getProductId().equals("02300233")||c.getProductId().equals("01516150")))	
						||c.getTuanCode().toLowerCase().startsWith("mqpps1304c")
						||(c.getTuanCode().toLowerCase().startsWith("mqwyjfd1304spcs")&&(c.getProductId().equals("01715915")||c.getProductId().equals("01715916")||c.getProductId().equals("01715917")
								||c.getProductId().equals("01715918")||c.getProductId().equals("01715919")))
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfc1305bt")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfc1305gt")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfd1305tx")
                        ||c.getTuanCode().toLowerCase().startsWith("mq1305cja")
						||c.getTuanCode().toLowerCase().startsWith("mq1305cjb")
						||c.getTuanCode().toLowerCase().startsWith("mq1305cjc")
						||c.getTuanCode().toLowerCase().startsWith("mqpmy1305j")
						||c.getTuanCode().toLowerCase().startsWith("mqaqy1305yd")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfcj1305dj")
						||c.getTuanCode().toLowerCase().startsWith("mqwyjfd1305dj")
						||c.getTuanCode().toLowerCase().startsWith("mqwycj1307zj")
						  
						))
						||(c.getType().longValue()==2&&c.getProductId()!=null&&c.getProductId().equals("01720843")&&c.getAmount().longValue()>=3)){
					only = true ;
					break;
				}
				if(c.getType().longValue()==19){
					only = true ;
					break;
				}
			}
			if(only){
				return 0f;
			}
		}
		
		if(!payId.equals("0")&&!payId.equals("44")){//��㡢�ʾ֡�������֧��
			if(cartMoney>=99f){
				return 0f ;//��99���˷�
			}else{
				return 10f;
			}
		}else{//��������
			
			if(ua.getMbrcst_provinceid()!=null){
//				if(ua.getMbrcst_provinceid().longValue()==1){//����������99���˷�
					//if(cartMoney>=199)return 0f;
					//else return 10f;
				//}else 
				if(ua.getMbrcst_provinceid().longValue()==1||ua.getMbrcst_provinceid().longValue()==2
					||ua.getMbrcst_provinceid().longValue()==20){//�������Ϻ����㶫��99���˷�
					if(cartMoney>=100)return 0f;
					//else return 10f;
				}else{//����������199���˷�
					if(cartMoney>=200)return 0f;
					else return 10f;
				}
			}else{//һ�㲻������������
				return 10f;
			}
		}
		return 10f;
	}
	/**
	 * �޸Ķ�������Դ��ַ
	 * @param orderId - ����id
	 * @param strSrcurl - ��Դ
	 * @return true or false
	 */
	public static boolean updateOdrmstCacheSrcurl(String orderId , String strSrcurl){
		if(Tools.isNull(orderId)||Tools.isNull(strSrcurl)) return false;
		
		OrderBase order = getById(orderId);
		if(order==null)return false;
		
		if(!strSrcurl.equals(order.getOdrmst_srcurl())){
			order.setOdrmst_srcurl(strSrcurl);
			return Tools.getManager(order.getClass()).update(order, false);
		}
		return true;
	}
	
	/**
	 * �������˱��
	 * @param orderId - ����id
	 * @param strOdrmstTemp - ���
	 * @return True or False
	 */
	public static boolean updateOdrmstCacheTemp(String orderId , String strOdrmstTemp){
		if(Tools.isNull(orderId)||Tools.isNull(strOdrmstTemp)) return false;
		
		OrderBase order = getById(orderId);
		if(order==null)return false;
		
		if(!strOdrmstTemp.equals(order.getOdrmst_temp())){
			order.setOdrmst_temp(strOdrmstTemp);
			return Tools.getManager(order.getClass()).update(order, false);
		}
		return true;
	}
	
	/**
	 * �޸Ķ������Ƽ���
	 * @param order - ����
	 * @param strPeoplercm - �Ƽ���ID
	 * @param strSubad - �
	 * @return True or False
	 */
	public static boolean updateOdrmstCachePeoplercm(String orderId , String strPeoplercm, String strSubad){
		if(Tools.isNull(orderId) || Tools.isNull(strPeoplercm) || Tools.isNull(strSubad)) return false;
		
		OrderBase order = getById(orderId);
		if(order==null)return false;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", order.getId()));
		listRes.add(Restrictions.eq("odrdtl_jcflag", new Long(0)));
		
		List<BaseEntity> list = null ;
		
		if(order instanceof OrderCache){
			list = Tools.getManager(OrderItemCache.class).getList(listRes, null, 0, 1000);
		}else if(order instanceof OrderMain){
			list = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		}else if(order instanceof OrderRecent){
			list = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
		}else if(order instanceof OrderHistory){
			list = Tools.getManager(OrderHistory.class).getList(listRes, null, 0, 1000);
		}
		
		if(list != null && !list.isEmpty()){
			boolean isUpdate = false;
			int size = list.size();
			for(int i=0;i<size;i++){
				OrderItemBase ois = (OrderItemBase)list.get(i);
				String rackcode = ois.getOdrdtl_rackcode();
				if(rackcode!=null && rackcode.length()>3) rackcode = rackcode.substring(0,3);
				long speclal = Tools.longValue(ois.getOdrdtl_specialflag());
				if(!"000".equals(rackcode) && (speclal & 2)==0){
					isUpdate = true;
					break;
				}
			}
			if(isUpdate){
				if(!strPeoplercm.equals(order.getOdrmst_peoplercm()) || !strSubad.equals(order.getOdrmst_subad())){
					order.setOdrmst_peoplercm(strPeoplercm);
					order.setOdrmst_subad(strSubad);
					return Tools.getManager(order.getClass()).update(order, false);
				}
			}
		}
		return false;
	}
	
	/**
	 * ���˵�--odrmst_cache
	 */
	public static ArrayList<OrderCache> getOrderCacheList(String odrmst_temp,Date start,Date end){
		ArrayList<OrderCache> list=new ArrayList<OrderCache>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("odrmst_orderdate", start));
		listRes.add(Restrictions.le("odrmst_orderdate", end));
		listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
		List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderCache)be);
		}
		return list;
	}
	/**
	 * ���˵�--odrmst
	 */
	public static ArrayList<OrderMain> getOrderMainList(String odrmst_temp,Date start,Date end){
		ArrayList<OrderMain> list=new ArrayList<OrderMain>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("odrmst_orderdate", start));
		listRes.add(Restrictions.le("odrmst_orderdate", end));
		listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
		List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderMain)be);
		}
		return list;
	}
	/**
	 * ���˵�--odrmst_recent
	 */
	public static ArrayList<OrderRecent> getOrderRecentList(String odrmst_temp,Date start,Date end){
		ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("odrmst_orderdate", start));
		listRes.add(Restrictions.le("odrmst_orderdate", end));
		listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
		List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderRecent)be);
		}
		return list;
	}
	
	
	/**
	 * ���˵� 
	 */
	
	public static ArrayList<OrderBase> getOrderList(String odrmst_temp,Date start,Date end){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();

		ArrayList<OrderCache> listcache=getOrderCacheList(odrmst_temp, start, end);
		if(listcache!=null){
			for(OrderCache ordercache:listcache){
				list.add(ordercache);
			}
		}

		ArrayList<OrderMain> listmain=getOrderMainList(odrmst_temp, start, end);
		if(listmain!=null){
			for(OrderMain ordermain:listmain){
				list.add(ordermain);
			}
		}
	
		ArrayList<OrderRecent> listrecent=getOrderRecentList(odrmst_temp, start, end);
		if(listrecent!=null){
			for(OrderRecent orderrecent:listrecent){
				list.add(orderrecent);
			}
		}
		if(list==null || list.size()==0){
			return null;
		}

		return list;
	}

	/**
	 * ���˵�--odrmst_cache
	 */
	public static ArrayList<OrderCache> getOrderCacheList(String odrmst_temp,Date start,Date end,int type){
		ArrayList<OrderCache> list=new ArrayList<OrderCache>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		if(type==1){
		listRes.add(Restrictions.ge("odrmst_update", start));
		listRes.add(Restrictions.le("odrmst_update", end));
		}else{
			listRes.add(Restrictions.ge("odrmst_orderdate", start));
			listRes.add(Restrictions.le("odrmst_orderdate", end));
		}
		listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
		List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderCache)be);
		}
		return list;
	}
	/**
	 * ���˵�--odrmst
	 */
	public static ArrayList<OrderMain> getOrderMainList(String odrmst_temp,Date start,Date end,int type){
		ArrayList<OrderMain> list=new ArrayList<OrderMain>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		if(type==1){
			listRes.add(Restrictions.ge("odrmst_update", start));
			listRes.add(Restrictions.le("odrmst_update", end));
			}else{
				listRes.add(Restrictions.ge("odrmst_orderdate", start));
				listRes.add(Restrictions.le("odrmst_orderdate", end));
			}
		listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
		List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderMain)be);
		}
		return list;
	}
	/**
	 * ���˵�--odrmst_recent
	 */
	public static ArrayList<OrderRecent> getOrderRecentList(String odrmst_temp,Date start,Date end,int type){
		ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		if(type==1){
			listRes.add(Restrictions.ge("odrmst_update", start));
			listRes.add(Restrictions.le("odrmst_update", end));
			}else{
				listRes.add(Restrictions.ge("odrmst_orderdate", start));
				listRes.add(Restrictions.le("odrmst_orderdate", end));
			}
		listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
		List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderRecent)be);
		}
		return list;
	}
	public static ArrayList<OrderBase> getOrderList(String odrmst_temp,Date start,Date end,int type){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();

		ArrayList<OrderCache> listcache=getOrderCacheList(odrmst_temp, start, end,type);
		if(listcache!=null){
			for(OrderCache ordercache:listcache){
				list.add(ordercache);
			}
		}

		ArrayList<OrderMain> listmain=getOrderMainList(odrmst_temp, start, end,type);
		if(listmain!=null){
			for(OrderMain ordermain:listmain){
				list.add(ordermain);
			}
		}
	
		ArrayList<OrderRecent> listrecent=getOrderRecentList(odrmst_temp, start, end,type);
		if(listrecent!=null){
			for(OrderRecent orderrecent:listrecent){
				list.add(orderrecent);
			}
		}
		if(list==null || list.size()==0){
			return null;
		}

		return list;
	}

	public static ArrayList<OrderMain> getShopOrderMainList(String shopcode,Date start,Date end){
		ArrayList<OrderMain> list=new ArrayList<OrderMain>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("odrmst_validdate", start));
		listRes.add(Restrictions.le("odrmst_validdate", end));
		listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(1)));
		listRes.add(Restrictions.eq("odrmst_sndshopcode", shopcode));
		List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderMain)be);
		}
		return list;
	}
	public static ArrayList<OrderRecent> getShopOrderRecentList(String shopcode,Date start,Date end){
		ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("odrmst_validdate", start));
		listRes.add(Restrictions.le("odrmst_validdate", end));
		listRes.add(Restrictions.ge("odrmst_orderstatus", new Long(1)));
		listRes.add(Restrictions.eq("odrmst_sndshopcode", shopcode));
		List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 3000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((OrderRecent)be);
		}
		return list;
	}
	public static ArrayList<OrderBase> getOrderShopList(String shopcode,Date start,Date end){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
	
		ArrayList<OrderMain> listmain=getShopOrderMainList(shopcode, start, end);
		if(listmain!=null){
			for(OrderMain ordermain:listmain){
				list.add(ordermain);
			}
		}
		ArrayList<OrderRecent> listrecent=getShopOrderRecentList(shopcode, start, end);
		if(listrecent!=null){
			for(OrderRecent orderrecent:listrecent){
				list.add(orderrecent);
			}
		}
		if(list==null || list.size()==0){
			return null;
		}
		return list;
	}
	/**
	 * ɸѡ�������׷�������ע�Ტ�µ��Ķ�����Ϣ
	 */
	public static ArrayList<OrderBase> getOrderList_wangyi(String odrmst_temp,Date start,Date end){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		ArrayList<OrderBase> orderlist=getOrderList(odrmst_temp,start,end);
		if(orderlist!=null){
			for(OrderBase order:orderlist){
				//ArrayList<User163> wangyilist=UserHelper. getUser163Info(order.getOdrmst_mbrid());
				//if(wangyilist!=null && wangyilist.size()>0){
					list.add(order);
				//}
			}
		}
		if(list==null || list.size()==0) return null;
		return list;
	}
	/**
	 * ƽ��ʵʱ������ѯ
	 * @param odrmst_temp
	 * @param start
	 * @param end
	 * @param odrmst_odrid
	 * @param memberid
	 * @return
	 */
	public static ArrayList<OrderBase> getOrderList_pingan(Date start,Date end,String odrid,String memberid){

		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_temp","pingan"));
		if (start!=null){
			listRes.add(Restrictions.ge("odrmst_orderdate",start));
		}
		if (end!=null){
			listRes.add(Restrictions.le("odrmst_orderdate",end));
		}
		if (!Tools.isNull(odrid)){
			listRes.add(Restrictions.eq("id",odrid));
		}
		if (Tools.isNull(memberid)){
			PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_memberid", memberid);
			if (pauser!=null){
				listRes.add(Restrictions.eq("odrmst_mbrid",pauser.getMbrmstpingan_mbrid()));
			}
		}
		
		//���뻺�涩��
		List<BaseEntity> list_cache = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 1000);
		
		if(list_cache!=null&&list_cache.size()>0){
			for(BaseEntity be:list_cache){
				OrderBase ob = (OrderBase)be;
				ob.setType(1);//��ʾΪcache����
				rlist.add(ob);
			}
		}
		
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		
		//����recent����
		List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 2000);
		
		if(list_recent!=null&&list_recent.size()>0){
			for(BaseEntity be:list_recent){
				OrderBase ob = (OrderBase)be;
				ob.setType(3);//��ʾΪrecent����
				rlist.add(ob);
			}
		}		
		
		//����
		Collections.sort(rlist,new OrderCreateTimeComparator());
		
		return rlist;
	}

	/**
	 * ���ݻ�Ա�Ż�ȡ��ʷ����(�ĸ���ǰ�Ķ���)
	 */
	public static ArrayList<OrderBase> getOrderHistoryListByMbrid(String mbrid,int count)
	{
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_mbrid", new Long(mbrid)));
		
		List<BaseEntity> list_history = Tools.getManager(OrderHistory.class).getList(listRes, null, 0, count);
		if(list_history!=null&&list_history.size()>0)
		{
			for(BaseEntity be:list_history)
			{
				list.add((OrderHistory)be);
			}
		}
		Collections.sort(list,new OrderCreateTimeComparator());
		return list;
		
	}
	
	/**
			 * ���ݻ�Ա�Ż�ȡ��ʷ����(�ĸ���ǰ�Ķ���)�����
			 */
			public static ArrayList<OrderBase> getOrderHistoryByMbrid(String mbrid,int count)
			{
				ArrayList<OrderBase> list=new ArrayList<OrderBase>();
				List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
				listRes.add(Restrictions.eq("odrmst_mbrid", new Long(mbrid)));
				//��ñ���ȵ�һ��
	    		Calendar c = Calendar.getInstance();
				c.set(c.get(Calendar.YEAR), 0, 1);
				c.set(Calendar.HOUR_OF_DAY, 0);
				c.set(Calendar.MINUTE, 0);
				c.set(Calendar.SECOND, 0);
				Date d = c.getTime();	
				listRes.add(Restrictions.gt("odrmst_orderdate",c.getTime()));
				
				List<BaseEntity> list_history = Tools.getManager(OrderHistory.class).getList(listRes, null, 0, count);
				if(list_history!=null&&list_history.size()>0)
				{
					for(BaseEntity be:list_history)
					{
						list.add((OrderHistory)be);
					}
				}
				Collections.sort(list,new OrderCreateTimeComparator());
				return list;
				
			}

	
	/**
	 * �õ�4�����ڵ����ж�����ע�������OrderBase��Ҫ��ȡ����������м�¼<br/>
	 * �õ���OrderBase�������getType=1��ʾcache���������getType=2��ʾmain������getType=3��recent������<br/>
	 * @param mbrId
	 * @return
	 */
	public static ArrayList<OrderBase> getTotalOrderListIn4Months(String mbrId){
		if(Tools.isNull(mbrId))return null;
		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
		
		//���뻺�涩��
		List<BaseEntity> list_cache = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 1000);
		
		if(list_cache!=null&&list_cache.size()>0){
			for(BaseEntity be:list_cache){
				OrderBase ob = (OrderBase)be;
				ob.setType(1);//��ʾΪcache����
				rlist.add(ob);
			}
		}
		
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		
		//����recent����
		List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
		
		if(list_recent!=null&&list_recent.size()>0){
			for(BaseEntity be:list_recent){
				OrderBase ob = (OrderBase)be;
				ob.setType(3);//��ʾΪrecent����
				rlist.add(ob);
			}
		}		
		
		//����
		Collections.sort(rlist,new OrderCreateTimeComparator());
		
		return rlist;
	}
	public static ArrayList<OrderBase> getOrderMain(String mbrId){
		if(Tools.isNull(mbrId))return null;
		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
		listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(1)));
		listRes.add(Restrictions.le("odrmst_orderstatus",new Long(2)));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("odrmst_orderdate"));
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, listOrder, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		
	
		
		return rlist;
	}
	
	public static ArrayList<OrderBase> getOrderMRecent(String mbrId){
		if(Tools.isNull(mbrId))return null;
		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
		listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
		listRes.add(Restrictions.le("odrmst_orderstatus",new Long(31)));
		listRes.add(Restrictions.ne("odrmst_orderstatus",new Long(5)));
		listRes.add(Restrictions.ne("odrmst_orderstatus",new Long(6)));
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		//����recent����
				List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
				
				if(list_recent!=null&&list_recent.size()>0){
					for(BaseEntity be:list_recent){
						OrderBase ob = (OrderBase)be;
						ob.setType(3);//��ʾΪrecent����
						rlist.add(ob);
					}
				}		
				
				//����
				Collections.sort(rlist,new OrderCreateTimeComparator());
	
		
		return rlist;
	}
	
	/**
	 * �õ�4�����ڵ����ж�����ע�������OrderBase��Ҫ��ȡ����������м�¼<br/>
	 * �õ���OrderBase�������getType=1��ʾcache���������getType=2��ʾmain������getType=3��recent������<br/>
	 * @param mbrname
	 * @return
	 */
	public static ArrayList<OrderBase> getTotalOrderListIn4MonthsBymbrname(String mbrname){
		if(Tools.isNull(mbrname))return null;
		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_rname",mbrname));
		
		//���뻺�涩��
		List<BaseEntity> list_cache = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 1000);
		
		if(list_cache!=null&&list_cache.size()>0){
			for(BaseEntity be:list_cache){
				OrderBase ob = (OrderBase)be;
				ob.setType(1);//��ʾΪcache����
				rlist.add(ob);
			}
		}
		
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		
		//����recent����
		List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
		
		if(list_recent!=null&&list_recent.size()>0){
			for(BaseEntity be:list_recent){
				OrderBase ob = (OrderBase)be;
				ob.setType(3);//��ʾΪrecent����
				rlist.add(ob);
			}
		}		
		
		//����
		Collections.sort(rlist,new OrderCreateTimeComparator());
		
		return rlist;
	}
	
	/**
	 * �õ�4�����ڵ����ж�����ע�������OrderBase��Ҫ��ȡ����������м�¼<br/>
	 * �õ���OrderBase�������getType=1��ʾcache���������getType=2��ʾmain������getType=3��recent������<br/>
	 * @param mbrId
	 * @return
	 */
	public static ArrayList<OrderBase> getTotalListIn4MonthsBynameAndid(String mbrname,String mbrid){
		if(Tools.isNull(mbrname))return null;
		if(Tools.isNull(mbrid))return null;
		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_rname",mbrname));
		listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrid)));
		
		//���뻺�涩��
		List<BaseEntity> list_cache = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 1000);
		
		if(list_cache!=null&&list_cache.size()>0){
			for(BaseEntity be:list_cache){
				OrderBase ob = (OrderBase)be;
				ob.setType(1);//��ʾΪcache����
				rlist.add(ob);
			}
		}
		
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		
		//����recent����
		List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
		
		if(list_recent!=null&&list_recent.size()>0){
			for(BaseEntity be:list_recent){
				OrderBase ob = (OrderBase)be;
				ob.setType(3);//��ʾΪrecent����
				rlist.add(ob);
			}
		}		
		
		//����
		Collections.sort(rlist,new OrderCreateTimeComparator());
		
		return rlist;
	}
	
	/**
	 * ���ݻ�Ա�ź�ʱ��λ�ȡ����(���ֻ���)
	 * 
	 * @param mbrid ��Ա��
	 * @param orderdate ����ʱ��
	 * @param predate ��ʼʱ��
	 * @return
	 */
	public static ArrayList<OrderBase> getOrderHistoryListByMbridAndDate(String mbrid,Date orderdate,Date predate)
	{
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_mbrid", new Long(mbrid)));
		listRes.add(Restrictions.ge("odrmst_orderdate",predate));
		listRes.add(Restrictions.le("odrmst_orderdate", orderdate));
		
		List<BaseEntity> list_history = Tools.getManager(OrderHistory.class).getList(listRes, null, 0, 1000);
		if(list_history!=null&&list_history.size()>0)
		{
			for(BaseEntity be:list_history)
			{
				list.add((OrderHistory)be);
			}
		}
		Collections.sort(list,new OrderCreateTimeComparator());
		return list;
		
	}
	/**
	 * 
	 * ���ݶ���ʱ��ͻ�Ա�Ż�ȡ�������ݣ����ڻ�ȡ�������飩
	 * @param mbrid ��Ա��
	 * @param orderdate ����ʱ��
	 * @param predate ��ʼʱ��
	 * @return
	 */
	public static ArrayList<OrderBase> getOrderListIn4MonthsBytime(String mbrid,Date orderdate,Date predate)
	{
		if(Tools.isNull(mbrid))return null;
		if(Tools.isNull(orderdate.toString())) return null;
		ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrid)));
		listRes.add(Restrictions.ge("odrmst_orderdate",predate));
		listRes.add(Restrictions.le("odrmst_orderdate", orderdate));
		//���뻺�涩��
		List<BaseEntity> list_cache = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 1000);
		
		if(list_cache!=null&&list_cache.size()>0){
			for(BaseEntity be:list_cache){
				OrderBase ob = (OrderBase)be;
				ob.setType(1);//��ʾΪcache����
				rlist.add(ob);
			}
		}
		
		//����main����
		List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
		
		if(list_main!=null&&list_main.size()>0){
			for(BaseEntity be:list_main){
				OrderBase ob = (OrderBase)be;
				ob.setType(2);//��ʾΪmain����
				rlist.add(ob);
			}
		}
		
		//����recent����
		List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
		
		if(list_recent!=null&&list_recent.size()>0){
			for(BaseEntity be:list_recent){
				OrderBase ob = (OrderBase)be;
				ob.setType(3);//��ʾΪrecent����
				rlist.add(ob);
			}
		}		
		
		//����
		Collections.sort(rlist,new OrderCreateTimeComparator());
		
		return rlist;
	}
	
	
	/**
	 * ��ȡ��ȫ���ջ������������ջ����Ķ�����Ϣ
	 */
	public static ArrayList<OrderBase> getMyFinishOrderList(String mbrid){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		ArrayList<OrderBase> newlist=getTotalOrderListIn4Months(mbrid);
		ArrayList<OrderBase> oldlist= getOrderHistoryListByMbrid(mbrid,1000);
		if(newlist!=null){
			for(OrderBase base:newlist){
				if(base.getOdrmst_orderstatus().intValue()==3 || base.getOdrmst_orderstatus().intValue()==31 ){
					list.add(base);
				}
			}
		}
		if(oldlist!=null){
			for(OrderBase base:oldlist){
				if(base.getOdrmst_orderstatus().intValue()==3 || base.getOdrmst_orderstatus().intValue()==31 ){
					list.add(base);
				}
			}
		}
		return list;
		
	}
	/**
	 * ��ȡ��ȫ���ջ������������ջ����Ķ�����Ϣ
	 */
	public static ArrayList<OrderBase> getMyFinishOrderList2(String mbrid){
		ArrayList<OrderBase> list=new ArrayList<OrderBase>();
		ArrayList<OrderBase> newlist=getTotalOrderListIn4Months(mbrid);
		
		if(newlist!=null){
			for(OrderBase base:newlist){
				if(base.getOdrmst_orderstatus().intValue()==3 || base.getOdrmst_orderstatus().intValue()==31 ){
					list.add(base);
				}
			}
		}
		return list;
		
	}
	/**
	 * �õ���������Ʒ���
	 * @param orderId
	 * @return
	 */
	public static double getOrderTotalProductMoney(String orderId){
		OrderBase order = getById(orderId);
		if(order==null)return 0f;
		
		return Tools.getDouble(order.getOdrmst_gdsmoney(), 2);
	}
	
	/**
	 * �õ��������˷�
	 * @param orderId
	 * @return
	 */
	public static double getOrderExpressFee(String orderId){
		OrderBase order = getById(orderId);
		if(order==null)return 0f;
		
		return Tools.getDouble(order.getOdrmst_shipfee(), 2);
	}
	
	/**
	 * �������Żݣ���ȯ
	 * @param orderId
	 * @return
	 */
	public static float getOrderTotalCut(String orderId){
		OrderBase order = getById(orderId);
		if(order==null)return 0f;
		
		return Tools.getFloat(order.getOdrmst_tktvalue().floatValue(), 2);
	}
	/**
	 * 
	 * Ԥ���
	 * @param orderId
	 * @return
	 */
	public static float getOrderTotalCut1(String orderId){
		OrderBase order = getById(orderId);
		if(order==null||order.getOdrmst_prepayvalue()==null)return 0f;
		
		return Tools.getFloat(order.getOdrmst_prepayvalue().floatValue(), 2);
	}
	
	/**
	 * �����ܽ���Ҫ֧����Ǯ
	 * @param orderId
	 * @return
	 */
	public static double getOrderTotalMoney(String orderId){
		OrderBase order = getById(orderId);
		if(order==null)return 0f;
		
		return Tools.getDouble(order.getOdrmst_acturepaymoney(), 2);
	}
	
	/**
	 * ��ö�����ϸ�б� by cg
	 * @param order - �������� OrderBase
	 * @return List<OrderItemBase>
	 */
	public static List<OrderItemBase> getOrderItemList(OrderBase order){
		if(order == null) return null;
		return getOrderItemList(order.getId());
	}
	
	/**
	 * ��ö�����ϸ�б� by cg
	 * @param type - ��������
	 * @param orderId - ����ID
	 * @return List<OrderItemBase>
	 */
	public static List<OrderItemBase> getOrderItemList(String orderId){
		if(Tools.isNull(orderId)) return null;
		OrderBase order = (OrderBase)getById(orderId);
		if(order==null)return null;
		if(order instanceof OrderCache){
			return OrderItemHelper.getOdrdtlCacheByOrderId(orderId);
		}else if(order instanceof OrderMain){
			return OrderItemHelper.getOdrdtlByOrderId(orderId);
		}else if(order instanceof OrderRecent){
		   	return OrderItemHelper.getOdrdtRecentlByOrderId(orderId);
		}else if(order instanceof OrderHistory){
		   	return OrderItemHelper.getOdrdtHistorylByOrderId(orderId);
		}
		return null;
	}
	
}

/**
 * ��������ʱ�����򣬵��򣡣�
 * @author kk
 *
 */
class OrderCreateTimeComparator implements Comparator<OrderBase>{

	@Override
	public int compare(OrderBase p0, OrderBase p1) {
		if(p0.getOdrmst_orderdate()!=null&&p1.getOdrmst_orderdate()!=null){
			if(p0.getOdrmst_orderdate().getTime()>p1.getOdrmst_orderdate().getTime()){
				return -1 ;
			}else if(p0.getOdrmst_orderdate().getTime()==p1.getOdrmst_orderdate().getTime()){
				return 0 ;
			}else{
				return 1 ;
			}
		}
		return 0;
	}

}
