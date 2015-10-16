package com.d1.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.Iterator;

import org.dom4j.Element;
import org.hibernate.HibernateException;

import com.d1.bean.CartItem;
import com.d1.bean.OdrVancl;
import com.d1.bean.OrderBase;
import com.d1.bean.OrderCache;
import com.d1.bean.OrderDangD;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderMain;
import com.d1.bean.OrderShopCache;
import com.d1.bean.Product;
import com.d1.bean.id.OrderIdGenerator;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.helper.ProductHelper;
import com.d1.util.DESUtil;
import com.d1.util.Tools;

public class OrderVanclService {
	/**
	 * 创建凡客订单的事务方法
	 * @return OrderCache
	 */
	public OrderCache createOrderFromVancl( Element itemEle,Element itemnotice) throws Exception {
		 String orderID = itemEle.elementTextTrim("orderid"); // 订单号
		   orderID=deccode(orderID);
		  // System.out.println("订单号："+orderID);
		   if(Tools.getManager(OdrVancl.class).txFindByProperty("odrvancl_orderid", orderID)!=null){
				//已经同步过了
				//System.out.println(orderID+"，订单已经同步过，忽略！");
				return null ;
			}
		   String username=itemEle.elementTextTrim("username"); // 收货人姓名
		   String usertel=itemEle.elementTextTrim("usertel"); // 收货人固定电话
		   String userphone=itemEle.elementTextTrim("userphone"); //收货人移动电话
		   String areaid=itemEle.elementText("areaid");//省市
		   String postalcode=itemEle.elementText("postalcode");//邮政编码
		   String address=itemEle.elementTextTrim("address"); // 收货地址
		   String receivetime=itemEle.elementTextTrim("receivetime"); // 送货时间
		   String needinvoice=itemEle.elementTextTrim("needinvoice"); // 是否需要发票
		   String totalprice=itemEle.elementTextTrim("totalprice"); // 订单总金额
		   String transferprice=itemEle.elementTextTrim("transferprice"); // 订单运费
		   String paidprice=itemEle.elementTextTrim("paidprice"); // 已付款，包含了在线支付，账户余额支付、礼品卡支付等-
		   String unpaidprice=itemEle.elementTextTrim("unpaidprice"); // 应付款，即实际应该打印到快递面单上的金额，也是快递人员应该向用户收取的金额
		   String paymenttype=itemEle.elementTextTrim("paymenttype"); // 支付方式
		   String comment=itemEle.elementTextTrim("comment"); // 用户留言
		   
		
		   username=deccode(username);
		   usertel=deccode(usertel);
		   userphone=deccode(userphone);
		   areaid=deccode(areaid);
		   postalcode=deccode(postalcode);
		   address=deccode(address);
		   receivetime=deccode(receivetime);
		   needinvoice=deccode(needinvoice);
		   totalprice=deccode(totalprice);
		   transferprice=deccode(transferprice);
		   paidprice=deccode(paidprice);
		   unpaidprice=deccode(unpaidprice);
		   paymenttype=deccode(paymenttype);
		   comment=deccode(comment);
		   if(Tools.isNull(userphone)){
			   userphone=usertel;
		   }
		   String province=address.substring(0,address.indexOf("（省）"));
			String city=address.substring(address.indexOf("（省）")+3,address.indexOf("（区）"));
			city=city.replace("（市）", " ");
			OrderCache order = new OrderCache();
			
			order.setId(OrderIdGenerator.generate());//order id，通过一个sequence创建的
			order.setOdrmst_id(new Long(SequenceIdGenerator.generate("4")));
	
			 order.setOdrmst_mbrid(new Long(3295935));//用于凡客下单的会员id 

			order.setOdrmst_rname(username+"(凡客订单)");//收货人姓名 
			order.setOdrmst_orderdate(new Date());//订单日期
			order.setOdrmst_rsex("");
			
			
			order.setOdrmst_rzipcode(postalcode);//收货人邮编
			order.setOdrmst_raddress(address);//收货人地址
			order.setOdrmst_rphone(userphone);//收货人电话、手机
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
			String pname="D1凡客商城";
			order.setOdrmst_pname(pname);//订购人相关信息，对应前面的id
			order.setOdrmst_psex("");
       		order.setOdrmst_oldodrid(order.getId());//用于补发或拆单对帐
			order.setOdrmst_odrqus(",001008,001009,");
			order.setOdrmst_orderstatus(new Long(0));//订单状态
			order.setOdrmst_specialtype(new Long(0));//用户的特殊标志（没用）
			order.setOdrmst_shipid(new Long(10));//快递上门
			order.setOdrmst_shipmethod("快递上门");

			order.setOdrmst_realgetmoney(new Double(0));
			order.setOdrmst_temp("凡客订单");//订单来源
		
			order.setOdrmst_tktid(new Long(0));//E券编号，对应tktmst.id
          
		     	    String zffs="商户合作支付";//支付方式
		           int payid=28;int paytype=4;
		           double promoDicount=0;
		           String strnotice="";
		           if(itemnotice!=null){
		        	   strnotice="发票信息:";  
		        	   String invoicetitle=itemnotice.elementTextTrim("invoicetitle"); // 发票抬头
		        	   strnotice+="发票抬头:"+invoicetitle+"<br>";
		        	   Iterator invoicedetail = itemnotice.elementIterator("invoicedetail"); 
		   	        while (invoicedetail.hasNext()) {
		   	     	   Element recordEle = (Element) invoicedetail.next();
		    		   String noticename=recordEle.elementTextTrim("name"); // 名称，按实际能开具的形式开具。例如用户要求开具办公用品，但实际只能开具是“食品”，则开具“食品”
		    		   String noticeunit=recordEle.elementTextTrim("unit"); // 单位
		    		   String noticeprice=recordEle.elementTextTrim("price"); // 金额
		    		   strnotice+="名称:"+noticename+"<br>";
		    		   strnotice+="单位:"+noticeunit+"<br>";
		    		   strnotice+="金额:"+noticeprice+"<br>";
		   	        }
		        	  
		        	   
		           }
		           if(needinvoice.equals("True")){
		        	   order.setOdrmst_taxflag(new Long(1));
		           }
		           
		        order.setOdrmst_acturepaymoney(new Double(Tools.parseDouble(totalprice)));//实际支付金额
     	   		order.setOdrmst_gdsmoney(new Double(Tools.parseDouble((Tools.parseDouble(totalprice)-Tools.parseDouble(transferprice))+"")));//总价-运费
    	   		order.setOdrmst_ordermoney(new Double(Tools.parseDouble(totalprice)));
		       	order.setOdrmst_shipfee(new Double(transferprice));//设置运费
				order.setOdrmst_getmoney(new Double(Tools.parseDouble(totalprice)));//收到多少钱
		           order.setOdrmst_paytype(new Long(paytype));//支付宝支付的type
		           order.setOdrmst_payid(new Long(payid));//商户合作支付
		   		order.setOdrmst_paymethod(zffs);
		   		order.setOdrmst_internalmemo("<font color=red><b>"+orderID+"凡客订单</b></font><br/><font color=red><b>"+comment+"</b></font><font color=red><b>"+strnotice+"</b></font>");
		   		order.setOdrmst_customerword(comment);//送货时间+买家留言
		        order.setOdrmst_difprice(new Double(0));
				order.setOdrmst_prepayvalue(new Double(0));
				order.setOdrmst_tktvalue(new Double(0));//E券金额
		        
		        
		   		System.out.println("凡客订单号："+orderID);
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
		   		
		   		orderShopCache.setOdrshp_gdsmoney(new Float(Tools.parseFloat(totalprice)));
		   		orderShopCache.setOdrshp_shipfee(new Float(0));
		   		orderShopCache.setOdrshp_centerfee(new Float(0));
		   		
		   		orderShopCache.setOdrshp_ordermoney(new Float(Tools.parseFloat(totalprice)));
		   		
		   		orderShopCache.setOdrshp_payshopmoney(new Float(0));
		   		
		   		orderShopCache.setOdrshp_incomevalue(new Float(Tools.parseFloat(totalprice)));
		   		orderShopCache.setOdrshp_realincome(new Float(0));
		   		orderShopCache.setOdrshp_giftid(new Long(0));
		   		orderShopCache.setOdrshp_giftfee(new Float(0));
		   		orderShopCache.setOdrshp_downflag(new Long(1));
		   		
		   		Tools.getManager(OrderShopCache.class).txCreate(orderShopCache);//创建odrshp记录，这个记录没有用，但后台有关联查询，所以必须创建
		   		
		      		 Iterator orderdetail = itemEle.elementIterator("orderdetail"); 
		                  // 遍历Header节点下的Response节点
		                   while (orderdetail.hasNext()) {

		                       Element productele = (Element) orderdetail.next();
		                      String outerItemID ="";
		                      if(productele.selectSingleNode("barcode")!=null){
		                    	  outerItemID= productele.elementTextTrim("barcode"); // 拿到ItemDetail下的子节点SpecilaItemInfo下的字节点outerItemID的值
		                      }
		                       String orderCount=productele.elementTextTrim("qty"); //订购数量
		                       String unitPrice=productele.elementTextTrim("price"); //成交价
		                       String amount=productele.elementTextTrim("amount"); //小计
		                       outerItemID=deccode(outerItemID);
		                       orderCount=deccode(orderCount);
		                       unitPrice=deccode(unitPrice);
		                       amount=deccode(amount);

		                     String productId="";
		   		        	 String psku="";
		   		        	 if(outerItemID!=null && outerItemID.length()>8){//有sku
		   						 productId=outerItemID.substring(0, 8);
		   						 psku=outerItemID.substring(8);
		   						}if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID) && outerItemID.length()==8){
		   							productId=outerItemID;
		   						}
		   	
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
	
