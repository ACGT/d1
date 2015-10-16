package com.d1.service;

import java.io.File;
import java.io.FileWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringEscapeUtils;
import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.CartItem;
import com.d1.bean.GiftItem;
import com.d1.bean.Order360buy;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.Product;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.dbcache.core.BaseEntity;
import com.d1.helper.ProductHelper;
import com.d1.util.Tools;

public class Order360buyService {
	/**
	 * 创建京东订单的事务方法
	 * @return OrderCache
	 */
	public OrderCache createOrderFrom360Buy(JSONObject tempJson) throws Exception {
		 String order_id_360buy = StringEscapeUtils.escapeSql(tempJson.getString("order_id"));  
		 String order_total_price = StringEscapeUtils.escapeSql(tempJson.getString("order_total_price"));//订单总金额
        // String order_payment = StringEscapeUtils.escapeSql(tempJson.getString("order_payment"));//用户应付金额
         String freight_price = StringEscapeUtils.escapeSql(tempJson.getString("freight_price"));//商品的运费
         String seller_discount = StringEscapeUtils.escapeSql(tempJson.getString("seller_discount"));//商家优惠金额
         String order_seller_price = StringEscapeUtils.escapeSql(tempJson.getString("order_seller_price"));//订单金额
         if(Tools.getManager(Order360buy.class).txFindByProperty("odr360buy_360odrid", order_id_360buy)!=null){
 			//已经同步过了
 			//System.out.println("京东"+order_id_360buy+"，订单已经同步过");
 			return null ;
 		}
         //String item_info_list = StringEscapeUtils.escapeSql(tempJson.getString("item_info_list"));
         /*order_id String 否   订单号（必须返回的字段） 
         vender_id String 否   商家编号 
         pay_type String 否   支付方式 
         order_total_price String 否   订单总金额 
         order_payment String 否   用户应付金额 
         freight_price String 否   商品的运费 
         seller_discount String 否   商家优惠金额 
         order_state String 否   订单状态（英文） 
         order_state_remark String 否   订单状态说明（中文） 
         delivery_type String 否   送货（日期）类型 
         invoice_info String 否   发票信息 
         order_remark String 否   买家下单时订单备注 
         order_start_time String 否   下单时间 
         order_end_time String 否   结单时间 
         consignee_info UserInfo 否   收货人基本信息 
         item_info_list List<ItemInfo> 否   订单商品列表 
         */
      
         
		OrderCache order = new OrderCache();
		
		order.setId(OrderIdGenerator.generate());//order id，通过一个sequence创建的
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		order.setOdrmst_mbrid(new Long(1271857));//用于财付通商城下单的会员id 
		
		//同步收货人
		String consignee_info=StringEscapeUtils.escapeSql(tempJson.getString("consignee_info"));
		JSONObject  jsonuser = JSONObject.fromObject(consignee_info);
		String user_name=StringEscapeUtils.escapeSql(jsonuser.getString("fullname"));
		String user_mobilephone=StringEscapeUtils.escapeSql(jsonuser.getString("mobile"));
		String user_address=StringEscapeUtils.escapeSql(jsonuser.getString("full_address"));
		String province=StringEscapeUtils.escapeSql(jsonuser.getString("province"));
		String city=StringEscapeUtils.escapeSql(jsonuser.getString("city"));
		
		order.setOdrmst_rname(user_name+"(京东订单)");//收货人姓名 
		order.setOdrmst_orderdate(new Date());//订单日期
		order.setOdrmst_rsex("");
		order.setOdrmst_payid(new Long(28));//商户合作支付
		order.setOdrmst_paymethod("商户合作支付");

		order.setOdrmst_paytype(new Long(4));//支付宝支付的type
		order.setOdrmst_rzipcode("");//收货人邮编
		order.setOdrmst_raddress(user_address);//收货人地址
		order.setOdrmst_rphone(user_mobilephone);//收货人电话、手机
		order.setOdrmst_remail("");//收货人email
		order.setOdrmst_rcountry("中国");//国家
		order.setOdrmst_rprovince(province);//收货人省
		order.setOdrmst_rcity(city);//收货人城市
		
		order.setOdrmst_ourmemo("");
		
		order.setOdrmst_pzipcode("");//订购人相关信息
		order.setOdrmst_paddress("");//订购人相关信息
		order.setOdrmst_pcountry("中国");//订购人相关信息
		order.setOdrmst_pprovince("");//订购人相关信息
		order.setOdrmst_pcity("");//订购人相关信息
		order.setOdrmst_pophone("");//订购人相关信息
		order.setOdrmst_phphone("");//订购人相关信息
		order.setOdrmst_pmphone("");//订购人相关信息 
		order.setOdrmst_pusephone("");//订购人相关信息 
		order.setOdrmst_pbp("");//订购人相关信息
		order.setOdrmst_pemail("");//订购人相关信息
		
		order.setOdrmst_pname("d1-京东商城");//订购人相关信息，对应前面的id
		
		order.setOdrmst_psex("");
		order.setOdrmst_oldodrid(order.getId());//用于补发或拆单对帐
		
		
		String fpinfo=StringEscapeUtils.escapeSql(tempJson.getString("invoice_info"));//发票信息
		
		String buyerremark =StringEscapeUtils.escapeSql(tempJson.getString("order_remark"));//备注
		order.setOdrmst_customerword(buyerremark);//送货时间+买家留言
		
		order.setOdrmst_internalmemo("<font color=red><b>"+order_id_360buy+"京东商城订单 用空白纸箱和胶带 不要放发货单和有公司名称的单据</b></font><br/><font color=red><b>"+fpinfo+"</b></font>");

		order.setOdrmst_odrqus(",001008,001009,");
		order.setOdrmst_orderstatus(new Long(0));//订单状态
		order.setOdrmst_specialtype(new Long(0));//用户的特殊标志（没用）
		
		order.setOdrmst_shipfee(new Double(freight_price));//设置运费
		order.setOdrmst_shipid(new Long(10));//快递上门
		order.setOdrmst_shipmethod("快递上门");
		
		
		order.setOdrmst_acturepaymoney(new Double(Tools.parseDouble(order_seller_price)+Tools.parseDouble(freight_price)));//实际支付金额
		
		order.setOdrmst_gdsmoney(new Double(Tools.parseDouble(order_seller_price)));//总价-运费
		

		
		
		order.setOdrmst_realgetmoney(new Double(0));
		
		if(buyerremark.startsWith("售后返修换新")&&Tools.parseDouble(order_total_price)==Tools.parseDouble(seller_discount)){
		order.setOdrmst_prepayvalue(new Double(Tools.parseDouble(seller_discount)));
		order.setOdrmst_tktvalue(new Double(0));//E券金额
		order.setOdrmst_getmoney(new Double(Tools.parseDouble(order_seller_price)+Tools.parseDouble(freight_price)));//收到多少钱
		}else{
			order.setOdrmst_prepayvalue(new Double(0));
			order.setOdrmst_tktvalue(new Double(Tools.parseDouble(seller_discount)));//E券金额
			order.setOdrmst_getmoney(new Double(Tools.parseDouble(order_seller_price)+Tools.parseDouble(freight_price)+Tools.parseDouble(seller_discount)));//收到多少钱
		}
		order.setOdrmst_ordermoney(new Double(Tools.parseDouble(order_total_price)+Tools.parseDouble(freight_price)+Tools.parseDouble(seller_discount)));
		order.setOdrmst_temp("京东订单");//订单来源
		
		
		order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id
		System.out.println("京东订单号："+order_id_360buy);
		System.out.println("创建OrderCache数据库..."+order.getId());
		
		Tools.getManager(OrderCache.class).txCreate(order);
				
		OrderShopCache orderShopCache = new OrderShopCache();
		orderShopCache.setOdrshp_odrid(order.getId());
		orderShopCache.setOdrshp_shopcode("08102301");
		orderShopCache.setOdrshp_sndshopcode("00000000");//d1发货全填这个
		orderShopCache.setOdrshp_orderdate(new Date());
		orderShopCache.setOdrshp_shopname("D1便利网自行发货");
		orderShopCache.setOdrshp_country("中国");
		orderShopCache.setOdrshp_province("");
		orderShopCache.setOdrshp_city("");
		
		orderShopCache.setOdrshp_gdsmoney(new Float(Tools.parseFloat(order_seller_price)));
		orderShopCache.setOdrshp_shipfee(new Float(0));
		orderShopCache.setOdrshp_centerfee(new Float(0));
		
		orderShopCache.setOdrshp_ordermoney(new Float(Tools.parseFloat(order_total_price)));
		
		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		
		orderShopCache.setOdrshp_incomevalue(new Float(Tools.parseFloat(order_seller_price)));
		orderShopCache.setOdrshp_realincome(new Float(0));
		orderShopCache.setOdrshp_giftid(new Long(0));
		orderShopCache.setOdrshp_giftfee(new Float(0));
		orderShopCache.setOdrshp_downflag(new Long(1));
		
		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//创建odrshp记录，这个记录没有用，但后台有关联查询，所以必须创建
		
		//System.out.println("d1gjl:"+item_info_list);
        //JSONObject  jsonorder = JSONObject.fromObject(item_info_list); 
        JSONArray jsons = tempJson.getJSONArray("item_info_list");  
		boolean flag = true ;
		if(flag){
			  int jsonLength = jsons.size();  
    	      //对json数组进行循环  

    	        for (int i = 0; i < jsonLength; i++) { //创建订单明细
    	        
    	        JSONObject itemJson = JSONObject.fromObject(jsons.get(i));  
				String outer_sku_id= StringEscapeUtils.escapeSql(itemJson.getString("outer_sku_id"));
				String item_total = StringEscapeUtils.escapeSql(itemJson.getString("item_total"));
				String jd_price = StringEscapeUtils.escapeSql(itemJson.getString("jd_price"));
				String productId="";
				String psku="";
				if(outer_sku_id.length()>8){
				 productId=outer_sku_id.substring(0, 8);
				 psku=repstr(outer_sku_id.substring(8));
				}
				if (Tools.isNull(productId)){
					
					FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
					fw.write("京东商品SKU不正确，订单号：="+order_id_360buy+"---京东sku:"+outer_sku_id);
					fw.flush();
					fw.close();
				}
				Product p = (Product)Tools.getManager(Product.class).txGet(productId);
				if (p==null){
					
				FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
				fw.write("京东商品SKU不正确，订单号：="+order_id_360buy+"---京东sku:"+outer_sku_id);
				fw.flush();
				fw.close();
					 //System.out.println("京东商品SKU不正确，订单号：="+order_id_360buy+"---京东sku:"+outer_sku_id);
				}
		    	OrderItemCache orderItem = new OrderItemCache();
				
				orderItem.setId(SequenceIdGenerator.generate("5"));
				orderItem.setOdrdtl_odrid(order.getId());//订单号
				orderItem.setOdrdtl_oldodrid(order.getId());
				
				orderItem.setOdrdtl_gdsid(productId);//product id
				
				
				orderItem.setOdrdtl_sku1(psku);
				orderItem.setOdrdtl_sku2("");//sku2  没用
			
				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
				orderItem.setOdrdtl_memberprice(new Double(Tools.parseDouble(jd_price)));//会员价
				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
				orderItem.setOdrdtl_vipprice(new Double(Tools.parseDouble(jd_price)));//vip 价
				
				orderItem.setOdrdtl_finalprice(new Double(Tools.parseDouble(jd_price)));//最后成交单价
				
				orderItem.setOdrdtl_gdscount(new Long(Tools.parseLong(item_total)));//订购数量
				
				double sumprice=Tools.parseDouble(jd_price)*Tools.parseDouble(item_total);
				orderItem.setOdrdtl_totalmoney(new Double(sumprice));//成交总金额
				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

				orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
				orderItem.setOdrdtl_sendcount(new Long(Tools.parseLong(item_total)));//发货数量，最开始0
				orderItem.setOdrdtl_creatdate(new Date());//创建日期
				orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
				orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
				
				orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//从商品表取
				orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
				orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
				orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
				orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
				orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
				orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
				orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
				
				orderItem.setOdrdtl_stddetail9("");//商品没有stddetail9字段
				
				orderItem.setOdrdtl_presellflag(new Long(0));//保留字段，无用
				orderItem.setOdrdtl_incometype(new Long(0));//保留字段，无用
				orderItem.setOdrdtl_incomevalue(new Double(0));//保留字段
				
				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(sumprice,2));//计算商户总收入 不用
				orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//商品应发E券 商品表取，价格不能打折送券的商品
				
				orderItem.setOdrdtl_spendcount(new Double(0));//返用户积分
				
				orderItem.setOdrdtl_managememo("");//产品经理留言
				orderItem.setOdrdtl_gdspurmemo("");//采购备注 
				
				orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
				orderItem.setOdrdtl_gifttype("");//赠品类型 
				
				orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
				orderItem.setOdrdtl_jcflag(new Long(0));//没有用
				
				orderItem.setOdrdtl_temp("京东商城");//商品活动标记，记录订单来源
				orderItem.setOdrdtl_tuancardno("");//商户兑换券号
				
				//创建订单明细
				System.out.println("创建数据库订单明细："+orderItem.getId());
				Tools.getManager(OrderItemCache.class).txCreate(orderItem);
				
				//创建另外一条记录，用于占用虚拟库存
				CartItem ci = new CartItem();
				ci.setAmount(orderItem.getOdrdtl_gdscount());
				ci.setCreateDate(new Date());
				ci.setOrderId(order.getId());
				ci.setProductId(p.getId());
				ci.setSkuId(orderItem.getOdrdtl_sku1());
				ci.setUserId("1271857");
				Tools.getManager(CartItem.class).txCreate(ci);
    	        	
			}
    	        SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    	        String end="2013-01-21 00:00:00";
    	        if(new Date().after(df.parse(end))){
    	        	  setzp(Tools.parseDouble(order_seller_price),order.getId());
    	        }
    	      
		}
		/*
		 * fullname String  否   姓名 
full_address String 否   地址 
telephone String 否   固定电话 
mobile String 否   手机 
province String 否   省 
city String 否   市 
county String 否   县 
		 * */
		//插入一条记录，记录该订单已经同步过了


