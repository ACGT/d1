package com.d1.service;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.hibernate.HibernateException;

import com.d1.bean.CartItem;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderDangD;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderShopCache;
import com.d1.bean.Product;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.dangdang.HttpInvokeUtil;
import com.d1.helper.ProductHelper;
import com.d1.util.MD5;
import com.d1.util.Tools;
public class OrderDDService {
	/**
	 * 创建当当订单的事务方法
	 * @return OrderCache
	 */
	public OrderCache createOrderFromDangd( Element itemEle,String shopid,String ddid,String relData) throws Exception {
		 String orderID = itemEle.elementTextTrim("orderID"); // 订单号
	   if(Tools.getManager(OrderDangD.class).txFindByProperty("odrdangd_dangdodrid", orderID)!=null){
			//已经同步过了
			//System.out.println(trade.getTid()+"，订单已经同步过，忽略！");
			return null ;
		}
	   String consigneeName=itemEle.elementTextTrim("consigneeName"); // 收货人姓名
	   String consigneeTel=itemEle.elementTextTrim("consigneeTel"); // 收货人固定电话
	   String consigneeMobileTel=itemEle.elementTextTrim("consigneeMobileTel"); //收货人移动电话
	   String consigneeAddr=itemEle.elementTextTrim("consigneeAddr"); // 收货地址
	   String sendGoodsMode=itemEle.elementTextTrim("sendGoodsMode"); // 送货方式
	 //  String orderMoney=itemEle.elementTextTrim("orderMoney"); // 订单总金额
	   String orderTimeStart=itemEle.elementTextTrim("orderTimeStart"); // 下单时间
	   String lastModifyTime=itemEle.elementTextTrim("lastModifyTime"); // 最后修改时间
	   String orderState=itemEle.elementTextTrim("orderState"); // 订单状态
	   String remark=itemEle.elementTextTrim("remark"); // 备注
   
	   if(Tools.isNull(consigneeMobileTel)){
		   consigneeMobileTel=consigneeTel;
	   }
			String[] strs=consigneeAddr.split("，");
			String province="";
			String city="";
			if(strs.length>=3){
				province=strs[1];
				city=strs[2];
				city=city+" "+strs[3];
			}
	   
		OrderCache order = new OrderCache();
		
		order.setId(OrderIdGenerator.generate());//order id，通过一个sequence创建的
		order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
		if(!Tools.isNull(ddid)){
		order.setOdrmst_mbrid(new Long(3210726));//用于当当下单的会员id 
		}else{
		 order.setOdrmst_mbrid(new Long(2363598));//用于当当下单的会员id 
		}

		order.setOdrmst_rname(consigneeName+"(当当订单)");//收货人姓名 
		order.setOdrmst_orderdate(new Date());//订单日期
		order.setOdrmst_rsex("");
		
		
		order.setOdrmst_rzipcode("");//收货人邮编
		order.setOdrmst_raddress(consigneeAddr);//收货人地址
		order.setOdrmst_rphone(consigneeMobileTel);//收货人电话、手机
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
		String pname="d1-当当商城";
		if(!Tools.isNull(ddid)){
			pname="当当小栗舍商城";
			}
		order.setOdrmst_pname(pname);//订购人相关信息，对应前面的id
		
		order.setOdrmst_psex("");
		
		order.setOdrmst_oldodrid(order.getId());//用于补发或拆单对帐
		order.setOdrmst_odrqus(",001008,001009,");
		order.setOdrmst_orderstatus(new Long(0));//订单状态
		order.setOdrmst_specialtype(new Long(0));//用户的特殊标志（没用）
		
	
		order.setOdrmst_shipid(new Long(10));//快递上门
		order.setOdrmst_shipmethod("快递上门");
		
		
		
		
		
		order.setOdrmst_realgetmoney(new Double(0));
		
		

		order.setOdrmst_temp("当当订单");//订单来源
	
		order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id

		//String relData=odrdtlData;
		 HashMap<String, String> productinfo = null;
		    InputStream in = null;
		   
		    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
		    	SAXReader reader = new SAXReader();
		    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
				Document doc = reader.read(isr);
				Element root = doc.getRootElement();
				String fpinfo="";//发票信息
				Iterator fpiter = root.elementIterator("receiptInfo"); 
	           while (fpiter.hasNext()) {
	           	 Element fpele = (Element) fpiter.next();
	           	 fpinfo="发票抬头:"+fpele.elementTextTrim("receiptName")+",发票内容:"+fpele.elementTextTrim("receiptDetails")+",发票金额:"+fpele.elementTextTrim("receiptMoney");
	           	 
	           }
	          
	     	    String zffs="商户合作支付";//支付方式
	           int payid=28;int paytype=4;
	           Iterator zpfsiter = root.elementIterator("buyerInfo"); 
	           double postage=0;
	           double giftCertMoney=0;
	           double giftCardMoney=0;
	           double accountBalance=0;
	           double promoDeductAmount=0;
	           String orderMoney="";
	           while (zpfsiter.hasNext()) {
	           	 Element fpele = (Element) zpfsiter.next();
	           	 zffs=fpele.elementTextTrim("buyerPayMode");
	           	orderMoney=fpele.elementTextTrim("goodsMoney");
	           	postage=Tools.parseDouble(fpele.elementTextTrim("postage")); //邮费
	           	giftCertMoney=Tools.parseDouble(fpele.elementTextTrim("giftCertMoney")); //买家支付礼券金额
	           	giftCardMoney=Tools.parseDouble(fpele.elementTextTrim("giftCardMoney")); //买家支付礼品卡金额
	           	accountBalance=Tools.parseDouble(fpele.elementTextTrim("accountBalance")); //买家支付账户余
	           	promoDeductAmount=Tools.parseDouble(fpele.elementTextTrim("promoDeductAmount")); //促销优惠金额
	           	
	           	 if(zffs.equals("货到付款")){
	           		 payid=0;paytype=1;
	           	 }else if(zffs.equals("邮局汇款")){
	           		 payid=1;paytype=2;
	           	 }else if(zffs.equals("银行汇款")){
	           		 payid=2;paytype=3;
	           	 }
	           }
	           double promoDicount=0;
	           String promotionName="";
	           Iterator PromoListiter = root.elementIterator("PromoList"); 
	           while (PromoListiter.hasNext()) {
	               Element PromoListEle = (Element) PromoListiter.next();
	              Iterator iters = PromoListEle.elementIterator("promoItem");
	               while (iters.hasNext()) {
	                   Element productele = (Element) iters.next();
	                   promotionName=promotionName+productele.elementTextTrim("promotionName");
	                   promoDicount=promoDicount+Tools.parseDouble(productele.elementTextTrim("promoDicount"));
	                   }
	           }
	           order.setOdrmst_acturepaymoney(new Double(Tools.parseDouble(orderMoney)));//实际支付金额
	   		
	   		order.setOdrmst_gdsmoney(new Double(Tools.parseDouble(orderMoney)+accountBalance+giftCardMoney));//总价-运费
	   		
	   		
	       	order.setOdrmst_shipfee(new Double(postage));//设置运费
	           order.setOdrmst_paytype(new Long(paytype));//支付宝支付的type
	           order.setOdrmst_payid(new Long(payid));//商户合作支付
	   		order.setOdrmst_paymethod(zffs);
	   		order.setOdrmst_internalmemo("<font color=red><b>"+orderID+"当当订单</b></font><br/><font color=red><b>"+fpinfo+"</b></font>"+promotionName+"");
	   		order.setOdrmst_customerword(remark);//送货时间+买家留言
	        order.setOdrmst_difprice(new Double(0));
	        
			//礼券收不回来的金额    giftCertMoney
			//礼品卡  可以收回来    giftcardmoney
			//账户余额可以收回来    accountbalance
	      //促销优惠金额收不回来 promoDeductAmount
	       //促销优惠金额 promoDicount
			order.setOdrmst_prepayvalue(new Double(accountBalance+giftCardMoney));
			order.setOdrmst_tktvalue(new Double(giftCertMoney+promoDeductAmount+promoDicount));//E券金额
			order.setOdrmst_ordermoney(new Double(Tools.parseDouble(orderMoney)+accountBalance+giftCardMoney+postage+giftCertMoney+promoDeductAmount+promoDicount));
			 if(zffs.equals("货到付款")){
			order.setOdrmst_getmoney(new Double(accountBalance+giftCardMoney+giftCertMoney+promoDeductAmount+promoDicount));//收到多少钱
			 }else
			 {
				 order.setOdrmst_getmoney(new Double(Tools.parseDouble(orderMoney)+accountBalance+giftCardMoney));//收到多少钱
			 }
			 
	   		System.out.println("当当订单号："+orderID);
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
	   		
	   		orderShopCache.setOdrshp_gdsmoney(new Float(Tools.parseFloat(orderMoney)));
	   		orderShopCache.setOdrshp_shipfee(new Float(0));
	   		orderShopCache.setOdrshp_centerfee(new Float(0));
	   		
	   		orderShopCache.setOdrshp_ordermoney(new Float(Tools.parseFloat(orderMoney)));
	   		
	   		orderShopCache.setOdrshp_payshopmoney(new Float(0));
	   		
	   		orderShopCache.setOdrshp_incomevalue(new Float(Tools.parseFloat(orderMoney)));
	   		orderShopCache.setOdrshp_realincome(new Float(0));
	   		orderShopCache.setOdrshp_giftid(new Long(0));
	   		orderShopCache.setOdrshp_giftfee(new Float(0));
	   		orderShopCache.setOdrshp_downflag(new Long(1));
	   		
	   		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//创建odrshp记录，这个记录没有用，但后台有关联查询，所以必须创建
	   		
	      		 Iterator productiter = root.elementIterator("ItemsList"); 
	               while (productiter.hasNext()) {

	                   Element recordEle = (Element) productiter.next();
	                  Iterator iters = recordEle.elementIterator("ItemInfo"); // 获取子节点ItemDetail下的子节点SpecilaItemInfo

	                   // 遍历Header节点下的Response节点
	                   while (iters.hasNext()) {

	                       Element productele = (Element) iters.next();
	                      String outerItemID ="";
	                      if(productele.selectSingleNode("outerItemID")!=null){
	                    	  outerItemID= productele.elementTextTrim("outerItemID"); // 拿到ItemDetail下的子节点SpecilaItemInfo下的字节点outerItemID的值
	                      }
	                      String specialAttribute="";
	                      if(productele.selectSingleNode("specialAttribute")!=null){
	                    	  specialAttribute= productele.elementTextTrim("specialAttribute"); // 拿到ItemDetail下的子节点SpecilaItemInfo下的字节点outerItemID的值
	                      }
	                      String orderCount=productele.elementTextTrim("orderCount"); //订购数量
	                      String itemID=productele.elementTextTrim("itemID"); //凡客商品ID
	                       String unitPrice=productele.elementTextTrim("unitPrice"); //成交价
	                      // String itemType=productele.elementTextTrim("itemType"); //商品类型
	                       String itemName=productele.elementTextTrim("itemName"); //商品名称
	                      // System.out.println("outerItemID:" + outerItemID);
	                       String productId="";
	   		        	 String psku="";
	   		        	 if(outerItemID!=null && outerItemID.length()>8){//有sku
	   						 productId=outerItemID.substring(0, 8);
	   						 psku=outerItemID.substring(8);
	   						}if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID) && outerItemID.length()==8){
	   							productId=outerItemID;
	   						}
	   					//if(Tools.isNull(psku) && !Tools.isNull(specialAttribute)){
	   					//	psku=specialAttribute.substring(specialAttribute.lastIndexOf(">>")+2);
	   					//	}
	   					if(Tools.isNull(productId)){
	   						StringBuffer resultStr=new StringBuffer(itemName);
	   						resultStr=resultStr.reverse();
	   						int s=resultStr.toString().indexOf("_");
	   						resultStr=new StringBuffer(resultStr.substring(s+1,s+9));
	   						productId=resultStr.reverse().toString();
	   					}
	   						//System.out.println(psku+"qqqqqqqqqq");
	   		        	 Product p=ProductHelper.getById(productId);
	   		        	
	   		   		    	OrderItemCache orderItem = new OrderItemCache();
	   		   				
	   		   				orderItem.setId(SequenceIdGenerator.generate("5"));
	   		   				orderItem.setOdrdtl_odrid(order.getId());//订单号
	   		   				
	   		   				orderItem.setOdrdtl_gdsid(productId);//product id
	   		   				
	   		   			    orderItem.setOdrdtl_shopcode(p.getGdsmst_shopcode());
		                    orderItem.setOdrdtl_oldodrid(order.getId());
	   		   				orderItem.setOdrdtl_sku1(psku);
	   		   				orderItem.setOdrdtl_sku2("");//sku2  没用
	   		   			
	   		   				orderItem.setOdrdtl_gdsname(p.getGdsmst_gdsname());//商品名
	   		   				orderItem.setOdrdtl_memberprice(new Double(Tools.parseDouble(unitPrice)));//会员价
	   		   				orderItem.setOdrdtl_saleprice(new Double(p.getGdsmst_saleprice()));//市场价
	   		   				orderItem.setOdrdtl_vipprice(new Double(Tools.parseDouble(unitPrice)));//vip 价
	   		   				
	   		   				orderItem.setOdrdtl_finalprice(new Double(Tools.parseDouble(unitPrice)));//最后成交单价
	   		   				
	   		   				orderItem.setOdrdtl_gdscount(new Long(Tools.parseLong(orderCount)));//订购数量
	   		   				
	   		   				double sumprice=Tools.parseDouble(unitPrice)*Tools.parseDouble(orderCount);
	   		   				orderItem.setOdrdtl_totalmoney(new Double(sumprice));//成交总金额
	   		   				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

	   		   				orderItem.setOdrdtl_shipstatus(new Long(1));//发货状态，1为未发货
	   		   				orderItem.setOdrdtl_sendcount(new Long(Tools.parseLong(orderCount)));//发货数量，最开始0
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
	   		   				
	   		   				orderItem.setOdrdtl_temp("当当");//商品活动标记，记录订单来源
	   		   				orderItem.setOdrdtl_tuancardno("");//商户兑换券号
	   		   				orderItem.setOdrdtl_bfdtemp(itemID);
	   		   				
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
	   		   				ci.setUserId("2363598");
	   		   				Tools.getManager(CartItem.class).txCreate(ci);
	   		       	        	
	   		   			
	   		   		}
	   		        	 
	   		        	
	                   }
	            
	    OrderDangD odd=new OrderDangD();
		odd.setOdrdangd_dangdodrid(orderID);
		odd.setOdrdangd_d1odrid(order.getId());
		if(!Tools.isNull(ddid)){
			odd.setOdrdangd_mbrid(new Long(3210726));
			}else{
			 odd.setOdrdangd_mbrid(new Long(2363598));
			}
		
		odd.setOdrdangd_name(consigneeName);
		odd.setOdrdangd_phone(consigneeTel);
		odd.setOdrdangd_mobile(consigneeMobileTel);
		odd.setOdrdangd_status(new Long(0));
		odd.setOdrdangd_createdate(new Date());
		odd.setOdrdangd_tktvalue(Tools.doubleValue(giftCertMoney+giftCertMoney));
		Tools.getManager(OrderDangD.class).txCreate(odd);
		int hfpayid=2;		
		if(zffs.equals("货到付款")){
			hfpayid=1;
		}
		confirmGetMoney(order.getId(),-1,hfpayid);//修改订单为确认收款状态

		return order;
	}

	/**
	* 订单确认收款，财付通已经完成支付 。orderId必须存在，订单状态必须是0！
	* @param orderId 订单id
	* @param getmoney 收到多少钱，大于0才有效，小于0不修改。
	* @return true 操作成功， false表示没有操作，可能是订单id不存在
	* @throws Exception
	*/
	public  boolean confirmGetMoney(String orderId,float getmoney,int hfpayid)throws Exception{
		OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
		if(order1==null)return false ;
		
		if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
			/*Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
			order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ Tools.stockFormatDate(new Date())+"当当同步订单收款");
			if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
			order1.setOdrmst_validdate(new Date());
			order1.setOdrmst_orderstatus(new Long(2));//确认收款状态
			Tools.getManager(OrderCache.class).txUpdate(order1, true);
			
			//调用存储过程把订单修改成“确认收款”状态
			ProcedureWork work = new ProcedureWork(orderId);
			Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
			
			return true ;
			*/
			
			
			int ret=updateOrderStatus2013(order1,getmoney,hfpayid);
			if (ret==1){
			updateOrderStatuswork(order1);
			return true ;
			}
		}
		
		return false ;
	}
	

	
	public int updateOrderStatus2013(OrderBase order , double dblAmount,int hfpayid){
		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
			if(Tools.longValue(order.getOdrmst_orderstatus()) != 0) return -2;
			//精确到角
			//if((int)Math.round(Tools.doubleValue(order.getOdrmst_acturepaymoney())*10) != (int)Math.round(dblAmount*10)) return -3;//金额不一样
			Tools.getManager(order.getClass()).txBeforeUpdate(order);
			if(dblAmount>0)order.setOdrmst_getmoney(new Double(dblAmount));
			order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"当当同步订单收款");
			order.setOdrmst_validdate(new Date());
			order.setOdrmst_orderstatus(new Long(hfpayid));
			
			Tools.getManager(order.getClass()).txUpdate(order, true);
			
			if(Tools.longValue(order.getOdrmst_orderstatus()) == 0) return -4;
			return 1;
		}
	}
	
	public int updateOrderStatuswork(OrderBase order){

		if(order == null) return -1;
		//锁用户订单。如果用memcached做数据库缓存，这块要修改成分布式锁或数据库锁！！！
		synchronized(order){
	
			
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
		str=str.replace("z", " ");
		return str;
	}

	


	
}