		   		   				orderItem.setOdrdtl_totalmoney(new Double(Tools.parseDouble(unitPrice)*Tools.parseInt(orderCount)));//成交总金额	   		   				orderItem.setOdrdtl_purprice(new Double(p.getGdsmst_inprice()));

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
		   		   				
		   		   				orderItem.setOdrdtl_totalincomevalue(Tools.getDouble(Tools.parseDouble(unitPrice),2));//计算商户总收入 不用
		   		   				orderItem.setOdrdtl_eyuan(new Double(0));//商品应发E券 商品表取，价格不能打折送券的商品
		   		   				
		   		   				orderItem.setOdrdtl_spendcount(new Double(0));//返用户积分
		   		   				
		   		   				orderItem.setOdrdtl_managememo("");//产品经理留言
		   		   				orderItem.setOdrdtl_gdspurmemo("");//采购备注 
		   		   				
		   		   				orderItem.setOdrdtl_specialflag(new Long(2));//0是什么都参与，1表示商品不能用券，2表示不参与联盟返利
		   		   				orderItem.setOdrdtl_gifttype("");//赠品类型 
		   		   				
		   		   				orderItem.setOdrdtl_refcount(new Long(1));//是否参加返Ｅ券活动，不参加为0，参与为1（目前没有用）
		   		   				orderItem.setOdrdtl_jcflag(new Long(0));//没有用
		   		   				