		Order360buy o360=new Order360buy();
		o360.setOdr360buy_360odrid(order_id_360buy);
		o360.setOdr360buy_d1odrid(order.getId());
		o360.setOdr360buy_name(user_name);
		o360.setOdr360buy_phone(user_mobilephone);
		o360.setOdr360buy_status(new Long(0));
		o360.setOdr360buy_createdate(new Date());
		
		Tools.getManager(Order360buy.class).txCreate(o360);
				
				
		confirmGetMoney(order.getId(),-1);//修改订单为确认收款状态
		return order;
	}
	
	private void setzp(double ordermoney,String orderid){
		String gdsid="";
		String sku="";
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(781)));//这里是专用赠品组
		clist.add(Restrictions.le("giftrckdtl_limitmoney", new Float(ordermoney)));//这里是专用赠品组
		List<org.hibernate.criterion.Order> olist = new ArrayList<org.hibernate.criterion.Order>();
		olist.add(org.hibernate.criterion.Order.desc("giftrckdtl_limitmoney"));
		
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).txGetList(clist,olist,0,10);
		if(resList!=null&&resList.size()>0){
			
				GiftItem gi = (GiftItem)resList.get(0);
				gdsid=gi.getGiftrckdtl_gdsid();
				if("01517367".equals(gdsid)){
					sku="红色";
				}
				if(!Tools.isNull(gdsid)){
					Product p=ProductHelper.getById(gdsid);
					OrderItemCache orderItem = new OrderItemCache();
					
					orderItem.setId(SequenceIdGenerator.generate("5"));
					orderItem.setOdrdtl_odrid(orderid);//订单号
					
					orderItem.setOdrdtl_gdsid(gdsid);//product id
					
					orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
	                orderItem.setOdrdtl_oldodrid(orderid);
					orderItem.setOdrdtl_sku1(sku);
					orderItem.setOdrdtl_sku2("");//sku2  没用
				
					orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
					orderItem.setOdrdtl_memberprice(new Double(p.getGdsmst_memberprice()));//会员价
					orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
					orderItem.setOdrdtl_vipprice(new Double(p.getGdsmst_vipprice()));//vip 价
					
					orderItem.setOdrdtl_finalprice(new Double(0));//最后成交单价
					
					orderItem.setOdrdtl_gdscount(new Long(1));//订购数量
					
					
					orderItem.setOdrdtl_totalmoney(new Double(0));//成交总金额
					orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));
		
					orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
					orderItem.setOdrdtl_sendcount(new Long(1));//发货数量，最开始0
					orderItem.setOdrdtl_creatdate(new Date());//创建日期
					orderItem.setOdrdtl_refundcount(new Long(0));//没发货的数量
					orderItem.setOdrdtl_rackcode(p.getGdsmst_rackcode());
					
					orderItem.setOdrdtl_stddetail1(p.getGdsmst_stdvalue1());//从商品表取
					orderItem.setOdrdtl_stddetail2(p.getGdsmst_stdvalue2());
					orderItem.setOdrdtl_stddetail3(p.getGdsmst_stdvalue3());
					orderItem.setOdrdtl_stddetail4(p.getGdsmst_stdvalue4());
					orderItem.setOdrdtl_stddetail5(p.getGdsmst_stdvalue5());
					orderItem.setOdrdtl_stddetail6(p.getGdsmst_stdvalue6());
					orderItem.setOdrdtl_stddetail7(p.getGdsmst_stdvalue7());
					orderItem.setOdrdtl_stddetail8(p.getGdsmst_stdvalue8());
					
					orderItem.setOdrdtl_stddetail9("");//商品没有stddetail9字段
					
					orderItem.setOdrdtl_presellflag(new Long(0));//保留字段，无用
					orderItem.setOdrdtl_incometype(new Long(0));//保留字段，无用
					orderItem.setOdrdtl_incomevalue(new Double(0));//保留字段
					
					orderItem.setOdrdtl_totalincomevalue(new Double(0));//计算商户总收入 不用
					orderItem.setOdrdtl_eyuan(new Double(p.getGdsmst_eyuan()));//商品应发E券 商品表取，价格不能打折送券的商品
					
					orderItem.setOdrdtl_spendcount(new Double(0));//返用户积分
					
					orderItem.setOdrdtl_managememo("");//产品经理留言
					orderItem.setOdrdtl_gdspurmemo("");//采购备注 
					
					orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
					orderItem.setOdrdtl_gifttype("");//赠品类型 
					
					orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
					orderItem.setOdrdtl_jcflag(new Long(0));//没有用
					orderItem.setOdrdtl_buyflag(new Long(2));    //赠品标识，正常商品为0 赠品为2
					orderItem.setOdrdtl_temp("京东商城");//商品活动标记，记录订单来源
					orderItem.setOdrdtl_tuancardno("");//商户兑换券号
					
					//创建订单明细
					System.out.println("创建数据库订单明细："+orderItem.getId());
					Tools.getManager(OrderItemCache.class).txCreate(orderItem);
					
					//创建另外一条记录，用于占用虚拟库存
					CartItem ci = new CartItem();
					ci.setAmount(orderItem.getOdrdtl_gdscount());
					ci.setCreateDate(new Date());
					ci.setOrderId(orderid);
					ci.setProductId(p.getId());
					ci.setSkuId(orderItem.getOdrdtl_sku1());
					ci.setUserId("1271857");
					Tools.getManager(CartItem.class).txCreate(ci);
				}
			}
		
	}
	
	/**
	 * 订单确认收款，财付通已经完成支付 。orderId必须存在，订单状态必须是0！
	 * @param orderId 订单id
	 * @param getmoney 收到多少钱，大于0才有效，小于0不修改。
	 * @return true 操作成功， false表示没有操作，可能是订单id不存在
	 * @throws Exception
	 */
	public synchronized boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1==null)return false ;
		
		if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
			/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
			order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"京东同步订单收款");
			if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
			order1.setOdrmst_validdate(new Date());
			order1.setOdrmst_orderstatus(new Long(2));//确认收款状态
			Tools.getManager(OrderCache.class).txUpdate(order1, true);
			
			//调用存储过程把订单修改成“确认收款”状态
			ProcedureWork work = new ProcedureWork(orderId);
			Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
			*/
			int ret=updateOrderStatus2013(order1,getmoney);
			if (ret==1){
			updateOrderStatuswork(order1);
			return true ;
			}
			
			
		}
		
		return false ;
	}
	
	public int updateOrderStatus2013(OrderBase order , double dblAmount){
		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！

			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//精确到角
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"京东同步订单收款");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(2));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
	}
	
	public int updateOrderStatuswork(OrderBase order){

		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
	
			
			//调用存储过程把订单修改成“确认收款”状态，并执行库存等修改动作！！！
			try {
			ProcedureWork work = new ProcedureWork(order.getId());
			Tools.getManager(order.getClass()).currentSession().doWork(work);//执行work
			
				Tools.getManager(order.getClass()).currentSession().connection().commit();
			} catch (HibernateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			return 1;

	}
	
	/**
	 * i    (
o   )
-    /
t    (
y    )
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
		str=str.replace("u", "灰色");
		str=str.replace("v", "棕色");
		str=str.replace("k", "红色");
		str=str.replace("g", "紫色");
		str=str.replace("n", "灰色");
		str=str.replace("f", "均码");
		str=str.replace("z", " ");
		return str;
	}
}