		   		   				orderItem.setOdrdtl_temp("凡客");//商品活动标记，记录订单来源
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
		   		   				ci.setUserId("3295935");
		   		   				Tools.getManager(CartItem.class).txCreate(ci);
		   		       	        	
		   		   			
		   		   		}

		                   String orderstatus=itemEle.elementTextTrim("orderstatus"); // 订单状态
		        		   String orderstatusname=itemEle.elementTextTrim("orderstatusname"); // 订单状态名称
		        		   String orderdistributetime=itemEle.elementTextTrim("orderdistributetime"); //订单确认有效时间
		        		   orderstatus=deccode(orderstatus);
		        		   orderstatusname=deccode(orderstatusname);
		        		   orderdistributetime=deccode(orderdistributetime);

		    OdrVancl ovancl=new OdrVancl();
            ovancl.setOdrvancl_odrid(order.getId());
             ovancl.setOdrvancl_orderid(orderID);
            ovancl.setOdrvancl_orderstatus(orderstatus);
            ovancl.setOdrvancl_orderstatusname(orderstatusname);
            ovancl.setOdrvacl_paidprice(new Double(paidprice));
            ovancl.setOdrvancl_orderdistributetime(orderdistributetime);
            ovancl.setOdrvancl_paymenttype(paymenttype);
            ovancl.setOdrvancl_totalprice(new Double(totalprice));
            ovancl.setOdrvancl_transferprice(new Double(transferprice));
             ovancl.setOdrvancl_unpaidprice(new Double(unpaidprice));
             ovancl.setOdrvancl_needinvoice(needinvoice);
            
			Tools.getManager(OdrVancl.class).txCreate(ovancl);

					
			confirmGetMoney(order.getId(),Tools.parseFloat(totalprice));//修改订单为确认收款状态
			return order;
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
				order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ Tools.stockFormatDate(new Date())+"凡客同步订单收款");
				if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
				order1.setOdrmst_validdate(new Date());
				order1.setOdrmst_orderstatus(new Long(2));//确认收款状态
				Tools.getManager(OrderCache.class).txUpdate(order1, true);
				
				//调用存储过程把订单修改成“确认收款”状态
				ProcedureWork work = new ProcedureWork(orderId);
				Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
				
				return true ;*/
						
				int ret=updateOrderStatus2013(order1,getmoney);
				if (ret==1){
				updateOrderStatuswork(order1);
				return true ;
				}else{
					return false ;
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
				order.setOdrmst_ourmemo(order.getOdrmst_ourmemo()+Tools.stockFormatDate(new Date()) +"凡客同步订单收款");
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
		
		
		
		private String deccode(String str){
			String strret="";
			try{
			String key="bjlsysgs";
			String iv="bjlsysgs";
			 strret=DESUtil.decryptDES(str, key, iv);
					//DESUtil.decryptDES(str,key,iv);
			}catch(Exception e){
				e.printStackTrace();
			}
			return strret;
		}
}